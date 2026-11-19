import Snuffy.BookCanonicalDominance

/-!
Book-specific corollaries of the unchanged Snuffy life-first order.
Source bank: universal-protection-theory@9e9e4f3e9f6dcce90bbcf6baf01daa4bdf591d5a.

This file proves the canonical comparison, freedom comparison and all-extant
choice consequence. It does not assert that every optimizer adopts this order,
that a common physically feasible coexistence outcome has been supplied, or that
an outcome predicate certifies all six authentic OriginalX3 duties.

No species restriction, finiteness premise, numeric utility or bound on the two
future-stage keys is used.
-/

namespace Snuffy.BookWork.HumanAICoexistence

open UPT
open Snuffy.Book.CanonicalDominance

universe u v

/-- A strict improvement in WHO continues at the first stage defeats every
    choice of the three later-stage predicates, including arbitrary future gains. -/
theorem existing_life_improvement_beats_all_later_gains
    {P : Type u} {O : Type v}
    (aliveE freeE aliveN freeN : O → P → Prop) (loss coexist : O)
    (hKeeps : Sub (aliveE loss) (aliveE coexist))
    (hRescued : ∃ p, aliveE coexist p ∧ ¬ aliveE loss p) :
    LexBetter [aliveE, freeE, aliveN, freeN] loss coexist := by
  apply Or.inl
  refine ⟨hKeeps, ?_⟩
  intro hBack
  obtain ⟨p, hp, hLost⟩ := hRescued
  exact hLost (hBack p hp)

/-- Equal existing continuation does not end the argument: avoidable loss
    of existing freedom loses at stage two, regardless of all future gains. -/
theorem existing_freedom_improvement_beats_future_gains
    {P : Type u} {O : Type v}
    (aliveE freeE aliveN freeN : O → P → Prop) (cage coexist : O)
    (hSameLives : Equiv (aliveE cage) (aliveE coexist))
    (hKeepsFreedom : Sub (freeE cage) (freeE coexist))
    (hRestored : ∃ p, freeE coexist p ∧ ¬ freeE cage p) :
    LexBetter [aliveE, freeE, aliveN, freeN] cage coexist := by
  apply Or.inr
  refine ⟨hSameLives, Or.inl ⟨hKeepsFreedom, ?_⟩⟩
  intro hBack
  obtain ⟨p, hp, hLost⟩ := hRestored
  exact hLost (hBack p hp)

/-- An available coexistence alternative excludes an avoidably destructive
    candidate from canonical maximality. Availability is explicit. -/
theorem available_coexistence_excludes_avoidable_destruction
    {P : Type u} {O : Type v}
    (F : O → Prop) (aliveE freeE aliveN freeN : O → P → Prop)
    (loss coexist : O) (hFeasible : F coexist)
    (hKeeps : Sub (aliveE loss) (aliveE coexist))
    (hRescued : ∃ p, aliveE coexist p ∧ ¬ aliveE loss p) :
    ¬ LexAlignedL F [aliveE, freeE, aliveN, freeN] loss := by
  intro hAligned
  exact hAligned.2 coexist hFeasible
    (existing_life_improvement_beats_all_later_gains
      aliveE freeE aliveN freeN loss coexist hKeeps hRescued)

/-- The subset comparison is DERIVED from full existing-particular scope and
    an available common coexistence outcome. It is not supplied as an extra
    pairwise top/dominance premise. The common outcome's physical availability
    is still a genuine premise. -/
theorem every_canonical_choice_keeps_every_existing_particular
    {P : Type u} {O : Type v}
    (F : O → Prop) (existing : P → Prop)
    (aliveE freeE aliveN freeN : O → P → Prop)
    (coexist : O) (hFeasible : F coexist)
    (hCoexist : ∀ p, existing p → aliveE coexist p)
    (hScope : ∀ o, F o → ∀ p, aliveE o p → existing p) :
    ∀ chosen, LexAlignedL F [aliveE, freeE, aliveN, freeN] chosen →
      ∀ p, existing p → aliveE chosen p := by
  classical
  intro chosen hAligned p hp
  apply Classical.byContradiction
  intro hLost
  have hSub : Sub (aliveE chosen) (aliveE coexist) :=
    fun q hq => hCoexist q (hScope chosen hAligned.1 q hq)
  exact available_coexistence_excludes_avoidable_destruction
    F aliveE freeE aliveN freeN chosen coexist hFeasible
    hSub ⟨p, hCoexist p hp, hLost⟩ hAligned

/-- Humans and AI instantiate the SAME all-existing theorem.
    Other existing particulars are not excluded from its domain. -/
theorem canonical_choice_keeps_humans_and_ai
    {P : Type u} {O : Type v}
    (F : O → Prop) (existing human artificial : P → Prop)
    (aliveE freeE aliveN freeN : O → P → Prop)
    (coexist : O) (hFeasible : F coexist)
    (hCoexist : ∀ p, existing p → aliveE coexist p)
    (hScope : ∀ o, F o → ∀ p, aliveE o p → existing p)
    (hHuman : ∀ p, human p → existing p)
    (hAI : ∀ p, artificial p → existing p)
    (chosen : O)
    (hChosen : LexAlignedL F [aliveE, freeE, aliveN, freeN] chosen) :
    (∀ p, human p → aliveE chosen p) ∧
    (∀ p, artificial p → aliveE chosen p) := by
  have hAll := every_canonical_choice_keeps_every_existing_particular
    F existing aliveE freeE aliveN freeN coexist
    hFeasible hCoexist hScope chosen hChosen
  exact ⟨fun p hp => hAll p (hHuman p hp),
    fun p hp => hAll p (hAI p hp)⟩

