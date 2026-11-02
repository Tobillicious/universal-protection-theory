#!/usr/bin/env python3
"""Fail-closed UPT physical join status and provenance gate.

This is a DOCUMENTARY assurance check, not external physics testing.
It refuses to promote a conditional theorem to physically complete
when any load-bearing factual/semantic/mathematical obligation is open.

No boolean tests on synthetic traces can discharge actual-world warrants.
"""
import copy
import json
from pathlib import Path


HERE = Path(__file__).resolve().parent
LEDGER = HERE / "load-bearing-join-ledger.json"
MODULE = HERE / "PhysicalBridges" / "LoadBearingPhysicalJoins.lean"

EXPECTED = {
    "real_step_coverage",
    "event_to_source_generator",
    "true_effect_calibration",
    "continuing_particular_semantics",
    "cut_fibre_viability",
    "enacted_mediation",
    "original_full_feasible_rivals",
    "infinite_horizon_compactness_and_liveness",
    "warmstart_3d_family",
    "physical_installed_commissioning",
}
REQUIRED_MODULE_SNIPPETS = (
    "certified_source_from_external_events",
    "finite_real_run_joins_event_continuity_guard_and_maximality",
    "source_guardian_without_physical_mediation_is_insufficient",
    "IR123.all_real_steps_witnessed_yield_complete_trace",
    "IR123.complete_physical_trace_burden_bound",
    "Oct10Continuity.original_particular_finite_causal_continuation",
    "guarded_real_effects_preserve_finite_histories",
    "IR98.original_order_transfer_of_no_new_improver",
    "hNoOmittedImprover",
    "hEnacted",
    "hCalibrated",
)


class UnsupportedPromotion(Exception):
    pass


def verify(ledger, source, require_physical_completion=False):
    if ledger.get("schema_version") != 1:
        raise UnsupportedPromotion("unrecognized version")
    if ledger.get("theorem") != (
        "PhysicalBridges.LoadBearingPhysicalJoins."
        "finite_real_run_joins_event_continuity_guard_and_maximality"
    ):
        raise UnsupportedPromotion("unrecognized proof dependency")
    obligations = ledger.get("obligations")
    if not isinstance(obligations, list) or not all(
        isinstance(x, dict) for x in obligations
    ):
        raise UnsupportedPromotion("missing obligation records")
    ids = [x.get("id") for x in obligations]
    if set(ids) != EXPECTED or len(ids) != len(EXPECTED):
        raise UnsupportedPromotion("missing, renamed or duplicate load-bearing premise")
    for required in REQUIRED_MODULE_SNIPPETS:
        if required not in source:
            raise UnsupportedPromotion(f"missing expected Lean anchor: {required}")
    if "axiom " in source or "\nsorry" in source or "\nadmit" in source:
        raise UnsupportedPromotion("unproved declaration or placeholder")
    if ledger.get("status") != "CONDITIONAL_FORMAL_JOIN":
        raise UnsupportedPromotion("theorem status overpromoted")
    if ledger.get("forbidden_promotion_without_evidence") is not True:
        raise UnsupportedPromotion("promotion firewall disabled")

    unclosed = []
    for item in obligations:
        kind = item.get("kind")
        status = item.get("status")
        evidence = item.get("evidence")
        if kind not in ("physical", "semantic", "mathematical"):
            raise UnsupportedPromotion(f"unknown kind {item['id']}")
        if not isinstance(item.get("model_anchor"), str) or not item["model_anchor"]:
            raise UnsupportedPromotion(f"missing model anchor {item['id']}")
        if not isinstance(evidence, list):
            raise UnsupportedPromotion(f"invalid evidence list {item['id']}")
        if kind == "mathematical":
            if status == "OPEN_PROOF":
                unclosed.append(item["id"])
            elif status == "PROVED_FORMAL":
                if not evidence:
                    raise UnsupportedPromotion(
                        f"formal theorem promoted with no proof receipt: {item['id']}")
            else:
                raise UnsupportedPromotion(f"invalid mathematical status: {item['id']}")
        else:
            if status == "OPEN_EXTERNAL":
                unclosed.append(item["id"])
            elif status == "VERIFIED_EXTERNAL":
                if not evidence or not all(
                    isinstance(x, dict) and x.get("source") and x.get("sha256")
                    and x.get("reviewer") and x.get("scope")
                    for x in evidence
                ):
                    raise UnsupportedPromotion(
                        f"external physical/semantic status has no "
                        f"independent scoped provenance: {item['id']}")
            else:
                raise UnsupportedPromotion(f"invalid external status: {item['id']}")
    claimed = ledger.get("full_physical_upt_status")
    if claimed not in ("OPEN", "VERIFIED_WITH_INDEPENDENT_EVIDENCE"):
        raise UnsupportedPromotion("unsupported physical completion label")
    if claimed == "VERIFIED_WITH_INDEPENDENT_EVIDENCE" and unclosed:
        raise UnsupportedPromotion("global completion asserted with open dependencies")
    if claimed == "OPEN" and not unclosed:
        # A completed ledger does not automatically prove the physical result;
        # promotion requires an additional independent integration decision.
        pass
    if require_physical_completion:
        if claimed != "VERIFIED_WITH_INDEPENDENT_EVIDENCE" or unclosed:
            raise UnsupportedPromotion("full physical UPT remains unverified")
    return unclosed


