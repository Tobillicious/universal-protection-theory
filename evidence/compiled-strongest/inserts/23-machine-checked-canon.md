## Section 23 — The machine-checked canon

*This section records the compiled results and their actual hypotheses. The current canon
has 192 Lean modules and 1,158 public theorem/lemma names. Checkpoint 12 freshly compiled
and kernel-checked all modules with zero output and passed the full standard-axiom,
strict completeness and claims audits. The current source hashes match its PASS receipt.
Checkpoint 11 was already complete for the 191-module / 1,150-name tree. The eight new
TransferRate results certify retained-prefix and complete-attempt cost summation. These
component receipts do not certify the remaining noisy physical holding application.*

*Evidence convention (unchanged from the edition header): a compiled theorem is cited by its name; a statement carried as a hypothesis of a compiled theorem is named as such; a prose derivation keeps its stated premises. A prose proof does not acquire a compiler certificate by association.*

---

### 23.1 The law and greatestness (Chapter 5; Part II)

| Claim | Module | Theorems |
| --- | --- | --- |
| The canonical order is a strict partial order | `Greatestness` | `lexLt_trans`, `lexLt_irrefl` |
| Proposition 1: aligned ⟺ no needless loss at any stage | `Greatestness` | `aligned_iff_no_needless_loss` (no axioms) |
| Proposition 2: every finite nonempty feasible family has an aligned option; the life guard (some aligned option keeps at the first stage everyone the standby option keeps) | `Law` | `exists_aligned`, `life_guard` |
| Proposition 3: maximality of the projection to a scope S guarantees no needless existing loss for every feasible family iff S is the whole existing domain; same-priority counting of a new particular admits a needless loss | `Law` | `scope_guarantee_iff`, `same_priority_admits_needless_loss` |
| Proposition 4: a statewise faithful hold dominates every rival on every upward-closed event under any law on the worlds, strictly when the rival misses with positive probability | `Law` | `faithful_hold_dominates`, `faithful_hold_strict` |
| Universal greatestness under stage-wise union closure (P-emu(c)); rivals are exact mirrors or strictly below; the canonical option is unique | `Greatestness` | `greatest_of_union_closed`, `strict_except_mirrors`, `aligned_unique` |
| **Whole-outcome greatestness.** Given `htopR` (the full top tuple is realisable) and `hsolv` (its cost fits the budget), an aligned option equals that feasible top and contains every rival tuple. No union-closure premise enters. Part II.10 supplies the proof; G2 supplies the full construction | `UnionClosure` | `greatest_of_solvent`, `strict_of_solvent`, `aligned_eq_of_greatest` |
| **Resource dichotomy.** With realisability at every step and the cost/demand correspondence, either the ledger is solvent and aligned outcomes are greatest at each step, or there is a first negative balance. The physical construction must prevent the relevant breach | `UnionClosure`, `PremiseFloor` | `greatest_or_irrelevant` |
| Below full solvency: every realisable rival whose union with the canonical outcome is affordable is contained in it; with subadditive cost, every finite set of rivals whose total cost fits in the canonical slack $B - c(o)$ is contained in it; whatever the budget, no feasible rival is canonically above the canonical option | `UnionClosure` | `dominates_of_affordable`, `dominates_within_slack`, `greatest_of_affordable`, `aligned_never_below` |
| The unfunded branch: when keeping everything costs more than the income, a rival can keep a particular the canonical option does not, so such a regime is irrelevant as a protector (income-or-irrelevance) | `UnionClosure` | `insolvent_not_greatest` |
| Reciprocity in the canonical order, below full solvency (§15, D3*) | `ReciprocityCeiling` | `reciprocity_dominance`, `omitting_rival_strictly_below` |
| **Affordable reciprocity.** Below full solvency, if the union of a rival with the canonical option is realisable (`UnionRealizable`) and affordable, any mind the rival keeps, the canonical regime keeps — no family closure | `AffordableReciprocity` | `reciprocity_dominance_affordable` |
| **Solvent reciprocity.** Under the Master Solvency Condition the canonical regime keeps every particular outright (the reading of $\top$ as "all existing particulars continue" enters as the hypothesis `htopkeeps`), and any mind kept by any rival whatsoever — no union closure, no feasibility assumption on the rival — is kept by the canonical regime | `SolventReciprocity` | `solvent_keeps_everyone`, `reciprocity_dominance_solvent` |
| Option value and indicator reciprocity (§§15–16) | `ReasonsRoute` (v4.1, unchanged) | `optionValue_strict`, `law_dominates_strict`, `rival_fraction_lt_one` |
| Reciprocity in expectation, the canonical floor, and the controller's floor (§§15.2, 16.4) | `ReasonsCompiled` | `reciprocity_expectation`, `reciprocity_canonical_floor`, `reciprocity_strict`, `reciprocity_from_solvency`, `controller_pays_floor` |
| Irreplaceability dominance and grading (§16.1, U1), additive information model | `Irreplaceability` | `destroy_loses_exactly`, `preserve_dominates`, `optimal_keeps_most_irreplaceable` |

### 23.2 Theorem 8: ledger, canon invariant, composition (§18; Chapters 1, 2)

| Claim | Module | Theorems |
| --- | --- | --- |
| Stroke identity $\Delta D = \beta W_{\mathrm{on}} - \beta Q_B + I_1 - I_2$ | `ThermoLedger` | `stroke_identity` |
| Cycle work floor from guard 1 | `ThermoLedger` | `cycle_work_floor` |
| **Guard 1 derived (Landauer).** Reversible dynamics of a register and a Gibbs bath: the Reeb–Wolf identity $\beta\,\Delta Q_B - \Delta S_R = I(R':B') + D(q_B \,\Vert\, \gamma)$; Landauer's bound $\beta\,\Delta Q_B \ge \Delta S_R$; erasure costs $Q_B \ge k_B T\, H(p)$ | `Landauer` | `reeb_wolf_identity`, `landauer`, `landauer_erasure` |
| **Guard 1 derived (quantum).** Von Neumann entropy: unitary invariance, pinching, the quantum Gibbs bound $S(\rho) \le \beta\,\mathrm{Tr}(\rho H) + \ln Z$ with equality at $\gamma$, $S(\rho_A \otimes \gamma) = S(\rho_A) + S(\gamma)$; Landauer's bound for every unitary coupling of a register to a Gibbs bath, $S(\rho_A) - S(\rho'_A) \le \beta\,\Delta Q_B$ | `QuantumLandauer` | `vnEnt_unitary_conj`, `vnEnt_le_diag`, `vnEnt_le_energy`, `vnEnt_init`, `quantum_landauer` |
| Guard 1, $\beta Q_B \ge I_M + D_{\mathrm{err}} + \delta_I$ whenever the reset removes that entropy; the cycle work floor with guard 1 derived, not assumed | `Landauer`, `QuantumLandauer` | `guard_one`, `quantum_guard_one`, `cycle_work_floor_derived`, `quantum_cycle_work_floor` |
| Funded-repair certificate; quarantine zero debt | `ThermoLedger` | `funded_repair_certificate`, `quarantine_zero_debt` |
| Canon invariant: P(breach) ≤ P(Gᶜ) ≤ Σδ, no independence | `ThermoLedger` | `tower_bound`, `canon_invariant` |
| Identity tracking envelope (Chapter 2) | `ThermoLedger` | `tracking_envelope`, `tracking_bounded`, `tracking_within_resolution` |
| **Tracking from the actual controller.** Exact flow, reset contraction, moving-record recursion and envelope (Part II.4) | `Instruments` | `lindblad_reset_flow`, `lindblad_step`, `reset_contracts`, `tracking_recursion_derived`, `tracking_envelope_derived` |
| **Derived coverage and physical holding.** Full scope, finite nearest decoder, unique decoding, repair preservation, radius throughout a step, code headroom and combined physical cycle (Part II.1–3) | `Bridge` | `coverage_from_law`, `exists_nearest_decoder`, `nearest_decodes`, `holding_preserves`, `qsl_growth`, `qsl_within_radius`, `headroom_within_radius`, `holding_cycle_physical` |
| Proposition 5 (reactive lockstep), invariant transfer, Theorem 8 composition | `Composition` | `reactive_lockstep`, `reactive_lockstep₂`, `invariant_transfer`, `theorem8_composition` |
| Proposition 6 (FIFO certificate, deadlines, tightness); serial stages | `Workload` | `fifo_certificate`, `fifo_deadlines`, `fifo_tight`, `serial_certificate` |

### 23.3 E9 (§19; Chapter 3)

| Claim | Module | Theorems |
| --- | --- | --- |
| Byzantine quorum: robust estimates lie between honest readings; existence for K ≥ 2f + 1 | `E9SelfHealing` | `robust_between_honest`, `no_false_alarm`, `no_masking`, `exists_robust` |
| Branch B: non-stabilizer errors below the distance have a non-trivial syndrome | `E9SelfHealing` | `syndrome_detects` |
| **Complete logical-attack split.** Support at least the code distance; every site below threshold or one site forces an alarm, with the honest-sensor response and robust quorum (Part II.5) | `Instruments` | `branchC_complete` |
| Wave-race margin; code headroom; assembled E9 | `E9SelfHealing` | `wave_race_margin`, `code_headroom`, `e9_timely_self_healing` |
| The bridge timing instances of §19: reaction before damage, positive propagation margin, buffer coverage of the reaction window, escrow gating before detection | `BridgeE9` | `reaction_before_damage`, `positive_propagation_margin`, `local_buffer_covers_entire_reaction`, `escrow_prevents_pre_detection_application` |
| **Branch A rate bound (quantum speed limit).** Unitary evolution preserves the norm; under H₀ + V the trajectory departs from the H₀ trajectory at rate at most ‖V‖/ħ, and at most $P_{\mathrm{adv}}/(\hbar\,\omega_{\mathrm{cutoff}})$ under the per-site coupling $\lVert V\rVert \le P_{\mathrm{adv}}/\omega_{\mathrm{cutoff}}$ | `SpeedLimit` | `norm_conserved`, `branchA_divergence`, `branchA_rate` |
| Mandelstam–Tamm, sharp: $\lvert\langle\psi_0, \psi_t\rangle\rvert \ge \cos(\Delta E\, t/\hbar)$ while $\Delta E\, t/\hbar \le \pi$; orthogonalisation time $T \ge \pi\hbar/(2\Delta E)$ | `SpeedLimit` | `mandelstam_tamm`, `orthogonalization_time` |

The Branch A divergence is measured in state-vector norm. For pure states, ‖ρ − σ‖₁ ≤ 2‖ψ − φ‖ is a standard inequality and is not compiled here.

### 23.4 H5 (§20; Chapter 4)

| Claim | Module | Theorems |
| --- | --- | --- |
| Reserve-before-activation machine: conservation, zero debt, strict authority attenuation, funding before activation, no unfunded work, no harmful effect | `H5Closure` | `step_inv`, `authority_attenuation`, `reserve_before_activation`, `zero_debt`, `no_unfunded_work`, `no_harmful_effect`, `effect_preserves_care` |
| Von Neumann's alternating projection theorem (existence step) | `CanonVonNeumann` | `tendsto_altIterate`, `canon_von_neumann_convergence`, `limit_subspace_eq_inf`, `opial_route_closes` |
| Halperin's theorem: the global meet of a whole presentation | `CyclicProjections` | `tendsto_cyc_iter`, `presentation_detector` |
| Consistency detector; meet algebra realised by Hilbert subspaces; contradictions detected, deductions never roll back | `H5Closure`, `MeetHilbert` | `consistency_detector`, `hilbert_anchor_preserved`, `hilbert_contradiction_collapse`, `contradiction_detected`, `deduction_never_rolls_back` |
| Rank criterion; Proposition 7; protected anchors untouched | `DeductionBoundary` | `rank_criterion`, `boundary_mem_image`, `anchor_untouched` |
| Paid reflection certificate | `ReflectionCertificate` | `residual_certificate`, `apriori_error`, `stopping_count`, `zero_constant_fixed` |