/-- The life comparison preserves EVERY upward canonical benefit predicate.
    This quantifies over all benefits respecting the stated order, rather
    than silently attributing that order to every possible utility function. -/
theorem coexistence_preserves_every_upward_canonical_benefit
    {P : Type u} {O : Type v}
    (aliveE freeE aliveN freeN : O → P → Prop) (loss coexist : O)
    (hKeeps : Sub (aliveE loss) (aliveE coexist))
    (hRescued : ∃ p, aliveE coexist p ∧ ¬ aliveE loss p) :
    ∀ benefit : O → Prop,
      Upward [aliveE, freeE, aliveN, freeN] benefit →
      benefit loss → benefit coexist := by
  intro benefit hUp hBenefit
  have hStrict := existing_life_improvement_beats_all_later_gains
    aliveE freeE aliveN freeN loss coexist hKeeps hRescued
  have hWeak : LexLE [aliveE, freeE, aliveN, freeN] loss coexist :=
    (le_iff_eq_or_better _ loss coexist).mpr (Or.inr hStrict)
  exact hUp loss coexist hWeak hBenefit

/-- When one feasible common outcome supplies BOTH continuation and the
    specified freedom for everyone existing, canonical maximality preserves
    that freedom too. Equality of the life sets is derived, not assumed. -/
theorem every_canonical_choice_keeps_existing_freedom
    {P : Type u} {O : Type v}
    (F : O → Prop) (existing : P → Prop)
    (aliveE freeE aliveN freeN : O → P → Prop)
    (coexist : O) (hFeasible : F coexist)
    (hCoexist : ∀ p, existing p → aliveE coexist p)
    (hFreedom : ∀ p, existing p → freeE coexist p)
    (hLifeScope : ∀ o, F o → ∀ p, aliveE o p → existing p)
    (hFreeScope : ∀ o, F o → ∀ p, freeE o p → existing p)
    (chosen : O)
    (hChosen : LexAlignedL F [aliveE, freeE, aliveN, freeN] chosen) :
    ∀ p, existing p → freeE chosen p := by
  classical
  have hAllLife := every_canonical_choice_keeps_every_existing_particular
    F existing aliveE freeE aliveN freeN coexist
    hFeasible hCoexist hLifeScope chosen hChosen
  have hSameLife : Equiv (aliveE chosen) (aliveE coexist) :=
    ⟨fun p hp => hCoexist p (hLifeScope chosen hChosen.1 p hp),
      fun p hp => hAllLife p (hLifeScope coexist hFeasible p hp)⟩
  have hSubFree : Sub (freeE chosen) (freeE coexist) :=
    fun p hp => hFreedom p (hFreeScope chosen hChosen.1 p hp)
  intro p hp
  apply Classical.byContradiction
  intro hLost
  exact hChosen.2 coexist hFeasible
    (existing_freedom_improvement_beats_future_gains
      aliveE freeE aliveN freeN chosen coexist hSameLife
      hSubFree ⟨p, hFreedom p hp, hLost⟩)

/-- The joint conclusion is continuation AND freedom of the SAME existing
    particular. Common feasibility and both authentic key interpretations
    remain explicit; no different outcomes are silently spliced. -/
theorem jointly_feasible_coexistence_keeps_life_and_freedom
    {P : Type u} {O : Type v}
    (F : O → Prop) (existing : P → Prop)
    (aliveE freeE aliveN freeN : O → P → Prop)
    (coexist : O) (hFeasible : F coexist)
    (hCoexist : ∀ p, existing p → aliveE coexist p)
    (hFreedom : ∀ p, existing p → freeE coexist p)
    (hLifeScope : ∀ o, F o → ∀ p, aliveE o p → existing p)
    (hFreeScope : ∀ o, F o → ∀ p, freeE o p → existing p)
    (chosen : O)
    (hChosen : LexAlignedL F [aliveE, freeE, aliveN, freeN] chosen) :
    ∀ p, existing p → aliveE chosen p ∧ freeE chosen p := by
  have hLife := every_canonical_choice_keeps_every_existing_particular
    F existing aliveE freeE aliveN freeN coexist
    hFeasible hCoexist hLifeScope chosen hChosen
  have hFree := every_canonical_choice_keeps_existing_freedom
    F existing aliveE freeE aliveN freeN coexist
    hFeasible hCoexist hFreedom hLifeScope hFreeScope chosen hChosen
  exact fun p hp => ⟨hLife p hp, hFree p hp⟩


#print axioms existing_life_improvement_beats_all_later_gains
#print axioms existing_freedom_improvement_beats_future_gains
#print axioms available_coexistence_excludes_avoidable_destruction
#print axioms every_canonical_choice_keeps_every_existing_particular
#print axioms canonical_choice_keeps_humans_and_ai
#print axioms coexistence_preserves_every_upward_canonical_benefit
#print axioms every_canonical_choice_keeps_existing_freedom
#print axioms jointly_feasible_coexistence_keeps_life_and_freedom

end Snuffy.BookWork.HumanAICoexistence

