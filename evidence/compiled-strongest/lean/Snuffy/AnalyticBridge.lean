import Mathlib.Analysis.Calculus.Deriv.MeanValue
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.FunProp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-! Derive barrier safety and transient decay by an integrating factor.
The integral is a real interval integral. Continuation dominance retains
maintenance cost and a nonzero protected hazard bound. -/
namespace GeminiThirteenAnalysis
noncomputable section
open Set Filter MeasureTheory

theorem integrating_factor_monotone (f derivative : ℝ → ℝ) (rate : ℝ)
    (differentiable : ∀ t ∈ Ici (0:ℝ), HasDerivAt f (derivative t) t)
    (barrier : ∀ t ∈ Ici (0:ℝ), 0 ≤ derivative t+rate*f t) :
    MonotoneOn (fun t => Real.exp (rate*t)*f t) (Ici 0) := by
  have productDerivative : ∀ t ∈ Ici (0:ℝ),
      HasDerivAt (fun v => Real.exp (rate*v)*f v)
        (Real.exp (rate*t)*(rate*f t+derivative t)) t := by
    intro t ht
    have raw := (((hasDerivAt_id t).const_mul rate).exp).mul (differentiable t ht)
    convert raw using 1
    · rfl
    · dsimp only [id_eq]
      ring
  apply monotoneOn_of_hasDerivWithinAt_nonneg (convex_Ici 0)
  · intro t ht
    exact (productDerivative t ht).continuousAt.continuousWithinAt
  · intro t ht
    exact (productDerivative t (interior_subset ht)).hasDerivWithinAt
  · intro t ht
    exact mul_nonneg (Real.exp_pos _).le (by linarith [barrier t (interior_subset ht)])

theorem linear_barrier_preserves_safety (f derivative : ℝ → ℝ) (rate : ℝ)
    (differentiable : ∀ t ∈ Ici (0:ℝ), HasDerivAt f (derivative t) t)
    (barrier : ∀ t ∈ Ici (0:ℝ), 0 ≤ derivative t+rate*f t)
    (initial : 0 ≤ f 0) (t : ℝ) (elapsed : 0 ≤ t) : 0 ≤ f t := by
  have mono := integrating_factor_monotone f derivative rate differentiable barrier
  have lower := mono (by simp) elapsed elapsed
  simp only [mul_zero,Real.exp_zero,one_mul] at lower
  have nonnegative : 0 ≤ Real.exp (rate*t)*f t := le_trans initial lower
  by_contra negative
  have strict := mul_neg_of_pos_of_neg (Real.exp_pos (rate*t)) (lt_of_not_ge negative)
  linarith

theorem exponential_transient_bound (f derivative : ℝ → ℝ) (rate : ℝ)
    (differentiable : ∀ t ∈ Ici (0:ℝ), HasDerivAt f (derivative t) t)
    (decay : ∀ t ∈ Ici (0:ℝ), derivative t+rate*f t ≤ 0)
    (t : ℝ) (elapsed : 0 ≤ t) : f t ≤ f 0*Real.exp (-rate*t) := by
  have mono := integrating_factor_monotone (fun t => -f t) (fun t => -derivative t) rate
    (fun t ht => (differentiable t ht).neg) (fun t ht => by linarith [decay t ht])
  have lower := mono (by simp) elapsed elapsed
  simp only [mul_zero,Real.exp_zero,one_mul] at lower
  have upper : Real.exp (rate*t)*f t ≤ f 0 := by nlinarith
  have unit : Real.exp (rate*t)*Real.exp (-rate*t)=1 := by
    rw [← Real.exp_add]
    ring_nf
    exact Real.exp_zero
  calc
    f t = (Real.exp (rate*t)*f t)*Real.exp (-rate*t) := by
      rw [mul_right_comm,unit,one_mul]
    _ ≤ f 0*Real.exp (-rate*t) := mul_le_mul_of_nonneg_right upper (Real.exp_pos _).le

theorem integrated_exponential_transient (rate horizon : ℝ) (positive : 0 < rate) :
    (∫ t in (0:ℝ)..horizon, Real.exp (-rate*t))=(1-Real.exp (-rate*horizon))/rate := by
  have derivative : ∀ t : ℝ,
      HasDerivAt (fun v => -Real.exp (-rate*v)/rate) (Real.exp (-rate*t)) t := by
    intro t
    have raw := ((((hasDerivAt_id t).const_mul (-rate)).exp).neg).div_const rate
    convert raw using 1
    · rfl
    · dsimp only [id_eq]
      field_simp
  have integral := intervalIntegral.integral_eq_sub_of_hasDerivAt
    (fun t _ => derivative t)
    ((show Continuous (fun t : ℝ => Real.exp (-rate*t)) by fun_prop).intervalIntegrable 0 horizon)
  rw [integral]
  simp only [mul_zero,Real.exp_zero]
  ring

