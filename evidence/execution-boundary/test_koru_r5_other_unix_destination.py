"""R5 hostile control: alternate outbound AF_UNIX peer remains reachable.

Disposable test-only listener in the Linux abstract namespace is not the
G3 authority. A root-launched test drops the client to the fixed EXECUTOR
UID, then runs the exact existing FD audit, Landlock and seccomp payloads.
This shows that permitting connect() without destination mediation leaves
other local peers reachable. No authority, HOLD or marker is involved.
"""
import os
import platform
import socket
import subprocess
import sys
import unittest

from koru_seccomp_fd_receive_fence import SECCOMP_CHILD_CODE
from koru_landlock_write_fence import LANDLOCK_CHILD_CODE
from koru_executor_fd_startup_audit import FD_AUDIT_CHILD_CODE

EXECUTOR_UID = 65532
CLIENT = r"""
import socket, sys
_assert_no_ambient_fds()
_install_write_deny_landlock()
_deny_fd_receive_syscalls()
with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as s:
    s.settimeout(5)
    s.connect(bytes.fromhex(sys.argv[1]))
    s.sendall(b"isolated-peer")
    if s.recv(64) != b"observed":
        raise AssertionError("unexpected alternate endpoint response")
print("ALTERNATE_PEER_REACHED", flush=True)
"""

@unittest.skipUnless(sys.platform == "linux" and os.geteuid() == 0
                     and platform.machine().lower() in ("x86_64", "aarch64", "arm64"),
                     "Disposable root-launched Linux UID-separated research only")
class OtherUnixDestinationNegativeControl(unittest.TestCase):
    def test_existing_policy_allows_other_abstract_unix_peer(self):
        address = (bytes((0,)) + b"g3-r5-other-peer-" +
                   str(os.getpid()).encode("ascii"))
        with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as listener:
            listener.bind(address)
            listener.listen(1)
            listener.settimeout(8)

            def drop():
                os.setgroups([])
                os.setgid(EXECUTOR_UID)
                os.setuid(EXECUTOR_UID)

            process = subprocess.Popen(
                [sys.executable, "-B", "-c",
                 FD_AUDIT_CHILD_CODE + "\n" + LANDLOCK_CHILD_CODE + "\n" +
                 SECCOMP_CHILD_CODE + "\n" + CLIENT, address.hex()],
                preexec_fn=drop, close_fds=True, pass_fds=(),
                cwd="/", stdin=subprocess.DEVNULL,
                stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True,
                env={"PATH": "/usr/local/bin:/usr/bin:/bin",
                     "PYTHONDONTWRITEBYTECODE": "1"})
            try:
                with listener.accept()[0] as peer:
                    self.assertEqual(peer.recv(64), b"isolated-peer")
                    peer.sendall(b"observed")
                stdout, stderr = process.communicate(timeout=8)
                self.assertEqual(process.returncode, 0, stderr)
                self.assertEqual(stdout.strip(), "ALTERNATE_PEER_REACHED")
            finally:
                if process.poll() is None:
                    process.kill()
                    process.communicate(timeout=3)

if __name__ == "__main__":
    unittest.main()
