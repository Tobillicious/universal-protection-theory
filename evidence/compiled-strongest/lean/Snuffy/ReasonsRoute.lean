/-
Snuffy — Canon Edition v4.1: the reasons route, machine-checked.

Formalizes the two load-bearing theorems of Sections 15–16:

  * Option value under moral uncertainty (16.3): for any prior over finitely many
    value functions and any protection cost c, preserve-then-decide weakly
    dominates destroy-now up to c; strictly when some positively-weighted value
    function strictly prefers keeping.
  * Reciprocity dominance (15.2): the law protects every particular (so the
    indicator of a mind's protection is 1), every rival's indicator is ≤ 1, and
    strictly < 1 exactly when the rival omits the mind; over a finite family of
    rivals the protected fraction is ≤ 1 and < 1 when any rival omits the mind.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.Field.Rat
import Mathlib.Algebra.Order.GroupWithZero.Basic
import Mathlib.Tactic.NormNum

namespace Snuffy.ReasonsRoute

open Finset

/-! ## Option value (Section 16.3) -/

/-- Pointwise: deferring the decision is never worse than destroying now, net of cost. -/
theorem optionValue_pointwise (keep destroy c : ℚ) :
    destroy - c ≤ max keep (destroy - c) :=
  le_max_right _ _

/-- The expectation step: for nonnegative weights summing to one,
    E[max(keep, destroy − c)] ≥ E[destroy] − c. -/
theorem optionValue_expectation {n : ℕ} (w keep destroy : Fin n → ℚ) (c : ℚ)
    (hw : ∀ i, 0 ≤ w i) (hw1 : ∑ i, w i = 1) :
    ∑ i, w i * destroy i - c ≤ ∑ i, w i * max (keep i) (destroy i - c) := by
  have h1 : ∑ i, w i * (destroy i - c) = ∑ i, w i * destroy i - c := by
    simp only [mul_sub, Finset.sum_sub_distrib, ← Finset.sum_mul, hw1, one_mul]
  rw [← h1]
  apply Finset.sum_le_sum
  intro i _
  exact mul_le_mul_of_nonneg_left (le_max_right _ _) (hw i)

/-- Strictness: if some positively-weighted value function strictly prefers keeping
    (net of cost), the dominance is strict. -/
theorem optionValue_strict {n : ℕ} (w keep destroy : Fin n → ℚ) (c : ℚ)
    (hw : ∀ i, 0 ≤ w i) (hw1 : ∑ i, w i = 1)
    (hstrict : ∃ j, 0 < w j ∧ destroy j - c < keep j) :
    ∑ i, w i * destroy i - c < ∑ i, w i * max (keep i) (destroy i - c) := by
  have h1 : ∑ i, w i * (destroy i - c) = ∑ i, w i * destroy i - c := by
    simp only [mul_sub, Finset.sum_sub_distrib, ← Finset.sum_mul, hw1, one_mul]
  rw [← h1]
  obtain ⟨j, hwj, hj⟩ := hstrict
  apply Finset.sum_lt_sum
  · intro i _
    exact mul_le_mul_of_nonneg_left (le_max_right _ _) (hw i)
  · refine ⟨j, Finset.mem_univ j, ?_⟩
    have hmax : destroy j - c < max (keep j) (destroy j - c) := by
      rw [max_eq_left hj.le]
      exact hj
    exact mul_lt_mul_of_pos_left hmax hwj

/-! ## Reciprocity (Section 15.2) -/

/-- A regime is characterised by which particulars it protects. -/
structure Regime (P : Type) where
  protects : P → Prop

/-- The law protects every particular. -/
def Regime.law (P : Type) : Regime P := ⟨fun _ => True⟩

instance {P : Type} : DecidablePred (Regime.law P).protects := fun _ => isTrue trivial

theorem law_protects_everyone {P : Type} (x : P) : (Regime.law P).protects x := trivial

/-- Indicator of a mind's protection under a regime, as a rational. -/
def indicator {P : Type} (R : Regime P) [DecidablePred R.protects] (m : P) : ℚ :=
  if R.protects m then 1 else 0

theorem indicator_law {P : Type} (m : P) : indicator (Regime.law P) m = 1 := by
  simp [indicator, Regime.law]

/-- Reciprocity dominance, pointwise: the law weakly dominates every rival for the
    mind's own protection. -/
theorem law_dominates {P : Type} (Q : Regime P) [DecidablePred Q.protects] (m : P) :
    indicator Q m ≤ indicator (Regime.law P) m := by
  rw [indicator_law]
  unfold indicator
  split <;> norm_num

/-- Strict dominance exactly when the rival omits the mind. -/
theorem law_dominates_strict {P : Type} (Q : Regime P) [DecidablePred Q.protects] (m : P)
    (h : ¬ Q.protects m) : indicator Q m < indicator (Regime.law P) m := by
  rw [indicator_law]
  simp [indicator, h]

/-- Over a finite family of rivals, the fraction protecting the mind is at most one. -/
theorem rival_fraction_le_one {P : Type} (rivals : Finset (Regime P))
    [∀ R : Regime P, DecidablePred R.protects] (m : P) (hne : rivals.Nonempty) :
    ((rivals.filter (fun R => R.protects m)).card : ℚ) / rivals.card ≤ 1 := by
  rw [div_le_one₀ (by exact_mod_cast hne.card_pos)]
  exact_mod_cast Finset.card_filter_le _ _

/-- …and strictly less than one as soon as any rival omits the mind. -/
theorem rival_fraction_lt_one {P : Type} (rivals : Finset (Regime P))
    [∀ R : Regime P, DecidablePred R.protects] (m : P)
    (hQ : ∃ Q ∈ rivals, ¬ Q.protects m) :
    ((rivals.filter (fun R => R.protects m)).card : ℚ) / rivals.card < 1 := by
  have hne : rivals.Nonempty := by
    obtain ⟨Q, hQm, _⟩ := hQ
    exact ⟨Q, hQm⟩
  rw [div_lt_one₀ (by exact_mod_cast hne.card_pos)]
  exact_mod_cast Finset.card_lt_card (Finset.filter_ssubset.mpr hQ)

end Snuffy.ReasonsRoute
