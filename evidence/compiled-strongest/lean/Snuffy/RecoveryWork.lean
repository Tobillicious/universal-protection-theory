/-
Snuffy — Canon Edition v4.1: the X3 recovery-work route, machine-checked
(Summit 4, X3).

The historical-transport route of the working argument (§12), from the
information tail onward:

  * frontier_work_bound — the recovery-work theorem: for an absolutely
    continuous frontier r on [0, T] with r ≥ 0, r(0) = r₀, r' ≤ v a.e., power
    P ≥ p' r^(d_G − 1) a.e. and charged work W ≥ ∫ P,
        r(T)^(d_G) − r₀^(d_G) ≤ (v d_G / p') W,
    for every real d_G ≥ 1 (integer and fractal growth alike).
  * RecoveryProtocol, Wmin_lower_bound — every admitted protocol that reaches
    the required radius R pays W ≥ (p' / (v d_G)) (R^(d_G) − r₀^(d_G)); the
    infimum over successful protocols (W_min, +∞ if none) inherits the bound.
  * necessary_radius — from the Gaussian information tail
    I(H : A) ≤ I₀ exp(−(ut − r)² / (4Dt)), successful recovery of I_target
    needs r ≥ ut − c√t with c = 2 √(D ln(I₀ / I_target)).
  * completing_square, carrier_radius — R(t) ≥ w (t − t_c) for any 0 < w < u,
    t_c = c² / (4w(u − w)).
  * x3_delayed_recovery_work, delayed_work_diverges — assembled: the minimum
    delayed-recovery work is at least (p' / (v d_G)) ((w(t − t_c))^(d_G) − r₀^(d_G))
    and diverges as t → ∞.

The information-theoretic inputs — the optimistic-decoder chain rule giving
I₀ Φ((r − ut)/√(2Dt)) and the Gaussian Chernoff tail — are the standard
Shannon/Gaussian steps of §12, cited there; everything from the tail bound on
is compiled here.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.MeasureTheory.Integral.IntervalIntegral.AbsolutelyContinuousFun
import Mathlib.Analysis.SpecialFunctions.Pow.Deriv
import Mathlib.Analysis.SpecialFunctions.Pow.Asymptotics
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Sqrt

open MeasureTheory Set Filter

namespace Snuffy.RecoveryWork

/-! ## The recovery-work theorem -/

/-- **Recovery-work theorem.** An absolutely continuous, nonnegative frontier
advancing at speed at most `v`, driven by power at least `p' r^(d − 1)`, sweeps
`r(T)^d − r₀^d` for at most `(v d / p')` times the charged work. -/
theorem frontier_work_bound {r P : ℝ → ℝ} {T r0 v p' W d : ℝ}
    (hT : 0 ≤ T) (hd : 1 ≤ d) (hv : 0 < v) (hp : 0 < p')
    (hac : AbsolutelyContinuousOnInterval r 0 T)
    (hnonneg : ∀ s ∈ Icc 0 T, 0 ≤ r s)
    (hr0 : r 0 = r0)
    (hspeed : ∀ᵐ s, s ∈ Icc 0 T → deriv r s ≤ v)
    (hpow : ∀ᵐ s, s ∈ Icc 0 T → p' * r s ^ (d - 1) ≤ P s)
    (hPint : IntervalIntegrable P volume 0 T)
    (hW : ∫ s in (0:ℝ)..T, P s ≤ W) :
    r T ^ d - r0 ^ d ≤ v * d / p' * W := by
  have hIcc : uIcc 0 T = Icc 0 T := uIcc_of_le hT
  obtain ⟨C, hC⟩ := isCompact_uIcc.exists_bound_of_continuousOn hac.continuousOn
  have hmaps : MapsTo r (uIcc 0 T) (Icc 0 C) := by
    intro s hs
    have hs' : s ∈ Icc 0 T := by rw [← hIcc]; exact hs
    refine ⟨hnonneg s hs', ?_⟩
    have h := hC s hs
    rw [Real.norm_eq_abs] at h
    exact le_trans (le_abs_self _) h
  have hlip : LipschitzOnWith ‖d * C ^ (d - 1)‖₊ (fun x : ℝ => x ^ d) (Icc 0 C) := by
    apply (convex_Icc (0:ℝ) C).lipschitzOnWith_of_nnnorm_hasDerivWithin_le
      (f' := fun x => d * x ^ (d - 1))
    · intro x _
      exact (Real.hasDerivAt_rpow_const (Or.inr hd)).hasDerivWithinAt
    · intro x hx
      have hx0 : 0 ≤ x := hx.1
      have hC0 : 0 ≤ C := le_trans hx.1 hx.2
      rw [← NNReal.coe_le_coe, coe_nnnorm, coe_nnnorm,
        Real.norm_of_nonneg (mul_nonneg (by linarith) (Real.rpow_nonneg hx0 _)),
        Real.norm_of_nonneg (mul_nonneg (by linarith) (Real.rpow_nonneg hC0 _))]
      exact mul_le_mul_of_nonneg_left (Real.rpow_le_rpow hx0 hx.2 (by linarith)) (by linarith)
  have hg : AbsolutelyContinuousOnInterval ((fun x : ℝ => x ^ d) ∘ r) 0 T :=
    hlip.comp_absolutelyContinuousOnInterval hmaps hac
  have hc : 0 ≤ v * d / p' := div_nonneg (mul_nonneg hv.le (by linarith)) hp.le
  have hae : ∀ᵐ s ∂(volume.restrict (Icc 0 T)),
      deriv ((fun x : ℝ => x ^ d) ∘ r) s ≤ v * d / p' * P s := by
    rw [ae_restrict_iff' measurableSet_Icc]
    filter_upwards [hac.ae_differentiableAt, hspeed, hpow] with s hdiff hsp hpw hs
    have hs' : s ∈ uIcc 0 T := by rw [hIcc]; exact hs
    have hder : deriv ((fun x : ℝ => x ^ d) ∘ r) s = d * r s ^ (d - 1) * deriv r s :=
      ((Real.hasDerivAt_rpow_const (Or.inr hd)).comp s (hdiff hs').hasDerivAt).deriv
    rw [hder]
    have hk : 0 ≤ d * r s ^ (d - 1) :=
      mul_nonneg (by linarith) (Real.rpow_nonneg (hnonneg s hs) _)
    calc d * r s ^ (d - 1) * deriv r s
        ≤ d * r s ^ (d - 1) * v := mul_le_mul_of_nonneg_left (hsp hs) hk
      _ = v * d / p' * (p' * r s ^ (d - 1)) := by field_simp
      _ ≤ v * d / p' * P s := mul_le_mul_of_nonneg_left (hpw hs) hc
  have hmono := intervalIntegral.integral_mono_ae_restrict hT hg.intervalIntegrable_deriv
    (hPint.const_mul (v * d / p')) hae
  rw [hg.integral_deriv_eq_sub, intervalIntegral.integral_const_mul] at hmono
  calc r T ^ d - r0 ^ d
      = ((fun x : ℝ => x ^ d) ∘ r) T - ((fun x : ℝ => x ^ d) ∘ r) 0 := by
        simp only [Function.comp_apply, hr0]
    _ ≤ v * d / p' * ∫ s in (0:ℝ)..T, P s := hmono
    _ ≤ v * d / p' * W := mul_le_mul_of_nonneg_left hW hc

/-- An admitted recovery protocol: duration `T`, absolutely continuous
frontier from `r₀` advancing at speed at most `v`, area power at least
`p' r^(d − 1)`, and charged work covering the integrated power. -/
structure RecoveryProtocol (r0 v p' d : ℝ) where
  T : ℝ
  frontier : ℝ → ℝ
  power : ℝ → ℝ
  work : ℝ
  T_nonneg : 0 ≤ T
  ac : AbsolutelyContinuousOnInterval frontier 0 T
  nonneg : ∀ s ∈ Icc 0 T, 0 ≤ frontier s
  start : frontier 0 = r0
  speed : ∀ᵐ s, s ∈ Icc 0 T → deriv frontier s ≤ v
  area_power : ∀ᵐ s, s ∈ Icc 0 T → p' * frontier s ^ (d - 1) ≤ power s
  power_integrable : IntervalIntegrable power volume 0 T
  charged : ∫ s in (0:ℝ)..T, power s ≤ work

/-- A protocol succeeds at required radius `R` when its final frontier reaches `R`. -/
def RecoveryProtocol.Succeeds {r0 v p' d : ℝ} (π : RecoveryProtocol r0 v p' d) (R : ℝ) :
    Prop :=
  R ≤ π.frontier π.T

/-- **W_min lower bound.** Every admitted protocol that reaches the required
radius `R ≥ 0` pays at least `(p' / (v d)) (R^d − r₀^d)`. Hence so does the
infimum over successful protocols (which is `+∞` when none succeeds). -/
theorem Wmin_lower_bound {r0 v p' d : ℝ} (hd : 1 ≤ d) (hv : 0 < v) (hp : 0 < p')
    {R : ℝ} (hR0 : 0 ≤ R) (π : RecoveryProtocol r0 v p' d) (hsucc : π.Succeeds R) :
    p' / (v * d) * (R ^ d - r0 ^ d) ≤ π.work := by
  have h := frontier_work_bound π.T_nonneg hd hv hp π.ac π.nonneg π.start π.speed
    π.area_power π.power_integrable π.charged
  have hRd : R ^ d ≤ π.frontier π.T ^ d := Real.rpow_le_rpow hR0 hsucc (by linarith)
  have hvd : 0 < v * d := mul_pos hv (by linarith)
  have key : R ^ d - r0 ^ d ≤ v * d / p' * π.work := by linarith
  calc p' / (v * d) * (R ^ d - r0 ^ d)
      ≤ p' / (v * d) * (v * d / p' * π.work) :=
        mul_le_mul_of_nonneg_left key (div_pos hp hvd).le
    _ = π.work := by field_simp

/-! ## The necessary recovery radius -/

/-- From the Gaussian information tail: if recovering `I_target` from inside
radius `r < ut` is only possible when `I_target ≤ I₀ exp(−(ut − r)²/(4Dt))`,
then every successful radius satisfies `r ≥ ut − c√t`,
`c = 2 √(D ln(I₀ / I_target))`. -/
theorem necessary_radius {I0 It D u t r : ℝ} (hD : 0 < D) (ht : 0 < t) (hIt : 0 < It)
    (hItI0 : It ≤ I0)
    (htail : r < u * t → It ≤ I0 * Real.exp (-(u * t - r) ^ 2 / (4 * D * t))) :
    u * t - 2 * Real.sqrt (D * Real.log (I0 / It)) * Real.sqrt t ≤ r := by
  have hI0 : 0 < I0 := lt_of_lt_of_le hIt hItI0
  have hL : 0 ≤ Real.log (I0 / It) :=
    Real.log_nonneg (by rw [le_div_iff₀ hIt]; linarith)
  by_cases hr : u * t ≤ r
  · have : 0 ≤ 2 * Real.sqrt (D * Real.log (I0 / It)) * Real.sqrt t := by positivity
    linarith
  · rw [not_le] at hr
    have h := htail hr
    have hlog : (u * t - r) ^ 2 / (4 * D * t) ≤ Real.log (I0 / It) := by
      have h1 : It / I0 ≤ Real.exp (-(u * t - r) ^ 2 / (4 * D * t)) := by
        rw [div_le_iff₀ hI0, mul_comm]
        exact h
      have h2 := Real.log_le_log (div_pos hIt hI0) h1
      rw [Real.log_exp, Real.log_div hIt.ne' hI0.ne'] at h2
      rw [Real.log_div hI0.ne' hIt.ne']
      have h3 : -(u * t - r) ^ 2 / (4 * D * t) = -((u * t - r) ^ 2 / (4 * D * t)) := by ring
      linarith
    have hsq : (u * t - r) ^ 2 ≤ 4 * D * t * Real.log (I0 / It) := by
      rw [div_le_iff₀ (by positivity)] at hlog
      linarith
    have hpos : 0 ≤ u * t - r := by linarith
    have hDL : 0 ≤ D * Real.log (I0 / It) := mul_nonneg hD.le hL
    have hbound : u * t - r ≤ 2 * Real.sqrt (D * Real.log (I0 / It)) * Real.sqrt t := by
      rw [← Real.sqrt_sq hpos]
      calc Real.sqrt ((u * t - r) ^ 2)
          ≤ Real.sqrt (4 * D * t * Real.log (I0 / It)) := Real.sqrt_le_sqrt hsq
        _ = 2 * Real.sqrt (D * Real.log (I0 / It)) * Real.sqrt t := by
          rw [show 4 * D * t * Real.log (I0 / It)
              = 2 ^ 2 * ((D * Real.log (I0 / It)) * t) by ring,
            Real.sqrt_mul (by norm_num), Real.sqrt_sq (by norm_num), Real.sqrt_mul hDL]
          ring
    linarith

/-- Completing the square: `ut − c√t − w(t − t_c) = (u − w)(√t − c/(2(u − w)))²`
with `t_c = c²/(4w(u − w))`. -/
theorem completing_square {u w c t : ℝ} (hw : 0 < w) (hwu : w < u) (ht : 0 ≤ t) :
    u * t - c * Real.sqrt t - w * (t - c ^ 2 / (4 * w * (u - w)))
      = (u - w) * (Real.sqrt t - c / (2 * (u - w))) ^ 2 := by
  obtain ⟨s, hs0, rfl⟩ : ∃ s, 0 ≤ s ∧ t = s ^ 2 :=
    ⟨Real.sqrt t, Real.sqrt_nonneg _, (Real.sq_sqrt ht).symm⟩
  have huw : u - w ≠ 0 := (sub_pos.mpr hwu).ne'
  have hw0 : w ≠ 0 := hw.ne'
  rw [Real.sqrt_sq hs0]
  field_simp
  ring

/-- **Carrier radius.** Any radius meeting the necessary bound `r ≥ ut − c√t`
satisfies `r ≥ w(t − t_c)` for every `0 < w < u`. -/
theorem carrier_radius {u w c t r : ℝ} (hw : 0 < w) (hwu : w < u) (ht : 0 ≤ t)
    (hr : u * t - c * Real.sqrt t ≤ r) :
    w * (t - c ^ 2 / (4 * w * (u - w))) ≤ r := by
  have h := completing_square (c := c) hw hwu ht
  have : 0 ≤ (u - w) * (Real.sqrt t - c / (2 * (u - w))) ^ 2 :=
    mul_nonneg (sub_pos.mpr hwu).le (sq_nonneg _)
  linarith

/-! ## Assembly: delayed recovery work diverges -/

/-- **X3, delayed recovery.** At unattended age `t ≥ t_c`, if the required radius
is at least `w(t − t_c)`, every successful admitted protocol pays at least
`(p' / (v d)) ((w(t − t_c))^d − r₀^d)`. -/
theorem x3_delayed_recovery_work {r0 v p' d w tc t R : ℝ} (hd : 1 ≤ d) (hv : 0 < v)
    (hp : 0 < p') (hw : 0 < w) (ht : tc ≤ t) (hR : w * (t - tc) ≤ R)
    (π : RecoveryProtocol r0 v p' d) (hsucc : π.Succeeds R) :
    p' / (v * d) * ((w * (t - tc)) ^ d - r0 ^ d) ≤ π.work :=
  Wmin_lower_bound hd hv hp (mul_nonneg hw.le (sub_nonneg.mpr ht)) π (le_trans hR hsucc)

/-- The delayed-recovery work bound diverges as the unattended age grows. -/
theorem delayed_work_diverges {r0 v p' d w tc : ℝ} (hd : 1 ≤ d) (hv : 0 < v) (hp : 0 < p')
    (hw : 0 < w) :
    Tendsto (fun t => p' / (v * d) * ((w * (t - tc)) ^ d - r0 ^ d)) atTop atTop := by
  have hlin : Tendsto (fun t : ℝ => w * (t - tc)) atTop atTop :=
    (tendsto_atTop_add_const_right atTop (-tc) tendsto_id).const_mul_atTop hw |>.congr
      (fun t => by simp [sub_eq_add_neg])
  have hpow : Tendsto (fun t : ℝ => (w * (t - tc)) ^ d) atTop atTop :=
    (tendsto_rpow_atTop (by linarith)).comp hlin
  have hsub : Tendsto (fun t : ℝ => (w * (t - tc)) ^ d - r0 ^ d) atTop atTop :=
    (tendsto_atTop_add_const_right atTop (-(r0 ^ d)) hpow).congr
      (fun t => by simp [sub_eq_add_neg])
  exact hsub.const_mul_atTop (div_pos hp (mul_pos hv (by linarith)))

end Snuffy.RecoveryWork
