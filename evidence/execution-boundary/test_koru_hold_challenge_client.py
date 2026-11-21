"""Adversarial client-side HOLD acknowledgment challenge controls.

Runs without root, sockets, production keys, or any live protected effect.
"""
import time
import unittest
from unittest.mock import patch

from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from koru_signed_hold_receipt import _body, _serialize
from koru_hold_challenge_client import HoldReceiptChallengeClient


class ChallengeClientTests(unittest.TestCase):
    def setUp(self):
        self.secret = Ed25519PrivateKey.generate()
        self.client = HoldReceiptChallengeClient(
            self.secret.public_key(), issuer="fixture-guardian")

    def receipt(self, nonce, *, event="event-one", authority="authority-one",
                generation=2):
        body = _body(issuer="fixture-guardian", nonce=nonce,
                     generation=generation, event_id=event,
                     authority_ref=authority)
        return {**body, "signature": self.secret.sign(_serialize(body)).hex()}

    def begin(self, client=None, **kwargs):
        return (client or self.client).begin(
            event_id=kwargs.get("event_id", "event-one"),
            authority_ref=kwargs.get("authority_ref", "authority-one"),
            minimum_generation=kwargs.get("minimum_generation", 2))

    def test_success_is_single_use(self):
        nonce = self.begin()
        signed = self.receipt(nonce)
        self.assertTrue(self.client.accept(nonce, signed))
        self.assertFalse(self.client.accept(nonce, signed))

    def test_missing_reply_consumes_challenge(self):
        nonce = self.begin()
        self.assertFalse(self.client.accept(nonce, None))
        self.assertFalse(self.client.accept(nonce, self.receipt(nonce)))
        fresh = self.begin()
        self.assertNotEqual(fresh, nonce)
        self.assertTrue(self.client.accept(fresh, self.receipt(fresh)))

    def test_forgery_then_genuine_receipt_cannot_recover_nonce(self):
        nonce = self.begin()
        bad = self.receipt(nonce)
        bad["signature"] = "0" * 128
        self.assertFalse(self.client.accept(nonce, bad))
        self.assertFalse(self.client.accept(nonce, self.receipt(nonce)))

    def test_wrong_subject_and_generation_fail_closed(self):
        nonce = self.begin()
        self.assertFalse(self.client.accept(
            nonce, self.receipt(nonce, event="other")))
        newer = self.begin(minimum_generation=5)
        self.assertFalse(self.client.accept(newer, self.receipt(newer)))

    def test_reply_swapping_and_old_replay(self):
        a = self.begin()
        b = self.begin()
        self.assertFalse(self.client.accept(a, self.receipt(b)))
        self.assertFalse(self.client.accept(b, self.receipt(a)))
        self.assertFalse(self.client.accept(a, self.receipt(a)))

    def test_wrong_issuer_key_and_cancel(self):
        stranger = HoldReceiptChallengeClient(
            Ed25519PrivateKey.generate().public_key(), issuer="fixture-guardian")
        nonce = self.begin(stranger)
        self.assertFalse(stranger.accept(nonce, self.receipt(nonce)))
        next_nonce = self.begin()
        self.assertTrue(self.client.cancel(next_nonce))
        self.assertFalse(self.client.accept(next_nonce, self.receipt(next_nonce)))

    def test_expiry_and_capacity(self):
        bounded = HoldReceiptChallengeClient(
            self.secret.public_key(), issuer="fixture-guardian",
            max_pending=1, ttl_seconds=0.001)
        nonce = self.begin(bounded)
        with self.assertRaises(RuntimeError):
            self.begin(bounded)
        time.sleep(0.01)
        self.assertFalse(bounded.accept(nonce, self.receipt(nonce)))
        fresh = self.begin(bounded)
        self.assertNotEqual(fresh, nonce)

    def test_invalid_query_does_not_register(self):
        with self.assertRaises(ValueError):
            self.begin(minimum_generation=True)
        with self.assertRaises(ValueError):
            self.begin(event_id="")
        self.assertFalse(self.client.accept("0" * 64, None))


if __name__ == "__main__":
    unittest.main()
