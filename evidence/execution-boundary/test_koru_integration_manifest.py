"""Machine-check that the G3 candidate's cited test modules run in Linux CI.

This catches accidental evidence-manifest/workflow divergence. It does not
certify test semantics, CI execution, executable identity or release status.
"""
import re
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
DOSSIER = HERE / "G3-INTEGRATED-RESEARCH-CANDIDATE.md"
WORKFLOW = HERE.parent.parent / ".github/workflows/g3-cross-uid-signed-hold-research.yml"


def referenced_tests(dossier):
    # Restrict to module names within the evidence table only.
    evidence = dossier.split("## Protection evidence matrix", 1)[1].split(
        "## Required release gates", 1)[0]
    return set(re.findall(r"`(test_koru_[a-z0-9_]+)`", evidence))


def verify_manifest(dossier, workflow):
    tests = referenced_tests(dossier)
    if len(tests) < 10:
        raise ValueError("missing manifest protection test entries")
    command = workflow.split("sudo --preserve-env=PATH PYTHONPATH=. python -B -m unittest -v", 1)
    if len(command) != 2:
        raise ValueError("Linux CI unittest invocation missing")
    invoked = set(re.findall(r"\btest_koru_[a-z0-9_]+\b", command[1]))
    missing = sorted(tests - invoked)
    if missing:
        raise ValueError("manifest tests absent from Linux CI: " + ", ".join(missing))
    return True


class G3IntegrationManifestTests(unittest.TestCase):
    def test_dossier_matches_checked_in_linux_ci(self):
        self.assertTrue(verify_manifest(DOSSIER.read_text(), WORKFLOW.read_text()))

    def test_removing_test_invocation_is_rejected(self):
        dossier = DOSSIER.read_text()
        workflow = WORKFLOW.read_text()
        changed = workflow.replace("            test_koru_emergency_hold_persistence", 
                                   "            test_koru_removed_persistence")
        self.assertNotEqual(changed, workflow)
        with self.assertRaisesRegex(ValueError, "absent from Linux CI"):
            verify_manifest(dossier, changed)

    def test_missing_manifest_entries_rejected(self):
        dossier = DOSSIER.read_text()
        reduced = dossier.replace("`test_koru_", "`removed_koru_")
        with self.assertRaisesRegex(ValueError, "missing manifest"):
            verify_manifest(reduced, WORKFLOW.read_text())


if __name__ == "__main__":
    unittest.main()
