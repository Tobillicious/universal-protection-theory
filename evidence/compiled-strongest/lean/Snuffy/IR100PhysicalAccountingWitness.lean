import Snuffy.IR99ResourceImproverCoverage

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IR100PhysicalAccountingWitness.lean` at main `740abbb` (sha256 `665a4f7cd7de03d11f8f76099b7bf88a2fa8ead57ec904a2fb580ff5b9fa8ad4`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false

/-!
IR-100: a concrete per-outcome accounting witness discharges the
resource and causal parts of IR-99. This does not independently establish
that every actual physical outcome carries the specified witness.
-/
namespace PhysicalBridges.IR100
open IRCoupledFinitaryTwoStage

structure AccountingWitness
    (weight : Nat → Fact → Nat) (capacity : Nat → Nat)
    (hard : List Fact → Prop) (required : Outcome)
    (s : Outcome) : Prop where
  channelBound : ∀ r xs, xs.Nodup →
    (∀ f, f ∈ xs → s f) →
    IRResourceDerivedClosure.charge weight r xs ≤ capacity r
  incompatibility : ∀ xs, hard xs →
    ¬ (∀ f, f ∈ xs → s f)
  requiredIncluded : Snuffy.Book.UPTExistence.Sub required s

theorem witness_implies_capacity_feasible
    (weight : Nat → Fact → Nat) (capacity : Nat → Nat)
    (hard : List Fact → Prop) (required s : Outcome)
    (h : AccountingWitness weight capacity hard required s) :
    IRResourceDerivedClosure.CapacityFeasible weight capacity hard s :=
  ⟨h.channelBound, h.incompatibility⟩

theorem witness_implies_modeled_feasible
    (weight : Nat → Fact → Nat) (capacity : Nat → Nat)
    (hard : List Fact → Prop) (required s : Outcome)
    (h : AccountingWitness weight capacity hard required s) :
    IRMandatoryBaselineMaximality.RequiredFeasible
      (IRResourceDerivedClosure.DerivedForbidden
        weight capacity hard) required s :=
  ⟨(IRResourceDerivedClosure.resource_feasible_iff_finite_forbidden
      weight capacity hard s).mp
      (witness_implies_capacity_feasible weight capacity hard required s h),
    h.requiredIncluded⟩

end PhysicalBridges.IR100
