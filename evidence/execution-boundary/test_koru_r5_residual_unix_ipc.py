"""R5 regression: previously reachable AF_UNIX IPC must be denied by the new policy.

Ancestor PR #598 preserves the positive residual-IPC evidence unchanged.
This stacked child #599 tests the narrower one-request executor policy only.
No authority or HOLD state is touched.
"""
import os
import platform
import subprocess
import sys
import unittest

from koru_seccomp_fd_receive_fence import SECCOMP_CHILD_CODE
from koru_landlock_write_fence import LANDLOCK_CHILD_CODE
from koru_executor_fd_startup_audit import FD_AUDIT_CHILD_CODE

PROBE = r"""
import os, socket, sys, errno
_assert_no_ambient_fds()
_install_write_deny_landlock()
_deny_fd_receive_syscalls()
mode = sys.argv[1]
if mode == "socketpair":
    try:
        a, b = socket.socketpair(socket.AF_UNIX, socket.SOCK_STREAM)
    except OSError as err:
        if err.errno != errno.EPERM:
            raise
    else:
        a.close()
        b.close()
        raise AssertionError("socketpair IPC unexpectedly available")
elif mode == "abstract":
    name = bytes((0,)) + b"g3-r5-local-" + str(os.getpid()).encode("ascii")
    with socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM) as s:
        try:
            s.bind(name)
        except OSError as err:
            if err.errno != errno.EPERM:
                raise
        else:
            raise AssertionError("abstract AF_UNIX bind unexpectedly available")
else:
    raise ValueError("unknown mode")
print("ALTERNATE_LOCAL_IPC_DENIED", flush=True)
"""

@unittest.skipUnless(sys.platform == "linux" and
                     platform.machine().lower() in ("x86_64", "aarch64", "arm64"),
                     "Linux seccomp/Landlock/FD-audit research only")
class ResidualUnixIPCNegativeControl(unittest.TestCase):
    def probe(self, mode):
        result = subprocess.run(
            [sys.executable, "-B", "-c",
             FD_AUDIT_CHILD_CODE + "\n" + LANDLOCK_CHILD_CODE + "\n" +
             SECCOMP_CHILD_CODE + "\n" + PROBE, mode],
            cwd="/", env={"PATH": "/usr/local/bin:/usr/bin:/bin",
                           "PYTHONDONTWRITEBYTECODE": "1"},
            text=True, capture_output=True, check=False, timeout=8)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stdout.strip(), "ALTERNATE_LOCAL_IPC_DENIED")

    def test_socketpair_ipc_kernel_denied(self):
        # Socketpair existed in #598; now require its syscall to return EPERM.
        self.probe("socketpair")

    def test_linux_abstract_unix_bind_kernel_denied(self):
        # Abstract bind existed in #598; now require kernel EPERM.
        self.probe("abstract")

if __name__ == "__main__":
    unittest.main()
