"""Disposable root-only AF_UNIX endpoint substitution regression controls.

Uses synthetic HOLD floor and ephemeral fixture key. No production endpoints.
"""
import os
import socket
import stat
import sys
import tempfile
import threading
import unittest
from pathlib import Path

from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from koru_socket_endpoint_pin import PinnedSocketEndpoint
from koru_local_hold_ack_socket import serve_one, query_one
from koru_hold_challenge_client import HoldReceiptChallengeClient


class Floor:
    def hold_status(self, fence):
        return {"ok": True, "code": "hold_complete", "generation": 2}
    def read(self):
        return {"held": True, "generation": 2, "event_id": "event",
                "authority_ref": "authority"}


class Fence:
    def __enter__(self):
        return self
    def __exit__(self, *_):
        return False


@unittest.skipUnless(sys.platform == "linux" and os.geteuid() == 0,
                     "disposable Linux root fixture required")
class SocketPinTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="g3-endpoint-")
        os.chmod(self.temp.name, 0o755)
        self.path = str(Path(self.temp.name) / "guardian.sock")
        self.listener = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        self.listener.bind(self.path)
        os.chmod(self.path, 0o660)
        self.listener.listen(2)
        self.pin = PinnedSocketEndpoint(self.path)
        self.key = Ed25519PrivateKey.generate()

    def tearDown(self):
        self.pin.close()
        self.listener.close()
        self.temp.cleanup()

    def test_intact_endpoint_verifies(self):
        self.pin.verify()

    def test_unlinked_endpoint_denied(self):
        os.unlink(self.path)
        with self.assertRaises(OSError):
            self.pin.verify()

    def test_path_replaced_by_new_socket_denied(self):
        os.unlink(self.path)
        impostor = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        try:
            impostor.bind(self.path)
            os.chmod(self.path, 0o660)
            with self.assertRaises(PermissionError):
                self.pin.verify()
        finally:
            impostor.close()

    def test_path_replaced_by_symlink_denied(self):
        os.unlink(self.path)
        os.symlink("/dev/null", self.path)
        with self.assertRaises(PermissionError):
            self.pin.verify()

    def test_replaced_parent_directory_denied(self):
        original = self.temp.name
        moved = original + "-moved"
        os.rename(original, moved)
        try:
            os.mkdir(original, 0o755)
            with self.assertRaises(PermissionError):
                self.pin.verify()
        finally:
            os.rmdir(original)
            os.rename(moved, original)

    def test_valid_receipt_when_path_intact(self):
        client_sock, server_sock = socket.socketpair(socket.AF_UNIX,
                                                      socket.SOCK_STREAM)
        try:
            for s in (client_sock, server_sock):
                s.settimeout(2)
            client = HoldReceiptChallengeClient(self.key.public_key(),
                                                issuer="fixture")
            failures = []
            def serve():
                try:
                    serve_one(server_sock, permitted_uid=0, private_key=self.key,
                              floor=Floor(), fence=Fence(), issuer="fixture",
                              endpoint_binding=self.pin)
                except BaseException as ex:
                    failures.append(ex)
            t = threading.Thread(target=serve)
            t.start()
            accepted = query_one(client_sock, client, event_id="event",
                                 authority_ref="authority",
                                 minimum_generation=2, expected_server_uid=0)
            t.join(3)
            self.assertTrue(accepted)
            self.assertFalse(failures)
        finally:
            client_sock.close()
            server_sock.close()

    def test_substituted_path_rejects_receipt_before_read(self):
        client_sock, server_sock = socket.socketpair(socket.AF_UNIX,
                                                      socket.SOCK_STREAM)
        try:
            os.unlink(self.path)
            with self.assertRaises(OSError):
                serve_one(server_sock, permitted_uid=0, private_key=self.key,
                          floor=Floor(), fence=Fence(), issuer="fixture",
                          endpoint_binding=self.pin)
            client_sock.settimeout(0.05)
            with self.assertRaises(socket.timeout):
                client_sock.recv(1)
        finally:
            client_sock.close()
            server_sock.close()


if __name__ == "__main__":
    unittest.main()
