import PhysicalBridges.EverestActualWEventJoin

/-!
# Chandrasekaran reduction: where the Guardian premise lives

28 November 2026. Additive. Two exact results about the bridge hypotheses
in the `positiveWholeU` instance used by `chandrasekaran_discharge`:

1. `coverage_of_clock`: a clock advancing by one on every physical step
   yields `CompleteWEventCoverage` exactly.
2. `reflection_positive_iff_X3`: `ForwardRealEventReflection` is EQUIVALENT
   to all six original X3 duties at every modeled step for every owed
   particular. The source side is true at every stage, so the reflection
   hypothesis carries the full X3 content.

Consequence: the open premise of G3 by modus ponens is exactly
"the physical dynamics carries all six duties at every event".
-/

namespace PhysicalBridges.ChandrasekaranReduction

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruWholeUSixDutyWebJoin
open PhysicalBridges.KoruSixOriginalRelationsOneWeb
open PhysicalBridges.OriginalKeystoneForwardSemanticReflection
open PhysicalBridges.OriginalKeystonePositiveWholeTest
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full
open PhysicalBridges.EverestActualWEventJoin

variable {S P : Type}

theorem coverage_of_clock (physicalStep : S → S → Prop) (clock : S → Nat)
    (hTick : ∀ s t, physicalStep s t → clock t = clock s + 1) :
    CompleteWEventCoverage physicalStep physicalStep
      (fun s => objectiveAt positiveWholeU (clock s)) clock positiveWholeU :=
  fun s t h => ⟨h, rfl, rfl, hTick s t h⟩

theorem positive_source_duty_always (n : Nat) (i : Index) (tag : DutyTag) :
    wholeSourceDutyAt positiveWholeU sixDiagonalRoles n i tag :=
  positive_origin_transports_every_six_source_field
    positiveWholeU sixDiagonalRoles (fun j : Index => j) (fun _ => True)
    (fun j _ => all_six_source_fields_true_at_origin j) n i trivial tag

theorem reflection_positive_iff_X3
    (modeledStep : S → S → Prop) (stage : S → Nat)
    (carrier : P → Index) (r : ParticularRelations S P) (owed : P → Prop) :
    ForwardRealEventReflection modeledStep stage positiveWholeU
        sixDiagonalRoles carrier r owed ↔
      ∀ s t p, modeledStep s t → owed p →
        OriginalX3 r.continues r.authorized r.free r.restrained
          r.maximal r.provenanced s t p := by
  constructor
  · intro h s t p hm ho
    exact (complete_profile_iff_original_x3 r s t p).mp
      (fun tag => h s t p tag hm ho
        (positive_source_duty_always (stage s) (carrier p) tag))
  · intro h s t p tag hm ho _
    exact (complete_profile_iff_original_x3 r s t p).mpr (h s t p hm ho) tag

/-- **THE CHANDRASEKARAN BICONDITIONAL.** With the model tracking every
physical step (supplied by a clock, `coverage_of_clock`), G3's duty-and-
eternity content is EXACTLY reflection plus nonterminal. Forward: the
bridge. Converse: G3 gives reflection (via `reflection_positive_iff_X3`)
and nonterminal (directly). Coverage itself is not forced by G3; it is
supplied independently by the clock. -/
theorem g3_iff_reflection_and_nonterminal
    (physicalStep : S → S → Prop) (clock : S → Nat)
    (carrier : P → Index) (r : ParticularRelations S P) (owed : P → Prop) :
    ((∀ s t, physicalStep s t → ∀ p, owed p →
        OriginalX3 r.continues r.authorized r.free r.restrained
          r.maximal r.provenanced s t p) ∧
      (∀ s, ∃ t, physicalStep s t)) ↔
    (ForwardRealEventReflection physicalStep clock positiveWholeU
        sixDiagonalRoles carrier r owed ∧
      (∀ s, ∃ t, physicalStep s t)) := by
  constructor
  · rintro ⟨hX3, hLive⟩
    exact ⟨(reflection_positive_iff_X3 physicalStep clock carrier r owed).mpr
      (fun s t p h ho => hX3 s t h p ho), hLive⟩
  · rintro ⟨hRefl, hLive⟩
    exact ⟨fun s t h p ho =>
      (reflection_positive_iff_X3 physicalStep clock carrier r owed).mp
        hRefl s t p h ho, hLive⟩

end PhysicalBridges.ChandrasekaranReduction

#print axioms PhysicalBridges.ChandrasekaranReduction.g3_iff_reflection_and_nonterminal

#print axioms PhysicalBridges.ChandrasekaranReduction.coverage_of_clock
#print axioms PhysicalBridges.ChandrasekaranReduction.reflection_positive_iff_X3
