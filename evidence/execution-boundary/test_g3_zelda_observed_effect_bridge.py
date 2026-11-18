"""Adversarial tests for the non-authorizing Zelda actual-effect bridge."""
import copy
import json
from pathlib import Path
import unittest
from g3_zelda_observed_effect_bridge import inspect

HERE = Path(__file__).resolve().parent
OBSERVATION = HERE / "g3_guardian_node" / "live-observation-2026-11-18.json"


class ZeldaObservedEffectBridgeTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.original = json.loads(OBSERVATION.read_text())

    def audit(self, item=None):
        return inspect(json.dumps(self.original if item is None else item).encode())

    def test_recorded_zela_trace_reconciles_without_promotion(self):
        outcome = self.audit()
        self.assertEqual(outcome["status"], "SCOPED_TRACE_RECONCILED_NOT_UNIVERSAL")
        self.assertTrue(outcome["hold_generation_2_retained_after_restart"])
        self.assertTrue(outcome["marker_identity_retained"])
        self.assertTrue(outcome["post_restart_denial_observed"])
        for name in ("hCoverage_proved", "hMeaning_proved", "all_actual_effects_covered",
                     "unconditional_universal_protection", "authorizes_effect",
                     "certified_for_production"):
            self.assertFalse(outcome[name])
        self.assertGreaterEqual(len(outcome["unresolved"]), 5)

    def test_changed_marker_inode_rejected(self):
        item = copy.deepcopy(self.original)
        item["post_restart_request"]["node"]["marker"]["inode"] += 1
        with self.assertRaisesRegex(ValueError, "marker identity changed"):
            self.audit(item)

    def test_missing_observed_stage_rejected(self):
        item = copy.deepcopy(self.original)
        del item["hold_request"]
        with self.assertRaisesRegex(ValueError, "missing observed stage"):
            self.audit(item)

    def test_false_hold_history_rejected(self):
        item = copy.deepcopy(self.original)
        item["restarted_status"]["held"] = False
        with self.assertRaisesRegex(ValueError, "HOLD history changed"):
            self.audit(item)

    def test_false_successful_repeat_rejected(self):
        item = copy.deepcopy(self.original)
        item["repeated_request"]["result"]["ok"] = True
        with self.assertRaisesRegex(ValueError, "repeat denial"):
            self.audit(item)

    def test_false_independent_custody_rejected(self):
        item = copy.deepcopy(self.original)
        item["restarted_status"]["independent_custody_verified"] = True
        with self.assertRaisesRegex(ValueError, "trust boundary mismatch"):
            self.audit(item)

    def test_universal_claim_flag_rejected(self):
        item = copy.deepcopy(self.original)
        item["claim_flags"]["all_actual_effects_covered"] = True
        with self.assertRaisesRegex(ValueError, "unsupported universal"):
            self.audit(item)

    def test_engine_digest_mismatch_rejected(self):
        item = copy.deepcopy(self.original)
        item["bundle_sha256"] = "0" * 64
        with self.assertRaisesRegex(ValueError, "engine source or bundle"):
            self.audit(item)

    def test_different_source_uid_rejected(self):
        item = copy.deepcopy(self.original)
        item["first_effect"]["node"]["authority_uid"] = 0
        with self.assertRaisesRegex(ValueError, "trust boundary mismatch"):
            self.audit(item)

    def test_unisolated_hold_first_cannot_be_claimed(self):
        item = copy.deepcopy(self.original)
        item["post_hold_denial_is_isolated_hold_first_control"] = True
        with self.assertRaisesRegex(ValueError, "HOLD-first"):
            self.audit(item)

    def test_duplicate_json_key_rejected(self):
        raw = OBSERVATION.read_bytes().rstrip()
        raw = raw[:-1] + b', "schema": "g3-zelda-local-live-observation-v1"}'
        with self.assertRaisesRegex(ValueError, "duplicate JSON"):
            inspect(raw)

    def test_empty_and_oversize_rejected(self):
        for raw in (b"", b" " * (1024 * 1024 + 1)):
            with self.subTest(length=len(raw)):
                with self.assertRaisesRegex(ValueError, "missing or oversized"):
                    inspect(raw)

    def test_missing_marker_or_unexpected_link_rejected(self):
        for key, value in (("exists", False), ("nlink", 2)):
            with self.subTest(key=key):
                item = copy.deepcopy(self.original)
                for stage in ("first_effect", "repeated_request", "hold_request",
                              "post_restart_request"):
                    item[stage]["node"]["marker"][key] = value
                item["restarted_status"]["marker"][key] = value
                with self.assertRaisesRegex(ValueError, "marker shape"):
                    self.audit(item)


if __name__ == "__main__":
    unittest.main()
