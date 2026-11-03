import PhysicalBridges.ParticularSemanticsAudit
import PhysicalBridges.FrozenBCRDEvents
import PhysicalBridges.IR132ExactBoundaryReconstruction

/-!
# PR B phase 2 — full frozen operator is insufficient to decode original X3

4 November 2026 · independently sourced readout/subject-semantics test.

PR A #286 establishes the exact six-dimensional frozen-source operator is
a trace-preserving, multiplicative, transpose-preserving involutive *-automorphism
over integer matrices. This module deliberately does NOT import unmerged PR A:
the underlying exact source FrozenBCRDEvents.evolve is already on main.

This module proves an independent model-theoretic/measurement boundary:
even a COMPLETE BEFORE/AFTER OPERATOR MATRIX readout cannot determine
the original six-X3 truth value if the physical-to-particular interpretation
has not been fixed. Identical measured matrices can admit conflicting
semantic annotations in a toy extension. This is an underdetermination
model, NOT an actual physical counterexample to ALL IS, BCRD, real
consciousness or universal protection.

Source witnesses are not invented: both interpreted events use the same
exact frozen physical M0→M1 operator event. Only the subject interpretation
differs. An independent source law could exclude the negative interpretation,
but MUST be derived; it cannot be excluded by defining ActualStep as X3.
-/

namespace PhysicalBridges.BCRDOperatorSubjectGap

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.ParticularSemanticsAudit

/-- A source event with a separate, not-yet-certified subject reading.
The *physical* output is computed from the actual frozen operator.
No boolean semantic field is asserted to be a physical observable. -/
structure InterpretedEvent where
  physicalBefore : Matrix6
  subject : ToyEpisode

/-- Exact full six-by-six source input AND operator-produced output. -/
def completePhysicalReadout (e : InterpretedEvent) : Matrix6 × Matrix6 :=
  (e.physicalBefore, evolve e.physicalBefore)

/-- Full six-component original-X3 status, not the two-flag proxy. -/
def fullSubjectStatus (e : InterpretedEvent) : Bool :=
  fullSixFlag e.subject

/-- Same real source operator transition, differing only by
a hypothetical subject-level authorization interpretation. -/
def protectedInterpretation : InterpretedEvent :=
  ⟨densityBefore, good⟩

def unconsentedInterpretation : InterpretedEvent :=
  ⟨densityBefore, missing ⟨1, by decide⟩⟩

/-- Both interpreted events have exactly the same COMPLETE physical
operator pre/post history, not just equal charge, generator, or origin. -/
theorem full_operator_readouts_identical :
    completePhysicalReadout protectedInterpretation =
      completePhysicalReadout unconsentedInterpretation := rfl

/-- The common physical source transition is nontrivial, and is
exactly the source frozen M0→M1 event (all 36 matrix entries). -/
theorem both_use_real_frozen_source_transition :
    (∀ i j : Index,
      (completePhysicalReadout protectedInterpretation).2 i j =
        densityAfter i j) ∧
    (∀ i j : Index,
      (completePhysicalReadout unconsentedInterpretation).2 i j =
        densityAfter i j) := by
  constructor <;> intro i j <;> decide

/-- One interpretation meets FULL six-X3; the other fails exactly
one original duty (authorization), though the operator trace is the same. -/
theorem original_x3_statuses_disagree :
    fullSubjectStatus protectedInterpretation = true ∧
      fullSubjectStatus unconsentedInterpretation = false := by
  decide

/-- No mathematical decoder of original full-X3 from ONLY
the entire frozen before/after operator observation exists on
this explicitly unrestrained semantic-extension domain. -/
theorem no_operator_trace_only_x3_decoder :
    ¬ PhysicalBridges.IR132.ExactDecoder
      completePhysicalReadout fullSubjectStatus := by
  intro hDecoder
  have hFibres :=
    PhysicalBridges.IR132.exact_decoder_implies_fiber_constant
      completePhysicalReadout fullSubjectStatus hDecoder
  have hSame :=
    hFibres protectedInterpretation unconsentedInterpretation
      full_operator_readouts_identical
  have hDifferent := original_x3_statuses_disagree
  rw [hDifferent.1, hDifferent.2] at hSame
  cases hSame

/-- Any future independently justified exact subject-X3 readout
MUST distinguish these interpretations or derive that one is
not physically realizable. The source matrix alone cannot. -/
theorem any_exact_semantic_readout_separates_subject_interpretations
    {D : Type} (readout : InterpretedEvent → D)
    (hExact : PhysicalBridges.IR132.ExactDecoder readout fullSubjectStatus) :
    readout protectedInterpretation ≠
      readout unconsentedInterpretation := by
  intro hSame
  have hFibres :=
    PhysicalBridges.IR132.exact_decoder_implies_fiber_constant
      readout fullSubjectStatus hExact
  have hEqual :=
    hFibres protectedInterpretation unconsentedInterpretation hSame
  have hDifferent := original_x3_statuses_disagree
  rw [hDifferent.1, hDifferent.2] at hEqual
  cases hEqual

#print axioms full_operator_readouts_identical
#print axioms both_use_real_frozen_source_transition
#print axioms original_x3_statuses_disagree
#print axioms no_operator_trace_only_x3_decoder
#print axioms any_exact_semantic_readout_separates_subject_interpretations

end PhysicalBridges.BCRDOperatorSubjectGap
