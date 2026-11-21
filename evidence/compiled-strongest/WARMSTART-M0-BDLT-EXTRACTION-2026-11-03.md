# M0 — BDLT source audit and three-dimensional warm-start handoff
Date: 3 November 2026
Status: PARTIAL primary-source audit. No claim of full lemma-by-lemma extraction or completed sampler.

## Provenance and sources
- BDLT: Balasubramanian, Davydova, Lin and Thorngren, A thermally and perturbatively stable classical spin model in two dimensions, arXiv:2610.22548v1, https://arxiv.org/abs/2610.22548 . Indexed proof excerpts were inspected at https://www.paperpeel.com/paper/2610.22548 . The full PDF and Appendix A could NOT be retrieved; formula typography in the index is lossy, so no unverified exact constants are promoted.
- BDL: Balasubramanian, Davydova and Lin, A passive self-correcting quantum memory in three dimensions, arXiv:2605.10943v1, https://arxiv.org/html/2605.10943v1 . Reviewed §1.3, §2.5/Theorem 2.6, §5.4 and §6.2.6.
- UPT canonical interfaces: evidence/compiled-strongest/lean/Snuffy/WarmStart.lean, HistoryPolymer.lean, ThermalEncoding.lean and StageSchedule.lean; WARMSTART-PROGRAM-2026-11-02.md. Companion global M4 ratio correction: draft PR #211.

## Source-anchored have/need ledger

| Source | Verified source-level role | Three-dimensional join | Status |
| --- | --- | --- | --- |
| BDLT §2.5–2.6 | Alternating classical Rep/Par hierarchy, gauge-generator structure and support-weight growth. The indexed 2D ladder construction requires odd scale ℓ ≥ 7. | Replace by the actual 3D X/Z syndrome constraint graph. The ℓ=3 dependency-radius experiment is a toy, not source verification. | Partial: exact lemma labels and all constants unverified |
| BDLT §3.1 | Hierarchical gauge averaging generates effective perturbations and separates gauge-invariant contributions from residual interactions. | A map to a proposal law or to implementable conditional sampling kernels is needed. | Strategy identified; not a sampler |
| BDLT §3.2, Theorem 4, Appendix A | Under a smallness condition, improved cluster expansion controls effective perturbation strength and retains spatial decay, in a form of the type norm(V_eff,m) ≤ 2 norm(V,eta), with 0<m<eta. Indexed source explicitly uses Kotecký–Preiss and Fernández–Procacci bounds. | Reprove polymer overlap/counting and precise smallness on the 3D graph, then control a NORMALISED Gibbs density. | Exact D, threshold and appendix proof unverified |
| BDLT §3.3–3.5, Lemmas 14–15 and Theorem 5 | Coarse norm comparison and multiscale recursive decay. The indexed geometric hull argument uses a bound of three for certain connected coarse hulls versus four for inadmissible operators. | A 3D counterpart of the hull/crossing argument, with constants, is required; a 2D embedding lemma is not automatically dimension-free. | Main geometric transfer obstacle isolated |
| BDLT §4.1–4.2 | Hierarchical decoder, stable logical sectors, unstable configurations and boundaries. | Verify 3D support and membership of a proposed conditioning event. | Structural |
| BDLT §4.5, Lemma 17 | Witness removal has a correction; perturbation energy change is controlled relative to witness weight. | Source-specific 3D witness correction and energy comparison if this route is used. | 2D correspondence unproved |
| BDLT §4.6, Theorem 7 and Lemma 19 | A Peierls rare-unstable probability bound and a local escape/memory-lifetime estimate. | An EVENT TAIL is not an algorithm for sampling the full 3D law. Independent BDL 3D source already bounds its decoder-unstable mass. | Event-bound logic identified |
| BDLT Appendix A, full result list | Polymer convergence, pinning/tree estimates and all exact constants. | Need an individual have/need entry for every mathematical lemma and any 2D-only use. | UNEXTRACTED: full text unavailable |
| Any BDLT sampling algorithm | No polynomial-time 3D Gibbs-state preparation algorithm or pointwise max-divergence bound was identified in retrieved sections. | Construct a valid proposal, normalized density and polynomial-time sampler. | NOT FOUND, not a proof of nonexistence |

M0 is still OPEN until the complete 64-page source, especially Appendix A, is checked theorem by theorem. Do not call a search-indexed excerpt an independently verified primary PDF proof.

## Positive closed mathematics from BDL §5.4: the 3D high-mass event

