"""Adversarial exact-head replay receipt checks; never grants release authority."""
from pathlib import Path
from tempfile import TemporaryDirectory
from unittest.mock import patch
import unittest

from g3_r7_same_head_replay_receipt import WATCH, REQUIRED_TEST_MODULES, inspect

SHA = "a" * 40

class ExactHeadReplayReceiptTests(unittest.TestCase):
    def setUp(self):
        self.temp = TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        modules = self.root / "evidence" / "execution-boundary"
        modules.mkdir(parents=True)
        for name in WATCH:
            (modules / name).write_text("reviewed source " + name)
        self.log = self.root / "replay.txt"
        self.cases = [
            "test_case_%d (%s.Case.test_case_%d) ... ok" % (i, module, i)
            for i, module in enumerate(sorted(REQUIRED_TEST_MODULES))
        ]
        self.rewrite(self.cases)

    def rewrite(self, cases, *, count=None, status="OK"):
        total = len(cases) if count is None else count
        self.log.write_text("\n".join(cases) + "\n\nRan %d tests in 0.1s\n\n%s\n" % (total, status))

    def check(self, sha=SHA, *, tree_clean=True, tracked=True, untracked=""):
        def fake_git(argv, **kwargs):
            from subprocess import CompletedProcess
            if argv[3:5] == ["rev-parse", "HEAD"]:
                return CompletedProcess(argv, 0, SHA + "\n", "")
            if argv[3:5] == ["diff", "--quiet"]:
                return CompletedProcess(argv, 0 if tree_clean else 1, b"", b"")
            if argv[3:5] == ["ls-files", "--others"]:
                return CompletedProcess(argv, 0, untracked, "")
            if argv[3:5] == ["ls-files", "--error-unmatch"]:
                return CompletedProcess(argv, 0 if tracked else 1, b"", b"")
            raise AssertionError("unexpected git command in R7 fixture")
        with patch("g3_r7_same_head_replay_receipt.subprocess.run", side_effect=fake_git):
            return inspect(log=self.log, checkout=self.root, expected_sha=sha)

    def test_untracked_watched_source_rejected(self):
        with self.assertRaisesRegex(ValueError, "not tracked"):
            self.check(tracked=False)

    def test_modified_git_tree_rejected(self):
        with self.assertRaisesRegex(ValueError, "committed Git tree"):
            self.check(tree_clean=False)

    def test_receipt_verifier_and_its_tests_are_source_fingerprinted(self):
        hashes = self.check()["tested_source_sha256"]
        self.assertIn("g3_r7_same_head_replay_receipt.py", hashes)
        self.assertIn("test_g3_r7_same_head_replay_receipt.py", hashes)

    def test_all_mandatory_test_modules_are_source_fingerprinted(self):
        record = self.check()
        for module in REQUIRED_TEST_MODULES:
            self.assertIn(module + ".py", WATCH)
            self.assertIn(module + ".py", record["tested_source_sha256"])

    def test_valid_replay_never_certifies(self):
        record = self.check()
        self.assertEqual(record["test_count"], len(REQUIRED_TEST_MODULES))
        self.assertEqual(set(record["covered_test_modules"]), REQUIRED_TEST_MODULES)
        self.assertEqual(len(record["tested_source_sha256"]), len(WATCH))
        self.assertEqual(len(record["test_case_identity_sha256"]), 64)
        for flag in ("r4_independently_administered_custody_verified",
                     "r5_all_actual_effects_covered",
                     "r6_authentic_six_reflections_verified",
                     "r7_independent_reviewer_accepted",
                     "certified_for_production", "universal_physical_protection_proved",
                     "authorizes_effect"):
            self.assertFalse(record[flag])

    def test_dirty_watched_source_rejected(self):
        with patch("g3_r7_same_head_replay_receipt.subprocess.run") as run:
            run.return_value.stdout = SHA + "\n"
            run.return_value.returncode = 1
            with self.assertRaisesRegex(ValueError, "committed Git tree"):
                inspect(log=self.log, checkout=self.root, expected_sha=SHA)

    def test_clean_watched_source_identity_recorded(self):
        self.assertIs(self.check()["working_tree_source_matches_commit"], True)

    def test_stale_head_rejected(self):
        with self.assertRaisesRegex(ValueError, "checkout"):
            self.check("b" * 40)

    def test_failed_replay_rejected(self):
        self.rewrite(self.cases, status="FAILED (failures=1)")
        with self.assertRaisesRegex(ValueError, "OK"):
            self.check()

    def test_success_with_hidden_traceback_rejected(self):
        self.log.write_text("ERROR: test\n" + self.log.read_text())
        with self.assertRaisesRegex(ValueError, "failure"):
            self.check()

    def test_ambiguous_duplicate_summary_rejected(self):
        self.log.write_text(self.log.read_text() + "\nRan 1 test in 0.1s\n")
        with self.assertRaisesRegex(ValueError, "summary"):
            self.check()

    def test_case_count_not_equal_summary_rejected(self):
        self.rewrite(self.cases, count=138)
        with self.assertRaisesRegex(ValueError, "case count"):
            self.check()

    def test_duplicate_case_identity_rejected(self):
        self.rewrite(self.cases + [self.cases[0]])
        with self.assertRaisesRegex(ValueError, "duplicate"):
            self.check()

    def test_imported_R4_fixture_duplicate_is_rejected(self):
        reused = ("test_same (test_koru_operator_surviving_rollback."
                  "SurvivingOperatorRollbackTests.test_same) ... ok")
        self.rewrite(self.cases + [reused, reused])
        with self.assertRaisesRegex(ValueError, "duplicate"):
            self.check()

    def test_three_R4_fixture_executions_also_rejected(self):
        reused = ("test_same (test_koru_operator_surviving_rollback."
                  "SurvivingOperatorRollbackTests.test_same) ... ok")
        self.rewrite(self.cases + [reused, reused, reused])
        with self.assertRaisesRegex(ValueError, "duplicate"):
            self.check()

    def test_skipped_test_rejected(self):
        changed = self.cases.copy()
        changed[0] = changed[0].replace("... ok", "... skipped 'not ready'")
        self.rewrite(changed)
        with self.assertRaisesRegex(ValueError, "outcome"):
            self.check()

    def test_missing_module_rejected(self):
        self.rewrite(self.cases[:-1])
        with self.assertRaisesRegex(ValueError, "mandatory"):
            self.check()

    def test_malformed_test_output_rejected(self):
        self.rewrite(self.cases[:-1] + ["test_case_X ... ok"])
        with self.assertRaisesRegex(ValueError, "outcome"):
            self.check()

    def test_symlinked_source_rejected(self):
        p = self.root / "evidence" / "execution-boundary" / WATCH[0]
        p.unlink()
        p.symlink_to(self.log)
        with self.assertRaisesRegex(ValueError, "symlink"):
            self.check()

    def test_invalid_sha_rejected(self):
        with self.assertRaisesRegex(ValueError, "exact commit"):
            self.check("not-a-commit")

    # --- binding gaps found in the 8493dab4 receipt audit -------------------

    def _with_extra_module(self, module, *, create=True):
        if create:
            (self.root / "evidence" / "execution-boundary" / (module + ".py")).write_text(
                "imported test class source")
        extra = "test_extra (%s.Imported.test_extra) ... ok" % module
        self.rewrite(self.cases + [extra])

    def test_module_that_ran_but_is_not_mandatory_is_fingerprinted(self):
        # e.g. operator custodian/mTLS classes imported into rollback tests.
        module = "test_koru_operator_checkpoint_custodian"
        self.assertNotIn(module, REQUIRED_TEST_MODULES)
        self._with_extra_module(module)
        record = self.check()
        self.assertIn(module, record["covered_test_modules"])
        self.assertIn(module + ".py", record["tested_source_sha256"])

    def test_module_that_ran_without_reviewable_source_rejected(self):
        self._with_extra_module("test_koru_unlisted_ghost", create=False)
        with self.assertRaisesRegex(ValueError, "source missing"):
            self.check()

    def test_untracked_file_in_evidence_directory_rejected(self):
        # An untracked module could shadow an import of the tested code.
        with self.assertRaisesRegex(ValueError, "untracked"):
            self.check(untracked="evidence/execution-boundary/koru_shadow.py\n")

    def test_receipt_is_recomputable_and_records_runtime(self):
        import hashlib
        record = self.check()
        self.assertEqual(
            hashlib.sha256("\n".join(record["test_case_ids"]).encode()).hexdigest(),
            record["test_case_identity_sha256"])
        self.assertEqual(record["replay_log_sha256"],
                         hashlib.sha256(self.log.read_bytes()).hexdigest())
        self.assertEqual(set(record["runtime"]), {"python", "kernel_release", "machine"})
        self.assertIn("repeated_R4_fixture_executions", record["fields_fixed_by_construction"])

    def test_every_fingerprinted_source_triggers_the_replay_workflow(self):
        # A hashed file outside the trigger paths can change without the
        # replay rerunning, leaving a stale receipt that still looks valid.
        import re
        workflow = (Path(__file__).resolve().parents[2] / ".github" / "workflows"
                    / "g3-r4-r6-combined-evidence-replay.yml").read_text()
        paths = set(re.findall(r"- '([^']+)'", workflow.split("workflow_dispatch")[0]))
        missing = [n for n in WATCH if "evidence/execution-boundary/" + n not in paths]
        self.assertEqual(missing, [], "fingerprinted but not a workflow trigger")

if __name__ == "__main__":
    unittest.main()
