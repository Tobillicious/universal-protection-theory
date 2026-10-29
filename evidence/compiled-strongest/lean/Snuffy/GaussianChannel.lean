/-
Snuffy — Canon Edition v4.1: the scalar Gaussian channel bound — the third
block of the Gaussian maximum-entropy bound of §11 (machine-checked).

The channel Y = gX + Z, Z ~ N(0, v) independent of the input, is the Markov
kernel x ↦ N(gx, v). For every input law P_X with finite second moment, mean
m and variance V:

  * integral_quadratic_gaussian — ∫ (c − (y − a)²/(2v) + (y − b)²/(2s)) dN(a, v)
    = c − 1/2 + (v + (a − b)²)/(2s).
  * llr_chan — the log-likelihood ratio of the joint law against P_X ⊗ Q,
    Q = N(gm, g²V + v), is the explicit quadratic almost everywhere.
  * klDiv_chan — KL(P_X ⊗ chan ‖ P_X ⊗ Q) = ½ ln((g²V + v)/v).
  * gaussian_channel_bound — I(X ; Y) ≤ ½ ln(1 + g² V / v): the Gaussian
    maximum-entropy bound for the scalar channel, every input law included.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.GaussianKL
import Snuffy.GoldenFormula
import Mathlib.Probability.Kernel.Composition.RadonNikodym
import Mathlib.Probability.Kernel.Composition.IntegralCompProd
import Mathlib.Probability.Kernel.Composition.AbsolutelyContinuous

open MeasureTheory ProbabilityTheory InformationTheory Real
open scoped ENNReal NNReal

namespace Snuffy.GaussianChannel

/-- The scalar Gaussian channel `x ↦ N(g x, v)`. -/
noncomputable def chan (g : ℝ) (v : ℝ≥0) : Kernel ℝ ℝ where
  toFun x := gaussianReal (g * x) v
  measurable' := measurable_gaussianReal.comp
    (Measurable.prodMk (measurable_const.mul measurable_id) measurable_const)

theorem chan_apply (g : ℝ) (v : ℝ≥0) (x : ℝ) : chan g v x = gaussianReal (g * x) v := rfl

instance (g : ℝ) (v : ℝ≥0) : IsMarkovKernel (chan g v) :=
  ⟨fun x => by rw [chan_apply]; infer_instance⟩

/-- Integral of the Gaussian log-likelihood quadratic. -/
theorem integral_quadratic_gaussian (a b c : ℝ) {v : ℝ≥0} (s : ℝ) :
    ∫ y, (c - (y - a) ^ 2 / (2 * v) + (y - b) ^ 2 / (2 * s)) ∂gaussianReal a v
      = c - (v : ℝ) / (2 * v) + ((v : ℝ) + (a - b) ^ 2) / (2 * s) := by
  have hsq : ∀ t, Integrable (fun y : ℝ => (y - t) ^ 2) (gaussianReal a v) := fun t =>
    ((memLp_id_gaussianReal 2).sub (memLp_const t)).integrable_sq
  have hA : Integrable (fun y : ℝ => c - (y - a) ^ 2 / (2 * v)) (gaussianReal a v) :=
    (integrable_const _).sub ((hsq a).div_const _)
  have hB : Integrable (fun y : ℝ => (y - b) ^ 2 / (2 * s)) (gaussianReal a v) :=
    (hsq b).div_const _
  have hC : Integrable (fun _ : ℝ => c) (gaussianReal a v) := integrable_const _
  have hD : Integrable (fun y : ℝ => (y - a) ^ 2 / (2 * v)) (gaussianReal a v) :=
    (hsq a).div_const _
  rw [integral_add hA hB, integral_sub hC hD, integral_const, probReal_univ, one_smul,
    integral_div, integral_div, Snuffy.GaussianKL.integral_sq_sub_gaussian,
    Snuffy.GaussianKL.integral_sq_sub_gaussian, sub_self]
  ring

section Bound

variable (g : ℝ) {v : ℝ≥0} (hv : v ≠ 0) (PX : Measure ℝ) [IsProbabilityMeasure PX]

/-- The quadratic log-likelihood ratio of the channel against `P_X ⊗ N(gm, s)`. -/
noncomputable def quad (v : ℝ≥0) (m : ℝ) (s : ℝ≥0) (p : ℝ × ℝ) : ℝ :=
  Real.log ((s : ℝ) / v) / 2 - (p.2 - g * p.1) ^ 2 / (2 * v) + (p.2 - g * m) ^ 2 / (2 * s)

