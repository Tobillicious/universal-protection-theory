#!/usr/bin/env python3
"""Prevent the original complete-law navigation from regressing to legacy editions."""
from pathlib import Path

root = Path(__file__).resolve().parents[1]
required_files = [
    "AGENTS.md", "THE-LAW-START-HERE.md", "README.md", "llms.txt",
    "QED-ONE-ROAD-EXACT-SOURCE-RUNWAY-2026-11-07.md",
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
# All four first-read surfaces must agree on the newest exact source graph.
for name, body in [("README.md", readme), ("llms.txt", llms), ("AGENTS.md", agents), ("THE-LAW-START-HERE.md", guide)]:
    assert "QED-ONE-ROAD-EXACT-SOURCE-RUNWAY-2026-11-07.md" in body, f"{name}: omitted one-road current proof runway"
assert "HILLARY-ROUTE-A-B-SUMMIT.md" in guide
for name, body in [("THE-LAW-START-HERE.md", guide), ("llms.txt", llms), ("AGENTS.md", agents)]:
    for needle in ["#360", "#364", "#365", "Part XV", "OriginalX3"]:
        assert needle in body, f"{name}: missing {needle}"
for needle in ["historical continuity", "authorization", "freedom", "restraint", "maximality", "provenance"]:
    assert needle in guide.lower(), f"Full six-X3 term lost: {needle}"
# Keep archived 4.4 and 4.6 as immutable historical records.
# Current v5.1 metadata is pinned separately from the archived v4.6 release.
import json
historical_46 = json.loads((root / "release-v4.6.json").read_text())
archived_release = json.loads((root / "PUBLISHED-4.4.json").read_text())
assert historical_46["version"] == "4.6.0", "Historical 4.6 version changed"
assert historical_46["identifier"] == "10.5281/zenodo.23965850", "Historical 4.6 DOI changed"
assert "version: 5.1.0" in cff, "Current CFF version mismatch"
assert "doi: 10.5281/zenodo.24357635" in cff, "Current CFF DOI mismatch"
assert "https://doi.org/10.5281/zenodo.24357635" in readme, "README current DOI mismatch"
assert archived_release["doi"] == "10.5281/zenodo.23877060", "Archived 4.4 DOI changed"
assert archived_release["version"] == "4.4", "Archived 4.4 version changed"
assert "10.5281/zenodo.23877060" in llms
assert llms.index("THE-LAW-START-HERE.md") < llms.index("Snuffy 2.0")
assert "Latest public compiled edition — 29 October 2026" not in readme
print("PASS: agents/readers first reach full Koru, original summit and original six X3.")
