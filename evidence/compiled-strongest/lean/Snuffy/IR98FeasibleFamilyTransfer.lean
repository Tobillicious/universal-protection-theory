import Snuffy.IRMandatoryBaselineMaximality

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IR98FeasibleFamilyTransfer.lean` at main `740abbb` (sha256 `8828131b33984f16d9ca835b77a61deef06236957d7ff052c5e4ce6b4eae6581`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false

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
      Snuffy.Book.UPTExistence.LexAlignedL modeled
        ([firstKey, secondKey] : List (Outcome → Nat → Prop)) x)
    (hActual : actual x)
    (noNewImprover : ∀ y, actual y →
      Snuffy.Book.UPTExistence.LexBetter
        ([firstKey, secondKey] : List (Outcome → Nat → Prop)) x y →
      modeled y) :
    Snuffy.Book.UPTExistence.LexAlignedL actual
      ([firstKey, secondKey] : List (Outcome → Nat → Prop)) x := by
  refine ⟨hActual, ?_⟩
  intro y hy hBetter
  exact hModeled.2 y (noNewImprover y hy hBetter) hBetter

end PhysicalBridges.IR98
