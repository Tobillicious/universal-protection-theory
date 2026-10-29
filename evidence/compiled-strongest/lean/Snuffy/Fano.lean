/-
Snuffy — Canon Edition v4.1: Fano's inequality and the required information
of a successful recovery, machine-checked (working argument §11).

For a finite message W with M ≥ 2 values, a finite observation Y, a joint law
`p : W → Y → ℝ` and any decoder `g : Y → W` with error probability ε:

  * max_entropy — Σ −a ln a ≤ ln |S| for a probability vector on S (Jensen).
  * fano_single — H(q) ≤ h₂(1 − q(w₀)) + (1 − q(w₀)) ln(M − 1).
  * fano — H(W | Y) ≤ h₂(ε) + ε ln(M − 1).
  * mi_eq_ent_sub_condEnt — I(W : Y) = H(W) − H(W | Y).
  * required_information — I(W : Y) ≥ H(W) − h₂(ε) − ε ln(M − 1) = Δ₀:
    every successful recovery needs at least Δ₀ nats through the channel.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.FiniteInformation
import Mathlib.Analysis.SpecialFunctions.BinaryEntropy

open Finset Real

namespace Snuffy.Fano

open Snuffy.FiniteInformation

/-! ## Maximum entropy -/

/-- **Maximum entropy.** A probability vector on a nonempty finite set `S` has
entropy at most `ln |S|`. -/
theorem max_entropy {ι : Type*} (S : Finset ι) (hS : S.Nonempty) (a : ι → ℝ)
    (ha : ∀ i ∈ S, 0 ≤ a i) (hsum : ∑ i ∈ S, a i = 1) :
    ∑ i ∈ S, negMulLog (a i) ≤ Real.log S.card := by
  have hk : (0 : ℝ) < S.card := by exact_mod_cast hS.card_pos
  have hj := concaveOn_negMulLog.le_map_sum (t := S) (w := fun _ => 1 / (S.card : ℝ)) (p := a)
    (fun i _ => by positivity) (by rw [sum_const, nsmul_eq_mul]; field_simp)
    (fun i hi => Set.mem_Ici.mpr (ha i hi))
  simp only [smul_eq_mul, ← mul_sum, hsum, mul_one] at hj
  have hval : negMulLog (1 / (S.card : ℝ)) = 1 / S.card * Real.log S.card := by
    rw [negMulLog, one_div, Real.log_inv]; ring
  rw [hval] at hj
  exact le_of_mul_le_mul_left hj (by positivity)

/-! ## Fano for a single observation -/

variable {W : Type*} [Fintype W] [DecidableEq W]

/-- **Fano, single observation.** Guessing `w₀` errs with probability
`ε = 1 − q(w₀)`, and then `H(q) ≤ h₂(ε) + ε ln(M − 1)`. -/
theorem fano_single (q : W → ℝ) (hq : ∀ w, 0 ≤ q w) (hsum : ∑ w, q w = 1) (w₀ : W)
    (hM : 2 ≤ Fintype.card W) :
    ∑ w, negMulLog (q w) ≤ binEntropy (1 - q w₀) + (1 - q w₀) * Real.log (Fintype.card W - 1) := by
  set S := univ.erase w₀
  have hsplit : ∀ f : W → ℝ, ∑ w, f w = f w₀ + ∑ w ∈ S, f w := fun f =>
    (add_sum_erase univ f (mem_univ w₀)).symm
  have hε : ∑ w ∈ S, q w = 1 - q w₀ := by
    have := hsplit q; rw [hsum] at this; linarith
  have hScard : (S.card : ℝ) = Fintype.card W - 1 := by
    rw [card_erase_of_mem (mem_univ w₀), card_univ, Nat.cast_sub (by omega), Nat.cast_one]
  rw [hsplit (fun w => negMulLog (q w)), binEntropy_eq_negMulLog_add_negMulLog_one_sub,
    sub_sub_cancel]
  set ε := 1 - q w₀
  by_cases hε0 : ε = 0
  · have hz : ∀ w ∈ S, q w = 0 :=
      (sum_eq_zero_iff_of_nonneg fun w _ => hq w).mp (hε ▸ hε0)
    have hS0 : ∑ w ∈ S, negMulLog (q w) = 0 :=
      sum_eq_zero fun w hw => by rw [hz w hw, negMulLog_zero]
    rw [hS0, hε0, negMulLog_zero]
    simp
  · have hεpos : 0 < ε := lt_of_le_of_ne (hε ▸ sum_nonneg fun w _ => hq w) (Ne.symm hε0)
    have hSne : S.Nonempty := by
      rw [← card_pos, card_erase_of_mem (mem_univ w₀), card_univ]; omega
    have hterm : ∀ w ∈ S, negMulLog (q w)
        = q w / ε * negMulLog ε + ε * negMulLog (q w / ε) := by
      intro w _
      rw [← negMulLog_mul, mul_div_cancel₀ _ hε0]
    rw [sum_congr rfl hterm, sum_add_distrib, ← sum_mul, ← mul_sum, ← sum_div, hε,
      div_self hε0, one_mul]
    have hmax := max_entropy S hSne (fun w => q w / ε) (fun w _ => div_nonneg (hq w) hεpos.le)
      (by rw [← sum_div, hε, div_self hε0])
    rw [hScard] at hmax
    have := mul_le_mul_of_nonneg_left hmax hεpos.le
    linarith

