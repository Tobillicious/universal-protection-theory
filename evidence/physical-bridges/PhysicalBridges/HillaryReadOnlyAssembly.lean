import PhysicalBridges.HillaryRouteABSummit
import PhysicalBridges.FencedTotalEOriginalSixJoin
import PhysicalBridges.OriginalKeystonePositiveWholeTest
import PhysicalBridges.EverestActualWEventJoin

/-!
# UPT Hillary assembly — existing proof banks only

7 November 2026. DRAFT GITHUB REVIEW CANDIDATE; no merge or publication.

Purpose: make three existing proof routes simultaneously visible without
inventing new mathematics or silently identifying different physical models.
This file is a COMPOSITION of existing declarations only; it introduces
no new axioms, semantic predicates, physical postulates, or altered X3 duties.

Theorem A: original Hillary conclusion with EVERY hypothesis shown.
Theorem B: all six original X3 duties fully discharged in the independently
           constructed fenced-optimiser model.
Theorem C: the same finite-W source carries the genuine Koru AND, under
           independently stated actual-event coverage + authentic forward
           reflection, every original six-X3 duty for the same event.

Important: B and C concern different models. There is no implicit model
identification or claim that C's hypotheses hold in the actual universe.
This file has not been compiled locally (Lean/Lake unavailable in the
working container); it MUST pass pinned Lean CI before merging anywhere.
-/

namespace PhysicalBridges.HillaryReadOnlyAssembly

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.Koru
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruGenesisPhysicalForcingFiretest
open PhysicalBridges.IntrinsicSixSourceForcing
open PhysicalBridges.RouteBOriginalSixFirstViolation
open PhysicalBridges.RouteBWholeUSixSourceFirstLoss
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full
open PhysicalBridges.HillaryRouteABSummit
open PhysicalBridges.FencedOptimiserInstrument
open PhysicalBridges.FencedTotalEOriginalSixJoin
open PhysicalBridges.KoruWholeUSixDutyWebJoin
open PhysicalBridges.OriginalKeystonePositiveWholeTest
open PhysicalBridges.EverestActualWEventJoin

/-! ## A. EXACT HILLARY: the original universal-looking conditional theorem.
    No hypothesized source-to-subject correspondence is hidden. -/

theorem hillary_exact_join_with_hypotheses
    {P : Type} (M : Nat) (physical : SourceRelation)
    (owed : ActualState → ActualState → P → Prop)
    (r : ParticularRelations ActualState P)
    (d : SixRelationalDuties) (roles : P → Fin 4 → Index)
    (hPhysical : RespectsCanonicalSource M physical)
    (hSourceInitially : ∀ s t p, physical s t → owed s t p →
      SourceSixAt s.2 d (roles p))
    (hAuthenticReflections :
      ThreeFirstFailureReflections physical owed r d roles) :
    (∀ s t p, physical s t → owed s t p → OriginalSixAt r s t p) ∧
    ¬ FirstOriginalViolation physical owed r ∧
    ¬ FirstSixSourceLoss physical d := by
  exact hillary_route_b_meets_original_route_a
    M physical owed r d roles
    hPhysical hSourceInitially hAuthenticReflections

/-! ## B. FULLY DISCHARGED in one explicit finite fenced-optimiser world.
    The fence, not an assumed X3 safety definition, gives all six fields.
    This is not a statement that the real universe has this fence. -/

theorem fenced_model_all_six_original_duties
    (n : Nat) :
    ∀ s t : World n, ∀ p : Fin n,
      (instrument n).step s t → modelOwed s t p →
      OriginalX3
        (relations n).continues (relations n).authorized
        (relations n).free (relations n).restrained
        (relations n).maximal (relations n).provenanced s t p := by
  exact full_six_original_x3_from_source_via_total_E n

/-! ## C. FULL OBJECTIVE SOURCE KORU + SIX SUBJECT DUTIES ON ONE W EVENT.
    Positive source origin is already derived for positiveWholeU.
    Actual event coverage and authentic forward reflection remain NAMED.
    They are not inferred from the existence of the Koru alone. -/

theorem positive_W_koru_and_original_six_for_one_actual_event
    {S P : Type}
    (physicalStep modeledStep : S → S → Prop)
    (source : S → FiniteObjectiveU)
    (stage : S → Nat)
    (carrier : P → Index)
    (r : ParticularRelations S P)
    (owed : P → Prop)
    (hCoverage : CompleteWEventCoverage
      physicalStep modeledStep source stage positiveWholeU)
    (hReflection : ForwardRealEventReflection
      modeledStep stage positiveWholeU sixDiagonalRoles carrier r owed)
    (s t : S) (hPhysical : physicalStep s t)
    (p : P) (hOwed : owed p) :
    koru (sourceWholeWeb (objectiveAt positiveWholeU (stage s)))
      (trackedPosition 2 (stage s)) (trackedPosition 3 (stage s)) ∧
    (source t = objectiveStep (source s) ∧
      OriginalX3 r.continues r.authorized r.free r.restrained
        r.maximal r.provenanced s t p) := by
  exact ⟨(positive_whole_Koru_and_all_six_source_duties (stage s)).1,
    positive_W_actual_event_six_requires_only_coverage_and_reflection
      physicalStep modeledStep source stage carrier r owed
      hCoverage hReflection s t hPhysical p hOwed⟩

#print axioms hillary_exact_join_with_hypotheses
#print axioms fenced_model_all_six_original_duties
#print axioms positive_W_koru_and_original_six_for_one_actual_event

end PhysicalBridges.HillaryReadOnlyAssembly