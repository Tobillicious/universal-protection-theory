import Mathlib.Basic.Real.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Lean.Elab.Tactic.Omega
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-! A discrete rank proves a trace length, unlike asymptotic real-valued
Lyapunov decay. Coalition penalties are compared against TOTAL gains. -/
namespace GeminiThirteenExecution
open scoped BigOperators

theorem ranked_trace_length {S : Type*} (trace : Nat → S) (rank : S → Nat)
    (steps : Nat)
    (descent : ∀ i < steps, rank (trace (i+1)) < rank (trace i)) :
    steps+rank (trace steps) ≤ rank (trace 0) := by
  induction steps with
  | zero => simp
  | succ n ih =>
      have earlier := ih (fun i hi => descent i (by omega))
      have last := descent n (by omega)
      omega

theorem ranked_polynomial_step_bound {S : Type*}
    (trace : Nat → S) (rank : S → Nat) (steps inputSize power : Nat)
    (initial : rank (trace 0) ≤ inputSize^power)
    (descent : ∀ i < steps, rank (trace (i+1)) < rank (trace i)) :
    steps ≤ inputSize^power := by
  have length := ranked_trace_length trace rank steps descent
  omega

theorem total_penalty_excludes_all_members_gaining {I : Type*}
    (coalition : Finset I) (gain penalty : I → ℝ)
    (strict : (∑ i ∈ coalition, gain i)<∑ i ∈ coalition, penalty i) :
    ∃ i ∈ coalition, gain i-penalty i<0 := by
  classical
  by_contra noLoser
  have each : ∀ i ∈ coalition, 0 ≤ gain i-penalty i := by
    intro i hi
    exact le_of_not_gt (fun loses => noLoser ⟨i,hi,loses⟩)
  have total := Finset.sum_nonneg each
  rw [Finset.sum_sub_distrib] at total
  linarith

theorem real_lyapunov_descent_need_not_terminate (n : Nat) :
    0<(1/2:ℝ)^n ∧
    ((1/2:ℝ)^(n+1))^2-((1/2:ℝ)^n)^2= -(3/4)*((1/2:ℝ)^n)^2 := by
  constructor
  · exact pow_pos (by norm_num) n
  · rw [show (1/2:ℝ)^(n+1)=(1/2:ℝ)^n*(1/2) from pow_succ _ n]
    ring

end GeminiThirteenExecution

