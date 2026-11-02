# Exact residual-dual bucket elimination with physical syndrome evidence

Date: 2026-11-03. Status: exact finite evidence-conditioned partition and sample algorithm with actual source-cell L=1 receipt. **NOT uniform polynomial M5 or physical quantum preparation.**
Stacked on draft #221→#220→#219→#218→#216→#215. No changes to X3, canonical manuscript, commissioning, founding, or publication.

## 1. Full 840-bit original Gibbs partition at z=1/3

For the source-derived BDL two-replacement cellular model at L=1 (ell=3), the actual hard-sector syndrome space has m=840 coordinates and a full 90-row independent metacheck basis. The sphere-plus-endpoint decomposition of #220 supplies 46 disjoint true rows and a 44-row independent residual complement.

The source receipt computes the **complete** full constraint partition Z=Σ_(x∈ker A_full) z^|x| at z=1/3 using exact Python Fraction arithmetic and Fourier-dual bucket elimination, rather than exponential rejection. The chosen min-fill order has induced primal width 16 and the evaluator processes 357758 total Boolean table entries across all buckets. Canonical reduced rational Z, encoded as numerator/denominator, has SHA-256

    82311cad726376c992a38fe99c7bace54f9b1fd10c694590dacd7dd1360daaca

The exact rational numerator has 472 decimal digits and denominator 394. An independently calculated fixed-bit marginal for the first physical syndrome site gives Pr(x_0=1)≈0.249987493272 and exact canonical ratio SHA-256

    f7162bc6c26ae696ac4e8cc3fc6725914567950ac762dfd7dfa94e60312e4805

The restricted normalizers at x_0=0 and x_0=1 are computed independently; their sum is proved equal to the original Z by exact integer/rational equality.

At L=2 the actual source-dual graph has d=116 and measured min-fill width 30; the corresponding explicit 2^31 table is intentionally NOT constructed. Only graph-width and source-basis verification is claimed there.

## 2. All-evidence exact Fourier-dual factor theorem

Let B_1,...,B_b be disjoint independent true full-code parity rows and R_1,...,R_d complete them to an independent basis of the FULL syndrome metacheck row space. For each physical syndrome coordinate i with dual residual parity p and partial fixed-bit evidence E:

    h_i(p) = 1+z*(-1)^p                  when i not fixed;
           = z^(e_i)*(-1)^(e_i*p)         when i fixed to e_i ∈{0,1}.

Then the exact constrained evidence partition is

    Z_E = 2^(-d) Σ_(v∈F₂^d) [
          Π_(block B_j) 1/2(
                 Π_(i∈B_j) h_i(v_i)
               + Π_(i∈B_j) h_i(v_i+1))
          × Π_(free sites i) h_i(v_i) ].

Proof: insert the complete character projector for all b+d original parity rows, restrict physical sites in E, exchange finite sums, and independently sum the two dual choices for each genuinely disjoint B_j. No row is dropped, no partition normalizer omitted, and no independence of residual constraints is assumed. The result holds for any strictly positive rational z.

**Evidence can create negative intermediate factor entries.** Exact signed Rat/Fraction arithmetic is necessary and used; the final restricted physical partition is nonnegative. The quotient's residual variables are dual parity-choice bits, NOT the original m physical syndrome bits.

For a site not fixed by E, conditional probability Pr(x_i=1|E)=Z_(E,i=1)/Z_E, when Z_E>0. Sequential exact rational-coin draws produce the original complete physical syndrome Gibbs law. On independently specified small parity systems, the code computes these restricted partitions and the complete sampling law, checks every sample against all metachecks, and matches a separate brute-force physical-syndrome enumeration.

## 3. New Lean kernel work

The new module PhysicalBridges.ResidualBucketEvidence is imported into the physical bridge root. Its intended checked theorems:
- joint_append: all original factors are preserved by list concatenation.
- joint_outside_independent: a product of factors independent of the eliminated bit remains independent.
- bucket_step_pointwise: exact rational multiply-sum distributivity including signed Fourier-evidence factors.
- partition_add and bucket_partition_correct: preserve the *complete* finite partition function under an exact factor bucket step.
- eliminateAll_correct: independent full finite Boolean marginalisation recursively matches exhaustive partition enumeration.

These are unconditional finite rational identities, NOT a proof of full BDL tree decomposition or a universal width bound. The earlier #221 module proves the 2^n assignment size and cost bound under a supplied bag-size certificate.

## 4. Complexity and open obligations

For a chosen actual primal elimination order of width w, a single exact evidence partition can be computed in O((F+d)2^(w+1)) arithmetic table operations, plus factor construction and signed rational bit complexity. Sequential full physical syndrome sampling can call this up to m+1 times: O(m(F+d)2^(w+1)) arithmetic table operations. The code does not hide worst-case memory, exact rational coin budgets or factor-table evaluation.

The two measured finite widths (16 and 30) do not prove a family-wide O(L) width theorem, and O(L) would remain exponential in L. Polynomial M5 across all levels at a fixed physical inverse temperature still needs O(log m) width or a separately proved efficient structure.

Full physical quantum encoded thermal preparation, authentic decoder stable-event sampling, arbitrary hierarchy levels, source-compliant geometric parameters and real hardware instrument correspondence remain OPEN; M6 and original X3 untouched.

## Reproduce

From repo root on the stacked branch:

    python3 evidence/compiled-strongest/tools/bdl_dual_bucket_exact.py
    python3 evidence/compiled-strongest/tools/bdl_dual_source_receipt.py

CI separately checks the pinned Lean 4.35.0 physical-bridges import/build and the exact Python receipts, including SHA-256 and max-width guards.
