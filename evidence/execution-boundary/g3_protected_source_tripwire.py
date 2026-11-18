"""G3 protected-source tripwire. Non-deploying, non-authorizing.

The reference blobs come from reviewed #656 head 5b22e4d... and protect
critical authority, HOLD, launcher and evidence boundary files against
UNREVIEWED changes in the subsequent exact-head chain. To intentionally
upgrade the engine, update the pins in a separate reviewed PR and
independently validate the revised threat model. A pin is not security
or universal physical mediation by itself.
"""
from pathlib import Path
import argparse
import subprocess

ROOT = Path(__file__).resolve().parents[2]
PINNED = {
    "evidence/execution-boundary/koru_broker.py":
        "42c3a67361a92a24a939a50bb61137fa78aa071d",
    "evidence/execution-boundary/koru_separated_authority_service.py":
        "e4046747f51a74d1aac8750fcadd0a840403353a",
    "evidence/execution-boundary/koru_authority_owned_marker_service.py":
        "3b183a64b1f523eb01c84c2f09293e4c2e723010",
    "evidence/execution-boundary/koru_no_inherited_fd_executor.py":
        "e04fce79dc12a4c92761c383021aae1bbcad52fb",
    "evidence/execution-boundary/g3_guardian_node/service.py":
        "f0009466e2c3b6204b5bd3170e484790e18d4dec",
    "evidence/execution-boundary/koru_transactional_hold_witness.py":
        "5125f7992e6c18e72efbc50c1f90fb0789ad2422",
    "evidence/execution-boundary/koru_r5_forest_coverage_audit.py":
        "25154a35135b5435a71f78a07de50a37a0122c23",
}


def audit(root=ROOT):
    violations = []
    for rel, expected in PINNED.items():
        path = root / rel
        if path.is_symlink() or not path.is_file():
            violations.append("missing_or_symlinked:" + rel)
            continue
        got = subprocess.run(
            ["git", "hash-object", "--", str(path)],
            check=True, capture_output=True, text=True,
        ).stdout.strip()
        if got != expected:
            violations.append("protected_source_drift:" + rel)
    return sorted(violations)


if __name__ == "__main__":
    p = argparse.ArgumentParser(description="G3 critical-source tripwire, no effects")
    p.add_argument("--root", type=Path, default=ROOT)
    args = p.parse_args()
    errors = audit(args.root)
    if errors:
        print("G3 PROTECTED SOURCE HOLD: " + ", ".join(errors))
        raise SystemExit(1)
    print(f"G3 protected-source pins match: {len(PINNED)} files. Scope still bounded.")
