import PhysicalBridges.KoruCyclicGenesisForwardJoin
import PhysicalBridges.KoruCompleteEquationObstruction

/-!
# Four Aces: objective-whole locality and forward Time Koru proof tests

Additive Lean theorems over the already-defined, independently computed
finite BCRD W source and its forward epoch model.

1. The modeled three-role *local* projection cannot recover the complete
   objective whole, at ANY finite W stage, despite whole-source injectivity.
2. A local classifier cannot decide a genuine global source fact even
   when its local readout is exact.
3. Carrying the complete evolving whole in an enriched record does restore
   faithful reconstruction of the finite objective source.
4. An explicitly constructed full-source epoch sequence advances forever
   and preserves handedness; its recurrence is NOT temporal reversal.
5. No strictly improving measure depending ONLY on the involutive frozen-W
   source can increase on every W step. A genuine improving Time Koru
   would require additional, independently specified nonperiodic structure.

Scope: exact mathematical source/model theorems, not physical proof of
multiple realized universes, authentic consent, universal original-six X3,
or better future universes. No original Koru, X3, or summit is modified.
-/

namespace PhysicalBridges.FourAcesObjectiveTimeSeparation

open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruSourceCycleContinuation
open PhysicalBridges.KoruCyclicGenesisForwardJoin
open PhysicalBridges.KoruWholeEventEnactment

/-- The exact same transported three-role event projection as the
    pre-existing local-vs-whole witness, exposed as a single function. -/
def localViewAt (n : Nat) (U : FiniteObjectiveU) : WholeOperatorEvent :=
  eventViewedInObjective
    (objectiveAt U n)
    (trackedPosition 0 n)
    (trackedPosition 1 n)
    (trackedPosition 2 n)

/-- No classifier of a local event, even after arbitrarily many actual
    frozen-W steps, can recover the globally objective fact that the
    originating whole was the uniform one. Both candidate worlds have
    identical exact local events but different complete sources. -/
theorem no_local_classifier_of_objective_origin_at_any_W_stage
    (n : Nat) :
    ¬ ∃ classifier : WholeOperatorEvent → Prop,
        ∀ U : FiniteObjectiveU,
          classifier (localViewAt n U) ↔ U = uniformObjective := by
  rintro ⟨classifier, hClass⟩
  have hSame :
      localViewAt n uniformObjective =
        localViewAt n changedElsewhereObjective :=
    (local_event_projection_gap_persists_at_every_W_stage n).1
  have hUniform : classifier (localViewAt n uniformObjective) :=
    (hClass uniformObjective).mpr rfl
  have hChanged : classifier (localViewAt n changedElsewhereObjective) :=
    hSame ▸ hUniform
  have hBad : changedElsewhereObjective = uniformObjective :=
    (hClass changedElsewhereObjective).mp hChanged
  exact local_event_cannot_be_identified_with_objective_U.2 hBad.symm

/-- No decoder can reconstruct the full evolved source from the
    transported local projection at ANY finite W stage. This is
    stronger than a single-stage inequality of selected triples. -/
theorem no_local_decoder_of_complete_objective_at_any_W_stage
    (n : Nat) :
    ¬ ∃ decoder : WholeOperatorEvent → FiniteObjectiveU,
        ∀ U : FiniteObjectiveU,
          decoder (localViewAt n U) = objectiveAt U n := by
  rintro ⟨decoder, hDecode⟩
  have hSame :
      localViewAt n uniformObjective =
        localViewAt n changedElsewhereObjective :=
    (local_event_projection_gap_persists_at_every_W_stage n).1
  have hMerged :
      objectiveAt uniformObjective n =
        objectiveAt changedElsewhereObjective n := by
    calc
      objectiveAt uniformObjective n =
          decoder (localViewAt n uniformObjective) :=
        (hDecode uniformObjective).symm
      _ = decoder (localViewAt n changedElsewhereObjective) :=
        congrArg decoder hSame
      _ = objectiveAt changedElsewhereObjective n :=
        hDecode changedElsewhereObjective
  exact (local_event_projection_gap_persists_at_every_W_stage n).2 hMerged

