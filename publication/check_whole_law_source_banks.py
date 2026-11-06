#!/usr/bin/env python3
"""Verify BOTH UPT proof-bank inventories and their archived build provenance.

This is a SOURCE-INTEGRITY check, not a Lean compiler, an empirical test,
or a proof of the universal physical Law. The original Snuffy canon's
separate archived 327-module receipt must never be silently promoted to
include additional research sources outside that exact receipt.
"""
from __future__ import annotations
import hashlib
from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parent.parent
CANON = ROOT / "evidence/compiled-strongest/lean"
BRIDGE = ROOT / "evidence/physical-bridges"
errors: list[str] = []

def require(condition: bool, message: str) -> None:
    if not condition:
        errors.append(message)

def has_declaration(path: Path, name: str) -> bool:
    if not path.is_file():
        return False
    return re.search(r"(?m)^\s*(?:theorem|lemma|def|abbrev|structure)\s+" + re.escape(name) + r"\b", path.read_text()) is not None

def source_receipt_audit() -> None:
    receipt_path = CANON / "RECEIPT.txt"
    receipt = receipt_path.read_text()
    build = (CANON / "build-and-audit.sh").read_text()
    audit = (CANON / "SummitsAudit.lean").read_text()
    require("## overall: PASS" in receipt, "Archived canon receipt does not state PASS")
    require("Mathlib rev 56a005855ea17e0b0958f73ec801ae140b0a1679" in receipt, "Archived Mathlib provenance changed")
    matches = re.findall(r"(?m)^##\s+([0-9a-f]{64})\s+Snuffy/([A-Za-z0-9_]+)\.lean$", receipt)
    recorded = {name: hexdigest for hexdigest, name in matches}
    require(len(matches) == len(recorded) == 327, f"Expected 327 distinct receipt SHA-256 entries, found {len(matches)}")
    match = re.search(r"(?m)^MODULES=\((.*?)\)$", build)
    named_build = set(match.group(1).split()) if match else set()
    require(named_build == set(recorded), "Canonical build MODULES differ from archived receipt")
    modules = {f.stem for f in (CANON / "Snuffy").glob("*.lean")}
    for name, hexdigest in recorded.items():
        path = CANON / "Snuffy" / f"{name}.lean"
        require(path.is_file(), f"Archived compiled source missing: {name}")
        if path.is_file():
            require(hashlib.sha256(path.read_bytes()).hexdigest() == hexdigest,
                    f"Source bytes changed since archived canon PASS receipt: {name}")
        require(re.search(r"(?m)^import Snuffy\." + re.escape(name) + r"\s*$", audit) is not None,
                f"Canon audit does not import {name}")
    require(not (set(recorded) - modules), "Canon receipt records source no longer present")

    # These are later, separately scoped research modules — NOT in the archived
    # v4.2 canon build. They must remain explicitly distinguished until a
    # separately verified extension build exists.
    extra = modules - set(recorded)
    expected_extra = {"ClosedUnitaryRecurrence", "UPTPhysicsDemonstration"}
    require(extra == expected_extra,
            f"Non-receipted canon research sources changed: expected {sorted(expected_extra)}, found {sorted(extra)}")
    require(has_declaration(CANON / "Snuffy/ClosedUnitaryRecurrence.lean", "unitary_no_permanent_curtailment"),
            "Research recurrence result not found")
    require(has_declaration(CANON / "Snuffy/ClosedUnitaryRecurrence.lean", "closure_does_not_forbid_first_loss"),
            "Research negative control not found")
    require(has_declaration(CANON / "Snuffy/UPTPhysicsDemonstration.lean", "upt_demonstrated"),
            "Research Hermitian-reciprocity result not found")
    print(f"Snuffy canon: {len(recorded)} original module SHA-256 values match archived PASS; {len(extra)} research sources outside receipt.")

