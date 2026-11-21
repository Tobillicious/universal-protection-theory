# BDL level-2 two-layer exact Gibbs proposal: disjoint sphere + endpoint factorisation

Date: 3 November 2026
Status: **exact normalized two-layer finite-source-cell sampler; 2c remaining constraints OPEN**.
Stacked on draft PR #219 (exact quotient plus fixed-temperature failure of sphere-only rejection), then #218→#216→#215. New files only; no canonical X3 or publication changes.
Primary model: Balasubramanian, Davydova & Lin, arXiv:2605.10943v1, §3.2 Tanner-square replacement and cochain incidence.

## 1. Why the second layer is real, not an assumed independence

From PR #218, level-2 hard-sector syndrome constraints contain c=8L²+12L+2 independent disjoint spherical parity rows S_z, all on X-syndrome sites of type xf. From PR #219, **every** first-level X-check x gives a full-code endpoint relation

    R_x = { (zv,x,0),(zv,x,1) }
          ∪ { (qe,q,e_vertical(q,x)) : q∈N_X(x) }.

The cochain/Tanner incidence proof establishes R_x is an actual metacheck, not an added duty. Distinct R_x have disjoint syndrome supports and none touches any S_z, since the R_x sites are only qe/zv and S_z sites only xf. Thus all c+e rows, where e=|X_1|=8L²+12L+4=c+2, are linearly independent, are present in the original full metacheck row space, and their parity constraints are on **pairwise disjoint coordinate blocks**. No metacheck is dropped from the ultimate target.

The full original relation rank is r=32L²+48L+10=4c+2 (PR #216). Conditioning on these disjoint rows in the proposal therefore reduces the as-yet-unenforced residual rank to

    d_2 = r−(c+e) = (4c+2)−(2c+2) = 2c
        =16L²+24L+4.

This is **the exact quotient rank**, not a heuristic count.

## 2. All-subdivision exact normalized Gibbs factorisation

Write z>0 rational for the syndrome fugacity; Z_even(k,z)=[(1+z)^k+(1−z)^k]/2.

The source-cell endpoint parity relations have the following exact sizes, proved by the four-sheet local vertex-category count and checked at L=1..4 in PR #219:

    N_5=8L−4;
    N_6=8L²−12L+12;
    N_7=16L−4.

They sum to e=c+2. Sphere blocks all have size s=8L(L+1). The number of hard-syndrome coordinates is

    m=64L⁴+256L³+336L²+160L+24.

The endpoint blocks consume

    5 N_5 + 6 N_6 + 7 N_7 = 48L²+80L+24

additional coordinates, none of which belongs to a sphere. Hence the remaining unconstrained Bernoulli coordinate count is

    f_2 = m−cs−(5N_5+6N_6+7N_7)
        =96L³+176L²+64L.

The TWO-LAYER proposal ν_2 is the exact Gibbs distribution conditioned on all sphere and endpoint checks, and its **complete global normalizer** is

    Z_2(z)=(1+z)^(f_2) Z_even(s,z)^c
           Z_even(5,z)^N_5 Z_even(6,z)^N_6 Z_even(7,z)^N_7.

No hidden partition function, uncharged boundary factor, approximate Gibbs oracle or independent-block assumption is introduced: **these particular true parity-check supports actually are disjoint**. The algorithm uses a two-parity-state exact rational sampler inside each even block and ordinary rational Bernoulli draws on leftover coordinates. Its runtime/coin bit cost is polynomial in m and in the rational z encoding length. A physical state preparation circuit and real-valued thermal-parameter tolerance are separate obligations.

For the first two independently materialized source-cell levels:
| L | m | c spheres | e endpoints | enforced independent rows | unresolved rank | free syndrome bits |
|---:|---:|---:|---:|---:|---:|---:|
| 1 | 840 | 22 | 24 | 46 | 44 | 336 |
| 2 | 4760 | 58 | 60 | 118 | 116 | 1600 |

All four quantities c,e,d_2,f_2 have symbolic formulas for every L≥1.

## 3. Relationship to the true full Gibbs law

Let B_2 be the event that the remaining d_2 independent parity constraints all hold. Then the *actual* complete level-2 hard-sector syndrome Gibbs law is exactly

    π_full = ν_2( · | B_2 ).

This is an identity—not yet a polynomial rejection algorithm at fixed positive fugacity. In particular, at z=1 the two-layer proposal is uniform over a subspace and the residual equations have independent rank d_2, so

    ν_2(B_2) = 2^(−d_2)=2^(−2c).

Thus the naive two-layer-rejection method still has exponential expected attempts at z=1, though it removes **c+2 independent obstructions** compared with the original sphere-only proposal (which has residual rank 3c+2).

PR #219's strong all-L fixed-z *no-go for sphere-only rejection* cannot simply be applied unchanged to this strengthened ν_2, since the endpoint parity events are now enforced by construction. A new residual structure/bound would be necessary.

## 4. Size-dependent cold gate, now with the second layer

The zero word is still in the true full code and has weight 1, so

    ν_2(B_2) ≥ ν_2(0) = 1/Z_2(z).

As in PR #219, the elementary even-block estimate Z_even(k,z)≤exp(k²z²/2), and (1+z)^(f_2)≤exp(f_2 z), yields

    ν_2(B_2) ≥ exp[−f_2 z − (c s² + E_2) z²/2],

where the exact endpoint length-square inventory is

    E_2 = 25N_5+36N_6+49N_7=288L²+552L+136.

Define h(L)=ceil(sqrt(c s²+E_2)). For any positive fugacity

    z ≤ 1/[f_2+h(L)],

the exponent is ≤3/2, hence full-constraint rejection from the exact two-layer sampler has **fewer than five attempts in expectation** (when an authentic complete constraint check is implemented). This is a size-dependent cold regime z=O(L^(−3))—not a fixed-temperature family-wide answer, and it leaves unbounded rare-branch worst-case/pathwise resources open.

## 5. Verification

Run:

    python3 evidence/compiled-strongest/tools/bdl_two_layer_factors.py

The file checks:
1. exact finite partition functions against independent exhaustive 2^8 enumeration for three fugacities;
2. true legal parity in every block on rational samples;
3. correct symbolic source-cell counts and all N_5/N_6/N_7 multiplicities;
4. full level-2 materialization L=1,2 and, for **every** sphere/endpoint block, actual parity closure against the complete δ0 source code matrix;
5. full block-disjointness and remaining rank d_2=2c;
6. sample agreement with all enforced checks without claiming agreement with residual checks;
7. exact rational all-L cold-gate inequalities at L=1,2,3,4.

This is a constructive and testable upgrade to the sampling proposal, not a Lean kernel certificate for all L and not an actual physical quantum initializer. No changes to original X3, BCRD/UPT physical obligations, founding, commissioning or the canonical manuscript.

## 6. Next decisive bridge

Use source's q-star and restriction maps to find a **coupled exact conditional kernel** that enforces the last 2c checks at fixed z without exponential rejection. Their effect is not removable by another naive independent-block assumption. The most useful next certificates are a verified bounded-interface recursion or a source-specific convergent cluster-expansion sampling theorem, including all normalization and runtime costs.
