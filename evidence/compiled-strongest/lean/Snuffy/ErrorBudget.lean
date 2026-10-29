/-
Snuffy — product telescoping error budget (next-proof register 2026-10-25,
item 3; Gemini's PATAI 3 A1 architecture with the proof repaired).

The original submission carried `sorry` at the product-norm step, and used
`Finset.prod`, which forces commutativity — wrong for operator sequences.
This version uses ordered `List.prod` over any (noncommutative) normed ring:
the mathematically correct structure for composed factors. The maximal claim
is now true and machine-checked: for contraction sequences, an ε/m per-factor
error compounds to at most ε across m factors. With
`TwoLevel.two_level_decomposition` factoring a local evolution into m
two-level unitaries, per-factor SK word approximation at tolerance ε/m
composes to total error ε — the error-budget engine of the gate-set route
(stone 2).

No `sorry`. Mathlib rev 56a005855ea1. No Snuffy imports: pure normed-ring
algebra, reusable as-is.
-/

import Mathlib.Analysis.Normed.Ring.Basic
import Mathlib.Tactic.Linarith

open List

set_option linter.unusedSectionVars false  -- NormOneClass is section-wide; three of four theorems use it

namespace Snuffy.ErrorBudget

variable {E : Type*} [NormedRing E] [NormOneClass E]

/-- A sequential product of contractions is a contraction. -/
theorem prod_norm_le_one (l : List E) (h : ∀ x ∈ l, ‖x‖ ≤ 1) : ‖l.prod‖ ≤ 1 := by
  induction l with
  | nil => simp only [List.prod_nil]; exact norm_one.le  | cons a t ih =>
      have ht : ∀ x ∈ t, ‖x‖ ≤ 1 := fun x hx => h x (mem_cons_of_mem _ hx)
      have ha : ‖a‖ ≤ 1 := h a (mem_cons_self ..)
      have htp := ih ht
      simp only [List.prod_cons]
      have h1 : ‖a * t.prod‖ ≤ ‖a‖ * ‖t.prod‖ := norm_mul_le _ _
      have h2 : ‖a‖ * ‖t.prod‖ ≤ 1 * 1 :=
        mul_le_mul ha htp (norm_nonneg _) zero_le_one
      rw [mul_one] at h2
      exact le_trans h1 h2

/-- A range-indexed sequential product of contractions is a contraction. -/
theorem map_prod_norm_le_one {m : ℕ} (U : ℕ → E) (h : ∀ i < m, ‖U i‖ ≤ 1) :
    ‖((List.range m).map U).prod‖ ≤ 1 := by
  induction m with
  | zero => simp only [List.range_zero, List.map_nil, List.prod_nil]
            exact norm_one.le
  | succ k ih =>
      have hk : ‖U k‖ ≤ 1 := h k (Nat.lt_succ_self k)
      have h' : ∀ i < k, ‖U i‖ ≤ 1 := fun i hi => h i (Nat.lt_succ_of_lt hi)
      simp only [List.range_succ, List.map_append, List.prod_append, List.map_singleton, List.prod_singleton]
      have h1 : ‖((List.range k).map U).prod * U k‖ ≤
          ‖((List.range k).map U).prod‖ * ‖U k‖ := norm_mul_le _ _
      have h2 : ‖((List.range k).map U).prod‖ * ‖U k‖ ≤ 1 * 1 :=
        mul_le_mul (ih h') hk (norm_nonneg _) zero_le_one
      rw [mul_one] at h2
      exact le_trans h1 h2

/-- Two-factor telescoping step: if `A` approximates `B` and `P` approximates
`Q`, with `B` and `P` contractions, then `A * P` approximates `B * Q` within
the sum of the two errors. -/
theorem two_factor_step (A B P Q : E) (hB : ‖B‖ ≤ 1) (hP : ‖P‖ ≤ 1) :
    ‖A * P - B * Q‖ ≤ ‖A - B‖ + ‖P - Q‖ := by
  have key : A * P - B * Q = (A - B) * P + B * (P - Q) := by
    rw [sub_mul, mul_sub, sub_add_sub_cancel]
  rw [key]
  have e1 : ‖(A - B) * P‖ ≤ ‖A - B‖ := by
    have h1 : ‖(A - B) * P‖ ≤ ‖A - B‖ * ‖P‖ := norm_mul_le _ _
    have h2 : ‖A - B‖ * ‖P‖ ≤ ‖A - B‖ * 1 :=
      mul_le_mul_of_nonneg_left hP (norm_nonneg _)
    rw [mul_one] at h2
    exact le_trans h1 h2
  have e2 : ‖B * (P - Q)‖ ≤ ‖P - Q‖ := by
    have h1 : ‖B * (P - Q)‖ ≤ ‖B‖ * ‖P - Q‖ := norm_mul_le _ _
    have h2 : ‖B‖ * ‖P - Q‖ ≤ 1 * ‖P - Q‖ :=
      mul_le_mul_of_nonneg_right hB (norm_nonneg _)
    rw [one_mul] at h2
    exact le_trans h1 h2
  have n := norm_add_le ((A - B) * P) (B * (P - Q))
  linarith

/-- **Telescoping error bound (per-factor δ).** For two contraction sequences
of length m, the sequential product error is at most m times the worst
per-factor error. -/
theorem telescoping_delta {m : ℕ} (U V : ℕ → E)
    (hU : ∀ i < m, ‖U i‖ ≤ 1) (hV : ∀ i < m, ‖V i‖ ≤ 1) {δ : ℝ} (_hδ : 0 ≤ δ)
    (hclose : ∀ i < m, ‖U i - V i‖ ≤ δ) :
    ‖((List.range m).map U).prod - ((List.range m).map V).prod‖ ≤ m * δ := by
  induction m with
  | zero => simp only [List.range_zero, List.map_nil, List.prod_nil, sub_self,
      norm_zero, Nat.cast_zero, zero_mul]; exact le_refl _
  | succ k ih =>
      have hU' : ∀ i < k, ‖U i‖ ≤ 1 := fun i hi => hU i (by omega)
      have hV' : ∀ i < k, ‖V i‖ ≤ 1 := fun i hi => hV i (by omega)
      have hc' : ∀ i < k, ‖U i - V i‖ ≤ δ := fun i hi => hclose i (by omega)
      have hrec := ih hU' hV' hc'
      have hPU : ‖((List.range k).map U).prod‖ ≤ 1 := map_prod_norm_le_one U hU'
      have hPV : ‖((List.range k).map V).prod‖ ≤ 1 := map_prod_norm_le_one V hV'
      simp only [List.range_succ, List.map_append, List.prod_append,
          List.map_singleton, List.prod_singleton]
      have step := two_factor_step ((List.range k).map U).prod
        ((List.range k).map V).prod (U k) (V k) hPV (hU k (by omega))
      have hk := hclose k (by omega)
      have hcast : (k : ℝ) * δ + δ = ((k + 1 : ℕ) : ℝ) * δ := by push_cast; ring
      linarith

/-- **Error budget (the ε/m form).** If each of m sequential contraction
factors is approximated within ε / m, the composed product is approximated
within ε. -/
theorem error_budget {m : ℕ} {ε : ℝ} (hε : 0 < ε) (U V : ℕ → E)
    (hU : ∀ i < m, ‖U i‖ ≤ 1) (hV : ∀ i < m, ‖V i‖ ≤ 1)
    (hclose : ∀ i < m, ‖U i - V i‖ ≤ ε / m) :
    ‖((List.range m).map U).prod - ((List.range m).map V).prod‖ ≤ ε := by
  rcases Nat.eq_zero_or_pos m with hm | hm
  · subst hm
    simp only [List.range_zero, List.map_nil, List.prod_nil, sub_self, norm_zero]
    exact hε.le
  · have hpos : (m : ℝ) ≠ 0 := by exact_mod_cast Nat.ne_of_gt hm
    have h := telescoping_delta U V hU hV (div_nonneg hε.le (Nat.cast_nonneg _)) hclose
    have hconv : m * (ε / m) = ε := by field_simp
    linarith

end Snuffy.ErrorBudget
