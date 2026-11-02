# BDL level-2 hard sector: disjoint local sphere constraints and the residual Gibbs join

Date: 2026-11-03
Status: exact source-cell local factorisation + precise residual obligation. NOT an exact full-sector Gibbs sampler.
Stacked on #216 (symbolic kernel/partitions), itself on #215 (cellular reconstruction).
Primary source: BDL arXiv:2605.10943v1, §§3.2.2–3.2.6, especially the double-of-the-cone local Y_z complexes.

## One independent local sphere constraint per cycle-type Z star

In the BDL R_Z step, dualize the R_X construction on the previous Tanner complex. A previous Z vertex z with a connected **cycle** as the boundary of its local star has Y_z topologically the suspension of a circle: a closed doubled disk/S². Let F(Y_z) denote all its 2-cell faces. Every 1-cell of this sphere is incident on exactly two faces over F₂. Consequently their sum has zero boundary, giving a Z-error metacheck of the next code:

    S_z := {new X-check ('xf',z,f) : f∈F(Y_z)},
    ∂S_z=0.

(The terminology switches under duality: these are parity constraints on the level-2 syndrome for Z-type errors, measured by X checks.)

For distinct original z vertices, the new local X-check coordinate sets are disjoint because the labels include the old z. Hence all S_z are linearly independent; they are **actual** relations of the FULL hard-sector matrix, not substituted weak constraints.

For the source-derived two-level [[5,1,2]] seed with ell=2L+1, L≥1:
    N_cycle = 8L²+12L+2
    |S_z| = 8L²+8L = 8L(L+1).

Each relation is supported entirely on the new X-checks descending from that old local sphere. The executable code constructs every Y_z locally, checks the double-incidence rule, and verifies each sphere check against all qubit columns for L=1 and L=2.

By the companion full-rank theorem in PR #216, the complete hard-sector X-check dependency rank is

    r_total = 32L²+48L+10 = 4 N_cycle + 2.

Thus the independent disjoint-sphere relations form a subspace of dimension N_cycle, and a complementary relation basis has rank exactly

    r_residual = r_total - N_cycle = 3N_cycle+2
               = 24L²+36L+8.

This dimension is not a guess about the specific choice of complementary basis. The statement that a complement exists is elementary finite-dimensional linear algebra; this PR does NOT construct a sparse, efficiently samplable full residual factorization.

## Constructive exact local proposal

Let m be the number of level-2 X-check syndrome bits:

    m = 64L⁴+256L³+336L²+160L+24.

Define A_loc to be the matrix of the N_cycle disjoint S_z parity checks. Let ν_z be the Gibbs distribution proportional to z^|σ| on ker A_loc. Because the sphere blocks are disjoint and no local check touches the remaining coordinates, the *normalized* distribution is an exact independent product of:
- uniform-fugacity Bernoulli bits on coordinates outside the sphere blocks;
- even-parity-fugacity Gibbs distributions on each sphere block.

For a sphere containing s=8L(L+1) bits, the exact restricted partition function is

    Z_even(s,z) = [(1+z)^s + (1-z)^s]/2.

If c=N_cycle, the full LOCAL proposal partition function is

    Z_loc(m,z) = (1+z)^(m-cs) × Z_even(s,z)^c.

This is an identity including global normalization, not an approximation. A **two-state exact rational backward dynamic program** samples each even-parity block in O(s) arithmetic operations, and the remaining independent bits directly. The whole proposal is polynomial in m and the bit size of positive rational z. See tools/bdl_local_spheres.py. The file labels its output LOCAL only, not the complete valid syndrome law.

## Residual acceptance and why the warm start is still open

The true hard-sector syndrome space is ker A_full, a subspace of ker A_loc. Extend the independent S_z equations to a full basis. Let B be the conjunction of the r_residual extra parity checks. Then the EXACT original syndrome Gibbs law is

    π_z = ν_z(· | B).

Thus a rejection sampler based on ν_z would be exact *if it can wait for acceptance*, and its expected number of attempts is 1/ν_z(B), where

    ν_z(B) = Z_full(z) / Z_loc(z).

The full Z_full(z) is NOT computed by this PR; neither a polynomial lower bound on ν_z(B) nor a polynomial direct sampler of B given the local factors is established.

An exact and instructive obstruction: at z=1 the proposal is uniform on ker A_loc, while B consists of r_residual independent GF(2) equations on that subspace. Hence

    ν_1(B) = 2^(-r_residual),
    E_ν1[attempts] = 2^(24L²+36L+8).

At L=1 the residual rank is 68; at L=2 it is 176. Therefore blindly rejecting LOCAL-only samples is exponentially expensive at this parameter value. This is NOT an impossibility theorem for a different sampler or for BDL's actual low-temperature z. It prevents a misleading claim that having disjoint local parity constraints already proves the needed M5 polynomial sampler.

## Exact finite tests

Run from the branch after parent #216:

    python3 evidence/compiled-strongest/tools/bdl_local_spheres.py

Tests independently enumerate tiny even-parity partition functions and compare to the exact analytic normalization; verify local even parity on exact rational samples; reconstruct actual level-2 source-cell complexes at L=1 and L=2; verify each spherical relation against every qubit, independence through disjointness, sizes and total ranks; and sample valid LOCAL-only configurations without asserting validity for the entire code.

Expected counts:
| L | Number of local spheres | Bits per sphere | Total independent metachecks | Remaining rank | Hard-sector syndrome bits |
|---:|---:|---:|---:|---:|---:|
| 1 | 22 | 16 | 90 | 68 | 840 |
| 2 | 58 | 48 | 234 | 176 | 4,760 |

This identifies a reproducible local factorization for part of the hard sector. The next mathematical attack is to derive an efficient **residual** conditional sampler using source-cell interfaces, or prove a quantitatively adequate low-temperature acceptance probability. Neither is supplied here.

No full-family temperature preparation, physical quantum encoding, RG decoder, unconditional protection, modification to original X3, commissioning, founding choice or canonical manuscript follows.
