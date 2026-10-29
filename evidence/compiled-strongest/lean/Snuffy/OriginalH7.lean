import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-! Work directly on Gemini's original diffusion/grounding equation:
  x' = w(y-x)-x, y' = w(x-y)-y, E_local(z)=z^2/2.
An explicit solution and limit are proved for EVERY nonnegative w.
This tests the claimed universal high-coupling groupthink threshold without
changing the submitted equation or adding a different consensus algorithm.
-/
namespace GeminiOriginalH7
noncomputable section
open Filter
open scoped Topology

def decay (amplitude rate t : ℝ) : ℝ := amplitude*Real.exp (-rate*t)
def left (mean difference coupling t : ℝ) : ℝ :=
  decay mean 1 t+decay difference (1+2*coupling) t
def right (mean difference coupling t : ℝ) : ℝ :=
  decay mean 1 t-decay difference (1+2*coupling) t

theorem decay_derivative (amplitude rate t : ℝ) :
    HasDerivAt (decay amplitude rate) (-rate*decay amplitude rate t) t := by
  have raw := (((hasDerivAt_id t).const_mul (-rate)).exp).const_mul amplitude
  change HasDerivAt (fun u : ℝ => amplitude*Real.exp (-rate*u))
    (-rate*(amplitude*Real.exp (-rate*t))) t
  simpa only [id_eq,mul_one,mul_assoc,mul_comm,mul_left_comm] using raw

theorem solves_original_equation (mean difference coupling t : ℝ) :
    HasDerivAt (left mean difference coupling)
      (coupling*(right mean difference coupling t-left mean difference coupling t)
        -left mean difference coupling t) t ∧
    HasDerivAt (right mean difference coupling)
      (coupling*(left mean difference coupling t-right mean difference coupling t)
        -right mean difference coupling t) t := by
  constructor
  · have raw := (decay_derivative mean 1 t).add (decay_derivative difference (1+2*coupling) t)
    convert raw using 1 <;> (try funext u) <;> (try dsimp [left,right]); ring
  · have raw := (decay_derivative mean 1 t).sub (decay_derivative difference (1+2*coupling) t)
    convert raw using 1 <;> (try funext u) <;> (try dsimp [left,right]); ring

theorem decay_limit (amplitude rate : ℝ) (positive : 0 < rate) :
    Tendsto (decay amplitude rate) atTop (𝓝 0) := by
  have exponent : Tendsto (fun t : ℝ => -rate*t) atTop atBot :=
    tendsto_id.const_mul_atTop_of_neg (neg_neg_of_pos positive)
  change Tendsto (fun t : ℝ => amplitude*Real.exp (-rate*t)) atTop (𝓝 0)
  simpa only [Function.comp_apply,mul_zero] using (Real.tendsto_exp_atBot.comp exponent).const_mul amplitude

theorem all_nonnegative_couplings_converge
    (mean difference coupling : ℝ) (nonnegative : 0 ≤ coupling) :
    Tendsto (left mean difference coupling) atTop (𝓝 0) ∧
    Tendsto (right mean difference coupling) atTop (𝓝 0) := by
  have slow := decay_limit mean 1 zero_lt_one
  have fast := decay_limit difference (1+2*coupling) (by linarith)
  constructor
  · change Tendsto (fun t : ℝ => decay mean 1 t+decay difference (1+2*coupling) t) atTop (𝓝 0)
    simpa only [add_zero] using slow.add fast
  · change Tendsto (fun t : ℝ => decay mean 1 t-decay difference (1+2*coupling) t) atTop (𝓝 0)
    simpa only [sub_zero] using slow.sub fast

theorem every_initial_pair_is_represented (x y coupling : ℝ) :
    left ((x+y)/2) ((x-y)/2) coupling 0=x ∧
    right ((x+y)/2) ((x-y)/2) coupling 0=y := by
  simp only [left,right,decay,mul_zero,Real.exp_zero,mul_one]
  constructor <;> ring

end
end GeminiOriginalH7

