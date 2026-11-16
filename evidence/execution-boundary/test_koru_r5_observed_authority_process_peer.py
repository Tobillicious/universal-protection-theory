"""R5 research: bind a confined Unix client to an independently observed process.

This does NOT modify the frozen production-style fixed launcher. The test
assembles its existing FD audit, Landlock and seccomp code, then contrasts
the real authority's SO_PEERCRED PID+UID against a same-UID impostor.
A trusted PID supplied by the test harness is an assumption, not an
operational trust anchor. PID reuse, root control, pre-connection attacks,
effect authenticity and arbitrary connect() reachability remain open.
"""
import os
import select
import subprocess
import sys
import tempfile
from pathlib import Path
import unittest

import test_koru_authority_owned_marker_service as base
from test_koru_r5_same_uid_peer_impersonation import FAKE_SERVER
from test_koru_authority_child_runtime_observation import compare_child_snapshot
from koru_runtime_evidence import digest_regular
from koru_executor_fd_startup_audit import FD_AUDIT_CHILD_CODE
from koru_landlock_write_fence import LANDLOCK_CHILD_CODE
from koru_seccomp_fd_receive_fence import SECCOMP_CHILD_CODE

CHECK_PEER = r"""
import socket, struct, sys
sockpath, expected_uid, expected_pid = sys.argv[1], int(sys.argv[2]), int(sys.argv[3])
_assert_no_ambient_fds()
_install_write_deny_landlock()
_deny_fd_receive_syscalls()
with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as sock:
    sock.settimeout(3)
    sock.connect(sockpath)
    actual_pid, actual_uid, actual_gid = struct.unpack(
        "3i", sock.getsockopt(socket.SOL_SOCKET, socket.SO_PEERCRED, struct.calcsize("3i")))
    if actual_uid != expected_uid or actual_pid != expected_pid:
        print("PEER_PROCESS_REJECTED", flush=True)
    else:
        print("BOUND_TO_OBSERVED_AUTHORITY", flush=True)
"""

@unittest.skipUnless(sys.platform == "linux" and os.geteuid() == 0,
                     "disposable privileged Linux research only")
class ConfinedAuthorityPeerProcessTests(unittest.TestCase):
    def setUp(self):
        self.fixture = base.AuthorityOwnedMarkerTests(
            methodName="test_hold_first_blocks_effect")
        self.fixture.setUp()

    def tearDown(self):
        self.fixture.tearDown()

    def run_client(self, path, trusted_pid):
        def drop_uid():
            os.setgroups([])
            os.setgid(base.EXECUTOR)
            os.setuid(base.EXECUTOR)
        result = subprocess.run(
            [sys.executable, "-B", "-c", FD_AUDIT_CHILD_CODE + "\n" +
             LANDLOCK_CHILD_CODE + "\n" + SECCOMP_CHILD_CODE + "\n" +
             CHECK_PEER, path, str(base.AUTH), str(trusted_pid)],
            preexec_fn=drop_uid, close_fds=True, pass_fds=(),
            stdin=subprocess.DEVNULL, capture_output=True, text=True,
            cwd="/", timeout=8,
            env={"PATH": "/usr/local/bin:/usr/bin:/bin",
                 "PYTHONDONTWRITEBYTECODE": "1"})
        self.assertEqual(result.returncode, 0, result.stderr)
        return result.stdout.strip()

    def test_real_observed_authority_peer_matches_pid_and_uid(self):
        expected_sha = digest_regular("/proc/self/exe")["sha256"]
        compare_child_snapshot(self.fixture.server, base.AUTH, expected_sha)
        self.assertEqual(
            self.run_client(self.fixture.sock, self.fixture.server.pid),
            "BOUND_TO_OBSERVED_AUTHORITY")
        # This identity-only test never requests the marker.
        self.assertFalse(list(self.fixture.marker.iterdir()))

    def test_same_uid_impostor_rejected_under_existing_confinement(self):
        with tempfile.TemporaryDirectory(prefix="g3-r5-process-peer-") as temp:
            root = Path(temp)
            root.chmod(0o755)
            directory = root / "socket"
            directory.mkdir(mode=0o700)
            os.chown(directory, base.AUTH, base.AUTH)
            directory.chmod(0o711)
            fake_path = str(directory / "not-authority.sock")
            fake = subprocess.Popen(
                [sys.executable, "-B", "-c", FAKE_SERVER, fake_path],
                preexec_fn=base.drop(base.AUTH),
                close_fds=True, pass_fds=(), cwd="/",
                stdin=subprocess.DEVNULL, stdout=subprocess.PIPE,
                stderr=subprocess.PIPE, text=True,
                env={"PATH": "/usr/local/bin:/usr/bin:/bin",
                     "PYTHONDONTWRITEBYTECODE": "1"})
            try:
                ready, _, _ = select.select([fake.stdout], [], [], 6)
                self.assertTrue(ready, "fake listener not ready")
                self.assertEqual(fake.stdout.readline().strip(), "READY")
                # We independently observed the genuine server's PID; the
                # fake server has the same UID but cannot match this PID.
                expected_sha = digest_regular("/proc/self/exe")["sha256"]
                compare_child_snapshot(self.fixture.server, base.AUTH, expected_sha)
                self.assertNotEqual(fake.pid, self.fixture.server.pid)
                self.assertEqual(
                    self.run_client(fake_path, self.fixture.server.pid),
                    "PEER_PROCESS_REJECTED")
                self.assertFalse(list(self.fixture.marker.iterdir()))
            finally:
                if fake.poll() is None:
                    fake.kill()
                fake.communicate(timeout=4)

if __name__ == "__main__":
    unittest.main()
