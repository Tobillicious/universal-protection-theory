/-
Snuffy — Canon Edition v4.1: the Lie–Trotter product formula with explicit
error, machine-checked — premise 2 (Church–Turing–Deutsch) reduced to Lloyd's
simulation theorem for bounded local Hamiltonians (Section 17; premise floor).

In a complete normed ℝ-algebra with ‖1‖ = 1 (bounded operators on a finite-
dimensional or Hilbert space, matrices):

  * norm_exp_le — ‖eˣ‖ ≤ e^‖x‖.
  * norm_exp_sub_one_sub_le — ‖eˣ − 1 − x‖ ≤ (‖x‖²/2) e^‖x‖.
  * norm_exp_mul_exp_sub — one-step error ‖eᵃeᵇ − e^(a+b)‖ ≤ 3 s² e^(2s),
    s = ‖a‖ + ‖b‖.
  * norm_exp_sum_sub_prod — k terms: ‖e^(Σ aⱼ) − Π e^(aⱼ)‖ ≤ 3 k s² e^(2s).
  * trotter_bound — ‖e^(Σ aⱼ) − (Π e^(aⱼ/n))ⁿ‖ ≤ 3 k s² e^(3s) / n.
  * trotter_tendsto — the Trotter products converge to e^(Σ aⱼ).
  * lloyd_simulation — for every ε > 0 a finite number of Trotter steps
    n = ⌈3 k s² e^(3s) / ε⌉ simulates the evolution to error ε: the overhead is
    explicit and polynomial in k, s and 1/ε.

With aⱼ = −i t Hⱼ/ħ for the local terms of H = Σ Hⱼ, every local Hamiltonian
evolution is a finite product of local evolutions to any precision; what
premise 2 then still declares is only that a universal simulator implements
each local factor (a universal gate set).

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.Analysis.Normed.Algebra.Exponential
import Mathlib.Analysis.SpecialFunctions.Exponential
import Mathlib.Analysis.SpecificLimits.Basic

open NormedSpace Filter Finset
open scoped Nat

namespace Snuffy.Trotter

variable {𝔸 : Type*} [NormedRing 𝔸] [NormedAlgebra ℝ 𝔸] [NormOneClass 𝔸] [CompleteSpace 𝔸]

/-! ## Series bounds for the exponential -/

omit [NormOneClass 𝔸] in
private lemma hasSum_exp (x : 𝔸) : HasSum (fun n => ((n !)⁻¹ : ℝ) • x ^ n) (exp x) :=
  exp_series_hasSum_exp' (𝕂 := ℝ) x

private lemma hasSum_rexp (r : ℝ) : HasSum (fun n => ((n !)⁻¹ : ℝ) * r ^ n) (Real.exp r) := by
  have h := exp_series_hasSum_exp' (𝕂 := ℝ) (𝔸 := ℝ) r
  rw [← Real.exp_eq_exp_ℝ] at h
  simpa only [smul_eq_mul] using h

omit [CompleteSpace 𝔸] in
private lemma norm_term_le (x : 𝔸) (n : ℕ) :
    ‖((n !)⁻¹ : ℝ) • x ^ n‖ ≤ ((n !)⁻¹ : ℝ) * ‖x‖ ^ n := by
  rw [norm_smul, Real.norm_of_nonneg (by positivity)]
  exact mul_le_mul_of_nonneg_left (norm_pow_le x n) (by positivity)

/-- `‖eˣ‖ ≤ e^‖x‖`. -/
theorem norm_exp_le (x : 𝔸) : ‖exp x‖ ≤ Real.exp ‖x‖ :=
  (hasSum_exp x).norm_le_of_bounded (hasSum_rexp ‖x‖) (norm_term_le x)

