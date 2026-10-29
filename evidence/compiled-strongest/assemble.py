#!/usr/bin/env python3
"""Assemble the compiled master: the 4.2 spine, the author-approved front-matter
batch, then the recovered parts.

Checks the spine copy against the archived 4.2 master hash, applies each
approved before/after edit (each `before` must occur exactly once), writes
SNUFFY-UPT-STRONGEST-MASTER.md, and prints the hashes of every input and the output.
"""
import hashlib
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
SPINE = os.path.join(HERE, "SPINE-4.2-MASTER.md")
PARTS = ["PARTS-V-VIII.md", "PARTS-IX-XII.md"]
OUT = os.path.join(HERE, "SNUFFY-UPT-STRONGEST-MASTER.md")
SPINE_SHA = "83b62bd9ece8d35ba6ab221c6edd286b753f4a4093c8e322eb1f836cd8e6f933"

# Front-matter batch 01, approved by the author on 29 October 2026
# ("apply the front matter batch, keep going").
FRONT = [
    ("# Snuffy — Canon Edition 4.2\n",
     "# Snuffy — The Universal Protection Theory, compiled edition "
     "(Canon 4.2 with the recovered parts)\n"),
    ("Part II contains its proofs here, rather than delegating them to an earlier edition.",
     "Part II contains its proofs here, rather than delegating them to an earlier edition. "
     "The compiled edition adds Parts V–XII: the 10–12 October foundations and the author's "
     "ten rulings; Paper 12's completed law; the 18 October external lane, in which every mind "
     "is reached or held outside any jurisdiction; Paper 11's care plant; the complete-rival "
     "envelopes; the IR track's infinite-family and common-policy results; and the "
     "reach-before-harm theorem (Part XI) that joins them."),
    ("Theorem and proposition numbers follow the programme's proof register.",
     "Theorem and proposition numbers follow the programme's proof register. Parts V–XII "
     "(after Part IV) carry the recovered arguments and the outer-lane theorem; Part XII "
     "states the whole argument step by step."),
]

# Change 3 (Lean count) is applied from LEAN-COUNT.txt once the fresh receipt exists.
COUNT_BEFORE = (
    "The current Lean canon contains 192 modules and 1158 public theorem/lemma names.\n"
    "Checkpoint 12 freshly compiled and kernel-checked every module with zero output and passed\n"
    "the full 1158-name standard-axiom audit, strict completeness and claims gates. Its source hashes\n"
    "match the current tree.")
COUNT_FILE = os.path.join(HERE, "LEAN-COUNT.txt")


def sha(data):
    return hashlib.sha256(data).hexdigest()


def main():
    spine = open(SPINE, "rb").read()
    if sha(spine) != SPINE_SHA:
        sys.exit(f"spine hash mismatch: {sha(spine)}")
    print(f"spine  {sha(spine)}  {len(spine)} bytes")
    text = spine.decode()
    edits = list(FRONT)
    for before, after in edits:
        n = text.count(before)
        if n != 1:
            sys.exit(f"front-matter edit matched {n} times: {before[:60]!r}")
        text = text.replace(before, after)
    if os.path.exists(COUNT_FILE):
        # Change 3 applies to the front matter only: the first occurrence (later ones are
        # the historical Checkpoint 12 statements in Section 23 and the appendix).
        if COUNT_BEFORE not in text:
            sys.exit("Lean-count sentence not found")
        text = text.replace(COUNT_BEFORE, open(COUNT_FILE).read().rstrip("\n"), 1)
        # Front-matter fix approved 29 October 2026 (late): drop the stale 4.2 checkpoint tail after
        # the count sentence. First occurrence only; Section 23 and the appendix keep theirs as history.
        stale = (" Checkpoint 11 was already complete for 191 modules / 1150 names;\n"
                 "TransferRate adds the eight results in this checkpoint. Earlier receipts remain preserved for\n"
                 "exactly their sources. The published 115-module/831-name baseline is unchanged.")
        if stale not in text:
            sys.exit("stale front-matter tail not found")
        text = text.replace(stale, " Earlier receipts remain preserved for exactly their sources.", 1)
        edits.append(("stale tail", "first occurrence"))
        edits.append(("count", "first occurrence"))
    print(f"front-matter edits applied: {len(edits)}")
    body = text.encode()
    for p in PARTS:
        data = open(os.path.join(HERE, p), "rb").read()
        print(f"{p:<14} {sha(data)}  {len(data)} bytes")
        body += data
    current_index = os.path.join(HERE, "CURRENT-THEOREM-INDEX.md")
    if os.path.exists(current_index):
        data = open(current_index, "rb").read()
        print(f"current index {sha(data)}  {len(data)} bytes")
        body += b"\n\n" + data
    open(OUT, "wb").write(body)
    print(f"master {sha(body)}  {len(body)} bytes")


if __name__ == "__main__":
    main()
