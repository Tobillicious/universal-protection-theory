#!/usr/bin/env python3
"""Fail-closed IR-133 assurance audit.

Validates the presence of all eight independent source/capture/action
premises, their traceable parent contracts and the required negative
control. This is static claim hygiene, NOT a hardware experiment or
evidence-authentication service. Physical promotion is deliberately
disallowed pending independent review and a separately updated gate.
"""
import copy
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parent
JOURNAL = ROOT / "source-enactment-obligations.json"
SOURCE = ROOT / "PhysicalBridges" / "IR133SourceEnactmentSeam.lean"
PARENTS = {
    "separates": "real_step_coverage",
    "dagCaptured": "real_step_coverage",
    "fluxCaptured": "real_step_coverage",
    "gaugeCaptured": "real_step_coverage",
    "actuatorCaptured": "real_step_coverage",
    "neutralCaptured": "real_step_coverage",
    "authenticGenerator": "event_to_source_generator",
    "enforcedAction": "enacted_mediation",
}
PROOF_ANCHORS = (
    "SourceEnactmentReceipt",
    "captured_event_for_every_real_transition",
    "captured_events_supply_both_load_bearing_interfaces",
    "captured_source_run_retains_original_order_protections",
    "captured_event_does_not_imply_enacted_policy_action",
    "IR125",
    "full_step_capture_from_four_channels",
    "LoadBearingPhysicalJoins",
    "finite_real_run_joins_event_continuity_guard_and_maximality",
)


def check(data, lean_source):
    if data.get("schema_version") != 1:
        raise ValueError("unknown audit schema")
    if data.get("scope") != "CONDITIONAL_SOURCE_FORMALIZATION":
        raise ValueError("formal source claim was promoted")
    if data.get("theorem") != (
        "PhysicalBridges.IR133."
        "captured_source_run_retains_original_order_protections"
    ):
        raise ValueError("wrong referenced Lean theorem")
    if data.get("physical_system_id") is not None:
        raise ValueError("no independently validated physical instrument in scope")
    if data.get("physical_evidence_status") != "UNVALIDATED":
        raise ValueError("physical certificate improperly promoted")
    if data.get("global_upt_status") != "OPEN":
        raise ValueError("global protection improperly promoted")
    rows = data.get("obligations")
    if not isinstance(rows, list) or len(rows) != len(PARENTS):
        raise ValueError("missing/extra source-seam obligations")
    seen = set()
    for row in rows:
        if not isinstance(row, dict):
            raise ValueError("malformed source-seam obligation")
        name = row.get("id")
        if name in seen or name not in PARENTS:
            raise ValueError("duplicate or unknown obligation")
        seen.add(name)
        if row.get("parent") != PARENTS[name]:
            raise ValueError("source-to-action parent mismatch")
        if row.get("status") != "OPEN_EXTERNAL":
            raise ValueError("source-seam obligation promoted without independent review")
        if row.get("evidence") != []:
            raise ValueError("unreviewed evidence cannot self-certify its source")
        if not isinstance(row.get("requirement"), str) or not row["requirement"]:
            raise ValueError("source-seam obligation lacks testable definition")
        if name not in lean_source:
            raise ValueError("Lean source missing required receipt field")
    if seen != set(PARENTS):
        raise ValueError("source-seam obligations incomplete")
    for anchor in PROOF_ANCHORS:
        if anchor not in lean_source:
            raise ValueError("missing Lean source composition anchor: " + anchor)
    return len(seen)


def test_negative_controls(original, lean_source):
    def must_reject(edited, label):
        try:
            check(edited, lean_source)
        except ValueError:
            return
        raise AssertionError("incorrectly accepted: " + label)

    missing = copy.deepcopy(original)
    missing["obligations"] = [
        row for row in missing["obligations"] if row["id"] != "enforcedAction"
    ]
    must_reject(missing, "unmediated real effects")

    renamed = copy.deepcopy(original)
    renamed["obligations"][0]["id"] = "sensors_probably_complete"
    must_reject(renamed, "weakened physical transition separation")

    promoted = copy.deepcopy(original)
    promoted["obligations"][-1]["status"] = "VERIFIED_EXTERNAL"
    must_reject(promoted, "unreviewed action enforcement")

    documented = copy.deepcopy(original)
    documented["obligations"][-1]["evidence"] = [
        {"source": "synthetic", "sha256": "unverified"}
    ]
    must_reject(documented, "self-attested external evidence")

    total = copy.deepcopy(original)
    total["global_upt_status"] = "PROVED"
    must_reject(total, "unsupported physical X3")

    reduced = copy.deepcopy(original)
    reduced["obligations"][-1]["parent"] = "digital_log_exists"
    must_reject(reduced, "replacement of physical enactment with logging")



def main():
    data = json.loads(JOURNAL.read_text())
    source = SOURCE.read_text()
    count = check(data, source)
    test_negative_controls(data, source)
    print(f"IR-133 SOURCE SEAM: {count} independent obligations present")
    print("real-step readout/capture, genuine generator, enforced action: OPEN_EXTERNAL")
    print("Physical deployment / universal-X3 certification: REFUSED")
    print("Missing premise / false source / unsupported promotion negatives: PASS")
    print("IR-133 documentary claim-integrity gate: PASS")


if __name__ == "__main__":
    main()
