"""Synthetic negative controls for the non-authorizing quorum checker.

Keys are ephemeral and generated only inside tests; never registered as
independent guardians or used to sign live custody/effect approvals.
"""
import hashlib
import tempfile
from pathlib import Path
import json
import unittest

from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey
from g3_quorum_certificate_check import DOMAIN, verify, verify_files


class QuorumReviewTests(unittest.TestCase):
    def setUp(self):
        self.keys = [Ed25519PrivateKey.generate() for _ in range(4)]
        self.sha = "a" * 64
        self.roster = {
            "test-" + str(i): key.public_key().public_bytes(
                encoding=serialization.Encoding.Raw,
                format=serialization.PublicFormat.Raw).hex()
            for i, key in enumerate(self.keys)
        }
        roster_digest = hashlib.sha256(json.dumps(
            self.roster, sort_keys=True, separators=(",", ":")).encode()).hexdigest()
        self.statement = DOMAIN + json.dumps(
            {"record_sha256": self.sha, "epoch": 1,
             "roster_sha256": roster_digest},
            sort_keys=True, separators=(",", ":")).encode()
        self.data = {
            "schema": "g3-independent-review-quorum-v1",
            "record_sha256": self.sha,
            "epoch": 1,
            "fault_tolerance": 1,
            "roster": self.roster,
            "signatures": [],
        }

    def packed(self, data=None):
        return json.dumps(self.data if data is None else data).encode()

    def sign(self, i):
        return {"member": "test-" + str(i),
                "signature": self.keys[i].sign(self.statement).hex()}

    def test_empty_quorum_is_not_accepted(self):
        r = verify(self.packed(), expected_sha=self.sha, trusted_roster=self.roster)
        self.assertEqual(r["status"], "INSUFFICIENT_SIGNATURES")
        self.assertFalse(r["authorizes_effect"])
        self.assertFalse(r["independent_custody_verified"])

    def test_two_of_four_is_not_quorum(self):
        self.data["signatures"] = [self.sign(0), self.sign(1)]
        self.assertFalse(verify(self.packed(), expected_sha=self.sha, trusted_roster=self.roster)["cryptographic_threshold_met"])

    def test_three_of_four_is_only_cryptographic_quorum(self):
        self.data["signatures"] = [self.sign(i) for i in range(3)]
        r = verify(self.packed(), expected_sha=self.sha, trusted_roster=self.roster)
        self.assertTrue(r["cryptographic_threshold_met"])
        for key in ("independent_custody_verified", "hCoverage_proved",
                    "hMeaning_proved", "authorizes_effect",
                    "may_clear_hold", "universal_G3_proved"):
            self.assertFalse(r[key])

    def test_self_supplied_roster_is_not_trusted(self):
        independently_pinned = dict(self.roster)
        substitute = Ed25519PrivateKey.generate()
        self.data["roster"]["test-0"] = substitute.public_key().public_bytes(
            encoding=serialization.Encoding.Raw,
            format=serialization.PublicFormat.Raw).hex()
        with self.assertRaisesRegex(ValueError, "independently pinned roster"):
            verify(self.packed(), expected_sha=self.sha, trusted_roster=independently_pinned)

    def test_duplicate_signer_rejected(self):
        self.data["signatures"] = [self.sign(0), self.sign(0), self.sign(1)]
        with self.assertRaisesRegex(ValueError, "duplicate or unregistered"):
            verify(self.packed(), expected_sha=self.sha, trusted_roster=self.roster)

    def test_changed_evidence_digest_rejected(self):
        self.data["signatures"] = [self.sign(i) for i in range(3)]
        with self.assertRaisesRegex(ValueError, "digest mismatch"):
            verify(self.packed(), expected_sha="b" * 64, trusted_roster=self.roster)

    def test_forged_signature_rejected(self):
        forged = self.sign(0)
        forged["signature"] = self.sign(1)["signature"]
        self.data["signatures"] = [forged]
        with self.assertRaisesRegex(ValueError, "verification failed"):
            verify(self.packed(), expected_sha=self.sha, trusted_roster=self.roster)

    def test_wrong_size_roster_rejected(self):
        self.data["roster"].pop("test-3")
        with self.assertRaisesRegex(ValueError, r"3f\+1"):
            verify(self.packed(), expected_sha=self.sha, trusted_roster=self.roster)

    def test_duplicate_public_key_rejected(self):
        self.data["roster"]["test-3"] = self.data["roster"]["test-0"]
        with self.assertRaisesRegex(ValueError, "duplicate public"):
            verify(self.packed(), expected_sha=self.sha, trusted_roster=self.roster)

    def test_unknown_signer_rejected(self):
        item = self.sign(0)
        item["member"] = "not-registered"
        self.data["signatures"] = [item]
        with self.assertRaisesRegex(ValueError, "unregistered"):
            verify(self.packed(), expected_sha=self.sha, trusted_roster=self.roster)


    def test_external_roster_and_real_evidence_bytes_required(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory)
            evidence = path / "evidence.json"
            certificate = path / "certificate.json"
            roster_file = path / "reviewed-roster.json"
            evidence.write_bytes(b"distinct physical review evidence")
            digest = hashlib.sha256(evidence.read_bytes()).hexdigest()
            self.data["record_sha256"] = digest
            roster_file.write_text(json.dumps(self.roster))
            trusted_roster_digest = hashlib.sha256(json.dumps(
                self.roster, sort_keys=True, separators=(",", ":")).encode()).hexdigest()
            certificate.write_bytes(self.packed())
            result = verify_files(evidence_path=evidence, certificate_path=certificate,
                                  roster_path=roster_file,
                                  expected_roster_sha256=trusted_roster_digest)
            self.assertFalse(result["cryptographic_threshold_met"])
            self.assertFalse(result["universal_G3_proved"])
            with self.assertRaisesRegex(ValueError, "independent roster digest mismatch"):
                verify_files(evidence_path=evidence, certificate_path=certificate,
                             roster_path=roster_file, expected_roster_sha256="0" * 64)
            evidence.write_bytes(b"modified physical review evidence")
            with self.assertRaisesRegex(ValueError, "reviewed evidence digest mismatch"):
                verify_files(evidence_path=evidence, certificate_path=certificate,
                             roster_path=roster_file,
                             expected_roster_sha256=trusted_roster_digest)

    def test_duplicate_json_key_rejected(self):
        raw = self.packed()
        raw = raw[:-1] + b', "epoch": 1}'
        with self.assertRaisesRegex(ValueError, "duplicate JSON"):
            verify(raw, expected_sha=self.sha, trusted_roster=self.roster)


if __name__ == "__main__":
    unittest.main()
