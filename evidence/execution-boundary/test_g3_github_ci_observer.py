"""Negative controls for GitHub-origin exact-head CI status observation."""
import unittest

from g3_exact_head_ci_gate import REQUIRED
from g3_github_ci_observer import observe

SHA = "f" * 40


def responses():
    return [
        {"name": name, "head_sha": SHA, "event": "pull_request",
         "status": "completed", "conclusion": "success", "id": n + 1}
        for n, name in enumerate(sorted(REQUIRED))
    ]


def run_with(rows):
    return observe(SHA, fetch=lambda head, page: rows if page == 1 else [])


class GitHubCIEvidenceTests(unittest.TestCase):
    def test_observed_all_six_green(self):
        result = run_with(responses())
        self.assertTrue(result["ok"], result)
        self.assertEqual(result["R4_independent_custody"], "UNASSESSED")
        self.assertEqual(result["R6_authentic_actual_effects"], "UNASSESSED")

    def test_wrong_head_and_false_green_do_not_pass(self):
        for key, value in [
            ("head_sha", "e" * 40),
            ("conclusion", "failure"),
            ("status", "in_progress"),
            ("id", True)
        ]:
            rows = responses()
            rows[0][key] = value
            with self.subTest(key=key):
                self.assertFalse(run_with(rows)["ok"])

    def test_duplicate_and_missing_run_refused(self):
        self.assertFalse(run_with(responses()[:-1])["ok"])
        rows = responses()
        rows.append(dict(rows[0], id=900))
        self.assertFalse(run_with(rows)["ok"])

    def test_non_pull_request_runs_cannot_substitute(self):
        rows = responses()
        rows[0]["event"] = "workflow_dispatch"
        self.assertFalse(run_with(rows)["ok"])

    def test_api_unavailable_and_malformed_fail_closed(self):
        def offline(head, page):
            raise OSError("not connected")
        self.assertFalse(observe(SHA, fetch=offline)["ok"])
        self.assertFalse(run_with([{"name": "Physical bridge proofs"}])["ok"])
        self.assertFalse(observe("not-a-commit")["ok"])

    def test_multiple_pages_observed(self):
        rows = responses()
        filler = [
            {"name": "unrelated", "head_sha": SHA, "event": "pull_request",
             "status": "completed", "conclusion": "success", "id": 100 + i}
            for i in range(94)
        ]
        def paged(head, page):
            return rows[:3] + filler[:97] if page == 1 else (
                rows[3:] if page == 2 else [])
        result = observe(SHA, fetch=paged)
        self.assertTrue(result["ok"], result)


if __name__ == "__main__":
    unittest.main()
