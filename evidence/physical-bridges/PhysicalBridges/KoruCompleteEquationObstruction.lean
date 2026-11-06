/-!
# The Koru's truer equals sign: full equation versus reduced answer

This module tests the precise 5 November 2026 insight:
`1+1=2` correctly reports a numerical value, but the answer alone
does not retain two distinct operand occurrences or the operation.

The positive mathematical result is universal: a non-injective reduction
of complete descriptions admits NO decoder preserving all particulars.
An observable-only action policy cannot satisfy mutually incompatible
source-level safety obligations in two indistinguishable full states.

Neither the decoder theorem nor the policy theorem assumes UPT or X3.
Neither says all real-world physical steps must be structure-preserving.
Their role in UPT is to forbid one common inference: "same computed
objective value" implies "same complete relational outcome".

The KoruEquation record below is a deliberately minimal proof-relevant
prototype, NOT the definitive ontological Koru or full six-X3 proof.
-/

namespace PhysicalBridges.KoruCompleteEquationObstruction

/-- Operations are part of the equation, not encoded in its answer. -/
inductive Operation where
  | add
  | subtract
  deriving DecidableEq, Repr

/-- Same numerical value can belong to DIFFERENT occurrences. -/
structure Occurrence where
  identity : Nat
  value : Nat
  deriving DecidableEq, Repr

/-- An expression keeps both occurrences and their relating operation. -/
structure Expression where
  lhs : Occurrence
  rhs : Occurrence
  operation : Operation
  deriving DecidableEq, Repr

/-- The conventional numerical projection. -/
def value (e : Expression) : Nat :=
  match e.operation with
  | .add => e.lhs.value + e.rhs.value
  | .subtract => e.lhs.value - e.rhs.value

/-- A full equation with its source, result and equality witness. -/
structure KoruEquation where
  source : Expression
  result : Nat
  sound : value source = result

def firstOne : Occurrence := ⟨0, 1⟩
def secondOne : Occurrence := ⟨1, 1⟩
def three : Occurrence := ⟨0, 3⟩

def sumExpression : Expression := ⟨firstOne, secondOne, .add⟩
def subtractionExpression : Expression := ⟨three, secondOne, .subtract⟩

/-- The two `1` occurrences are numerically equal but not identical. -/
theorem one_occurrences_distinct : firstOne ≠ secondOne := by decide

/-- Both expressions return the SAME ordinary equality result. -/
theorem same_numeric_answer :
    value sumExpression = value subtractionExpression := by decide

/-- They are NOT the same expression/provenance/operation. -/
theorem expressions_distinct :
    sumExpression ≠ subtractionExpression := by decide

def koruSum : KoruEquation := ⟨sumExpression, 2, by decide⟩
def koruSubtraction : KoruEquation := ⟨subtractionExpression, 2, by decide⟩

/-- Reduced to their answers, the two distinct complete equations coincide. -/
theorem equations_have_same_answer :
    koruSum.result = koruSubtraction.result := rfl

/-- Their full Koru-prototype records are not interchangeable. -/
theorem equations_remain_distinct :
    koruSum ≠ koruSubtraction := by
  intro h
  have hsource := congrArg KoruEquation.source h
  exact expressions_distinct hsource

/-- General theorem: a reduction that merges two distinguishable wholes
cannot be inverted on EVERY whole. No UPT premises are used. -/
theorem no_decoder_of_noninjective_projection
    {Whole Answer : Type}
    (projection : Whole → Answer) (a b : Whole)
    (distinct : a ≠ b)
    (indistinguishable : projection a = projection b) :
    ¬ ∃ decoder : Answer → Whole,
      ∀ whole : Whole, decoder (projection whole) = whole := by
  rintro ⟨decoder, hdecode⟩
  have hEq : a = b := by
    calc
      a = decoder (projection a) := (hdecode a).symm
      _ = decoder (projection b) := congrArg decoder indistinguishable
      _ = b := hdecode b
  exact distinct hEq

/-- There is no universal reconstruction of the relational equation
from its numerical answer alone, even in this simple finite fragment. -/
theorem no_lossless_recovery_of_equation_from_answer :
    ¬ ∃ decoder : Nat → KoruEquation,
      ∀ q : KoruEquation, decoder q.result = q := by
  exact no_decoder_of_noninjective_projection
    KoruEquation.result koruSum koruSubtraction
    equations_remain_distinct equations_have_same_answer

/-- A general safety information theorem: when two complete histories
look identical to a reduced observer but require incompatible safe actions,
NO policy which sees only that reduced observation can protect both.

This is a boundary-action/indistinguishability obstruction. It does not
say such incompatible states occur in the complete BCRD physical source. -/
theorem no_uniform_safe_action_from_reduced_observation
    {Whole Observation Action : Type}
    (observe : Whole → Observation)
    (a b : Whole)
    (sameObservation : observe a = observe b)
    (safe : Whole → Action → Prop)
    (incompatible : ∀ act : Action, ¬ (safe a act ∧ safe b act)) :
    ¬ ∃ policy : Observation → Action,
        ∀ w : Whole, safe w (policy (observe w)) := by
  rintro ⟨policy, hsafe⟩
  have hA : safe a (policy (observe a)) := hsafe a
  have hB : safe b (policy (observe a)) := by
    rw [sameObservation]
    exact hsafe b
  exact incompatible (policy (observe a)) ⟨hA, hB⟩

/-- Toy diagnostic: the action must match the actual operation.
This is NOT an identification of an operation tag with a human's consent;
its purpose is to show reduced-score insufficiency non-vacuously. -/
def safeToyAction (e : Expression) (a : Operation) : Prop :=
  a = e.operation

theorem toy_safe_actions_incompatible (a : Operation) :
    ¬ (safeToyAction sumExpression a ∧
       safeToyAction subtractionExpression a) := by
  rintro ⟨hplus, hminus⟩
  have hp : a = Operation.add := by
    simpa [safeToyAction, sumExpression] using hplus
  have hm : a = Operation.subtract := by
    simpa [safeToyAction, subtractionExpression] using hminus
  have h : Operation.add = Operation.subtract := hp.symm.trans hm
  cases h

/-- Concrete refutation of the "numeric score alone ensures all protection"
inference. A full-state policy MAY still choose the right action. -/
theorem toy_no_score_only_safe_policy :
    ¬ ∃ policy : Nat → Operation,
      ∀ e : Expression, safeToyAction e (policy (value e)) := by
  exact no_uniform_safe_action_from_reduced_observation
    value sumExpression subtractionExpression same_numeric_answer
    safeToyAction toy_safe_actions_incompatible

/-- In contrast, a controller which retains the complete expression CAN
select the correct action for each source in this toy. -/
theorem toy_full_source_policy_exists :
    ∃ policy : Expression → Operation,
      ∀ e : Expression, safeToyAction e (policy e) := by
  exact ⟨fun e => e.operation, fun _ => rfl⟩

#print axioms same_numeric_answer
#print axioms equations_remain_distinct
#print axioms no_decoder_of_noninjective_projection
#print axioms no_lossless_recovery_of_equation_from_answer
#print axioms no_uniform_safe_action_from_reduced_observation
#print axioms toy_no_score_only_safe_policy
#print axioms toy_full_source_policy_exists

end PhysicalBridges.KoruCompleteEquationObstruction
