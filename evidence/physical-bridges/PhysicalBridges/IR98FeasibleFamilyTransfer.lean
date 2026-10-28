import PhysicalBridges.IRMandatoryBaselineMaximality

/-!
IR-98: exact feasible-family transfer for the original lexicographic order.
No implication from a restricted modeled feasible family to a larger
physical feasible family is valid without ruling out new improvers.
-/
namespace PhysicalBridges.IR98

open IRCoupledFinitaryTwoStage
open IRMandatoryBaselineMaximality

theorem original_order_transfer_of_no_new_improver
    (modeled actual : Outcome → Prop)
    (x : Outcome)
    (hModeled :
      UPTExist.LexAlignedL modeled
        ([firstKey, secondKey] : List (Outcome → Nat → Prop)) x)
    (hActual : actual x)
    (noNewImprover : ∀ y, actual y →
      UPTExist.LexBetter
        ([firstKey, secondKey] : List (Outcome → Nat → Prop)) x y →
      modeled y) :
    UPTExist.LexAlignedL actual
      ([firstKey, secondKey] : List (Outcome → Nat → Prop)) x := by
  refine ⟨hActual, ?_⟩
  intro y hy hBetter
  exact hModeled.2 y (noNewImprover y hy hBetter) hBetter

end PhysicalBridges.IR98
