/-
Snuffy — Canon Edition 4.2 working: the doubling schedule's transfer bill has a
constant long-run rate, including bounded failed attempts and the full
retained stage history. These are accounting theorems; they do not supply
the physical noisy-state holding certificate.

  * poly_le_two_pow — every polynomial in `n` is at most `C · 2^n`, with `C`
    independent of `n`.
  * transfer_bill_le — per-stage transfer cost `(a + b j)^κ`, polynomial in the
    stage index (so polynomial in the stage code size `n_j`, since `n_j^η` grows
    linearly in `j`), sums over the first `J` stages to at most `C · 2^J`.
  * transfer_bill_linear_in_age — when the first `J` stages cover age `t`
    (`2^J ≤ 2 t`), the summed transfer bill is at most `C t` with the same `C`
    at every age: the transfers add an age-independent constant to the holding
    rate. Every transfer charge is included as supplied; nothing is averaged.
  * retained_prefix_bound — retaining every earlier stage record still costs
    polynomial space in the stage index; no record is discarded.
  * attempt_stage_bound / complete_attempt_bill — the complete nine-account
    invoice and a deterministic attempt cap give the same rate bound.
  * polynomial_stage_bill — a polynomial upper bound on the actual invoice
    suffices, without equating it to a model cost.
  * join_complete_bill — the transfer bill joins the sweep and archive bills
    for every d >= 1. The physical bounds on those bills remain premises.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.StageSchedule
import Snuffy.WorkBilling
import Mathlib.Analysis.SpecificLimits.Normed

open Finset Filter Topology

namespace Snuffy.TransferRate

/-- **A polynomial is at most a constant times `2^n`.** -/
theorem poly_le_two_pow (k : ℕ) : ∃ C : ℝ, ∀ n : ℕ, (n : ℝ) ^ k ≤ C * 2 ^ n := by
  have ht : Tendsto (fun n : ℕ => (n : ℝ) ^ k / (2 : ℝ) ^ n) atTop (𝓝 0) :=
    tendsto_pow_const_div_const_pow_of_one_lt k (by norm_num)
  obtain ⟨C, hC⟩ := ht.bddAbove_range
  refine ⟨C, fun n => ?_⟩
  have h2 : (0 : ℝ) < 2 ^ n := by positivity
  have hle : (n : ℝ) ^ k / 2 ^ n ≤ C := hC ⟨n, rfl⟩
  rwa [div_le_iff₀ h2] at hle

/-- **The summed transfer bill over `J` stages is at most `C · 2^J`.** -/
theorem transfer_bill_le (a b κ : ℕ) :
    ∃ C : ℝ, ∀ J : ℕ, ((∑ j ∈ range J, (a + b * j) ^ κ : ℕ) : ℝ) ≤ C * 2 ^ J := by
  obtain ⟨C, hC⟩ := poly_le_two_pow (κ + 1)
  refine ⟨2 * ((a + b : ℕ) : ℝ) ^ κ * C, fun J => ?_⟩
  have hsum := Snuffy.StageSchedule.stage_cost_le a b κ J
  have hlin : a + b * J ≤ (a + b) * (J + 1) := by nlinarith
  have hnat : J * (a + b * J) ^ κ ≤ (a + b) ^ κ * (J + 1) ^ (κ + 1) := by
    calc J * (a + b * J) ^ κ ≤ (J + 1) * ((a + b) * (J + 1)) ^ κ :=
          Nat.mul_le_mul (Nat.le_succ J) (Nat.pow_le_pow_left hlin κ)
      _ = (a + b) ^ κ * (J + 1) ^ (κ + 1) := by rw [mul_pow, pow_succ]; ring
  have hreal : ((∑ j ∈ range J, (a + b * j) ^ κ : ℕ) : ℝ)
      ≤ ((a + b : ℕ) : ℝ) ^ κ * ((J + 1 : ℕ) : ℝ) ^ (κ + 1) := by
    have := le_trans hsum hnat
    exact_mod_cast this
  have hpow := hC (J + 1)
  have hab : (0 : ℝ) ≤ ((a + b : ℕ) : ℝ) ^ κ := by positivity
  calc ((∑ j ∈ range J, (a + b * j) ^ κ : ℕ) : ℝ)
        ≤ ((a + b : ℕ) : ℝ) ^ κ * ((J + 1 : ℕ) : ℝ) ^ (κ + 1) := hreal
    _ ≤ ((a + b : ℕ) : ℝ) ^ κ * (C * 2 ^ (J + 1)) := mul_le_mul_of_nonneg_left hpow hab
    _ = 2 * ((a + b : ℕ) : ℝ) ^ κ * C * 2 ^ J := by rw [pow_succ]; ring

