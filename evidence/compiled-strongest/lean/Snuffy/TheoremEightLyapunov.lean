/-
Snuffy 4.2 repair: the actual clipped reserve-deficit functional.
Replenishment saturates at both the reserve target and the physical capacity.
Every charge belongs in `work`; excess income is not counted as a negative
deficit. A solvent cycle does not increase the reserve term, and the actual
error drift and repair then give the unchanged contraction target.
-/

import Mathlib.Basic.Real.Basic
import Mathlib.Algebra.Order.Field.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

namespace Snuffy.TheoremEightLyapunov

noncomputable def reserveDeficit (target scale escrow : ℝ) : ℝ :=
  max 0 (target - escrow) / scale

noncomputable def replenish (capacity escrow income : ℝ) : ℝ :=
  min capacity (escrow + income)

noncomputable def storage (target scale error escrow : ℝ) : ℝ :=
  error + reserveDeficit target scale escrow

/-- Income beyond physical capacity remains an explicit exported surplus. -/
noncomputable def overflow (capacity available : ℝ) : ℝ :=
  max 0 (available - capacity)

theorem capacity_balance (capacity available : ℝ) :
    min capacity available + overflow capacity available = available := by
  by_cases h : capacity ≤ available
  · rw [min_eq_left h]
    simp only [overflow, max_eq_right (sub_nonneg.mpr h)]
    ring
  · rw [min_eq_right (le_of_not_ge h)]
    simp only [overflow, max_eq_left (sub_nonpos.mpr (le_of_not_ge h)), add_zero]

theorem solvent_cycle_energy_account {capacity before after work income : ℝ}
    (hbalance : after = min capacity (before - work + income)) :
    after + work + overflow capacity (before - work + income) = before + income := by
  have h := capacity_balance capacity (before - work + income)
  rw [hbalance]
  linarith

theorem reserve_deficit_antitone {target scale before after : ℝ}
    (hscale : 0 < scale) (h : before ≤ after) :
    reserveDeficit target scale after ≤ reserveDeficit target scale before := by
  exact div_le_div_of_nonneg_right
    (max_le_max le_rfl (sub_le_sub_left h target)) hscale.le

theorem reserve_deficit_cap {target scale capacity escrow : ℝ}
    (hcap : target ≤ capacity) :
    reserveDeficit target scale (min capacity escrow) =
      reserveDeficit target scale escrow := by
  by_cases h : capacity ≤ escrow
  · rw [min_eq_left h]
    simp only [reserveDeficit, max_eq_left (sub_nonpos.mpr hcap),
      max_eq_left (sub_nonpos.mpr (hcap.trans h)), zero_div]
  · rw [min_eq_right (le_of_not_ge h)]

theorem replenishment_exact {target scale capacity escrow income : ℝ}
    (hscale : 0 < scale) (hincome : 0 ≤ income) (hcap : target ≤ capacity) :
    reserveDeficit target scale (replenish capacity escrow income) -
        reserveDeficit target scale escrow =
      -min (income / scale) (reserveDeficit target scale escrow) := by
  unfold replenish
  rw [reserve_deficit_cap hcap]
  by_cases hfilled : target ≤ escrow
  · have hfilled' : target ≤ escrow + income := by linarith
    simp only [reserveDeficit, max_eq_left (sub_nonpos.mpr hfilled),
      max_eq_left (sub_nonpos.mpr hfilled'), zero_div, sub_self,
      min_eq_right (div_nonneg hincome hscale.le), neg_zero]
  · have hdef : 0 ≤ target - escrow := by linarith
    by_cases hsmall : escrow + income ≤ target
    · have hnew : 0 ≤ target - (escrow + income) := by linarith
      have hmin : income / scale ≤ reserveDeficit target scale escrow := by
        unfold reserveDeficit
        rw [max_eq_right hdef]
        exact div_le_div_of_nonneg_right (by linarith) hscale.le
      rw [min_eq_left hmin]
      simp only [reserveDeficit, max_eq_right hnew, max_eq_right hdef]
      ring
    · have hnew : target ≤ escrow + income := le_of_not_ge hsmall
      have hmin : reserveDeficit target scale escrow ≤ income / scale := by
        unfold reserveDeficit
        rw [max_eq_right hdef]
        exact div_le_div_of_nonneg_right (by linarith) hscale.le
      rw [min_eq_right hmin]
      simp only [reserveDeficit, max_eq_left (sub_nonpos.mpr hnew), zero_div, zero_sub]

theorem replenishment_nonincrease {target scale capacity escrow income : ℝ}
    (hscale : 0 < scale) (hincome : 0 ≤ income) (hcap : target ≤ capacity) :
    reserveDeficit target scale (replenish capacity escrow income) ≤
      reserveDeficit target scale escrow := by
  have h := replenishment_exact (escrow := escrow) hscale hincome hcap
  have hd : 0 ≤ reserveDeficit target scale escrow :=
    div_nonneg (le_max_left _ _) hscale.le
  have hm : 0 ≤ min (income / scale) (reserveDeficit target scale escrow) :=
    le_min (div_nonneg hincome hscale.le) hd
  linarith

/-- The complete realised work is debited before income; capacity clips only
the resulting storage. A solvent cycle never increases the clipped deficit. -/
theorem solvent_cycle_deficit {target scale capacity before after work income : ℝ}
    (hscale : 0 < scale) (hcap : target ≤ capacity)
    (hbalance : after = min capacity (before - work + income))
    (hsolv : work ≤ income) :
    reserveDeficit target scale after ≤ reserveDeficit target scale before := by
  rw [hbalance, reserve_deficit_cap hcap]
  exact reserve_deficit_antitone hscale (by linarith)

/-- Contraction of the defined storage functional from actual error drift,
actual repair and the complete solvent escrow balance. No linear stroke-IV
descent through the zero-deficit plateau is assumed. -/
theorem cycle_contracts {target scale capacity before after work income
    errorBefore errorDrift errorAfter lam tau eta C : ℝ}
    (hscale : 0 < scale) (hcap : target ≤ capacity)
    (hdrift : errorDrift ≤ errorBefore + lam * tau)
    (hrepair : errorAfter ≤ errorDrift - eta * C)
    (hbalance : after = min capacity (before - work + income))
    (hsolv : work ≤ income) :
    storage target scale errorAfter after - storage target scale errorBefore before ≤
      -(eta * C - lam * tau) := by
  have hd := solvent_cycle_deficit hscale hcap hbalance hsolv
  unfold storage
  linarith

theorem margin_pos {lam tau eta C : ℝ} (hlam : 0 < lam) (htime : tau < eta * C / lam) :
    0 < eta * C - lam * tau := by
  rw [lt_div_iff₀ hlam] at htime
  linarith

theorem lyapunov_iterate (Φ : ℕ → ℝ) {σ : ℝ} (h : ∀ k, Φ (k + 1) ≤ Φ k - σ) :
    ∀ n : ℕ, Φ n ≤ Φ 0 - n * σ := by
  intro n
  induction n with
  | zero => simp
  | succ n ih =>
      have := h n
      push_cast
      linarith

end Snuffy.TheoremEightLyapunov
