# Residual GF(2) basis sparsification: exact Gibbs invariance and primal-width search

Date: 2026-11-03
Status: deterministic source-derived finite algebraic basis and width audit, no all-L treewidth or M5 theorem.
Parent: #224→#222→#221→#220→#219→#218→#216→#215. Preserves original X3, canonical manuscript and commissioning/founding status.

## Why this is a mathematically valid approach

The full metacheck relation space of the reconstructed level-2 BDL code is W⊆F₂^m. The disjoint sphere+endpoint rows in PR #220 form an independent subspace U with dimension 2c+2; a residual complementary basis of d=2c rows spans V, with W=U⊕V.

Changing the residual basis by an invertible matrix M∈GL(d,F₂) does NOT change W. In the exact Fourier dual formula of PR #222, it is just a bijective reindexing of all d summation variables. Therefore the original completely normalized syndrome Gibbs law, every physical evidence partition and every conditional probability are invariant. Yet the **factor scopes and induced elimination width can change**, because the columns of the chosen residual row basis change.

Elementary operations R_i ← R_i ⊕ R_j (i≠j) and R_i ← R_i ⊕ B_k (true U-basis row) preserve the direct-sum completion and span. Sorting independent candidate generators and selecting another full-rank complement also preserves the full row space. A smaller Hamming weight is a heuristic for a lower primal width; by itself it is NOT a certificate.

## New exact finite verifier

evidence/compiled-strongest/tools/bdl_residual_basis_search.py:
1. Rebuilds the original full source-cell level-2 Tanner matrix and obtains the complete GF₂ metacheck basis independently from original check incidence, for ell=3 and ell=5.
2. Inserts the genuine disjoint sphere and endpoint rows FIRST, then chooses complete independent complementary bases using several deterministic orderings of original generators: source, Hamming weight, coset-minimal Hamming weight, and seeded permutations.
3. Optionally reduces each residual row using only strictly weight-decreasing, mathematically reversible elementary XORs with another independent residual row and/or one original disjoint basis row.
4. Rechecks that all rows remain independent and that their union spans the full original source-derived kernel; no original parity checks can be lost.
5. Builds the complete Fourier-dual primal graph from all local block and unconstrained physical syndrome-coordinate factors with each new basis. Computes exact certified filled bags, actual maximum clique/separator width, table-entry work and running-intersection tree via the independent checker in PR #224.
6. Searches deterministic orders, retaining only independently certified improvements. If no improvement occurs, the work is still a test of a valid basis-change method, not a fabricated theorem.

No family-wide optimality result or asymptotic proof follows from finitely many seeds. The source's physical geometric ell requires separate proof. This is a classical exact-inference study, not physical encoded state preparation or a universal UPT guarantee.

## Mathematical next condition

A true width-transfer theorem must specify a constructive residual basis and elimination ordering for every admissible L (and eventually hierarchy level k), with a proved bound on the actual factor scopes and **filled** neighbors. Even O(L) gives exponential-in-L table arithmetic. M5 family-wide polynomiality remains OPEN unless a logarithmic-width construction or different polynomial exact algorithm is proved.

Run:

    python3 evidence/compiled-strongest/tools/bdl_residual_basis_search.py

This prints finite exact row-equivalence certificates and achieved widths; CI archives the receipt.


## Verified finite outcomes and exact treewidth brackets

The source-complete GF(2) basis search compared 128 certified (basis, order) pairs per subdivision. It found **no further width improvement** beyond PR #224's best known upper bounds, 14 and 28. This is a bounded heuristic experiment, NOT a proof of optimality.

| ell | L | Physical syndrome bits | Residual dual variables | Original min-fill width | Best induced width | Original best table entries | Alternate basis table entries |
|---:|---:|---:|---:|---:|---:|---:|---:|
| 3 | 1 | 840 | 44 | 16 | 14 | 229,758 | 229,758 |
| 5 | 2 | 4,760 | 116 | 30 | 28 | 2,176,540,670 | 2,256,340,478 |

At L=2 the alternate basis is more costly than PR #224's best ordering: it is not described as an improvement.

### Independently certified minor lower bounds

The executable tools/bdl_residual_minor_lower.py constructs graph minors of the ORIGINAL residual Fourier-dual primal graph of PR #221. At each step it deletes an isolated vertex or contracts a genuine edge, verifying the adjacency matrix and replaying every operation. Because treewidth is minor-monotone and tw(H) is at least the minimum degree of H for any finite minor H:

    tw(G) >= tw(H) >= minimum_degree(H).

The maximum witnessed minor minimum-degree is therefore a rigorous lower bound on primal elimination width for THIS particular factor graph, not for every other GF(2) basis or exact sampler.

| ell | Primal vertices | Certified lower bound | Best known elimination upper bound | Witness minor vertices |
|---:|---:|---:|---:|---:|
| 3 | 44 | **9** | **14** | 19 |
| 5 | 116 | **12** | **28** | 15 |

The script uses four source-independent contraction heuristics with 48 deterministic seeds each, replays the entire winning contraction certificate, and checks the lower-bound algorithm against exact brute-force treewidth on reference graphs. Two finite bounds are NOT an asymptotic lower-bound theorem.

### Independently computed alternative-basis Gibbs receipts

The executable tools/bdl_basis_partition_invariance.py uses a genuinely DIFFERENT full-rank 44-dimensional residual complement at L=1 and an independently certified width-14 ordering. It recomputes the original COMPLETE source-derived 840-bit, 90-metacheck Gibbs partition at fixed rational z=1/3. Exact reduced Fraction arithmetic reproduces the earlier PR #222 SHA-256 of canonical numerator/denominator:

    Z_full:
    82311cad726376c992a38fe99c7bace54f9b1fd10c694590dacd7dd1360daaca

It also independently evaluates both fixed-first-bit evidence partitions and verifies Z(x0=0)+Z(x0=1)=Z_full exactly, with the same exact marginal SHA-256:

    Pr(syndrome_bit_0=1):
    f7162bc6c26ae696ac4e8cc3fc6725914567950ac762dfd7dfa94e60312e4805

The alternate run uses 229,758 certified Boolean table entries, down from the original PR #222's 357,758. This is a second exact *dual-coordinate* computation over the SAME source-cell algebraic model, not independent physical evidence or a source-compliant geometric realization.

At L=2 a full exact partition is still NOT evaluated; the best known order has more than two billion Boolean table entries. Uniform width bounds, all-level efficient sampling, source-compliant physical placement, and encoded state preparation remain OPEN.

Reproduce in the stacked branch:

    python3 evidence/compiled-strongest/tools/bdl_residual_basis_search.py
    python3 evidence/compiled-strongest/tools/bdl_residual_minor_lower.py
    python3 evidence/compiled-strongest/tools/bdl_basis_partition_invariance.py

The dedicated GitHub workflow executes these checks and archives the text receipts.
