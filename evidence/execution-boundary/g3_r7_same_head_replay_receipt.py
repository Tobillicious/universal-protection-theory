"""Non-certifying R7 replay receipt for a pinned disposable Linux CI run.

Binds observed unittest success, source bytes and exact git HEAD. CI reports
are not independent reviewer signatures, off-host custody, or subject evidence.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import re
import subprocess

EVIDENCE_DIR = "evidence/execution-boundary"
# Fields whose value is fixed by construction rather than measured by this
# run. Listed in the receipt so no reader mistakes them for observations.
FIXED_BY_CONSTRUCTION = (
    "repeated_R4_fixture_executions",  # duplicates are rejected outright
    "unique_test_case_count",          # equals test_count for the same reason
    "research_suite_executed",
    "forest_six_duty_gap_checks_executed",
    "r5_alternative_effect_channel_tests_executed",
)

REQUIRED_TEST_MODULES = frozenset((
    "test_koru_operator_surviving_rollback",
    "test_koru_operator_all_stores_rollback_contrast",
    "test_koru_operator_post_recovery_recheck",
    "test_koru_r5_post_connect_kernel_fence",
    "test_koru_r5_kernel_denial_evidence",
    "test_koru_r6_marker_readonly_observer",
    "test_koru_r5_forest_coverage_audit",
    "test_koru_r5_residual_unix_ipc",
    "test_koru_r5_process_creation_fence",
    "test_koru_r5_socket_family_fence",
    "test_koru_no_inherited_fd_executor",
    "test_koru_fixed_workload_contract",
))
CASE = re.compile(r"^(test_[A-Za-z0-9_]+) \((test_[A-Za-z0-9_]+\.[A-Za-z0-9_.]+)\) \.\.\. (ok|FAIL|ERROR|skipped.*|expected failure|unexpected success)$")

WATCH = (
    "koru_operator_checkpoint_recovery.py",
    "koru_operator_checkpoint_custodian.py",
    "koru_operator_checkpoint_mtls.py",
    "koru_no_inherited_fd_executor.py",
    "koru_seccomp_fd_receive_fence.py",
    "koru_r5_kernel_denial_evidence.py",
    "koru_r6_marker_readonly_observer.py",
    "test_koru_r6_marker_readonly_observer.py",
    "koru_r5_forest_coverage_audit.py",
    "test_koru_r5_forest_coverage_audit.py",
    "test_koru_r5_residual_unix_ipc.py",
    "test_koru_r5_process_creation_fence.py",
    "test_koru_r5_socket_family_fence.py",
    "test_koru_no_inherited_fd_executor.py",
    "koru_fixed_workload_contract.py",
    "test_koru_fixed_workload_contract.py",
)
# Every required test module is itself part of the reviewed evidence input.
# Do not allow future required-suite additions to escape source fingerprinting.
WATCH = tuple(sorted(set(WATCH) | {name + ".py" for name in REQUIRED_TEST_MODULES}
                     | {"g3_r7_same_head_replay_receipt.py",
                        "test_g3_r7_same_head_replay_receipt.py"}))

def inspect(*, log, checkout, expected_sha):
    if not isinstance(expected_sha, str) or re.fullmatch(r"[0-9a-f]{40}", expected_sha) is None:
        raise ValueError("invalid exact commit")
    root = Path(checkout).resolve(strict=True)
    actual = subprocess.run(
        ["git", "-C", str(root), "rev-parse", "HEAD"],
        capture_output=True, text=True, check=True).stdout.strip()
    if actual != expected_sha:
        raise ValueError("tested checkout does not match exact commit")
    lines = Path(log).read_text(encoding="utf8").splitlines()
    summaries = [re.fullmatch(r"Ran ([0-9]+) tests? in ([0-9.]+)s", s.strip())
                 for s in lines]
    summaries = [s for s in summaries if s is not None]
    if len(summaries) != 1 or int(summaries[0].group(1)) < 1:
        raise ValueError("exactly one positive unittest summary required")
    if sum(s.strip() == "OK" for s in lines) != 1:
        raise ValueError("one unambiguous unittest OK required")
    if any(re.search(r"^(FAILED|ERROR:|FAIL:|Traceback \(most recent call last\))", s.strip()) for s in lines):
        raise ValueError("failure content in replay transcript")
    case_lines = [s.strip() for s in lines if s.strip().startswith("test_")]
    matches = [CASE.fullmatch(s) for s in case_lines]
    if (any(m is None or m.group(3) != "ok" for m in matches)
            or len(matches) != int(summaries[0].group(1))):
        raise ValueError("verbose test case count or outcome does not match summary")
    case_ids = [m.group(2) for m in matches]
    if any(not case_id.endswith("." + m.group(1)) for case_id, m in zip(case_ids, matches)):
        raise ValueError("test method identity mismatch")
    # Any repeated case makes the replay transcript ambiguous. The workflow
    # selects the imported rollback contrast class explicitly, so duplicate
    # discovery is no longer a permitted exception.
    if len(set(case_ids)) != len(case_ids):
        raise ValueError("duplicate unittest case identity")
    duplicate_executions = 0
    multiplicity = set(case_ids)
    tested_modules = {m.group(2).split(".", 1)[0] for m in matches}
    if not REQUIRED_TEST_MODULES <= tested_modules:
        raise ValueError("missing mandatory R4/R5/R6 test module")
    source_root = root / "evidence" / "execution-boundary"
    # Fingerprint every module that actually RAN, not only the mandatory list:
    # imported test classes (e.g. operator custodian/mTLS) execute under their
    # own module names and must not escape source binding.
    hashed = tuple(sorted(set(WATCH) | {m + ".py" for m in tested_modules}))
    checksums = {}
    for name in hashed:
        target = source_root / name
        if not target.is_file() or target.is_symlink():
            raise ValueError("source missing or symlink: " + name)
        checksums[name] = hashlib.sha256(target.read_bytes()).hexdigest()
    # A HEAD label alone does not bind edited working-tree files to Git.
    # Check the WHOLE evidence directory, not only fingerprinted files: the
    # tested code imports unlisted local modules (e.g. the child's Landlock
    # and FD-audit pieces, the authority service).
    watched_paths = [EVIDENCE_DIR + "/" + name for name in hashed]
    tree_check = subprocess.run(
        ["git", "-C", str(root), "diff", "--quiet", "HEAD", "--", EVIDENCE_DIR],
        capture_output=True, check=False)
    if tree_check.returncode != 0:
        raise ValueError("reviewed source does not match committed Git tree")
    # git diff ignores untracked files, and an untracked module can shadow
    # an import. Reject any untracked, non-ignored file in the directory.
    untracked = subprocess.run(
        ["git", "-C", str(root), "ls-files", "--others", "--exclude-standard",
         "--", EVIDENCE_DIR],
        capture_output=True, text=True, check=False)
    if untracked.returncode != 0 or untracked.stdout.strip():
        raise ValueError("untracked file in evidence directory")
    # git diff ignores untracked files. Require each reviewed file to be
    # present in the immutable Git index before accepting its SHA-256.
    tracked = subprocess.run(
        ["git", "-C", str(root), "ls-files", "--error-unmatch", "--", *watched_paths],
        capture_output=True, check=False)
    if tracked.returncode != 0:
        raise ValueError("reviewed source is not tracked by Git")
    return {
        "schema": "g3-r7-same-head-research-replay-v3",
        "working_tree_source_matches_commit": True,
        "tree_clean_scope": EVIDENCE_DIR + " (tracked changes and untracked files)",
        "source_commit": actual,
        "test_count": len(matches),
        "unique_test_case_count": len(multiplicity),
        "repeated_R4_fixture_executions": duplicate_executions,
        "test_case_identity_sha256": hashlib.sha256("\n".join(sorted(case_ids)).encode()).hexdigest(),
        # The IDs themselves, so the digest above is recomputable from this
        # receipt alone without uploading the raw (possibly noisy) log.
        "test_case_ids": sorted(case_ids),
        "replay_log_sha256": hashlib.sha256(Path(log).read_bytes()).hexdigest(),
        "runtime": {
            "python": platform.python_version(),
            "kernel_release": platform.release(),
            "machine": platform.machine(),
        },
        "ci_run_id": os.environ.get("GITHUB_RUN_ID"),
        "ci_workflow_ref": os.environ.get("GITHUB_WORKFLOW_REF"),
        "fields_fixed_by_construction": list(FIXED_BY_CONSTRUCTION),
        "covered_test_modules": sorted(tested_modules),
        "tested_source_sha256": checksums,
        "research_suite_executed": True,
        "forest_six_duty_gap_checks_executed": True,
        "r5_alternative_effect_channel_tests_executed": True,
        "r4_independently_administered_custody_verified": False,
        "r5_all_actual_effects_covered": False,
        "r6_authentic_six_reflections_verified": False,
        "r7_independent_reviewer_accepted": False,
        "certified_for_production": False,
        "universal_physical_protection_proved": False,
        "authorizes_effect": False,
    }

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--log", type=Path, required=True)
    ap.add_argument("--checkout", type=Path, required=True)
    ap.add_argument("--sha", required=True)
    ap.add_argument("--output", type=Path, required=True)
    args = ap.parse_args()
    result = inspect(log=args.log, checkout=args.checkout, expected_sha=args.sha)
    args.output.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n")
    print("R7 bounded same-head replay receipt: " + str(result["test_count"]) + " tests")
    
if __name__ == "__main__":
    main()