/-- **The transfer bill is linear in age with an age-independent constant.** -/
theorem transfer_bill_linear_in_age (a b κ : ℕ) :
    ∃ C : ℝ, ∀ (J : ℕ) (t : ℝ), (2 : ℝ) ^ J ≤ 2 * t →
      ((∑ j ∈ range J, (a + b * j) ^ κ : ℕ) : ℝ) ≤ C * t := by
  obtain ⟨C, hC⟩ := transfer_bill_le a b κ
  refine ⟨2 * max C 0, fun J t ht => ?_⟩
  have h1 := hC J
  have hm : C * 2 ^ J ≤ max C 0 * 2 ^ J :=
    mul_le_mul_of_nonneg_right (le_max_left C 0) (by positivity)
  have hm2 : max C 0 * 2 ^ J ≤ max C 0 * (2 * t) :=
    mul_le_mul_of_nonneg_left ht (le_max_right C 0)
  nlinarith

/-- Retain all records through stage j, including failed-attempt records.
A polynomial record bound per stage gives a polynomial bound on the complete
prefix. This does not retire or coarse-grain any protected information. -/
theorem retained_prefix_bound (records : ℕ → ℕ) (a b κ : ℕ)
    (hrecords : ∀ j, records j ≤ (a + b * j) ^ κ) (j : ℕ) :
    (∑ k ∈ range (j + 1), records k) ≤ (a + 1 + (b + 1) * j) ^ (κ + 1) := by
  let B := a + 1 + (b + 1) * j
  have hj : j + 1 ≤ B := by dsimp [B]; nlinarith
  have hk : ∀ k ∈ range (j + 1), a + b * k ≤ B := by
    intro k hk
    have hkj : k ≤ j := Nat.le_of_lt_succ (mem_range.mp hk)
    dsimp [B]
    nlinarith [Nat.mul_le_mul_left b hkj]
  calc
    (∑ k ∈ range (j + 1), records k) ≤ ∑ _k ∈ range (j + 1), B ^ κ :=
      sum_le_sum fun k hmem => (hrecords k).trans (Nat.pow_le_pow_left (hk k hmem) κ)
    _ = (j + 1) * B ^ κ := by simp
    _ ≤ B * B ^ κ := Nat.mul_le_mul_right _ hj
    _ = B ^ (κ + 1) := by rw [pow_succ, Nat.mul_comm]

/-- The invoice counts the entire nine-account charge of every attempt,
including unsuccessful attempts. Bounded attempt count and bounded complete
attempt work give a polynomial stage bound. -/
theorem attempt_stage_bound (charges : ℕ → ℕ → Snuffy.WorkBilling.HandoffCharge)
    (attempts : ℕ → ℕ) (a b κ u v r : ℕ)
    (hcount : ∀ j, attempts j ≤ (u + v * j) ^ r)
    (hcharge : ∀ j k, k < attempts j → (charges j k).total ≤ (a + b * j) ^ κ)
    (j : ℕ) :
    (∑ k ∈ range (attempts j), (charges j k).total) ≤
      (a + u + (b + v) * j) ^ (κ + r) := by
  have ha : a + b * j ≤ a + u + (b + v) * j := by nlinarith
  have hu : u + v * j ≤ a + u + (b + v) * j := by nlinarith
  calc
    (∑ k ∈ range (attempts j), (charges j k).total)
        ≤ ∑ _k ∈ range (attempts j), (a + b * j) ^ κ :=
      sum_le_sum fun k hk => hcharge j k (mem_range.mp hk)
    _ = attempts j * (a + b * j) ^ κ := by simp
    _ ≤ (u + v * j) ^ r * (a + b * j) ^ κ :=
      Nat.mul_le_mul_right _ (hcount j)
    _ ≤ (a + u + (b + v) * j) ^ r * (a + u + (b + v) * j) ^ κ :=
      Nat.mul_le_mul (Nat.pow_le_pow_left hu r) (Nat.pow_le_pow_left ha κ)
    _ = (a + u + (b + v) * j) ^ (κ + r) := by rw [← pow_add]; congr 1; omega