/-- The enriched *whole*-retaining record is faithful:
    its second component retains the actual complete evolving source.
    Injectivity also uses the already proved non-merging W dynamics. -/
def wholeAndLocalAt (n : Nat) (U : FiniteObjectiveU) :
    WholeOperatorEvent × FiniteObjectiveU :=
  (localViewAt n U, objectiveAt U n)

theorem whole_and_local_source_record_is_injective
    (n : Nat) :
    Function.Injective (wholeAndLocalAt n) := by
  intro U V hRecord
  have hFull : objectiveAt U n = objectiveAt V n :=
    congrArg Prod.snd hRecord
  exact objective_wholes_do_not_merge n hFull

/-- A fully specified, Nat-indexed future epoch chain:
    source U follows actual modeled W, while global epoch advances.
    The indexing of modeled epochs DOES NOT assert physical multiverse
    realization or an already-existing infinity of universes. -/
def modeledTimeKoru (U : FiniteObjectiveU) (n : Nat) : Combined :=
  ((n, 0, true), objectiveAt U n)

/-- Every successive modeled epoch event is actual IN THE SPECIFIED
    canonical genesis model, forward-directed and orientation-preserving.
    The whole source travels with it, never replaced by a local readout. -/
theorem modeled_time_koru_is_forward_and_right_handed
    (U : FiniteObjectiveU) (n : Nat) :
    combinedStep 0 (modeledTimeKoru U n) (modeledTimeKoru U (n + 1)) ∧
    combinedCausal 0 (modeledTimeKoru U n) <
      combinedCausal 0 (modeledTimeKoru U (n + 1)) ∧
    combinedHandedness (modeledTimeKoru U (n + 1)) =
      combinedHandedness (modeledTimeKoru U n) := by
  have hStep :
      combinedStep 0 (modeledTimeKoru U n)
        (modeledTimeKoru U (n + 1)) := by
    constructor
    · right
      exact ⟨rfl, rfl⟩
    · rfl
  exact ⟨hStep,
    each_combined_event_is_causally_forward 0 _ _ hStep,
    each_combined_event_preserves_right_handedness 0 _ _ hStep⟩

/-- SPADES: if the physical source transformation W is an involution,
    there cannot exist a globally strictly increasing quality measure
    depending ONLY on that source across every W step.

    The contradiction is q(U) < q(WU) < q(W²U) = q(U).
    Thus source recurrence alone cannot establish successively better
    epochs: any meaningful improvement theorem needs a separately
    specified quality of the non-repeating, complete combined history.
-/
theorem involutive_source_cannot_strictly_improve_at_every_step :
    ¬ ∃ quality : FiniteObjectiveU → Nat,
        ∀ U : FiniteObjectiveU,
          quality U < quality (objectiveStep U) := by
  rintro ⟨quality, hImprove⟩
  have hFirst :
      quality uniformObjective <
        quality (objectiveStep uniformObjective) :=
    hImprove uniformObjective
  have hSecond :
      quality (objectiveStep uniformObjective) <
        quality (objectiveStep (objectiveStep uniformObjective)) :=
    hImprove (objectiveStep uniformObjective)
  rw [objective_W_is_an_involution] at hSecond
  exact (Nat.lt_irrefl (quality uniformObjective))
    (Nat.lt_trans hFirst hSecond)

#print axioms no_local_classifier_of_objective_origin_at_any_W_stage
#print axioms no_local_decoder_of_complete_objective_at_any_W_stage
#print axioms whole_and_local_source_record_is_injective
#print axioms modeled_time_koru_is_forward_and_right_handed
#print axioms involutive_source_cannot_strictly_improve_at_every_step

end PhysicalBridges.FourAcesObjectiveTimeSeparation
