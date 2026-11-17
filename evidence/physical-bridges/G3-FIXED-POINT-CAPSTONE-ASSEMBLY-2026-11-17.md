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
