import PhysicalBridges.IR104ThreeCaseAuthorization

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
