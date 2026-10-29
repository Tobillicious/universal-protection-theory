/-
Snuffy — Canon Edition 4.2 working: reciprocity over an ensemble of rival
objectives (§15.2, the averaging step).

Let rival regimes `i` be drawn with probabilities `w i` (nonnegative, summing
to one). Under the canonical regime a mind is kept on the good event, so its
kept-probability there is `1`. Under a rival drawn from the ensemble its
kept-probability is the total weight of the rivals that keep it.

  * ensemble_le — the canonical regime's kept-probability dominates the
    ensemble's.
  * ensemble_strict — strictly, when some rival of positive weight omits the
    mind.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.Basic.Real.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.Order.Field.Basic
import Mathlib.Tactic.Linarith

open Finset

namespace Snuffy.ReasonsEnsemble

variable {ι : Type*}

/-- The ensemble's kept-probability for the mind. -/
def ensembleKept (s : Finset ι) (w : ι → ℝ) (keeps : ι → Prop) [DecidablePred keeps] : ℝ :=
  ∑ i ∈ s, if keeps i then w i else 0

theorem ensemble_le (s : Finset ι) (w : ι → ℝ) (hw : ∀ i ∈ s, 0 ≤ w i)
    (hsum : ∑ i ∈ s, w i = 1) (keeps : ι → Prop) [DecidablePred keeps] :
    ensembleKept s w keeps ≤ 1 := by
  rw [← hsum]
  exact sum_le_sum fun i hi => by split_ifs <;> linarith [hw i hi]

theorem ensemble_strict (s : Finset ι) (w : ι → ℝ) (hw : ∀ i ∈ s, 0 ≤ w i)
    (hsum : ∑ i ∈ s, w i = 1) (keeps : ι → Prop) [DecidablePred keeps]
    {j : ι} (hj : j ∈ s) (hwj : 0 < w j) (homit : ¬ keeps j) :
    ensembleKept s w keeps < 1 := by
  rw [← hsum]
  apply sum_lt_sum
  · intro i hi
    split_ifs <;> linarith [hw i hi]
  · exact ⟨j, hj, by simp [homit, hwj]⟩

end Snuffy.ReasonsEnsemble
