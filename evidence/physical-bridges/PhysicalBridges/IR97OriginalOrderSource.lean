import PhysicalBridges.IRMandatoryBaselineMaximality

/-! IR-97: original-order maximality, preserving the exact IR-71
feasible family and original two-stage lexicographic order. -/
namespace PhysicalBridges.IR97

open IRCoupledFinitaryTwoStage
open IRMandatoryBaselineMaximality

theorem original_order_mandatory_baseline
    (forbidden : List Fact → Prop) (required : Outcome)
    (baselineFeasible :
      IRCoupledFinitaryTwoStage.Feasible forbidden required) :
    UPTExist.LexAlignedL
      (RequiredFeasible forbidden required)
      ([firstKey,secondKey] : List (Outcome → Nat → Prop))
      (finalProtected forbidden required) :=
  required_baseline_full_feasible_original_lex_maximal
    forbidden required baselineFeasible

end PhysicalBridges.IR97
