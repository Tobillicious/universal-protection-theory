/-
Snuffy — Canon Edition v4.1: the vector Gaussian channel with white noise —
block 4c of the Gaussian maximum-entropy bound (§11).

Output space ℝⁿ = `Fin n → ℝ`. Given the input x, the coordinates are
independent, Y_i ~ N(w_i x, v) (white noise of variance v); the kernel is built
one coordinate at a time through the measurable equivalence
ℝ^(n+1) ≃ ℝ × ℝⁿ. For any input law on a standard Borel space and signals w_i
with finite second moments:

  * klDiv_vecChan — KL(P ⊗ vecChan ‖ P ⊗ Π_i N(E w_i, Var w_i + v))
      = Σ_i ½ ln((Var w_i + v)/v)   (induction with KL additivity);
  * vector_channel_bound — I(X ; Y) ≤ Σ_i ½ ln(1 + Var w_i / v);
  * vector_channel_trace_bound — I(X ; Y) ≤ Σ_i Var w_i / (2v); for
    w_i = (G x)_i this is tr(G K Gᵀ)/(2v), the trace bound on which the
    calibrated cap of §11 rests.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.GaussianChannelGen
import Snuffy.KLAdditivity
import Snuffy.GoldenFormula

open MeasureTheory ProbabilityTheory InformationTheory Real Finset
open scoped ENNReal NNReal

namespace Snuffy.GaussianVector

open Snuffy.GaussianChannelGen

/-- Splitting off the first coordinate: ℝ^(n+1) ≃ ℝ × ℝⁿ. -/
noncomputable def eSucc (n : ℕ) : (Fin (n + 1) → ℝ) ≃ᵐ ℝ × (Fin n → ℝ) :=
  MeasurableEquiv.piFinSuccAbove (fun _ => ℝ) 0

variable {α : Type*} [MeasurableSpace α]

/-- The vector channel with independent coordinates `Y_i ~ N(w_i x, v)`. -/
noncomputable def vecChan (v : ℝ≥0) :
    (n : ℕ) → (w : Fin n → α → ℝ) → (∀ i, Measurable (w i)) → Kernel α (Fin n → ℝ)
  | 0, _, _ => Kernel.const α (Measure.dirac (fun i => Fin.elim0 i))
  | n + 1, w, hw =>
    (chanW (w 0) (hw 0) v ×ₖ vecChan v n (fun i => w i.succ) (fun i => hw i.succ)).map
      (eSucc n).symm

theorem isMarkov_vecChan (v : ℝ≥0) :
    ∀ (n : ℕ) (w : Fin n → α → ℝ) (hw : ∀ i, Measurable (w i)), IsMarkovKernel (vecChan v n w hw)
  | 0, _, _ => by unfold vecChan; infer_instance
  | n + 1, w, hw => by
    unfold vecChan
    have := isMarkov_vecChan v n (fun i => w i.succ) (fun i => hw i.succ)
    exact Kernel.IsMarkovKernel.map _ (eSucc n).symm.measurable

/-- The reference output law: independent Gaussians `N(m_i, s_i)`. -/
noncomputable def refMeas : (n : ℕ) → (Fin n → ℝ) → (Fin n → ℝ≥0) → Measure (Fin n → ℝ)
  | 0, _, _ => Measure.dirac (fun i => Fin.elim0 i)
  | n + 1, m, s => ((gaussianReal (m 0) (s 0)).prod
      (refMeas n (fun i => m i.succ) (fun i => s i.succ))).map (eSucc n).symm

theorem isProb_refMeas : ∀ (n : ℕ) (m : Fin n → ℝ) (s : Fin n → ℝ≥0),
    IsProbabilityMeasure (refMeas n m s)
  | 0, _, _ => by unfold refMeas; infer_instance
  | n + 1, m, s => by
    unfold refMeas
    have := isProb_refMeas n (fun i => m i.succ) (fun i => s i.succ)
    exact (Measure.isProbabilityMeasure_map_iff (eSucc n).symm.measurable.aemeasurable).mpr
      inferInstance

