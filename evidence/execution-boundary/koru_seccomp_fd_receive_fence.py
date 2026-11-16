"""A narrow Linux syscall fence installed inside a disposable executor.

The fixed child source is inlined into Python -c BEFORE opening the authority
socket, so a dropped-UID subprocess never imports from a protected checkout.

The filter denies recvmsg/recvmmsg/pidfd_getfd for this child AND descendants,
without interfering with ordinary recv() on the fixed authority socket.
This is not complete process confinement: root/ptrace, alternate effects,
io_uring, inherited descriptors, shell execution and other resources require
separate mediation. Fixed architecture constants are Linux-specific.
No deployment or production launcher claim.
"""

SECCOMP_CHILD_CODE = r"""
import ctypes as _sc, errno as _errno, platform as _platform
from ctypes import Structure as _Structure
from ctypes import c_ushort as _u16, c_ubyte as _u8, c_uint as _u32

class _Filter(_Structure):
    _fields_=[("code",_u16),("jt",_u8),("jf",_u8),("k",_u32)]

class _Program(_Structure):
    _fields_=[("len",_u16),("filter",ctypes.POINTER(_Filter))]

def _deny_fd_receive_syscalls():
    # Linux audit arch and syscall numbers; NEVER use mismatched ABI values.
    arch=_platform.machine().lower()
    tables={
        "x86_64":(0xc000003e,(47,299,438)),
        "aarch64":(0xc00000b7,(212,243,438)),
        "arm64":(0xc00000b7,(212,243,438)),
    }
    if arch not in tables:
        raise OSError("unsupported seccomp architecture")
    audit_arch, blocked=tables[arch]
    # classic BPF: verify arch, then deny each specific syscall with EPERM.
    instructions=[
        (0x20,0,0,4),                       # load seccomp_data.arch
        (0x15,1,0,audit_arch),              # jump past kill when correct
        (0x06,0,0,0x80000000),              # SECCOMP_RET_KILL_PROCESS
        (0x20,0,0,0),                       # load seccomp_data.nr
    ]
    for nr in blocked:
        instructions += [(0x15,0,1,nr),
                         (0x06,0,0,0x00050000 | _errno.EPERM)]
    instructions += [(0x06,0,0,0x7fff0000)] # SECCOMP_RET_ALLOW
    arr=(_Filter*len(instructions))(*[_Filter(*v) for v in instructions])
    prog=_Program(len(instructions),arr)
    libc=ctypes.CDLL(None,use_errno=True)
    PR_SET_NO_NEW_PRIVS=38
    PR_SET_SECCOMP=22
    SECCOMP_MODE_FILTER=2
    if libc.prctl(PR_SET_NO_NEW_PRIVS,1,0,0,0)!=0:
        raise OSError(ctypes.get_errno(),"no_new_privs failed")
    if libc.prctl(PR_SET_SECCOMP,SECCOMP_MODE_FILTER,
                  ctypes.byref(prog))!=0:
        raise OSError(ctypes.get_errno(),"seccomp filter failed")
""".replace("ctypes.POINTER", "_sc.POINTER").replace("ctypes.CDLL","_sc.CDLL").replace("ctypes.byref","_sc.byref").replace("ctypes.get_errno","_sc.get_errno")
