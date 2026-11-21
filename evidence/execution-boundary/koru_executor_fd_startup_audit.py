"""Fixed-child pre-confinement file descriptor inventory.

Only Linux /proc/self/fd is supported. Scan before Landlock/seccomp and deny
if any live descriptor outside 0, 1, 2 is present. Transient directory fd
opened during os.listdir is already closed and ignored when fstat returns
EBADF. No policy fallback if /proc is unavailable.

An untrusted or compromised Python interpreter before this check, descriptor
injection *after* the audit, or effects before process startup remain out of
scope. This is a narrow defence-in-depth assertion for the fixed child.
"""
FD_AUDIT_CHILD_CODE = r"""
import errno as _audit_errno, os as _audit_os

def _assert_no_ambient_fds():
    names=_audit_os.listdir("/proc/self/fd")
    if not names:
        raise RuntimeError("empty proc fd inventory")
    for name in names:
        if not name.isdecimal():
            raise RuntimeError("invalid proc fd inventory")
        fd=int(name)
        if fd<=2:
            continue
        try:
            _audit_os.fstat(fd)
        except OSError as e:
            if e.errno==_audit_errno.EBADF:
                continue  # transient fd created by os.listdir itself
            raise
        raise PermissionError("unexpected inherited descriptor")
"""