/-- KL is unchanged when both kernels are pushed through a measurable equivalence. -/
theorem klDiv_compProd_map_equiv {β γ : Type*} [MeasurableSpace β] [MeasurableSpace γ]
    (P : Measure α) [IsFiniteMeasure P] (κ c : Kernel α β) [IsMarkovKernel κ] [IsMarkovKernel c]
    (e : β ≃ᵐ γ) :
    klDiv (P ⊗ₘ κ.map e) (P ⊗ₘ c.map e) = klDiv (P ⊗ₘ κ) (P ⊗ₘ c) := by
  rw [Measure.compProd_map e.measurable, Measure.compProd_map e.measurable]
  exact Snuffy.KLAdditivity.klDiv_map_equiv (MeasurableEquiv.prodCongr (MeasurableEquiv.refl α) e)
    (P ⊗ₘ κ) (P ⊗ₘ c)

section Bound

variable {v : ℝ≥0} (hv : v ≠ 0) (P : Measure α) [IsProbabilityMeasure P]

/-- Mean of signal `w_i`. -/
noncomputable def meanW {n : ℕ} (w : Fin n → α → ℝ) (i : Fin n) : ℝ := ∫ y, w i y ∂P

/-- Variance of signal `w_i`. -/
noncomputable def varW {n : ℕ} (w : Fin n → α → ℝ) (i : Fin n) : ℝ :=
  ∫ x, (w i x - ∫ y, w i y ∂P) ^ 2 ∂P

omit [IsProbabilityMeasure P] in
theorem varW_nonneg {n : ℕ} (w : Fin n → α → ℝ) (i : Fin n) : 0 ≤ varW P w i :=
  integral_nonneg fun _ => sq_nonneg _

include hv in
/-- **KL of the vector channel against the Gaussian product reference.** -/
theorem klDiv_vecChan :
    ∀ (n : ℕ) (w : Fin n → α → ℝ) (hw : ∀ i, Measurable (w i)) (_hX : ∀ i, MemLp (w i) 2 P),
    klDiv (P ⊗ₘ vecChan v n w hw)
      (P ⊗ₘ Kernel.const α (refMeas n (meanW P w) (fun i => outVarW (w i) P v)))
      = ENNReal.ofReal (∑ i, Real.log ((varW P w i + v) / v) / 2)
  | 0, w, hw, _ => by
    simp only [vecChan, refMeas, univ_eq_empty, sum_empty, ENNReal.ofReal_zero]
    exact klDiv_self _
  | n + 1, w, hw, hX => by
    have := isMarkov_vecChan v n (fun i => w i.succ) (fun i => hw i.succ)
    have := isProb_refMeas n (fun i => meanW P w i.succ) (fun i => outVarW (w i.succ) P v)
    have ih := klDiv_vecChan n (fun i => w i.succ) (fun i => hw i.succ) (fun i => hX i.succ)
    have hconst : Kernel.const α (refMeas (n + 1) (meanW P w) (fun i => outVarW (w i) P v))
        = (Kernel.const α (gaussianReal (meanW P w 0) (outVarW (w 0) P v))
          ×ₖ Kernel.const α (refMeas n (fun i => meanW P w i.succ)
            (fun i => outVarW (w i.succ) P v))).map (eSucc n).symm := by
      rw [Kernel.prod_const, Kernel.map_const _ (eSucc n).symm.measurable]
      rfl
    have hvc : vecChan v (n + 1) w hw
        = (chanW (w 0) (hw 0) v ×ₖ vecChan v n (fun i => w i.succ) (fun i => hw i.succ)).map
          (eSucc n).symm := rfl
    rw [hvc, hconst, klDiv_compProd_map_equiv, Snuffy.KLAdditivity.klDiv_prod_kernel,
      show meanW P w 0 = ∫ y, w 0 y ∂P from rfl, klDiv_chanW (w 0) (hw 0) hv P (hX 0)]
    have hih : klDiv (P ⊗ₘ vecChan v n (fun i => w i.succ) (fun i => hw i.succ))
        (P ⊗ₘ Kernel.const α (refMeas n (fun i => meanW P w i.succ)
          (fun i => outVarW (w i.succ) P v)))
        = ENNReal.ofReal (∑ i : Fin n, Real.log ((varW P w i.succ + v) / v) / 2) := ih
    rw [hih, Fin.sum_univ_succ]
    have hvpos : (0 : ℝ) < v := NNReal.coe_pos.mpr (pos_iff_ne_zero.mpr hv)
    have hterm : ∀ j : Fin (n + 1), 0 ≤ Real.log ((varW P w j + v) / v) / 2 := fun j => by
      have h1 : 1 ≤ (varW P w j + v) / v := by
        rw [le_div_iff₀ hvpos]; linarith [varW_nonneg P w j]
      exact div_nonneg (Real.log_nonneg h1) (by norm_num)
    rw [coe_outVarW, show (∫ x, (w 0 x - ∫ y, w 0 y ∂P) ^ 2 ∂P) = varW P w 0 from rfl,
      ← ENNReal.ofReal_add (hterm 0) (sum_nonneg fun j _ => hterm j.succ)]

