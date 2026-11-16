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
    command = workflow.split('"$PYTHON_BIN" -B -m unittest -v', 1)
    if len(command) != 2:
        raise ValueError("Linux CI unittest invocation missing")
    invoked = set(re.findall(r"\btest_koru_[a-z0-9_]+\b", command[1]))
    missing = sorted(tests - invoked)
    if missing:
        raise ValueError("manifest tests absent from Linux CI: " + ", ".join(missing))
    return True


# New R4 regressions reuse this existing manifest checker; they must remain
# executable on the same Linux CI head as original authority/HOLD tests.
R4_REQUIRED = frozenset({
    "test_koru_operator_checkpoint_recovery",
    "test_koru_operator_checkpoint_custodian",
    "test_koru_operator_checkpoint_mtls",
    "test_koru_operator_checkpoint_handshake_bounds",
    "test_koru_operator_surviving_rollback",
    "test_koru_operator_checkpoint_interleaving",
    "test_koru_operator_checkpoint_strict_wire",
    "test_koru_operator_all_stores_rollback_contrast",
    "test_koru_operator_post_recovery_recheck",
    "test_koru_custodian_authenticated_observation",
    "test_koru_operator_readonly_negative_controls",
    "test_koru_operator_bound_witness_reads",
})


def verify_r4_regression_invocation(workflow):
    """Check actual unittest arguments, not path-filter names or comments."""
    prefix = '"$PYTHON_BIN" -B -m unittest -v'
    if prefix not in workflow:
        raise ValueError("Linux CI unittest invocation missing")
    # Real workflow spans many lines: inspect until the next shell command
    # but stop at the first blank command boundary.
    lines = workflow.split(prefix, 1)[1].splitlines()
    invoked = set()
    for line in lines:
        stripped = line.strip()
        if stripped and not stripped.startswith("test_koru_") and stripped.endswith(chr(92)):
            continue
        if not stripped:
            break
        if stripped.startswith("test_koru_"):
            invoked.update(re.findall(r"\btest_koru_[a-z0-9_]+\b", stripped))
        elif stripped and not stripped.startswith("#"):
            break
    missing = sorted(R4_REQUIRED - invoked)
    if missing:
        raise ValueError("R4 regression absent from Linux CI: " + ", ".join(missing))
    return True


# R5 hostile controls must execute in the disposable Linux child, not merely
# appear as workflow path triggers. Keep the negative-control baselines as
# evidence of old bypasses; their presence is not a confinement certificate.
R5_REQUIRED = frozenset({
    "test_koru_r5_residual_unix_ipc",
    "test_koru_r5_other_unix_destination",
    "test_koru_r5_same_uid_peer_impersonation",
    "test_koru_r5_observed_authority_process_peer",
    "test_koru_r5_post_connect_kernel_fence",
})


def verify_r5_regression_invocation(workflow):
    """Require actual unittest invocation of the assembled R5 hostile controls."""
    prefix = '"$PYTHON_BIN" -B -m unittest -v'
    if prefix not in workflow:
        raise ValueError("Linux CI unittest invocation missing")
    invoked = set()
    for line in workflow.split(prefix, 1)[1].splitlines():
        stripped = line.strip()
        if not stripped:
            break
        if stripped.startswith("test_koru_"):
            invoked.update(re.findall(r"\btest_koru_[a-z0-9_]+\b", stripped))
        elif stripped.startswith("#") or stripped.endswith(chr(92)):
            continue
        else:
            break
    missing = sorted(R5_REQUIRED - invoked)
    if missing:
        raise ValueError("R5 regression absent from Linux CI: " + ", ".join(missing))
    return True


class G3IntegrationManifestTests(unittest.TestCase):
    def test_r5_hostile_modules_registered_on_linux_ci(self):
        self.assertTrue(verify_r5_regression_invocation(WORKFLOW.read_text()))

    def test_removing_r5_post_connect_negative_control_is_rejected(self):
        workflow = WORKFLOW.read_text()
        target = "            test_koru_r5_post_connect_kernel_fence"
        self.assertIn(target, workflow)
        changed = workflow.replace(target, "            test_koru_removed_post_connect")
        with self.assertRaisesRegex(ValueError, "R5 regression absent"):
            verify_r5_regression_invocation(changed)

    def test_r4_regression_modules_registered_on_linux_ci(self):
        self.assertTrue(verify_r4_regression_invocation(WORKFLOW.read_text()))

    def test_removing_r4_rollback_negative_control_is_rejected(self):
        workflow = WORKFLOW.read_text()
        target = "            test_koru_operator_all_stores_rollback_contrast"
        self.assertIn(target, workflow)
        changed = workflow.replace(target, "            test_koru_removed_all_stores")
        with self.assertRaisesRegex(ValueError, "R4 regression absent"):
            verify_r4_regression_invocation(changed)

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
