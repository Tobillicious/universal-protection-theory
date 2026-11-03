# The 𝒲̂-sector weight floor — precise task specification (3 November 2026)

Converts "the strict Lemma-8 floor" from a name into a computable task on
the reconstructed complex, with the level-1 value already verified by two
independent implementations. No rushed numbers here — every probe on this
quantity must assert closure/membership at each step (the discipline bought
today by the 4/4/6 incident).

## Definitions on our complex (level j, chain side)

Work on the Z-side 1-chains (qubit chains, C¹), which is where the 2D
paper's Lemma 8 floor lives (Wilson loops; §4.2 rail projections p^a, lift L):

- **Fully gauge-invariant** (products of checks): K₁ = im(δ¹ᵀ) ⊆ C¹ — the
  span of the Z-check incidence vectors (the `cols` of the membrane work).
- **Commuting with all X-gauge**: ker(δ⁰ᵀ) — chains whose parity over every
  X-check's qubit set is even.
- **Partially invariant, not fully**: 𝒲̂ = ker(δ⁰ᵀ) ∖ K₁.
- **The floor**: f_j = min over w ∈ 𝒲̂ of min over u ∈ K₁ of |w + u|
  (coset minimum = the minimum weight of a nontrivial Z-logical at that
  level, since the logical space is exactly ker(δ⁰ᵀ)/K₁).

## Verified so far

- **Level 1: f₁ = d_Z = 4, exact at ℓ = 3.** Verified twice: #232's
  exhaustive low-weight clearing, and this lane's independent enumeration
  (0 Z-logicals at weights 1–3; 8 at weight 4, single coset).
- Membrane-side margin (distinct quantity): closed-membrane min weight 5,
  constant in ℓ (#234 + independent reproduction).

## The task

Lemma 13's contradiction at induction step i needs f_{i+1} > J₃. So:

1. **Compute or bound f₂** on the level-2 complex
   (`replace_z(replace_x(seed(), L).tanner, L)`; C¹ mixes `("xe",…)` and
   `("qv",…)` cells — the alternating duality makes the sector definition
   above carry over verbatim, but the support structure changes).
   Direct enumeration is hopeless (C¹ dim 3620 at ℓ=3); the tractable
   route is the **rail-projection analogue**: restrict to the fibre over
   the lift of a level-1 𝒲̂ representative and minimise the coset
   restricted to that fibre — exactly the content of the 2D proof's
   p^a/L machinery. Any such probe must verify: (a) the candidate is in
   ker(δ⁰ᵀ) at level 2; (b) it is not in K₁; (c) the fibre actually
   carries the full coset freedom (else the bound is only upper).
2. **Growth**: show f_{j+1} ≥ f_j · c_rail (the 2D factor is 2 per level,
   giving 2^{n−i+1}) or at minimum f_{j+1} > J₃ for all j up to the
   induction depth. The constant-in-ℓ behaviour of the membrane kernel
   does NOT transfer automatically — floors grow, kernels don't; keep the
   two distinct.
3. **J₃**: falls out of the R-injective hull confinement (hull lane,
   in progress). Once J₃ and f₂ are both measured, the level-1→2 base
   case of the 3D Lemma 13 either closes or reports its first honest
   obstruction.

## Standing warnings

- Probe code must assert: membership in ker(δ⁰ᵀ), non-membership in K₁
  (span test against the verified Z-incidence basis), and exact coset
  minimality within whatever support class is searched. Print the
  assertions' outcomes, not just the weights.
- Every number that enters a doc must be reproducible by a second
  implementation or CI gate before it is cited (this document's f₁ = 4
  satisfies that; anything new must too).

No Lean claim. This is a specification, not a result.