private lemma norm_exp_sub_one_sub_le_rexp (x : 𝔸) :
    ‖exp x - 1 - x‖ ≤ Real.exp ‖x‖ - 1 - ‖x‖ := by
  have h1 := (hasSum_nat_add_iff' 2).mpr (hasSum_exp x)
  have h2 := (hasSum_nat_add_iff' 2).mpr (hasSum_rexp ‖x‖)
  have h := h1.norm_le_of_bounded h2 (fun n => norm_term_le x (n + 2))
  simp only [sum_range_succ, sum_range_zero, zero_add, Nat.factorial_zero, Nat.factorial_one,
    Nat.cast_one, inv_one, pow_zero, pow_one, one_smul, one_mul] at h
  rwa [sub_add_eq_sub_sub, sub_add_eq_sub_sub] at h

private lemma rexp_sub_one_sub_le {r : ℝ} (hr : 0 ≤ r) :
    Real.exp r - 1 - r ≤ r ^ 2 / 2 * Real.exp r := by
  have h2 := (hasSum_nat_add_iff' 2).mpr (hasSum_rexp r)
  have h3 := (hasSum_rexp r).mul_left (r ^ 2 / 2)
  have hle : ∀ n : ℕ, (((n + 2) !)⁻¹ : ℝ) * r ^ (n + 2) ≤ r ^ 2 / 2 * (((n !)⁻¹ : ℝ) * r ^ n) := by
    intro n
    have hfac : (2 : ℝ) * n ! ≤ ((n + 2) ! : ℝ) := by
      have : 2 * n ! ≤ (n + 2) ! := by
        rw [Nat.factorial_succ, Nat.factorial_succ]
        have h2 : 2 ≤ (n + 1 + 1) * (n + 1) := by nlinarith
        calc 2 * n ! ≤ ((n + 1 + 1) * (n + 1)) * n ! := Nat.mul_le_mul_right _ h2
          _ = (n + 1 + 1) * ((n + 1) * n !) := by ring
      exact_mod_cast this
    have hpos : (0 : ℝ) < n ! := by exact_mod_cast Nat.factorial_pos n
    calc (((n + 2) !)⁻¹ : ℝ) * r ^ (n + 2) = (r ^ 2 * r ^ n) / ((n + 2) ! : ℝ) := by
          rw [pow_add]; ring
      _ ≤ (r ^ 2 * r ^ n) / (2 * n ! : ℝ) :=
          div_le_div_of_nonneg_left (by positivity) (by positivity) hfac
      _ = r ^ 2 / 2 * (((n !)⁻¹ : ℝ) * r ^ n) := by field_simp
  have h := hasSum_le hle h2 h3
  simp only [sum_range_succ, sum_range_zero, zero_add, Nat.factorial_zero, Nat.factorial_one,
    Nat.cast_one, inv_one, pow_zero, pow_one, one_mul] at h
  linarith

/-- `‖eˣ − 1 − x‖ ≤ (‖x‖²/2) e^‖x‖`. -/
theorem norm_exp_sub_one_sub_le (x : 𝔸) : ‖exp x - 1 - x‖ ≤ ‖x‖ ^ 2 / 2 * Real.exp ‖x‖ :=
  (norm_exp_sub_one_sub_le_rexp x).trans (rexp_sub_one_sub_le (norm_nonneg x))

/-- `t ↦ t² e^(2t)` is monotone on `t ≥ 0`. -/
private lemma g_mono {t u : ℝ} (ht : 0 ≤ t) (htu : t ≤ u) :
    t ^ 2 * Real.exp (2 * t) ≤ u ^ 2 * Real.exp (2 * u) :=
  mul_le_mul (pow_le_pow_left₀ ht htu 2) (Real.exp_le_exp.mpr (by linarith))
    (Real.exp_pos _).le (by positivity)

/-! ## The one-step product error -/

/-- **One-step error.** `‖eᵃeᵇ − e^(a+b)‖ ≤ 3 s² e^(2s)`, `s = ‖a‖ + ‖b‖`. -/
theorem norm_exp_mul_exp_sub (a b : 𝔸) :
    ‖exp a * exp b - exp (a + b)‖ ≤ 3 * (‖a‖ + ‖b‖) ^ 2 * Real.exp (2 * (‖a‖ + ‖b‖)) := by
  set α := ‖a‖
  set β := ‖b‖
  set s := α + β
  have hα : 0 ≤ α := norm_nonneg a
  have hβ : 0 ≤ β := norm_nonneg b
  have hs : 0 ≤ s := by positivity
  have hid : exp a * exp b - exp (a + b)
      = (exp a - 1 - a) * exp b + (1 + a) * (exp b - 1 - b) + a * b
        - (exp (a + b) - 1 - (a + b)) := by noncomm_ring
  have hEs : Real.exp α * Real.exp β = Real.exp s := (Real.exp_add α β).symm
  have hs2 : Real.exp s ≤ Real.exp (2 * s) := Real.exp_le_exp.mpr (by linarith)
  have h1 : 1 ≤ Real.exp (2 * s) := Real.one_le_exp (by linarith)
  have hα2 : α ^ 2 ≤ s ^ 2 := pow_le_pow_left₀ hα (by linarith) 2
  have hβ2 : β ^ 2 ≤ s ^ 2 := pow_le_pow_left₀ hβ (by linarith) 2
  have hexpα := Real.exp_pos α
  have hexpβ := Real.exp_pos β
  have T1 : ‖(exp a - 1 - a) * exp b‖ ≤ s ^ 2 / 2 * Real.exp (2 * s) := by
    calc ‖(exp a - 1 - a) * exp b‖ ≤ ‖exp a - 1 - a‖ * ‖exp b‖ := norm_mul_le _ _
      _ ≤ (α ^ 2 / 2 * Real.exp α) * Real.exp β :=
          mul_le_mul (norm_exp_sub_one_sub_le a) (norm_exp_le b) (norm_nonneg _) (by positivity)
      _ = α ^ 2 / 2 * Real.exp s := by rw [← hEs]; ring
      _ ≤ s ^ 2 / 2 * Real.exp (2 * s) := by gcongr
  have T2 : ‖(1 + a) * (exp b - 1 - b)‖ ≤ s ^ 2 / 2 * Real.exp (2 * s) := by
    have h1a : ‖(1 : 𝔸) + a‖ ≤ Real.exp α := by
      calc ‖(1 : 𝔸) + a‖ ≤ ‖(1 : 𝔸)‖ + ‖a‖ := norm_add_le _ _
        _ = α + 1 := by rw [norm_one]; ring
        _ ≤ Real.exp α := Real.add_one_le_exp α
    calc ‖(1 + a) * (exp b - 1 - b)‖ ≤ ‖(1 : 𝔸) + a‖ * ‖exp b - 1 - b‖ := norm_mul_le _ _
      _ ≤ Real.exp α * (β ^ 2 / 2 * Real.exp β) :=
          mul_le_mul h1a (norm_exp_sub_one_sub_le b) (norm_nonneg _) (by positivity)
      _ = β ^ 2 / 2 * Real.exp s := by rw [← hEs]; ring
      _ ≤ s ^ 2 / 2 * Real.exp (2 * s) := by gcongr
  have T3 : ‖a * b‖ ≤ s ^ 2 * Real.exp (2 * s) := by
    calc ‖a * b‖ ≤ α * β := norm_mul_le _ _
      _ ≤ s ^ 2 := by nlinarith
      _ ≤ s ^ 2 * Real.exp (2 * s) := le_mul_of_one_le_right (by positivity) h1
  have T4 : ‖exp (a + b) - 1 - (a + b)‖ ≤ s ^ 2 / 2 * Real.exp (2 * s) := by
    have hab : ‖a + b‖ ≤ s := norm_add_le a b
    calc ‖exp (a + b) - 1 - (a + b)‖ ≤ ‖a + b‖ ^ 2 / 2 * Real.exp ‖a + b‖ :=
          norm_exp_sub_one_sub_le _
      _ ≤ s ^ 2 / 2 * Real.exp s := by
          gcongr
      _ ≤ s ^ 2 / 2 * Real.exp (2 * s) := by gcongr
  rw [hid]
  calc ‖(exp a - 1 - a) * exp b + (1 + a) * (exp b - 1 - b) + a * b
        - (exp (a + b) - 1 - (a + b))‖
      ≤ ‖(exp a - 1 - a) * exp b‖ + ‖(1 + a) * (exp b - 1 - b)‖ + ‖a * b‖
        + ‖exp (a + b) - 1 - (a + b)‖ := by
        refine (norm_sub_le _ _).trans ?_
        gcongr
        refine (norm_add_le _ _).trans ?_
        gcongr
        exact norm_add_le _ _
    _ ≤ 3 * s ^ 2 * Real.exp (2 * s) := by
        have hX : 0 ≤ s ^ 2 * Real.exp (2 * s) := by positivity
        linarith

/-! ## k terms -/

omit [NormedAlgebra ℝ 𝔸] [NormOneClass 𝔸] [CompleteSpace 𝔸] in
private lemma norm_list_sum_le (l : List 𝔸) : ‖l.sum‖ ≤ (l.map norm).sum := by
  induction l with
  | nil => simp
  | cons a l ih =>
    simp only [List.sum_cons, List.map_cons]
    exact (norm_add_le _ _).trans (by linarith)

omit [NormedAlgebra ℝ 𝔸] [NormOneClass 𝔸] [CompleteSpace 𝔸] in
private lemma list_norm_sum_nonneg (l : List 𝔸) : 0 ≤ (l.map norm).sum :=
  List.sum_nonneg (by simp)

private lemma norm_list_prod_exp_le (l : List 𝔸) :
    ‖(l.map exp).prod‖ ≤ Real.exp (l.map norm).sum := by
  induction l with
  | nil => simp
  | cons a l ih =>
    simp only [List.map_cons, List.prod_cons, List.sum_cons, Real.exp_add]
    exact (norm_mul_le _ _).trans
      (mul_le_mul (norm_exp_le a) ih (norm_nonneg _) (Real.exp_pos _).le)

/-- **k-term one-step error.** `‖e^(Σ aⱼ) − Π e^(aⱼ)‖ ≤ 3 k s² e^(2s)`. -/
theorem norm_exp_sum_sub_prod : ∀ l : List 𝔸,
    ‖exp l.sum - (l.map exp).prod‖
      ≤ 3 * l.length * (l.map norm).sum ^ 2 * Real.exp (2 * (l.map norm).sum)
  | [] => by simp [exp_zero]
  | a :: l => by
    have ih := norm_exp_sum_sub_prod l
    simp only [List.sum_cons, List.map_cons, List.prod_cons, List.length_cons]
    set S := l.sum
    set P := (l.map exp).prod
    set sr := (l.map norm).sum
    set α := ‖a‖
    have hα : 0 ≤ α := norm_nonneg a
    have hsr : 0 ≤ sr := list_norm_sum_nonneg l
    have hS : ‖S‖ ≤ sr := norm_list_sum_le l
    have hsplit : exp (a + S) - exp a * P
        = -(exp a * exp S - exp (a + S)) + exp a * (exp S - P) := by noncomm_ring
    have hA : ‖exp a * exp S - exp (a + S)‖ ≤ 3 * (α + sr) ^ 2 * Real.exp (2 * (α + sr)) := by
      calc ‖exp a * exp S - exp (a + S)‖ ≤ 3 * (α + ‖S‖) ^ 2 * Real.exp (2 * (α + ‖S‖)) :=
            norm_exp_mul_exp_sub a S
        _ ≤ 3 * (α + sr) ^ 2 * Real.exp (2 * (α + sr)) := by
            have := g_mono (t := α + ‖S‖) (u := α + sr) (by positivity) (by linarith)
            linarith
    have hB : ‖exp a * (exp S - P)‖ ≤ 3 * l.length * (α + sr) ^ 2 * Real.exp (2 * (α + sr)) := by
      have hsr2 : sr ^ 2 ≤ (α + sr) ^ 2 := pow_le_pow_left₀ hsr (by linarith) 2
      have hexp : Real.exp α * Real.exp (2 * sr) ≤ Real.exp (2 * (α + sr)) := by
        rw [← Real.exp_add]; exact Real.exp_le_exp.mpr (by linarith)
      have hlen : (0 : ℝ) ≤ l.length := by positivity
      calc ‖exp a * (exp S - P)‖ ≤ ‖exp a‖ * ‖exp S - P‖ := norm_mul_le _ _
        _ ≤ Real.exp α * (3 * l.length * sr ^ 2 * Real.exp (2 * sr)) :=
            mul_le_mul (norm_exp_le a) ih (norm_nonneg _) (Real.exp_pos _).le
        _ = 3 * l.length * sr ^ 2 * (Real.exp α * Real.exp (2 * sr)) := by ring
        _ ≤ 3 * l.length * (α + sr) ^ 2 * Real.exp (2 * (α + sr)) := by
            have h3 : 0 ≤ 3 * (l.length : ℝ) := by positivity
            have hE : 0 ≤ Real.exp α * Real.exp (2 * sr) := by positivity
            calc 3 * (l.length : ℝ) * sr ^ 2 * (Real.exp α * Real.exp (2 * sr))
                ≤ 3 * l.length * (α + sr) ^ 2 * (Real.exp α * Real.exp (2 * sr)) := by
                  gcongr
              _ ≤ 3 * l.length * (α + sr) ^ 2 * Real.exp (2 * (α + sr)) := by
                  gcongr
    rw [hsplit]
    calc ‖-(exp a * exp S - exp (a + S)) + exp a * (exp S - P)‖
        ≤ ‖exp a * exp S - exp (a + S)‖ + ‖exp a * (exp S - P)‖ := by
          refine (norm_add_le _ _).trans ?_
          rw [norm_neg]
      _ ≤ 3 * (α + sr) ^ 2 * Real.exp (2 * (α + sr))
          + 3 * l.length * (α + sr) ^ 2 * Real.exp (2 * (α + sr)) := add_le_add hA hB
      _ = 3 * ((l.length + 1 : ℕ) : ℝ) * (α + sr) ^ 2 * Real.exp (2 * (α + sr)) := by
          push_cast; ring

/-! ## Telescoping and the Trotter formula -/

omit [NormOneClass 𝔸] [CompleteSpace 𝔸] in
private lemma list_sum_smul (c : ℝ) (l : List 𝔸) :
    (l.map fun a => c • a).sum = c • l.sum := by
  induction l with
  | nil => simp
  | cons a l ih => simp only [List.map_cons, List.sum_cons, ih, smul_add]

omit [NormOneClass 𝔸] [CompleteSpace 𝔸] in
private lemma list_norm_smul {c : ℝ} (hc : 0 ≤ c) (l : List 𝔸) :
    ((l.map fun a => c • a).map norm).sum = c * (l.map norm).sum := by
  induction l with
  | nil => simp
  | cons a l ih =>
    simp only [List.map_cons, List.sum_cons, ih, norm_smul, Real.norm_of_nonneg hc]
    ring

omit [NormedAlgebra ℝ 𝔸] [CompleteSpace 𝔸] in
private lemma pow_sub_pow_le (X Y : 𝔸) {q δ : ℝ} (hq : 1 ≤ q) (hX : ‖X‖ ≤ q) (hY : ‖Y‖ ≤ q)
    (hδ : ‖X - Y‖ ≤ δ) : ∀ n : ℕ, ‖X ^ n - Y ^ n‖ ≤ n * q ^ n * δ := by
  have hδ0 : 0 ≤ δ := (norm_nonneg _).trans hδ
  intro n
  induction n with
  | zero => simp
  | succ n ih =>
    have hsplit : X ^ (n + 1) - Y ^ (n + 1) = X * (X ^ n - Y ^ n) + (X - Y) * Y ^ n := by
      rw [pow_succ', pow_succ']; noncomm_ring
    have hYn : ‖Y ^ n‖ ≤ q ^ n := (norm_pow_le Y n).trans (pow_le_pow_left₀ (norm_nonneg _) hY n)
    have hqn : 1 ≤ q ^ n := one_le_pow₀ hq
    rw [hsplit]
    calc ‖X * (X ^ n - Y ^ n) + (X - Y) * Y ^ n‖
        ≤ ‖X‖ * ‖X ^ n - Y ^ n‖ + ‖X - Y‖ * ‖Y ^ n‖ :=
          (norm_add_le _ _).trans (add_le_add (norm_mul_le _ _) (norm_mul_le _ _))
      _ ≤ q * (n * q ^ n * δ) + δ * q ^ n := by
          gcongr
      _ ≤ (n + 1 : ℕ) * q ^ (n + 1) * δ := by
          push_cast
          rw [pow_succ]
          nlinarith [mul_nonneg (mul_nonneg (by positivity : (0:ℝ) ≤ q ^ n) hδ0)
            (by linarith : (0:ℝ) ≤ q - 1)]

/-- **Trotter bound.** For a list of `k` terms with total norm `s` and `n ≥ 1`,
`‖e^(Σ aⱼ) − (Π e^(aⱼ/n))ⁿ‖ ≤ 3 k s² e^(3s) / n`. -/
theorem trotter_bound (l : List 𝔸) {n : ℕ} (hn : 0 < n) :
    ‖exp l.sum - ((l.map fun a => exp ((n : ℝ)⁻¹ • a)).prod) ^ n‖
      ≤ 3 * l.length * (l.map norm).sum ^ 2 * Real.exp (3 * (l.map norm).sum) / n := by
  set s := (l.map norm).sum
  have hs : 0 ≤ s := list_norm_sum_nonneg l
  have hnR : (0 : ℝ) < n := by exact_mod_cast hn
  set l' := l.map fun a => (n : ℝ)⁻¹ • a
  have hl'sum : l'.sum = (n : ℝ)⁻¹ • l.sum := list_sum_smul _ l
  have hl'norm : (l'.map norm).sum = s / n := by
    rw [list_norm_smul (inv_nonneg.mpr hnR.le) l, div_eq_inv_mul]
  have hl'len : l'.length = l.length := by simp [l']
  set X := exp ((n : ℝ)⁻¹ • l.sum)
  set Y := (l'.map exp).prod
  have hYdef : (l.map fun a => exp ((n : ℝ)⁻¹ • a)).prod = Y := by
    simp only [Y, l', List.map_map]
    rfl
  have hXn : X ^ n = exp l.sum := by
    have hpow : ∀ m : ℕ, exp ((m : ℝ) • ((n : ℝ)⁻¹ • l.sum)) = X ^ m := by
      intro m
      induction m with
      | zero => simp [exp_zero]
      | succ m ih =>
        rw [Nat.cast_succ, add_smul, one_smul, pow_succ, ← ih]
        exact exp_add_of_commute_of_mem_ball (𝕂 := ℝ)
          ((Commute.refl _).smul_left _)
          (by rw [expSeries_radius_eq_top]; exact Metric.mem_eball.mpr (by simp))
          (by rw [expSeries_radius_eq_top]; exact Metric.mem_eball.mpr (by simp))
    rw [← hpow n, smul_smul, mul_inv_cancel₀ hnR.ne', one_smul]
  have hδ : ‖X - Y‖ ≤ 3 * l.length * (s / n) ^ 2 * Real.exp (2 * (s / n)) := by
    have h := norm_exp_sum_sub_prod l'
    rw [hl'sum, hl'norm, hl'len] at h
    exact h
  have hq : 1 ≤ Real.exp (s / n) := Real.one_le_exp (div_nonneg hs hnR.le)
  have hX : ‖X‖ ≤ Real.exp (s / n) := by
    refine (norm_exp_le _).trans (Real.exp_le_exp.mpr ?_)
    rw [norm_smul, Real.norm_of_nonneg (inv_nonneg.mpr hnR.le)]
    rw [div_eq_inv_mul]
    exact mul_le_mul_of_nonneg_left (norm_list_sum_le l) (inv_nonneg.mpr hnR.le)
  have hY : ‖Y‖ ≤ Real.exp (s / n) := by
    have := norm_list_prod_exp_le l'
    rwa [hl'norm] at this
  have htel := pow_sub_pow_le X Y hq hX hY hδ n
  have hqn : Real.exp (s / n) ^ n = Real.exp s := by
    rw [← Real.exp_nat_mul, mul_div_cancel₀ s hnR.ne']
  rw [hYdef, ← hXn]
  calc ‖X ^ n - Y ^ n‖
      ≤ n * Real.exp (s / n) ^ n * (3 * l.length * (s / n) ^ 2 * Real.exp (2 * (s / n))) := htel
    _ = 3 * l.length * s ^ 2 * (Real.exp s * Real.exp (2 * (s / n))) / n := by
        rw [hqn]; field_simp
    _ ≤ 3 * l.length * s ^ 2 * Real.exp (3 * s) / n := by
        apply div_le_div_of_nonneg_right _ hnR.le
        apply mul_le_mul_of_nonneg_left _ (by positivity)
        rw [← Real.exp_add]
        apply Real.exp_le_exp.mpr
        have : s / n ≤ s := div_le_self hs (by exact_mod_cast hn)
        linarith

/-- **The Lie–Trotter product formula.** -/
theorem trotter_tendsto (l : List 𝔸) :
    Tendsto (fun n : ℕ => ((l.map fun a => exp ((n : ℝ)⁻¹ • a)).prod) ^ n) atTop
      (nhds (exp l.sum)) := by
  set C := 3 * l.length * (l.map norm).sum ^ 2 * Real.exp (3 * (l.map norm).sum)
  rw [tendsto_iff_norm_sub_tendsto_zero]
  have hC : Tendsto (fun n : ℕ => C / n) atTop (nhds 0) :=
    tendsto_const_div_atTop_nhds_zero_nat C
  refine squeeze_zero' (Eventually.of_forall fun n => norm_nonneg _) ?_ hC
  filter_upwards [eventually_gt_atTop 0] with n hn
  rw [norm_sub_rev]
  exact trotter_bound l hn

/-- **Lloyd's simulation theorem.** For every precision `ε > 0`, the number of
Trotter steps `n = ⌈3 k s² e^(3s)/ε⌉ + 1` simulates `e^(Σ aⱼ)` by local factors
to error at most `ε`. -/
theorem lloyd_simulation (l : List 𝔸) {ε : ℝ} (hε : 0 < ε) :
    ∃ n : ℕ, n = ⌈3 * l.length * (l.map norm).sum ^ 2 * Real.exp (3 * (l.map norm).sum) / ε⌉₊ + 1 ∧
      ‖exp l.sum - ((l.map fun a => exp ((n : ℝ)⁻¹ • a)).prod) ^ n‖ ≤ ε := by
  set C := 3 * l.length * (l.map norm).sum ^ 2 * Real.exp (3 * (l.map norm).sum)
  have hC : 0 ≤ C := by
    have := list_norm_sum_nonneg l
    positivity
  refine ⟨⌈C / ε⌉₊ + 1, rfl, ?_⟩
  have hn : 0 < ⌈C / ε⌉₊ + 1 := Nat.succ_pos _
  refine (trotter_bound l hn).trans ?_
  have hnR : (0 : ℝ) < ((⌈C / ε⌉₊ + 1 : ℕ) : ℝ) := by exact_mod_cast hn
  rw [div_le_iff₀ hnR]
  have hceil : C / ε ≤ ⌈C / ε⌉₊ := Nat.le_ceil _
  have : C ≤ ε * ⌈C / ε⌉₊ := by
    rw [div_le_iff₀ hε] at hceil
    linarith
  push_cast
  nlinarith

end Snuffy.Trotter
