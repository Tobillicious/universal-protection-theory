/-
Snuffy — Canon Edition v4.1: the scalar Gaussian channel over an arbitrary
input space — block 4b of the Gaussian maximum-entropy bound (§11).

For any measurable space of inputs, input law P and measurable signal
w : α → ℝ with finite second moment (mean m, variance V), the channel is the
Markov kernel x ↦ N(w x, v), and

  * llr_chanW — its log-likelihood ratio against P ⊗ N(m, s) is the explicit
    quadratic almost everywhere;
  * klDiv_chanW — KL(P ⊗ chanW ‖ P ⊗ N(m, V + v)) = ½ ln((V + v)/v).

Each output coordinate of the vector channel, w_i(x) = (G x)_i, is an
instance.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.GaussianChannel

open MeasureTheory ProbabilityTheory InformationTheory Real
open scoped ENNReal NNReal

namespace Snuffy.GaussianChannelGen

open Snuffy.GaussianChannel

variable {α : Type*} [MeasurableSpace α]

/-- The Gaussian channel `x ↦ N(w x, v)`. -/
noncomputable def chanW (w : α → ℝ) (hw : Measurable w) (v : ℝ≥0) : Kernel α ℝ where
  toFun x := gaussianReal (w x) v
  measurable' := measurable_gaussianReal.comp (Measurable.prodMk hw measurable_const)

theorem chanW_apply (w : α → ℝ) (hw : Measurable w) (v : ℝ≥0) (x : α) :
    chanW w hw v x = gaussianReal (w x) v := rfl

instance (w : α → ℝ) (hw : Measurable w) (v : ℝ≥0) : IsMarkovKernel (chanW w hw v) :=
  ⟨fun x => by rw [chanW_apply]; infer_instance⟩

section Bound

variable (w : α → ℝ) (hw : Measurable w) {v : ℝ≥0} (hv : v ≠ 0) (P : Measure α)
  [IsProbabilityMeasure P]

/-- The quadratic log-likelihood ratio against `P ⊗ N(m, s)`. -/
noncomputable def quadW (v : ℝ≥0) (m : ℝ) (s : ℝ≥0) (p : α × ℝ) : ℝ :=
  Real.log ((s : ℝ) / v) / 2 - (p.2 - w p.1) ^ 2 / (2 * v) + (p.2 - m) ^ 2 / (2 * s)

include hw in
theorem measurable_quadW (v : ℝ≥0) (m : ℝ) (s : ℝ≥0) : Measurable (quadW w v m s) := by
  unfold quadW
  have h : Measurable fun p : α × ℝ => w p.1 := hw.comp measurable_fst
  fun_prop

