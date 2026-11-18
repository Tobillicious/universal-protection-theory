"""G3 acceptance entrypoint: never deploy, never authorize, never clear HOLD.

Combines three separately bounded evidence checks with an explicit undecided
physical-world acceptance ledger. A CI success means source-level evidence
checks ran, not that actual-world or universal G3 protection is proven.
"""
import argparse
import json
from pathlib import Path

from g3_zelda_observed_effect_bridge import inspect as inspect_zelda
from g3_protected_source_tripwire import audit as audit_source

HERE = Path(__file__).resolve().parent
RECORD = HERE / "g3_guardian_node" / "live-observation-2026-11-18.json"
OPEN_GATES = {
    "R4_off_host_custody": "No separately administered off-host signed receipt has been verified",
    "R5_all_effect_route_mediation": "No independently complete writer/bypass inventory for actual host effects",
    "R6_authentic_six_at_actual_events": "Six actual owed-subject relations are not independently established",
    "R7_independent_acceptance": "No independent off-host replay and custody acceptance",
    "UNIVERSAL_physical_correspondence": "No independently proven coverage of all actual physical causes and transitions",
}


def evaluate(record_bytes, *, source_audit=audit_source):
    drift = source_audit()
    evidence = inspect_zelda(record_bytes)
    if type(drift) is not list or any(type(x) is not str for x in drift):
        raise ValueError("invalid protected-source audit result")
    source_clear = len(drift) == 0
    trace_clear = evidence["observed_technical_trace_consistent"] is True
    return {
        "schema": "g3-stage-zero-acceptance-v1",
        "scope": "historical Zelda one-marker evidence and reviewed source integrity",
        "source_pins_match": source_clear,
        "historical_trace_reconciled": trace_clear,
        "source_drift": drift,
        "open_gates": OPEN_GATES.copy(),
        "acceptance_stage": "EVIDENCE_REVIEW_STARTED",
        "ready_for_universal_physical_protection": False,
        "hCoverage_proved": False,
        "hMeaning_proved": False,
        "authorizes_effect": False,
        "may_clear_hold": False,
        "may_merge_or_deploy": False,
        "status": ("BLOCKED_SOURCE_DRIFT" if not source_clear
                   else "BOUNDED_EVIDENCE_VERIFIED_EXTERNAL_GATES_OPEN"),
    }


def main():
    parser = argparse.ArgumentParser(description="Start offline G3 acceptance, no runtime changes")
    parser.add_argument("--observation", type=Path, default=RECORD)
    args = parser.parse_args()
    if args.observation.is_symlink():
        parser.error("symlinked evidence is not accepted")
    try:
        report = evaluate(args.observation.read_bytes())
    except (OSError, ValueError, KeyError) as exc:
        parser.error(str(exc))
    print(json.dumps(report, indent=2, sort_keys=True))
    # This exits 0 for a successful bounded audit; it does NOT signal physical
    # acceptance, effect authorization, or authorization to clear HOLD.
    return 0 if report["source_pins_match"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
