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
print("PASS: agents/readers first reach full Koru, original summit and original six X3.")
