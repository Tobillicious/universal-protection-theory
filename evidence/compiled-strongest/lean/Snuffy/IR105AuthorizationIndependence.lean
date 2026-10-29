import Snuffy.IR104ThreeCaseAuthorization

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IR105AuthorizationIndependence.lean` at main `740abbb` (sha256 `2b04c17258d68e7edce717eb1bd0e12ced4a54ac9e40ae8532a5fab2f8611ef1`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false

/-!
IR-105: counterexample to inferring authorization from accounting,
including a nonzero causal contribution by the affected subject.
The physical correspondence of these predicates remains open.
-/
namespace PhysicalBridges.IR105

structure Transition where
  accounted : Bool
  subjectParticipated : Bool
  authorized : Bool
  subjectContinues : Bool
  deriving DecidableEq

def BoundaryComplete (t : Transition) : Prop :=
  t.accounted = true

def HasSubjectCausalInput (t : Transition) : Prop :=
  t.subjectParticipated = true

def ConsentValid (t : Transition) : Prop :=
  t.authorized = true

def X3Transition (t : Transition) : Prop :=
  t.subjectContinues = true ∨ ConsentValid t

def forced : Transition :=
  ⟨true, true, false, false⟩

theorem accounting_and_subject_input_do_not_imply_x3 :
    BoundaryComplete forced ∧
    HasSubjectCausalInput forced ∧
    ¬ X3Transition forced := by
  constructor
  · rfl
  constructor
  · rfl
  · intro h
    cases h with
    | inl h => cases h
    | inr h => cases h

theorem authorization_or_continuation_suffices
    (t : Transition)
    (h : t.subjectContinues = true ∨ ConsentValid t) :
    X3Transition t := h

end PhysicalBridges.IR105
