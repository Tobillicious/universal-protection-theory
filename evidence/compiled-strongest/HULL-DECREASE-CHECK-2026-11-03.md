# Hull-decrease check (Lemma 13 analogue) — ℓ=3,5 (3 November 2026)

Hull function (author's definition, 2026-11-03): **`l_i(X) = number of level-i
blocks X touches`**. Blocks = cells; coarse-shadow `R: level-2 → level-1` is the
label projection `R(cell)=cell[1]` (see `COARSE-SHADOW-MAP-R`). Tool:
`tools/bdl_hull_decrease.py` (CI-gated). Tested on **every** nonzero combination
of the level-2 closed-membrane generators (ker ∂₂).

## Result

| ℓ | #nontrivial chains | shadow-monotone (dec ≥ 0) | min hull-decrease | dec ≥ 1 |
| --- | --- | --- | --- | --- |
| 3 | 7 | ✅ | **61** | ✅ |
| 5 | 7 | ✅ | **165** | ✅ |

`l_2(X) − l_1(R(X)) ≥ 1` holds for all tested nontrivial closed membranes, and
shadow-monotonicity holds.

## ⚠ Honest reading — this is NOT "Lemma 13 verified"

The decreases are **huge (61–224), not ~1.** Lemma 13 guarantees `≥ 1`; a 60–220×
overshoot is a structural tell, not a triumph:

- My `R` collapses a **whole replacement level** — block sizes are 39–169 fine
  cells per coarse cell (`COARSE-SHADOW-MAP-R`). Any sizeable chain's hull then
  plummets automatically.
- Lemma 13's proof bounds the coarse-grained hull by **≤ 3 block-spins** — i.e.
  the coarse-graining it concerns merges ≤ 3 fine blocks per coarse block, a
  **single RG step**, not a whole-level collapse.

**Therefore:** what is verified here is shadow-monotonicity + a ≥1 hull-decrease
**at the level-1↔level-2 (whole-replacement) granularity.** Whether that is the
"adjacent levels i, i+1" of Lemma 13 — in which case the inequality is confirmed
— or whether the lemma concerns a finer single-RG-step coarse-graining (≤3
blocks, decrease ~1) that my `R` is too coarse to represent, is an **OPEN
question** I cannot settle without the BDLT RG-step definition (paper not in
repo).

## What is and isn't established
- ✅ `l_i` computed per the author's definition; `R` from the construction.
- ✅ Shadow-monotonicity and `≥1` hull-decrease at whole-level granularity, ℓ=3,5.
- ❌ NOT Lemma 13 for all ℓ (that is the junction/crossing analysis).
- ❓ OPEN: the correct RG-step granularity. The ≤3-block-spin structure suggests
  a single-step coarse-graining finer than level-1↔level-2; building it needs the
  paper's RG-step map (or author guidance). **Flag for the parallel worker.**

## Reproduce
`python3 evidence/compiled-strongest/tools/bdl_hull_decrease.py` — per-chain JSON;
asserts monotonicity and `decrease ≥ 1`; exits non-zero on any violation.
