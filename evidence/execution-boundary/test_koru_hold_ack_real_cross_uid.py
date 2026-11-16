"""Cross-process Linux SO_PEERCRED tests using genuinely different Unix UIDs.

Disposable CI-only fixture, requires root. No daemon/service installation,
production key, existing HOLD state, or protected output is touched.

Security limit: synthetic completed floor and signing key; this demonstrates
kernel peer-credential gating on an accepted AF_UNIX socket, not real X3.
"""
import os
import shutil
import socket
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from koru_local_hold_ack_socket import serve_one

CLIENT = """
import socket, sys
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PublicKey
from koru_hold_challenge_client import HoldReceiptChallengeClient
from koru_local_hold_ack_socket import query_one

public_key = Ed25519PublicKey.from_public_bytes(bytes.fromhex(sys.argv[2]))
client = HoldReceiptChallengeClient(public_key, issuer="cross-uid-fixture")
sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
sock.settimeout(3)
try:
    sock.connect(sys.argv[1])
except OSError as exc:
    print("CONNECT_FAILED", type(exc).__name__)
    sys.exit(5)
try:
    accepted = query_one(sock, client, event_id="one", authority_ref="authority",
                         minimum_generation=2, expected_server_uid=0)
    print("ACCEPTED" if accepted else "DENIED")
finally:
    sock.close()
"""


class CompletedFloor:
    def hold_status(self, fence):
        return {"ok": True, "code": "hold_complete", "generation": 2}

    def read(self):
        return {"held": True, "generation": 2, "event_id": "one",
                "authority_ref": "authority"}


class Fence:
    def __enter__(self):
        return self

    def __exit__(self, *_):
        return False


@unittest.skipUnless(sys.platform == "linux" and os.geteuid() == 0,
                     "isolated disposable Linux root runner only")
class DistinctUidHoldAckTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix="g3-peercred-")
        os.chmod(self.tmp.name, 0o755)
        # UID-dropped children may not traverse CI checkout owner directories.
        # Stage only the unprivileged research client modules in the fixture.
        module_dir = Path(__file__).resolve().parent
        for module in ("koru_signed_hold_receipt.py",
                       "koru_hold_challenge_client.py",
                       "koru_local_hold_ack_socket.py"):
            shutil.copyfile(module_dir / module, Path(self.tmp.name) / module)
        self.socket_path = str(Path(self.tmp.name) / "ack.sock")
        self.server = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        self.server.bind(self.socket_path)
        # Deliberately connectable to both fixture users. Access control is
        # tested in the kernel credential check, NOT pathname mode.
        os.chmod(self.socket_path, 0o666)
        self.server.listen(1)
        self.server.settimeout(4)
        self.secret = Ed25519PrivateKey.generate()
        public = self.secret.public_key().public_bytes(
            encoding=serialization.Encoding.Raw,
            format=serialization.PublicFormat.Raw)
        self.public_hex = public.hex()

    def tearDown(self):
        self.server.close()
        self.tmp.cleanup()

    @staticmethod
    def _drop_to(uid):
        def drop():
            os.setgroups([])
            os.setgid(uid)
            os.setuid(uid)
        return drop

    def exchange(self, uid, expected_authorized):
        process = subprocess.Popen(
            [sys.executable, "-B", "-c", CLIENT, self.socket_path, self.public_hex],
            stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True,
            preexec_fn=self._drop_to(uid), close_fds=True,
            env={**os.environ, "PYTHONPATH": self.tmp.name})
        try:
            try:
                connection, _ = self.server.accept()
            except TimeoutError as exc:
                out, err = process.communicate(timeout=3)
                self.fail(f'child never connected: rc={process.returncode}; stdout={out!r}; stderr={err!r}')
            with connection:
                connection.settimeout(3)
                if expected_authorized:
                    serve_one(connection, permitted_uid=65534,
                              private_key=self.secret, floor=CompletedFloor(),
                              fence=Fence(), issuer="cross-uid-fixture")
                else:
                    with self.assertRaises(PermissionError):
                        serve_one(connection, permitted_uid=65534,
                                  private_key=self.secret, floor=CompletedFloor(),
                                  fence=Fence(), issuer="cross-uid-fixture")
            out, err = process.communicate(timeout=5)
            self.assertEqual(process.returncode, 0, (out, err))
            self.assertEqual(out.strip(), "ACCEPTED" if expected_authorized else
                             "DENIED", (out, err))
        finally:
            if process.poll() is None:
                process.kill()
                process.communicate()

    def test_authorized_real_uid_receives_verified_ack(self):
        self.exchange(65534, True)

    def test_connectable_untrusted_real_uid_never_receives_ack(self):
        self.exchange(65533, False)


if __name__ == "__main__":
    unittest.main()
