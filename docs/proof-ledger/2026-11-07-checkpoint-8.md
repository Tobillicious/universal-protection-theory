
## Checkpoint 8 — P57: protected origin and joint continuation

P01–P56 and O01–O08 retained. P15–P17 are reused for the fenced construction.
Pinned commit: `037b74f3785d65d4c495a92ced958683a079bfc4`.

### P57 — full_guardian_origin_from_source
[FullGuardianOrigin.lean](https://github.com/Tobillicious/universal-protection-theory/blob/037b74f3785d65d4c495a92ced958683a079bfc4/evidence/physical-bridges/PhysicalBridges/FullGuardianOrigin.lean)
Blob: `1dd27a158dab7a3aaec2e64ff703bd5c991cc3d3`.

Signature:
```lean
theorem full_guardian_origin_from_source (m : MeasuredInstrument S)
    (r : ParticularRelations S P) (hMeaning : SameSourceReflection m r)
    (advance : ActualAdvance m) (s : S) : FullGuardianState m r s
```

FullGuardianState has two distinct fields:
- everyEvent: each edge from every state reachable from s satisfies FullEvent r for every represented particular.
- continuation: each reachable state has one actual successor whose same edge satisfies FullEvent r for the entire represented population.

Proof body checked: everyEvent directly applies every_real_step_full_original_x3 with hMeaning to the given edge. continuation chooses advance.next a, supplies advance.realizes a, and applies the same full-event theorem. The proof does not assume a separately protected origin. It retains source reflection and actual progress as inputs.

The carry lemma was checked: prepend_real_step inducts over the suffix Reach proof, prepending the original edge. Both FullGuardianState fields then reuse their original quantified history statements. protected_origin_has_full_next uses Reach.refl; no_terminal_guardian_state contradicts that witnessed next edge. A dead-end state therefore cannot satisfy this definition through vacuous absence of outgoing events.

Verdict: Q.E.D. at the stated type by source review, reusing the full-event dependency already recorded with P15/P16. No independent Lean build or axiom replay was performed.

### Constructed application, reusing P15–P17
[FencedOptimiserInstrument.lean](https://github.com/Tobillicious/universal-protection-theory/blob/037b74f3785d65d4c495a92ced958683a079bfc4/evidence/physical-bridges/PhysicalBridges/FencedOptimiserInstrument.lean), blob `6dbdebd223f426c89d0cb844440a7d3d3f0ac647`.
[FencedTotalEOriginalSixJoin.lean](https://github.com/Tobillicious/universal-protection-theory/blob/037b74f3785d65d4c495a92ced958683a079bfc4/evidence/physical-bridges/PhysicalBridges/FencedTotalEOriginalSixJoin.lean), blob `8f30c6c34615d211d3815559436b86b82de416d5`.

The six guard proofs and fenced_same_source_reflection were read. Harmful coordinates retain their old level; other coordinates receive the proposal. Continuation follows because a proposed zero for a living coordinate triggers the guard. Any actual loss must have passed the guard and therefore has consent=true. Consent is copied unchanged. Restraint, maximality and provenance follow from the same Harmful branch test and its logged Boolean. These are independently specified model predicates, not six always-true definitions.

fencedAdvance chooses the guarded idle proposal and proves it is an instrument.step. Thus P57 applies with constructed reflection and advance in this World n model. The same subject quantifier ranges over all Fin n; no selected-subject restriction is introduced.

The Total-E join first obtains all-six truth from the source guard. Its implication from an alleged violation to AbsoluteE uses False.elim on that already-proved all-six truth. This is a valid model-relative composition, not an independent new derivation of six duties from bare non-erasure.

### Application boundary and next handoff
For this constructed instrument, the reflection/progress interfaces are discharged. O04/O05 are not globally discharged for actual physical subjects: complete mediation, calibrated physical channels, and authentic meanings of life, consent and freedom must match the target domain. Existing proofs are retained at full strength; the remaining application question does not invalidate the model theorem.

P57 uses SameSourceReflection over arbitrary instrument states. P56 uses ThreeFirstFailureReflections over Combined W-source states. They are different interfaces. A bridge must explicitly match states, physical edges, roles and six predicates before these results can be composed. Next search for existing refinement/interpretation certificates providing that match.
