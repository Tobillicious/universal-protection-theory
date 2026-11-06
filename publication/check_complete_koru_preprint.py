#!/usr/bin/env python3
"""Mechanical integrity checks for Complete-Koru preprint publication packet.

NOT a proof of ontology, BCRD physical applicability, or original six X3.
Checks source fidelity, cross-links and minimum packet integrity only.
"""
from __future__ import annotations

import hashlib
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PUB = ROOT / "publication"
PAPER = PUB / "COMPLETE-KORU-OBJECTIVE-WHOLE-PREPRINT-2026-11-06.md"
CROSSWALK = PUB / "COMPLETE-KORU-SOURCE-AND-CLAIM-CROSSWALK-2026-11-06.md"
PACKET = PUB / "COMPLETE-KORU-ZENODO-AND-REFEREE-RELEASE-PACKET-2026-11-06.md"
SUMMIT = ROOT / "evidence/compiled-strongest/PARTS-XV-SUMMIT.md"
# This is the original main-branch summit-companion blob SHA, not a PDF/text digest.
FROZEN_SUMMIT_BLOB = "6464dfbb08825a1f12dbc1a3c63dad33cb6ee98b"
ORIGINAL_COMMIT = "729905285d104fa058b0a3f8428367851fbd4621"
MAIN_BASE = "9088d9a855390f6505f44d7e2a75909691c7e618"

def fail(message: str) -> None:
    print(f"FAIL: {message}", file=sys.stderr)
    raise SystemExit(1)

def must(text: str, needle: str, label: str) -> None:
    if needle not in text:
        fail(f"{label} missing required retained source text: {needle}")

def validate() -> None:
    for file in (PAPER, CROSSWALK, PACKET, SUMMIT):
        if not file.is_file():
            fail(f"missing: {file.relative_to(ROOT)}")
    paper, ledger, packet = (p.read_text(encoding="utf-8") for p in (PAPER, CROSSWALK, PACKET))
    # Preserve source, not its title or an asserted restore state.
    sha = subprocess.check_output(["git", "hash-object", str(SUMMIT)], cwd=ROOT, text=True).strip()
    if sha != FROZEN_SUMMIT_BLOB:
        fail(f"historical summit blob modified: got {sha}, expected {FROZEN_SUMMIT_BLOB}")

    for label, s in (("paper", paper), ("ledger", ledger), ("release", packet)):
        must(s, "Complete Koru", label) if label != "paper" else must(s, "The Complete Koru", label)
        must(s, ORIGINAL_COMMIT, label)
        must(s, "X3", label)
        if len(s) < 4000:
            fail(f"{label} too short to be the intended complete packet")

    for needle in (
        "ALL IS", "ALL DISTINCT", "ALL IS ONE", "operators",
        "God", "Gravity", "Guardian", "Hume", "Archimedes",
        "thermodynamics", "Hilbert", "black hole", "circular",
        "Historical continuity", "Authentic authorization",
        "Freedom", "restraint", "maximality", "Provenance",
        "R(m) ∨ H(m)", "theorem", "Absolute E",
    ):
        if needle.lower() not in paper.lower():
            fail("paper dropped part of complete argument: " + needle)
    for needle in ("#341", "#355", "#358", "#359", "42137629766",
                   "Strong", "Absolute", "no", "authentic", "same-particular"):
        if needle.lower() not in ledger.lower():
            fail("crosswalk missing named source/claim context: " + needle)
    for needle in ("Zenodo", "author", "approval", "PDF", "DOI", "Publish", "Snuffy"):
        if needle not in packet:
            fail("deposit packet missing: " + needle)
    if MAIN_BASE not in ledger:
        fail("ledger omits exact frozen-main source anchor")

    files = (PAPER, CROSSWALK, PACKET)
    bad_links = []
    link_rx = re.compile(r'\[[^\]]+\]\(([^)]+)\)')
    for file in files:
        for link in link_rx.findall(file.read_text(encoding="utf-8")):
            url = link.strip().split("#", 1)[0]
            if not url or "://" in url or url.startswith("mailto:"):
                continue
            target = (file.parent / url).resolve()
            if not target.is_relative_to(ROOT.resolve()) or not target.exists():
                bad_links.append((file.name, link))
    if bad_links:
        fail("bad relative Markdown links: " + repr(bad_links))

    for file in files:
        digest = hashlib.sha256(file.read_bytes()).hexdigest()
        print(f"OK {file.relative_to(ROOT)} SHA256 {digest}")
    print(f"OK exact historical summit blob {sha}")
    print("PASS publication text/source-link/freeze-marker integrity ONLY.")
    print("NOT an independent confirmation of universal physical UPT or new Zenodo DOI.")

if __name__ == "__main__":
    validate()
