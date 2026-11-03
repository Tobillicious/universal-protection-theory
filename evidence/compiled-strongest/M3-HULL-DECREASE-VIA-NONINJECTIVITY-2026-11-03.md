# M3 hull-decrease at ℓ=3,5 via R-non-injectivity — the easy case closes (3 November 2026)

A genuine positive result on Lemma 13, and it **sidesteps the fragile J₃** for
the objects at hand. Tool: `tools/bdl_r_noninjective.py` (CI-gated). No Lean claim.

## The argument (uses only Lemma 9's structure-generic chain)

Lemma 9(3)'s inequality chain (which the corrected route confirms transfers to
3D as-is):

```
l_i(R(X))  ≤  |R(H_{i+1}(X))|  ≤  |H_{i+1}(X)|  =  l_{i+1}(X)
```

Equality (i.e. **no** hull-decrease) forces `R` injective on the hull
`H_{i+1}(X)`. The hull contains `X`, so:

> **If `R` is non-injective on `supp X`, then it is non-injective on `H ⊇ X`,
> so `|R(H)| < |H|`, the chain is strict, and `l_i(R(X)) < l_{i+1}(X)` — strict
> hull-decrease — with no appeal to J₃ or the weight floor.**

## Measured (ℓ=3,5, level-2 closed membranes)

`R` (= `cell[1]`, #228) is **non-injective on `supp X` for every nontrivial
closed membrane** `X` (all `2³−1` nonzero combinations of the `ker ∂₂`
generators):

| ℓ | all nontrivial membranes R-non-injective? | min collapse `|supp|−|R(supp)|` |
| --- | --- | --- |
| 3 | ✅ | 61 |
| 5 | ✅ | 165 |

So the strict hull-decrease holds for **all** of them directly.

## Why this matters, and its honest limits

- It shows Lemma 13's **conclusion holds at ℓ=3,5 for the whole closed-membrane
  sector**, via a route that **does not touch J₃ or the floor** — so the tight,
  at-risk `floor > J₃` margin flagged in `M3-JUNCTION-MARGIN` (#236) is **moot
  for these objects**.
- **Scope — this is only the R-non-injective case.** The J₃/floor machinery
  exists for the **R-injective** case (a minimal chain confined where R is 1-1).
  That case does **not** arise here — the block sizes (39–169) make R collapse
  every membrane — but it remains the general obstruction, and #236's margin is
  the live risk there. This result does **not** resolve it.
- **Not a proof for all ℓ.** It needs R-non-injectivity proven for *every*
  nontrivial membrane at every scale (plausible given the collapse grows with ℓ,
  but measured, not proven here).
- It is the **correct** reading of the collapse data the retracted support-size
  check fumbled: not `l_i` itself, but R-non-injectivity feeding Lemma 9.

## Reproduce
`python3 evidence/compiled-strongest/tools/bdl_r_noninjective.py` — per-membrane
JSON; asserts R non-injective on all nontrivial membranes (fails, pointing to
the live J₃/floor case, if any membrane is R-injective).
