# M3 Lemma-13 margin analysis — floor vs J₃ is TIGHT in 3D (risk flag)

Tests the central claim of the corrected route (`WARMSTART-M3-BLOCK-RECONCILIATION`):
that Lemma 13's contradiction closes in 3D "with only the constants replaced."
Tool: `tools/bdl_junction_margin.py` (CI-gated on the measured constants; makes
**no** closure claim). No Lean claim.

## The mechanism and what it needs

Lemma 13's contradiction: a nontrivial chain has weight `≥ floor`, but an
R-injective hull is confined to one coarse junction holding `≤ J₃` regions, so
`floor ≤ J₃` — a contradiction **iff `floor > J₃`**. In 2D: `floor = 4`,
`J₃ = 3` (check degree ≤ 3), margin `+1`.

## Measured in 3D (PR #215 complex, coarse = level 1)

`floor = 5` (min closed-membrane weight, constant ℓ=3,5,7; #234). J₃ candidates:

| J₃ candidate | ℓ=3,5,7 level 1 | level 2 | margin `floor − J₃` |
| --- | --- | --- | --- |
| bit→region fan-out `max\|δ¹(b)\|` | **4** | **4** (stable) | **+1** (holds) |
| C²-check degree | 4 | 5 | +1 → **0** (fails at L2) |
| C⁰-check degree | 5 | 6 | **0 → −1** (fails) |

## Finding (honest, and it's a risk flag)

**The optimistic 2D value `J₃ = 3` does NOT transfer.** 3D junctions fan out to
**4–6**. The margin `floor > J₃` is **tight (≤ 1) and its sign depends on which
junction notion is the true J₃**:

- It holds (`+1`) **only** under the **bit→region fan-out** identification —
  which is also the **only** candidate that stays `≤ 4` at every level and scale.
- Under either **check-degree** identification it is `≤ 0` and **fails at
  level 2** (check degrees grow with the hierarchy: C⁰ 5→6, C² 4→5).

So Lemma 13's 3D closure is **not** the comfortable "replace 3 with a slightly
bigger constant" the route assumed. It hinges on (a) the precise J₃ being the
bit→region fan-out (stable 4), not a check degree, and (b) that staying `< 5` as
ℓ, level → ∞. Both are **construction questions** for the lane holding the
source — not settleable by measurement. This document flags the risk with the
measured constants; it asserts no closure.

## What would settle it (for the source-holding lane)
1. Which graph is the R-injective hull confined in — regions=C² with junctions =
   shared C¹ bits (fan-out 4), or a check-degree junction (5–6)? The 2D proof's
   "check degree ≤ 3" must be mapped to the right 3D object.
2. Does the chosen J₃ stay `< floor` as level → ∞? The check degrees already
   grow at level 2; the bit→region fan-out does not (stays 4) — that stability
   is the crux.

## Reproduce
`python3 evidence/compiled-strongest/tools/bdl_junction_margin.py` — JSON with
floor, J₃ candidates, and margins; asserts the measured constants (floor 5,
bit-fanout 4) are stable; **makes no closure assertion**.
