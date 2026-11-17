import PhysicalBridges.FourAcesGenesisNoEJoin
import PhysicalBridges.KoruWActionFixedSymmetry

/-!
# Living Tree: canonical-W rigidity and full-parent provenance

The frozen canonical-W source coverage contract forces every realized
learned-Tree step to be exactly objectiveStep of the current source.
Because objectiveStep is involutive, the source then repeats after two
generations, regardless of what the theory revision proposes.

This is a useful *negative* theorem about using an old W-only physical
coverage certificate for a genuinely learning-driven next-U source.

The *positive* result separately proves that the complete LivingTree
cultivation map is injective, because the child retains the entire
immediate parent theory/source/history and the older ancestors. Thus
the whole learning record does not have to repeat even when the
projected frozen source does. No new physical law, X3 relation,
Koru definition, or evidence of actual cosmological Genesis is asserted.
-/

namespace PhysicalBridges.LivingTreeCoverageProvenance

open PhysicalBridges.LivingTreeGenerations
open PhysicalBridges.KoruJokerUniverseTrialFeedback
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruWActionFixedSymmetry
open PhysicalBridges.EverestActualWEventJoin
open PhysicalBridges.OriginalKeystonePositiveWholeTest

variable {T H E : Type}

/-- All learned steps are genuinely enacted in a separately given
physical relation. This is not supplied by a source definition. -/
def RealizesAllLearnedBoundaries
    (J : JokerExperiment T FiniteObjectiveU H)
    (initial : LivingTree T H E)
    (physicalStep : LivingTree T H E → LivingTree T H E → Prop) :
    Prop :=
  ∀ n, physicalStep (grow J initial n)
    (cultivate J (grow J initial n))

/-- The old canonical W coverage condition, if it applies to ALL
realized learned steps, *forces* the complete modeled source to take
precisely one W step per epoch. -/
theorem canonical_coverage_forces_each_learning_source_to_W
    (J : JokerExperiment T FiniteObjectiveU H)
    (initial : LivingTree T H E)
    (physicalStep modeledStep :
      LivingTree T H E → LivingTree T H E → Prop)
    (hRealizes : RealizesAllLearnedBoundaries J initial physicalStep)
    (hCoverage : CompleteWEventCoverage physicalStep modeledStep
      (fun s => s.whole) (fun s => s.epoch) positiveWholeU) :
    ∀ n, (grow J initial (n + 1)).whole =
      objectiveStep (grow J initial n).whole := by
  intro n
  let s := grow J initial n
  have hStep : physicalStep s (cultivate J s) := hRealizes n
  obtain ⟨_, hBefore, hAfter, hStage⟩ :=
    hCoverage s (cultivate J s) hStep
  change s.whole = objectiveAt positiveWholeU s.epoch at hBefore
  change (cultivate J s).whole =
    objectiveAt positiveWholeU (cultivate J s).epoch at hAfter
  change (cultivate J s).epoch = s.epoch + 1 at hStage
  have hW : (cultivate J s).whole = objectiveStep s.whole := by
    calc
      (cultivate J s).whole =
          objectiveAt positiveWholeU (cultivate J s).epoch := hAfter
      _ = objectiveStep (objectiveAt positiveWholeU s.epoch) := by
        rw [hStage]
        rfl
      _ = objectiveStep s.whole := by rw [hBefore]
  simpa only [grow] using hW

/-- The frozen W-source has a two-step orbit; any truly new
history-dependent source change needs a stronger physical boundary
coverage law. The growing *history record* is not asserted periodic. -/
theorem old_W_coverage_forces_two_epoch_source_recurrence
    (J : JokerExperiment T FiniteObjectiveU H)
    (initial : LivingTree T H E)
    (physicalStep modeledStep :
      LivingTree T H E → LivingTree T H E → Prop)
    (hRealizes : RealizesAllLearnedBoundaries J initial physicalStep)
    (hCoverage : CompleteWEventCoverage physicalStep modeledStep
      (fun s => s.whole) (fun s => s.epoch) positiveWholeU) :
    ∀ n, (grow J initial ((n + 1) + 1)).whole =
      (grow J initial n).whole := by
  intro n
  have h1 := canonical_coverage_forces_each_learning_source_to_W
    J initial physicalStep modeledStep hRealizes hCoverage n
  have h2 := canonical_coverage_forces_each_learning_source_to_W
    J initial physicalStep modeledStep hRealizes hCoverage (n + 1)
  calc
    (grow J initial ((n + 1) + 1)).whole =
      objectiveStep (grow J initial (n + 1)).whole := h2
    _ = objectiveStep (objectiveStep (grow J initial n).whole) := by
      rw [h1]
    _ = (grow J initial n).whole :=
      objective_W_is_an_involution _

/-- The complete *learning Tree*, unlike the projected finite W
source, remembers its entire parent. Equal children require equal
parents even if J.enact collapses distinct theories to one source. -/
theorem cultivate_preserves_full_parent_identity
    (J : JokerExperiment T FiniteObjectiveU H) :
    Function.Injective (cultivate J : LivingTree T H E → LivingTree T H E) := by
  intro s t h
  have hRecord := congrArg
    (fun x : LivingTree T H E => x.ancestors) h
  change
    (s.theory, s.whole, J.completedHistory s.whole) :: s.ancestors =
    (t.theory, t.whole, J.completedHistory t.whole) :: t.ancestors
      at hRecord
  have hHead :
      (s.theory, s.whole, J.completedHistory s.whole) =
        (t.theory, t.whole, J.completedHistory t.whole) := by
    injection hRecord with hh _
  have hTail : s.ancestors = t.ancestors := by
    injection hRecord with _ ht
  have hTheory : s.theory = t.theory :=
    congrArg (fun a : T × FiniteObjectiveU × H => a.1) hHead
  have hWhole : s.whole = t.whole :=
    congrArg (fun a : T × FiniteObjectiveU × H => a.2.1) hHead
  have hEpoch := congrArg
    (fun x : LivingTree T H E => x.epoch) h
  change s.epoch + 1 = t.epoch + 1 at hEpoch
  have hEpoch' : s.epoch = t.epoch := Nat.add_right_cancel hEpoch
  have hEthics := congrArg
    (fun x : LivingTree T H E => x.ethics) h
  change s.ethics = t.ethics at hEthics
  have hHand := congrArg
    (fun x : LivingTree T H E => x.rightHanded) h
  change s.rightHanded = t.rightHanded at hHand
  cases s with
  | mk e th w anc eth hand =>
    cases t with
    | mk e' th' w' anc' eth' hand' =>
      cases hEpoch'
      cases hTheory
      cases hWhole
      cases hTail
      cases hEthics
      cases hHand
      rfl

#print axioms canonical_coverage_forces_each_learning_source_to_W
#print axioms old_W_coverage_forces_two_epoch_source_recurrence
#print axioms cultivate_preserves_full_parent_identity

end PhysicalBridges.LivingTreeCoverageProvenance
