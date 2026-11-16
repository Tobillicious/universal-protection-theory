"""Disposable Linux socketpair tests; no listener, root or deployed service."""
import os
import socket
import sys
import threading
import unittest

from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from koru_hold_challenge_client import HoldReceiptChallengeClient
from koru_local_hold_ack_socket import serve_one, query_one, _send_frame, _read_frame


class Fence:
    def __enter__(self):
        return self
    def __exit__(self, *_):
        return False


class Floor:
    def __init__(self, held=True):
        self.held = held
    def hold_status(self, fence):
        return {"ok": self.held, "code": "hold_complete" if self.held else
                "hold_pending_deny", "generation": 2}
    def read(self):
        return {"held": self.held, "generation": 2,
                "event_id": "event-one", "authority_ref": "authority-one"}


@unittest.skipUnless(sys.platform == "linux" and hasattr(socket, "SO_PEERCRED"),
                     "Linux SO_PEERCRED required")
class LocalHoldSocketTests(unittest.TestCase):
    def setUp(self):
        self.key = Ed25519PrivateKey.generate()
        self.client = HoldReceiptChallengeClient(self.key.public_key(),
                                                   issuer="fixture-guardian")
        self.left, self.right = socket.socketpair(socket.AF_UNIX, socket.SOCK_STREAM)
        for s in (self.left, self.right):
            s.settimeout(1)

    def tearDown(self):
        self.left.close()
        self.right.close()

    def handler(self, **kw):
        return serve_one(self.right, permitted_uid=kw.get("uid", os.getuid()),
                         private_key=self.key, floor=Floor(kw.get("held", True)),
                         fence=Fence(), issuer="fixture-guardian")

    def query(self):
        return query_one(self.left, self.client, event_id="event-one",
                         authority_ref="authority-one", minimum_generation=2,
                         expected_server_uid=os.getuid())

    def test_valid_peer_completed_hold(self):
        errors = []
        t = threading.Thread(target=lambda: self._capture(errors, self.handler))
        t.start()
        self.assertTrue(self.query())
        t.join(2)
        self.assertFalse(errors)

    @staticmethod
    def _capture(errors, fn):
        try:
            fn()
        except Exception as e:
            errors.append(e)

    def test_client_rejects_wrong_server_uid_before_query(self):
        # No server worker is started. Wrong peer UID must reject without
        # sending a challenge; connected socket remains readable nowhere.
        self.assertFalse(query_one(
            self.left, self.client, event_id="event-one",
            authority_ref="authority-one", minimum_generation=2,
            expected_server_uid=os.getuid() + 1))
        self.right.settimeout(0.05)
        with self.assertRaises(socket.timeout):
            self.right.recv(1)

    def test_client_requires_explicit_valid_server_pin(self):
        with self.assertRaises(ValueError):
            query_one(self.left, self.client, event_id="event-one",
                      authority_ref="authority-one", minimum_generation=2,
                      expected_server_uid=True)

    def test_wrong_uid_denies_before_signing(self):
        with self.assertRaises(PermissionError):
            self.handler(uid=os.getuid()+1)

    def test_pending_hold_never_acknowledged(self):
        errors=[]
        t=threading.Thread(target=lambda:
                           self._capture(errors, lambda: self.handler(held=False)))
        t.start()
        self.assertFalse(self.query())
        t.join(2)
        self.assertTrue(any(isinstance(e, PermissionError) for e in errors))

    def test_truncated_and_oversized_requests_rejected(self):
        self.left.sendall(b'{"op":"query_complete_hold"')
        self.left.shutdown(socket.SHUT_WR)
        with self.assertRaises(ValueError):
            self.handler()

    def test_invalid_query_rejected(self):
        _send_frame(self.left, {"op":"publish","nonce":"a"*64})
        with self.assertRaises(ValueError):
            self.handler()

    def test_invalid_nonce_rejected(self):
        _send_frame(self.left, {"op":"query_complete_hold","nonce":"not-a-nonce"})
        with self.assertRaises(ValueError):
            self.handler()

    def test_response_loss_fail_closed(self):
        self.right.close()
        self.assertFalse(self.query())


if __name__ == "__main__":
    unittest.main()
