"""Hostile tests for exact pinned, signed, chained custody statements."""
import copy
import hashlib
import json
import unittest

from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from test_g3_worm_custody import WormCustodyTests
from g3_worm_custody import assemble, canonical
from g3_worm_pinned_receipt import DOMAIN, verify

class PinnedWormReceiptTests(unittest.TestCase):
    def setUp(self):
        fixture = WormCustodyTests(methodName="test_valid_scoped_bundle_remains_on_hold")
        fixture.setUp()
        self.args = fixture.inputs()
        self.bundle = assemble(**self.args)
        self.custodian = Ed25519PrivateKey.generate()
        self.body = dict(schema="g3-worm-custody-receipt-v1",
            store_id="external-custodian-A", sequence=2,
            predecessor_receipt_sha256="e"*64,
            bundle_sha256=hashlib.sha256(self.bundle).hexdigest(),
            source_commit="a"*40, scope="synthetic fixed marker",
            checkpoint_revision=2, retention_policy_id="policy-2026-review",
            status="retained_receipt_claimed")

    def signed(self, body=None, signing_key=None):
        b = self.body if body is None else body
        private = self.custodian if signing_key is None else signing_key
        return canonical(dict(b, signature=private.sign(DOMAIN + canonical(b)).hex()))

    def check(self, receipt, **changes):
        kw = dict(receipt_bytes=receipt, bundle_bytes=self.bundle,
            event_bytes=self.args["event_bytes"],
            inventory_bytes=self.args["inventory_bytes"],
            expected_commit=self.args["expected_commit"],
            challenge_nonce=self.args["challenge_nonce"],
            expected_floor=self.args["expected_floor"],
            operator_public_key=self.args["operator_public_key"],
            custodian_public_key=self.custodian.public_key(),
            independently_pinned_receipt_sha256=hashlib.sha256(receipt).hexdigest(),
            independently_pinned_predecessor_sha256="e"*64,
            independently_pinned_store_id="external-custodian-A",
            independently_pinned_retention_policy_id="policy-2026-review",
            expected_sequence=2)
        kw.update(changes)
        return verify(**kw)

    def test_receipt_crypto_valid_but_physical_custody_stays_open(self):
        result = self.check(self.signed())
        self.assertTrue(result["cryptographic_receipt_verified"])
        for key in ("independent_retention_verified",
                    "independent_administration_verified", "hCoverage_proved",
                    "hMeaning_proved", "universal_G3_proved",
                    "authorizes_effect", "may_clear_hold"):
            self.assertFalse(result[key])

    def test_independent_digest_pin_rejects_substitution(self):
        with self.assertRaisesRegex(ValueError, "pinned digest"):
            self.check(self.signed(), independently_pinned_receipt_sha256="0"*64)

    def test_replayed_sequence_and_forked_predecessor_denied(self):
        for change in (dict(expected_sequence=3),
                       dict(independently_pinned_predecessor_sha256="f"*64)):
            with self.subTest(change=change), self.assertRaises(ValueError):
                self.check(self.signed(), **change)

    def test_forged_signature_denied_even_if_digest_recalculated(self):
        forged = self.signed(signing_key=Ed25519PrivateKey.generate())
        with self.assertRaisesRegex(ValueError, "signature invalid"):
            self.check(forged)

    def test_old_bundle_cannot_claim_new_bundle(self):
        altered = dict(self.args)
        altered["inventory_bytes"] += b" "
        with self.assertRaises(ValueError):
            self.check(self.signed(), inventory_bytes=altered["inventory_bytes"])

    def test_policy_and_store_swap_denied(self):
        for change in ({"retention_policy_id":"different-policy"},
                       {"store_id":"attacker-store"}):
            b = dict(self.body, **change)
            with self.subTest(change=change), self.assertRaises(ValueError):
                self.check(self.signed(b))

    def test_operator_key_must_differ_from_receipt_key(self):
        with self.assertRaisesRegex(ValueError, "must differ"):
            self.check(self.signed(), custodian_public_key=self.args["operator_public_key"])

    def test_claim_escalation_and_duplicate_json_denied(self):
        b = dict(self.body, status="physical_G3_certified")
        with self.assertRaises(ValueError):
            self.check(self.signed(b))
        raw = self.signed()
        with self.assertRaises(ValueError):
            self.check(raw[:-1] + b', "sequence": 2}')

if __name__ == "__main__":
    unittest.main()
