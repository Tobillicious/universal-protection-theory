import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum

/-! Original D1 defines discounted accumulated utility. A positive fatal
hazard makes survival probability tend to zero, but does not erase utility
earned before failure. The actual improper integrals are evaluated here.
-/
namespace GeminiOriginalD1
noncomputable section
open MeasureTheory Set Filter
open scoped Topology

def expectedValue (reward discount hazard : ℝ) : ℝ :=
  ∫ t : ℝ in Ioi 0, reward*Real.exp (-(discount+hazard)*t)

theorem expected_value_formula (reward discount hazard : ℝ)
    (decay : 0 < discount+hazard) :
    expectedValue reward discount hazard = reward/(discount+hazard) := by
  unfold expectedValue
  rw [integral_const_mul]
  rw [integral_exp_mul_Ioi (by linarith : -(discount+hazard)<0) 0]
  simp only [mul_zero,Real.exp_zero,neg_div_neg_eq]
  ring

theorem original_dominance_counterexample :
    expectedValue 1 1 1=1/2 ∧ expectedValue (1-3/4) 1 0=1/4 ∧
    expectedValue (1-3/4) 1 0 < expectedValue 1 1 1 := by
  rw [expected_value_formula 1 1 1 (by norm_num),
      expected_value_formula (1-3/4) 1 0 (by norm_num)]
  norm_num

/-- exp(-t) on positive lifetimes is a normalized nonnegative density. -/
theorem lifetime_density_is_normalized :
    (∀ t : ℝ, 0 ≤ Real.exp (-t)) ∧ (∫ t : ℝ in Ioi 0, Real.exp (-t))=1 := by
  exact ⟨fun t => (Real.exp_pos (-t)).le,integral_exp_neg_Ioi_zero⟩

theorem lifetime_survival_tail (t : ℝ) :
    (∫ u : ℝ in Ioi t, Real.exp (-u))=Real.exp (-t) := integral_exp_neg_Ioi t

theorem zero_ultimate_survival_with_positive_accumulated_value :
    Tendsto (fun t : ℝ => Real.exp (-t)) atTop (𝓝 0) ∧ 0<expectedValue 1 1 1 := by
  constructor
  · exact Real.tendsto_exp_neg_atTop_nhds_zero
  · rw [expected_value_formula 1 1 1 (by norm_num)]
    norm_num

end
end GeminiOriginalD1

