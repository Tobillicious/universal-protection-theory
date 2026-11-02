# BDL residual exact elimination ordering and running-intersection audit
Date: 2026-11-03
Status: finite certificates of actual source-dual bag width, not a uniform family-width proof.
Parent: PR #222→#221→#220→#219→#218→#216→#215. Original X3 unchanged.

## Source and exact scope
Primary source for cellular replacements: Balasubramanian, Davydova & Lin, arXiv:2605.10943v1, §3.2. This audit uses the actual finite source-derived algebraic Tanner complexes at ell=3 and ell=5 from PR #215 and the complete residual Fourier-dual factor graph in PR #221. These toy subdivisions do not establish the paper's geometric-scale physical premises.

The residual-dual variable count d=2c=16L²+24L+4 counts independent metacheck CHOICE coefficients, not syndrome bits. Every syndrome coordinate that is outside the source's disjoint sphere+endpoint blocks contributes its genuine factor scope; each genuine local parity block contributes a single exact source-derived Fourier-dual factor. All original full-code checks remain present.

## New certificate beyond the previous min-fill heuristic

Each elimination ordering is independently replayed against the entire original factor primal graph. At step i, the certificate stores the filled neighbor set N_i and Boolean bag X_i={v_i}∪N_i. Before eliminating v_i, all remaining neighbors are made a clique. The width is max_i |N_i|; actual table work is the sum Σ_i 2^|X_i|, not a single maximum-clique proxy.

Define parent(v_i), when N_i nonempty, as the earliest-eliminated vertex in N_i; otherwise its bag is a root. The code checks the local *running-intersection inclusion*

    N_i ⊆ X_parent(i).

This inclusion is enough for the global running-intersection property: any retained vertex x that appears in a descendant bag is carried through all parent bags until its own elimination (simple induction on the parent chain). The chosen parent edges form a forest because elimination indices strictly increase. Joining component roots via empty separators gives a full junction-tree representation when desired. This verifies a constructive tree-decomposition certificate for the CHOSEN finite graph, rather than assuming one from RCM.

The benchmark also measures multiple deterministic min-fill, minimum-degree, hybrid and weighted-fill orderings with 32 fixed seeds each. Each candidate's filled graph and bag-forest certificate is checked independently; it cannot be accepted on a heuristic score alone.

The resulting width certificates are for these selected complementary GF(2) relation bases and numerical subdivisions only. Such certificates are not optimality bounds, do not prove any width asymptotics and do not on their own evaluate exact physical or quantum time/work.

## Reproduce

    python3 evidence/compiled-strongest/tools/bdl_residual_order_search.py

The script emits (for L=1,2) factor counts, primal component sizes, baseline min-fill width and exact table-entry count, best width and exact table-entry count, best method and seed, and complete frequency distribution of measured candidate widths. A focused CI gate archives these results.

## Remaining
- Derive the actual full source-family bag interface and a UNIFORM asymptotic width bound, including k-level recurrence.
- If width is O(L), exact table work remains exponential in L. A polynomial family-wide M5 needs a logarithmic-width construction, source-specific alternative factorization or other polynomial normalized sampler.
- Exact bucket arithmetic bit complexity and all original physical-source-to-encoded-state/decoder/commissioning joins remain open.
- Do not promote this finite-order audit to general UPT protection or physical BDL lifetime certification.
