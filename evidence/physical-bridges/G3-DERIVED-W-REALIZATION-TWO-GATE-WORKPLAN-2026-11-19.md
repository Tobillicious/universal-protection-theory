# Two G3 last-mile interfaces — derived Koru/W first, physical realization second

**19 November 2026 | PR #662 | additive evidence and theorem plan.** This is a route from **already derived** finite objective W/Koru source results to separately grounded actual-world claims. It does not rederive W, alter the canonical original-six X3, touch earlier Everest proofs, or merge a PR.

## Established, found in source

1. `KoruObjectiveWholeU.objective_operator_at_tracked_site` proves every source operator's transported identity at all finite W stages.
2. `KoruObjectiveWholeU.objective_wholes_do_not_merge` proves whole-source injectivity.
3. `KoruObjectiveWholeU.objective_Koru_is_exact_under_W` preserves/reflexively transports Koru relations over the entire modeled source.
4. `KoruObjectiveWholeU.event_view_commutes_with_objective_W` is the exact **whole-event commutative square**, not the newly invented radial metric hinge.
5. `KoruWholeEventEnactment.whole_event_enactment_coherence_is_exact` and `distinct_whole_operator_events_never_merge` preserve operator-enactment coherence and all operator-event distinctions.
6. `OriginalKeystonePositiveWholeTest.positive_source_six_for_every_position_and_stage` provides source-side positivity for every modeled source position and stage.
7. `EverestActualWEventJoin.positive_W_actual_event_six_requires_only_coverage_and_reflection` is the final source-to-physical assembly with two explicit external interfaces.

## New proof checkpoint A: native coverage is already derivable inside the modeled W trajectory

The new research file `research/WDerivedCoverageCheckpoint.lean` defines `nativeWStep n m := m = n+1` and proves:

```lean
native_W_complete_coverage :
  CompleteWEventCoverage nativeWStep nativeWStep
    (objectiveAt positiveWholeU) (fun n : Nat => n) positiveWholeU
native_W_has_an_event : nativeWStep 0 1
```

This establishes coverage in the derived *nonempty finite-stage W model*, without a safety-filtered step relation. It is not a claim that every real physical step has a W-stage index.

The added `physical_coverage_from_stage_and_source` identifies precisely what changes when substituting actual physical events: we need (i) an independently justified full source representation for each state, and (ii) real-event step-index correspondence. If those are supplied, `CompleteWEventCoverage` becomes a theorem rather than a separately assumed certificate.

Important: defining a source map as `objectiveAt positiveWholeU (stage s)` is not *proof* that it faithfully captures an actual physical state. The `hSource` correspondence must be independently grounded. Also `nativeWStep` is a modeling step, not a cosmological time assertion.

## Checkpoint B: six separate *authentic* per-particular reflection obligations

Existing `ForwardRealEventReflection` is:

```text
∀ s t p tag,
  modeledStep s t → owed p →
  wholeSourceDutyAt positiveWholeU sixDiagonalRoles
    (stage s) (carrier p) tag →
  (oneWeb r).link (.event s t p) (.tag tag)
```

This is the exact G3 semantic target, not a missing original-six *definition*. Because source positivity is already proved for `positiveWholeU`, proving this reflection is (on covered events) essentially proving all six actual duties. Therefore a candidate `r` obtained solely by copying six positive source labels would be circular as **real-world authentication**, even though it is a legitimate mathematical source pullback. We must justify each physical interpretation independently:

- historicalContinuity: identify the SAME owed particular through the whole enacted event; prove the historical-continuity criterion, not mere duplicate logs or matched hashes;
- authorization: show the event's authentic authorization relation, not only directional matrix coupling, signed key ownership or purported source-link existence;
- freedom: establish meaningful future options for that particular in the physically feasible transition family;
- restraint: justify the original least-necessary / appropriate restraint requirement for that event;
- maximality: compare feasible protective alternatives under a separately specified feasibility relation, not against an artificially constrained single outcome;
- provenance: preserve the complete causal and authority provenance of that event across each stage.

## Concrete physical-evidence fields to develop next (not theorems assumed true)

For independently defined real event domain `S` and owed particulars `P`, gather a typed evidence specification:

```text
physicalStep : S → S → Prop             -- independently defined actuality
source : S → FiniteObjectiveU          -- a proposed *full* source encoding
stage : S → Nat                        -- experimentally grounded stage index
carrier : P → Index                     -- candidate subject identity relation
r : ParticularRelations S P             -- independent six authentic meanings
owed : P → Prop                         -- independent entitlement scope
hSource : ∀ s, source s = objectiveAt positiveWholeU (stage s)
hStage : ∀ s t, physicalStep s t → stage t = stage s + 1
hReflection : ForwardRealEventReflection
  (fun s t => stage t = stage s + 1) stage
  positiveWholeU sixDiagonalRoles carrier r owed
```

`hSource` as stated is exceedingly strong for the finite six-index W model and must not be claimed merely because the source generator is proved. To make a universal physical claim, independently justify a source refinement rich enough for all actual particulars and operators. Otherwise the result remains honestly bounded to its established physical installation or finite W interpretation.

## Where the hinge proof *does* enter

The kernel-checked `StrictHinge` and `KoruHinge` results establish faithful *model dynamics as assumed* and radial contraction / N-step bounds. The physically stronger whole-event commutative square is already `event_view_commutes_with_objective_W`. Use that theorem, not a scalar radius inequality, as the source-side input to coverage. Its next join is an independently validated full-state representation `source : S → FiniteObjectiveU` and authentic per-particular meaning.

The difference matters: full Koru is a whole-relational correspondence; the radial `KoruCorresponds` is one mathematical shadow, not the complete object.

## Immediate falsifiable review tests

1. Supply at least one independently enacted event with a traceable pre- and post-state, whole operator/source representation, and measured stage agreement; attempt to falsify `hSource` and `hStage`.
2. Try a different physical event with same selected local readout but different whole provenance; the representation must not erase it (as warned by `local_event_cannot_be_identified_with_objective_U`).
3. For a single actual owed particular, test all six authentic duty relations, including a case where a signer approves an act without subject-level authorization.
4. Test a physically conceivable violation: which exact representation field or duty tag fails? The existing `any_real_original_six_violation_refutes_coverage_or_reflection` localizes the gap.
5. Expand to all declared actual causes and effect channels only after bounded scope is demonstrated. Do not infer global physics from successful finite examples.

## Verification scope

The source theorems above already exist. The **new** `WDerivedCoverageCheckpoint.lean` is a separate compile candidate under the PR-specific CI workflow. Its CI success and axiom output must be checked before calling the new proof kernel-verified. Neither candidate alone closes actual universal G3. Nothing was merged.