/-! ## Conditional entropy and Fano -/

variable {Y : Type*} [Fintype Y]

/-- Conditional entropy `H(W | Y)` of a joint law `p : W → Y → ℝ`. -/
noncomputable def condEnt (p : W → Y → ℝ) : ℝ :=
  ∑ y, margY p y * ∑ w, negMulLog (p w y / margY p y)

/-- Entropy `H(W)` of the message marginal. -/
noncomputable def entW (p : W → Y → ℝ) : ℝ := ∑ w, negMulLog (margH p w)

/-- **Fano's inequality.** For any decoder `g`, with error probability
`ε = 1 − Σ_y p(g y, y)`, `H(W | Y) ≤ h₂(ε) + ε ln(M − 1)`. -/
theorem fano (p : W → Y → ℝ) (hp : ∀ w y, 0 ≤ p w y) (hp1 : ∑ w, ∑ y, p w y = 1)
    (g : Y → W) (hM : 2 ≤ Fintype.card W) :
    condEnt p ≤ binEntropy (1 - ∑ y, p (g y) y)
      + (1 - ∑ y, p (g y) y) * Real.log (Fintype.card W - 1) := by
  set L := Real.log (Fintype.card W - 1)
  have hmY : ∀ y, 0 ≤ margY p y := fun y => sum_nonneg fun w _ => hp w y
  have hle : ∀ w y, p w y ≤ margY p y := fun w y =>
    single_le_sum (f := fun w => p w y) (fun w _ => hp w y) (mem_univ w)
  have hmY1 : ∑ y, margY p y = 1 := by unfold margY; rw [sum_comm]; exact hp1
  set e : Y → ℝ := fun y => 1 - p (g y) y / margY p y
  have he01 : ∀ y, e y ∈ Set.Icc (0 : ℝ) 1 := by
    intro y
    by_cases hy : margY p y = 0
    · simp [e, hy]
    · have hpos : 0 < margY p y := lt_of_le_of_ne (hmY y) (Ne.symm hy)
      have h1 : p (g y) y / margY p y ≤ 1 := (div_le_one hpos).mpr (hle _ _)
      have h2 : 0 ≤ p (g y) y / margY p y := div_nonneg (hp _ _) hpos.le
      exact ⟨by simp only [e]; linarith, by simp only [e]; linarith⟩
  -- per-observation Fano
  have hper : ∀ y, margY p y * ∑ w, negMulLog (p w y / margY p y)
      ≤ margY p y * (binEntropy (e y) + e y * L) := by
    intro y
    by_cases hy : margY p y = 0
    · rw [hy, zero_mul, zero_mul]
    · have hpos : 0 < margY p y := lt_of_le_of_ne (hmY y) (Ne.symm hy)
      apply mul_le_mul_of_nonneg_left _ hpos.le
      exact fano_single (fun w => p w y / margY p y) (fun w => div_nonneg (hp w y) hpos.le)
        (by rw [← sum_div]; exact div_self hy) (g y) hM
  have hεsum : ∑ y, margY p y * e y = 1 - ∑ y, p (g y) y := by
    have : ∀ y, margY p y * e y = margY p y - p (g y) y := by
      intro y
      by_cases hy : margY p y = 0
      · have : p (g y) y = 0 := le_antisymm (hy ▸ hle _ _) (hp _ _)
        simp [e, hy, this]
      · simp only [e]; field_simp
    rw [sum_congr rfl fun y _ => this y, sum_sub_distrib, hmY1]
  have hconc := strictConcave_binEntropy.concaveOn.le_map_sum (t := univ) (w := margY p) (p := e)
    (fun y _ => hmY y) hmY1 (fun y _ => he01 y)
  simp only [smul_eq_mul] at hconc
  rw [hεsum] at hconc
  calc condEnt p ≤ ∑ y, margY p y * (binEntropy (e y) + e y * L) := sum_le_sum fun y _ => hper y
    _ = ∑ y, margY p y * binEntropy (e y) + (∑ y, margY p y * e y) * L := by
        rw [sum_mul, ← sum_add_distrib]; exact sum_congr rfl fun y _ => by ring
    _ ≤ binEntropy (1 - ∑ y, p (g y) y) + (1 - ∑ y, p (g y) y) * L := by
        rw [hεsum]; linarith

