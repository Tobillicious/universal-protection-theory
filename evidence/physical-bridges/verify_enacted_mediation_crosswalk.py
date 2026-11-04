#!/usr/bin/env python3
"""Fail-closed validator for the enacted-mediation witness crosswalk.

Checks the machine-readable crosswalk against the protected source anchors and
the honesty rules of the physical-bridges workflow. Exits nonzero on any
tampering: renamed source theorems, a PASS row without linked provenance,
a PASS row count above the declared honest count, a counterexample whose
detection mapping points at a nonexistent witness row, or the synthetic
fixture being relabelled as physical evidence.

Model-level checks only; this script is not physical BCRD evidence.
"""
import hashlib
import json
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
CROSSWALK = os.path.join(HERE, "enacted-mediation-crosswalk.json")
FIXTURE = os.path.join(HERE, "fixtures", "enacted_mediation_hold_bypass_fixture.py")

# Protected identifiers: deletion or redefinition of any of these fails.
PROTECTED_THEOREMS = [
    "PhysicalBridges.IR133.captured_events_supply_both_load_bearing_interfaces",
    "PhysicalBridges.IR133.captured_source_run_retains_original_order_protections",
    "PhysicalBridges.IR133.captured_event_does_not_imply_enacted_policy_action",
    "PhysicalBridges.LoadBearingPhysicalJoins.finite_real_run_joins_event_continuity_guard_and_maximality",
]
PROTECTED_SIBLINGS = [
    "separates", "dagCaptured", "fluxCaptured", "gaugeCaptured",
    "actuatorCaptured", "neutralCaptured", "authenticGenerator",
]
LEDGER_OBLIGATION = "enacted_mediation"
RECEIPT_FIELD = "enforcedAction"


def fail(msg):
    print(f"FAIL: {msg}")
    sys.exit(1)


def main():
    if not os.path.exists(CROSSWALK):
        fail("crosswalk JSON missing")
    with open(CROSSWALK) as f:
        d = json.load(f)

    # Target anchors must be present and honest.
    t = d.get("target", {})
    if t.get("ledger_obligation") != LEDGER_OBLIGATION:
        fail(f"ledger obligation must stay {LEDGER_OBLIGATION!r}")
    if t.get("receipt_field") != RECEIPT_FIELD:
        fail(f"receipt field must stay {RECEIPT_FIELD!r}")
    if t.get("ledger_status_external") != "OPEN_EXTERNAL" or t.get("receipt_field_status_external") != "OPEN_EXTERNAL":
        fail("external anchor statuses must stay OPEN_EXTERNAL; no promotion without evidence")
    if t.get("global_upt_status", d.get("global_upt_status")) != "OPEN":
        fail("global_upt_status must stay OPEN")
    if not t.get("proxy_warning"):
        fail("the PR #246 proxy warning must stay present")

    # Protected theorem names, exactly.
    theorems = d.get("source_theorems", [])
    for name in PROTECTED_THEOREMS:
        if name not in theorems:
            fail(f"protected theorem {name!r} missing from crosswalk")

    # Sibling receipt fields, exactly (coordination, not re-proof).
    siblings = d.get("sibling_receipt_fields", [])
    for s in PROTECTED_SIBLINGS:
        if s not in siblings:
            fail(f"protected sibling receipt field {s!r} missing")

    # Witness rows: honest statuses, provenance on any PASS.
    rows = {r["id"]: r for r in d.get("witness_rows", [])}
    if not rows:
        fail("no witness rows")
    pass_rows = []
    for rid, r in rows.items():
        status = r.get("status")
        if status not in ("OPEN_EXTERNAL", "BLOCKED", "PASS"):
            fail(f"row {rid}: illegal status {status!r}")
        if status == "PASS":
            if not r.get("evidence"):
                fail(f"row {rid}: PASS without linked evidence/provenance")
            pass_rows.append(rid)
        if status in ("OPEN_EXTERNAL", "BLOCKED") and not r.get("blocker"):
            fail(f"row {rid}: {status} rows must name their exact blocker")

    declared = d.get("pass_row_count_must_be")
    if declared is None:
        fail("pass_row_count_must_be must be declared (fail-closed against silent PASS)")
    if len(pass_rows) != declared:
        fail(f"PASS row count {len(pass_rows)} != declared {declared}")

    # Hostile counterexamples must map to existing rows.
    counterexamples = d.get("hostile_counterexamples", [])
    if not counterexamples:
        fail("at least one hostile bypass counterexample is required")
    for hc in counterexamples:
        for key in ("detected_by", "fenced_by"):
            for rid in hc.get(key, []):
                if rid not in rows:
                    fail(f"counterexample {hc.get('id')}: {key} row {rid!r} does not exist")
        if not hc.get("source_baseline"):
            fail(f"counterexample {hc.get('id')}: missing source baseline")
    ids = [hc["id"] for hc in counterexamples]
    if "HC-1" not in ids:
        fail("HC-1 (acknowledged hold with surviving queued effect) is required")

    # The synthetic fixture must stay labelled as non-evidence.
    if not os.path.exists(FIXTURE):
        fail("regression fixture missing")
    src = open(FIXTURE).read()
    if "SYNTHETIC_REGRESSION_ONLY" not in src:
        fail("fixture lost its SYNTHETIC_REGRESSION_ONLY label")
    rf = d.get("regression_fixture", {})
    if rf.get("scope") != "SYNTHETIC_REGRESSION_ONLY" or rf.get("physical_evidence") is not False:
        fail("regression fixture must stay labelled SYNTHETIC_REGRESSION_ONLY / physical_evidence=false")

    # The run itself: execute the fixture as a regression and record its digest.
    import subprocess
    proc = subprocess.run([sys.executable, FIXTURE], capture_output=True, text=True, timeout=60)
    if proc.returncode != 0:
        fail(f"fixture regression failed:\n{proc.stdout}\n{proc.stderr}")
    if "SYNTHETIC_REGRESSION_ONLY" not in proc.stdout:
        fail("fixture output did not carry the synthetic-only label")
    digest = hashlib.sha256(src.encode()).hexdigest()
    print(f"fixture sha256: {digest}")
    print(f"witness rows: {len(rows)} (OPEN_EXTERNAL={sum(1 for r in rows.values() if r['status']=='OPEN_EXTERNAL')}, "
          f"BLOCKED={sum(1 for r in rows.values() if r['status']=='BLOCKED')}, PASS={len(pass_rows)})")
    print(f"hostile counterexamples: {len(counterexamples)}")
    print("PASS: crosswalk honest; no absent-evidence promotion; fixture regression holds")


if __name__ == "__main__":
    main()