theorem measurable_quad (v : ℝ≥0) (m : ℝ) (s : ℝ≥0) : Measurable (quad g v m s) := by
  unfold quad
  fun_prop

include hv in
/-- **The log-likelihood ratio of the channel.** -/
theorem llr_chan (m : ℝ) {s : ℝ≥0} (hs : s ≠ 0) :
    llr (PX ⊗ₘ chan g v) (PX ⊗ₘ Kernel.const ℝ (gaussianReal (g * m) s))
      =ᵐ[PX ⊗ₘ chan g v] quad g v m s := by
  set Q := gaussianReal (g * m) s
  have hacx : ∀ x, chan g v x ≪ Q := fun x =>
    (gaussianReal_absolutelyContinuous (g * x) hv).trans (gaussianReal_absolutelyContinuous' _ hs)
  have hac : PX ⊗ₘ chan g v ≪ PX ⊗ₘ Kernel.const ℝ Q :=
    Measure.AbsolutelyContinuous.compProd_right (Filter.Eventually.of_forall hacx)
  have hA := hac.ae_le (rnDeriv_measure_compProd_right PX (chan g v) (Kernel.const ℝ Q))
  have hB : ∀ᵐ p ∂(PX ⊗ₘ chan g v),
      Real.log ((chan g v).rnDeriv (Kernel.const ℝ Q) p.1 p.2).toReal = quad g v m s p := by
    rw [Measure.ae_compProd_iff (measurableSet_eq_fun
      ((Kernel.measurable_rnDeriv _ _).ennreal_toReal.log) (measurable_quad g v m s))]
    refine Filter.Eventually.of_forall fun x => ?_
    have h1 := Kernel.rnDeriv_eq_rnDeriv_measure (κ := chan g v) (η := Kernel.const ℝ Q) (a := x)
    have h2 := Snuffy.GaussianKL.llr_gaussian_gaussian (m₁ := g * x) (m₂ := g * m) hv hs
    filter_upwards [(hacx x).ae_le h1, h2] with y hy1 hy2
    rw [hy1]
    exact hy2
  filter_upwards [hA, hB] with p hp1 hp2
  rw [llr_def]
  simp only
  rw [hp1]
  exact hp2

/-- The reference output variance `g² V + v`. -/
noncomputable def outVar (v : ℝ≥0) : ℝ≥0 :=
  ⟨g ^ 2 * ∫ x, (x - ∫ y, y ∂PX) ^ 2 ∂PX + v,
    add_nonneg (mul_nonneg (sq_nonneg g)
      (integral_nonneg (f := fun x : ℝ => (x - ∫ y, y ∂PX) ^ 2) fun _ => sq_nonneg _)) v.2⟩

omit [IsProbabilityMeasure PX] in
theorem coe_outVar (v : ℝ≥0) :
    (outVar g PX v : ℝ) = g ^ 2 * ∫ x, (x - ∫ y, y ∂PX) ^ 2 ∂PX + v := rfl

include hv in
/-- **KL of the channel against the Gaussian reference output.** -/
theorem klDiv_chan (hX : MemLp id 2 PX) :
    klDiv (PX ⊗ₘ chan g v)
      (PX ⊗ₘ Kernel.const ℝ (gaussianReal (g * ∫ y, y ∂PX) (outVar g PX v)))
      = ENNReal.ofReal (Real.log ((outVar g PX v : ℝ) / v) / 2) := by
  set m := ∫ y, y ∂PX
  set V := ∫ x, (x - m) ^ 2 ∂PX
  have hV : 0 ≤ V := integral_nonneg fun x => sq_nonneg _
  have hvpos : (0 : ℝ) < v := NNReal.coe_pos.mpr (pos_iff_ne_zero.mpr hv)
  set s : ℝ≥0 := outVar g PX v
  have hsR : (s : ℝ) = g ^ 2 * V + v := coe_outVar g PX v
  have hspos : (0 : ℝ) < s := by rw [hsR]; positivity
  have hs : s ≠ 0 := fun h => by rw [h] at hspos; simp at hspos
  set Q := gaussianReal (g * m) s
  set J := PX ⊗ₘ chan g v
  have hacx : ∀ x, chan g v x ≪ Q := fun x =>
    (gaussianReal_absolutelyContinuous (g * x) hv).trans (gaussianReal_absolutelyContinuous' _ hs)
  have hac : J ≪ PX ⊗ₘ Kernel.const ℝ Q :=
    Measure.AbsolutelyContinuous.compProd_right (Filter.Eventually.of_forall hacx)
  have hllr := llr_chan g hv PX m hs
  have hXm : Integrable (fun x : ℝ => (x - m) ^ 2) PX :=
    (hX.sub (memLp_const m)).integrable_sq
  have hsec : ∀ x : ℝ, ∀ t, Integrable (fun y : ℝ => (y - t) ^ 2) (chan g v x) := fun x t => by
    rw [chan_apply]; exact ((memLp_id_gaussianReal 2).sub (memLp_const t)).integrable_sq
  have hfiber : ∀ x : ℝ, Integrable (fun y => quad g v m s (x, y)) (chan g v x) := fun x =>
    ((integrable_const (Real.log ((s : ℝ) / v) / 2)).sub ((hsec x (g * x)).div_const _)).add
      ((hsec x (g * m)).div_const _)
  set B : ℝ → ℝ := fun x =>
    |Real.log ((s : ℝ) / v) / 2| + 1 / 2 + ((v : ℝ) + (g * x - g * m) ^ 2) / (2 * s)
  have hBint : Integrable B PX := by
    have h1 : Integrable (fun x : ℝ => (v : ℝ) + g ^ 2 * (x - m) ^ 2) PX :=
      (integrable_const _).add (hXm.const_mul _)
    have h2 : Integrable (fun x : ℝ => ((v : ℝ) + g ^ 2 * (x - m) ^ 2) / (2 * s)) PX :=
      h1.div_const _
    have h3 : Integrable (fun x : ℝ => |Real.log ((s : ℝ) / v) / 2| + 1 / 2
        + ((v : ℝ) + g ^ 2 * (x - m) ^ 2) / (2 * s)) PX := (integrable_const _).add h2
    refine h3.congr (Filter.Eventually.of_forall fun x => ?_)
    simp only [B]
    ring
  have hv2 : (v : ℝ) / (2 * v) = 1 / 2 := by field_simp
  have hfint : Integrable (quad g v m s) J := by
    rw [Measure.integrable_compProd_iff (measurable_quad g v m s).aestronglyMeasurable]
    refine ⟨Filter.Eventually.of_forall hfiber, hBint.mono'
      ((measurable_quad g v m s).norm.stronglyMeasurable.integral_kernel_prod_right').aestronglyMeasurable
      (Filter.Eventually.of_forall fun x => ?_)⟩
    rw [Real.norm_of_nonneg (integral_nonneg fun y => norm_nonneg _)]
    have hmaj : Integrable (fun y : ℝ => |Real.log ((s : ℝ) / v) / 2| + (y - g * x) ^ 2 / (2 * v)
        + (y - g * m) ^ 2 / (2 * s)) (chan g v x) :=
      ((integrable_const _).add ((hsec x (g * x)).div_const _)).add ((hsec x (g * m)).div_const _)
    calc ∫ y, ‖quad g v m s (x, y)‖ ∂(chan g v x)
        ≤ ∫ y, (|Real.log ((s : ℝ) / v) / 2| + (y - g * x) ^ 2 / (2 * v)
            + (y - g * m) ^ 2 / (2 * s)) ∂(chan g v x) := by
          refine integral_mono (hfiber x).norm hmaj fun y => ?_
          have h1 : 0 ≤ (y - g * x) ^ 2 / (2 * v) := by positivity
          have h2 : 0 ≤ (y - g * m) ^ 2 / (2 * s) := by positivity
          have h3 := le_abs_self (Real.log ((s : ℝ) / v) / 2)
          have h4 := neg_abs_le (Real.log ((s : ℝ) / v) / 2)
          simp only [quad, Real.norm_eq_abs]
          rw [abs_le]
          constructor <;> linarith
      _ = B x := by
          rw [chan_apply]
          have hA : Integrable (fun y : ℝ => |Real.log ((s : ℝ) / v) / 2| + (y - g * x) ^ 2 / (2 * v))
              (gaussianReal (g * x) v) :=
            (integrable_const _).add
              (((memLp_id_gaussianReal 2).sub (memLp_const _)).integrable_sq.div_const _)
          have hB' : Integrable (fun y : ℝ => (y - g * m) ^ 2 / (2 * s)) (gaussianReal (g * x) v) :=
            ((memLp_id_gaussianReal 2).sub (memLp_const _)).integrable_sq.div_const _
          have hD : Integrable (fun y : ℝ => (y - g * x) ^ 2 / (2 * v)) (gaussianReal (g * x) v) :=
            ((memLp_id_gaussianReal 2).sub (memLp_const _)).integrable_sq.div_const _
          rw [integral_add hA hB', integral_add (integrable_const _) hD, integral_const,
            probReal_univ, one_smul, integral_div, integral_div,
            Snuffy.GaussianKL.integral_sq_sub_gaussian, Snuffy.GaussianKL.integral_sq_sub_gaussian,
            sub_self]
          simp only [B]
          field_simp
          ring
  have hint_llr : Integrable (llr J (PX ⊗ₘ Kernel.const ℝ Q)) J := hfint.congr hllr.symm
  rw [klDiv_of_ac_of_integrable hac hint_llr, integral_congr_ae hllr, probReal_univ, probReal_univ,
    add_sub_cancel_right, Measure.integral_compProd hfint]
  congr 1
  have hinner : ∀ x : ℝ, ∫ y, quad g v m s (x, y) ∂(chan g v x)
      = Real.log ((s : ℝ) / v) / 2 - 1 / 2 + ((v : ℝ) + (g * x - g * m) ^ 2) / (2 * s) := by
    intro x
    rw [chan_apply]
    have h := integral_quadratic_gaussian (g * x) (g * m) (Real.log ((s : ℝ) / v) / 2) (v := v) (s : ℝ)
    rw [hv2] at h
    exact h
  simp_rw [hinner]
  have hE : Integrable (fun _ : ℝ => Real.log ((s : ℝ) / v) / 2 - 1 / 2) PX := integrable_const _
  have hG : Integrable (fun x : ℝ => g ^ 2 * (x - m) ^ 2) PX := hXm.const_mul _
  have hF : Integrable (fun x : ℝ => ((v : ℝ) + (g * x - g * m) ^ 2) / (2 * s)) PX := by
    have h1 : Integrable (fun x : ℝ => ((v : ℝ) + g ^ 2 * (x - m) ^ 2) / (2 * s)) PX :=
      ((integrable_const (v : ℝ)).add hG).div_const _
    refine h1.congr (Filter.Eventually.of_forall fun x => ?_)
    simp only
    ring
  rw [integral_add hE hF, integral_const, probReal_univ, one_smul, integral_div]
  have hsplit : (fun x : ℝ => (v : ℝ) + (g * x - g * m) ^ 2)
      = fun x => (v : ℝ) + g ^ 2 * (x - m) ^ 2 := by
    funext x; ring
  rw [hsplit, integral_add (integrable_const _) hG, integral_const, probReal_univ, one_smul,
    integral_const_mul]
  have h12 : ((v : ℝ) + g ^ 2 * V) / (2 * s) = 1 / 2 := by
    rw [hsR]; field_simp; ring
  rw [h12]
  ring

include hv in
/-- **The Gaussian maximum-entropy bound for the scalar channel.** For every
input law with finite second moment and variance `V`,
`I(X ; Y) ≤ ½ ln(1 + g² V / v)`. -/
theorem gaussian_channel_bound (hX : MemLp id 2 PX) :
    Snuffy.Information.mutualInfo (PX ⊗ₘ chan g v)
      ≤ ENNReal.ofReal (Real.log (1 + g ^ 2 * (∫ x, (x - ∫ y, y ∂PX) ^ 2 ∂PX) / v) / 2) := by
  have hvpos : (0 : ℝ) < v := NNReal.coe_pos.mpr (pos_iff_ne_zero.mpr hv)
  have hgold := Snuffy.Information.mutualInfo_le_klDiv (PX ⊗ₘ chan g v)
    (gaussianReal (g * ∫ y, y ∂PX) (outVar g PX v))
  rw [Measure.fst_compProd, ← Measure.compProd_const, klDiv_chan g hv PX hX, coe_outVar] at hgold
  have heq : (g ^ 2 * ∫ x, (x - ∫ y, y ∂PX) ^ 2 ∂PX + v) / (v : ℝ)
      = 1 + g ^ 2 * (∫ x, (x - ∫ y, y ∂PX) ^ 2 ∂PX) / v := by
    field_simp
    ring
  rw [heq] at hgold
  exact hgold

end Bound

end Snuffy.GaussianChannel
