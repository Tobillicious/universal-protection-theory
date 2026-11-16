"""R5 negative controls: Linux AF_UNIX IPC outside the intended authority socket.

These are safe, disposable *positive observations of residual IPC reachability*,
not requirements that alternate channels be permitted. A success means that
the tested restrictions are NOT a complete local IPC mediation boundary.
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
import os, socket, sys
_assert_no_ambient_fds()
_install_write_deny_landlock()
_deny_fd_receive_syscalls()
mode = sys.argv[1]
if mode == "socketpair":
    a, b = socket.socketpair(socket.AF_UNIX, socket.SOCK_STREAM)
    with a, b:
        a.sendall(b"r5-local")
        if b.recv(64) != b"r5-local":
            raise AssertionError("socketpair IPC content mismatch")
elif mode == "abstract":
    name = bytes((0,)) + b"g3-r5-local-" + str(os.getpid()).encode("ascii")
    with socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM) as s:
        s.bind(name)
        s.sendto(b"r5-local", name)
        if s.recv(64) != b"r5-local":
            raise AssertionError("abstract AF_UNIX datagram content mismatch")
else:
    raise ValueError("unknown mode")
print("ALTERNATE_LOCAL_IPC_REACHABLE", flush=True)
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
        self.assertEqual(result.stdout.strip(), "ALTERNATE_LOCAL_IPC_REACHABLE")

    def test_socketpair_ipc_not_mediated_by_socket_domain_rule(self):
        # Independently synthesized same-process IPC channel after confinement.
        self.probe("socketpair")

    def test_linux_abstract_unix_ipc_not_mediated_by_path_landlock(self):
        # Independent abstract address; no filesystem path or external peer.
        self.probe("abstract")

if __name__ == "__main__":
    unittest.main()
