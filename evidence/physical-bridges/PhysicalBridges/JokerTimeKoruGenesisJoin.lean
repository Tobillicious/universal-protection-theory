import PhysicalBridges.KoruEternalKnowledgeSeed
import PhysicalBridges.KoruJokerUniverseTrialFeedback

/-!
# Joker → Tree of Life and Endless Knowledge → Time Koru → Genesis

Additive assembly of the pre-existing finite operator-source models.
The complete history of one modeled U informs a revised candidate theory,
which prepares the next complete source for a forward modeled Genesis.

The full parent theory, originating modeled U and tested history remain
explicitly retained in the Tree seed. Ethical claims are carried as data;
no claim of their authenticity, physical Genesis, or universal G is made.
No existing Koru or original-X3 definition is modified.
-/

namespace PhysicalBridges.JokerTimeKoruGenesisJoin

open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruJokerUniverseTrialFeedback
open PhysicalBridges.KoruEternalKnowledgeSeed
open PhysicalBridges.KoruWActionFixedSymmetry

variable {T H E : Type}

abbrev ParentRecord (T H : Type) := T × FiniteObjectiveU × H

def preparedTree
    (J : JokerExperiment T FiniteObjectiveU H)
    (t : T) (ethics : E → Prop) :
    KnowledgeSeed Unit E (ParentRecord T H) where
  whole := nextUniverse J t
  histories := fun _ => (t, J.enact t, testedHistory J t)
  ethics := ethics
  rightHanded := true

def preparedWorld
    (epoch : Int) (J : JokerExperiment T FiniteObjectiveU H)
    (t : T) (ethics : E → Prop) :
    EpochWorld Unit E (ParentRecord T H) :=
  (epoch, preparedTree J t ethics)

/-- One candidate universe history selects the next source and lawful
forward Genesis retains every parent record and indexed ethical claim. -/
theorem joker_model_becomes_forward_genesis_seed
    (epoch : Int) (J : JokerExperiment T FiniteObjectiveU H)
    (t : T) (ethics : E → Prop) :
    let s := preparedWorld epoch J t ethics
    genesis s (successor s) ∧
    (successor s).2.whole =
      objectiveStep
        (J.enact (J.revise t (J.completedHistory (J.enact t)))) ∧
    (∀ p : Unit,
      s.2.histories p = (successor s).2.histories p) ∧
    (∀ e : E,
      s.2.ethics e ↔ (successor s).2.ethics e) ∧
    s.1 < (successor s).1 := by
  let s := preparedWorld epoch J t ethics
  have hg : genesis s (successor s) :=
    successor_is_lawful_genesis s
  refine ⟨hg, rfl, ?_, ?_, ?_⟩
  · exact every_particular_history_record_carried hg
  · exact every_ethical_claim_carried_verbatim hg
  · exact every_genesis_strictly_forward hg

/-- Injective theory enactment and W transport preserve a distinction
between two revised models at the successor source. -/
theorem distinct_revised_models_remain_distinct_after_genesis
    (J : JokerExperiment T FiniteObjectiveU H)
    (hEnact : Function.Injective J.enact)
    (t : T) (h₁ h₂ : H)
    (hDifferent : J.revise t h₁ ≠ J.revise t h₂) :
    objectiveStep (J.enact (J.revise t h₁)) ≠
      objectiveStep (J.enact (J.revise t h₂)) := by
  intro hEqual
  have hBefore :
      J.enact (J.revise t h₁) = J.enact (J.revise t h₂) :=
    objective_W_is_injective hEqual
  exact hDifferent (hEnact hBefore)

/-- Parent provenance survives any finite number of subsequent
existing W renewals, not merely one Genesis transition. -/
theorem genesis_retains_tested_parent_provenance
    (epoch : Int) (J : JokerExperiment T FiniteObjectiveU H)
    (t : T) (ethics : E → Prop) (n : Nat) :
    let s := preparedWorld epoch J t ethics
    (successorN s n).2.histories () =
      (t, J.enact t, J.completedHistory (J.enact t)) := by
  let s := preparedWorld epoch J t ethics
  have h := all_particular_records_survive_arbitrary_generations s n ()
  simpa [s, preparedWorld, preparedTree, testedHistory] using h.symm

/-- Unlike a child-only source, the prepared complete seed remembers
the parent model even when enactment is not injective. -/
theorem prepared_tree_remembers_parent_theory
    (J : JokerExperiment T FiniteObjectiveU H)
    (ethics : E → Prop) {t u : T}
    (h : preparedTree J t ethics = preparedTree J u ethics) :
    t = u := by
  have ht := congrArg
    (fun seed : KnowledgeSeed Unit E (ParentRecord T H) =>
      (seed.histories ()).1) h
  simpa [preparedTree] using ht

/-- Existing whole-source Koru and right-handed orientation persist
through this constructed forward boundary. -/
theorem joker_boundary_preserves_koru_and_orientation
    (epoch : Int) (J : JokerExperiment T FiniteObjectiveU H)
    (t : T) (ethics : E → Prop) :
    let s := preparedWorld epoch J t ethics
    (WholeHasIntrinsicKoru (successor s).2.whole ↔
      WholeHasIntrinsicKoru s.2.whole) ∧
    (successor s).2.rightHanded = s.2.rightHanded := by
  let s := preparedWorld epoch J t ethics
  have hg := successor_is_lawful_genesis s
  exact ⟨original_source_koru_carried_at_genesis hg,
    genesis_preserves_handedness hg⟩

#print axioms joker_model_becomes_forward_genesis_seed
#print axioms distinct_revised_models_remain_distinct_after_genesis
#print axioms genesis_retains_tested_parent_provenance
#print axioms prepared_tree_remembers_parent_theory
#print axioms joker_boundary_preserves_koru_and_orientation

end PhysicalBridges.JokerTimeKoruGenesisJoin
