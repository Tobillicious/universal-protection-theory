import PhysicalBridges.IR98FeasibleFamilyTransfer
import PhysicalBridges.IRMandatoryBaselineMaximality

/-!
IR-99: derive no-new-improver coverage from independently checked
resource/causal constraints, rather than assuming that coverage itself.
The physical-accounting soundness premise remains explicit.
-/
namespace PhysicalBridges.IR99
open IRCoupledFinitaryTwoStage
open IRMandatoryBaselineMaximality

theorem physical_resource_soundness_implies_no_new_improver
    (weight : Nat → Fact → Nat) (capacity : Nat → Nat)
    (hard : List Fact → Prop) (required : Outcome)
    (actual : Outcome → Prop)
    (actualRespectsResources : ∀ y, actual y →
      IRResourceDerivedClosure.CapacityFeasible
        weight capacity hard y)
    (actualRespectsMandatory : ∀ y, actual y →
      UPTExist.Sub required y)
    (x : Outcome) :
    ∀ y, actual y →
      UPTExist.LexBetter
        ([firstKey, secondKey] : List (Outcome → Nat → Prop)) x y →
      RequiredFeasible
        (IRResourceDerivedClosure.DerivedForbidden
          weight capacity hard) required y := by
  intro y hy _
  exact ⟨(IRResourceDerivedClosure.resource_feasible_iff_finite_forbidden
    weight capacity hard y).mp (actualRespectsResources y hy),
    actualRespectsMandatory y hy⟩

theorem physical_accounting_original_order_maximal
    (weight : Nat → Fact → Nat) (capacity : Nat → Nat)
    (hard : List Fact → Prop) (required : Outcome)
    (actual : Outcome → Prop)
    (baselineFeasible :
      IRResourceDerivedClosure.CapacityFeasible
        weight capacity hard required)
    (actualRespectsResources : ∀ y, actual y →
      IRResourceDerivedClosure.CapacityFeasible
        weight capacity hard y)
    (actualRespectsMandatory : ∀ y, actual y →
      UPTExist.Sub required y)
    (selectedActual : actual
      (finalProtected
        (IRResourceDerivedClosure.DerivedForbidden
          weight capacity hard) required)) :
    UPTExist.LexAlignedL actual
      ([firstKey, secondKey] : List (Outcome → Nat → Prop))
      (finalProtected
        (IRResourceDerivedClosure.DerivedForbidden
          weight capacity hard) required) := by
  apply IR98.original_order_transfer_of_no_new_improver
    (RequiredFeasible
      (IRResourceDerivedClosure.DerivedForbidden
        weight capacity hard) required)
    actual
    (finalProtected
      (IRResourceDerivedClosure.DerivedForbidden
        weight capacity hard) required)
  · exact required_baseline_full_feasible_original_lex_maximal
      (IRResourceDerivedClosure.DerivedForbidden weight capacity hard)
      required
      ((IRResourceDerivedClosure.resource_feasible_iff_finite_forbidden
        weight capacity hard required).mp baselineFeasible)
  · exact selectedActual
  · exact physical_resource_soundness_implies_no_new_improver
      weight capacity hard required actual
      actualRespectsResources actualRespectsMandatory _

end PhysicalBridges.IR99
