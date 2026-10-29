/-! A precise replacement for the termination part of the submitted H6 claim.
Every admitted reflection debits a positive amount from one finite, unreplenished
quota. The invariant bounds the number of successful reflections. It does not
derive optimal utility, unforced convergence or physical per-step energy costs.
-/
namespace UPTReflectionQuota

inductive PaidTrace : Nat → List Nat → Nat → Prop
  | done (fuel) : PaidTrace fuel [] fuel
  | step (fuel cost rest remaining)
      (positive : 0 < cost) (funded : cost ≤ fuel)
      (tail : PaidTrace (fuel-cost) rest remaining) :
      PaidTrace fuel (cost :: rest) remaining

theorem steps_bounded {fuel remaining : Nat} {costs : List Nat}
    (trace : PaidTrace fuel costs remaining) : costs.length ≤ fuel := by
  induction trace with
  | done fuel => simp
  | step fuel cost rest remaining positive funded tail ih =>
      simp only [List.length_cons]
      omega

theorem quota_conserved {fuel remaining : Nat} {costs : List Nat}
    (trace : PaidTrace fuel costs remaining) : costs.sum + remaining = fuel := by
  induction trace with
  | done fuel => simp
  | step fuel cost rest remaining positive funded tail ih =>
      simp only [List.sum_cons]
      omega

/-- No family of arbitrarily long admitted prefixes exists inside one finite
quota. Replenishment or zero-cost reflections would invalidate this statement. -/
theorem no_unbounded_paid_reflection (fuel : Nat) :
    ¬ (∀ n, ∃ costs remaining, PaidTrace fuel costs remaining ∧ costs.length = n) := by
  intro unlimited
  obtain ⟨costs, remaining, trace, length⟩ := unlimited (fuel+1)
  have bounded := steps_bounded trace
  omega

/-- A depth/energy bound alone cannot imply a fixed point. Both states cost at
most one unit under the proposed quadratic depth cost, yet toggling never stops. -/
theorem bounded_depth_can_cycle :
    (∀ depth : Bool, (if depth then 1 else 0 : Nat)^2 ≤ 1) ∧
    (∀ depth : Bool, (!depth) ≠ depth) := by decide

end UPTReflectionQuota