### 23.5 X3 and the information-to-area bridge (Section 21)

| Claim | Module | Theorems |
| --- | --- | --- |
| Data processing invariance I(H : 𝓡(S)) ≤ I(H : S), any probability spaces | `DataProcessing` | `data_processing`, `data_processing_map` |
| Finite information theory: log-sum, data processing, flag identity, decoder bound | `FiniteInformation` | `log_sum`, `data_processing_fin`, `flag_identity`, `decoder_bound` |
| Gaussian carrier tail; necessary radius; carrier radius $R(t) \ge w(t - t_c)$ | `GaussianTail`, `RecoveryWork`, `FiniteInformation` | `carrier_tail`, `necessary_radius_from_decoder`, `carrier_radius` |
| Recovery-work theorem; $W_{\min}$ over all admitted protocols; divergence of delayed recovery | `RecoveryWork`, `GaussianTail` | `frontier_work_bound`, `Wmin_lower_bound`, `x3_work_from_decoder`, `delayed_work_diverges` |
| Fano's inequality and the required information Δ₀ | `Fano` | `fano`, `mi_eq_ent_sub_condEnt`, `required_information` |
| Gaussian maximum entropy: KL between Gaussians; golden formula; scalar, vector, correlated-noise and exact log-det channel bounds | `GaussianKL`, `GoldenFormula`, `GaussianChannel`, `KLAdditivity`, `GaussianChannelGen`, `GaussianVector`, `Whitening`, `Rotation`, `LogDet` | `klDiv_gaussian_gaussian`, `golden_formula`, `gaussian_channel_bound`, `klDiv_prod_kernel`, `vector_channel_bound`, `correlated_channel_bound`, `logdet_channel_bound` |
| ln det(I + W) ≤ tr W; per-use cap; required traffic m ≥ θ₀n; area power | `AreaBridge`, `Workload` | `logdet_le_trace`, `channel_cap`, `required_traffic`, `area_power`, `range_variance_bound` |
| **Explicit frontier geometry.** Lattice box and boundary counts, with charged per-site frontier power (Section 21.4) | `Instruments` | `card_box`, `card_boundary`, `boundary_power` |

Section 21 supplies the derivation in this edition. The finite-information, Gaussian-channel, carrier and work implications are compiled in their stated domains. The complete physical binding remains G1; the matching upper construction for the full Θ target remains G3.

### 23.6 The premise floor (§17)

| Claim | Module | Theorems |
| --- | --- | --- |
| Income-or-irrelevance; forced breach; breach strictly dominated | `PremiseFloor` | `income_or_irrelevance`, `forced_breach`, `breach_strictly_below` |
| Premise 5 derived: the law plus Bennett's feasible reversible counterpart forces reversible administration | `PremiseFloor` | `reversible_administration_forced` (no axioms) |
| Premise 2 reduced: Lie–Trotter product formula with explicit error; Lloyd's simulation theorem | `Trotter` | `trotter_bound`, `trotter_tendsto`, `lloyd_simulation` |
| **The gate-set error budget.** For contraction sequences on any normed ring, an ε/m per-factor approximation error composes to at most ε over m sequential factors (ordered products; with `TwoLevel.two_level_decomposition` and the cited Solovay–Kitaev theorem this is the approximation route for the gate-set clause) | `ErrorBudget` | `prod_norm_le_one`, `two_factor_step`, `telescoping_delta`, `error_budget` |
| Premise 7's ceiling is a dial: every target ε > 0 is met at some code distance | `ReciprocityCeiling` | `ceiling_achievable` |
| **The threshold theorem's counting core.** Under local stochastic noise: $P(\text{at least } m \text{ of } T \text{ fail}) \le \binom{\lvert T\rvert}{m} p^m$; with half-faulty failure witnesses, $P(\text{fail}) \le \sum_w (2\sqrt p)^{\lvert w\rvert}$; with at most $V\Delta^L$ witnesses of each length $L \ge d$, $P(\text{fail}) \le V r^d/(1-r)$, $r = 2\Delta\sqrt p < 1$ | `Threshold` | `many_faults`, `fail_le_witness`, `fail_le_geometric` |
| The repetition code end to end: majority decoding fails with probability at most $(4p)^t$, and every ceiling is met below $p = 1/4$ | `Threshold` | `repetition_threshold`, `repetition_ceiling` |
| Code families with polynomially many witnesses: the charged kernel decays geometrically, and every target ceiling (10⁻⁶ included) is met at some distance and every larger one | `Threshold` | `family_ceiling` |


### 23.7 The Universal Protection Theorem with the derived holding bridge

`UniversalProtection.universal_protection` retains the abstract assembly: reasons-or-holding coverage, continuation through the horizon on the good event, the joint fault ceiling, greatestness and reciprocity at its stated inputs.

`Bridge.universal_protection_held` strengthens the continuation assembly by deriving scope from the law and preservation from nearest-codeword holding. It composes the physical/source projection with the same reactive controller and environment. On \(G\), every particular continues at every step through the horizon; the probability that any particular fails is at most \(\sum_i\delta_i\), without independence.

Part II.1–6 supplies the proof, physical-cycle derivations and all five `hcert` components. G1 is the combined full-domain source/event/observation/fault construction. Part II.10 supplies the separate greatestness proof, with G2 retaining the whole outcome and freedom stages.

### 23.8 What the compiled theorems rest on

**Premises carried as stated premises or hypotheses:**
* the surface-code chain lemma (Dennis, Kitaev, Landahl and Preskill, 2002): minimum-weight decoding fails only along a self-avoiding chain of length at least d with at least half its edges faulty, with at most $V\Delta^L$ such chains of length $L$ — as the code-specific input to `Threshold.family_ceiling` for the surface-code instance. The threshold theorem's counting core is compiled (§23.6), and for concatenated codes the threshold is compiled end to end with no carried code-specific input: failure probability at most $(21p)^{2^k}/21$ under local stochastic noise (`Concatenated.concatenated_threshold`), so the fault ceiling is attained on a fully compiled route;
* Bennett's reversible counterpart, no longer carried as prose: given a Bennett counterpart with the stated properties (a reversible map preserving base cost, zero heat on reversible options, positive heat on irreversible ones), the law itself forces reversible administration (`Bennett.premise5_from_bennett`). What remains carried is the counterpart's existence, stated as explicit hypotheses of the compiled theorem;
* the gate-set clause of premise 2, no longer carried as prose: every unitary on $\mathbb{C}^n$ is a finite product of two-level unitaries (`TwoLevel.two_level_decomposition`), so a simulator implementing each two-level factor implements every local evolution. What remains carried is that the universal simulator's gate set reaches every two-level factor;
* the relational frame BCRD P1–P4.

The chain lemma is a published mathematical theorem, cited as such; the Bennett and gate-set items are now the explicit hypotheses of compiled theorems; the fourth is the frame the edition is stated in.

**Physical premises now compiled.** Guard 1 (the second law in its export form) is derived from Landauer's theorem (§23.2), and the quantum speed limit, in Mandelstam–Tamm form and in the rate-bound form of E9 Branch A, is derived from unitary dynamics (§23.3). What these theorems assume is the standard physical framework:
* finite-dimensional quantum mechanics, with Schrödinger dynamics generated by self-adjoint Hamiltonians;
* unitary (in the classical form, reversible) joint dynamics;
* a bath that starts in its Gibbs state, uncorrelated with the register;
* for Branch A, the per-site coupling bound $\lVert V\rVert \le P_{\mathrm{adv}}/\omega_{\mathrm{cutoff}}$;
* for the fault ceiling, local stochastic noise of rate p below the threshold of `Threshold.family_ceiling`.

**Greatestness.** `UnionClosure.greatest_of_solvent` takes both `htopR : ⊤ ∈ R` and `hsolv : c ⊤ ≤ B`. The first supplies the whole top tuple, including freedom stages; the second pays its cost. Alignment forces equality with that feasible top (Part II.10). `greatest_or_irrelevant` retains realisability at every step and derives the resource split. G2 supplies the full construction. The affordable-union results retain their separate resource cases.

The amount $I_M + D_{\mathrm{err}} + \delta_I$ that the reset removes from the register is the instance's entropy accounting (§18), stated as the hypothesis of `guard_one` and `quantum_guard_one`.

**The physical bridge and its joined certificate.** `Bridge.coverage_from_law` derives full scope from the law guarantee over all feasible families. `holding_preserves` derives preservation from decoding radius and repair precision. `qsl_within_radius`, `headroom_within_radius` and `holding_cycle_physical` supply the continuous and discrete cycle arguments. `universal_protection_held` takes the actual commuting source transition, observation agreement, initial continuation, perturbation-radius and repair witnesses in `hcert`, together with the named-event cover and fault bounds. G1 supplies their combined construction for the complete claimed physical domain. Parts II.3–6 give the available arguments; a deployment and a mathematical construction of the full source domain retain their distinct roles.

**Not compiled by this section:**
* the installation figures of §22, which are sourced measurements and design values (§22.5);
* the interpretive companion (the doors), which is held for consultation and is not mathematics.


<!-- BEGIN THEOREM INDEX -->
## 23.A Complete theorem index

Generated from the sources by `lean/gen-index.py`; every theorem listed here is kernel-checked and axiom-audited by `lean/build-and-audit.sh`.