include hv in
/-- **The vector Gaussian channel bound.** For every input law on a standard
Borel space and signals with finite second moments,
`I(X ; Y) ≤ Σ_i ½ ln(1 + Var w_i / v)`. -/
theorem vector_channel_bound [StandardBorelSpace α] [Nonempty α] (n : ℕ) (w : Fin n → α → ℝ)
    (hw : ∀ i, Measurable (w i)) (hX : ∀ i, MemLp (w i) 2 P) :
    Snuffy.Information.mutualInfo (P ⊗ₘ vecChan v n w hw)
      ≤ ENNReal.ofReal (∑ i, Real.log (1 + varW P w i / v) / 2) := by
  have := isMarkov_vecChan v n w hw
  have := isProb_refMeas n (meanW P w) (fun i => outVarW (w i) P v)
  have hgold := Snuffy.Information.mutualInfo_le_klDiv (P ⊗ₘ vecChan v n w hw)
    (refMeas n (meanW P w) (fun i => outVarW (w i) P v))
  rw [Measure.fst_compProd, ← Measure.compProd_const, klDiv_vecChan hv P n w hw hX] at hgold
  have hvpos : (0 : ℝ) < v := NNReal.coe_pos.mpr (pos_iff_ne_zero.mpr hv)
  have heq : ∀ i, (varW P w i + v) / (v : ℝ) = 1 + varW P w i / v := fun i => by
    field_simp
    ring
  simp_rw [heq] at hgold
  exact hgold

include hv in
/-- **Trace form.** `I(X ; Y) ≤ Σ_i Var w_i / (2v)`. -/
theorem vector_channel_trace_bound [StandardBorelSpace α] [Nonempty α] (n : ℕ)
    (w : Fin n → α → ℝ) (hw : ∀ i, Measurable (w i)) (hX : ∀ i, MemLp (w i) 2 P) :
    Snuffy.Information.mutualInfo (P ⊗ₘ vecChan v n w hw)
      ≤ ENNReal.ofReal (∑ i, varW P w i / (2 * v)) := by
  refine (vector_channel_bound hv P n w hw hX).trans (ENNReal.ofReal_le_ofReal ?_)
  have hvpos : (0 : ℝ) < v := NNReal.coe_pos.mpr (pos_iff_ne_zero.mpr hv)
  refine sum_le_sum fun i _ => ?_
  have hpos : 0 < 1 + varW P w i / v := by
    have := varW_nonneg P w i; positivity
  have hlog := Real.log_le_sub_one_of_pos hpos
  have : varW P w i / (2 * v) = (varW P w i / v) / 2 := by field_simp
  rw [this]
  linarith

end Bound

end Snuffy.GaussianVector
