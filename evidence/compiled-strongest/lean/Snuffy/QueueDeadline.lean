import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

/-! An exponential service law is normalized and has a positive finite
deadline tail even for one job admitted into an empty finite queue. -/
namespace GeminiThirteenQueue
noncomputable section
open MeasureTheory Set

theorem exponential_service_tail (rate deadline : ℝ) (positive : 0 < rate) :
    (∫ t : ℝ in Ioi deadline, rate*Real.exp (-rate*t))=Real.exp (-rate*deadline) := by
  rw [integral_const_mul,integral_exp_mul_Ioi (neg_neg_of_pos positive) deadline]
  field_simp

theorem exponential_service_normalized (rate : ℝ) (positive : 0 < rate) :
    (∀ t : ℝ, 0 ≤ rate*Real.exp (-rate*t)) ∧
    (∫ t : ℝ in Ioi 0, rate*Real.exp (-rate*t))=1 := by
  constructor
  · intro t
    exact mul_nonneg positive.le (Real.exp_pos _).le
  · rw [exponential_service_tail rate 0 positive]
    norm_num

theorem positive_deadline_miss_probability (rate deadline : ℝ) (positive : 0 < rate) :
    0 < (∫ t : ℝ in Ioi deadline, rate*Real.exp (-rate*t)) := by
  rw [exponential_service_tail rate deadline positive]
  exact Real.exp_pos _

theorem small_mean_does_not_make_tail_zero :
    (17/(22*(22-17)):ℝ)<1 ∧
    0 < (∫ t : ℝ in Ioi 1, 22*Real.exp (-22*t)) := by
  constructor
  · norm_num
  · exact positive_deadline_miss_probability 22 1 (by norm_num)

end
end GeminiThirteenQueue

