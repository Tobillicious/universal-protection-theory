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
