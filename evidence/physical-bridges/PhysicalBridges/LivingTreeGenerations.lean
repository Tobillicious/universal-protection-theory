import PhysicalBridges.JokerTimeKoruGenesisJoin

/-!
# Living Tree — repeated learning through modeled forward generations

The Joker's measured completed history revises the theory for *each*
successor, not only at the first Genesis. The existing whole-source
objectiveStep acts on the next enacted theory, and the entire parent
record is retained in an accumulating list.

This is a separate history-informed CANDIDATE boundary rule: it is NOT
the old involutive `KoruEternalKnowledgeSeed.genesis` relation, nor
evidence that the physical universe implements the learning selector.
The source is the existing finite W bank. Ethical claim values remain
records, not automatically authenticated duties. Original six-X3 and
Koru definitions are unchanged.
-/

namespace PhysicalBridges.LivingTreeGenerations

open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruJokerUniverseTrialFeedback
open PhysicalBridges.KoruEternalKnowledgeSeed

variable {T H E : Type}

/-- A growing complete candidate Theory-and-History record.
No single particular or moral predicate stands for the whole world. -/
abbrev AncestralRecord (T H : Type) :=
  T × FiniteObjectiveU × H

structure LivingTree (T H E : Type) where
  epoch : Nat
  theory : T
  whole : FiniteObjectiveU
  ancestors : List (AncestralRecord T H)
  ethics : E → Prop
  rightHanded : Bool

/-- A starting theory is enacted into the modeled evolved source. -/
def plant (J : JokerExperiment T FiniteObjectiveU H)
    (t : T) (ethics : E → Prop) : LivingTree T H E where
  epoch := 0
  theory := t
  whole := objectiveStep (J.enact t)
  ancestors := []
  ethics := ethics
  rightHanded := true

/-- The completed actual *modeled* world, not the predicted one,
updates the Tree; the revised model seeds the next whole-source U. -/
def cultivate (J : JokerExperiment T FiniteObjectiveU H)
    (s : LivingTree T H E) : LivingTree T H E :=
  let observed := J.completedHistory s.whole
  let nextTheory := J.revise s.theory observed
  { epoch := s.epoch + 1
    theory := nextTheory
    whole := objectiveStep (J.enact nextTheory)
    ancestors := (s.theory, s.whole, observed) :: s.ancestors
    ethics := s.ethics
    rightHanded := s.rightHanded }

/-- Genuine repeated revision, once for every modeled epoch. -/
def grow (J : JokerExperiment T FiniteObjectiveU H)
    (s : LivingTree T H E) : Nat → LivingTree T H E
  | 0 => s
  | n + 1 => cultivate J (grow J s n)

/-- The Joker result, forward stage and whole-source Genesis
candidate are calculated from the SAME completed modeled history. -/
theorem each_generation_learns_and_prepares_next_U
    (J : JokerExperiment T FiniteObjectiveU H)
    (s : LivingTree T H E) :
    (cultivate J s).epoch = s.epoch + 1 ∧
    (cultivate J s).theory =
      J.revise s.theory (J.completedHistory s.whole) ∧
    (cultivate J s).whole =
      objectiveStep
        (J.enact (J.revise s.theory
          (J.completedHistory s.whole))) := by
  exact ⟨rfl, rfl, rfl⟩

/-- Each ancestor remains part of the complete Tree, even when its
revised successor has a different physical operator source. -/
theorem every_ancestor_survives_one_revision
    (J : JokerExperiment T FiniteObjectiveU H)
    (s : LivingTree T H E) (record : AncestralRecord T H)
    (h : record ∈ s.ancestors) :
    record ∈ (cultivate J s).ancestors := by
  simp [cultivate, h]

/-- The currently completed universe and its observed history are
added to the Tree; it cannot silently discard this generation. -/
theorem current_world_enters_tree
    (J : JokerExperiment T FiniteObjectiveU H)
    (s : LivingTree T H E) :
    (s.theory, s.whole, J.completedHistory s.whole) ∈
      (cultivate J s).ancestors := by
  simp [cultivate]

/-- Every previously recorded ancestor survives any finite
number of further learn-and-Genesis candidate stages. -/
theorem ancestors_survive_all_future_generations
    (J : JokerExperiment T FiniteObjectiveU H)
    (s : LivingTree T H E) (record : AncestralRecord T H)
    (k n : Nat)
    (h : record ∈ (grow J s k).ancestors) :
    record ∈ (grow J s (k + n)).ancestors := by
  induction n with
  | zero =>
      simpa using h
  | succ n ih =>
      have hNext :=
        every_ancestor_survives_one_revision J (grow J s (k + n))
          record ih
      simpa [grow, Nat.add_succ] using hNext

/-- There is a new historical record at each successive stage;
this is not merely identical W renewal through two-period recurrence. -/
theorem accumulated_knowledge_grows_each_generation
    (J : JokerExperiment T FiniteObjectiveU H)
    (s : LivingTree T H E) (n : Nat) :
    (grow J s n).ancestors.length =
      s.ancestors.length + n := by
  induction n with
  | zero => rfl
  | succ n ih =>
      change (grow J s n).ancestors.length + 1 =
        s.ancestors.length + (n + 1)
      rw [ih]
      omega

/-- Forward Time Koru: chronological epoch rank strictly grows
while the complete ancestral record is retained. -/
theorem epoch_advances_with_learning
    (J : JokerExperiment T FiniteObjectiveU H)
    (s : LivingTree T H E) (n : Nat) :
    (grow J s n).epoch = s.epoch + n := by
  induction n with
  | zero => rfl
  | succ n ih =>
      change (grow J s n).epoch + 1 = s.epoch + (n + 1)
      rw [ih]
      omega

/-- Original ethical records and right-handed orientation are never
erased or inverted by this proposed learned-boundary construction. -/
theorem modeled_learning_preserves_ethics_and_orientation
    (J : JokerExperiment T FiniteObjectiveU H)
    (s : LivingTree T H E) (n : Nat) (e : E) :
    ((grow J s n).ethics e ↔ s.ethics e) ∧
    (grow J s n).rightHanded = s.rightHanded := by
  induction n with
  | zero => exact ⟨Iff.rfl, rfl⟩
  | succ n ih =>
      simpa [grow, cultivate] using ih

/-- The next source is obtained from the revised model at every
generation, not by forgetting the Joker feedback after epoch one. -/
theorem every_successor_is_model_generated
    (J : JokerExperiment T FiniteObjectiveU H)
    (s : LivingTree T H E) (n : Nat) :
    (grow J s (n + 1)).whole =
      objectiveStep
        (J.enact
          (J.revise (grow J s n).theory
            (J.completedHistory (grow J s n).whole))) := by
  rfl

#print axioms each_generation_learns_and_prepares_next_U
#print axioms every_ancestor_survives_one_revision
#print axioms current_world_enters_tree
#print axioms ancestors_survive_all_future_generations
#print axioms accumulated_knowledge_grows_each_generation
#print axioms epoch_advances_with_learning
#print axioms modeled_learning_preserves_ethics_and_orientation
#print axioms every_successor_is_model_generated

end PhysicalBridges.LivingTreeGenerations
