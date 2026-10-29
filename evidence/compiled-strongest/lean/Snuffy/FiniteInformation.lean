/-
Snuffy — Canon Edition v4.1: finite-alphabet information theory for the X3
decoder, machine-checked (working argument §12; Summit 4, X3).

Joint laws are nonnegative arrays `p : H → Y → ℝ` summing to one; mutual
information is `I(p) = Σ p log(p / (p_H p_Y))` (natural logarithms).

  * log_sum — the log-sum inequality, from Jensen and convexity of t log t.
  * data_processing_fin — I(H : K(Y)) ≤ I(H : Y) for every stochastic matrix K.
  * flag_identity — the optimistic decoder that receives the payload with
    probability π (the carrier is inside its radius) and an H-independent
    blank otherwise has exactly I(H : Y) = π · I(H : P).
  * decoder_bound — every decoder with less access (any channel applied to
    the optimistic decoder's view) has I ≤ π · I₀.
  * necessary_radius_from_decoder — composed with the Gaussian carrier tail:
    successful recovery of I_target forces r ≥ ut − c√t, with no
    information-theoretic hypothesis left.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.GaussianTail
import Mathlib.Analysis.SpecialFunctions.Log.NegMulLog
import Mathlib.Analysis.Convex.Jensen
import Mathlib.Data.Fintype.Option

open Finset Real

namespace Snuffy.FiniteInformation

/-! ## The log-sum inequality -/

/-- **Log-sum inequality.** For nonnegative `a, b` with `b i = 0 → a i = 0`,
`(Σ a) log(Σ a / Σ b) ≤ Σ a log(a / b)`. -/
theorem log_sum {ι : Type*} [Fintype ι] (a b : ι → ℝ) (ha : ∀ i, 0 ≤ a i) (hb : ∀ i, 0 ≤ b i)
    (hab : ∀ i, b i = 0 → a i = 0) :
    (∑ i, a i) * Real.log ((∑ i, a i) / ∑ i, b i) ≤ ∑ i, a i * Real.log (a i / b i) := by
  set A := ∑ i, a i
  set B := ∑ i, b i
  by_cases hB : B = 0
  · have hb0 : ∀ i, b i = 0 := fun i =>
      (sum_eq_zero_iff_of_nonneg (fun i _ => hb i)).mp hB i (mem_univ i)
    have ha0 : ∀ i, a i = 0 := fun i => hab i (hb0 i)
    have hA : A = 0 := sum_eq_zero fun i _ => ha0 i
    rw [hA, zero_mul]
    exact le_of_eq (sum_eq_zero fun i _ => by rw [ha0 i, zero_mul]).symm
  · have hBpos : 0 < B := lt_of_le_of_ne (sum_nonneg fun i _ => hb i) (Ne.symm hB)
    have hjensen := convexOn_mul_log.map_sum_le (t := univ) (w := fun i => b i / B)
      (p := fun i => a i / b i) (fun i _ => div_nonneg (hb i) hBpos.le)
      (by rw [← sum_div]; exact div_self hB)
      (fun i _ => Set.mem_Ici.mpr (div_nonneg (ha i) (hb i)))
    have hpt1 : ∀ i, (b i / B) • (a i / b i) = a i / B := by
      intro i
      rw [smul_eq_mul]
      by_cases hbi : b i = 0
      · rw [hbi, hab i hbi]; simp
      · field_simp
    have hpt2 : ∀ i, (b i / B) • (a i / b i * Real.log (a i / b i))
        = a i * Real.log (a i / b i) / B := by
      intro i
      rw [smul_eq_mul]
      by_cases hbi : b i = 0
      · rw [hbi, hab i hbi]; simp
      · field_simp
    simp only [hpt1, hpt2, ← sum_div] at hjensen
    have h := mul_le_mul_of_nonneg_right hjensen hBpos.le
    rw [div_mul_cancel₀ _ hB] at h
    have key : A * Real.log (A / B) = A / B * Real.log (A / B) * B := by field_simp
    rw [key]
    exact h

/-! ## Mutual information of a finite joint law -/

variable {H Y Z : Type*} [Fintype H] [Fintype Y] [Fintype Z]

/-- First marginal. -/
def margH (p : H → Y → ℝ) (h : H) : ℝ := ∑ y, p h y

/-- Second marginal. -/
def margY (p : H → Y → ℝ) (y : Y) : ℝ := ∑ h, p h y

/-- Mutual information `I(H : Y)` of a finite joint law, in nats. -/
noncomputable def mi (p : H → Y → ℝ) : ℝ :=
  ∑ h, ∑ y, p h y * Real.log (p h y / (margH p h * margY p y))

/-- Process the second coordinate by a stochastic matrix `K`. -/
def process (p : H → Y → ℝ) (K : Y → Z → ℝ) (h : H) (z : Z) : ℝ := ∑ y, p h y * K y z

omit [Fintype H] in
theorem margH_process (p : H → Y → ℝ) (K : Y → Z → ℝ) (hK : ∀ y, ∑ z, K y z = 1) (h : H) :
    margH (process p K) h = margH p h := by
  unfold margH process
  rw [sum_comm]
  simp_rw [← mul_sum, hK, mul_one]

omit [Fintype Z] in
theorem margY_process (p : H → Y → ℝ) (K : Y → Z → ℝ) (z : Z) :
    margY (process p K) z = ∑ y, margY p y * K y z := by
  unfold margY process
  rw [sum_comm]
  simp_rw [sum_mul]

/-- **Finite data processing.** Applying any stochastic matrix to the second
coordinate does not increase mutual information. -/
theorem data_processing_fin (p : H → Y → ℝ) (hp : ∀ h y, 0 ≤ p h y)
    (K : Y → Z → ℝ) (hK0 : ∀ y z, 0 ≤ K y z) (hK : ∀ y, ∑ z, K y z = 1) :
    mi (process p K) ≤ mi p := by
  have hle_H : ∀ h y, p h y ≤ margH p h := fun h y =>
    single_le_sum (fun y _ => hp h y) (mem_univ y)
  have hle_Y : ∀ h y, p h y ≤ margY p y := fun h y =>
    single_le_sum (f := fun h => p h y) (fun h _ => hp h y) (mem_univ h)
  have hmH : ∀ h, 0 ≤ margH p h := fun h => sum_nonneg fun y _ => hp h y
  have hmY : ∀ y, 0 ≤ margY p y := fun y => sum_nonneg fun h _ => hp h y
  set L : H → Y → ℝ := fun h y => Real.log (p h y / (margH p h * margY p y))
  -- pointwise log-sum at each (h, z)
  have hpoint : ∀ h z,
      process p K h z * Real.log (process p K h z / (margH (process p K) h * margY (process p K) z))
        ≤ ∑ y, p h y * K y z * L h y := by
    intro h z
    rw [margH_process p K hK, margY_process]
    have hls := log_sum (fun y => p h y * K y z) (fun y => margH p h * margY p y * K y z)
      (fun y => mul_nonneg (hp h y) (hK0 y z))
      (fun y => mul_nonneg (mul_nonneg (hmH h) (hmY y)) (hK0 y z))
      (by
        intro y hy
        rcases mul_eq_zero.mp hy with h1 | h1
        · rcases mul_eq_zero.mp h1 with h2 | h2
          · have := hle_H h y; rw [h2] at this
            rw [le_antisymm this (hp h y), zero_mul]
          · have := hle_Y h y; rw [h2] at this
            rw [le_antisymm this (hp h y), zero_mul]
        · rw [h1, mul_zero])
    have hsumb : ∑ y, margH p h * margY p y * K y z = margH p h * ∑ y, margY p y * K y z := by
      rw [mul_sum]; exact sum_congr rfl fun y _ => by ring
    rw [hsumb] at hls
    refine hls.trans (le_of_eq (sum_congr rfl fun y _ => ?_))
    by_cases hKz : K y z = 0
    · rw [hKz]; simp
    · show p h y * K y z * Real.log (p h y * K y z / (margH p h * margY p y * K y z))
          = p h y * K y z * Real.log (p h y / (margH p h * margY p y))
      rw [mul_div_mul_right _ _ hKz]
  unfold mi
  calc ∑ h, ∑ z, process p K h z
        * Real.log (process p K h z / (margH (process p K) h * margY (process p K) z))
      ≤ ∑ h, ∑ z, ∑ y, p h y * K y z * L h y :=
        sum_le_sum fun h _ => sum_le_sum fun z _ => hpoint h z
    _ = ∑ h, ∑ y, p h y * L h y := by
        refine sum_congr rfl fun h _ => ?_
        rw [sum_comm]
        refine sum_congr rfl fun y _ => ?_
        rw [← sum_mul, ← mul_sum, hK, mul_one]

/-! ## The optimistic decoder -/

variable {X : Type*} [Fintype X]

/-- The optimistic decoder's view: with probability `pr` (the carrier lies
inside the decoder's radius) it receives the payload, otherwise an
H-independent blank. -/
def flag (pr : ℝ) (q : H → X → ℝ) (h : H) : Option X → ℝ
  | some x => pr * q h x
  | none => (1 - pr) * margH q h

/-- **Flag identity.** The optimistic decoder carries exactly `pr · I(H : P)`. -/
theorem flag_identity (pr : ℝ) (q : H → X → ℝ) (hq1 : ∑ h, ∑ x, q h x = 1) :
    mi (flag pr q) = pr * mi q := by
  have hmH : ∀ h, margH (flag pr q) h = margH q h := by
    intro h
    unfold margH
    rw [Fintype.sum_option]
    simp only [flag, ← mul_sum]
    unfold margH
    ring
  have hmYnone : margY (flag pr q) none = 1 - pr := by
    unfold margY
    simp only [flag, ← mul_sum]
    unfold margH
    rw [hq1, mul_one]
  have hmYsome : ∀ x, margY (flag pr q) (some x) = pr * margY q x := by
    intro x
    unfold margY
    simp only [flag, ← mul_sum]
  unfold mi
  rw [mul_sum]
  refine sum_congr rfl fun h _ => ?_
  rw [Fintype.sum_option, hmH, hmYnone]
  have hnone : flag pr q h none * Real.log (flag pr q h none / (margH q h * (1 - pr))) = 0 := by
    show (1 - pr) * margH q h * Real.log ((1 - pr) * margH q h / (margH q h * (1 - pr))) = 0
    by_cases h0 : (1 - pr) * margH q h = 0
    · rw [h0, zero_mul]
    · rw [mul_comm (margH q h), div_self h0, Real.log_one, mul_zero]
  rw [hnone, zero_add, mul_sum]
  refine sum_congr rfl fun x _ => ?_
  rw [hmYsome]
  show pr * q h x * Real.log (pr * q h x / (margH q h * (pr * margY q x)))
    = pr * (q h x * Real.log (q h x / (margH q h * margY q x)))
  by_cases hpr : pr = 0
  · rw [hpr]; simp
  · rw [show margH q h * (pr * margY q x) = pr * (margH q h * margY q x) by ring,
      mul_div_mul_left _ _ hpr]
    ring

/-- **Decoder bound.** Any decoder with less access than the optimistic one —
any stochastic processing `K` of its view — carries at most `pr · I₀`. -/
theorem decoder_bound {pr : ℝ} (hpr0 : 0 ≤ pr) (hpr1 : pr ≤ 1) (q : H → X → ℝ)
    (hq : ∀ h x, 0 ≤ q h x) (hq1 : ∑ h, ∑ x, q h x = 1)
    (K : Option X → Z → ℝ) (hK0 : ∀ y z, 0 ≤ K y z) (hK : ∀ y, ∑ z, K y z = 1) :
    mi (process (flag pr q) K) ≤ pr * mi q := by
  have hflag : ∀ h y, 0 ≤ flag pr q h y := by
    intro h y
    cases y with
    | none => exact mul_nonneg (by linarith) (sum_nonneg fun x _ => hq h x)
    | some x => exact mul_nonneg hpr0 (hq h x)
  rw [← flag_identity pr q hq1]
  exact data_processing_fin _ hflag K hK0 hK

/-! ## X3 without an information hypothesis -/

open MeasureTheory ProbabilityTheory

/-- **Necessary radius, information theory included.** Let `q` be the joint
law of the history and the payload, `I₀ = I(H : P)`, and let the actual
decoder at radius `r` process the optimistic decoder's view, which receives
the payload exactly when the carrier `X_t ~ N(ut, 2Dt)` lies within `r`. If
it recovers `I_target ≤ I₀`, then `r ≥ ut − c√t`, `c = 2√(D ln(I₀/I_target))`. -/
theorem necessary_radius_from_decoder {D u t r It : ℝ} (hD : 0 < D) (ht : 0 < t) (hIt : 0 < It)
    (q : H → X → ℝ) (hq : ∀ h x, 0 ≤ q h x) (hq1 : ∑ h, ∑ x, q h x = 1)
    (hItI0 : It ≤ mi q)
    (K : Option X → Z → ℝ) (hK0 : ∀ y z, 0 ≤ K y z) (hK : ∀ y, ∑ z, K y z = 1)
    (hsuccess : It ≤ mi (process (flag
      ((gaussianReal (u * t) (Snuffy.GaussianTail.carrierVar D t hD ht)).real {x | x ≤ r}) q) K)) :
    u * t - 2 * Real.sqrt (D * Real.log (mi q / It)) * Real.sqrt t ≤ r := by
  set pr := (gaussianReal (u * t) (Snuffy.GaussianTail.carrierVar D t hD ht)).real {x | x ≤ r}
  have hpr0 : 0 ≤ pr := measureReal_nonneg
  have hpr1 : pr ≤ 1 := measureReal_le_one
  have hdec := decoder_bound hpr0 hpr1 q hq hq1 K hK0 hK
  refine Snuffy.GaussianTail.necessary_radius_of_decoder hD ht hIt hItI0 ?_
  rw [mul_comm]
  exact hsuccess.trans hdec

end Snuffy.FiniteInformation
