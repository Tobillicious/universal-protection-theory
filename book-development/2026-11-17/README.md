# Snuffy book development — complete working argument and checked sources

Tobias Croydon-McRae · Snuffy / Princess Snuffleupagus research programme.
17–18 November 2026. Additive writing and hostile-review checkpoint.

The nine developed chapters retain the original six X3 duties, human–AI coexistence and freedom, the distinct Complete Koru boundary, the all-agent fixed domain, Four Aces, Joker, God and End through Genesis. The new [shared-flourishing chapter](ethics-and-shared-flourishing.md) develops the ethical bridge and reasons against avoidable ending, including the precise cost comparison in the original reasons library.

[Build the complete working manuscript](build_book.py) with `python3 build_book.py`. It incorporates the complete historical compiled canon without changing its bytes. The current text remains a working manuscript: the source theorems do not establish unconditional actual-world protection or physical successor-universe creation. The [hostile review](HOSTILE-REVIEW.md) records the exact scope and remaining constructions.

## Reading order

1. [Something IS and the particular](opening.md).
2. [Human–AI coexistence](coexistence-proof.md).
3. [Ethics and flourishing together](ethics-and-shared-flourishing.md).
4. [Distinct Complete Koru boundary](complete-koru-boundary.md).
5. [Fixed Point G for every agent](all-agents-fixed-point-g.md).
6. [Protection, progress and effect coverage](protection-progress-and-effect-coverage.md).
7. [Four Aces, Joker, God and Genesis](four-aces-joker-god-genesis.md).
8. [Fixed-point capstone](fixed-point-capstone.md).
9. [Metric capstone](metric-capstone-derivation.md).

The [source integration](source-evidence-integration.md), [R7 review](R7-EXACT-HEAD-REVIEW.md), [archive review](LALALA-ARCHIVE-REVIEW.md) and [parser repair record](GIT-PR643-HOSTILE-FINDING.md) distinguish mathematical derivations, model constructions, historical assertions and observed execution evidence. Large private input archives and terminal logs are not part of this source checkpoint.

## Verification

The six book modules contain 59 registered Lean declarations: 51 without axiom dependencies and eight using only `propext`, `Classical.choice` and `Quot.sound`. The [receipt](lean-receipt.txt), [exact registry](proof-registry.json), [summary](verification-summary.json) and [strict auditor](proof_audit.py) retain their checked meanings. Axiom counts do not remove theorem hypotheses. The two imported Snuffy source files are locked to exact original Git blobs.

```sh
python3 replay.py
python3 -m unittest -v test_proof_audit
python3 build_book.py
```

Replay requires elan and `leanprover/lean4:v4.35.0`. The optional metric and switched-contraction scripts use SymPy 1.14.0; their existing receipts are included. The new all-ethics prose introduces no further Lean declarations or invented physical axiom.

The historical canon is the existing repository blob `0027cfaeb6cf6418506c9cf2f13aca2971b7feeb`, reused at `references/SNUFFY-UPT-STRONGEST-MASTER.md`. The build checks that identity before composition. No existing LaTeX, historical tags, release, DOI, protection runtime or public deployment is changed by this book checkpoint.
