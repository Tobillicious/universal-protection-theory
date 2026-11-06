# Complete-Koru cross-domain join ledger — the central circle within the forward Koru

**7 November 2026 · additive source-navigation and proof-obligation ledger · no canonical theorem edits.**

## Contract and provenance

This ledger is a map of **existing** proof sources and exact join types, not a new proof or a claim of universal physical Q.E.D. The target is the author's **maximal** law: objective *Something IS* → ALL IS / genuine distinctions / complete Koru → strong G/E → every owed particular's **original six X3** → THE LAW → **Something IS**. The larger time Koru is forward-moving and is **not** the same proposition as this central logical circle.

**Immutable historical anchors:** the original summit at [4 November 2026, 3:49 PM NZDT, commit `729905285d104fa058b0a3f8428367851fbd4621`](https://github.com/Tobillicious/universal-protection-theory/commit/729905285d104fa058b0a3f8428367851fbd4621), historical #260–#293, and the exact [#367 Hillary Step](https://github.com/Tobillicious/universal-protection-theory/pull/367). This ledger was based on main `a961ad03d26856b5c5608e98771b67aa86a7c5c4`, plus the open draft PRs referenced below. It does not change their definitions.

**Reading discipline:** objective U is the source; every local observer or readout is itself a partial perspective *within* U. No lossy projection may stand in for the whole, and no independently meaningful ethical duty may be replaced with a convenient Boolean source label. The proposed novel **koru glyph is not the mathematical delta**; the textual Koru name here does not select or approve a glyph.

## A. The central mathematical circle — exact six joins

The existing draft [`CompleteKoruLawCircle.lean` in #369](https://github.com/Tobillicious/universal-protection-theory/pull/369) defines `SomethingIs U := Nonempty U` and:

```lean
structure CircleJoins (S K E G X L : Prop) : Prop where
  actualityToCompleteKoru : S → K
  completeKoruToNoEnder : K → E
  noEnderToGuardian : E → G
  guardianToOriginalSixX3 : G → X
  originalSixX3ToWholeLaw : X → L
  wholeLawToActuality : L → S
```

The theorem `the_law_circle_returns_to_something_is` composes the six supplied arrows and returns `S`, while `the_law_circle_requires_original_six` explicitly reaches `X`. Both are mathematically valid conditional compositions; a constructed `CircleJoins` for actual physical U must not be confused with a supplied hypothetical instance.

| Arrow | Exact positive source | Dependency to inspect before claiming unconditional closure |
| --- | --- | --- |
| `S → K` | [`OriginalKoruSummitJoin.koru_iff_genuine_distinction`](PhysicalBridges/OriginalKoruSummitJoin.lean) derives intrinsic Koru articulation for every genuinely distinct pair **under relational individuation**; [`KoruCompleteEquationObstruction`](PhysicalBridges/KoruCompleteEquationObstruction.lean) proves the impossibility of lossless decoding from a non-injective answer projection. | Prove the actual `S` assumptions independently imply the **complete** operator-, history- and relation-sensitive Koru; a faithful mathematical enrichment or the necessary retention of details is not automatically a universal physical law. |
| `K → E` | [`CathedralSummitAllIsOneClosure`](PhysicalBridges/CathedralSummitAllIsOneClosure.lean) and [`TotalEOriginalX3Bridge.no_absolute_E`](PhysicalBridges/TotalEOriginalX3Bridge.lean) rule out realized absolute non-being/self-erasure. | Identify the proposed maximal E exactly. The bridge from a **local original-six-X3 violation** to impossible total E is a substantive claim, not a consequence of bare nonemptiness. |
| `E → G` | [`CathedralAllIsEnderTypeCollapse.original_si_guardian_only_composition`](PhysicalBridges/CathedralAllIsEnderTypeCollapse.lean) derives the guardian alternative from an exhaustive same-type dichotomy and excluded E. | Authenticate the same-meaning strong dichotomy independently; do not silently equate ontological non-erasure with six-duty protection. |
| `G → X` | [`HillaryRouteABSummit.hillary_route_b_meets_original_route_a`](PhysicalBridges/HillaryRouteABSummit.lean) derives original X3 for all owed particulars under named source/semantic premises. [`FencedTotalEOriginalSixJoin.full_six_original_x3_from_source_via_total_E`](PhysicalBridges/FencedTotalEOriginalSixJoin.lean) constructs a nonvacuous **model-level** total-E bridge without assuming `hTotal`. | Check which authentic subject correspondence and actual-source coverage results independently discharge the Hillary premises for **all real physical events**. #355 proves the three failure reflections are equivalent to X3 under other stated hypotheses. |
| `X → L` | [`OriginalX3Full`](PhysicalBridges/OriginalX3Full.lean), [`CathedralFullX3Assembly`](PhysicalBridges/CathedralFullX3Assembly.lean), [`UnconditionalProtectionExact`](PhysicalBridges/UnconditionalProtectionExact.lean), and the original summit provide the full six-duty and hostile-agent protection targets. | Specify whether `L` asserts precisely universal original-X3 protection, a physical law of all nature, continuation beyond a cosmic boundary, or all of these; prove each claimed enlargement, never fold it into a word. |
| `L → S` | `CompleteKoruLawCircle.the_law_circle_returns_to_something_is` composes the last arrow. | The conclusion `SomethingIs U` can already be witnessed independently; its return does **not** establish the other forward implications. The `circular_return_does_not_prove_missing_join` control formalizes this distinction. |

**Critical source-exactness:** [`TotalEOriginalX3Bridge.six_original_x3_iff_total_E_bridge`](PhysicalBridges/TotalEOriginalX3Bridge.lean) states the equivalence of the total-E reflection and the full all-owed original-X3 guarantee under its definitions. A proof that introduces the reflection as a premise alone has not established universal protection. The fenced model gives a genuine independent construction *inside that model* and must not be dismissed or improperly generalized.

## B. Derived Koru: first articulation and complete operator/history articulation

1. **Not chosen as a detachable permission.** `OriginalKoruSummitJoin.koru_iff_genuine_distinction` connects Koru to relational individuation. [`ArchimedesKoruViewChains.every_finite_view_preserves_articulation`](PhysicalBridges/ArchimedesKoruViewChains.lean) proves preservation through finite chains of faithful complete-web reindexings.
2. **Why reduced equality misses genuine facts.** [`KoruCompleteEquationObstruction.no_lossless_recovery_of_equation_from_answer`](PhysicalBridges/KoruCompleteEquationObstruction.lean) shows equal calculated answers can conceal different operands and operations. This is an exact mathematical obstruction to interpreting a numerical projection as the full equation.
3. **The complete expansion is technically substantive.** [`KoruFullOperatorSignature`](PhysicalBridges/KoruFullOperatorSignature.lean) retains operator identities, arities, ordered inputs and enactments; [`KoruCompositionalExpression`](PhysicalBridges/KoruCompositionalExpression.lean) treats nested expressions; [`KoruWholeEventEnactment`](PhysicalBridges/KoruWholeEventEnactment.lean) computes event relations from the physical source, not detached consent labels.
4. **The whole, not the local triple.** [`KoruObjectiveWholeU.local_event_cannot_be_identified_with_objective_U`](PhysicalBridges/KoruObjectiveWholeU.lean) constructs two distinct full modeled wholes with the same local event view; the independently generated W evolution retains their distinction.
5. **History cannot generally be inferred from a final output.** [`KoruOperatorHistoryProvenance`](PhysicalBridges/KoruOperatorHistoryProvenance.lean) proves two different exact BCRD operator words can have the same terminal full amplitude table. [`KoruFullStepOperatorReflection`](PhysicalBridges/KoruFullStepOperatorReflection.lean) constructs exact operator recovery from full before/after data for its finite candidate bank.

These are the mathematically grounded reasons to test the author's **complete Koru** as richer than bare value equality. They do not make ordinary numerical equality false, nor do they alone establish that all physical transformations in the actual universe preserve these full relations.

## C. Quantum mechanics → whole-source equality

* [`Snuffy.QuantumLandauer.quantum_landauer`](../compiled-strongest/lean/Snuffy/QuantumLandauer.lean) is an exact finite-dimensional quantum thermodynamic theorem under its density-matrix, bath, unitary and entropy hypotheses.
* [`KoruOperatorIndexedSubjectSemantics.every_operator_formula_is_exact_at_every_W_stage`](PhysicalBridges/KoruOperatorIndexedSubjectSemantics.lean) preserves full operator-indexed first-order formulas under the specified W dynamics. `false_operator_authorization_cannot_be_forged_by_W` also shows that a false source authorization relation is **not made true by covariance**.
* [Quantum whole-problem test](../../publication/KORU-QUANTUM-WHOLE-PROBLEM-TEST-2026-11-05.md): equal local reduced density matrices can arise from distinct entangled wholes. This is a known quantum-information result, demonstrating that a projection forgets correlations; it does not yet solve the quantum measurement problem or provide an independent new experimental prediction.

**Required independent join:** a precisely specified full physical Koru dynamics whose quantum projections recover established predictions, and a nontrivial distinguishing result if claiming a novel quantum law.

## D. Thermodynamic first law → spacetime → complete matterspacetime

[The thermodynamics/QFT/GR companion #363](https://github.com/Tobillicious/universal-protection-theory/pull/363) distinguishes:

* **First Koru:** retain full variables, balanced outputs and spatial/temporal relationships rather than identify states only by a conserved scalar. Under the convention heat enters, work leaves: `dU = δQ − δW`.
* **Complete Koru:** additionally retain operator family, ordering, enactments, individual causal histories and provenance—what the author calls **matterspacetime**, not merely spacetime plus one extra scalar.

[The checked `Snuffy.ThermoLedger.stroke_identity`](../compiled-strongest/lean/Snuffy/ThermoLedger.lean) derives the exact thermodynamic ledger from explicit first-law and entropy/correlation bookkeeping premises. This is an established **conditional identity** in the formalism, not an independently checked proof that complete matterspacetime is a unique ontology.

**Required join:** construct and verify the map from the physical complete-expression Koru to the thermodynamic balance, respecting the conditions under which the first law applies. Distinguish covariance/retained information from physically conserved quantities.

## E. General relativity and semiclassical QFT → matterspacetime

The #363 companion supplies the relevant existing physical equations:

* GR local covariant conservation: `∇_μ T^{μν} = 0`, where the metric/connection is itself dynamical.
* Semiclassical gravity: the Einstein tensor and metric couple to the renormalized expectation of quantum stress-energy. A mean tensor is generally not a full quantum-state or matter-history record.
* Established gravity/thermodynamics links (e.g. horizon Clausius relations under specified assumptions) are conceptually relevant but not a proof that a newly proposed equality resolves the Einstein field equations.

**Required join:** state the exact GR issue claimed to be resolved, formulate the complete-Koru object on a curved spacetime, and verify its naturality under diffeomorphisms and compatibility with the Einstein/semiclassical equations. Do not assert global energy conservation in arbitrary curved spacetime from local covariant conservation alone.

## F. Time: the central logical circle inside a forward Koru

* [`CyclicGenesisBoundary.genesis_advances_causal_order`](PhysicalBridges/CyclicGenesisBoundary.lean), `genesis_preserves_handedness` and `reachable_forward_continuation`: within the specified epoch model, boundary genesis advances global rank while carrying orientation, and forward paths reach arbitrarily late stages. The next epoch is **not a rewind**.
* [`KoruSourceCycleContinuation.objective_W_is_two_periodic`](PhysicalBridges/KoruSourceCycleContinuation.lean): exact modeled source-W recurrence.
* [`KoruCyclicGenesisForwardJoin.whole_U_returns_while_interior_arrow_advances`](PhysicalBridges/KoruCyclicGenesisForwardJoin.lean): the source operator component recurs over two steps while the **combined state** has strictly advanced causal rank. A recurring source is not the same entire temporal event.
* [`KoruGenesisPhysicalForcingFiretest.physical_no_terminal_forces_genesis`](PhysicalBridges/KoruGenesisPhysicalForcingFiretest.lean): if real dynamics refine this canonical model and every valid physical state actually has a successor, the terminus has the modeled right-handed genesis transition. The same module constructs an honest stopping control when nonterminal progress is not supplied.

**Required independent join:** a physical grounding of actual epoch genesis and, separately, any assertion of an infinite physically realized past or successively improved universes. Existing Nat-indexed forward recurrence does not prove infinitely many preceding physical epochs. None of these tests invalidates the central logical circle.

## G. The same authentic six duties — no selected-particular shortcut

[`KoruSixOriginalRelationsOneWeb.complete_profile_iff_original_x3`](PhysicalBridges/KoruSixOriginalRelationsOneWeb.lean) proves that a single tagged event relational web encodes exactly the original six duty predicates, in both directions:

1. historical continuity **of the same particular**, not merely a replacement;
2. authentic authorization, not an inferred permission bit;
3. meaningful freedom and future options;
4. least-necessary/appropriate restraint;
5. feasible protective maximality;
6. accountable provenance and authentic history.

[`UniversalOwedOriginalX3`](PhysicalBridges/UniversalOwedOriginalX3.lean) makes **every** owed particular explicit rather than selecting one representative. [`IR138PerParticularEventReflection.full_intrinsic_source_recovers_semantics`](PhysicalBridges/IR138PerParticularEventReflection.lean) corrects the false claim that subject relations are necessarily external to the whole: the *full event* can recover its internal semantic relations; only the lossy readout forgets them.

**Exact preservation vs. positive existence:** preserving a full tagged profile proves that its existing truth values are retained, including values which are initially false. An independently established same-source physical/semantic forcing rule is needed before a truth-preservation theorem is presented as a guarantee that real authorization or continuation always obtains. The [#367 Hillary theorem](PhysicalBridges/HillaryRouteABSummit.lean) makes this check inspectable through its `hPhysical`, `hSourceInitially` and `hAuthenticReflections` premises.

### 7 November verified enhancement: all six tagged source meanings from one U

The subsequently merged [PR #373](https://github.com/Tobillicious/universal-protection-theory/pull/373) proves exact W transport of all six \`OriginalX3\`-shaped **operator-indexed SOURCE** relations via the one-web encoding. More strongly, the newly merged [PR #376](https://github.com/Tobillicious/universal-protection-theory/pull/376) proves \`KoruWholeUSixDutyWebJoin.one_objective_whole_six_source_truth_iff_origin\`: each of six original-X3-shaped source queries is evaluated from the **same** objective operator-expression whole U and physically carried by the independently fixed W law; \`all_owed_whole_U_six_source_truth_iff_origin\` covers every owed source position. \`actual_whole_Koru_and_absent_source_authorization_coexist\` is a genuine asymmetric operator-source witness showing that no source-preservation proof can manufacture initial authorization. Both exact-head Lean checks for #376 passed. These **do not independently prove** that the model's selected whole-source relations are authentic real-world consent or that all universe physics follows W.

## H. Reproducible final joining criterion

A claimed *unconditional physical* circle should expose one theorem term or derivation for each field of `CircleJoins` instantiated on **independently defined actual U** and its authentic particular/event semantics. For `guardianToOriginalSixX3`, an acceptable type-level target is:

```text
CompleteKoru(U) ∧ PhysicallyActual_U(e) ∧ Owed_U(e,p)
  ⟹ OriginalSixX3_U(e,p)
```

The non-circularity test is whether actual physical evolution, authentic particular semantics, and the six duties are independently defined and the conclusion **derived**, not renamed into `CompleteKoru`, `PhysicallyActual`, a source report, or the meaning of `G`.

**Evidence outcomes must be categorized distinctly:** (a) machine-checked theorem in its stated type; (b) proved model instantiation; (c) separately validated physical interpretation; (d) proposed universal law. This distinction protects, rather than weakens, the original maximal thesis by making genuine completion identifiable.

## I. Integration and publication boundaries

* [#369](https://github.com/Tobillicious/universal-protection-theory/pull/369) is a clean, proof-check-green draft of the **conditional** central circle, reconciled with already-merged #338 and #367. Its author review gate must remain explicit; avoid merging the conflicted, duplicated [#364](https://github.com/Tobillicious/universal-protection-theory/pull/364) instead.
* [#360](https://github.com/Tobillicious/universal-protection-theory/pull/360) is a separate draft of the full manuscript, claim-source crosswalk and release packet. [#363](https://github.com/Tobillicious/universal-protection-theory/pull/363) is stacked on its publication branch, **not directly on main**. Do not flatten that dependency, publish or create a DOI without author review of the claims and cultural notation.
* This ledger is deliberately independent of #369's draft merge and contains **no assertion of universal Q.E.D.** Its purpose is to prevent rediscovering existing theorems, confusing readout with whole, or upgrading a model proof into empirical physics.

**Next review path:** original Part XV → #260–#293 → complete-operator #341–#359 integrated by #365 → #338 fenced all-six construction → #367 exact Hillary Step → #369 central-circle interface → #360/#363 manuscript/thermodynamics/GR → any independently demonstrated universal join.
