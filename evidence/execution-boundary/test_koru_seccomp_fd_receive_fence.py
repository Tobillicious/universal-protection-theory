"""Cross-architecture seccomp enforcement in actual dropped-UID children.

These tests check kernel denial, not a Python-only guard: untrusted Python
attempts recvmsg after launch on a legitimate Unix socket. Also verifies
the fixed authority executor still uses ordinary recv to request its one
synthetic action; no authority code or data store changed.
"""
import array
import errno
import os
from pathlib import Path
import socket
import subprocess
import sys
import tempfile
import unittest

import test_koru_authority_owned_marker_service as base
from koru_no_inherited_fd_executor import launch_fixed_executor_client
from koru_seccomp_fd_receive_fence import SECCOMP_CHILD_CODE

PROBE = r"""
import errno,os,socket,sys
fd=int(sys.argv[1])
mode=sys.argv[2]
with socket.socket(fileno=fd) as channel:
    _deny_fd_receive_syscalls()
    print("READY",flush=True)
    # Wait until the parent has queued the ancillary message after filter install.
    if sys.stdin.readline().strip() != "go":
        raise ValueError("missing test synchronization")
    if mode=="rights":
        try:
            channel.recvmsg(32,socket.CMSG_SPACE(16))
        except OSError as e:
            if e.errno==errno.EPERM:
                print("SECCOMP_DENIED",flush=True)
            else:
                raise
        else:
            print("UNEXPECTED_ALLOWED",flush=True)
    elif mode in ("sendmsg", "sendmmsg"):
        try:
            if mode=="sendmsg":
                channel.sendmsg([b"x"],[])
            else:
                import ctypes
                libc=ctypes.CDLL(None,use_errno=True)
                syscall_nr={"x86_64":307,"aarch64":269,"arm64":269}.get(
                    os.uname().machine.lower())
                if syscall_nr is None:
                    raise ValueError("unsupported syscall architecture")
                result=libc.syscall(ctypes.c_long(syscall_nr),ctypes.c_int(fd),
                                    ctypes.c_void_p(),ctypes.c_uint(0),
                                    ctypes.c_uint(0))
                if result==-1:
                    raise OSError(ctypes.get_errno(),os.strerror(ctypes.get_errno()))
        except OSError as e:
            if e.errno==errno.EPERM:
                print("SECCOMP_DENIED",flush=True)
            else:
                raise
        else:
            print("UNEXPECTED_ALLOWED",flush=True)
    elif mode=="plain":
        print(channel.recv(32).decode("ascii"),flush=True)
    else:
        raise ValueError("unexpected mode")
"""


class SeccompProcessTests(unittest.TestCase):
    def _child(self, mode, *, transfer_rights):
        with tempfile.TemporaryDirectory(prefix="g3-seccomp-recv-") as d:
            marker=Path(d)/"marker"
            marker.write_bytes(b"")
            fd=os.open(str(marker),os.O_WRONLY)
            a,b=socket.socketpair(socket.AF_UNIX,socket.SOCK_DGRAM)
            try:
                proc=subprocess.Popen(
                    [sys.executable,"-B","-c",SECCOMP_CHILD_CODE+"\n"+PROBE,
                     str(b.fileno()),mode],
                    pass_fds=(b.fileno(),),close_fds=True,
                    stdin=subprocess.PIPE,stdout=subprocess.PIPE,
                    stderr=subprocess.PIPE,text=True,bufsize=1)
                b.close()
                ready=proc.stdout.readline().strip()
                self.assertEqual(ready,"READY")
                if transfer_rights:
                    handles=array.array("i",[fd])
                    a.sendmsg([b"x"],[(socket.SOL_SOCKET,socket.SCM_RIGHTS,
                                      handles.tobytes())])
                else:
                    a.send(b"PLAIN")
                remainder,err=proc.communicate(input="go\n",timeout=5)
                self.assertEqual(proc.returncode,0,err)
                self.assertEqual(marker.read_bytes(),b"")
                return remainder.strip()
            finally:
                a.close()
                b.close()
                os.close(fd)

    @unittest.skipUnless(sys.platform=="linux","Linux seccomp only")
    def test_kernel_denies_scm_rights_recvmsg_after_launch(self):
        self.assertEqual(self._child("rights",transfer_rights=True),
                         "SECCOMP_DENIED")

    @unittest.skipUnless(sys.platform=="linux","Linux seccomp only")
    def test_kernel_denies_sendmsg_after_launch(self):
        self.assertEqual(self._child("sendmsg",transfer_rights=False),
                         "SECCOMP_DENIED")

    @unittest.skipUnless(sys.platform=="linux" and
                         os.uname().machine.lower() in ("x86_64","aarch64","arm64"),
                         "supported Linux seccomp architecture only")
    def test_kernel_denies_sendmmsg_after_launch(self):
        self.assertEqual(self._child("sendmmsg",transfer_rights=False),
                         "SECCOMP_DENIED")

    @unittest.skipUnless(sys.platform=="linux","Linux seccomp only")
    def test_plain_recv_still_works_under_filter(self):
        self.assertEqual(self._child("plain",transfer_rights=False),"PLAIN")


@unittest.skipUnless(sys.platform=="linux" and os.geteuid()==0,
                     "disposable privileged Linux UID fixture only")
class SeccompAuthorityExecutorTests(unittest.TestCase):
    def setUp(self):
        self.fixture=base.AuthorityOwnedMarkerTests(
            methodName="test_hold_first_blocks_effect")
        self.fixture.setUp()

    def tearDown(self):
        self.fixture.tearDown()

    def _launch(self,authority_uid=base.AUTH):
        return launch_fixed_executor_client(
            self.fixture.sock,executor_uid=base.EXECUTOR,
            authority_uid=authority_uid,
            authority_pid=self.fixture.server.pid)

    def test_filtered_executor_can_request_one_authority_owned_effect(self):
        self.assertEqual(self._launch()["code"],"synthetic_effect_returned")
        self.assertTrue((self.fixture.marker/"fixed.marker").exists())
        self.assertEqual(self._launch()["code"],"authority_denied")

    def test_filtered_executor_denied_after_committed_hold(self):
        self.assertEqual(self.fixture.ask(base.CONTROLLER,"hold")["code"],
                         "hold_recorded")
        self.assertEqual(self._launch()["code"],"authority_denied")
        self.assertFalse((self.fixture.marker/"fixed.marker").exists())

    def test_filtered_executor_rejects_untrusted_authority_uid(self):
        result=self._launch(authority_uid=base.CONTROLLER)
        self.assertFalse(result["ok"])
        self.assertFalse((self.fixture.marker/"fixed.marker").exists())


if __name__=="__main__":
    unittest.main()