At low temperature, the 3D source bounds

  Tr[(1-P_stable) rho_beta] ≤ 4 × 2^(-2^(k-1))

for the 2k-level CSS construction. At k≥3 the right side is at most 1/4. Hence the Gibbs probability of the decoder-stable syndrome event A_k is at least 3/4.

If an exact sampler that runs in time polynomial in the actual 3D system size n can sample pi_k conditional on A_k, its law is

  mu_k(x) = pi_k(x) × 1_Ak(x) / pi_k(A_k)

and thus pointwise mu_k(x) ≤ (4/3) pi_k(x). In that conditional case the warm-start constant can be 4/3 (stronger than the original desired polynomial C). This is an elementary deduction from the published tail bound; it is NOT a construction or time bound for the needed sampler.

BDL §1.3 explicitly raises rapid thermal initialization as unresolved; its metacheck matrix is not LDPC, and energetic bottlenecks may obstruct mixing. The high-mass event does not magically yield an efficient sampler. The event-mass portion of the truncated-sampler route is already accounted for in BDL's low-temperature 3D theorem; the preparation portion remains OPEN.

## Exact normalisation-sensitive mathematical transfer

Let pi be a strictly positive normalized finite target law and w(x)>0 a candidate tilt. Define Z=Σ_x pi(x)w(x) and mu(x)=pi(x)w(x)/Z. If m=min w and M=max w, then m≤Z≤M and for every x,

  mu(x)/pi(x) = w(x)/Z ≤ M/m.

For w(x)=exp(-beta deltaE(x)), beta>0, this gives

  C_min(mu,pi) ≤ exp(beta [max deltaE - min deltaE]).

A sufficient global certificate is oscillation(deltaE) ≤ q log(n)/beta, which yields C≤n^q. A small LOCAL norm per interaction term alone does not imply this: n noncancelling O(1) terms may have O(n) oscillation. Therefore an actual BDLT-to-warm-start use would need total cancellation, a scale-telescoping proof, or a different sampler bound. The full partition-function normalization cannot be omitted.

Equivalent conditional-kernel criterion: along a complete finite hierarchical path x_1,...,x_J with common supported prefixes, suppose each candidate conditional kernel satisfies mu_j(x_j|prefix) ≤ c_j pi_j(x_j|prefix). By multiplying the EXACT chain-rule factorizations,

  mu(x_1,...,x_J) ≤ (Π_j c_j) pi(x_1,...,x_J).

No independent-block assumption is needed. But a fixed factor greater than one paid at Θ(n) stages is exponential; M4 requires Π_j c_j ≤ n^q or an exact alternative.

## Quantitative regression and target condition

Run:

    python3 evidence/compiled-strongest/tools/check_warmstart_ratio_gate.py -v

Five exact Fraction arithmetic tests check: (1) exponential product-factor accumulation; (2) an event of mass 3/4 with sharp conditional ratio 4/3; (3) normalized Gibbs tilts; (4) zero-target-support obstruction; (5) the May BDL 3D bound at k≥3. Regression tests are not substitute proof of the 3D sampler.

## Corrected M1–M6 progression

M1. Establish the 3D polymer-link graph and exact source-valid construction scale, rather than carrying over ℓ=3 toy constants or ℓ≥7 2D ladder assumptions.
M2–M3. Prove 3D recursion with correct constraints, boundaries and either normalized conditional kernels or globally controlled tilt oscillation.
M4. Supply pointwise global C(n)≤n^q with complete partition-function factors. Alternatively construct an exactly sampled conditional law on the already high-mass 3D stable event to obtain C≤4/3.
M5. Prove an ACTUAL sampler (not a Gibbs-law oracle), output-support correctness, normalization and polynomial runtime with rare-branch costs accounted for.
M6. Only then instantiate the existing canonical WarmStart, HistoryPolymer and StageSchedule results at discharged inputs.

## Remaining review gates (OPEN)
1. Obtain and independently inspect the full BDLT primary source and Appendix A, all theorem/lemma hypotheses, geometry dependencies and constants.
2. Prove each proposed 2D-to-3D transfer or mark it inapplicable.
3. Provide the sampler as an explicit algorithm, with actual output distribution and runtime.
4. Demonstrate a global pointwise normalized ratio bound and common support.
5. Check actual geometric scale/physical-size asymptotics, not the toy scale alone.

No changes to canonical manuscript, X3 priorities, physical commissioning, or founding choice; no claim that universal real-world UPT follows.