/-- A bound on the actual complete stage bill, rather than equality with a
polynomial model, is sufficient for the age-independent rate. -/
theorem polynomial_stage_bill (cost : ℕ → ℕ) (a b κ : ℕ)
    (hcost : ∀ j, cost j ≤ (a + b * j) ^ κ) :
    ∃ C : ℝ, ∀ (J : ℕ) (t : ℝ), (2 : ℝ) ^ J ≤ 2 * t →
      ((∑ j ∈ range J, cost j : ℕ) : ℝ) ≤ C * t := by
  obtain ⟨C, hC⟩ := transfer_bill_linear_in_age a b κ
  refine ⟨C, fun J t ht => ?_⟩
  have hsum : (∑ j ∈ range J, cost j) ≤ ∑ j ∈ range J, (a + b * j) ^ κ :=
    sum_le_sum fun j _ => hcost j
  have hreal : ((∑ j ∈ range J, cost j : ℕ) : ℝ) ≤
      ((∑ j ∈ range J, (a + b * j) ^ κ : ℕ) : ℝ) := by exact_mod_cast hsum
  exact hreal.trans (hC J t ht)

/-- All admitted attempt costs, successful or failed, retain a uniform
linear-in-age bound. No expected retry count is substituted. -/
theorem complete_attempt_bill (charges : ℕ → ℕ → Snuffy.WorkBilling.HandoffCharge)
    (attempts : ℕ → ℕ) (a b κ u v r : ℕ)
    (hcount : ∀ j, attempts j ≤ (u + v * j) ^ r)
    (hcharge : ∀ j k, k < attempts j → (charges j k).total ≤ (a + b * j) ^ κ) :
    ∃ C : ℝ, ∀ (J : ℕ) (t : ℝ), (2 : ℝ) ^ J ≤ 2 * t →
      ((∑ j ∈ range J, ∑ k ∈ range (attempts j), (charges j k).total : ℕ) : ℝ) ≤ C * t :=
  polynomial_stage_bill _ (a + u) (b + v) (κ + r)
    (attempt_stage_bound charges attempts a b κ u v r hcount hcharge)

/-- The linear transfer/attempt bill joins the sweep and archive bills for
every d>=1, including d=1. Holding remains an explicit separate account. -/
theorem join_complete_bill {sweep archive transfer Cs Ca Ct t : ℝ} {d : ℕ}
    (ht : 1 ≤ t) (hd : 1 ≤ d) (hCt : 0 ≤ Ct)
    (hsweep : sweep ≤ Cs * t ^ d) (harchive : archive ≤ Ca * t ^ d)
    (htransfer : transfer ≤ Ct * t) :
    sweep + archive + transfer ≤ (Cs + Ca + Ct) * t ^ d := by
  have hpow : t ≤ t ^ d :=
    le_self_pow₀ ht (Nat.ne_of_gt (lt_of_lt_of_le Nat.zero_lt_one hd))
  have htrans := htransfer.trans (mul_le_mul_of_nonneg_left hpow hCt)
  calc
    sweep + archive + transfer ≤ Cs * t ^ d + Ca * t ^ d + Ct * t ^ d :=
      add_le_add (add_le_add hsweep harchive) htrans
    _ = (Cs + Ca + Ct) * t ^ d := by ring

end Snuffy.TransferRate