/-! ## Mutual information and the required information -/

omit [DecidableEq W] in
/-- **I(W : Y) = H(W) − H(W | Y).** -/
theorem mi_eq_ent_sub_condEnt (p : W → Y → ℝ) (hp : ∀ w y, 0 ≤ p w y) :
    mi p = entW p - condEnt p := by
  have hleH : ∀ w y, p w y ≤ margH p w := fun w y =>
    single_le_sum (fun y _ => hp w y) (mem_univ y)
  have hleY : ∀ w y, p w y ≤ margY p y := fun w y =>
    single_le_sum (f := fun w => p w y) (fun w _ => hp w y) (mem_univ w)
  have hcond : condEnt p = ∑ w, ∑ y, -(p w y * Real.log (p w y / margY p y)) := by
    unfold condEnt
    rw [sum_comm]
    refine sum_congr rfl fun y _ => ?_
    rw [mul_sum]
    refine sum_congr rfl fun w _ => ?_
    by_cases hy : margY p y = 0
    · have : p w y = 0 := le_antisymm (hy ▸ hleY w y) (hp w y)
      simp [hy, this]
    · rw [negMulLog]; field_simp
  have hent : entW p = ∑ w, ∑ y, -(p w y * Real.log (margH p w)) := by
    unfold entW
    refine sum_congr rfl fun w _ => ?_
    unfold negMulLog margH
    rw [sum_neg_distrib, ← sum_mul]
    ring
  rw [hcond, hent, ← sum_sub_distrib]
  unfold mi
  refine sum_congr rfl fun w _ => ?_
  rw [← sum_sub_distrib]
  refine sum_congr rfl fun y _ => ?_
  by_cases h0 : p w y = 0
  · simp [h0]
  · have hpos : 0 < p w y := lt_of_le_of_ne (hp w y) (Ne.symm h0)
    have hH : 0 < margH p w := lt_of_lt_of_le hpos (hleH w y)
    have hY : 0 < margY p y := lt_of_lt_of_le hpos (hleY w y)
    rw [Real.log_div h0 (mul_pos hH hY).ne', Real.log_mul hH.ne' hY.ne',
      Real.log_div h0 hY.ne']
    ring

/-- **Required information (§11).** Every decoder with error probability `ε`
on an `M`-valued message receives at least
`Δ₀ = H(W) − h₂(ε) − ε ln(M − 1)` nats. -/
theorem required_information (p : W → Y → ℝ) (hp : ∀ w y, 0 ≤ p w y)
    (hp1 : ∑ w, ∑ y, p w y = 1) (g : Y → W) (hM : 2 ≤ Fintype.card W) :
    entW p - binEntropy (1 - ∑ y, p (g y) y)
      - (1 - ∑ y, p (g y) y) * Real.log (Fintype.card W - 1) ≤ mi p := by
  rw [mi_eq_ent_sub_condEnt p hp]
  have := fano p hp hp1 g hM
  linarith

end Snuffy.Fano