def negative_controls(ledger, source):
    def must_fail(value, reason):
        try:
            verify(value, source)
        except UnsupportedPromotion:
            return
        raise AssertionError(f"promotion gate accepted invalid {reason}")

    missing = copy.deepcopy(ledger)
    missing["obligations"] = [
        o for o in missing["obligations"]
        if o["id"] != "enacted_mediation"
    ]
    must_fail(missing, "removed mandatory source-to-effect mediation")

    replaced = copy.deepcopy(ledger)
    replaced["obligations"][0]["id"] = "digital_log_is_complete"
    must_fail(replaced, "renamed independent physical source coverage")

    physical = copy.deepcopy(ledger)
    physical["obligations"][0]["status"] = "VERIFIED_EXTERNAL"
    must_fail(physical, "physical coverage with no independent source evidence")

    formal = copy.deepcopy(ledger)
    next(o for o in formal["obligations"] if o["kind"]=="mathematical")[
        "status"
    ] = "PROVED_FORMAL"
    must_fail(formal, "formally closed without a proof receipt")

    promoted = copy.deepcopy(ledger)
    promoted["full_physical_upt_status"] = "VERIFIED_WITH_INDEPENDENT_EVIDENCE"
    must_fail(promoted, "premature global full physical closure")

    must_fail(ledger | {"status": "UPT_PROVED"}, "premature theorem promotion")

    assert "hNoOmittedImprover" in source
    # The fifth-source countermodel and provenance/feasible-menu
    # countermodels are separate pinned Lean imports; no status promotion
    # can be justified by this manifest validator alone.


def main():
    ledger = json.loads(LEDGER.read_text())
    source = MODULE.read_text()
    missing = verify(ledger, source)
    assert len(missing) == len(EXPECTED)
    negative_controls(ledger, source)
    try:
        verify(ledger, source, require_physical_completion=True)
    except UnsupportedPromotion:
        print("EXTERNAL PHYSICAL COMPLETION: NOT ESTABLISHED (correctly refused)")
    else:
        raise AssertionError("incorrectly certified full physical UPT")
    print("FORMAL JOIN: exact source-to-run theorem claimed (Lean build separately required)")
    print(f"OPEN LOAD-BEARING OBLIGATIONS: {len(missing)}")
    for name in missing:
        print(" -", name)
    print("Missing-field, redefinition, missing-provenance and "
          "premature-completion counterchecks: PASS")
    print("Load-bearing documentary proof/promotion gate: PASS")


if __name__ == "__main__":
    main()
