"""A narrow Linux syscall fence installed inside a disposable executor.

The fixed child source is inlined into Python -c BEFORE opening the authority
socket, so a dropped-UID subprocess never imports from a protected checkout.

The filter denies non-AF_UNIX socket creation, process/exec creation, local IPC endpoint/listener syscalls, descriptor reception, ancillary-message send and named filesystem operations,
including open/openat/openat2, path mutation, and io_uring entry. The fixed
child can still use normal recv() and send() on the authority socket.
This is a deliberately narrow denylist, NOT complete syscall confinement:
existing writable FDs, memory mappings, other kernel APIs, privileged
injection, and alternative effects remain outside this research boundary. Fixed architecture constants are Linux-specific.
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

def _deny_fd_receive_syscalls(*, deny_new_connections=False):
    # Linux audit arch and syscall numbers; NEVER use mismatched ABI values.
    arch=_platform.machine().lower()
    tables={
        # Includes selected direct pathname mutations and io_uring syscalls.
        # Hard-coded Linux syscall IDs are limited to these two known ABIs.
        "x86_64":(0xc000003e,(
            46,47,299,307,438,    # sendmsg,recvmsg,recvmmsg,sendmmsg,pidfd_getfd
            2,85,257,437,304,     # open,creat,openat,openat2,open_by_handle_at
            76,77,                # truncate,ftruncate
            82,264,316,87,263,   # rename*,unlink*
            83,258,86,265,88,266,133,259,  # mkdir*,link*,symlink*,mknod*
            90,91,268,452,92,93,94,260,  # chmod/chown*
            425,426,427)),        # io_uring setup/enter/register
        "aarch64":(0xc00000b7,(
            211,212,243,269,438,  # sendmsg,recvmsg,recvmmsg,sendmmsg,pidfd_getfd
            56,437,265,           # openat,openat2,open_by_handle_at
            45,46,                # truncate,ftruncate
            38,276,35,            # renameat,renameat2,unlinkat
            34,37,36,33,          # mkdirat,linkat,symlinkat,mknodat
            52,53,452,54,55,      # fchmod*,fchown*
            425,426,427)),        # io_uring setup/enter/register
        "arm64":(0xc00000b7,(
            211,212,243,269,438,56,437,265,45,46,38,276,35,34,37,36,33,
            52,53,452,54,55,425,426,427)),
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
    if arch=="x86_64":
        # x32 ABI uses the same audit arch with bit 30 set. Refuse its
        # alternate syscall numbering instead of accidentally allowing it.
        instructions += [
            (0x54,0,0,0x40000000),          # A &= __X32_SYSCALL_BIT
            (0x15,1,0,0),                   # if zero skip deny
            (0x06,0,0,0x00050000 | _errno.EPERM),
            (0x20,0,0,0),                   # restore syscall number
        ]
    # The fixed one-request child does not need to launch descendants after
    # confinement. Deny process creation and executable replacement in this
    # already-running child. Blocking clone also denies NEW THREADS; this
    # limitation is intentional for this single-request research workload.
    # The parent launcher and authority service are unaffected.
    process_syscalls=(
        (56,57,58,59,322,435) if arch=="x86_64"
        else (220,221,281,435)
    )  # clone,fork,vfork,execve,execveat,clone3 (when present)
    blocked=tuple(blocked)+process_syscalls
    # The one-request child needs only outbound AF_UNIX authority access.
    # No socketpair, bound local endpoint, listener, or accept is required.
    # This does NOT constrain destinations of still-allowed connect().
    local_server_syscalls=(
        (53,49,50,43,288) if arch=="x86_64"
        else (199,200,201,202,242)
    )  # socketpair, bind, listen, accept, accept4
    blocked=tuple(blocked)+local_server_syscalls
    # Fixed-client mode: the one authenticated authority connection was
    # established under executor UID BEFORE applying this filter. All new
    # sockets and connect attempts must now fail at the kernel boundary.
    # Legacy no-argument mode remains for historical hostile controls only.
    if type(deny_new_connections) is not bool:
        raise ValueError("explicit boolean connection policy required")
    if deny_new_connections:
        blocked=tuple(blocked)+(
            (41,42) if arch=="x86_64" else (198,203)
        )  # socket, connect
    # Legacy mode permits only AF_UNIX socket creation; the fixed executor
    # instead calls with deny_new_connections=True after trusted connection.
    # Preserve legacy behavior for explicit historical negative controls.
    # seccomp_data.args[0] is 64-bit at offset 16; AF_UNIX is exactly 1.
    socket_nr=41 if arch=="x86_64" else 198
    if not deny_new_connections:
        instructions += [
        (0x15,0,4,socket_nr),               # if nr != socket skip 4
        (0x20,0,0,16),                      # A = low32(args[0])
        (0x15,1,0,1),                       # AF_UNIX: skip deny
        (0x06,0,0,0x00050000 | _errno.EPERM),
        (0x20,0,0,0),                       # restore A = syscall number
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
