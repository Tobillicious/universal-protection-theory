"""Offline R7 exact-head receipt negative controls; no network or authorization."""
import unittest
from g3_exact_head_ci_gate import REQUIRED, inspect

HEAD = "a" * 40


def packet():
    return {
        "head_sha": HEAD,
        "workflow_runs": [
            {"name": name, "head_sha": HEAD,
             "status": "completed", "conclusion": "success", "id": i + 1}
            for i, name in enumerate(sorted(REQUIRED))
        ],
    }


class ExactHeadCIGateTests(unittest.TestCase):
    def test_six_unique_exact_head_successes(self):
        self.assertEqual(inspect(packet()), (True, []))

    def test_wrong_sha_rejected(self):
        p = packet()
        p["workflow_runs"][0]["head_sha"] = "b" * 40
        self.assertFalse(inspect(p)[0])

    def test_missing_workflow_rejected(self):
        p = packet()
        p["workflow_runs"].pop()
        self.assertFalse(inspect(p)[0])

    def test_duplicate_workflow_rejected_even_if_six_green(self):
        p = packet()
        p["workflow_runs"].append(dict(p["workflow_runs"][0], id=999))
        self.assertFalse(inspect(p)[0])

    def test_duplicate_run_id_across_different_workflows_rejected(self):
        p = packet()
        p["workflow_runs"][1]["id"] = p["workflow_runs"][0]["id"]
        self.assertFalse(inspect(p)[0])

    def test_in_progress_or_failed_rejected(self):
        for status, outcome in [("in_progress", None),
                                ("completed", "failure"),
                                ("completed", "cancelled")]:
            p = packet()
            p["workflow_runs"][0]["status"] = status
            p["workflow_runs"][0]["conclusion"] = outcome
            self.assertFalse(inspect(p)[0])

    def test_bad_or_ambiguous_schema_rejected(self):
        p = packet()
        p["workflow_runs"][0]["proof_of_G3"] = True
        self.assertFalse(inspect(p)[0])
        p = packet()
        p["workflow_runs"][0]["id"] = True
        self.assertFalse(inspect(p)[0])


if __name__ == "__main__":
    unittest.main()
