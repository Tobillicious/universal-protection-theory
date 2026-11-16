"""Adversarial signed reconciliation fixture. Review never authorizes an effect."""
import hashlib
import tempfile
import unittest
from pathlib import Path

from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from koru_durable_effect_intent import DurableEffectIntentBoundary
from koru_signed_effect_reconciliation import (
    BODY, DOMAIN, SignedReconciliationRecorder, _canonical)
from koru_transactional_hold_witness import TransactionalHoldWitness


class SignedReconciliationTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix="g3-review-")
        self.db = str(Path(self.tmp.name) / "state.db")
        state = dict(generation=3, held=False,
                     event_id="event", authority_ref="ref")
        self.expected = {k: state[k] for k in
                         ("generation", "event_id", "authority_ref")}
        self.store = TransactionalHoldWitness.provision(self.db, state)
        self.gate = DurableEffectIntentBoundary.provision_journal(self.store)
        SignedReconciliationRecorder.provision_review_table(self.store)
        self.key = Ed25519PrivateKey.generate()
        self.recorder = SignedReconciliationRecorder(
            self.store, self.key.public_key())

    def tearDown(self):
        self.tmp.cleanup()

    def uncertain(self):
        def partially_effected():
            raise RuntimeError("uncertain effect")
        self.assertEqual(self.gate.enact("op", self.expected,
                         lambda: True, partially_effected)["code"],
                         "outcome_uncertain")
        self.assertEqual(self.gate.pending_operations(), ["op"])

    def signed(self, **updates):
        body = dict(domain=DOMAIN, operation_id="op", generation=3,
                    event_id="event", authority_ref="ref",
                    finding="observed_partial", review_id="review-1",
                    evidence_sha256=hashlib.sha256(b"fixture observations").hexdigest())
        body.update(updates)
        return dict(body, signature=self.key.sign(_canonical(body)).hex())

    def test_signed_review_records_observation_but_pending_remains(self):
        self.uncertain()
        self.assertTrue(self.recorder.record(self.signed()))
        self.assertEqual(self.recorder.reviewed("op")[1], "observed_partial")
        self.assertEqual(self.gate.pending_operations(), ["op"])
        self.assertFalse(self.gate.enact("next", self.expected,
                                        lambda: True, lambda: {"ok": True})["ok"])

    def test_claimed_complete_does_not_clear_pending_or_hold(self):
        self.uncertain()
        self.store.commit_hold()
        self.assertTrue(self.recorder.record(self.signed(finding="observed_complete")))
        self.assertEqual(self.gate.pending_operations(), ["op"])
        self.assertTrue(self.store.read()["held"])
        self.assertFalse(self.gate.enact("new", self.expected,
                                        lambda: True, lambda: {"ok": True})["ok"])

    def test_forgery_and_tampering_denied(self):
        self.uncertain()
        envelope = self.signed()
        envelope["finding"] = "observed_complete"
        self.assertFalse(self.recorder.record(envelope))
        forged = self.signed()
        forged["signature"] = Ed25519PrivateKey.generate().sign(
            _canonical({k: forged[k] for k in BODY})).hex()
        self.assertFalse(self.recorder.record(forged))
        self.assertIsNone(self.recorder.reviewed("op"))
        self.assertEqual(self.gate.pending_operations(), ["op"])

    def test_cross_operation_identity_and_generation_substitution_denied(self):
        self.uncertain()
        for update in (dict(operation_id="other"), dict(generation=4),
                       dict(authority_ref="wrong"), dict(event_id="other")):
            self.assertFalse(self.recorder.record(self.signed(**update)))
        self.assertIsNone(self.recorder.reviewed("op"))

    def test_duplicate_review_cannot_rewrite_record(self):
        self.uncertain()
        first = self.signed()
        self.assertTrue(self.recorder.record(first))
        self.assertFalse(self.recorder.record(first))
        self.assertFalse(self.recorder.record(
            self.signed(review_id="review-2", finding="observed_complete")))
        self.assertEqual(self.recorder.reviewed("op")[1], "observed_partial")

    def test_missing_review_table_denies_without_recreation(self):
        self.uncertain()
        from contextlib import closing
        with closing(self.store._connect()) as db:
            db.execute("DROP TABLE effect_review")
        self.assertFalse(self.recorder.record(self.signed()))
        self.assertEqual(self.gate.pending_operations(), ["op"])

    def test_review_of_completed_intent_is_rejected(self):
        self.assertTrue(self.gate.enact(
            "op", self.expected, lambda: True, lambda: {"ok": True})["ok"])
        self.assertFalse(self.recorder.record(self.signed()))
        self.assertIsNone(self.recorder.reviewed("op"))


if __name__ == "__main__":
    unittest.main()
