"""Non-authorizing read-only Zelda packet handoff tests."""
import copy
import json
import unittest

from g3_r6_zelda_event_packet import inspect_packet, MAX_BYTES
from g3_r6_same_event_evidence_audit import SIX

HEAD = "a" * 40


class ZeldaPacketTests(unittest.TestCase):
    def setUp(self):
        self.packet = {
            "schema": "g3-r6-zelda-observed-events-v1",
            "source_commit": HEAD,
            "scope": "synthetic confined fixed-marker research process",
            "declared_paths": ["fixed-marker"],
            "events": [{
                "event_id": "e1",
                "effect_path": "fixed-marker",
                "before_sha256": "b" * 64,
                "after_sha256": "c" * 64,
                "observer_ref": "synthetic-observer",
                "actor_ref": "synthetic-actor",
            }],
            "owed_by_event": {"e1": ["synthetic-subject"]},
            "duties_by_event": {"e1": {"synthetic-subject": {
                tag: {"status": "supported",
                      "evidence_ref": "synthetic-e1-" + tag}
                for tag in SIX
            }}},
        }

    def check(self, packet=None, *, head=HEAD):
        data = self.packet if packet is None else packet
        return inspect_packet(json.dumps(data).encode(), expected_commit=head)

    def test_filled_packet_still_has_unresolved_independence(self):
        result = self.check()
        self.assertEqual(result["status"], "RESEARCH_GAPS")
        self.assertEqual(result["events_reconciled"], 1)
        self.assertIn("external_effect_inventory_unverified", result["unresolved"])
        self.assertIn("independent_observer_unverified", result["unresolved"])
        for field in ("hCoverage_proved", "hMeaning_proved",
                      "authentic_subjects_verified", "authorizes_effect",
                      "certified_for_production", "independence_self_certification_accepted"):
            self.assertFalse(result[field])

    def test_stale_source_head_rejected(self):
        with self.assertRaisesRegex(ValueError, "source commit"):
            self.check(head="d" * 40)

    def test_self_asserted_independence_rejected(self):
        packet = copy.deepcopy(self.packet)
        packet["independently_authenticated_observers"] = True
        with self.assertRaisesRegex(ValueError, "schema"):
            self.check(packet)

    def test_duplicate_json_keys_rejected(self):
        raw = json.dumps(self.packet).encode()
        raw = raw[:-1] + b',"scope":"another scope"}'
        with self.assertRaisesRegex(ValueError, "duplicate JSON"):
            inspect_packet(raw, expected_commit=HEAD)

    def test_event_path_outside_declared_scope_reported(self):
        packet = copy.deepcopy(self.packet)
        packet["events"][0]["effect_path"] = "unknown-channel"
        result = self.check(packet)
        self.assertIn("undeclared_effect_path:e1:unknown-channel", result["unresolved"])

    def test_duplicate_effect_path_claims_rejected(self):
        packet = copy.deepcopy(self.packet)
        packet["declared_paths"].append("fixed-marker")
        with self.assertRaisesRegex(ValueError, "duplicated"):
            self.check(packet)

    def test_empty_owed_list_rejected(self):
        packet = copy.deepcopy(self.packet)
        packet["owed_by_event"]["e1"] = []
        with self.assertRaisesRegex(ValueError, "nonempty"):
            self.check(packet)

    def test_missing_original_six_duty_detected(self):
        packet = copy.deepcopy(self.packet)
        del packet["duties_by_event"]["e1"]["synthetic-subject"]["authorization"]
        result = self.check(packet)
        self.assertIn("unresolved:e1:synthetic-subject:authorization",
                      result["unresolved"])

    def test_malformed_subject_ref_cannot_make_a_proof(self):
        packet = copy.deepcopy(self.packet)
        packet["duties_by_event"]["e1"]["synthetic-subject"]["authorization"] = True
        result = self.check(packet)
        self.assertIn("unresolved:e1:synthetic-subject:authorization",
                      result["unresolved"])

    def test_missing_before_after_evidence_reported(self):
        packet = copy.deepcopy(self.packet)
        packet["events"][0]["after_sha256"] = "garbage"
        result = self.check(packet)
        self.assertIn("missing_after_sha256:e1", result["unresolved"])

    def test_unknown_or_missing_schema_rejected(self):
        packet = copy.deepcopy(self.packet)
        packet["schema"] = "g3-production-accept"
        with self.assertRaisesRegex(ValueError, "version"):
            self.check(packet)

    def test_oversized_and_non_utf8_packet_rejected(self):
        with self.assertRaisesRegex(ValueError, "oversized"):
            inspect_packet(b" " * (MAX_BYTES + 1), expected_commit=HEAD)
        with self.assertRaisesRegex(ValueError, "invalid JSON"):
            inspect_packet(b"\xff", expected_commit=HEAD)

    def test_invalid_pinned_sha_rejected(self):
        with self.assertRaisesRegex(ValueError, "pinned Git"):
            self.check(head="not-a-commit")


if __name__ == "__main__":
    unittest.main()
