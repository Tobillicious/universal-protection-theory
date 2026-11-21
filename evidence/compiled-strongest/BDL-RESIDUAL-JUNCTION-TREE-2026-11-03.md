# Residual Junction-Tree: conditional elimination theorem and actual-width audit
Date: 2026-11-03. Status: exact Lean primitives and finite width certificates, **not** a complete family-width theorem.
Parent: draft PR #220, atop #219→#218→#216→#215.

## Scope correction

At level 2, d=2c=16L²+24L+4 counts independent remaining parity constraints, not physical syndrome bits. The Fourier-dual quotient in #219 can, however, represent the acceptance law using exactly d Boolean dual row-selection variables. The factor scopes on those d variables come from all true two-layer parity blocks and leftover free syndrome sites.

The RCM cut-interface ranks in #215 belong to a different graph: the original syndrome-bit parity trellis. They are not primal-graph elimination widths for the residual-dual factors. One n-body parity equation has trellis cut rank 1 and an unsplit n-clique primal factor. Therefore the proposed RCM-to-junction-tree bound requires a NEW graph-specific theorem.

## Correct conditional sum-product result

For d binary dual choices and F rational factor functions phi_j with true scopes S_j, let

    Z = sum_(x in {0,1}^d) product_j phi_j(x restricted to S_j).

Choose a variable elimination order pi. Collect all current factors touching the next variable x_i, multiply them on the union scope, and sum x_i over 0 and 1. Since finite summation distributes over factors not depending on x_i, this preserves the complete Z exactly. After all d variables are eliminated, the final scalar equals the full partition sum. Keeping queried variables yields exact unnormalized marginals; normalize only when Z>0.

Construct the primal graph by joining all pairs of dual variables within each factor scope. Under the chosen order, add all fill edges between active neighbours before removing each vertex. If the actual maximum number of surviving neighbours is w, every bucket table has at most w+1 Boolean dimensions; the fill graph supplies a chordal completion and a width-w tree decomposition. Cost in exact rational arithmetic operations is O((F+d) 2^(w+1)) after factor input, not generically O(2c 2^(w+1)). Factor table construction, rational bit lengths and all sampled coins must be additionally accounted for. Marginal output for an arbitrary k-variable subset may itself need 2^k entries.

A uniform w=O(L) would give poly(L) 2^O(L), exponential in L, subexponential in m=Theta(L^4), **not** quasipolynomial in L. A polynomial-time M5 result needs w=O(log m) or a different, proven factorization.

## Source-derived graph results

The reproducible script at evidence/compiled-strongest/tools/bdl_residual_junction_audit.py derives the full level-2 metacheck matrix, inserts all true sphere+endpoint rows, extends by a GF(2) complement, sparsifies complement representatives modulo whole disjoint rows, forms the actual Fourier-dual factor scopes, then measures induced widths from explicit fill edges. It uses no assumed prior RCM width transfer.

| ell | syndrome bits m | dual variables d | nonconstant factors F | largest initial factor | raw induced width | min-fill induced width |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| 3 | 840 | 44 | 254 | 5 | 17 | 16 |
| 5 | 4760 | 116 | 1142 | 5 | 33 | 30 |

These are exact finite upper bounds for this particular complementary basis and ordering. At ell=5 an explicit table of size 2^31 remains infeasible in ordinary memory, even though the graph is far smaller than the original 4760-bit syndrome space. Two scales cannot prove O(L), optimality or a polynomial sampler.

## Lean contents, with the exact claim boundary

The separate new module PhysicalBridges.ResidualJunctionTree uses rational weights. It proves one-variable partition splitting, exact distributivity when a factor does not depend on the eliminated bit, and a sum-of-bag-table-size bound **under an explicit bag-size hypothesis**. It does NOT yet construct a full junction tree inside Lean, formalize every factor-bucket join, prove source-family width, or certify a physical sampling runtime. No new axioms or proof placeholders are intended.

## Open proof obligations

1. Prove the full Fourier-dual factor scopes and normalizations of #219/#220 are represented exactly by the residual input factor graph (the present Python tool audits scopes but does not evaluate all large rational messages).
2. Formally construct filled bags, running-intersection property and bucket recursion, with corresponding Lean kernel receipts.
3. Obtain a uniform ordering-width theorem for every L and level k; O(L) alone still fails the polynomial M5 target.
4. Validate published geometric source parameters, real RG decoder, original physical-encoding correspondence and complete pathwise time/memory/work costs.
5. M6 and original X3 protection stay unchanged and OPEN. No manuscript, founding or commissioning action.

Verdict: constructive, verifiable partial algorithmic progress, not a completed full level-2 Gibbs sampler or physical UPT theorem.
