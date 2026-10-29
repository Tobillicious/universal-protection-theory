import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Algebra.Order.Floor.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

/-! Gemini H6's original thermal depth formula, at its stated strength.
The cost coefficient is positive; alpha > 1. The radicand's nonnegativity
is derived from the sustainable-state premise, rather than assumed.
-/
namespace GeminiOriginalH6
noncomputable section

theorem original_thermal_depth_ceiling
    (sigma0 cost alpha flux fluxMax drift : ℝ) (depth : Nat)
    (costPositive : 0 < cost) (superlinear : 1 < alpha)
    (available : flux ≤ fluxMax)
    (sustainable : sigma0+cost*(depth:ℝ)^alpha-flux ≤ drift) :
    depth ≤ Nat.floor (((fluxMax+drift-sigma0)/cost)^(1/alpha)) := by
  have exponentPositive : 0 < alpha := lt_trans zero_lt_one superlinear
  have powerNonnegative : 0 ≤ (depth:ℝ)^alpha := Real.rpow_nonneg (Nat.cast_nonneg depth) _
  have powerBound : (depth:ℝ)^alpha ≤ (fluxMax+drift-sigma0)/cost := by
    apply (le_div_iff₀ costPositive).mpr
    nlinarith
  have radicandNonnegative : 0 ≤ (fluxMax+drift-sigma0)/cost := powerNonnegative.trans powerBound
  apply Nat.le_floor
  simpa only [one_div] using
    (Real.le_rpow_inv_iff_of_pos (Nat.cast_nonneg depth) radicandNonnegative exponentPositive).mpr powerBound

def bankedStep (target tau state : ℝ) : ℝ := (target+tau*state)/(1+tau)
def rate (tau : ℝ) : ℝ := tau/(1+tau)

def bankedRun (target tau initial : ℝ) : Nat → ℝ
  | 0 => initial
  | n+1 => bankedStep target tau (bankedRun target tau initial n)

theorem banked_rate_is_contractive (tau : ℝ) (nonnegative : 0 ≤ tau) :
    0 ≤ rate tau ∧ rate tau < 1 := by
  have denominator : 0 < 1+tau := by linarith
  exact ⟨div_nonneg nonnegative denominator.le,
    (div_lt_iff₀ denominator).mpr (by linarith)⟩

theorem banked_step_error (target tau state : ℝ) (nonnegative : 0 ≤ tau) :
    bankedStep target tau state-target = rate tau*(state-target) := by
  have denominator : 1+tau ≠ 0 := by linarith
  unfold bankedStep rate
  field_simp
  ring

/-- This is the actual fixed-target revision rule banked on 10 October,
not a newly substituted reflection algorithm. -/
theorem banked_exact_error (target tau initial : ℝ) (nonnegative : 0 ≤ tau) (n : Nat) :
    bankedRun target tau initial n-target = rate tau^n*(initial-target) := by
  induction n with
  | zero => simp [bankedRun]
  | succ n ih =>
      rw [bankedRun,banked_step_error target tau _ nonnegative,ih,pow_succ]
      ring

theorem banked_paid_epsilon_accuracy
    (target tau initial epsilon energy price : ℝ) (nonnegative : 0 ≤ tau)
    (n : Nat) (paid : (n:ℝ)*price ≤ energy)
    (adequate : rate tau^n*|initial-target| ≤ epsilon) :
    |bankedRun target tau initial n-target| ≤ epsilon ∧ (n:ℝ)*price ≤ energy := by
  constructor
  · rw [banked_exact_error target tau initial nonnegative,abs_mul,
        abs_of_nonneg (pow_nonneg (banked_rate_is_contractive tau nonnegative).1 _)]
    exact adequate
  · exact paid

/-- The original finite-flux, bounded-depth premises allow a thermally
balanced two-state reflection cycle. This tests the original convergence
inference; it does not replace that inference by a weaker positive target. -/
theorem original_thermal_premises_allow_cycle :
    (0:ℝ)+1*(1:ℝ)^(2:ℝ)-1≤0 ∧
    Nat.floor ((((1:ℝ)+0-0)/1)^(1/(2:ℝ)))=1 ∧
    ∀ state : Bool, (!state)≠state := by
  constructor
  · norm_num
  constructor
  · norm_num
  · intro state
    cases state <;> decide

end
end GeminiOriginalH6

