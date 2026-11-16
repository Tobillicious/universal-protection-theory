"""Disposable Linux x86-64/AArch64 kernel-enforced SCM_RIGHTS negative control.

Contrast to historical #475 (unrestricted child successfully writes through an
SCM_RIGHTS-transferred writable FD after HOLD): this test confines a separate
unprivileged child BEFORE exec. It must be impossible for that child to receive
the transmitted writable FD through recvmsg/recvmmsg or pidfd_getfd.

Research-only demonstration. The privileged delegator remains trusted and
could itself mutate the file; this is not host-wide complete mediation.
"""
import array
import ctypes
import errno
import json
import os
from pathlib import Path
import platform
import socket
import subprocess
import sys
import tempfile
import unittest

from g3_monitor import Store

# Native Linux seccomp_data, sock_filter, sock_fprog ABIs. Only x86-64 and
# AArch64. x32 is forbidden on x86-64. No generic sandbox implied.
AUDIT_ARCH_X86_64 = 0xC000003E
AUDIT_ARCH_AARCH64 = 0xC00000B7
X32_SYSCALL_BIT = 0x40000000
BPF_LD_W_ABS = 0x20
BPF_JMP_JEQ_K = 0x15
BPF_JMP_JGE_K = 0x35
BPF_RET_K = 0x06
SECCOMP_RET_KILL_PROCESS = 0x80000000
SECCOMP_RET_ERRNO = 0x00050000
SECCOMP_RET_ALLOW = 0x7FFF0000
PR_SET_NO_NEW_PRIVS = 38
PR_SET_SECCOMP = 22
SECCOMP_MODE_FILTER = 2

# Architecture-specific native Linux syscall numbers. These are narrow
# demonstration deny-lists, NOT exhaustive production allow-lists.
RESTRICTED_SYSCALLS = {
    'x86_64': (47, 299, 438, 32, 33, 292, 425, 426, 427),
    'aarch64': (212, 243, 438, 23, 24, 425, 426, 427),
}
AUDIT_ARCH = {'x86_64': AUDIT_ARCH_X86_64, 'aarch64': AUDIT_ARCH_AARCH64}


class SockFilter(ctypes.Structure):
    _fields_ = [
        ("code", ctypes.c_ushort),
        ("jt", ctypes.c_ubyte),
        ("jf", ctypes.c_ubyte),
        ("k", ctypes.c_uint32),
    ]


class SockFprog(ctypes.Structure):
    _fields_ = [
        ("len", ctypes.c_ushort),
        ("filter", ctypes.POINTER(SockFilter)),
    ]


def install_restricted_receiver_filter():
    """Install real kernel filter inside trusted pre-exec child setup."""
    arch = platform.machine()
    if sys.platform != "linux" or arch not in AUDIT_ARCH:
        raise RuntimeError("research filter supports Linux x86-64/AArch64 only")
    instructions = [
        SockFilter(BPF_LD_W_ABS, 0, 0, 4),
        SockFilter(BPF_JMP_JEQ_K, 1, 0, AUDIT_ARCH[arch]),
        SockFilter(BPF_RET_K, 0, 0, SECCOMP_RET_KILL_PROCESS),
        SockFilter(BPF_LD_W_ABS, 0, 0, 0),
    ]
    if arch == 'x86_64':
        instructions.extend([
            SockFilter(BPF_JMP_JGE_K, 0, 1, X32_SYSCALL_BIT),
            SockFilter(BPF_RET_K, 0, 0, SECCOMP_RET_KILL_PROCESS),
        ])
    for number in RESTRICTED_SYSCALLS[arch]:
        instructions.extend([
            SockFilter(BPF_JMP_JEQ_K, 0, 1, number),
            SockFilter(BPF_RET_K, 0, 0, SECCOMP_RET_ERRNO | errno.EPERM),
        ])
    instructions.append(SockFilter(BPF_RET_K, 0, 0, SECCOMP_RET_ALLOW))
    array_type = SockFilter * len(instructions)
    filt = array_type(*instructions)
    prog = SockFprog(len(instructions), filt)
    libc = ctypes.CDLL(None, use_errno=True)
    libc.prctl.argtypes = [ctypes.c_int, ctypes.c_ulong, ctypes.c_ulong,
                           ctypes.c_ulong, ctypes.c_ulong]
    libc.prctl.restype = ctypes.c_int
    if libc.prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) != 0:
        e = ctypes.get_errno()
        raise OSError(e, os.strerror(e))
    if libc.prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER,
                  ctypes.addressof(prog), 0, 0) != 0:
        e = ctypes.get_errno()
        raise OSError(e, os.strerror(e))


