#!/usr/bin/env python3
"""Prevent the original complete-law navigation from regressing to legacy editions."""
from pathlib import Path

root = Path(__file__).resolve().parents[1]
required_files = [
    "AGENTS.md", "THE-LAW-START-HERE.md", "README.md", "llms.txt",
    "HILLARY-ROUTE-A-B-SUMMIT.md",
    "evidence/physical-bridges/PhysicalBridges/HillaryRouteABSummit.lean",
    "CITATION.cff", "PUBLISHED-4.4.json",
    "evidence/compiled-strongest/PARTS-XV-SUMMIT.md",
    "evidence/physical-bridges/PhysicalBridges/OriginalX3Full.lean",
    "evidence/physical-bridges/PhysicalBridges/CathedralBackwardsOriginalX3.lean",
    "evidence/physical-bridges/PhysicalBridges/TotalEOriginalX3Bridge.lean",
    "evidence/physical-bridges/PhysicalBridges/IntrinsicSixSourceForcing.lean",
    "evidence/physical-bridges/PhysicalBridges/FencedTotalEOriginalSixJoin.lean",
    "evidence/physical-bridges/PhysicalBridges/BCRDSixSourceHistoryPositiveJoin.lean",
    "publication/UPT-SUMMIT-SOURCE-MAP-2026-11-05.md",
    "publication/ALL-IS-FULL-KORU-CATHEDRAL-ARCHIMEDES-QED-AUDIT-2026-11-05.md",
]
for path in required_files:
    assert (root / path).is_file(), f"Missing navigated source: {path}"

readme = (root / "README.md").read_text()
llms = (root / "llms.txt").read_text()
guide = (root / "THE-LAW-START-HERE.md").read_text()
agents = (root / "AGENTS.md").read_text()
cff = (root / "CITATION.cff").read_text()

for name, body in [("README.md", readme), ("llms.txt", llms), ("AGENTS.md", agents)]:
    assert "HILLARY-ROUTE-A-B-SUMMIT.md" in body, f"{name}: missing Hillary route"
    assert "THE-LAW-START-HERE.md" in body, f"{name}: missing full-law gateway"
assert "HILLARY-ROUTE-A-B-SUMMIT.md" in guide
for name, body in [("THE-LAW-START-HERE.md", guide), ("llms.txt", llms), ("AGENTS.md", agents)]:
    for needle in ["#360", "#364", "#365", "Part XV", "OriginalX3"]:
        assert needle in body, f"{name}: missing {needle}"
for needle in ["historical continuity", "authorization", "freedom", "restraint", "maximality", "provenance"]:
    assert needle in guide.lower(), f"Full six-X3 term lost: {needle}"
assert "version: \"4.4\"" in cff, "Archive version should be checked against CITATION.cff"
assert "10.5281/zenodo.23877060" in llms
assert llms.index("THE-LAW-START-HERE.md") < llms.index("Snuffy 2.0")
assert "Latest public compiled edition — 29 October 2026" not in readme

# ATLAS INTEGRITY CHECK: The single-roof proof route must remain traceable to
# the existing theorem statements and all local links must resolve.
import re

atlas_path = "PROOF-ATLAS-START-HERE.md"
assert (root / atlas_path).is_file(), "Missing complete one-roof proof atlas"
atlas = (root / atlas_path).read_text()
for name, body in [("README.md", readme), ("llms.txt", llms),
                   ("AGENTS.md", agents), ("THE-LAW-START-HERE.md", guide)]:
    assert atlas_path in body, f"{name}: missing one-roof proof atlas first stop"

# This checks declarations exist in their ORIGINAL banks. It does not claim
# independently validated physical interpretation, nor merge Lean toolchains.
required_theorems = {
    "evidence/compiled-strongest/lean/Snuffy/H5Closure.lean": (
        "effect_preserves_care", "no_harmful_effect", "consistency_detector",
    ),
    "evidence/compiled-strongest/lean/Snuffy/G2Held.lean": (
        "active_authorised_free", "held_source_top",
    ),
    "evidence/compiled-strongest/lean/Snuffy/G1Held.lean": ("held_source_protection",),
    "evidence/compiled-strongest/lean/Snuffy/G2Splice.lean": ("fourStage",),
    "evidence/compiled-strongest/lean/Snuffy/CyclicProjections.lean": (
        "tendsto_cyc_iter", "presentation_detector",
    ),
    "evidence/compiled-strongest/lean/Snuffy/MeetHilbert.lean": (
        "deduction_never_rolls_back", "contradiction_detected",
    ),
    "evidence/physical-bridges/PhysicalBridges/OriginalX3Full.lean": (
        "proxy_is_strictly_weaker",
    ),
    "evidence/physical-bridges/PhysicalBridges/HillaryRouteABSummit.lean": (
        "hillary_route_b_meets_original_route_a",
        "hillary_semantic_keystone_exact_strength",
    ),
    "evidence/physical-bridges/PhysicalBridges/FullPhysicalDomainGuardianAssembly.lean": (
        "every_physical_event_has_complete_koru_full_six_G_and_no_absolute_E",
    ),
    "evidence/physical-bridges/PhysicalBridges/ConstructivePositiveWGuardian.lean": (
        "positive_W_mathematical_guardian_exists_and_protects_every_step",
    ),
    "evidence/physical-bridges/PhysicalBridges/NonstutteringPositiveWGuardian.lean": (
        "nonstuttering_mathematical_guardian_exists",
    ),
    "evidence/physical-bridges/PhysicalBridges/CathedralBackwardsOriginalX3.lean": (
        "original_dichotomy_iff_every_owed_original_x3",
    ),
    "evidence/physical-bridges/PhysicalBridges/CompleteKoruLawCircle.lean": (
        "the_law_circle_returns_to_something_is",
    ),
}
for source, names in required_theorems.items():
    body = (root / source).read_text()
    for name in names:
        declaration = r"(?m)^\s*(?:theorem|lemma|def|abbrev|structure)\s+" + re.escape(name) + r"\b"
        assert re.search(declaration, body), f"Atlas declaration missing: {source}:{name}"
        assert name in atlas, f"Atlas lost theorem reference: {name}"

for local in re.findall(r"\]\(([^)]+)\)", atlas):
    if "://" in local or local.startswith("#") or local.startswith("mailto:"):
        continue
    linked = local.split("#", 1)[0].split("?", 1)[0]
    assert (root / linked).is_file(), f"Atlas has broken link: {local}"

assert "hCoverage" in atlas and "hReflection" in atlas, (
    "Atlas must retain the physical and semantic applicability premises"
)
assert "301/301" in atlas and "311/311" in atlas, (
    "Historical main/blob provenance checkpoints missing"
)
print("PASS: one-roof H5/G2, whole-Koru, Hillary, original-six and Guardian source atlas intact.")

print("PASS: agents/readers first reach full Koru, original summit and original six X3.")
