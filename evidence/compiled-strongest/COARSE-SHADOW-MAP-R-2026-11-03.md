# Coarse-shadow map R — reconstruction and block structure (3 November 2026)

First brick of the 3D Appendix-B analogue (program doc "main work item"):
reconstruct the coarse-shadow map R from PR #215's replacements. Tool:
`tools/bdl_coarse_shadow.py` (stdlib, CI-gated on `R_total`).

## What R is (construction-derived, not invented)

The hierarchy is built by successive replacement: level 1 = `replace_x(seed)`;
level 2 = `replace_z(level1.tanner)`. Every level-2 cell has the form
`(type, <level-1 element>, <subdivision detail>)`, so the coarse-shadow map is
the **label projection**:

```
R(cell) = cell[1]        # the level-1 element the cell is built over
```

This is derived from the construction, not chosen to make a property hold.

## Established (finite, exact, ℓ=3,5)

- **R is well-defined and total** (`R_total = true`): every level-2 cell projects
  to a valid level-1 cell.
- **R is a mixed-grade cellular projection, not a degree-preserving chain map.**
  The grade map (ℓ=3) is `L2g0→{L1g2:480, L1g1:312, L1g0:48}`,
  `L2g1→{L1g2:1008, L1g1:328}`, `L2g2→{L1g2:588}`. The spread across grades is
  the X/Z duality of the hierarchy (level 2 is the Z-side dual of level 1); a
  faithful chain-map treatment must account for that dualisation.
- **Block (fiber) structure measured:**

  | over L1 grade | block size (ℓ=3) | block size (ℓ=5) | scaling |
  | --- | --- | --- | --- |
  | 0 | 2 (constant) | 2 (constant) | flat |
  | 1 | 7–12 (mean 10.7) | 11–20 (mean 18.5) | grows |
  | 2 | 39–66 (mean 54.6) | 107–194 (mean 168.5) | **≈ ℓ²** |

  The grade-2 cover block (the A_ℓ-like cover constant) scales ≈ ℓ² (×3.07 for
  ℓ 3→5 vs ℓ²'s ×2.78) — the per-level 2D signature, consistent with
  `MEMBRANE-EXACTNESS-TOOLKIT`'s `dim C² ≈ 2ℓ²`.

## OPEN — named, not done, not claimed

- **Hull function `l_i`.** The BDLT paper (arXiv:2610.22548) defines a geometric
  hull with a "≤ 3 block-spins" bound; **the paper is not in this repo** and the
  hull is not precisely defined in any repo doc. Defining `l_i` as mere support
  size would trivialise monotonicity and misrepresent Lemma 13 — not done here.
- **Shadow-monotonicity `l_i(R(X)) ≤ l_{i+1}(X)`** as a lemma — pending `l_i`.
- **3D hull-decrease Lemma 13** (`l_{i+1} − l_i∘R ≥ 1`, "the one genuinely new
  2D-free lemma") — the key open research result; R here is its substrate only.

## Reproduce
`python3 evidence/compiled-strongest/tools/bdl_coarse_shadow.py` — prints the
per-ℓ JSON, asserts `R_total`, exits non-zero if R is not total.
