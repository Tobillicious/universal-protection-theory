"""Hostile R7 WORM signature-binding tests; synthetic evidence only."""
import hashlib
import json
import unittest
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey

from test_g3_worm_pinned_receipt import PinnedWormReceiptTests
from g3_r7_external_review_signature import DOMAIN as REVIEW_DOMAIN
from g3_r7_worm_review import verify


class R7WormTests(unittest.TestCase):
    def setUp(self):
        fixture = PinnedWormReceiptTests(
            methodName="test_receipt_crypto_valid_but_physical_custody_stays_open")
        fixture.setUp()
        self.fixture = fixture
        self.receipt = fixture.signed()
        self.reviewer = Ed25519PrivateKey.generate()
        self.review = dict(
            schema="g3-r7-external-review-v1",
            source_commit="a" * 40,
            evidence_sha256=hashlib.sha256(self.receipt).hexdigest(),
            scope="synthetic fixed marker",
            decision="HOLD_UNRESOLVED",
            reviewer_identifier="synthetic-reviewer",
            reviewed_at_utc="2026-11-18T00:00:00Z",
            findings="Cryptographic review only, not verified independent custody")

    def signed_review(self, review=None, signer=None):
        raw = json.dumps(self.review if review is None else review,
                         sort_keys=True).encode()
        key = self.reviewer if signer is None else signer
        return raw, key.sign(REVIEW_DOMAIN + raw)

    def check(self, *, review_bytes=None, review_signature=None, **overrides):
        if review_bytes is None and review_signature is None:
            review_bytes, review_signature = self.signed_review()
        args = self.fixture.args
        public = self.reviewer.public_key().public_bytes_raw()
        kwargs = dict(
            receipt_bytes=self.receipt,
            bundle_bytes=self.fixture.bundle,
            event_bytes=args["event_bytes"],
            inventory_bytes=args["inventory_bytes"],
            expected_commit=args["expected_commit"],
            challenge_nonce=args["challenge_nonce"],
            expected_floor=args["expected_floor"],
            operator_public_key=args["operator_public_key"],
            custodian_public_key=self.fixture.custodian.public_key(),
            independently_pinned_receipt_sha256=hashlib.sha256(
                self.receipt).hexdigest(),
            independently_pinned_predecessor_sha256="e" * 64,
            independently_pinned_store_id="external-custodian-A",
            independently_pinned_retention_policy_id="policy-2026-review",
            expected_sequence=2,
            review_bytes=review_bytes,
            review_signature=review_signature,
            reviewer_public_key=public,
            independently_pinned_reviewer_key_sha256=hashlib.sha256(
                public).hexdigest())
        kwargs.update(overrides)
        return verify(**kwargs)

    def test_signed_hold_review_never_grants_permission(self):
        report = self.check()
        self.assertTrue(report["detached_review_signature_verified"])
        self.assertTrue(report["cryptographic_custody_receipt_verified"])
        self.assertEqual(report["status"], "HOLD_REVIEW_NOT_ACCEPTED")
        self.assertFalse(report["universal_G3_proved"])
        self.assertFalse(report["authorizes_effect"])

    def test_bounded_acceptance_does_not_prove_universality(self):
        doc = dict(self.review, decision="ACCEPT_BOUNDED_RESEARCH")
        raw, sig = self.signed_review(review=doc)
        result = self.check(review_bytes=raw, review_signature=sig)
        self.assertEqual(
            result["status"],
            "BOUNDED_CRYPTOGRAPHIC_REVIEW_ACCEPTED_PHYSICAL_GATES_OPEN")
        self.assertFalse(result["independent_administration_verified"])
        self.assertFalse(result["hCoverage_proved"])
        self.assertFalse(result["may_clear_hold"])

    def test_review_wrong_receipt_digest_denied(self):
        doc = dict(self.review, evidence_sha256="0" * 64)
        raw, sig = self.signed_review(review=doc)
        with self.assertRaises(ValueError):
            self.check(review_bytes=raw, review_signature=sig)

    def test_signed_review_for_other_scope_denied(self):
        doc = dict(self.review, scope="different physical domain")
        raw, sig = self.signed_review(review=doc)
        with self.assertRaisesRegex(ValueError, "scope differs"):
            self.check(review_bytes=raw, review_signature=sig)

    def test_forged_review_signature_denied(self):
        raw, sig = self.signed_review(signer=Ed25519PrivateKey.generate())
        with self.assertRaises(ValueError):
            self.check(review_bytes=raw, review_signature=sig)

    def test_reviewer_key_pin_mismatch_denied(self):
        with self.assertRaisesRegex(ValueError, "independent pin"):
            self.check(independently_pinned_reviewer_key_sha256="0" * 64)

    def test_reviewer_cannot_reuse_operator_or_custodian_key(self):
        with self.assertRaisesRegex(ValueError, "must differ"):
            self.check(
                reviewer_public_key=self.fixture.args[
                    "operator_public_key"].public_bytes_raw(),
                independently_pinned_reviewer_key_sha256=hashlib.sha256(
                    self.fixture.args["operator_public_key"].public_bytes_raw()
                ).hexdigest())

    def test_forked_custody_chain_denied(self):
        with self.assertRaises(ValueError):
            self.check(independently_pinned_predecessor_sha256="f" * 64)

    def test_source_change_denied(self):
        with self.assertRaises(ValueError):
            self.check(expected_commit="f" * 40)


if __name__ == "__main__":
    unittest.main()