def whole_route_source_audit() -> None:
    # This is the public WHOLE-LAW proof route, not an assertion that one
    # theorem discharges another's physical, ethical, or semantic hypotheses.
    required = {
        "Snuffy/Law.lean": ("scope_guarantee_iff", "faithful_hold_dominates"),
        "Snuffy/Greatestness.lean": ("aligned_iff_no_needless_loss", "greatest_of_union_closed"),
        "Snuffy/UniversalProtection.lean": ("coverage_invariant", "universal_protection"),
        "Snuffy/Bridge.lean": ("coverage_from_law", "universal_protection_held"),
        "Snuffy/G2Splice.lean": ("fourStage", "block_splice_keeps"),
        "Snuffy/H5Closure.lean": ("effect_preserves_care", "no_harmful_effect", "consistency_detector"),
        "Snuffy/G2Held.lean": ("active_authorised_free", "held_source_top"),
        "Snuffy/CyclicProjections.lean": ("tendsto_cyc_iter", "presentation_detector"),
        "Snuffy/MeetHilbert.lean": ("deduction_never_rolls_back", "contradiction_detected"),
    }
    for rel, theorems in required.items():
        path = CANON / rel
        for name in theorems:
            require(has_declaration(path, name), f"Original canon missing {rel}:{name}")
    h5 = (CANON / "Snuffy/H5Closure.lean").read_text()
    g2 = (CANON / "Snuffy/G2Held.lean").read_text()
    cyc = (CANON / "Snuffy/CyclicProjections.lean").read_text()
    require("effect_preserves_care" in g2, "G2Held no longer cites H5 ledger care theorem")
    require("active_authorised_free" in g2.split("theorem held_source_top", 1)[-1],
            "G2 held-source top no longer cites derived ledger-freedom theorem")
    require("held_source_protection" in g2.split("theorem held_source_top", 1)[-1],
            "G2 held-source top no longer cites G1 continuation theorem")
    require("Snuffy.CanonVonNeumann.tendsto_altIterate" in h5,
            "H5 consistency detector no longer cites the convergence theorem")
    require("tendsto_cyc_iter K x" in cyc,
            "Whole-family H5 detector no longer cites cyclic convergence")
    required_bridge = {
        "HillaryReadOnlyAssembly": ("hillary_exact_join_with_hypotheses", "fenced_model_all_six_original_duties"),
        "FullPhysicalDomainGuardianAssembly": ("every_physical_event_has_complete_koru_full_six_G_and_no_absolute_E", "physical_domain_has_no_original_six_violation_or_absolute_E"),
        "ConstructivePositiveWGuardian": ("positive_W_mathematical_guardian_exists_and_protects_every_step", "canonical_positive_W_has_complete_model_coverage", "canonical_positive_W_has_formal_six_reflection"),
        "NonstutteringPositiveWGuardian": ("nonstuttering_mathematical_guardian_exists", "nonstuttering_W_source_changes", "generated_W_has_complete_model_coverage", "generated_W_has_formal_six_reflection"),
        "IR138PerParticularEventReflection": ("full_intrinsic_source_recovers_semantics",),
        "WholeSourceSemanticVisibility": ("semantic_factors_through_observation_iff_fibre_constant",),
        "KoruEternalKnowledgeSeed": ("every_ethical_claim_carried_verbatim", "every_modeled_world_has_parent_and_child"),
        "KoruJokerUniverseTrialFeedback": ("one_ethical_question_does_not_certify_all_ethics",),
        "SummitExistenceImpliesGuardian": ("inversion_form", "DecisiveContradiction"),
        "OriginalX3Full": ("OriginalX3", "proxy_is_strictly_weaker"),
        "HillaryRouteABSummit": ("hillary_route_b_meets_original_route_a", "hillary_semantic_keystone_exact_strength"),
        "KoruObjectiveWholeU": ("objectiveStep",),
        "KoruOneRealizedTraceAssembly": ("koru_holding_six_x3_total_E_one_realized_trace",),
        "GAndNoEFullSixTraceAssembly": ("g_and_no_absolute_E_on_same_koru_realized_history",),
        "PhysicalSemanticLastMileGates": ("any_real_original_six_violation_refutes_coverage_or_reflection", "the_two_last_mile_gates_are_independent_of_source_formalism"),
        "OriginalKeystoneForwardSemanticReflection": ("all_owed_original_six_iff_forward_reflection", "positive_whole_without_authentic_forward_reflection"),
        "CathedralBackwardsOriginalX3": ("original_dichotomy_iff_every_owed_original_x3",),
        "CompleteKoruLawCircle": ("CircleJoins", "the_law_circle_returns_to_something_is", "circular_return_does_not_prove_missing_join"),
        "FullGuardianOrigin": ("source_derives_route_b",),
        "AllIsGActualityDischarge": ("RouteBSummit",),
    }
    physical_root = (BRIDGE / "PhysicalBridges.lean").read_text()
    for module, theorems in required_bridge.items():
        path = BRIDGE / "PhysicalBridges" / f"{module}.lean"
        require(f"import PhysicalBridges.{module}" in physical_root,
                f"Pinned Physical Bridges root does not directly import {module}")
        for name in theorems:
            require(has_declaration(path, name), f"Physical Bridge missing {module}:{name}")
    x3 = (BRIDGE / "PhysicalBridges/OriginalX3Full.lean").read_text()
    six = ["historicalContinuity", "authorization", "freedom", "restraint", "maximality", "provenance"]
    for field in six:
        require(re.search(r"(?m)^\s*" + field + r"\s*:", x3) is not None,
                f"Original six-X3 field absent: {field}")
    # This is a signed source-navigation contract, NOT a declaration that
    # unproved physical/semantic or cosmological hypotheses are now theorems.
    runway_path = ROOT / "QED-ONE-ROAD-EXACT-SOURCE-RUNWAY-2026-11-07.md"
    require(runway_path.is_file(), "One-road proof runway is missing")
    if runway_path.is_file():
        runway = runway_path.read_text()
        for mandatory in (
            "CompleteWEventCoverage",
            "ForwardRealEventReflection",
            "six original X3",
            "H5.2 freedom",
            "ALL independently valid ethics",
            "Tree of Life",
            "Every six",
            "actual-world",
        ):
            require(mandatory.lower() in runway.lower(),
                    f"Proof runway omitted load-bearing topic: {mandatory}")
    type_index = (BRIDGE / "PhysicalBridges/LawExistingBrickIndexChecks.lean").read_text()
    for module, declaration in (
        ("FullPhysicalDomainGuardianAssembly", "every_physical_event_has_complete_koru_full_six_G_and_no_absolute_E"),
        ("NonstutteringPositiveWGuardian", "nonstuttering_mathematical_guardian_exists"),
        ("PhysicalSemanticLastMileGates", "any_real_original_six_violation_refutes_coverage_or_reflection"),
        ("AllIsGActualityDischarge", "RouteBSummit"),
        ("CompleteKoruLawCircle", "CircleJoins"),
    ):
        require(f"#check PhysicalBridges.{module}.{declaration}" in type_index,
                f"Pinned type runway omitted {module}.{declaration}")
    print("Whole-Law source route: original six-X3, historical Snuffy protection, Koru/Hillary/Total-E, and two physical-semantic gates found.")

if __name__ == "__main__":
    source_receipt_audit()
    whole_route_source_audit()
    if errors:
        print("WHOLE-LAW SOURCE INTEGRITY: FAIL")
        for problem in errors:
            print(" -", problem)
        sys.exit(1)
    print("WHOLE-LAW SOURCE INTEGRITY: PASS (provenance/source inventory only; not a universal physics Q.E.D.)")