include hv in
/-- **The log-likelihood ratio of the channel.** -/
theorem llr_chanW (m : ℝ) {s : ℝ≥0} (hs : s ≠ 0) :
    llr (P ⊗ₘ chanW w hw v) (P ⊗ₘ Kernel.const α (gaussianReal m s))
      =ᵐ[P ⊗ₘ chanW w hw v] quadW w v m s := by
  set Q := gaussianReal m s
  have hacx : ∀ x, chanW w hw v x ≪ Q := fun x =>
    (gaussianReal_absolutelyContinuous (w x) hv).trans (gaussianReal_absolutelyContinuous' _ hs)
  have hac : P ⊗ₘ chanW w hw v ≪ P ⊗ₘ Kernel.const α Q :=
    Measure.AbsolutelyContinuous.compProd_right (Filter.Eventually.of_forall hacx)
  have hA := hac.ae_le (rnDeriv_measure_compProd_right P (chanW w hw v) (Kernel.const α Q))
  have hB : ∀ᵐ p ∂(P ⊗ₘ chanW w hw v),
      Real.log ((chanW w hw v).rnDeriv (Kernel.const α Q) p.1 p.2).toReal = quadW w v m s p := by
    rw [Measure.ae_compProd_iff (measurableSet_eq_fun
      ((Kernel.measurable_rnDeriv _ _).ennreal_toReal.log) (measurable_quadW w hw v m s))]
    refine Filter.Eventually.of_forall fun x => ?_
    have h1 := Kernel.rnDeriv_eq_rnDeriv_measure (κ := chanW w hw v) (η := Kernel.const α Q) (a := x)
    have h2 := Snuffy.GaussianKL.llr_gaussian_gaussian (m₁ := w x) (m₂ := m) hv hs
    filter_upwards [(hacx x).ae_le h1, h2] with y hy1 hy2
    rw [hy1]
    exact hy2
  filter_upwards [hA, hB] with p hp1 hp2
  rw [llr_def]
  simp only
  rw [hp1]
  exact hp2

/-- The reference output variance `Var w + v`. -/
noncomputable def outVarW (v : ℝ≥0) : ℝ≥0 :=
  ⟨∫ x, (w x - ∫ y, w y ∂P) ^ 2 ∂P + v,
    add_nonneg (integral_nonneg (f := fun x => (w x - ∫ y, w y ∂P) ^ 2) fun _ => sq_nonneg _) v.2⟩

omit [IsProbabilityMeasure P] in
theorem coe_outVarW (v : ℝ≥0) :
    (outVarW w P v : ℝ) = ∫ x, (w x - ∫ y, w y ∂P) ^ 2 ∂P + v := rfl

include hv in
/-- **KL of the channel against the Gaussian reference output.** -/
theorem klDiv_chanW (hX : MemLp w 2 P) :
    klDiv (P ⊗ₘ chanW w hw v)
      (P ⊗ₘ Kernel.const α (gaussianReal (∫ y, w y ∂P) (outVarW w P v)))
      = ENNReal.ofReal (Real.log ((outVarW w P v : ℝ) / v) / 2) := by
  set m := ∫ y, w y ∂P
  set V := ∫ x, (w x - m) ^ 2 ∂P
  have hV : 0 ≤ V := integral_nonneg fun x => sq_nonneg _
  have hvpos : (0 : ℝ) < v := NNReal.coe_pos.mpr (pos_iff_ne_zero.mpr hv)
  set s : ℝ≥0 := outVarW w P v
  have hsR : (s : ℝ) = V + v := coe_outVarW w P v
  have hspos : (0 : ℝ) < s := by rw [hsR]; positivity
  have hs : s ≠ 0 := fun h => by rw [h] at hspos; simp at hspos
  set Q := gaussianReal m s
  set J := P ⊗ₘ chanW w hw v
  have hacx : ∀ x, chanW w hw v x ≪ Q := fun x =>
    (gaussianReal_absolutelyContinuous (w x) hv).trans (gaussianReal_absolutelyContinuous' _ hs)
  have hac : J ≪ P ⊗ₘ Kernel.const α Q :=
    Measure.AbsolutelyContinuous.compProd_right (Filter.Eventually.of_forall hacx)
  have hllr := llr_chanW w hw hv P m hs
  have hXm : Integrable (fun x => (w x - m) ^ 2) P :=
    (hX.sub (memLp_const m)).integrable_sq
  have hsec : ∀ x : α, ∀ t, Integrable (fun y : ℝ => (y - t) ^ 2) (chanW w hw v x) := fun x t => by
    rw [chanW_apply]; exact ((memLp_id_gaussianReal 2).sub (memLp_const t)).integrable_sq
  have hfiber : ∀ x : α, Integrable (fun y => quadW w v m s (x, y)) (chanW w hw v x) := fun x =>
    ((integrable_const (Real.log ((s : ℝ) / v) / 2)).sub ((hsec x (w x)).div_const _)).add
      ((hsec x m).div_const _)
  set B : α → ℝ := fun x =>
    |Real.log ((s : ℝ) / v) / 2| + 1 / 2 + ((v : ℝ) + (w x - m) ^ 2) / (2 * s)
  have hBint : Integrable B P := by
    have h1 : Integrable (fun x => (v : ℝ) + (w x - m) ^ 2) P :=
      (integrable_const _).add hXm
    have h2 : Integrable (fun x => ((v : ℝ) + (w x - m) ^ 2) / (2 * s)) P := h1.div_const _
    exact (integrable_const _).add h2
  have hv2 : (v : ℝ) / (2 * v) = 1 / 2 := by field_simp
  have hfint : Integrable (quadW w v m s) J := by
    rw [Measure.integrable_compProd_iff (measurable_quadW w hw v m s).aestronglyMeasurable]
    refine ⟨Filter.Eventually.of_forall hfiber, hBint.mono'
      ((measurable_quadW w hw v m s).norm.stronglyMeasurable.integral_kernel_prod_right').aestronglyMeasurable
      (Filter.Eventually.of_forall fun x => ?_)⟩
    rw [Real.norm_of_nonneg (integral_nonneg fun y => norm_nonneg _)]
    have hmaj : Integrable (fun y : ℝ => |Real.log ((s : ℝ) / v) / 2| + (y - w x) ^ 2 / (2 * v)
        + (y - m) ^ 2 / (2 * s)) (chanW w hw v x) :=
      ((integrable_const _).add ((hsec x (w x)).div_const _)).add ((hsec x m).div_const _)
    calc ∫ y, ‖quadW w v m s (x, y)‖ ∂(chanW w hw v x)
        ≤ ∫ y, (|Real.log ((s : ℝ) / v) / 2| + (y - w x) ^ 2 / (2 * v)
            + (y - m) ^ 2 / (2 * s)) ∂(chanW w hw v x) := by
          refine integral_mono (hfiber x).norm hmaj fun y => ?_
          have h1 : 0 ≤ (y - w x) ^ 2 / (2 * v) := by positivity
          have h2 : 0 ≤ (y - m) ^ 2 / (2 * s) := by positivity
          have h3 := le_abs_self (Real.log ((s : ℝ) / v) / 2)
          have h4 := neg_abs_le (Real.log ((s : ℝ) / v) / 2)
          simp only [quadW, Real.norm_eq_abs]
          rw [abs_le]
          constructor <;> linarith
      _ = B x := by
          rw [chanW_apply]
          have hA : Integrable (fun y : ℝ => |Real.log ((s : ℝ) / v) / 2| + (y - w x) ^ 2 / (2 * v))
              (gaussianReal (w x) v) :=
            (integrable_const _).add
              (((memLp_id_gaussianReal 2).sub (memLp_const _)).integrable_sq.div_const _)
          have hB' : Integrable (fun y : ℝ => (y - m) ^ 2 / (2 * s)) (gaussianReal (w x) v) :=
            ((memLp_id_gaussianReal 2).sub (memLp_const _)).integrable_sq.div_const _
          have hD : Integrable (fun y : ℝ => (y - w x) ^ 2 / (2 * v)) (gaussianReal (w x) v) :=
            ((memLp_id_gaussianReal 2).sub (memLp_const _)).integrable_sq.div_const _
          rw [integral_add hA hB', integral_add (integrable_const _) hD, integral_const,
            probReal_univ, one_smul, integral_div, integral_div,
            Snuffy.GaussianKL.integral_sq_sub_gaussian, Snuffy.GaussianKL.integral_sq_sub_gaussian,
            sub_self]
          simp only [B]
          field_simp
          ring
  have hint_llr : Integrable (llr J (P ⊗ₘ Kernel.const α Q)) J := hfint.congr hllr.symm
  rw [klDiv_of_ac_of_integrable hac hint_llr, integral_congr_ae hllr, probReal_univ, probReal_univ,
    add_sub_cancel_right, Measure.integral_compProd hfint]
  congr 1
  have hinner : ∀ x : α, ∫ y, quadW w v m s (x, y) ∂(chanW w hw v x)
      = Real.log ((s : ℝ) / v) / 2 - 1 / 2 + ((v : ℝ) + (w x - m) ^ 2) / (2 * s) := by
    intro x
    rw [chanW_apply]
    have h := integral_quadratic_gaussian (w x) m (Real.log ((s : ℝ) / v) / 2) (v := v) (s : ℝ)
    rw [hv2] at h
    exact h
  simp_rw [hinner]
  have hE : Integrable (fun _ : α => Real.log ((s : ℝ) / v) / 2 - 1 / 2) P := integrable_const _
  have hF : Integrable (fun x => ((v : ℝ) + (w x - m) ^ 2) / (2 * s)) P :=
    ((integrable_const (v : ℝ)).add hXm).div_const _
  rw [integral_add hE hF, integral_const, probReal_univ, one_smul, integral_div,
    integral_add (integrable_const _) hXm, integral_const, probReal_univ, one_smul]
  have h12 : ((v : ℝ) + V) / (2 * s) = 1 / 2 := by
    rw [hsR]; field_simp; ring
  rw [h12]
  ring

end Bound

end Snuffy.GaussianChannelGen
