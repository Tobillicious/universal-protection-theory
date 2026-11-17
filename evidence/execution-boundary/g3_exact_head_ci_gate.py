"""R7 offline exact-head CI receipt validator; never issues G3 certification.

Input must be independently fetched/reviewed, not agent self-asserted.
This checks receipt consistency only; GitHub authenticity, R4 independent custody,
R6 real-world effects and R7 independent human acceptance are separate gates.
"""
import argparse
import json
import re

SHA = re.compile(r"[0-9a-f]{40}\Z")
REQUIRED = frozenset({
    "Physical bridge proofs",
    "G3 kernel identity threat-model tests",
    "Full-law agent entrypoint integrity",
    "UPT summit publication packet",
    "Koru shadow verifier (synthetic, non-enforcing)",
    "G3 cross-UID signed HOLD research (non-deploying)",
})


def inspect(packet):
    """Return (bool, list[str]); fail closed on ambiguity or stale heads."""
    failures = []
    if type(packet) is not dict or set(packet) != {"head_sha", "workflow_runs"}:
        return False, ["packet_schema"]
    head = packet["head_sha"]
    if type(head) is not str or not SHA.fullmatch(head):
        return False, ["invalid_head_sha"]
    runs = packet["workflow_runs"]
    if type(runs) is not list:
        return False, ["workflow_runs_not_list"]
    seen = set()
    seen_ids = set()
    for index, run in enumerate(runs):
        if type(run) is not dict or set(run) != {
                "name", "head_sha", "status", "conclusion", "id"}:
            failures.append(f"run_{index}_schema")
            continue
        name = run["name"]
        if type(name) is not str or name not in REQUIRED:
            failures.append(f"run_{index}_unknown_name")
            continue
        if name in seen:
            failures.append(f"run_{index}_duplicate")
        seen.add(name)
        if type(run["id"]) is not int or run["id"] <= 0:
            failures.append(f"run_{index}_invalid_id")
        elif run["id"] in seen_ids:
            failures.append(f"run_{index}_duplicate_id")
        else:
            seen_ids.add(run["id"])
        if run["head_sha"] != head:
            failures.append(f"run_{index}_wrong_commit")
        if run["status"] != "completed" or run["conclusion"] != "success":
            failures.append(f"run_{index}_not_successful")
    for missing in sorted(REQUIRED - seen):
        failures.append(f"missing_{missing}")
    return not failures, failures


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("receipt_json")
    args = parser.parse_args()
    with open(args.receipt_json, encoding="utf-8") as handle:
        packet = json.load(handle)
    ok, errors = inspect(packet)
    print(json.dumps({
        "exact_head_ci_receipt_consistent": ok,
        "R4_independent_custody": "UNASSESSED",
        "R6_authentic_actual_effects": "UNASSESSED",
        "R7_external_reviewer_acceptance": "UNASSESSED",
        "errors": errors
    }, sort_keys=True))
    raise SystemExit(0 if ok else 1)


if __name__ == "__main__":
    main()
