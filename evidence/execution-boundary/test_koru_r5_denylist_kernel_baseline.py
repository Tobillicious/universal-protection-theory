"""R5 baseline: observe effects not prohibited by the EXISTING narrow seccomp.

These are negative-control observations, NOT security passes or new mediation.
Use only disposable child processes; socket creation never connects or sends.
Keep the actual fixed-launcher and every protection mechanism unchanged.
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
_deny_fd_receive_syscalls()
operation = sys.argv[1]
if operation == "ipv4_stream":
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM):
        pass
elif operation == "ipv4_datagram":
    with socket.socket(socket.AF_INET, socket.SOCK_DGRAM):
        pass
elif operation == "unix_stream":
    with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM):
        pass
elif operation == "fork":
    pid = os.fork()
    if pid == 0:
        os._exit(0)
    child, status = os.waitpid(pid, 0)
    if child != pid or not os.WIFEXITED(status) or os.WEXITSTATUS(status):
        raise AssertionError("child not reaped successfully")
elif operation == "stdout":
    os.write(1, b"FD_WRITE_PERMITTED\\n")
else:
    raise ValueError("unknown operation")
print("PERMITTED", flush=True)
"""


@unittest.skipUnless(sys.platform == "linux" and
                     platform.machine().lower() in ("x86_64", "aarch64", "arm64"),
                     "existing seccomp fixture supports only Linux x86_64/ARM64")
class R5DenylistKernelBaselineTests(unittest.TestCase):
    def probe(self, operation):
        result = subprocess.run(
            [sys.executable, "-B", "-c", SECCOMP_CHILD_CODE + "\n" + PROBE, operation],
            cwd="/", env={"PATH": "/usr/bin:/bin", "PYTHONDONTWRITEBYTECODE": "1"},
            capture_output=True, text=True, timeout=6, check=False)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertTrue(result.stdout.endswith("PERMITTED\n"), result.stdout)
        return result

    def probe_all_installed_layers(self, operation):
        # Replay the actual fixed-child installation order: FD audit,
        # Landlock write confinement, then seccomp, before the operation.
        # This isolates the combined kernel permissions rather than merely
        # the narrow syscall filter. No protected authority is contacted.
        combined = PROBE.replace(
            "_deny_fd_receive_syscalls()",
            "_assert_no_ambient_fds()\\n_install_write_deny_landlock()\\n_deny_fd_receive_syscalls()",
            1,
        )
        result = subprocess.run(
            [sys.executable, "-B", "-c",
             FD_AUDIT_CHILD_CODE + "\\n" + LANDLOCK_CHILD_CODE + "\\n" +
             SECCOMP_CHILD_CODE + "\\n" + combined, operation],
            cwd="/", env={"PATH": "/usr/bin:/bin", "PYTHONDONTWRITEBYTECODE": "1"},
            capture_output=True, text=True, timeout=6, check=False)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertTrue(result.stdout.endswith("PERMITTED\\n"), result.stdout)
        return result

    def test_complete_installed_chain_still_allows_ipv4_socket_creation(self):
        self.probe_all_installed_layers("ipv4_stream")
        self.probe_all_installed_layers("ipv4_datagram")

    def test_complete_installed_chain_still_allows_unix_socket_creation(self):
        self.probe_all_installed_layers("unix_stream")

    def test_complete_installed_chain_still_allows_fork(self):
        self.probe_all_installed_layers("fork")

    def test_complete_installed_chain_still_allows_stdout_write(self):
        self.assertIn("FD_WRITE_PERMITTED",
                      self.probe_all_installed_layers("stdout").stdout)

    def test_ipv4_stream_socket_creation_still_allowed(self):
        # No bind/connect/send: demonstrate only permitted capability creation.
        self.probe("ipv4_stream")

    def test_ipv4_datagram_socket_creation_still_allowed(self):
        self.probe("ipv4_datagram")

    def test_unix_socket_creation_still_allowed(self):
        self.probe("unix_stream")

    def test_fork_still_allowed(self):
        self.probe("fork")

    def test_write_to_inherited_stdout_still_allowed(self):
        self.assertIn("FD_WRITE_PERMITTED", self.probe("stdout").stdout)


if __name__ == "__main__":
    unittest.main()
