"""Synthetic negative controls for the exact-event G3 physical last-mile join."""
import copy
import hashlib
import json
import unittest

from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey

from g3_quorum_certificate_check import DOMAIN
from g3_r6_same_event_evidence_audit import SIX
from g3_joint_physical_acceptance import evaluate

HEAD = "a" * 40


class G3JointPhysicalReviewTests(unittest.TestCase):
    def setUp(self):
        self.private = [Ed25519PrivateKey.generate() for _ in range(4)]
        self.roster = {"reviewer-" + str(i): k.public_key().public_bytes(
            encoding=serialization.Encoding.Raw,
            format=serialization.PublicFormat.Raw).hex()
            for i, k in enumerate(self.private)}
        self.pin = hashlib.sha256(json.dumps(
            self.roster, sort_keys=True, separators=(",", ":")).encode()).hexdigest()
        self.packet = {
            "schema": "g3-r6-zelda-observed-events-v1",
            "source_commit": HEAD,
            "scope": "synthetic one fixed marker; NOT real custody",
            "declared_paths": ["marker"],
            "events": [{"event_id": "event-1", "effect_path": "marker",
                        "before_sha256": "b" * 64, "after_sha256": "c" * 64,
                        "observer_ref": "synthetic-observer",
                        "actor_ref": "synthetic-actor"}],
            "owed_by_event": {"event-1": ["subject-1"]},
            "duties_by_event": {"event-1": {"subject-1": {
                d: {"status": "supported", "evidence_ref": "event-1-subject-1-" + d}
                for d in SIX}}},
        }

    def bundle(self, *, signers=(0, 1, 2), packet=None):
        raw = json.dumps(self.packet if packet is None else packet).encode()
        digest = hashlib.sha256(raw).hexdigest()
        statement = DOMAIN + json.dumps(
            {"record_sha256": digest, "epoch": 1, "roster_sha256": self.pin},
            sort_keys=True, separators=(",", ":")).encode()
        cert = {
            "schema": "g3-independent-review-quorum-v1",
            "record_sha256": digest,
            "epoch": 1,
            "fault_tolerance": 1,
            "roster": self.roster,
            "signatures": [{"member": "reviewer-" + str(i),
                            "signature": self.private[i].sign(statement).hex()}
                           for i in signers],
        }
        return raw, json.dumps(cert).encode()

    def check(self, raw, certificate, **overrides):
        args = {"packet_bytes": raw, "expected_commit": HEAD,
                "certificate_bytes": certificate, "trusted_roster": self.roster,
                "independently_pinned_roster_sha256": self.pin}
        args.update(overrides)
        return evaluate(**args)

    def test_three_signatures_do_not_certify_universal_or_human_meaning(self):
        raw, cert = self.bundle()
        result = self.check(raw, cert)
        self.assertTrue(result["signature_threshold_met"])
        self.assertEqual(result["scoped_event_count"], 1)
        self.assertIn("external_effect_inventory_unverified",
                      result["unresolved_scoped_evidence"])
        for key in ("hCoverage_proved", "hMeaning_proved",
                    "independent_custody_verified",
                    "universal_physical_protection_proved",
                    "authorizes_effect", "may_clear_hold", "may_merge_or_deploy"):
            self.assertFalse(result[key])

    def test_no_signatures_cannot_qualify_as_quorum(self):
        raw, cert = self.bundle(signers=())
        result = self.check(raw, cert)
        self.assertEqual(result["status"], "BLOCKED_NO_SIGNED_QUORUM")
        self.assertIn("R4_signed_review_threshold_missing",
                      result["unresolved_scoped_evidence"])

    def test_event_bytes_changed_after_signing_are_rejected(self):
        raw, cert = self.bundle()
        with self.assertRaisesRegex(ValueError, "digest mismatch"):
            self.check(raw + b" ", cert)

    def test_unknown_effect_route_remains_open(self):
        packet = copy.deepcopy(self.packet)
        packet["events"][0]["effect_path"] = "unlisted-effect"
        raw, cert = self.bundle(packet=packet)
        result = self.check(raw, cert)
        self.assertIn("undeclared_effect_path:event-1:unlisted-effect",
                      result["unresolved_scoped_evidence"])
        self.assertFalse(result["hCoverage_proved"])

    def test_missing_original_six_duty_remains_open(self):
        packet = copy.deepcopy(self.packet)
        del packet["duties_by_event"]["event-1"]["subject-1"]["provenance"]
        raw, cert = self.bundle(packet=packet)
        result = self.check(raw, cert)
        self.assertIn("unresolved:event-1:subject-1:provenance",
                      result["unresolved_scoped_evidence"])
        self.assertFalse(result["hMeaning_proved"])

    def test_independently_pinned_roster_rejects_substitution(self):
        raw, cert = self.bundle()
        with self.assertRaisesRegex(ValueError, "independent roster pin mismatch"):
            self.check(raw, cert, independently_pinned_roster_sha256="0" * 64)

    def test_different_source_commit_rejected(self):
        raw, cert = self.bundle()
        with self.assertRaisesRegex(ValueError, "source commit"):
            self.check(raw, cert, expected_commit="f" * 40)

    def test_forged_signer_rejected(self):
        raw, cert = self.bundle()
        record = json.loads(cert)
        record["signatures"][0]["signature"] = "00" * 64
        with self.assertRaisesRegex(ValueError, "signature verification failed"):
            self.check(raw, json.dumps(record).encode())


if __name__ == "__main__":
    unittest.main()