theorem integrated_transient_cost_bound (cost : ℝ → ℝ)
    (base initialExcess rate horizon : ℝ) (elapsed : 0 ≤ horizon) (positive : 0 < rate)
    (integrable : IntervalIntegrable cost volume 0 horizon)
    (envelope : ∀ t ∈ Icc 0 horizon, cost t ≤ base+initialExcess*Real.exp (-rate*t)) :
    (∫ t in (0:ℝ)..horizon, cost t) ≤
      base*horizon+initialExcess*(1-Real.exp (-rate*horizon))/rate := by
  have continuous : Continuous (fun t : ℝ => base+initialExcess*Real.exp (-rate*t)) := by fun_prop
  have bound := intervalIntegral.integral_mono_on elapsed integrable
    (continuous.intervalIntegrable 0 horizon) envelope
  rw [intervalIntegral.integral_add (intervalIntegrable_const)
    ((show Continuous (fun t : ℝ => initialExcess*Real.exp (-rate*t)) by fun_prop).intervalIntegrable 0 horizon),
    intervalIntegral.integral_const,intervalIntegral.integral_const_mul,
    integrated_exponential_transient rate horizon positive] at bound
  simpa only [sub_zero,smul_eq_mul,mul_comm horizon,mul_div_assoc] using bound

theorem continuation_hazard_threshold (reward cost discount protectedHazard defectHazard : ℝ)
    (protectedDenominator : 0 < discount+protectedHazard)
    (defectDenominator : 0 < discount+defectHazard)
    (netPositive : 0 < reward-cost) :
    reward/(discount+defectHazard) < (reward-cost)/(discount+protectedHazard) ↔
      reward*(discount+protectedHazard)/(reward-cost)-discount < defectHazard := by
  rw [div_lt_div_iff₀ defectDenominator protectedDenominator]
  constructor
  · intro better
    have ratio : reward*(discount+protectedHazard)/(reward-cost) < discount+defectHazard := by
      apply (div_lt_iff₀ netPositive).mpr
      nlinarith
    linarith
  · intro threshold
    have ratio : reward*(discount+protectedHazard)/(reward-cost) < discount+defectHazard := by
      linarith
    have := (div_lt_iff₀ netPositive).mp ratio
    nlinarith

theorem heterogeneous_quadratic_cost_identity (first : ℝ) :
    first^2+4*(1-first)^2=4/5+5*(first-4/5)^2 := by ring

theorem heterogeneous_uniform_is_not_minimum :
    (4/5:ℝ)^2+4*(1/5)^2 < (1/2)^2+4*(1/2)^2 := by norm_num

theorem eventually_better_continuation
    (reward cost discount protectedHazard : ℝ) (neglectedHazard : ℝ → ℝ)
    (discountPositive : 0 < discount) (protectedNonnegative : 0 ≤ protectedHazard)
    (hazardNonnegative : ∀ t ∈ Ici (0:ℝ), 0 ≤ neglectedHazard t)
    (netPositive : 0 < reward-cost)
    (diverges : Tendsto neglectedHazard atTop atTop) :
    ∃ start : ℝ, ∀ t ≥ start,
      reward/(discount+neglectedHazard t) < (reward-cost)/(discount+protectedHazard) := by
  let threshold := reward*(discount+protectedHazard)/(reward-cost)-discount
  have eventuallyHigh : ∀ᶠ t in atTop, threshold+1 ≤ neglectedHazard t :=
    (tendsto_atTop.1 diverges) (threshold+1)
  obtain ⟨start,after⟩ := eventually_atTop.1 eventuallyHigh
  refine ⟨max start 0,?_⟩
  intro t ht
  have elapsed : 0 ≤ t := le_trans (le_max_right _ _) ht
  have large := after t (le_trans (le_max_left _ _) ht)
  apply (continuation_hazard_threshold reward cost discount protectedHazard (neglectedHazard t)
    (by linarith) (by linarith [hazardNonnegative t elapsed]) netPositive).mpr
  change threshold < neglectedHazard t
  linarith

end
end GeminiThirteenAnalysis

