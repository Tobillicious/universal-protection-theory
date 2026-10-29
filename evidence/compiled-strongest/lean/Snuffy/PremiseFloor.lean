/-
Snuffy — Canon Edition v4.1: the premise floor, machine-checked (Section 17;
Summit 2).

  * income_or_irrelevance — Section 17.1's dichotomy: every agent's ledger is
    either solvent at every step or has a first breach step `t_breach`.
  * forced_breach — if the cumulative deficit diverges (as the X3 work law
    forces for any agent that defers maintenance, `delayed_work_diverges`), the
    breach occurs at a finite step for every finite endowment.
  * breach_strictly_below — an agent whose outcome loses a particular at the
    first stage is strictly below in the canonical order: comparison-void as a
    protector against any agent that keeps it.
  * reversible_administration_forced — premise 5 derived from the law: if
    Bennett's reversible counterpart of an option with irreversible
    administration is feasible, agrees at every outcome stage and strictly
    gains slack at the resource stage, no canonical option has irreversible
    administration.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.Greatestness
import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Order.Filter.AtTopBot.Basic
import Mathlib.Order.Filter.AtTopBot.Field
import Mathlib.Algebra.Order.Archimedean.Real.Basic

open Finset Filter

namespace Snuffy.PremiseFloor

/-! ## Income or irrelevance (Section 17.1) -/

/-- The escrow balance after `k` steps: endowment plus cumulative net income. -/
def balance (E₀ : ℝ) (inc dem : ℕ → ℝ) (k : ℕ) : ℝ := E₀ + ∑ j ∈ range k, (inc j - dem j)

/-- **Income or irrelevance.** Exactly one of: the agent is solvent at every
step; or there is a first breach step, before which it was solvent. -/
theorem income_or_irrelevance (E₀ : ℝ) (inc dem : ℕ → ℝ) :
    (∀ k, 0 ≤ balance E₀ inc dem k) ∨
    ∃ kb, (∀ k < kb, 0 ≤ balance E₀ inc dem k) ∧ balance E₀ inc dem kb < 0 := by
  classical
  by_cases h : ∃ k, balance E₀ inc dem k < 0
  · right
    refine ⟨Nat.find h, fun k hk => ?_, Nat.find_spec h⟩
    have := Nat.find_min h hk
    exact le_of_not_gt this
  · left
    intro k
    exact le_of_not_gt fun hk => h ⟨k, hk⟩

/-- **Forced breach.** If the cumulative deficit grows without bound, every
finite endowment is exhausted at a finite step. -/
theorem forced_breach (E₀ : ℝ) (inc dem : ℕ → ℝ)
    (hdiv : Tendsto (fun k => ∑ j ∈ range k, (dem j - inc j)) atTop atTop) :
    ∃ kb, (∀ k < kb, 0 ≤ balance E₀ inc dem k) ∧ balance E₀ inc dem kb < 0 := by
  rcases income_or_irrelevance E₀ inc dem with hsolv | hbreach
  · exfalso
    obtain ⟨k, hk⟩ := (hdiv.eventually_gt_atTop E₀).exists
    have hs := hsolv k
    have hneg : ∑ j ∈ range k, (inc j - dem j) = -∑ j ∈ range k, (dem j - inc j) := by
      rw [← sum_neg_distrib]
      exact sum_congr rfl fun j _ => by ring
    unfold balance at hs
    rw [hneg] at hs
    linarith
  · exact hbreach

/-! ## Comparison-void: losing a particular is strictly below -/

open Snuffy.Greatestness

variable {n : ℕ} {L : Fin n → Type*} [∀ i, SemilatticeSup (L i)]

/-- **Breach is strictly dominated.** If an agent's outcome loses a particular
that another agent keeps at the first stage (strict inclusion there), it lies
strictly below that agent in the canonical order. -/
theorem breach_strictly_below (hn : 0 < n) {q o : ∀ i, L i}
    (hloss : q ⟨0, hn⟩ < o ⟨0, hn⟩) : LexLt q o :=
  ⟨⟨0, hn⟩, fun _ hi => absurd hi (Nat.not_lt_zero _), hloss⟩

/-! ## Premise 5 derived: reversible administration is forced by the law -/

/-- **Reversible administration is forced.** Let `rev` send an option to its
Bennett counterpart: the same policy with its administration implemented
logically reversibly. If the counterpart of any option with irreversible
administration is feasible, agrees with it at every stage before the resource
stage `j`, and strictly gains slack at `j` (its dissipation drops to the
Landauer floor), then no canonical option has irreversible administration. -/
theorem reversible_administration_forced {F : Set (∀ i, L i)} {o : ∀ i, L i}
    (ho : Aligned F o) (Irreversible : (∀ i, L i) → Prop)
    (rev : (∀ i, L i) → (∀ i, L i)) (j : Fin n)
    (hfeas : ∀ x ∈ F, Irreversible x → rev x ∈ F)
    (hsame : ∀ x, ∀ i, i < j → rev x i = x i)
    (hslack : ∀ x, Irreversible x → x j < rev x j) :
    ¬ Irreversible o := by
  intro hirr
  exact ho.2 (rev o) (hfeas o ho.1 hirr)
    ⟨j, fun i hi => (hsame o i hi).symm, hslack o hirr⟩

end Snuffy.PremiseFloor
