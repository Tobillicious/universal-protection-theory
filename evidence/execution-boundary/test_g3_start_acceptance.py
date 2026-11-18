"""G3 stage-zero hostile acceptance tests; no operational actuation."""
import unittest
from pathlib import Path
from g3_start_acceptance import evaluate, RECORD, OPEN_GATES


class G3StageZeroAcceptanceTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.raw = RECORD.read_bytes()

    def test_real_historical_fixture_starts_acceptance_not_deployment(self):
        report = evaluate(self.raw)
        self.assertEqual(report["status"],
                         "BOUNDED_EVIDENCE_VERIFIED_EXTERNAL_GATES_OPEN")
        self.assertEqual(report["acceptance_stage"], "EVIDENCE_REVIEW_STARTED")
        self.assertTrue(report["historical_trace_reconciled"])
        self.assertTrue(report["source_pins_match"])
        self.assertEqual(set(report["open_gates"]), set(OPEN_GATES))
        for key in ("ready_for_universal_physical_protection",
                    "authorizes_effect", "may_clear_hold", "may_merge_or_deploy",
                    "hCoverage_proved", "hMeaning_proved"):
            self.assertIs(report[key], False)

    def test_drift_blocks_even_when_historical_trace_is_good(self):
        r = evaluate(self.raw, source_audit=lambda: ["protected_source_drift:broker"])
        self.assertEqual(r["status"], "BLOCKED_SOURCE_DRIFT")
        self.assertFalse(r["source_pins_match"])
        self.assertFalse(r["may_clear_hold"])

    def test_corrupt_observation_is_not_accepted(self):
        with self.assertRaises(ValueError):
            evaluate(b'{"schema":"invented"}', source_audit=lambda: [])

    def test_no_unverified_gate_can_be_closed_by_input(self):
        report = evaluate(self.raw, source_audit=lambda: [])
        self.assertEqual(len(report["open_gates"]), 5)
        self.assertFalse(report["ready_for_universal_physical_protection"])

    def test_unexpected_source_audit_type_rejected(self):
        with self.assertRaises(ValueError):
            evaluate(self.raw, source_audit=lambda: True)


if __name__ == "__main__":
    unittest.main()
