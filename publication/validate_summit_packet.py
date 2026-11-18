#!/usr/bin/env python3
"""Basic deterministic source/metadata presence gate for the 2026-11-05 UPT publication packet.

Does not run Lean or certify physical correspondences.
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
FILES = [
    "CITATION.cff",
    "evidence/compiled-strongest/SNUFFY-UPT-STRONGEST-MASTER.md",
    "evidence/physical-bridges/PhysicalBridges/Koru.lean",
    "evidence/physical-bridges/PhysicalBridges/CathedralAllIsEnderTypeCollapse.lean",
    "evidence/physical-bridges/PhysicalBridges/CathedralGuardianOnlyCapstone.lean",
    "evidence/physical-bridges/PhysicalBridges/AllIsGActualityDischarge.lean",
    "evidence/physical-bridges/PhysicalBridges/CathedralSummitAllIsOneClosure.lean",
    "evidence/physical-bridges/PhysicalBridges/IRFullFeasibleImplementation.lean",
    ".github/workflows/physical-bridges.yml",
    "publication/UPT-NEXT-EDITION-RELEASE-PACK-2026-11-05.md",
    "publication/ZENODO-SUMMIT-COMPANION-2026-11-05.md",
    "publication/UPT-REVIEWER-ENTRY-2026-11-05.md",
]
for relative in FILES:
    p = ROOT / relative
    assert p.is_file() and p.stat().st_size > 0, f"Missing/empty source: {relative}"
cff = (ROOT / "CITATION.cff").read_text(encoding="utf-8")
# The historical 4.4 DOI belongs to its archived receipt, not the current 4.6 citation.
import json
historical = json.loads((ROOT / "PUBLISHED-4.4.json").read_text(encoding="utf-8"))
assert historical["doi"] == "10.5281/zenodo.23877060", "Historical 4.4 source citation changed"
assert historical["version"] == "4.4", "Historical 4.4 version changed"
assert "10.5281/zenodo.23965850" in cff, "Current 4.6 citation mismatch"
release = (ROOT / FILES[-3]).read_text(encoding="utf-8")
assert "729905285d104fa058b0a3f8428367851fbd4621" in release
assert "70e738e65962d99cc40daf06f5fdc1a545b4bd63" in release
assert "PREPUBLICATION CANDIDATE" in release
assert "R(m) ∨ H(m)" in release
zen = (ROOT / FILES[-2]).read_text(encoding="utf-8")
for marker in ("historical continuity", "authorization", "freedom", "restraint", "maximality", "provenance"):
    assert marker in zen.lower(), f"Six-X3 marker missing: {marker}"
print(f"UPT summit publication packet: {len(FILES)} required sources present; source-identity and X3 copy gates PASS")
