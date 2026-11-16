"""G3 R5 narrow socket-family kernel fence, disposable Linux only.

The existing seccomp policy now permits socket(AF_UNIX) but denies all
non-AF_UNIX domains; no external connections, network traffic or deployment.
Actual protected authority/HOLD tests remain in existing G3 suite.
"""
import errno
import os
import platform
import subprocess
import sys
import unittest

from koru_seccomp_fd_receive_fence import SECCOMP_CHILD_CODE

PROBE = r"""
import errno, socket, sys
_deny_fd_receive_syscalls()
family = sys.argv[1]
if family == "unix":
    with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM):
        print("AF_UNIX_ALLOWED", flush=True)
elif family == "fork_inheritance":
    import os
    child = os.fork()
    if child == 0:
        try:
            with socket.socket(socket.AF_INET, socket.SOCK_STREAM):
                os._exit(2)
        except OSError as err:
            os._exit(0 if err.errno == errno.EPERM else 3)
    waited, status = os.waitpid(child, 0)
    if waited != child or not os.WIFEXITED(status) or os.WEXITSTATUS(status) != 0:
        raise AssertionError("forked child escaped restricted socket policy")
    print("FORK_INHERITED_DENIAL", flush=True)
elif family in ("ipv4", "ipv6", "netlink"):
    mapping = {"ipv4": socket.AF_INET, "ipv6": socket.AF_INET6,
               "netlink": getattr(socket, "AF_NETLINK", 16)}
    try:
        with socket.socket(mapping[family], socket.SOCK_STREAM):
            print("UNEXPECTED_ALLOWED", flush=True)
    except OSError as err:
        if err.errno == errno.EPERM:
            print("SECCOMP_DENIED", flush=True)
        else:
            raise
else:
    raise ValueError("unsupported family")
"""


@unittest.skipUnless(sys.platform == "linux" and
                     platform.machine().lower() in ("x86_64", "aarch64", "arm64"),
                     "Linux x86_64/ARM64 seccomp only")
class SocketFamilyFenceTests(unittest.TestCase):
    def probe(self, family):
        result = subprocess.run(
            [sys.executable, "-B", "-c", SECCOMP_CHILD_CODE + "\n" + PROBE, family],
            capture_output=True, text=True, timeout=6, check=False,
            cwd="/", env={"PATH": "/usr/bin:/bin", "PYTHONDONTWRITEBYTECODE": "1"})
        self.assertEqual(result.returncode, 0, result.stderr)
        return result.stdout.strip()

    def test_required_unix_socket_remains_available(self):
        self.assertEqual(self.probe("unix"), "AF_UNIX_ALLOWED")

    def test_ipv4_socket_creation_is_kernel_denied(self):
        self.assertEqual(self.probe("ipv4"), "SECCOMP_DENIED")

    def test_ipv6_socket_creation_is_kernel_denied(self):
        self.assertEqual(self.probe("ipv6"), "SECCOMP_DENIED")

    def test_forked_child_inherits_socket_denial(self):
        # A descendant may be created, but it must not lose the filter.
        self.assertEqual(self.probe("fork_inheritance"), "FORK_INHERITED_DENIAL")

    def test_netlink_socket_creation_is_kernel_denied(self):
        self.assertEqual(self.probe("netlink"), "SECCOMP_DENIED")


if __name__ == "__main__":
    unittest.main()