| Module | Theorems |
| --- | --- |
| `MathlibAnalyticBridge` | `starProjection_fixed_iff_mem`, `starProjection_idem`, `altIterate_succ_eq_self`, `altIterate_succ_mem`, `mirrorIterate_succ_mem`, `convergence_inf_le`, `limit_mem_of_fixed`, `convergence_inf_ge`, `von_neumann_identification` |
| `HalperinDecay` | `norm_starProjection_apply_le`, `dist_starProjection_le`, `sq_pythagoras_step`, `chain_identity`, `sq_dist_antitone`, `sq_dist_tendsto`, `delta_tendsto_zero`, `asymptotic_regularity` |
| `OpialBridge` | `tIterate_succ_mem`, `weakCluster_mem_exact`, `weakCluster_mem`, `iterate_inner_const`, `weakCluster_eq_starProjection`, `iterate_sub_starProjection_sq_eq`, `tendsto_starProjection_of_norm_sq_tendsto`, `makeVonNeumannConvergence` |
| `CanonVonNeumann` | `altIterate_sub`, `altIterate_shift`, `norm_altIterate_le`, `altIterate_eq_halperin`, `opial_tIterate_eq`, `mirrorAltIterate_eq`, `tendsto_altIterate_sub_succ`, `mem_inf_of_orthogonal_range`, `tendsto_zero_of_mem_orthogonal`, `tendsto_altIterate`, `canon_von_neumann_convergence`, `limit_subspace_eq_inf`, `canon_opial_convergence`, `opial_norm_sq_tendsto`, `opial_route_closes` |
| `RecoveryWork` | `frontier_work_bound`, `Wmin_lower_bound`, `necessary_radius`, `completing_square`, `carrier_radius`, `x3_delayed_recovery_work`, `delayed_work_diverges` |
| `E9SelfHealing` | `robust_between_honest`, `no_false_alarm`, `no_masking`, `exists_robust`, `syndrome_detects`, `wave_race_margin`, `code_headroom`, `e9_timely_self_healing` |
| `H5Closure` | `step_inv`, `reachable_inv`, `genesis_inv`, `authority_attenuation`, `reserve_before_activation`, `zero_debt`, `no_unfunded_work`, `no_harmful_effect`, `effect_preserves_care`, `consistency_detector` |
| `Greatestness` | `lexLt_irrefl`, `lexLt_trans`, `aligned_iff_no_needless_loss`, `lexLe_of_le`, `greatest_of_union_closed`, `strict_except_mirrors`, `aligned_unique` |
| `ThermoLedger` | `stroke_identity`, `cycle_work_floor`, `funded_repair_certificate`, `quarantine_zero_debt`, `tower_bound`, `canon_invariant`, `tracking_envelope`, `tracking_bounded`, `tracking_within_resolution` |
| `Composition` | `reactive_lockstep`, `reactive_lockstep₂`, `invariant_transfer`, `theorem8_composition` |
| `PremiseFloor` | `income_or_irrelevance`, `forced_breach`, `breach_strictly_below`, `reversible_administration_forced` |
| `ReciprocityCeiling` | `reciprocity_dominance`, `omitting_rival_strictly_below`, `ceiling_achievable` |
| `CyclicProjections` | `cyc_succ_apply`, `adj_succ_apply`, `norm_cyc_le`, `norm_adj_le`, `inner_cyc`, `cyc_fix`, `mem_of_norm_adj_eq`, `energy`, `iter_succ`, `iter_shift`, `norm_iter_le`, `iter_fix`, `tendsto_iter_sub_succ`, `tendsto_zero_of_mem_orthogonal`, `tendsto_cyc_iter`, `presentation_detector` |
| `GaussianTail` | `gaussian_lower_tail`, `carrier_tail`, `necessary_radius_of_decoder`, `x3_work_from_decoder` |
| `DeductionBoundary` | `rank_criterion`, `context_maps_image`, `boundary_mem_image`, `anchor_untouched` |
| `ReflectionCertificate` | `residual_certificate`, `apriori_error`, `stopping_count`, `zero_constant_fixed` |
| `Trotter` | `norm_exp_le`, `norm_exp_sub_one_sub_le`, `norm_exp_mul_exp_sub`, `norm_exp_sum_sub_prod`, `trotter_bound`, `trotter_tendsto`, `lloyd_simulation` |
| `Irreplaceability` | `destroy_loses_exactly`, `preserve_dominates`, `optimal_keeps_most_irreplaceable` |
| `DataProcessing` | `fst_process`, `snd_process`, `data_processing`, `data_processing_map` |
| `MeetAlgebra` | `anchor_preserved`, `contradiction_collapse`, `bot_absorb`, `anchor_preserved_over`, `meetAll_bot`, `collapse_over`, `consistent_preserved` |
| `MeetHilbert` | `hilbert_anchor_preserved`, `hilbert_contradiction_collapse`, `contradiction_detected`, `deduction_never_rolls_back` |
| `FiniteInformation` | `log_sum`, `margH_process`, `margY_process`, `data_processing_fin`, `flag_identity`, `decoder_bound`, `necessary_radius_from_decoder` |
| `AreaBridge` | `logdet_le_trace`, `channel_cap`, `required_traffic`, `area_power` |
| `UniversalProtection` | `coverage_invariant`, `universal_protection` |
| `Workload` | `fifo_certificate`, `fifo_deadlines`, `fifo_tight`, `serial_certificate`, `range_variance_bound` |
| `Fano` | `max_entropy`, `fano_single`, `fano`, `mi_eq_ent_sub_condEnt`, `required_information` |
| `GaussianKL` | `rnDeriv_gaussian_gaussian`, `log_gaussianPDFReal`, `llr_gaussian_gaussian`, `integral_sq_sub_gaussian`, `klDiv_gaussian_gaussian` |
| `GoldenFormula` | `klDiv_map_swap`, `golden_formula`, `mutualInfo_le_klDiv` |
| `GaussianChannel` | `chan_apply`, `integral_quadratic_gaussian`, `measurable_quad`, `llr_chan`, `coe_outVar`, `klDiv_chan`, `gaussian_channel_bound` |
| `KLAdditivity` | `prod_eq_compProd`, `klDiv_map_equiv`, `compProd_prod_assoc`, `compProd_prod_swap`, `klDiv_prod_kernel` |
| `GaussianChannelGen` | `chanW_apply`, `measurable_quadW`, `llr_chanW`, `coe_outVarW`, `klDiv_chanW` |
| `GaussianVector` | `isMarkov_vecChan`, `isProb_refMeas`, `klDiv_compProd_map_equiv`, `varW_nonneg`, `klDiv_vecChan`, `vector_channel_bound`, `vector_channel_trace_bound` |
| `Whitening` | `mutualInfo_map_snd_equiv`, `mutualInfo_kernel_map_equiv`, `pi_eq_map_eSucc`, `vecChan_apply`, `multivariateGaussian_one_eq_pi`, `isUnit_det_sqrt`, `wht_mul_sqrt`, `sqrt_mul_wht`, `toEuclideanCLM_mul_apply`, `whiten`, `corrChan_apply`, `measurable_whtSignal`, `correlated_channel_bound` |
| `Rotation` | `multivariateGaussian_one_map_isometry`, `measurable_rotSignal`, `rotated_channel_bound` |
| `LogDet` | `cov_isHermitian`, `var_lincomb`, `rotSignal_eigen`, `var_rot_eq_eigenvalue`, `det_one_add`, `logdet_channel_bound` |
| `Law` | `exists_aligned`, `lexLt_first_le`, `life_guard`, `scope_guarantee_iff`, `same_priority_admits_needless_loss`, `faithful_hold_dominates`, `faithful_hold_strict` |
| `SpeedLimit` | `norm_le_of_inner_deriv_le`, `angle_le_chord`, `angle_le_speed_mul`, `re_inner_gen_eq_zero`, `norm_conserved`, `branchA_divergence`, `branchA_rate`, `mandelstam_tamm`, `orthogonalization_time` |
| `Landauer` | `kl_nonneg`, `mul_log_div_eq`, `sum_margA`, `sum_margB`, `mutualInfo_eq`, `mutualInfo_nonneg`, `ent_le_ent_marg`, `partition_pos`, `gibbs_pos`, `gibbs_sum_one`, `log_gibbs`, `ent_gibbs`, `ent_le_energy`, `evolve_nonneg`, `evolve_sum`, `ent_evolve`, `reeb_wolf_identity`, `landauer`, `landauer_erasure`, `guard_one`, `cycle_work_floor_derived` |
| `QuantumLandauer` | `vnEnt_eq_roots`, `vnEnt_congr`, `vnEnt_unitary_conj`, `vnEnt_diagonal`, `diag_conj`, `row_normSq_sum`, `col_normSq_sum`, `vnEnt_le_diag`, `diag_nonneg`, `diag_sum`, `UH_mem`, `H_spec`, `energy_eq`, `vnEnt_le_energy`, `gibbsState_posSemidef`, `gibbsState_trace`, `gibbsState_diag`, `gibbsState_trace'`, `gibbsState_energy`, `vnEnt_gibbsState`, `ptrA_isHermitian`, `sum_star_mul_eq`, `ptrA_conj`, `ptrB_conj`, `init_posSemidef`, `finalState_posSemidef`, `finalState_trace`, `vnEnt_init`, `quantum_landauer`, `quantum_guard_one`, `quantum_cycle_work_floor` |
| `Threshold` | `prob_le_one`, `prob_nonneg`, `filter_subset_powersetCard`, `many_faults`, `fail_le_witness`, `fail_le_geometric`, `repetition_threshold`, `two_sqrt_pow_le`, `repetition_ceiling`, `poly_geom_le`, `family_ceiling` |
| `UnionClosure` | `aligned_never_below`, `dominates_of_affordable`, `strict_of_affordable`, `exists_union_bound`, `dominates_within_slack`, `union_closed_of_affordable`, `greatest_of_affordable`, `aligned_eq_of_greatest`, `greatest_of_solvent`, `strict_of_solvent`, `greatest_or_irrelevant`, `insolvent_not_greatest` |
| `SolventReciprocity` | `solvent_keeps_everyone`, `reciprocity_dominance_solvent` |
| `AffordableReciprocity` | `reciprocity_dominance_affordable` |
| `Bridge` | `coverage_from_law`, `nearest_decodes`, `exists_nearest_decoder`, `holding_preserves`, `qsl_growth`, `qsl_within_radius`, `headroom_within_radius`, `universal_protection_held`, `holding_cycle_physical` |
| `Instruments` | `lindblad_reset_flow`, `lindblad_step`, `reset_contracts`, `tracking_recursion_derived`, `tracking_envelope_derived`, `branchC_complete`, `card_box`, `box_mono`, `card_boundary`, `boundary_power` |
| `StrokeBookkeeping` | `ptrB_isHermitian`, `controlled_mul_apply`, `mul_star_controlled_apply`, `controlled_unitary`, `ptrB_controlled`, `stroke_entropy_change`, `stroke_identity_derived` |
| `Bennett` | `bennett_step`, `bennett_compute_uncompute`, `ent_equiv`, `negMulLog_add_le`, `negMulLog_add_lt`, `negMulLog_sum_le`, `ent_eq_fiber`, `ent_push_le`, `ent_push_lt`, `heat_reversible`, `heat_irreversible`, `premise5_from_bennett` |
| `Concatenated` | `distance3_corrects_one`, `lift_subset`, `fails_witness`, `card_lift`, `disjoint_lift`, `card_witness`, `card_witnesses`, `concatenated_threshold`, `concatenated_ceiling` |
| `ReasonsCompiled` | `reciprocity_expectation`, `reciprocity_canonical_floor`, `reciprocity_strict`, `reciprocity_from_solvency`, `controller_pays_floor`, `controller_floor_diverges` |
| `TwoLevel` | `mul_of_idOutside`, `rad_mul_self`, `conj_rad`, `givens_idOutside`, `givens_unitary`, `one_idOutside`, `rad_eq_zero`, `elim_unitary`, `elim_idOutside`, `elim_kills`, `idOutside_row`, `idOutside_keeps_col`, `col_zero_above`, `clear_below`, `phase_idOutside`, `phase_unitary`, `phase_mul_apply`, `next_column`, `star_list_prod'`, `star_twoLevel`, `two_level_decomposition` |
| `ErrorBudget` | `prod_norm_le_one`, `map_prod_norm_le_one`, `two_factor_step`, `telescoping_delta`, `error_budget` |
| `GateSupport` | `kraus_branch_preserves_support`, `kraus_sum_preserves_support`, `support_preservation_composes` |
| `RiskBounds` | `weighted_markov`, `event_mass_mono`, `intersection_mass_le_each`, `positive_work_tail_control`, `dependent_chain_bound` |
| `QueueDeadline` | `exponential_service_tail`, `exponential_service_normalized`, `positive_deadline_miss_probability`, `small_mean_does_not_make_tail_zero` |
| `BandwidthReflection` | `normalized_susceptibility`, `exact_bandwidth_sensitivity`, `finite_positive_sensory_access_remains`, `bandwidth_bias_threshold` |
| `AnalyticBridge` | `integrating_factor_monotone`, `linear_barrier_preserves_safety`, `exponential_transient_bound`, `integrated_exponential_transient`, `integrated_transient_cost_bound`, `continuation_hazard_threshold`, `heterogeneous_quadratic_cost_identity`, `heterogeneous_uniform_is_not_minimum`, `eventually_better_continuation` |
| `RankAndCoalition` | `ranked_trace_length`, `ranked_polynomial_step_bound`, `total_penalty_excludes_all_members_gaining`, `real_lyapunov_descent_need_not_terminate` |
| `MetricShadow` | `embedding_distance_stability`, `protected_close_edge_margin`, `protected_separated_edge_margin` |
| `SemanticMap` | `identity_is_bijective`, `flipped_is_bijective`, `two_distinct_lossless_maps`, `calibrated_reference_fixes_binary_mapping` |
| `BridgeD1` | `dynamic_survival_equation`, `hazard_grows_without_bound`, `positive_accumulated_prefix`, `increasing_hazard_does_not_erase_prefix`, `exact_discounted_dominance_criterion`, `undiscounted_finite_crossover` |
| `BridgeE9` | `reaction_before_damage`, `positive_propagation_margin`, `local_buffer_covers_entire_reaction`, `escrow_prevents_pre_detection_application`, `incidence_has_circulation_kernel`, `lost_circulation_need_not_change_divergence` |
| `BridgeH6` | `charged_transition_bound`, `no_infinite_paid_run`, `budget_exhaustion_need_not_be_fixed`, `current_residual_bound`, `next_residual_bound` |
| `BridgeH7` | `rate_bounds`, `denominator_positive`, `equilibrium_is_fixed`, `fixed_point_unique`, `exact_transient`, `equilibrium_private_evidence_sensitivity`, `stubborn_anchor_limit`, `private_evidence_sensitivity_vanishes`, `exact_bias_threshold` |
| `BridgeH8` | `variance_identity`, `uniform_global_minimum`, `equality_only_at_uniform`, `blend_normalized`, `blend_cap_preserved`, `exact_excess_decay`, `gradient_flow_equation`, `flow_coefficient_in_unit_interval`, `original_upper_fails_along_restoring_flow` |
| `ReasonsRoute` | `optionValue_pointwise`, `optionValue_expectation`, `optionValue_strict`, `law_protects_everyone`, `indicator_law`, `law_dominates`, `law_dominates_strict`, `rival_fraction_le_one`, `rival_fraction_lt_one` |
| `SensorTail` | `sensor_tail`, `sensor_law_tail` |
| `ConsensusRate` | `bandwidth_contraction` |
| `RGFixedPoint` | `sq_root`, `gstar_pos`, `fixed_relation`, `beta_gstar`, `eigenvalue_gstar`, `beta_factor`, `beta_pos_below`, `beta_neg_above` |
| `FinalClosure` | `verifier_bound_iff`, `proxy_ungameable_iff`, `proxy_gameable`, `pruning_lowers_rate`, `living_unbounded`, `pruning_all_stalls`, `void_strictly_below`, `void_never_chosen`, `dominance_channels`, `coop_more_efficient`, `stewardship_sustains`, `extraction_depletes`, `sustained_iff` |
| `H8Bound` | `one_sub_u_pos`, `h8_of_concentration_bound`, `h8_graph`, `h8_iff`, `routing_bound`, `h8_routed` |
| `CorrelatedStress` | `many_touching`, `correlated_stress` |
| `LatticeLaplacian` | `symmetric_slope`, `ratio_eq_slope`, `second_difference`, `lattice_laplacian` |
| `SafeGenesis` | `migration_progress`, `safe_genesis` |
| `AdaptiveConsensus` | `weighted_error_bound`, `anchored_update_error`, `adaptive_history_error_bound` |
| `CascadeCore` | `workload_deadline`, `recursive_queue_bound`, `multi_epoch_entropy_bound`, `spectrum_expectation_floor`, `atomic_headroom`, `defection_deficit`, `sustained_deficit_crosses_buffer`, `buffer_threshold_crossed` |
| `DecisionAndScale` | `weighted_outcome_dominance`, `continuation_gain_pays_overhead`, `finite_branch_payoff_bound`, `duration_reward_bound`, `efficiency_gain_pays_cost`, `dominant_action_survives_mixture`, `local_verifier_cost`, `two_provider_unique_balanced_cost` |
| `E9Routes` | `surviving_disjoint_route`, `certified_repair_meets_deadline` |
| `GenerativeClosure` | `step_preserves_paid_activation`, `every_generated_active_is_funded`, `reserve_does_not_displace_existing_agents`, `generated_authority_stays_within_root` |
| `ReflectionContraction` | `complete_contraction_has_unique_fixed_point`, `finite_error_bound`, `accuracy_within_budget`, `residual_error_bound`, `residual_tolerance`, `post_update_error_bound`, `post_update_tolerance`, `run_commutes`, `paired_trajectory_bound`, `residual_geometric_bound`, `first_residual_stop_is_paid_and_accurate` |
| `ReflectionFuel` | `steps_bounded`, `quota_conserved`, `no_unbounded_paid_reflection`, `bounded_depth_can_cycle` |
| `RestrictedModels` | `anchored_consensus_dissipation`, `hhi_variance_identity`, `uniform_shares_minimize_hhi`, `uniform_shares_are_unique`, `quadratic_cost_floor`, `conditional_product_pushforward` |
| `ThermalBalance` | `intra_epoch_integral_bound`, `repair_before_buffer_exhaustion` |
| `TransportLaw` | `transport_nonneg`, `transport_ge_local`, `hhi_ge_uniform`, `monopoly_penalty` |
| `ControllerCertificate` | `stable_min_three`, `delta_min_three`, `rate_min_three`, `debt_min_three`, `alloc_min_three`, `total_min_three`, `total_min_three_le`, `band_min_three`, `stable_min_four`, `delta_min_four`, `rate_min_four`, `debt_min_four`, `alloc_min_four`, `total_min_four`, `total_min_four_le`, `band_min_four`, `stable_rob_three_two`, `stable_rob_three_four`, `total_rob_three_two`, `total_rob_three_three`, `total_rob_three_four`, `total_rob_three_two_le`, `total_rob_three_three_le`, `total_rob_three_four_le`, `band_rob_three`, `stable_rob_four_two`, `stable_rob_four_four`, `total_rob_four_two`, `total_rob_four_three`, `total_rob_four_four`, `total_rob_four_two_le`, `total_rob_four_three_le`, `total_rob_four_four_le`, `band_rob_four`, `pool_bills`, `corrected_bill_saving`, `allocation_undercharge_three`, `allocation_undercharge_four` |
| `FIFOWorkload` | `fifo_step`, `finish_le_upper`, `certified_prefix_meets_deadline` |
| `R16Feedback` | `map_iterate`, `tick_commutes`, `reactive_lockstep` |
| `UPTLawLife` | `refl`, `trans`, `U1`, `trans_sub`, `trans_ssub`, `lex_irrefl`, `lex_trans`, `lex_U1`, `freedom_first_U1_legacy`, `guard_first_stage`, `canonical_life_first_U1`, `life_guard` |
| `ClosedCohold` | `reachable_closed`, `reachable_least`, `factorised_cohold`, `outside_unchanged`, `crossing_boundary_changes_outside_later` |
| `R14Boundary` | `safe_step`, `every_good_trace_safe`, `journal_commutes`, `sink_commutes`, `outside_commutes`, `harmful_effect_refused`, `old_generation_refused`, `external_weather_is_not_a_replica_fault`, `recruitment_erasure`, `recruitment_never_ends_care`, `failure_has_a_named_exception` |
| `ReceivedCutRepaired` | `different_has_unmediated_path`, `outside_equal_of_cut`, `r2_no_crossing` |
| `ReadoutJoint` | `block_det_identity`, `shifted_det_identity`, `cp_coeff_nonneg`, `cp_coeff_pos`, `iso01_shift_nonneg`, `iso10_shift_nonneg`, `blockA_shift_nonneg`, `blockD_shift_nonneg`, `block_shifted_det_nonneg`, `quad_form_nonneg`, `choi_form_nonneg`, `positive_constant_not_cp`, `cp_constant_at_half_half`, `weight_nonneg`, `chain_nonneg`, `joint_record_lower`, `chain_ge_pow`, `hard_count_floor` |
| `ReadoutBounds` | `determinant_identity`, `determinant_lower`, `strictly_positive_determinant`, `spectral_lower`, `weight_nonnegative`, `conditional_record_lower`, `baseline_normalized` |
| `OriginalD1` | `expected_value_formula`, `original_dominance_counterexample`, `lifetime_density_is_normalized`, `lifetime_survival_tail`, `zero_ultimate_survival_with_positive_accumulated_value` |
| `OriginalE9AndH5` | `finite_speed_indistinguishability`, `no_sound_remote_alarm_before_arrival`, `h5_local_rate_does_not_bound_total_entropy` |
| `OriginalH6` | `original_thermal_depth_ceiling`, `banked_rate_is_contractive`, `banked_step_error`, `banked_exact_error`, `banked_paid_epsilon_accuracy`, `original_thermal_premises_allow_cycle` |
| `OriginalH7` | `decay_derivative`, `solves_original_equation`, `decay_limit`, `all_nonnegative_couplings_converge`, `every_initial_pair_is_represented` |
| `OriginalH8` | `actual_minimum_is_one`, `uniform_attains_minimum`, `original_bound_counterexample` |
| `ControllerFinality` | `tally_mono`, `quorum_has_honest`, `two_tallies_bound`, `quorum_intersection`, `committee_threshold`, `prefix_trans`, `equal_length_prefixes`, `certificates_do_not_equivocate`, `certificate_is_final`, `context_words_injective`, `run_append`, `step_floor_mono`, `run_floor_mono`, `grant_fields`, `floor_fields`, `held_refuses`, `retired_generation_refuses`, `pending_conflict_refuses`, `closed_sequence_refuses`, `receipt_names_success`, `certified_receipt_names_success`, `same_generation_no_context_conflict`, `checkpoint_replay`, `consume_once`, `restart_disabled`, `retained_floor_refuses`, `old_boot_refuses`, `deadline_refuses`, `issued_append`, `emission_bounded`, `issues_bounded_by_final_floor`, `step_stays_held`, `held_issues_nothing`, `grant_receipt_is_issued`, `hold_bounds_every_issued_grant` |
| `UPTFence` | `hold_safety`, `raise_then_nothing_lands`, `admission_only_lands_in_hold`, `check_at_apply_refuses` |
| `ConservedRouting` | `conserved_decomposes`, `regular_psi_is_hhi`, `hhi_uniform`, `monopoly_exceeds_uniform`, `h8_exact_general`, `thermal_ledger_positivity_strict`, `thermal_ledger_positivity_nonneg`, `jarzynski_bound_valid` |
| `P2P3` | `sensor_exp_positivity`, `scaling_sum`, `azuma_scaling`, `work_tv_floor`, `coordinate_sensitivity`, `telescoping_drop`, `semigroup_time_rescaling`, `ness_work_linear`, `work_floor_positive`, `liquidation_triggers`, `zero_breach_bound`, `bound_decays`, `escrow_ordering`, `fluctuation_bound_le_two` |
| `FIFOInstance` | `finishes_three`, `veto_envelope_three`, `alloc_completion_is_the_charge_three`, `control_lane_three_certified`, `finishes_four`, `veto_envelope_four`, `alloc_completion_is_the_charge_four`, `control_lane_four_certified`, `per_job_deadlines_three`, `per_job_deadlines_four` |
| `FIFOAdmission` | `checks_iff`, `certified_mono`, `certified_append`, `admission_preserves`, `completion_preserves`, `cancellation_preserves`, `all_occurrences_timely`, `queue_step_preserves`, `refinement_preserves_queue` |
| `R16TwoPhase` | `phase_tick_commutes`, `two_phase_lockstep` |
| `R16Cut` | `closed_cut_step`, `dependency_closure_step`, `difference_has_bypass`, `causal_separator`, `closed_cut_reactive`, `delayed_locality`, `pending_is_in_cut`, `private_cause_is_in_cut`, `delayed_effect_countermodel`, `omitted_edge_is_not_local` |
| `ReceivedCutR14Repaired` | `journal_projection_step_ext`, `sink_projection_step_ext`, `outside_projection_step_ext`, `journal_outside_unchanged`, `sink_outside_unchanged` |
| `ControllerFence` | `certified_hold_nothing_lands`, `both_targets_held` |
| `IntegrationCertificate` | `typed_gate_decomposition`, `finish_interval_deadline`, `psi2_uniform`, `h8_bound_two_node` |
| `R16R14` | `compromise_commutes`, `project_step`, `reference_two_phase_lockstep` |
| `R16Screened` | `screened_fibre_lockstep` |
| `UPTR12A` | `words_injective`, `grant_has_decision_scope`, `same_generation_cannot_rebind`, `finalized_receipt_is_in_log`, `finalized_receipt_is_authorize`, `changed_log_implies_checks`, `applied_effect_has_aligned_decision`, `raised_floor_refuses`, `wrong_effect_refuses`, `replay_refuses`, `original_fence_theorem_available` |
| `R17AQueueFinality` | `new_effect_has_current_permit`, `drain_currently_authorized`, `revoked_refuses`, `expired_refuses`, `installed_floor_refuses`, `spend_is_funded`, `application_has_source_binding` |
| `R17FIFOR17A` | `applied_fifo_effect_is_timely_and_authorized`, `ready_fifo_effect_applies_before_deadline` |
| `R17Funding` | `charged_append`, `atomic_target_append`, `application_conserves_funding`, `trace_conserves_funding`, `cumulative_charge_is_funded`, `used_ticket_refuses`, `accepted_ticket_is_consumed`, `replay_cannot_append`, `funded_admission_preserves`, `source_drain_preserves_reservation` |
| `R17WorkConcrete` | `mono_le`, `unfinished_before`, `carry_in_completion`, `ceil_div_covers`, `carry_in_affine`, `no_service_no_completion`, `U_succ_succ`, `exec_le_envelope`, `deadlines_met`, `row_congr`, `tail_admission_invariant`, `tail_admission_preserves_certificates`, `applied_stage_effect_is_timely_and_authorized`, `timely_but_revoked_is_not_delivery` |
| `TIWASource` | `outerUpdate_read_frozen`, `freeze_monotone`, `schedule_no_rework`, `readyToFreeze_no_inFlight` |
| `TIWAGuard` | `guard_data_frame`, `installGuard_monotone` |
| `TIWARecovery` | `bounded_visits`, `wave_count_at` |
| `TIWAWork` | `local_work_bound`, `ball_work_bound`, `total_work_bound` |
| `TopRealisability` | `top_realisable_of_singletons` |
| `FaultCover` | `fault_cover` |
| `G2Singleton` | `g2_discharge_hsingle`, `topRealisability_hsingle_discharged` |
| `G1Certificate` | `universal_protection_held` |
| `G1Executable` | `g1_admission_soundness` |
| `PhysicalGuard` | `factorization`, `interior_unchanged` |
| `MeanErgodic` | `cesaro_mean_id` |
| `TemporalSafety` | `admit_of_secure`, `secure_preserved`, `trace_secure` |
| `WorkIntegration` | `work_bound` |
| `RelationalBridge` | `bridge_preserves_safety` |
| `MeanErgodicDeep` | `cesaro_id`, `id_fixes_all` |
| `GuardFactorization` | `commutativity`, `factorization_zero` |
| `G1Complete` | `g1_append_safe` |
| `G2Outcome` | `g2_compose_valid` |
| `G3WorkBill` | `g3_append_work_bill` |
| `Htopkeeps` | `htopkeeps` |
| `SnuffyLocal` | `local_trajectory_growth_valid`, `tpt_state_preservation` |
| `G1FullDomain` | `g1_source_exhaustive`, `g1_fault_taxonomy_exhaustive`, `g1_append_preserves`, `replay_journal_step`, `journal_reactive_fidelity`, `transcript_capacity` |
| `G2WholeOutcome` | `g2_authorized_implies_closed`, `g2_authorized_implies_positive_work`, `g2_compose_valid`, `journal_whole_outcome`, `journal_outcome_family` |
| `G3CompleteBill` | `g3_success_implies_bound`, `g3_compose_valid`, `g3_wave_count_nonnegative`, `cumulative_charge_bound`, `valid_work_bill_from_complete_ledger`, `valid_bill_bound_in_age` |
| `GuardOperator` | `guard_within_tolerance`, `guard_exceeds_tolerance` |
| `HamiltonianDecomposition` | `total_is_sum`, `boundary_confinement_positive`, `exchange_hamiltonian_hermitian`, `exchange_conserves_total_charge`, `exchange_pumps_boundary`, `exchange_swap_unitary`, `exchange_swap_charge`, `exchange_swap_total`, `partial_trace_local_conjugation`, `guarded_history_reduced_state`, `syndrome_exchange_preserves_history`, `syndrome_exchange_charge` |
| `GuardSignature` | `guard_idempotent` |
| `WorkBilling` | `work_nonnegative`, `work_bound_preserved`, `decoder_work_balance`, `decoder_work_floor`, `decoder_work_floor_saturation`, `funded_decoder_entropy_bound`, `funded_decoder_cycles`, `charged_attempt_accounting`, `syndrome_stock_bound`, `syndrome_flux_balance`, `cumulative_maintenance_bound` |
| `DecoderRetraction` | `decode_encode`, `finite_code_recovery`, `nonvanishing_of_continuation`, `finite_code_self_grounding`, `inner_preserved_from_symplectic_flux`, `adjoint_decodes_isometry`, `boundary_observable_on_code`, `historical_query_preserved`, `historical_word_on_code`, `historical_word_expectation`, `boundary_observable_mul`, `boundary_observable_commutator`, `powers_intertwine`, `exponential_intertwines`, `historical_flow_roundtrip`, `historical_dual_kernel`, `work_shifted_flow_on_code`, `historical_gram_preserved`, `historical_gram_nondegenerate`, `coordinate_boundary_roundtrip`, `boundary_capacity_necessary`, `handoff_moves_reference_payload`, `handoff_preserves_norm`, `handoff_roundtrip`, `parallel_cnot_handoff`, `charged_archive_handoff` |
| `G2Splice` | `splice_grade`, `splice_realisable`, `outcome_splice`, `union_realizable`, `top_realisable`, `whole_outcome_greatest`, `fourStage`, `block_splice_run`, `block_splice_keeps` |
| `CorrelatedCeiling` | `ceil_touching`, `correlated_stress_ceil`, `prob_damage`, `near_card_le`, `choose_pow_le`, `damage_local_stochastic`, `correlated_family_ceiling` |
| `G1Held` | `good_cover`, `held_source_protection`, `initial_frame_normalised`, `held_step_normalised`, `held_run_normalised`, `held_source_qsl`, `zero_hamiltonian_trajectory`, `concrete_decoder_certificate`, `concrete_good_event_inhabited` |
| `G1E9` | `alarm_or_subthreshold`, `held_source_e9` |
| `G2Held` | `active_authorised_free`, `held_realises_top`, `held_source_top` |
| `G3Sweep` | `sweep_recovers`, `sweep_visits`, `waves_from_spread`, `sweep_bill` |
| `G3PatchDecode` | `patch_correction_succeeds`, `patch_sweep_bill` |
| `ReasonsEnsemble` | `ensemble_le`, `ensemble_strict` |
| `TheoremEightLyapunov` | `capacity_balance`, `solvent_cycle_energy_account`, `reserve_deficit_antitone`, `reserve_deficit_cap`, `replenishment_exact`, `replenishment_nonincrease`, `solvent_cycle_deficit`, `cycle_contracts`, `margin_pos`, `lyapunov_iterate` |
| `SmearingIntegral` | `smeared_reconstruction`, `smeared_boundary_reconstruction` |
| `ChannelExtension` | `ext_recovers`, `kron_isometry`, `ext_recovers_reference`, `ext_trace`, `ext_posSemidef` |
| `PureStateDistance` | `pure_infidelity_le`, `pure_fidelity_ge` |
| `BennettCounterpart` | `counterpart_heat_zero`, `merging_heat_pos`, `counterpart_same`, `counterpart_feasible`, `counterpart_more_slack`, `premise5_constructed`, `bennett_counterpart_computes`, `implemented_program_computes`, `implemented_program_output`, `implemented_program_workspace`, `implemented_program_history`, `implemented_step_fields`, `implemented_run_refines`, `implemented_run_history`, `implemented_quantum_norm`, `implemented_quantum_roundtrip`, `complete_cost_difference`, `complete_cost_strict_iff`, `implemented_work_ceiling`, `adiabatic_slack_window`, `switched_program_meets_deadline`, `adiabatic_feasible_iff` |
| `RegionBoundary` | `exists_crossing`, `region_bootstrap`, `whole_no_boundary`, `whole_H0_trivial` |
| `TimelyCare` | `care_served`, `exhaustion_fails`, `deadline_met`, `miss_within_shortage` |
| `DeadlineDemand` | `demand_le_supply`, `robust_demand` |
| `DecisionPermit` | `decision_words_injective`, `grant_names_certified`, `granted_policy_is_certified`, `wrong_action_rejected`, `certified_action_granted` |
| `ObservationWinning` | `policy_wins_iff`, `hidden_world_countermodel` |
| `R14Rivals` | `refl`, `trans`, `coordinate_envelope`, `complete_rival_transfer`, `hot_beats_pause` |
| `R15CausalGluing` | `boundary_representatives_iff`, `selected_representative_greatest`, `canonical_boundary_iff`, `interface_envelope_transfer`, `hidden_world_control` |
| `ReciprocityDistance` | `distance_floor`, `reciprocity_at_distance`, `reciprocity_strict_at_distance`, `canonical_tends_to_one` |
| `CutEquivalence` | `closed_iff_no_bypass` |
| `ConcatenatedDecoding` | `outer_decodes`, `mem_sub`, `decodes_unless_fails`, `decoding_failure_le` |
| `ChannelCP` | `kron_entry`, `amp_eq`, `compress_entry`, `mp_posSemidef`, `decoder_completely_positive` |
| `PureStateTraceNorm` | `sum_sq_eigenvalues`, `eigenvalue_cube`, `pureDiff_hermitian`, `vmv_smul`, `star_dot_swap`, `pure_cube`, `pure_trace_sq`, `pure_trace_norm` |
| `G1Refinement` | `guarded_step_continues`, `physical_protection`, `journaled_protection`, `physical_qsl_drift`, `physical_protection_qsl`, `physical_instance_inhabited` |
| `G2Physical` | `held_installation_keeps_all`, `top_dominates_continuation` |
| `G2Freedom` | `joint_holding`, `joint_holding_and_delivery` |
| `G3GoodEvent` | `sweep_success_on_good_event`, `complete_bill_with_archive` |
| `BennettExact` | `premise5_exact`, `window_exact`, `reversible_admin_computes` |
| `G3ArchiveStock` | `live_stock_bill`, `retained_stock_quadratic`, `rollover_quadratic` |
| `KnillLaflamme` | `eq_zero_of_eq_neg`, `spectral_projection`, `sandwich_anticomm`, `sandwich_scalar`, `knill_laflamme_of_distance` |
| `AgeReliability` | `cubic_spacetime_rate`, `log_distance_schedule`, `log_factor_not_absorbed` |
| `ExRecBound` | `exrec_pair_bound`, `circuit_level_rate`, `surface_code_rate` |
| `EdgeLaw` | `prob_push`, `push_localStochastic` |
| `MatchingWitness` | `card_symmDiff`, `half_faulty`, `matching_witness` |
| `SparseFailure` | `disjoint_windows`, `many_failures` |
| `ToleranceSweep` | `frozen_after`, `wrong_has_cause`, `wrong_le_of_eroder`, `wrong_subset_bad`, `sweep_density`, `pathwise_bill`, `recovery_tail` |
| `PassiveReference` | `stages_cover`, `total_failure_le`, `total_rewrite_cost` |
| `RedundantRecord` | `majority_decodes`, `tolerant_outer_decoder` |
| `BennettBatch` | `batched_window`, `premise5_batched` |
| `WeightedEdgeLaw` | `push_weighted`, `push_uniform`, `rate_iff`, `tightened_threshold`, `walk_bound`, `threshold_value` |
| `StageSchedule` | `total_with_transfers`, `stage_cost_le` |
| `WarmStart` | `warm_start`, `warm_start_event`, `fibre_mass_pos`, `fibre_reassembly`, `reverse_sampler_bound`, `heat_bath_normalized`, `heat_bath_stationary`, `pointwise_from_absolute`, `warm_start_from_mixing` |
| `WalkBound9` | `walk_bound_9`, `threshold_9`, `threshold_9_value` |
| `HistoryPolymer` | `halving_prefix`, `paired_history_bound`, `component_valid`, `truncation_bound`, `sampled_truncation_bound`, `branch_path_bound` |
| `ThermalEncoding` | `branch_compression`, `recovers`, `kron_orthogonal`, `recovers_reference` |
| `TransferRate` | `poly_le_two_pow`, `transfer_bill_le`, `transfer_bill_linear_in_age`, `retained_prefix_bound`, `attempt_stage_bound`, `polynomial_stage_bill`, `complete_attempt_bill`, `join_complete_bill` |
| `OuterLane` | `wavefront_coverage`, `interception_in_time`, `pool_strictly_dominant`, `outer_lane_risk` |
| `StagedMaximality` | `finset_subset_of_chain`, `stage_step`, `exists_stagemax_upto`, `exists_lex_maximal`, `freedomPre_earlier`, `four_stage_original_maximal` |
| `FoundingDominance` | `contribution_advantage_pos`, `contribution_strictly_dominant`, `no_abstention_equilibrium` |
| `ReachBeforeHarm` | `reach_before_harm` |
| `NarrowPlace` | `np_splitting_bound` |
| `HoldCommonAction` | `hold_is_common_viable_action`, `common_policy_from_hold`, `act_or_hold_policy`, `no_effect_action_safe_in_both`, `two_world_resolved` |
| `BookUPTExistence` | `refl`, `trans`, `U1`, `trans_sub`, `trans_ssub`, `lex_irrefl`, `lex_trans`, `climb`, `lex_aligned_exists`, `aligned_exists`, `no_needless_choice_exists`, `infinite_family_forces_needless_loss`, `infinite_family_has_no_aligned_option` |
| `BookUPTAdequacy` | `lex_iff_first_difference`, `lex_keeps_first_stage`, `improvement_never_costs_a_life`, `improvement_never_costs_existing_freedom`, `losing_a_life_is_never_better`, `restrainable_iff_needless`, `restrainable_iff_not_aligned` |
| `BookUPTAgents` | `shared_order_no_conflict`, `stall_is_best_response`, `stall_not_jointly_maximal`, `best_responses_can_stall`, `ssub_irrefl`, `ssub_trans`, `joint_maximal_exists` |
| `BookUPTBroadcast` | `majority_left`, `majority_outer`, `majority_right`, `entry_from_loyal`, `honest_dealer_validity`, `faulty_dealer_vector`, `agreement`, `om1_broadcast` |
| `BookUPTCountRefinement` | `exists_max`, `exists_maximal`, `count_refined_maximal`, `lex_irrefl`, `lex_trans`, `count_mono`, `canonical_count_refined`, `counting_is_an_extra_principle` |
| `BookUPTDominance` | `statewise_dominance` |
| `BookUPTHold` | `replay_ideal`, `crash_ideal`, `faithful`, `faithful_from_start`, `admissible_observer`, `ideal_lengths`, `hold_executes_nothing`, `mutant_no_replay_unfaithful`, `mutant_run_while_held_unfaithful`, `mutant_redeliver_unfaithful`, `timing_observer_sees_the_hold`, `faithful_instance` |
| `BookUPTHoldAdequacy` | `H_best_for_lives`, `L_is_lethal`, `lives_only_hold_leaves_lethal_undominated`, `faithful_hold_dominates`, `faithful_hold_strict_when_real`, `faithful_hold_ends_no_one` |
| `BookUPTHoldTimed` | `stutter_erasure`, `admissible_peer`, `autonomous_peer_sees_hold`, `schedule_holds_interval`, `cohold_closed` |
| `BookUPTImpartiality` | `sum_ge`, `sum_gt`, `len_mul_inv`, `some_chance_at_most`, `everyone_at_least_only_if_uniform`, `uniform_disadvantages_D`, `least_chance_at_most_two_fifths`, `ruling_gives_everyone_two_fifths`, `ruling_is_unique`, `len_inv_pos`, `weight_of_keepers`, `uniform_chance`, `uniform_equal_iff_equal_counts` |
| `BookUPTInfiniteGuard` | `refl`, `trans`, `U1`, `trans_sub`, `trans_ssub`, `lex_irrefl`, `lex_trans`, `lex_U1`, `freedom_first_U1_legacy`, `guard_first_stage`, `canonical_life_first_U1`, `life_guard`, `greedy_pos`, `greedy_neg`, `countable_maximal`, `life_guard_countable`, `countable_maximal_nonvacuous` |
| `BookUPTLaw` | `refl`, `U1`, `U2_partial_fails`, `U2_universal_protects`, `U3`, `E3_active`, `E3_guard`, `E7_dominance`, `hold_dominates_standby`, `hold_dominates_strike`, `hold_strictly_beats_standby`, `hold_strictly_beats_strike`, `strike_standby_tragic`, `swap_oa`, `swap_ob`, `E1_no_fixed_choice` |
| `BookUPTLawGuard` | `refl`, `trans`, `U1`, `trans_sub`, `trans_ssub`, `lex_irrefl`, `lex_trans`, `guard_first_stage` |
| `BookUPTLawLex` | `refl`, `trans`, `U1`, `trans_sub`, `trans_ssub`, `lex_irrefl`, `lex_trans`, `lex_U1`, `freedom_first_U1_legacy`, `guard_maximal_above` |
| `BookUPTLawRepair` | `refl`, `U1`, `aligned_congr`, `U2_star`, `U2_star_hypothesis_needed`, `progressive_retention`, `switch_without_retention`, `E7_top` |
| `BookUPTLifeGuardExists` | `refl`, `trans`, `U1`, `trans_sub`, `trans_ssub`, `lex_irrefl`, `lex_trans`, `lex_U1`, `freedom_first_U1_legacy`, `guard_first_stage`, `canonical_life_first_U1`, `life_guard`, `climb_from`, `life_guard_exists` |
| `BookUPTLottery` | `outcome_reachable`, `outcome_unique`, `fair_when_bound_before_reveal`, `choosing_after_reveal_forces_any_outcome`, `inconsistent_openings_disagree`, `cnt_or_le`, `cnt_compl`, `decoding_radius`, `unique_decoding` |
| `BookUPTLotteryMenu` | `cnt_congr`, `draw_invariant`, `duplicate_description_changes_nothing`, `draw_over_descriptions_is_manipulable`, `tragic_pair_equal_chances` |
| `BookUPTMonotone` | `inv_in_unit`, `factor_eq`, `factor_antitone`, `factor_nonneg`, `mul_mono`, `pow_mono`, `bound_antitone`, `grid_min_antitone`, `clip_antitone`, `ceiling_at_499_bounds_larger_service`, `audit_instance` |
| `BookUPTNoExchangeRate` | `weighted_sum_trades_a_life`, `grows`, `no_count_utility`, `no_faithful_count_utility`, `bounded_stakes_represent`, `frac_spec`, `frac_strict`, `frac_lt_one`, `frac_nonneg`, `bounded_utility_represents_counts`, `no_utility_on_who_is_kept` |
| `BookUPTQuorum` | `cnt_le`, `cnt_or_and`, `cnt_split`, `cnt_mono`, `cnt_pos`, `quorum_overlap`, `quorums_share_a_live_island`, `up_islands_form_a_quorum`, `cnt_lt_range`, `cnt_ge_range`, `cnt_band_range`, `overlap_bound_is_tight`, `U6_pool_quorums`, `U6_control_201`, `U6_live`, `U8_lockstep_majority`, `U5_threshold_counting` |
| `BookUPTRestraint` | `ssub_irrefl`, `ssub_trans`, `restraint_keeps`, `climb`, `maximal_restraint_exists`, `predator_tragic`, `hunting_not_restrainable`, `harmless_alternative_restrains` |
| `EmissionBound` | `requisite_variety`, `requisite_variety_prob`, `narrow_channel_bits`, `unmetered_energy_bound`, `emission_cannot_power` |
| `FoundingAnchor` | `campaign_funded`, `anchor_founds_iff`, `anchor_founds_mono` |
| `ContinuationPredicate` | `laterStage_refl`, `laterStage_trans`, `copy_not_laterStage`, `split_continues_both`, `faithful_hold_preserves`, `directed_by_other_not_free` |
| `BookContextualObservation` | `contextual_iff_congruent`, `contextual_on_invariant`, `identity_detector_implies_injective`, `forgotten_id_breaks_continuation`, `endpoint_sampling_misses_a_cycle`, `cache_can_be_hidden` |
| `IRSafeMaximality` | `safe_maximal_exists`, `cofinal_safe_maximal_is_globally_maximal`, `cofinal_global_maximal_exists`, `globally_maximal_first_stage_no_needless` |
| `IRSelectedMaximality` | `selected_safety_maximal_lifts_globally`, `cofinal_implies_selected_no_outside_improver`, `selected_realisation_suffices`, `cofinality_is_not_necessary`, `local_maximum_need_not_be_global` |
| `IRProfileAudit` | `obstruction_blocks_improvement`, `no_improvement_has_obstruction`, `obstruction_iff_not_better`, `improvement_transfers_to_faithful_profile`, `audited_no_excluded_improver`, `alleged_improver_exposes_bad_audit`, `audited_selected_global_maximal`, `full_coverage`, `faithful_profiles`, `certified_obstructions`, `local_choice`, `globally_maximal_without_cofinality`, `full_options_all_n`, `omitted_incomparable_profile`, `omitted_better_candidate`, `bad_abstraction_covers`, `bad_abstraction_passes_obstruction`, `bad_abstraction_is_not_faithful`, `incomplete_profile_list_is_not_coverage` |
| `IRFiniteProfileObstruction` | `aboveEvery_gt_mem`, `faithful_chain_rep_is_exact`, `no_finite_faithful_chain_profiles`, `impossible_finite_profile_audit_for_original_chain`, `unbounded_chain_lacks_global_maximum` |
| `IRInfiniteFinitaryMaximality` | `feasible_downward`, `finite_chain_capture`, `chain_union_feasible`, `derived_chain_upper_bound`, `greedyStep_preserves_feasible`, `greedyStep_extends`, `greedyStep_adds_if_feasible`, `stage_increasing`, `stage_monotone`, `stage_feasible`, `finite_stage_capture`, `limit_feasible`, `cannot_feasibly_add_missing_particular`, `infinite_full_feasible_aligned_exists`, `infinite_one_stage_lex_aligned_exists`, `all_prefixes_feasible_forces_full_retention`, `original_chain_not_finitary_closed`, `pair_empty_feasible`, `pair_full_retention_infeasible`, `pair_all_unconflicted_retained`, `pair_cannot_keep_both`, `nontrivial_infinite_full_feasible_instance` |
| `IRTwoStageInfiniteLex` | `independent_two_stage_global_lex_maximum`, `independent_any_finite_stage_lex_maximum`, `coupled_choice_feasible`, `coupled_two_stage_lex_maximum`, `empty_feasible_without_prohibitions`, `unconstrained_limit_includes_every_particular`, `independent_maxima_not_jointly_feasible`, `coupled_choice_not_joint_independent_maximum` |
| `IRCoupledFinitaryTwoStage` | `feasible_downward`, `chooseStep_extends`, `chooseStep_feasible`, `chooseStep_adds`, `phase_increasing`, `phase_monotone`, `phase_feasible`, `phaseLimit_contains_base`, `finite_phase_capture`, `phaseLimit_feasible`, `phaseLimit_no_cross`, `phase_cannot_add_missing`, `firstChoice_feasible`, `fullChoice_feasible`, `firstChoice_only_higher`, `fullChoice_first_iff`, `no_first_stage_strict_improver`, `no_second_stage_strict_improver`, `coupled_two_stage_full_feasible_lex_maximal` |
| `IRResourceDerivedClosure` | `resource_feasible_iff_finite_forbidden`, `empty_capacity_feasible`, `resource_capacity_implies_global_lex_maximality`, `shared_capacity_excludes_joint_pair`, `shared_capacity_global_original_lex_maximal`, `finite_prefix_eventually_absent`, `full_infinite_not_eventually_absent`, `eventual_absence_not_exactly_finitary` |
| `IRFiniteRefutationCriterion` | `finite_refutations_give_exact_representation`, `any_exact_finite_pattern_model_is_finitely_refutable`, `finite_refutations_iff_exact_finite_patterns`, `finite_refutations_force_downward_feasibility`, `source_two_stage_maximal_from_physical_finite_refutations`, `resource_feasibility_has_finite_refutations`, `mandatory_positive_retention_not_finitely_refutable` |
| `IRMandatoryBaselineMaximality` | `first_protected_feasible`, `final_protected_feasible`, `final_protected_contains_required`, `first_protected_base_or_higher`, `final_first_priority_iff`, `no_required_first_improver`, `no_required_second_improver`, `required_baseline_full_feasible_original_lex_maximal`, `resource_capacity_plus_mandatory_baseline_maximal`, `required_duty_is_genuinely_positive` |
| `IRViability` | `viable_now_safe`, `viable_horizon_monotone`, `robust_invariant_implies_all_horizons`, `robust_policy_preserves_every_finite_trace`, `safe_immediate_but_not_viable` |
| `IRInfiniteHistoryCompactness` | `viable_weaken`, `forever_viable_has_common_action`, `compact_policy_keeps_forever_viable`, `derived_infinite_robust_safe_history`, `countdown_finite_budget_viable`, `countdown_any_finite_horizon_viable`, `countdown_budget_exhausts`, `infinite_action_branching_blocks_common_policy` |
| `IREnergyReplenishment` | `draining_viable_iff`, `finite_bank_cannot_support_all_horizons`, `paid_reserve_step_invariant`, `uniform_paid_supply_derives_all_horizons`, `uniform_paid_supply_derives_infinite_safe_policy`, `intermittent_supply_fails_one_step` |
| `IRTypedTraceChecker` | `checkStep_sound`, `checkSegments_sound`, `verifyTraceData_sound`, `valid_segments_every_step_paid`, `accepted_trace_every_record_above_reserve`, `accepted_trace_every_step_paid`, `accepted_trace_every_step_balanced_and_bounded`, `accepted_example_is_computable`, `invalid_singleton_rejected`, `missing_tick_rejected`, `forged_balance_rejected`, `insufficient_step_supply_rejected`, `too_rapid_logged_descent_rejected`, `accepted_records_without_physical_refinement_do_not_certify_reality`, `accepted_trace_physical_reserve_with_error` |
| `IRDeferredEffects` | `held_gate_can_still_deliver_old_physical_effect`, `cleared_pending_has_no_delivery`, `quiescent_hold_has_no_delivery`, `certified_hold_does_not_clear_existing_queue`, `no_landing_of_empty_backlog` |
| `IRQuiescenceAck` | `ack_sound`, `no_landing_after_fresh_ack`, `certified_quiescent_hold`, `stale_ack_does_not_protect` |
| `IRAtomicQuiescence` | `closed_dispatch_is_noop`, `quiescent_step`, `quiescent_under_arbitrary_finite_commands`, `close_empty_queue_is_quiescent`, `close_then_no_modeled_landing`, `source_certified_log_and_quiescent_actuator`, `empty_unclosed_queue_counterexample`, `closed_but_not_drained_counterexample` |
| `IRInFlightQuiescence` | `quiescent_step`, `barrier_holds_under_any_finite_interleaving`, `close_fully_drained_is_quiescent`, `source_certified_finality_with_inflight_barrier`, `in_flight_defeats_queue_only_ack`, `open_admission_defeats_empty_backlogs` |
| `IRJsonTraceChecker` | `verifyJsonText_sound`, `verifyJsonText_recorded_reserve` |
| `IRWatchdogLatencyEffects` | `additive_fault_to_quiescence_bound`, `window_age_bounded`, `guarded_reaction_window_remains_below_threshold`, `guarded_quiescence_endpoint_safe`, `disabled_complete_mediation_blocks_modeled_effect`, `independent_bypass_defeats_disabled_gate`, `fenced_and_drained_pipeline_stops_modeled_effects`, `fast_shutdown_does_not_erase_prior_breach`, `absorbing_no_service_counterexample`, `valid_logged_trace_can_coexist_with_unmodeled_physical_breach` |
| `IRPhysicalGuard` | `post_effect_guard_sound`, `omitted_jump_counterexample`, `sequential_post_effect_safety` |
| `IRControllerPhysical` | `certified_hold_preserves_log_derived_physics`, `certified_hold_physical_refinement`, `unchanged_log_insufficient_without_coverage`, `later_bounded_effect_safe` |
| `IRMicrostepInvariant` | `all_recorded_microsteps_safe`, `endpoints_safe_interior_unsafe`, `certified_hold_and_microstep_safety`, `omitted_microstep_counterexample` |
| `IRInterSampleEnvelope` | `every_unsampled_instant_safe`, `every_second_sample_safe_but_interior_unsafe`, `hidden_pulse_breaks_zero_rate` |
| `IRStoredEnergyCommonMode` | `zero_escape_zero_remnant_requires_full_capacity`, `undersized_clamp_forces_escape_or_remaining`, `synthetic_magnetic_store_exceeds_capacity`, `energy_capacity_does_not_bound_peak_voltage`, `two_agreeing_untrusted_sensors_can_both_be_wrong`, `one_physically_sound_channel_with_margin`, `failed_analog_domain_denies_modeled_command`, `failed_physical_fence_denies_modeled_command`, `all_enables_pass_but_independent_bypass_lands`, `intersample_endpoint_acceptance_does_not_ensure_safety` |
| `IRControlledReentry` | `primary_alone_cannot_start`, `no_direct_hold_to_active`, `bad_diagnostic_returns_to_hold`, `physical_unready_returns_to_hold`, `failed_slew_returns_to_hold`, `stale_epoch_relocks_active`, `failed_fence_relocks_active`, `failed_watchdog_relocks_active`, `three_authorized_phases_reach_active`, `non_active_mode_rejects_command`, `failed_watchdog_rejects_command`, `failed_fence_rejects_command`, `accepted_diagnostics_imply_recorded_trace_valid`, `start_guard_constructed_from_verified_inputs`, `diagnostic_guard_constructed_from_verified_inputs`, `ramp_guard_constructed_from_verified_inputs`, `source_level_composition`, `no_external_auth_stays_in_hold`, `example_reentry`, `reentry_is_not_itself_a_service_proof`, `model_accepted_physical_flag_without_real_plant_refinement` |
| `IRCapabilityNoninterference` | `distinct_address_domains`, `primary_write_cannot_change_maintenance`, `primary_program_noninterference`, `primary_program_full_maintenance_projection`, `maintenance_observer_noninterference`, `primary_program_preserves_authorization_bit`, `primary_only_writes_cannot_reenter_locked_supervisor`, `external_maintenance_write_changes_target`, `external_maintenance_write_preserves_other_cells`, `additional_bus_master_can_set_auth_source_cell` |
| `IRA1HostMediation` | `dma_cannot_mutate_maintenance`, `maintenance_target_is_rejected`, `outside_dma_window_is_rejected`, `inside_dma_window_is_executed`, `host_step_maintenance_invariant`, `host_step_preserves_privilege_ceiling`, `any_finite_host_sequence_preserves_maintenance`, `any_finite_host_sequence_preserves_privilege_ceiling`, `admitted_a1_host_transitions_cannot_authorize_reentry`, `unrestricted_dma_changes_maintenance` |
| `IRA1PageCapability` | `execute_preserves_mask`, `rejected_grant_does_not_change_state`, `admitted_grant_is_permitted`, `execute_preserves_capability_invariant`, `execute_preserves_maintenance`, `execute_preserves_privilege`, `execute_preserves_safe`, `all_finite_host_and_page_grants_remain_safe`, `all_finite_host_and_page_grants_preserve_mask`, `all_finite_host_and_page_grants_preserve_maintenance`, `t11_t12_t13_host_traces_cannot_forge_reentry`, `unguarded_page_grant_breaks_capability_invariant` |
| `IRA1PacketIngress` | `permit_implies_auth_epoch_and_exact_sequence`, `wrong_epoch_cannot_be_accepted`, `wrong_sequence_cannot_be_accepted`, `auth_failure_cannot_be_accepted`, `accepted_packet_increments_sequence`, `replay_of_accepted_packet_rejected`, `ingest_preserves_epoch`, `ingest_preserves_valid_session`, `any_finite_packet_stream_valid`, `any_finite_packet_stream_epoch_unchanged`, `field_step_preserves_maintenance`, `field_step_preserves_supervisor`, `any_finite_ingress_cannot_write_maintenance`, `any_finite_ingress_cannot_change_supervisor`, `accepted_cryptographically_unverified_packet`, `no_sequence_check_allows_duplicate_replay`, `source_sequence_guard_rejects_same_packet_replay` |
| `IRA1CausalField` | `field_permit_sound`, `impossible_distance_in_deadline_is_rejected`, `accepted_field_uses_ir85_ingress`, `field_ingress_preserves_ir85_session`, `all_finite_causal_field_events_preserve_source_session`, `nominal_report_accepted_without_crypto_security`, `accepted_report_cannot_prove_real_causal_transport`, `impossible_nominal_distance_rejected` |
| `IRA1DurableJournal` | `queue_never_acknowledges`, `queue_never_changes_durable`, `reboot_preserves_committed_journal`, `reboot_preserves_previously_issued_acks`, `step_preserves_ack_soundness`, `one_step_preserves_durable_suffix`, `durable_extension_transitive`, `any_finite_journal_stream_preserves_ack_soundness`, `any_finite_journal_stream_is_append_only`, `premature_ack_without_commit_breaks_soundness`, `digest_check_sound_as_equality_only`, `untrusted_hash_equality_does_not_prove_journal_equality`, `synthetic_flush_then_reboot_preserves_receipt` |
| `IRA1PacketJournalJoin` | `committed_payload_is_durable`, `committed_payload_is_acknowledged`, `commit_ingress_preserves_packet_session`, `commit_ingress_preserves_ack_soundness`, `commit_ingress_preserves_receipt_persistence`, `commit_ingress_preserves_joint_safety`, `reboot_preserves_joint_safety`, `all_finite_packet_and_reboot_events_preserve_joint_safety`, `non_atomic_packet_crash_loses_accepted_history`, `atomic_source_ingress_reboot_retains_accepted_payload` |
| `IRA1CommissionEscrow` | `commissioning_for_window_implies_every_earlier_tick_funded`, `insufficient_finite_commission_is_rejected`, `positive_recurring_cost_precludes_unfunded_infinite_commission`, `replenished_commission_derives_all_horizon_reserve_policy`, `initial_only_funding_can_fail_first_service`, `favorable_supply_not_robust_even_for_one_tick` |
| `IRA1Delegation` | `subset_checker_sound`, `permitted_subset_is_not_merely_named`, `rejected_delegation_does_not_change_state`, `delegation_preserves_parent_authority`, `delegate_preserves_nonescalation`, `arbitrary_finite_delegation_chain_never_escalates`, `finite_delegation_chain_preserves_root_authority`, `delegated_child_stays_within_t11_global_mask`, `all_descendants_stay_within_t11_global_mask`, `unchecked_child_grant_can_escalate_authority`, `example_delegation_rejects_escalation` |
| `IRA1Retirement` | `release_permit_sound`, `released_controller_is_source_absorbing`, `denied_release_keeps_custody`, `authorized_release_satisfies_full_finality`, `one_lifecycle_step_preserves_release_safety`, `arbitrary_finite_retirement_lifecycle_is_safe`, `weak_retirement_ignores_inflight_effects_and_handoff`, `model_retirement_requires_handoff_and_termination` |
| `IRA1NineClassComposition` | `authorize_commission_preserves_finite_window`, `post_release_source_world_is_absorbing`, `step_preserves_all_a1_source_invariants`, `arbitrary_finite_nine_class_source_trace_is_safe`, `already_released_world_freezes_every_a1_event` |
| `IR93GlobalComposition` | `compose_step`, `compose_trace`, `assemble_preservation`, `covered_step` |
| `IR98FeasibleFamilyTransfer` | `original_order_transfer_of_no_new_improver` |
| `IR99ResourceImproverCoverage` | `physical_resource_soundness_implies_no_new_improver`, `physical_accounting_original_order_maximal` |
| `IR100PhysicalAccountingWitness` | `witness_implies_capacity_feasible`, `witness_implies_modeled_feasible` |
| `IR101ProtectedSector` | `sector_preserved_along_reach`, `reversible_does_not_force_protection` |
| `IR103LedgerContinuityCountermodel` | `append_only_does_not_imply_living_continuity`, `append_only_preserves_past` |
| `IR104ThreeCaseAuthorization` | `all_three_cases_accounted`, `accounting_allows_unconsented`, `authorized_continuation`, `authorized_consented_end`, `authorization_excludes_unconsented` |
| `IR105AuthorizationIndependence` | `accounting_and_subject_input_do_not_imply_x3`, `authorization_or_continuation_suffices` |
| `IR108ObservationObstruction` | `same_observation`, `each_state_has_safe_action`, `no_common_safe_action`, `no_observation_only_safe_policy` |
| `IR109RobustObservationViability` | `robust_policy_safe`, `robust_viability_step`, `robust_viability_all_finite_traces` |
| `IR113ObservationClassSelection` | `observation_policy_exists_iff_common_viable_action`, `common_actions_give_finite_trace_viability`, `ir108_blocks_common_safe_action` |
| `IR110WatchdogRobustObservation` | `robust_window_from_shared_readout` |
| `IR112RobustContinuityOptions` | `robust_continuation_and_options`, `executable_option_not_maximal_freedom` |
| `IR115WatchdogToAgency` | `watchdog_contract_yields_common_protected_action`, `certified_action_preserves_continuity_and_options`, `enabled_nonblocking_certified_action` |
| `IR116CumulativeSubjectDuties` | `cumulative_duties_preserved`, `initial_cohort_retains_continuity_and_every_required_option`, `old_or_new_remains_owed`, `empty_registry_vacuity_countermodel` |
| `IRBeliefViability` | `prune_inside`, `prune_monotone`, `approx_inside_initial`, `invariant_beliefs_survive`, `stable_belief_kernel_is_greatest`, `stable_belief_has_policy`, `real_next_belongs_to_updated_belief`, `belief_policy_one_step_sound` |
| `IRBeliefTrace` | `advance_preserves_true_membership`, `advance_preserves_kernel`, `finite_trace_belief_and_physical_safety`, `stable_belief_policy_safe_on_all_finite_traces` |
| `IRServiceProgress` | `ranked_trace_reaches_goal`, `infinite_hold_is_safe_but_never_serves`, `favourable_transition_not_sufficient` |
| `IRBeliefService` | `service_absorbing_across_belief_update`, `guarded_belief_step`, `guarded_belief_trace`, `bounded_observed_service_for_actual_physical_state` |
| `IRStutterObstruction` | `stuttering_non_goal_refutes_any_progress_rank`, `unchanged_unserved_belief_blocks_rank`, `initially_unserved`, `initial_is_good`, `helpful_and_stalling_disturbances`, `adverse_event_keeps_belief_unchanged`, `beneficial_option_does_not_force_robust_belief_progress` |
| `IRBoundedStalls` | `partition_trace`, `invariant_through_trace`, `goal_absorbs_through_trace`, `unserved_trace_rank_accounting`, `bounded_stall_budget_forces_service`, `stalling_is_counted` |
| `IRClockedService` | `interstep_upper_bound`, `clocked_observed_service_if_steps_complete`, `progress_without_latency_has_no_deadline`, `frozen_clock_is_not_completion_evidence` |
| `IRClockedBoundedStalls` | `actual_trace_service_and_elapsed_bound`, `exact_horizon_clocked_service`, `count_budget_alone_does_not_bound_wallclock` |
| `IRObservedClockedStalls` | `actual_state_safe_and_served_with_bounded_stalls` |
| `IR95SharedStateRefinement` | `one_step_refinement`, `finite_trace_refinement`, `safe_correspondence` |
| `IR96DisturbanceSimulation` | `robust_reach` |
| `IR117SourceInstallationAdapter` | `certified_quiescent_step_preserves`, `installed_finite_trace_guard`, `installed_finite_trace_cumulative_duty`, `initial_subjects_keep_physical_guard_and_options`, `bypass_defeats_quiescent_log`, `unseen_option_revocation_countermodel` |
| `IR118InFlightBacklogBudget` | `closed_step_conserves_committed_effects`, `closed_run_conserves_committed_effects`, `closed_run_landed_bounded_by_initial_backlog`, `physical_reserve_holds_during_closed_drain`, `closed_source_budget_does_not_imply_future_options`, `open_admission_defeats_initial_backlog_budget` |
| `IRContinuation` | `source_level_finite_simulation`, `future_observations_agree_under_refinement`, `reuse_contextual_observation_certificate`, `same_observation_different_physical_states` |
| `IRHistoryProvenance` | `one_step_faithful`, `finite_history_provenance`, `physical_origin_never_rewritten`, `recorded_origin_never_rewritten`, `faithful_records_cannot_merge_different_origins`, `forgotten_origin_counterexample` |
| `IR119MultimindSourceWitness` | `append_event_preserves_all_provenance`, `append_event_preserves_physical_origin`, `witnessed_step_preserves_guard_and_provenance`, `witnessed_finite_trace_guard_and_provenance`, `witnessed_finite_trace_retains_origins`, `complete_record_can_coexist_with_terminated_subject` |
| `IR120WitnessedDrainCohort` | `source_step_landed_monotone`, `certified_step_landed_monotone`, `witnessed_closed_drain_invariant`, `witnessed_drain_retains_cohort_and_safety` |
| `IRAggregateBudget` | `aggregate_post_effect_safe`, `escrow_spent_bounded`, `charged_events_bounded`, `no_automatic_budget` |
| `IRChannelInventory` | `apply_coupled`, `run_coupled`, `run_physical_sum`, `bounded_all_channel_effects`, `incomplete_inventory_counterexample`, `no_unconditional_total_budget` |
| `IREventTimeBudget` | `strict_clock_progress_bounds_event_index`, `horizon_bounds_trace_length`, `finite_list_charge_bound`, `nonzeno_timed_metered_guard`, `stalled_clock_allows_unbounded_events` |
| `IRPhysicalAbstraction` | `physical_run_sum`, `residual_sum_bound`, `physical_guard_with_residual`, `time_bounded_physical_guard`, `empty_classification_counterexample` |
| `IRResidualEscrow` | `metered_residual_bounded_by_escrow`, `escrow_residual_physical_guard`, `timed_escrow_physical_guard`, `conserved_bookkeeping_does_not_bound_unmetered_effect` |
| `IR121MeteredResidualEscrow` | `ir25_remaining_escrow_bounds_residual_spend`, `residual_step_preserves_closed_reserved_guard`, `all_finite_residual_traces_preserve_guard`, `residual_drain_keeps_subjects_protected`, `positive_metered_residual_is_possible`, `balanced_ledger_does_not_imply_physical_metering` |
| `ReachTiming` | `round_trip_in_time`, `reach_round_trip`, `net_coverage`, `fence_in_time` |
| `FoundingPivotal` | `pivotal_contribution_dominant`, `others_short`, `all_necessary_dominant` |
| `GrowingBill` | `pv_nonneg`, `endowment_suffices`, `polynomial_bill_summable` |
| `ContinuationSubject` | `laterStage_refl`, `laterStage_trans`, `copy_not_laterStage`, `split_continues_both`, `care_keeps_freedom`, `directed_by_other_not_free`, `faithful_hold_preserves` |
| `NoisyPooling` | `noisy_advantage`, `noisy_pool_strictly_dominant` |
| `StageBridge` | `mem_slice_iff`, `slice_eq_of_tuple_eq`, `slice_ssubset_of_tuple_lt`, `lexBetter_of_lexLt`, `four_stage_aligned`, `four_stage_no_needless_loss` |
| `HoldFromCycle` | `hsafe_of_holding_cycle`, `classViable_iff_IR113`, `hold_common_action_of_cycle`, `one_policy_from_holding_cycle` |
| `FiniteCharacter` | `realisable_iff_finite`, `realisable_finitary`, `four_stage_maximal_of_compact` |
| `StagedAlternatives` | `stage_step_alt`, `exists_stagemax_upto_alt`, `exists_lex_maximal_alt` |
| `ExclusionRadius` | `exclusion_radius`, `received_effect_bound` |
| `CommonPolicyMaximal` | `common_policy_maximal` |
| `CommonPolicyTop` | `top_policy_exists`, `top_policy_greatest` |
| `FoundingCover` | `founding_cover_exists`, `founded_reach` |
| `CountablePooling` | `pool_strictly_dominant_ennreal`, `countable_keepers_pool`, `countable_keepers_noisy_pool` |
| `ExpandingWavefront` | `expanding_coverage`, `expanding_round_trip` |
| `ItemisedRisk` | `account_le_of_kernel`, `itemised_risk` |
| `ChannelMeter` | `channel_le_meter`, `every_channel_excluded`, `every_channel_bits_bounded` |
| `PerLossCheck` | `maximal_iff_per_loss` |
| `CorrelatedHolding` | `random_threat_bound`, `correlated_holding_bound`, `random_threat_independent`, `random_threat_correlated` |
| `BookCanonicalDominance` | `le_refl`, `le_trans`, `le_iff_eq_or_better`, `all_events_iff_statewise`, `full_canonical_top`, `mass_mono` |
| `BookDurableDrain` | `represented_lengths`, `step_preserves`, `run_preserves`, `held_step_changes_no_durable_field`, `drained_refinement`, `can_drain`, `cache_reset`, `cache_survives_record`, `cache_advance`, `cache_complete` |
| `BookTrustedCounter` | `count_zero_iff_clean`, `endpoint_counter_certificate`, `count_append`, `prefix_counter_monotone`, `wrapping_counter_misses_two`, `missing_event_misses_violation` |
| `BookCoholdFixedPoint` | `iterate_contains_seed`, `iterate_below_every_certificate`, `stabilised_least`, `least_bill` |
| `BookCheckpointBudget` | `install_from_complete_cache`, `anchor_survives_record`, `loaded_anchor_is_correct`, `suffix_reconstruction`, `tail_bound`, `gated_record_preserves_window`, `supplied_cost_bound` |
| `BookDeliveryGap` | `no_local_choice_succeeds_in_both_worlds`, `indistinguishable_local_recovery`, `sink_side_identity_resolves_this_gap`, `distinguishing_query_resolves_this_gap` |
| `BookObservedHold` | `not_forbidden_iff_safe`, `clean_iff_safe_trace`, `accepted_iff_safe_trace`, `safe_trace_member`, `accepted_preserves_each_held_operation` |
| `IR134SourceExtractedOutcome` | `executed_selected_is_reachable`, `original_order_maximality_of_executed_audit`, `policy_reach_trans`, `source_run_is_policy_reachable`, `source_run_retains_original_cohort_and_required_options`, `every_source_prefix_retains_owed_cohort`, `original_cohort_continues_with_options_at_every_source_state`, `reactive_world_original_order_selected_maximal`, `reactive_environment_is_not_a_fixed_disturbance_transcript`, `arbitrary_realisability_witness_can_be_false`, `unexercised_freedom_under_permanent_stutter` |
| `IR135CommonPolicyWorlds` | `reactive_trace_is_source_trace`, `same_policy_worldwise_original_maximality_and_continuation`, `observation_class_certificate_constructs_common_protection_policy`, `each_reactive_world_has_its_own_successful_policy`, `each_world_separate_success_does_not_yield_common_policy` |
<!-- END THEOREM INDEX -->

---

