#!/usr/bin/env python3
"""IR-134 source-to-physical HOLD audit: fail closed on evidence promotion.

This static code can verify only an explicit documented *open* status;
it cannot authenticate real hardware, independent review or source physics.
"""
import copy
import json
from pathlib import Path

BASE=Path(__file__).resolve().parent
LEDGER=BASE/"hold-physical-refinement-obligations.json"
MODULE=BASE/"PhysicalBridges"/"IR134RealHoldEffectRefinement.lean"
PARENT=BASE/"source-enactment-obligations.json"
IDS={
    "actual_real_step_refinement",
    "effect_meter_and_residual_envelope",
    "ack_after_closed_and_fully_drained",
    "noncooperative_effect_authority",
    "adversarial_environment_and_faults",
    "independent_commissioning_and_replay",
}
ANCHORS=(
    "HoldEffectRefinement",
    "everyRealStepHasSourceCommand",
    "physicalEffectAccounted",
    "quiescent_real_step_residual_bound",
    "all_finite_real_hold_traces_no_effect_growth",
    "source_barrier_and_command_match_without_effect_accounting_fail",
    "quiescent_step",
)


class UnsupportedPhysicalClaim(ValueError):
    pass


def verify(ledger,lean,parent):
    expected={
        "schema_version":1,
        "formal_theorem":"PhysicalBridges.IR134.all_finite_real_hold_traces_no_effect_growth",
        "source_scope":"CONDITIONAL_FINITE_TRACE",
        "hardware_coverage":"OPEN",
        "hold_reference_fixture":"COOPERATIVE_SINK_BYPASS_DEMONSTRATED",
        "independent_installation_certification":"NOT_ESTABLISHED",
        "upt_original_x3_status":"OPEN",
    }
    for field,value in expected.items():
        if ledger.get(field)!=value:
            raise UnsupportedPhysicalClaim(f"unsupported claim in {field}")
    for anchor in ANCHORS:
        if anchor not in lean:
            raise UnsupportedPhysicalClaim(f"missing proof dependency {anchor}")
    obligations=ledger.get("obligations")
    if not isinstance(obligations,list) or len(obligations)!=len(IDS):
        raise UnsupportedPhysicalClaim("missing or duplicated independent physical warrant")
    seen=set()
    for row in obligations:
        if not isinstance(row,dict):
            raise UnsupportedPhysicalClaim("malformed record")
        name=row.get("id")
        if name in seen or name not in IDS:
            raise UnsupportedPhysicalClaim("duplicated/renamed obligation")
        seen.add(name)
        if row.get("status")!="OPEN_EXTERNAL":
            raise UnsupportedPhysicalClaim("physical obligation has no independent verification")
        if row.get("evidence")!=[]:
            raise UnsupportedPhysicalClaim("unreviewed evidence cannot close physical gap")
        if not isinstance(row.get("requirement"),str) or not row["requirement"]:
            raise UnsupportedPhysicalClaim("no operationally defined test")
    if seen!=IDS:
        raise UnsupportedPhysicalClaim("uncovered external obligation")
    parents={row["id"]:row for row in parent.get("obligations",[])}
    if parents.get("enforcedAction",{}).get("status")!="OPEN_EXTERNAL":
        raise UnsupportedPhysicalClaim("IR133 enactment certified from incomplete hold fixture")
    if parent.get("global_upt_status")!="OPEN":
        raise UnsupportedPhysicalClaim("source seam incorrectly promoted global X3")
    return len(IDS)


def adversarial_negative_tests(data,lean,parent):
    def reject(mutated,label,source=lean,ancestor=parent):
        try:
            verify(mutated,source,ancestor)
        except UnsupportedPhysicalClaim:
            return
        raise AssertionError("fail-open for "+label)

    changed=copy.deepcopy(data)
    changed["obligations"]=[
        row for row in changed["obligations"]
        if row["id"]!="noncooperative_effect_authority"
    ]
    reject(changed,"removed direct-write bypass challenge")

    changed=copy.deepcopy(data)
    changed["obligations"][0]["id"]="we_have_a_good_digital_log"
    reject(changed,"source model substituted for actual real step")

    changed=copy.deepcopy(data)
    changed["obligations"][1]["status"]="VERIFIED_EXTERNAL"
    reject(changed,"external residual bound asserted without independent measurement")

    changed=copy.deepcopy(data)
    changed["hold_reference_fixture"]="ALL_PHYSICAL_OUTPUTS_FENCED"
    reject(changed,"cooperative sink falsely promoted to full hardware authority")

    changed=copy.deepcopy(data)
    changed["upt_original_x3_status"]="PROVED"
    reject(changed,"global X3 promoted on local hold proof")

    ancestor=copy.deepcopy(parent)
    next(x for x in ancestor["obligations"] if x["id"]=="enforcedAction")[
        "status"
    ]="VERIFIED_EXTERNAL"
    reject(data,"IR133 action without external test",ancestor=ancestor)

    reject(data,"negative hold theorem erased",
           source=lean.replace("source_barrier_and_command_match_without_effect_accounting_fail",
                               "no_counterexample"))


if __name__=="__main__":
    data=json.loads(LEDGER.read_text())
    source=MODULE.read_text()
    parent=json.loads(PARENT.read_text())
    count=verify(data,source,parent)
    adversarial_negative_tests(data,source,parent)
    print(f"IR-134 physical HOLD warrants: {count} OPEN_EXTERNAL")
    print("Reference sink status: COOPERATIVE HOLD, OUTSIDE-WRITER BYPASS DEMONSTRATED")
    print("Measured zero physical residual across all effects: NOT ESTABLISHED")
    print("Independent installed physical HOLD/X3 certification: REFUSED")
    print("Seven missing-premise / false-promotion adversarial audits: PASS")
