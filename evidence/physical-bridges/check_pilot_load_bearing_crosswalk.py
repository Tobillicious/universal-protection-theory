#!/usr/bin/env python3
"""Crosswalk the actual preserved pilot commissioning report into UPT joins.

Source of the screening truth is commission.py + params-pilot.json, not a
mutable prose summary. A separate historical report must agree on all
requirement statuses. This is a test of the *specified* pilot's inputs
and statuses, NOT independent certification of the physical instruments.
"""
import hashlib
import json
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parent
PILOT = ROOT.parent / "compiled-strongest" / "installation" / "pilot"
INSTALL = PILOT.parent
PARAMS = PILOT / "params-pilot.json"
REPORT = PILOT / "COMMISSIONING-REPORT-PILOT.md"
LEDGER = ROOT / "load-bearing-join-ledger.json"

EXPECTED_COUNTS = {"PASS": 9, "FAIL": 3, "NOT MEASURED": 10}
EXPECTED_FAILED = {
    "harm: devices and records: radiated fields",
    "harm: devices and records: radiated fields (industrial)",
    "harm: people: hearing (8-hour)",
}
CONNECTIONS = {
    "real_step_coverage": "Not measured by the pilot's digital source inventory; extra-class actual events remain possible",
    "event_to_source_generator": "No authenticated complete real-physics-to-BCRD generator correspondence",
    "true_effect_calibration": "Three failed effect screens and unmeasured radiation, thermal, magnetic and decoherence classes",
    "continuing_particular_semantics": "No subjective or actual-subject historical continuity measurement",
    "cut_fibre_viability": "Source-only guard and finite readouts; no complete all-real-state common-action certificate",
    "enacted_mediation": "Cooperative lock-gated sink tested; independently writable filesystem/OS bypass remains",
    "original_full_feasible_rivals": "No actual all-feasible-outcomes/no-excluded-improver audit",
    "infinite_horizon_compactness_and_liveness": "Finite trials only; no all-time physical history/fairness certificate",
    "warmstart_3d_family": "No full 3D geometric C3 and uniform family Gibbs preparation certificate",
    "physical_installed_commissioning": "Nine passes, three failures and ten unmeasured in the preserved laboratory pilot",
}


def parse_screening(report):
    out = {}
    in_requirements = False
    for line in report.splitlines():
        if line.strip() == "| Requirement | Status |":
            in_requirements = True
            continue
        if in_requirements and line.startswith("|---"):
            continue
        if in_requirements and line.startswith("|"):
            cols = [x.strip() for x in line.strip().strip("|").split("|")]
            if len(cols) != 2 or cols[1] not in EXPECTED_COUNTS:
                raise AssertionError("invalid requirement row in screening report")
            name, status = cols
            if name in out:
                raise AssertionError("duplicate requirement in commissioning")
            out[name] = status
        elif in_requirements and out:
            break
    if not out:
        raise AssertionError("no commissioning screens parsed")
    return out


def validate_recomputed_report(recomputed, saved, ledger):
    authoritative = parse_screening(recomputed)
    historical = parse_screening(saved)
    if authoritative != historical:
        missing = sorted(set(authoritative) ^ set(historical))
        differences = sorted(
            k for k in set(authoritative) & set(historical)
            if authoritative[k] != historical[k]
        )
        raise AssertionError(
            f"historical pilot diverges from source inputs "
            f"(missing={missing}, changed={differences})"
        )
    counts = {status: sum(v == status for v in authoritative.values())
              for status in EXPECTED_COUNTS}
    assert counts == EXPECTED_COUNTS, counts
    assert {k for k,v in authoritative.items() if v == "FAIL"} == EXPECTED_FAILED
    assert "All screens pass: NO." in recomputed, "false complete commissioning flag"
    assert "All screens pass: NO." in saved, "historical false completion flag"
    assert len(authoritative) == sum(counts.values()) == 22

    obligations = {x["id"]: x for x in ledger["obligations"]}
    assert set(obligations) == set(CONNECTIONS)
    assert ledger["full_physical_upt_status"] == "OPEN"
    for key in CONNECTIONS:
        if obligations[key]["status"] not in ("OPEN_EXTERNAL","OPEN_PROOF"):
            raise AssertionError(f"pilot reports nonclosed physical join as closed: {key}")
    return counts, authoritative


def negative_tests(recomputed, saved, ledger):
    altered = saved.replace(
        "| harm: people: hearing (8-hour) | FAIL |",
        "| harm: people: hearing (8-hour) | PASS |",
    )
    try:
        validate_recomputed_report(recomputed, altered, ledger)
    except AssertionError:
        pass
    else:
        raise AssertionError("falsely promoted hearing FAIL was accepted")

    altered = saved.replace("All screens pass: NO.", "All screens pass: YES.")
    try:
        validate_recomputed_report(recomputed, altered, ledger)
    except AssertionError:
        pass
    else:
        raise AssertionError("forged all-pass pilot was accepted")

    altered = json.loads(json.dumps(ledger))
    altered["obligations"][0]["status"] = "VERIFIED_EXTERNAL"
    try:
        validate_recomputed_report(recomputed, saved, altered)
    except AssertionError:
        pass
    else:
        raise AssertionError("pilot-only data closed real-world source coverage")


def main():
    raw = PARAMS.read_bytes()
    invocation = subprocess.run(
        [sys.executable, str(INSTALL / "commission.py"), str(PARAMS)],
        check=True, capture_output=True, text=True
    )
    saved = REPORT.read_text()
    ledger = json.loads(LEDGER.read_text())
    counts, rows = validate_recomputed_report(invocation.stdout, saved, ledger)
    negative_tests(invocation.stdout, saved, ledger)
    print("UPT PILOT JOIN: commissioning recomputed from source/params — PASS")
    print("Screening counts:",counts)
    print("Failed:",", ".join(sorted(k for k,v in rows.items() if v=="FAIL")))
    print("Params SHA-256:",hashlib.sha256(raw).hexdigest())
    print("Historical-report SHA-256:",hashlib.sha256(saved.encode()).hexdigest())
    for key, reason in CONNECTIONS.items():
        print(f"OPEN {key}: {reason}")
    print("Pilot physical completion: NOT ESTABLISHED (correctly blocked)")
    print("False pass and source completeness promotion controls: PASS")


if __name__ == "__main__":
    main()
