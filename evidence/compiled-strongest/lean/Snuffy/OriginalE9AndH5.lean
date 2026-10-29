import Mathlib.Basic.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum

/-! Exact inference tests. The E9 result is a finite-speed observation
obstruction, conditional on 'global' meaning sound detection at a remote
observer. It does not assume a definition of Gemini's unspecified metric.
The H5 result separates the original local per-step inequality from a
uniform-in-time total entropy ceiling.
-/
namespace GeminiOriginalInterfaces

def localRun (initial : Nat → Bool) : Nat → Nat → Bool
  | 0, site => initial site
  | n+1, 0 => localRun initial n 0
  | n+1, site+1 => localRun initial n site

def healthy : Nat → Bool := fun _ => false
def attacked : Nat → Bool := fun site => decide (site=0)

theorem finite_speed_indistinguishability (n site : Nat) (outside : n<site) :
    localRun attacked n site=localRun healthy n site := by
  induction n generalizing site with
  | zero =>
      have positive : site≠0 := by omega
      simp [localRun,attacked,healthy,positive]
  | succ n ih =>
      cases site with
      | zero => omega
      | succ site => exact ih site (by omega)

theorem no_sound_remote_alarm_before_arrival (n site : Nat) (outside : n<site)
    (alarm : Bool → Bool) :
    ¬ (alarm (localRun healthy n site)=false ∧ alarm (localRun attacked n site)=true) := by
  rw [finite_speed_indistinguishability n site outside]
  intro both
  rw [both.1] at both
  exact Bool.false_ne_true both.2

def localGuard (production flux drift : ℝ) : Prop := production-flux ≤ drift

theorem h5_local_rate_does_not_bound_total_entropy :
    localGuard 1 0 1 ∧ (0:ℝ)+1-0≤1 ∧ ¬ ((0:ℝ)+1-0+1-0≤1) := by
  norm_num [localGuard]

end GeminiOriginalInterfaces

