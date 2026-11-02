# BDL levels 1 and 2 — cellular replacement and exact metacheck frontier audit

Date: 3 November 2026
Status: **source-derived algebraic reconstruction at toy subdivision scales; full 3D sampler and published geometric-scale correspondence OPEN.**

## Source lock and exact boundary

Primary source: Balasubramanian, Davydova and Lin, [arXiv:2605.10943v1](https://arxiv.org/html/2605.10943v1), §§2.2 and 3.2.1–3.2.6, especially Eqs. (59)–(73). The paper defines local complexes by subdividing square-star neighborhoods, doubling them along their boundaries, and taking restrictions through embedded 1D and 0D subcomplexes. Its alternation is R_X followed by R_Z. The source also specifies a separate **large geometric scale**, selected after a random perturbation/embedding step; the examples here use ell=2L+1 equal to **3 and 5** to test the abstract cellular rules, not to instantiate the published locality theorem.

Code:
- tools/bdl_replacement_chain.py
- tools/bdl_frontier_audit.py

Source-algebraic implementation:
1. Start with the [[5,1,2]] Tanner square seed of 5 qubits, 2 X checks, 2 Z checks and four X–Q–Z–Q faces. Matches the source seed already separately checked in PR #213.
2. For R_X, construct for each X vertex the subdivided square-star X_x, its two copies, and the boundary cylinder Y_x. For each Q vertex use the doubled, subdivided Q–Z star graph Y_q with vertical edges at its Z endpoints. Each Z vertex supplies two points Y_z.
3. Form the TOTAL COCHAIN complex with C^0=C_X^0, C^1=C_X^1 ⊕ C_Q^1, C^2=C_X^2 ⊕ C_Q^2 ⊕ C_Z^2. Derive δ^0 and δ^1 from actual edge/face incidence and restrictions Y_q → Y_x and Y_z → Y_q, not guessed parity rows.
4. Reconstruct the next Tanner square complex using local cell flags and inherited endpoint square-pairs. Every X–Z shared qubit is paired exactly once by these squares; check this in code.
5. Form R_Z as the dual of R_X applied to the dual Tanner complex, transposing the differentials and swapping X/Z labels.
6. Validate δ¹δ⁰=0, full Tanner pairing coverage, ranks, logical dimension, complete left nullspaces and metacheck relation parity.

This is a **reconstruction of the published local-complex prescription** at two smaller formal subdivision parameters. We have not established that all geometric gluing choices and intermediate embeddings coincide with those of a physical published-parameter run. The first full paper-to-code correspondence is therefore *partial*, not a signed physical-model certificate.

## Reproducible exact results

Run from the repository root:

    python3 evidence/compiled-strongest/tools/bdl_frontier_audit.py

The script constructs both levels at ell=3 (L=1) and ell=5 (L=2). Exact GF(2) elimination verifies the invariant dimensions.

| Level | ell | Physical qubits | X checks | Z checks | Logical qubits | X-error metachecks | Z-error metachecks |
|---|---:|---:|---:|---:|---:|---:|---:|
| 1, R_X | 3 | 60 | 24 | 38 | 1 | 3 | 0 |
| 2, R_Z R_X | 3 | 1,336 | 840 | 588 | 1 | 3 | 90 |
| 1, R_X | 5 | 140 | 60 | 82 | 1 | 3 | 0 |
| 2, R_Z R_X | 5 | 8,144 | 4,760 | 3,620 | 1 | 3 | 234 |

Here “X-error metachecks” = independent relations among Z-check syndromes, dimension dim C²−rank δ¹. “Z-error metachecks” = independent relations among X-check syndromes, dimension dim C⁰−rank δ⁰. These are the **complete** left nullspaces, not a manually selected subset.

## Frontier ranks: stronger than row-span bookkeeping

For each syndrome sector independently, take its exact complete relation matrix A over F₂ and a fixed *natural source-cell ordering* of syndrome coordinates. The existing exact-sampler trellis uses row live-width w_span = max over cuts of number of basis rows with nonzero entries on both sides.

**Row-basis-invariant boundary rank.** For a cut S|Sᶜ, let A_S and A_Sᶜ be the column restrictions. Then the intersection of the two column spans has dimension

    b(S) = rank(A_S) + rank(A_Sᶜ) − rank(A).

This is a linear-algebra identity since span(A_S)+span(A_Sᶜ)=span(A). Changing the metacheck **row basis** does not change b(S). A parity-trellis that follows the SAME variable ordering cannot encode all valid prefix/suffix matching conditions with fewer than 2^b(S) distinct linear boundary states at that cut. This is an invariant **for a fixed ordering**, not for all possible orders or algorithms.

| Level | ell | X-error row-span/invariant width | Z-error row-span/invariant width |
|---|---:|---:|---:|
| 1 | 3 | 3 / 3 | 0 / 0 |
| 2 | 3 | 3 / 3 | 46 / 46 |
| 1 | 5 | 3 / 3 | 0 / 0 |
| 2 | 5 | 3 / 3 | 118 / 118 |

The equality of both width measures on these orders means **row-basis Gaussian elimination alone cannot rescue this exact natural-order trellis**. At ell=5 level 2, a naive 2^118 state table is already prohibitive. This conclusion concerns the *chosen source-cell ordering*. No lower bound for optimal variable ordering or a different sampler has been established.

The two tested subdivisions do NOT prove an asymptotic lower bound on w or a universal obstruction. The source's published random-embedding ell is selected from geometric parameters and must be reproduced separately.

## Mathematics remaining

1. **Source parameter join:** compute one actual source-compliant random-embedding ell, including constants and square-gluing details. Confirm the instance generated is equivalent to the paper's full chain complex. Large ell may make explicit level-2 matrices enormous: where infeasible, use symbolic cell counts and verified small subinstances, do not invent measurements.
2. **Ordering attack:** find a provably better complete-variable ordering, or a matroid/pathwidth upper bound. The current fixed-order interface ranks do not exclude O(log n) orderings.
3. **Multiscale attack:** exploit R_X/R_Z cellular restrictions and quotient/splice decompositions to derive exact conditional factorisations, whose total **normalized** max-log-density ratio cost is O(log n). A formal free-energy bound alone is not enough.
4. **Sampler correspondence:** connect the full published BDL RG decoder stable event (and correct complexity) to the exact syndrome sampler and physical Pauli state preparation. Distinguish the proved random-embedding family from the geometrically explicit ell=8 construction whose full lifetime proof was deferred.
5. **Only then** invoke the archived WarmStart and StageSchedule results; do not claim unconditional quantum holding or full physical UPT from these toy reconstructions.

No rewriting of original X3, no new physical commissioning/founding decision, no manuscript or public edition release.


## First ordering attack: deterministic source-graph RCM

The benchmark also includes a deterministic standard-library reverse Cuthill–McKee ordering with a pseudo-peripheral starting vertex on the syndrome-variable ↔ metacheck bipartite graph. It uses every independent metacheck equation. The algorithm is a heuristic and does **not** certify optimal ordering or polynomial-time scaling.

| Tested level 2 | Natural-order row-span / invariant cut rank | RCM row-span / invariant cut rank |
|---|---:|---:|
| ell=3, 840 X-syndrome variables, 90 metachecks | 46 / 46 | **29 / 29** |
| ell=5, 4,760 X-syndrome variables, 234 metachecks | 118 / 118 | **41 / 39** |

This gives a genuine constructive reduction of the state space for the **same full syndrome law** and **all original complete constraints**, without dropping a constraint or assuming independent factors. But 2^29 and 2^41 are still very large, and two toy scales do not imply any asymptotic O(log m) ordering. In the ell=5 RCM ordering, the 41 live-row trellis is not rank-optimal even for that ordering; the minimal-rank state construction in companion draft PR #214 could reduce to the invariant 39 if instantiated here.

For exact rank-minimal sampling given an ordering, see PR #214 (based on PR #213). This PR contributes the previously missing **source-derived level-1/2 constraint input and width measurements**. PR #214's proof targets remain subject to the same source-compliant geometric-scale and full-family correspondence obligations.
