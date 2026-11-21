"""Research integration tests: provisioned signer -> verified HOLD acknowledgment.

Root-only disposable fixture. No production key, service, or protected effect.
"""
import os
import socket
import tempfile
import threading
import unittest
import sys
from pathlib import Path

from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey

from koru_hold_challenge_client import HoldReceiptChallengeClient
from koru_local_hold_ack_socket import query_one
from koru_provisioned_receipt_issuer import serve_one_provisioned


class Floor:
    def __init__(self, held=True):
        self.held = held

    def hold_status(self, _fence):
        return {"ok": self.held, "code": "hold_complete" if self.held
                else "hold_pending_deny", "generation": 2}

    def read(self):
        return {"held": self.held, "generation": 2, "event_id": "event",
                "authority_ref": "authority"}


class Fence:
    def __enter__(self):
        return self

    def __exit__(self, *_):
        return False


@unittest.skipUnless(sys.platform == "linux" and os.geteuid() == 0,
                     "disposable root-enabled Linux fixture only")
class ProvisionedIssuerTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="g3-provisioned-")
        self.root = Path(self.temp.name)
        self.root.chmod(0o700)
        self.key_path = self.root / "key"
        self.key = Ed25519PrivateKey.generate()
        self.install_key(self.key)
        self.client_sock, self.server_sock = socket.socketpair(
            socket.AF_UNIX, socket.SOCK_STREAM)
        for sock in (self.client_sock, self.server_sock):
            sock.settimeout(0.5)

    def tearDown(self):
        self.client_sock.close()
        self.server_sock.close()
        self.temp.cleanup()

    def install_key(self, key):
        raw = key.private_bytes(
            serialization.Encoding.Raw, serialization.PrivateFormat.Raw,
            serialization.NoEncryption())
        # Fixture provisioning is intentionally separate from issuer API.
        self.key_path.write_bytes(raw)
        self.key_path.chmod(0o600)

    def serve(self, **kwargs):
        return serve_one_provisioned(
            self.server_sock, permitted_uid=kwargs.get("uid", os.getuid()),
            key_path=str(self.key_path),
            trusted_public_key=kwargs.get("trust", self.key.public_key()),
            floor=Floor(kwargs.get("held", True)), fence=Fence(), issuer="fixture")

    def query(self, key=None):
        client = HoldReceiptChallengeClient(
            (key or self.key).public_key(), issuer="fixture")
        return query_one(
            self.client_sock, client, event_id="event",
            authority_ref="authority", minimum_generation=2,
            expected_server_uid=os.getuid())

    def test_complete_hold_has_verified_receipt(self):
        failures = []
        def server():
            try:
                self.serve()
            except Exception as error:
                failures.append(error)
        t = threading.Thread(target=server)
        t.start()
        self.assertTrue(self.query())
        t.join(2)
        self.assertFalse(failures)

    def test_wrong_signer_after_key_file_replacement_denies(self):
        self.install_key(Ed25519PrivateKey.generate())
        with self.assertRaises(PermissionError):
            self.serve()
        self.assertFalse(self.query())

    def test_missing_signer_refuses_receipt(self):
        self.key_path.unlink()
        with self.assertRaises(FileNotFoundError):
            self.serve()
        self.assertFalse(self.query())

    def test_insecure_key_mode_refuses_receipt(self):
        self.key_path.chmod(0o644)
        with self.assertRaises(PermissionError):
            self.serve()
        self.assertFalse(self.query())

    def test_symlink_signer_refuses_receipt(self):
        other = self.root / "other"
        os.rename(self.key_path, other)
        self.key_path.symlink_to(other)
        with self.assertRaises(OSError):
            self.serve()
        self.assertFalse(self.query())

    def test_wrong_client_uid_denies_before_signing(self):
        with self.assertRaises(PermissionError):
            self.serve(uid=os.getuid() + 1)
        self.assertFalse(self.query())

    def test_pending_hold_never_produces_receipt(self):
        failures = []
        def server():
            try:
                self.serve(held=False)
            except Exception as error:
                failures.append(error)
        t = threading.Thread(target=server)
        t.start()
        self.assertFalse(self.query())
        t.join(2)
        self.assertTrue(any(isinstance(x, PermissionError) for x in failures))

    def test_missing_trust_anchor_denies(self):
        with self.assertRaises(TypeError):
            self.serve(trust=None)
        self.assertFalse(self.query())


if __name__ == "__main__":
    unittest.main()
