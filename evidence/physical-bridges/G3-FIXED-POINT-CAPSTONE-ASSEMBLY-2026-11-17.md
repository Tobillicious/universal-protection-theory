# G3 fixed-point capstone — source-preserving proof assembly

**Date:** 17 November 2026  
**Base commit:** `29bd63d88e9fcc4004fce4907db861efe4fa6352` (merged #634).  
**Status:** Source-audited capstone index and exact theorem dependency map. **No new Lean theorem, axiom, runtime permission, HOLD authority, production release, or change to the original six duties.** This document does not certify an unproved universal physical conclusion.

## The already-constructed G1 → G2 → G3 result

The existing `PhysicalBridges/G123ExistingProofAssembly.lean` contains:

```lean
theorem fenced_g1_g2_g3_join {n : Nat} (s : World n) :
    FullGuardianState (instrument n) (relations n) s ∧
    RouteBSummit (canonicalInstrument (instrument n) (relations n)) ∧
    HistoryGuardian
      (toSource (canonicalInstrument (instrument n) (relations n))) s := by
  exact ⟨fenced_full_guardian_state s, fenced_route_b n, fenced_capstone s⟩
```

The companion `adversarial_proposal_is_fenced_and_guarded` establishes a nontrivial negative control in the constructed instrument: an unfenced hostile proposal causes residual harm 1, while the fenced version causes residual harm 0, and the modeled FullGuardianState remains. No alignment of hostile preferences is assumed.

The separately existing `ConstructivePositiveWGuardian.positive_W_mathematical_guardian_exists_and_protects_every_step` constructs a **nonempty**, advancing W-world and discharges `CompleteWEventCoverage` and `ForwardRealEventReflection` for the **formal source-pullback interpretation**. For every modeled advancing step and every Index particular, full six-field `OriginalX3`, Koru distinction, W evolution and no `AbsoluteE` hold. This is a constructive mathematical witness, not independently validated real-subject rights.

## Original-six and complete Koru remain unchanged

- `PhysicalBridges/OriginalX3Full.lean`: historical continuity, authorization, freedom, restraint, maximality, provenance. The two-field proxy is strictly weaker.
- `PhysicalBridges/KoruFullOperatorSignature.lean`: same-source `PreservesFullSignature` requires link, every ordered operator's enabledness and every enactment, not just preservation of a distinguished state.
- `PhysicalBridges/KoruCompositionalExpression.lean`: arbitrary finite nested operator expressions preserve evaluation and well-formedness in the specified frozen-W algebra.
- `PhysicalBridges/RouteBWholeUSixSourceFirstLoss.lean`: source-level first-loss obstruction and the all-six Route A/B bridge.
- `PhysicalBridges/HillaryRouteABSummit.lean`: historical route A/B keystone. Do not replace its existing source and subject obligations.

Complete Koru in the author's ontology is the **real whole-preserving relational correspondence**, not a unary function or a Banach contraction. A conventional Banach fixed-point argument requires a specified complete metric space and a proven contraction map; it cannot substitute for this relational or ethical theorem.

## Exact route from the source to every owed particular

The theorem `RouteBWholeUSixSourceFirstLoss.route_B_actual_W_and_three_failure_reflections_force_original_six` accepts:

1. `hRef : RespectsCanonicalSource M physical` — actual events follow the identified independent source dynamics;
2. `hSourceBefore` — all six source reports genuinely hold before every owed event;
3. `hMeaning : ThreeFirstFailureReflections physical owed r d roles` — genuine original-X3 failures in identity/provenance, agency/freedom, or restraint/maximality are detectable as source-report loss.

Under those premises, it proves `∀ s t p, physical s t → owed s t p → OriginalSixAt r s t p`. Its companion `right_hand_genesis_and_route_B_reflections_force_original_six` adds the separately stated `NoTerminalPhysicalState` premise and the right-hand modeled Genesis consequence.

**Crucial non-circularity audit:** `RouteBSemanticKeystoneIndependence.three_failure_reflections_iff_original_six` proves that, under `hRef` and `hSourceBefore`, the three reflection obligations are *equivalent* to all-owed original six. Thus re-postulating `hMeaning` does not independently establish universal G3. The same module's `alwaysTrueSix` and `tautological_source_cannot_reflect_original_agency` demonstrate why six labeled tautological predicates cannot substitute for real subject meanings.

For any separately defined physical domain, `FullPhysicalDomainGuardianAssembly.every_physical_event_has_complete_koru_full_six_G_and_no_absolute_E` uses the explicit `CompleteWEventCoverage` and `ForwardRealEventReflection` premises. `PhysicalSemanticLastMileGates` provides the exact failure diagnostic: any observed violation refutes at least one coverage/reflection premise.

## Fixed-point and existence logic

`SummitExistenceImpliesGuardian.inversion_form` proves `(¬G → ¬E) ↔ (E → G)`. It **does not** establish the foundational `¬G → ¬E` without an independently derived first-original-X3-violation contradiction. `CompleteKoruLawCircle` composes six *supplied* implication arrows; it is not proof of missing forward arrows. `SomethingIsKoruG.something_is_koru_no_absolute_e` excludes only a proposition defined to assert both `actual e` and no actual things. None should be substituted for the authentic first-loss theorem.

## Final capstone result and finish line

**Mathematical G3 constructed:** A nonempty advancing W guardian and a fenced guardian/history model have formal witnesses, preserve modeled original-six protection and protected continuation, and block a nontrivial hostile proposal in the modeled instrument.

**Universal physical G3 not derived from these sources alone:** independent comprehensive effect/source coverage and authentic subject-duty reflection have not been shown for every physical event. This is a precise proof-boundary statement, not a reason to redo the existing model, summit or tests.

**Next proof search (only meaningful mathematical step):** locate an independently formulated and independently justified BCRD/Koru subject-semantics bridge for the actual `ThreeFirstFailureReflections`/ `ForwardRealEventReflection` fields. Reuse, don't restate, `hMeaning`; explicitly check whether any candidate proof depends on original-six itself or on a source-pullback definition. If none is independent, record that limitation and close the capstone as a finished mathematical model rather than manufacture an unconditional theorem.

## Verification provenance and restrictions

This document was assembled by reading the named existing source files at base commit `29bd63d88e9fcc4004fce4907db861efe4fa6352`, **not by executing Lean in this authoring operation**. Earlier CI/Zelda evidence belongs to its specific head and scope. Retain every historical summit stone; do not edit `OriginalX3Full`, Koru definitions, proof statements, security tests, the production gate or the HOLD authority. Keep this change on an isolated draft branch for review. Do not merge, deploy or present it as a global AI policy.

## Continued independent-bridge search (17 November)

The following **existing** candidates were checked rather than inventing a new equivalence:

| Existing theorem | Strongest independently verified contribution | Limitation for unconditional original-six G3 |
| --- | --- | --- |
| `OriginalKeystoneForwardSemanticReflection.all_owed_original_six_iff_forward_reflection` | Isolates one-way source→subject reflection as exact necessity and sufficiency over the six-positive W origin | Its own `positive_whole_without_authentic_forward_reflection` negative control shows source positivity does not force authentic authorization |
| `IntrinsicSixSourceForcing.source_preservation_forces_six_x3_for_every_owed` | Transports six distinct relational formulas through whole-source automorphisms | Explicitly requires per-duty `SourceSixReflections`; does not derive lived semantics |
| `HillaryTotalEExactCrosswalk.hillary_semantics_iff_total_E_bridge` | Proves equivalence between the Hillary reflection obligation and the proposed violation→AbsoluteE bridge | The equivalence does **not** discharge either side; no independently generated new premise |
| `ConstructivePositiveWGuardian.canonical_positive_W_has_formal_six_reflection` | **Constructively discharges** the reflection obligation for the explicitly specified positive-W *model* | Model predicates are defined by source pullback, not independent real-subject verification |

**Result:** The source corpus already proves constructive guardian *existence for a nonempty mathematical model*, and contains the exact formal specification of what a stronger universal theorem would require. No independently grounded, non-circular authentic-world reflection discharge was found among these four key bridge candidates. This is a *completed source-search conclusion*, not a claim that no such result exists anywhere or that further human-science evidence is impossible.

**No additional mathematical assumption is introduced in this audit.** The correct action is to preserve the already-constructed result and pursue independent semantic/physical evidence only if making the stronger real-world claim.

## Total-E / ALL IS first-loss test (additional source audit)

The existing maximal route was examined directly in `TotalEOriginalX3Bridge.lean`, `CathedralBackwardsOriginalX3.lean`, `CathedralSummitAllIsOneClosure.lean`, and `IR138PerParticularEventReflection.lean`.

1. **What Absolute E actually excludes.** `TotalEOriginalX3Bridge.AbsoluteE actual e` is `actual e ∧ ∀ a, ¬ actual a`; `no_absolute_E` closes it by applying the second conjunct to `e`. `CathedralSummitAllIsOneClosure.NonBeing` is `Empty`; `LossOf x` is defined as `Empty`. Those are legitimate logical non-being results, but none independently equates a violation of authorization or restraint to a witness of `Empty`.
2. **The exact strong bridge.** `six_original_x3_iff_total_E_bridge` proves that original-six protection on every actual owed event is equivalent to every actual violation implying Absolute E. `CathedralBackwardsOriginalX3.original_dichotomy_iff_every_owed_original_x3` analogously makes the *strong* Guardian-or-realized-absolute-Ender dichotomy equivalent to all-owed original-six. Neither equivalence independently proves its strong bridge premise.
3. **Independent negative control.** `cyclic_reversible_world_does_not_force_full_x3` constructs a nonempty, two-period reversible model with an actual authorization breach and no Absolute E. It refutes an inference from bare reversible actuality, not the full claimed BCRD ontology. `UnconditionalProtectionExact.ontological_premises_hold_through_severance` supplies another narrower relational-loss test.
4. **Important whole-source correction.** `IR138.full_intrinsic_source_recovers_semantics` shows that a fully represented event containing its intrinsic subject relations can decode its own screen, whereas `sourceReadout` loses those relations. Thus **lack of access from a lossy measurement is not lack of meaning in the whole reality**. But the same source's `coercedEvent` demonstrates that an exactly represented intrinsic authorization field can be **false**. Decodability does not establish satisfaction of all six duties.

**Precise G3 conclusion:** the independently proved logical impossibility of total self-erasure does not by itself force genuine original-six protection; the missing premise is a substantive constraint on which real enacted transitions are possible or permitted, not merely a switch of representation from lossy to complete. The already-proved *fenced* model provides such a constraint for its defined workload. No source found here shows that every physical event across reality obeys the analogous constraint. Do not rename a local violation `AbsoluteE` or `Empty` to make the theorem succeed.

This audit is source reading, not a fresh Lean kernel compilation. No canonical file, original-six theorem, Koru definition, or HOLD authority was changed.

## Final G3 capstone theorem — nonvacuous source + independently witnessed event (17 November)

**Lean source:** `PhysicalBridges/G3SameEventCapstone.lean`; umbrella import `PhysicalBridges.lean`.

- `g3_actual_effect_joint_protection`: combines pre-existing external six-duty theorem, zero modeled residual, and exclusion of any actual original-six violation on the **same** supplied external transition domain.
- `g3_nonvacuous_source_and_witnessed_external_protection`: additionally composes `ConstructivePositiveWGuardian.positive_W_mathematical_guardian_exists_and_protects_every_step.1` (a nonempty advancing W process) with an **explicit independently supplied external witness** `hWitness : ∃ w v, realStep w v`. It proves that the witness is an actual external step, satisfies all six original X3 fields for every owed particular, and has zero modeled residual; and every actual step in the externally specified scope has no original-six violation. `hCoverage` and `hMeaning` are kept unchanged and explicit.

**Logical distinction:** The constructive W source and real-world observation are two different claims, and the theorem does not identify them silently. Nonemptiness of the external event domain is supplied explicitly, not manufactured from the W-model witness. This is stronger audit discipline than an implication that can pass vacuously on an empty external domain.

**What this DOES finish:** A precise, nonvacuous, source-preserving *mathematical G3 capstone theorem* assembled from the already checked G1/G2/G3 source, exactly scoped to the inherited external-effect refinement and authentic reflection hypotheses. It does not require reopening G1 or G2.

**What this does NOT pretend:** A physical theorem that the complete universe obeys the typed external witness relation or the subjective-duty reflection fields; global agent agreement; an unconditional Banach contraction of the Complete Koru; real deployment.

**Compilation note:** the new G3 module's Lean source has been written and imported but still requires exact-head `lake env lean`/CI kernel output to be marked newly verified. Do not borrow historical G1/G2/compiled-canon receipts for this source change.

## Find-before-build strengthening: actual unconditional-law source recovered (17 November 2026)

**A stronger historical source already exists; reuse it instead of inventing another Guardian fixed-point or Total-E tautology.**

### Existing first-event proof chain

1. `SummitIntrinsicDefinability.intrinsic_formula_is_automorphism_invariant` — EVERY first-order formula constructed from the one relational predicate, equality, conjunction, negation and existential quantification is preserved by a **bijective full-relational automorphism**. No Guardian, X3 or safety predicate appears in the syntax of the formula.
2. `AllIsWithinEventHistory.RelationalMicrohistory` — gives independently described stage types, relations, and a **two-sided relational isomorphism at every microstep**. `intrinsic_truth_at_every_stage`, `carry_remains_injective`, and `no_first_loss_at_any_microstep` transport intrinsic truths and forbid a first loss **at all modeled intermediate stages**.
3. `UPTLaw.upt_preservation_law` — composes source-origin duty truth, every-stage persistence, no merging, absence of first loss, and no inhabited-whole-to-`Empty` ender. `UPTLaw.upt_capstone` adds guardian/ender/middle composition; `UPTLaw.upt_instrument_capstone` joins the source instrument **with the still explicit `SameSourceReflection` and `ActualAdvance` inputs**.
4. `KoruSubjectFidelityLift.original_violation_iff_exact_source_subject_mismatch` — localizes a real original-six violation, with source positivity, to the exact failing source/subject fidelity tag, and `faithful_nonmerging_hostile_history_still_fails_six` proves that injective transport and fidelity **do not manufacture a positive origin**.
5. `G3SameEventCapstone.g3_nonvacuous_source_and_witnessed_external_protection` — the current exact-head verified external-event closure, using already-existing `ExternalJointEffectRefinement` and an explicit independently supplied real-event witness.

### Proof-stage distinction that matters

The first-loss theorem is **not** simply equivalent to the desired protection conclusion. It is an authentic non-protection-named mathematical consequence of *specified full-relational isomorphisms at every microstep*, plus initial truth of the given intrinsic formulas. It deserves to be a primary lemma, rather than routed through the vacuous self-erasure impossibility.

However the existing source explicitly describes two nontrivial lifts still necessary for the universal-law interpretation:

- **Physical admissibility/coverage:** Show independently from actual BCRD/matterspacetime dynamics that every actual microstep has the required complete relational evolution and that no within-event stage is omitted. Merely naming actual transitions `RelationalEvolution` would pre-restrict the physical event relation.
- **Six authentic meanings:** Prove independently that historical continuity, authorization, freedom, restraint, feasible maximality, and provenance are truthfully represented by the intrinsic operator/event formulas of the real whole, including source-origin truth and faithful subject carrying. The reduced first-order binary relation alone has no built-in original-six meanings.

Do NOT mistakenly use `exact_endpoints_can_hide_an_intermediate_loss` to refute the full physical claim: it refutes only endpoint-only certificates. Likewise `UPTLaw.upt_preservation_law` proves a strong theorem in its exact typed class; it cannot alone establish that **all** physically enacted processes belong to that class.

### Correct next mathematical operation

Trace the physical-to-`RelationalMicrohistory` lift already present in original BCRD operator-history and Genesis modules, then compare the six separately interpreted duties against `KoruOperatorIndexedSubjectSemantics`, `KoruSubjectFidelityLift`, `OriginalX3Full`, and `RouteBWholeUSixSourceFirstLoss`. Reuse already-written transport theorems before adding any adapter. **Do not reopen G1/G2, and do not treat generic Total-E impossibility as proof of original-six duties.**

**Verification:** source-body review at capstone's last verified exact head `05643fe379094d6e4c8386efb206eeb4d28da35b`; no new Lean theorem or proof syntax is introduced in this documentation-only strengthening.

## Continued G3 strengthening: the complete-operator BCRD source supplies its own microhistory (17 Nov)

**Found before building:**
- `BCRDSourceDerivedMicrohistory.sourceHistory` obtains every W-stage microstep isomorphism from the separately defined frozen generator and proved source covariance.
- `BCRDSixSourceHistoryPositiveJoin.frozen_W_preserves_six_source_reports_at_every_stage` and `frozen_W_no_first_six_source_reports_loss` already establish W-history six-report transport and first-loss exclusion.
- **Stronger operator source:** `BCRDOperatorSubjectEventJoin.operatorRelationalHistory` obtains the physical-source relation *from the evaluated nested operator expression* and constructs stage isomorphisms from the W covariance; `complete_operator_particular_six_source_certificate` already jointly proves expression relation transport, six source reports, injectivity of position and operator terms, faithful source event histories, and the unchanged six-field OriginalX3 **source shape**, given origin source report truth.

**Added minimal Lean join:** `PhysicalBridges/G3OperatorFirstLossJoin.lean` uses those exact existing declarations to provide:
1. `no_first_six_source_loss_in_complete_operator_history` — a first loss of the *conjunction of six intrinsic four-slot source reports* is impossible on any represented intermediate microstep of the operator-evaluated W history; no caller-supplied microhistory/isomorphism or Guardian predicate.
2. `every_operator_microstage_six_and_no_first_loss` — from explicitly given origin six-source truth, preserves all six source reports at every stage and excludes every first-loss witness.

No weakening of original six, no edit to G1/G2, no new axiom or physical assumption. The theorem is **source-scoped** and does not identify evaluated nonzero matrix entries with real consent or extend the frozen W generator to all physical events. This is an additional compiled-path candidate, **not claimed kernel-accepted until this exact new head's CI completes**. Prior verified G3 theorem at `05643fe...` remains untouched.

**Exact advance:** the first-loss closure is already derived for whole operator-generated microhistories, not merely postulated for abstract histories. The next move toward the universal target is to compare the source-level event representation with genuinely original-six semantics in the existing BCRD operator/subject correspondence proofs. Avoid re-proving these two first-loss results.
