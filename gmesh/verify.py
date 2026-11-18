"""Read-only bounded Zelda guardian source/status check.

A local HOLD/fingerprint check cannot establish mesh consensus, real R4
independent custody, complete R5/R6 actual-world effects or universal G3.
Strict *universal* physical certification is therefore fail-closed.
"""
import argparse
import json
from pathlib import Path
import subprocess
import sys

REPO_ROOT = Path(__file__).resolve().parent.parent


def verify_node(*, node_id, strict=False, root=REPO_ROOT, run=subprocess.run):
    if type(node_id) is not str or not node_id or len(node_id) > 200:
        raise ValueError("valid node identity required")
    for argv in (["./guardian-node", "check", "--json"],
                 ["./guardian-node", "status", "--json"]):
        result = run(argv, cwd=str(root), capture_output=True,
                     text=True, timeout=20, check=False)
        if result.returncode != 0:
            raise ValueError("guardian read-only check failed: " + argv[1])
        try:
            payload = json.loads(result.stdout)
        except (ValueError, TypeError) as exc:
            raise ValueError("guardian supplied invalid JSON: " + argv[1]) from exc
        if type(payload) is not dict:
            raise ValueError("guardian JSON must be an object")
        if argv[1] == "check":
            if payload.get("source_fingerprints_verified") is not True:
                raise ValueError("source integrity not positively attested")
        else:
            if (payload.get("held") is not True
                    or payload.get("ready") is not True
                    or type(payload.get("generation")) is not int
                    or payload["generation"] < 2):
                raise ValueError("guardian status not confirmed ready/held")
            generation = payload["generation"]
    report = {
        "schema": "g3-readonly-node-check-v1",
        "node_id": node_id,
        "recorded_generation": generation,
        "local_source_check_passed": True,
        "local_hold_observed": True,
        "independent_quorum_verified": False,
        "actual_world_effect_completeness_verified": False,
        "authentic_original_six_verified": False,
        "universal_physical_protection_proved": False,
        "authorizes_effect": False,
        "may_clear_hold": False,
    }
    if strict:
        raise ValueError("strict universal G3 requires independent physical evidence; unavailable")
    return report


def main(argv=None):
    parser = argparse.ArgumentParser(description="Read-only scoped guardian review")
    parser.add_argument("--node-id", required=True)
    parser.add_argument("--strict", action="store_true")
    args = parser.parse_args(argv)
    try:
        print(json.dumps(verify_node(node_id=args.node_id, strict=args.strict),
                         sort_keys=True))
    except (ValueError, OSError, subprocess.TimeoutExpired) as exc:
        print(json.dumps({"status": "UNVERIFIED", "error": str(exc),
                          "universal_physical_protection_proved": False,
                          "authorizes_effect": False,
                          "may_clear_hold": False}), file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
