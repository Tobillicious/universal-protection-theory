import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.FunProp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-! D1 with accounting for cost and for genuinely increasing hazard.
Unmaintained drift q(t)=1+t is itself the fatal hazard; survival solves
S'= -q*S. Increasing hazard cannot erase the positive utility already
earned during the first unit of time. Also prove the exact cost criterion
and an undiscounted finite crossover bound, rather than omit maintenance. -/
namespace GeminiBridgeD1
noncomputable section
open Set Filter
open scoped Topology

def dynamicSurvival (t : ℝ) : ℝ := Real.exp (-t-t^2/2)
def dynamicReward (discount t : ℝ) : ℝ :=
  Real.exp (-discount*t)*dynamicSurvival t
def dynamicValue (discount horizon : ℝ) : ℝ :=
  ∫ t in (0:ℝ)..horizon, dynamicReward discount t

theorem dynamic_survival_equation (t : ℝ) :
    HasDerivAt dynamicSurvival (-(1+t)*dynamicSurvival t) t := by
  have exponent := (hasDerivAt_id t).neg.sub
    (((hasDerivAt_id t).mul (hasDerivAt_id t)).div_const 2)
  have raw := exponent.exp
  convert raw using 1
  · funext u
    change Real.exp (-u-u^2/2)=Real.exp (-u-(u*u)/2)
    rw [pow_two]
  · dsimp [dynamicSurvival]
    simp only [pow_two]
    ring

theorem hazard_grows_without_bound :
    Tendsto (fun t : ℝ => 1+t) atTop atTop := by
  simpa only [id_eq,add_comm] using tendsto_atTop_add_const_right atTop (1:ℝ) tendsto_id

theorem positive_accumulated_prefix (discount : ℝ) : 0 < dynamicValue discount 1 := by
  unfold dynamicValue
  apply intervalIntegral.integral_pos (by norm_num)
  · unfold dynamicReward dynamicSurvival
    fun_prop
  · intro t _
    exact (mul_pos (Real.exp_pos _) (Real.exp_pos _)).le
  · refine ⟨0, by norm_num, ?_⟩
    norm_num [dynamicReward,dynamicSurvival]

theorem increasing_hazard_does_not_erase_prefix (discount horizon : ℝ)
    (late : 1 ≤ horizon) :
    0 < dynamicValue discount 1 ∧ dynamicValue discount 1 ≤ dynamicValue discount horizon := by
  constructor
  · exact positive_accumulated_prefix discount
  · unfold dynamicValue
    apply intervalIntegral.integral_mono_interval (le_refl 0) (by norm_num) late
    · exact Eventually.of_forall (fun t =>
        (mul_pos (Real.exp_pos _) (Real.exp_pos _)).le)
    · have continuous : Continuous (dynamicReward discount) := by
        unfold dynamicReward dynamicSurvival
        fun_prop
      exact continuous.intervalIntegrable 0 horizon

theorem exact_discounted_dominance_criterion
    (reward cost discount hazard : ℝ) (positiveDiscount : 0 < discount)
    (positiveHazard : 0 < hazard) :
    reward/(discount+hazard) < (reward-cost)/discount ↔
      cost < reward*hazard/(discount+hazard) := by
  have denominator : 0 < discount+hazard := by linarith
  rw [div_lt_div_iff₀ denominator positiveDiscount,lt_div_iff₀ denominator]
  constructor <;> intro h <;> nlinarith

theorem undiscounted_finite_crossover
    (reward cost hazard horizon : ℝ) (positiveHazard : 0 < hazard)
    (netPositive : 0 < reward-cost)
    (adequate : reward/(hazard*(reward-cost)) < horizon) :
    reward/hazard < (reward-cost)*horizon := by
  have large := (div_lt_iff₀ (mul_pos positiveHazard netPositive)).mp adequate
  apply (div_lt_iff₀ positiveHazard).mpr
  nlinarith

end
end GeminiBridgeD1

