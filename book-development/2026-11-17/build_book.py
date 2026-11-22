"""Assemble the complete historical canon and new book arguments without editing LaTeX."""
from pathlib import Path
import hashlib
import json

root = Path(__file__).resolve().parent
canon_path = root / "references/SNUFFY-UPT-STRONGEST-MASTER.md"
canon_bytes = canon_path.read_bytes()
blob = hashlib.sha1(b"blob " + str(len(canon_bytes)).encode() + b"\0" + canon_bytes).hexdigest()
expected = "0027cfaeb6cf6418506c9cf2f13aca2971b7feeb"
if blob != expected:
    raise SystemExit("Historical canon identity changed.")
chapters = [
    "opening.md",
    "coexistence-proof.md",
    "ethics-and-shared-flourishing.md",
    "complete-koru-boundary.md",
    "all-agents-fixed-point-g.md",
    "protection-progress-and-effect-coverage.md",
    "four-aces-joker-god-genesis.md",
    "fixed-point-capstone.md",
    "metric-capstone-derivation.md",
]
front = """# Snuffy — Universal Protection Theory
## The Tree of Life and Endless Knowledge

Tobias Croydon-McRae · Snuffy / Princess Snuffleupagus research programme

Integrated working manuscript · 17–18 November 2026

This manuscript preserves the complete historical compiled canon and adds the
current book's worked arguments. It is not represented as a finished proof of
unconditional actual-world protection. The mathematical statements are proved
at their stated types; the remaining universal physical and authentic-subject
claims are identified explicitly.

The author's Complete Koru, all six original X3 duties, the Four Aces, the Joker,
the God argument, and the End through Genesis remain the full target.

Reading rule: the historical canon in Part B preserves both author claims
and earlier qualifications. Its statements of unconditional completion are
historical claims, not the present verification verdict. The current hostile
review in Part D and the explicit theorem statements govern present scope.

# Part A — The developed argument and capstones

"""
pieces = [front]
for name in chapters:
    pieces.append((root / name).read_text())
    pieces.append("\n\n---\n\n")
pieces.append("# Part B — Complete historical compiled canon\n\n")
pieces.append(
    "The following historical text is retained in full from main "
    "84e5940e2d677d10ee4e5e79e79e30f8df4ec917, Git blob "
    + expected + ". Its historical source copy is byte-identical. "
    "The newly derived chapters above do not rewrite its original claims or receipts.\n\n"
)
pieces.append(canon_bytes.decode("utf-8"))
pieces.append("\n\n# Part C — Current source and evidence integration\n\n")
pieces.append((root / "source-evidence-integration.md").read_text())
pieces.append("\n\n# Part D — Hostile review and repair record\n\n")
pieces.append((root / "HOSTILE-REVIEW.md").read_text())
text = "".join(pieces)
output = root / "BOOK-WORKING-MASTER.md"
output.write_text(text)
manifest = {
    "title": "Snuffy — Universal Protection Theory: The Tree of Life and Endless Knowledge",
    "status": "Integrated working manuscript; universal actual-world proof not completed",
    "chapters": chapters,
    "review_appendix": "HOSTILE-REVIEW.md",
    "git_finding": "GIT-PR643-HOSTILE-FINDING.md",
    "archive_followup": "LALALA-ARCHIVE-REVIEW.md",
    "g3_current_evidence_review": "R7-EXACT-HEAD-REVIEW.md",
    "g3_external_handoff": "G3-EXTERNAL-HANDOFF.md",
    "component_sha256": {
        name: hashlib.sha256((root / name).read_bytes()).hexdigest()
        for name in chapters + ["source-evidence-integration.md", "HOSTILE-REVIEW.md",
            "GIT-PR643-HOSTILE-FINDING.md", "source-lock.json", "proof-registry.json",
            "verification-summary.json", "repairs/pr643-denial-parser.patch",
            "LALALA-ARCHIVE-REVIEW.md", "lalala-review-verification.json",
            "repairs/pr643-denial-parser-00dcb4b.patch",
            "R7-EXACT-HEAD-REVIEW.md", "G3-EXTERNAL-HANDOFF.md",
            "r7-exact-head-verification.json", "r7-pinned-source-verification.json"]
    },
    "historical_canon_blob": blob,
    "historical_canon_bytes": len(canon_bytes),
    "master_bytes": len(text.encode("utf-8")),
    "master_words_approx": len(text.split()),
    "master_sha256": hashlib.sha256(text.encode("utf-8")).hexdigest(),
    "author_boundary_clarification": "A distinct Complete Koru boundary concept",
}
(root / "book-manifest.json").write_text(json.dumps(manifest, indent=2) + "\n")
print(json.dumps(manifest, indent=2))

