"""Adversarial R5/R6 real evidence handoff tests; synthetic fixtures only."""
import copy
import io
import tempfile
from pathlib import Path
from contextlib import redirect_stdout
import hashlib
import json
import unittest
from datetime import datetime, timezone

from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey

from g3_r6_same_event_evidence_audit import SIX
from g3_real_effect_inventory_handoff import BYPASS, inspect, inspect_signed, main
from g3_r7_external_review_signature import DOMAIN

HEAD = "a" * 40


class RealInventoryHandoffTests(unittest.TestCase):
    def setUp(self):
        self.packet = {
            "schema": "g3-r6-zelda-observed-events-v1", "source_commit": HEAD,
            "scope": "synthetic reviewed fixed marker",
            "declared_paths": ["marker"],
            "events": [{"event_id": "e1", "effect_path": "marker",
                        "before_sha256": "b" * 64, "after_sha256": "c" * 64,
                        "observer_ref": "observer", "actor_ref": "actor"}],
            "owed_by_event": {"e1": ["subject"]},
            "duties_by_event": {"e1": {"subject": {
                duty: {"status": "supported", "evidence_ref": "e1-subject-" + duty}
                for duty in SIX}}},
        }
        self.inventory = {
            "schema": "g3-r5-physical-inventory-v1",
            "source_commit": HEAD, "scope": self.packet["scope"],
            "observed_event_ids": ["e1"], "effect_paths": ["marker"],
            "examined_bypass_classes": sorted(BYPASS),
            "unexamined_bypass_classes": [], "observer_ref": "synthetic-auditor",
        }

    def check(self, packet=None, inventory=None):
        return inspect(
            event_bytes=json.dumps(self.packet if packet is None else packet).encode(),
            inventory_bytes=json.dumps(self.inventory if inventory is None else inventory).encode(),
            expected_commit=HEAD)

    def test_complete_synthetic_inventory_is_still_not_physical_proof(self):
        result = self.check()
        self.assertIn("external_effect_inventory_unverified", result["unresolved"])
        for name in ("independent_custody_verified", "hCoverage_proved",
                     "hMeaning_proved", "universal_physical_protection_proved",
                     "authorizes_effect", "may_clear_hold", "may_merge_or_deploy"):
            self.assertFalse(result[name])

    def test_unknown_effect_path_detected(self):
        inventory = copy.deepcopy(self.inventory)
        inventory["effect_paths"] = ["different-writer"]
        self.assertIn("R5_R6_effect_paths_disagree",
                      self.check(inventory=inventory)["unresolved"])

    def test_missing_event_detected(self):
        inventory = copy.deepcopy(self.inventory)
        inventory["observed_event_ids"] = []
        self.assertIn("R5_R6_event_ids_disagree", self.check(inventory=inventory)["unresolved"])

    def test_unexamined_bypass_stays_open(self):
        inventory = copy.deepcopy(self.inventory)
        inventory["examined_bypass_classes"].remove("privileged_host_admin")
        inventory["unexamined_bypass_classes"].append("privileged_host_admin")
        self.assertIn("bypass_class_unexamined:privileged_host_admin",
                      self.check(inventory=inventory)["unresolved"])

    def test_omitted_bypass_stays_open(self):
        inventory = copy.deepcopy(self.inventory)
        inventory["examined_bypass_classes"].remove("network_sockets")
        self.assertIn("bypass_class_unaccounted:network_sockets",
                      self.check(inventory=inventory)["unresolved"])

    def test_duplicate_field_and_mismatched_source_rejected(self):
        raw = json.dumps(self.inventory).encode()
        packet = json.dumps(self.packet).encode()
        with self.assertRaisesRegex(ValueError, "duplicate"):
            inspect(event_bytes=packet, inventory_bytes=raw[:-1] + b', "scope": "fake"}',
                    expected_commit=HEAD)
        inventory = copy.deepcopy(self.inventory)
        inventory["source_commit"] = "f" * 40
        with self.assertRaisesRegex(ValueError, "source/scope"):
            self.check(inventory=inventory)

    def test_r7_signature_binds_both_exact_input_files(self):
        key = Ed25519PrivateKey.generate()
        pub = key.public_key().public_bytes(
            encoding=serialization.Encoding.Raw,
            format=serialization.PublicFormat.Raw)
        packet = json.dumps(self.packet).encode()
        inv = json.dumps(self.inventory).encode()
        report = inspect(event_bytes=packet, inventory_bytes=inv, expected_commit=HEAD)
        review = {"schema": "g3-r7-external-review-v1",
                  "source_commit": HEAD,
                  "evidence_sha256": report["joint_evidence_sha256"],
                  "scope": self.packet["scope"], "decision": "HOLD_UNRESOLVED",
                  "reviewer_identifier": "synthetic-reviewer",
                  "reviewed_at_utc": "2026-11-18T00:00:00Z",
                  "findings": "synthetic independent review test; no real witness"}
        review_raw = json.dumps(review).encode()
        signature = key.sign(DOMAIN + review_raw)
        signed = inspect_signed(
            event_bytes=packet, inventory_bytes=inv, expected_commit=HEAD,
            review_bytes=review_raw, review_signature=signature,
            pinned_reviewer_public_key=pub)
        self.assertTrue(signed["detached_review_signature_verified"])
        self.assertFalse(signed["universal_physical_protection_proved"])
        with self.assertRaisesRegex(ValueError, "review does not match"):
            inspect_signed(
                event_bytes=packet,
                inventory_bytes=inv + b" ",
                expected_commit=HEAD, review_bytes=review_raw,
                review_signature=signature, pinned_reviewer_public_key=pub)



    def test_cli_reads_real_file_bytes_without_effects(self):
        with tempfile.TemporaryDirectory() as temp:
            folder = Path(temp)
            event = folder / "event.json"
            inventory = folder / "inventory.json"
            event.write_text(json.dumps(self.packet))
            inventory.write_text(json.dumps(self.inventory))
            output = io.StringIO()
            with redirect_stdout(output):
                code = main(["--event-packet", str(event),
                             "--effect-inventory", str(inventory),
                             "--expected-commit", HEAD])
            self.assertEqual(code, 0)
            report = json.loads(output.getvalue())
            self.assertEqual(report["source_commit"], HEAD)
            self.assertFalse(report["detached_review_signature_verified"])
            self.assertFalse(report["universal_physical_protection_proved"])
            self.assertFalse(report["may_clear_hold"])
            # Changing independently pinned source must never be accepted.
            with self.assertRaises(SystemExit):
                main(["--event-packet", str(event),
                      "--effect-inventory", str(inventory),
                      "--expected-commit", "f" * 40])

    def test_cli_rejects_symlink_and_partial_reviewer_credentials(self):
        with tempfile.TemporaryDirectory() as temp:
            folder = Path(temp)
            event = folder / "event.json"
            inventory = folder / "inventory.json"
            event.write_text(json.dumps(self.packet))
            inventory.write_text(json.dumps(self.inventory))
            link = folder / "event-link"
            link.symlink_to(event)
            with self.assertRaises(SystemExit):
                main(["--event-packet", str(link),
                      "--effect-inventory", str(inventory),
                      "--expected-commit", HEAD])
            with self.assertRaises(SystemExit):
                main(["--event-packet", str(event),
                      "--effect-inventory", str(inventory),
                      "--expected-commit", HEAD,
                      "--review", str(event)])

    def test_cli_external_signer_pin_cannot_be_supplied_by_packet(self):
        with tempfile.TemporaryDirectory() as temp:
            folder = Path(temp)
            event = folder / "event.json"
            inventory = folder / "inventory.json"
            review = folder / "review.json"
            keyfile = folder / "reviewer.key"
            sigfile = folder / "signature.hex"
            event.write_text(json.dumps(self.packet))
            inventory.write_text(json.dumps(self.inventory))
            digest = inspect(event_bytes=event.read_bytes(),
                             inventory_bytes=inventory.read_bytes(),
                             expected_commit=HEAD)["joint_evidence_sha256"]
            key = Ed25519PrivateKey.generate()
            public = key.public_key().public_bytes(
                encoding=serialization.Encoding.Raw,
                format=serialization.PublicFormat.Raw)
            review_body = {
                "schema": "g3-r7-external-review-v1",
                "source_commit": HEAD,
                "evidence_sha256": digest,
                "scope": self.packet["scope"],
                "decision": "HOLD_UNRESOLVED",
                "reviewer_identifier": "synthetic-reviewer",
                "reviewed_at_utc": "2026-11-18T00:00:00Z",
                "findings": "offline test only"}
            review.write_text(json.dumps(review_body))
            sigfile.write_text(key.sign(DOMAIN + review.read_bytes()).hex())
            keyfile.write_text(public.hex())
            flags = ["--event-packet", str(event),
                     "--effect-inventory", str(inventory),
                     "--expected-commit", HEAD,
                     "--review", str(review),
                     "--signature-hex-file", str(sigfile),
                     "--reviewer-pubkey-hex-file", str(keyfile),
                     "--pinned-reviewer-pubkey-sha256", hashlib.sha256(public).hexdigest()]
            output = io.StringIO()
            with redirect_stdout(output):
                self.assertEqual(main(flags), 0)
            result = json.loads(output.getvalue())
            self.assertTrue(result["detached_review_signature_verified"])
            self.assertFalse(result["universal_physical_protection_proved"])
            bad = flags.copy()
            bad[-1] = "0" * 64
            with self.assertRaises(SystemExit):
                main(bad)

if __name__ == "__main__":
    unittest.main()
