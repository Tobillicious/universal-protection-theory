"""Disposable separate-process guardian restart and key replacement controls.

No installed daemon, real key, live HOLD or protected effect. The child is a
fresh Python interpreter on each query; it uses the strict provisioned signer.
"""
import os
import socket
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey

from koru_hold_challenge_client import HoldReceiptChallengeClient
from koru_local_hold_ack_socket import query_one

CHILD = """
import os, socket, sys
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PublicKey
from koru_provisioned_receipt_issuer import serve_one_provisioned

class Floor:
    def hold_status(self, fence):
        return {"ok": True, "code": "hold_complete", "generation": 2}
    def read(self):
        return {"held": True, "generation": 2, "event_id": "restart",
                "authority_ref": "pinned"}

class Fence:
    def __enter__(self):
        return self
    def __exit__(self, *_):
        return False

sock = socket.socket(fileno=int(sys.argv[1]))
sock.settimeout(1)
public = Ed25519PublicKey.from_public_bytes(bytes.fromhex(sys.argv[3]))
try:
    serve_one_provisioned(
        sock, permitted_uid=0, key_path=sys.argv[2],
        trusted_public_key=public, floor=Floor(), fence=Fence(),
        issuer="restart-fixture")
except Exception as exc:
    print(type(exc).__name__, file=sys.stderr)
    sys.exit(3)
finally:
    sock.close()
"""


@unittest.skipUnless(sys.platform == "linux" and os.geteuid() == 0,
                     "isolated disposable root Linux tests only")
class RestartedGuardianTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix="g3-restart-key-")
        self.path = Path(self.tmp.name) / "receipt.key"
        Path(self.tmp.name).chmod(0o700)
        self.original = Ed25519PrivateKey.generate()
        self.write_key(self.original)
        self.public = self.original.public_key()
        self.public_hex = self.public.public_bytes(
            serialization.Encoding.Raw,
            serialization.PublicFormat.Raw).hex()
        self.client = HoldReceiptChallengeClient(self.public, issuer="restart-fixture")

    def tearDown(self):
        self.tmp.cleanup()

    def write_key(self, key):
        raw = key.private_bytes(
            serialization.Encoding.Raw, serialization.PrivateFormat.Raw,
            serialization.NoEncryption())
        self.path.write_bytes(raw)
        self.path.chmod(0o600)

    def exchange(self):
        parent, child = socket.socketpair(socket.AF_UNIX, socket.SOCK_STREAM)
        parent.settimeout(0.4)
        child.settimeout(1)
        process = subprocess.Popen(
            [sys.executable, "-B", "-c", CHILD, str(child.fileno()),
             str(self.path), self.public_hex],
            pass_fds=(child.fileno(),), close_fds=True,
            stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        child.close()
        try:
            accepted = query_one(
                parent, self.client, event_id="restart", authority_ref="pinned",
                minimum_generation=2, expected_server_uid=0)
            out, err = process.communicate(timeout=4)
            return accepted, process.returncode, err
        finally:
            parent.close()
            if process.poll() is None:
                process.kill()
                process.communicate()

    def test_fresh_process_reuses_pinned_key_without_replaying_challenge(self):
        first, code1, err1 = self.exchange()
        second, code2, err2 = self.exchange()
        self.assertTrue(first, err1)
        self.assertTrue(second, err2)
        self.assertEqual((code1, code2), (0, 0))

    def test_substituted_valid_private_key_denied_after_restart(self):
        accepted, code, err = self.exchange()
        self.assertTrue(accepted, err)
        self.assertEqual(code, 0)
        self.write_key(Ed25519PrivateKey.generate())
        accepted, code, err = self.exchange()
        self.assertFalse(accepted)
        self.assertEqual(code, 3, err)
        self.assertIn("PermissionError", err)

    def test_missing_key_denied_after_restart_then_valid_recovery(self):
        self.path.unlink()
        accepted, code, err = self.exchange()
        self.assertFalse(accepted)
        self.assertEqual(code, 3, err)
        self.assertIn("FileNotFoundError", err)
        self.write_key(self.original)
        accepted, code, err = self.exchange()
        self.assertTrue(accepted, err)
        self.assertEqual(code, 0)

    def test_insecure_key_permissions_denied_after_restart(self):
        self.path.chmod(0o644)
        accepted, code, err = self.exchange()
        self.assertFalse(accepted)
        self.assertEqual(code, 3, err)
        self.assertIn("PermissionError", err)


if __name__ == "__main__":
    unittest.main()
