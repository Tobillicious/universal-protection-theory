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
    # The parent branch (#594) proves forked descendants inherit the filter.
    # This stricter child (#595) forbids fork altogether; require EPERM.
    import os
    try:
        child = os.fork()
    except OSError as err:
        if err.errno != errno.EPERM:
            raise
        print("FORK_DENIED", flush=True)
    else:
        if child == 0:
            os._exit(3)
        os.waitpid(child, 0)
        raise AssertionError("fork unexpectedly succeeded")
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

    def test_stronger_child_policy_denies_fork(self):
        # Ancestor #594 checked inherited confinement; #595 denies fork itself.
        self.assertEqual(self.probe("fork_inheritance"), "FORK_DENIED")

    def test_netlink_socket_creation_is_kernel_denied(self):
        self.assertEqual(self.probe("netlink"), "SECCOMP_DENIED")


if __name__ == "__main__":
    unittest.main()
