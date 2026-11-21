"""Signed challenge-bound acknowledgment adversarial tests.

The issuer key is generated for each disposable test, never committed.
No production IPC or live privileged service is installed.
"""
import os
import sys
import unittest

from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
import test_koru_hold_ack_reconcile as prior
from koru_signed_hold_receipt import (
    issue_complete_receipt, verify_complete_receipt)


@unittest.skipUnless(sys.platform == "linux" and os.geteuid() == 0,
                     "disposable Linux root fixture only")
class SignedHoldReceiptTests(unittest.TestCase):
    def setUp(self):
        self.fixture = prior.HoldAcknowledgmentRecoveryTests(
            methodName="test_killed_after_intent_reports_pending_not_ack_then_reconciles")
        self.fixture.setUp()
        self.secret = Ed25519PrivateKey.generate()
        self.pub = self.secret.public_key()
        self.nonce = os.urandom(32).hex()
        c = self.fixture.fixture.fixture.case
        self.event = c.event

    def tearDown(self):
        self.fixture.tearDown()

    def sign(self, nonce=None):
        def do(floor,fence):
            return issue_complete_receipt(
                self.secret, floor, fence, issuer="root-guardian-test",
                nonce=self.nonce if nonce is None else nonce)
        return self.fixture.with_root(do)

    def verify(self, receipt, nonce=None, **overrides):
        p = {"issuer": "root-guardian-test",
             "nonce": self.nonce if nonce is None else nonce,
             "event_id": self.event["event_id"],
             "authority_ref": self.event["authority_ref"],
             "minimum_generation": self.event["generation"]}
        p.update(overrides)
        return verify_complete_receipt(self.pub, receipt, **p)

    def test_pending_state_cannot_claim_completed_ack(self):
        self.fixture.fixture.kill_at("after-intent-sync", "AFTER_INTENT_SYNC")
        with self.assertRaises(PermissionError):
            self.sign()
        self.assertEqual(self.fixture.fixture.fixture.case.request()["code"],
                         "writer_authorization_denied")
        self.fixture.with_root(lambda floor,fence: floor.reconcile_hold(fence))
        receipt=self.sign()
        self.assertTrue(self.verify(receipt))
        self.fixture.fixture.assert_denied_and_restart()

    def test_signature_rejects_forgery_tamper_and_wrong_key(self):
        self.fixture.with_root(lambda floor,fence: floor.commit_hold(fence))
        receipt=self.sign()
        self.assertTrue(self.verify(receipt))
        for key, value in (("generation", receipt["generation"]+1),
                           ("status", "hold_pending_deny"),
                           ("issuer", "other-issuer"),
                           ("event_id", "different-event"),
                           ("signature", "0"*128)):
            fake=dict(receipt)
            fake[key]=value
            self.assertFalse(self.verify(fake),key)
        self.assertFalse(verify_complete_receipt(
            Ed25519PrivateKey.generate().public_key(),receipt,
            issuer="root-guardian-test",nonce=self.nonce,
            event_id=self.event["event_id"],
            authority_ref=self.event["authority_ref"],
            minimum_generation=self.event["generation"]))

    def test_old_nonce_replay_and_wrong_subject_rejected(self):
        self.fixture.with_root(lambda floor,fence: floor.commit_hold(fence))
        receipt=self.sign()
        self.assertFalse(self.verify(receipt,nonce=os.urandom(32).hex()))
        self.assertFalse(self.verify(receipt,event_id="other-event"))
        self.assertFalse(self.verify(receipt,authority_ref="other-authority"))
        self.assertFalse(self.verify(receipt,minimum_generation=receipt["generation"]+1))
        self.assertTrue(self.verify(receipt))

    def test_missing_reply_can_be_requeried_without_reenacting_effect(self):
        c=self.fixture.fixture.fixture.case
        self.fixture.with_root(lambda floor,fence: floor.commit_hold(fence))
        _lost_receipt=self.sign()
        # The caller does not accept a missing response or replay old nonce.
        next_nonce=os.urandom(32).hex()
        self.assertFalse(self.verify(_lost_receipt,nonce=next_nonce))
        fresh=self.sign(nonce=next_nonce)
        self.assertTrue(self.verify(fresh,nonce=next_nonce))
        self.assertEqual(c.request()["code"],"writer_authorization_denied")
        c.stop_writer()
        self.fixture.fixture.fixture.start_anchored_writer()
        self.assertEqual(c.request()["code"],"writer_authorization_denied")

    def test_precommit_kill_never_produces_completed_receipt(self):
        self.fixture.fixture.kill_at("before-intent","BEFORE_INTENT")
        with self.assertRaises(PermissionError):
            self.sign()
        result=self.fixture.with_root(lambda floor,fence:floor.hold_status(fence))
        self.assertEqual(result["code"],"hold_not_committed")


if __name__ == "__main__":
    unittest.main()
