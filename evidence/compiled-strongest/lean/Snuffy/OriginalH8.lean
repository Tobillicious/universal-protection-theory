import Mathlib.Basic.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum

/-! Gemini's ORIGINAL H8 upper bound is evaluated, not replaced by the
different assertion that equal shares minimize HHI. Four equal resistive
channels have total dissipation 4*sum(s_i^2), with genuine minimum one.
All shares in the test are strictly positive and below the original cap 1/2.
-/
namespace GeminiOriginalH8
noncomputable section

def hhi (a b c d : ℝ) : ℝ := a^2+b^2+c^2+d^2
def quadraticDissipation (a b c d : ℝ) : ℝ := 4*hhi a b c d
def originalProposedUpper (a b c d : ℝ) : ℝ :=
  1*(1+(hhi a b c d-1/4)/(1-1/4))

theorem actual_minimum_is_one (a b c d : ℝ) (normalized : a+b+c+d=1) :
    1 ≤ quadraticDissipation a b c d := by
  unfold quadraticDissipation hhi
  nlinarith [sq_nonneg (a-1/4),sq_nonneg (b-1/4),sq_nonneg (c-1/4),sq_nonneg (d-1/4)]

theorem uniform_attains_minimum : quadraticDissipation (1/4) (1/4) (1/4) (1/4)=1 := by
  norm_num [quadraticDissipation,hhi]

theorem original_bound_counterexample :
    (3/8:ℝ)+3/8+1/8+1/8=1 ∧
    (0<(3/8:ℝ) ∧ (3/8:ℝ)≤1/2) ∧
    (0<(1/8:ℝ) ∧ (1/8:ℝ)≤1/2) ∧
    hhi (3/8) (3/8) (1/8) (1/8)=5/16 ∧
    quadraticDissipation (3/8) (3/8) (1/8) (1/8)=5/4 ∧
    originalProposedUpper (3/8) (3/8) (1/8) (1/8)=13/12 ∧
    ¬ quadraticDissipation (3/8) (3/8) (1/8) (1/8) ≤
      originalProposedUpper (3/8) (3/8) (1/8) (1/8) := by
  norm_num [quadraticDissipation,hhi,originalProposedUpper]

end
end GeminiOriginalH8