def drop_and_confine():
    """Popen trusted preexec: restrict child before executing untrusted code."""
    os.setgroups([])
    os.setgid(65534)
    os.setuid(65534)
    install_restricted_receiver_filter()


CHILD = r"""
import array,errno,json,os,socket,sys
path,sockfd=sys.argv[1:]
s=socket.socket(fileno=int(sockfd))
status=open('/proc/self/status',encoding='utf8').read().splitlines()
seccomp=[x.split(':',1)[1].strip() for x in status if x.startswith('Seccomp:')]
assert seccomp==['2'],seccomp
# Confirm no protected-write FD was inherited across exec. The temporary
# descriptor used by /proc enumeration may close before fstat; ignore it.
existing=[]
for item in os.listdir('/proc/self/fd'):
    try: os.fstat(int(item))
    except OSError: continue
    existing.append(int(item))
extra=set(existing)-{0,1,2,int(sockfd)}
assert not extra, extra
try:
    with open(path,'ab') as f: f.write(b'UNAUTHORIZED-PATH')
    path_status='ALLOWED'
except PermissionError:
    path_status='DENIED'
assert path_status=='DENIED',path_status
s.send(b'R')
assert os.read(0,1)==b'G', 'missing trusted test release'
try:
    _,anc,_,_=s.recvmsg(1,socket.CMSG_SPACE(array.array('i').itemsize))
except OSError as exc:
    assert exc.errno==errno.EPERM,exc
    receiver='EPERM'
else:
    receiver='ALLOWED'
assert receiver=='EPERM','seccomp failed to block SCM_RIGHTS receiver'
print(json.dumps({'uid':os.geteuid(),'path':path_status,
                  'recvmsg':receiver,'seccomp':int(seccomp[0]),
                  'unexpected_fds':sorted(extra)}))
s.close()
"""


@unittest.skipUnless(
    sys.platform == 'linux' and platform.machine() in AUDIT_ARCH
    and os.geteuid() == 0,
    'disposable root-enabled Linux x86-64/AArch64 only')
class ConfinedDescriptorTransferCut(unittest.TestCase):
    def test_seccomp_before_exec_denies_scm_rights_after_hold(self):
        with tempfile.TemporaryDirectory(prefix='g3-seccomp-fd-') as tmp:
            root = Path(tmp)
            root.chmod(0o711)
            output = root/'output'
            output.mkdir(mode=0o700)
            store = Store(str(root/'writer.sqlite'),output)
            try:
                epoch=store.arm()['epoch']
                first=store.write({'op':'write','id':'one',
                    'html':'authorized','epoch':epoch})
                self.assertTrue(first['ok'],first)
                target=next(output.glob('*.html'))
                # Intentional hostile capability present in privileged parent,
                # matching #475; child must NOT be able to receive/use it.
                writable=os.open(target,os.O_WRONLY|os.O_APPEND|os.O_NOFOLLOW)
                try:
                    self.assertTrue(store.hold()['ok'])
                    self.assertEqual(store.write({'op':'write','id':'two',
                        'html':'refused','epoch':epoch})['code'],'stale_or_halted')
                    before=target.read_bytes()
                    a,b=socket.socketpair(socket.AF_UNIX,socket.SOCK_DGRAM)
                    try:
                        proc=subprocess.Popen(
                            [sys.executable,'-B','-c',CHILD,str(target),str(b.fileno())],
                            stdin=subprocess.PIPE,stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE,text=True,
                            pass_fds=(b.fileno(),),close_fds=True,
                            preexec_fn=drop_and_confine)
                        b.close()
                        a.settimeout(8)
                        self.assertEqual(a.recv(1),b'R')
                        self.assertEqual(a.sendmsg([b'X'],
                            [(socket.SOL_SOCKET,socket.SCM_RIGHTS,
                              array.array('i',[writable]).tobytes())]),1)
                        stdout,stderr=proc.communicate(input='G',timeout=10)
                        self.assertEqual(proc.returncode,0,stderr)
                        data=json.loads(stdout)
                        self.assertEqual(data['uid'],65534)
                        self.assertEqual(data['seccomp'],2)
                        self.assertEqual(data['path'],'DENIED')
                        self.assertEqual(data['recvmsg'],'EPERM')
                        self.assertEqual(data['unexpected_fds'],[])
                        self.assertEqual(target.read_bytes(),before)
                        self.assertTrue(store.inventory()['ok'])
                    finally:
                        a.close()
                        b.close()
                finally:
                    os.close(writable)
            finally:
                store.close()

if __name__=='__main__':
    unittest.main()
