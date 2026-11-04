import PhysicalBridges.BCRDParticularCarrierCriterion
import PhysicalBridges.IR131ActionLabelledBranching
import PhysicalBridges.IR132ExactBoundaryReconstruction

/-!
# PR B phase 6 — actual frozen movement does not determine authorization or freedom

4 November 2026; focused source/subject acceptance tests.

Positive, physically grounded fact: the exact M-sector source generator
moves M0 to M1. The source does not supply TWO independently sourced
action labels, executable alternative successors or the original
particular's authentic authorization. Thus an action-labelled process
constructed faithfully with only its one named event can move but
cannot satisfy IR131.TwoWayChoice. This is a MODELING LIMIT, NOT a
claim that any real subject lacks freedom.

Second independent control: the source-generated physical histories
and recorded histories of PR B phase 4 can be delivered for EVERY
finite horizon. Two unrestricted SUBJECT INTERPRETATIONS of the SAME
physical source position retain exactly the same entire infinite
sequence of modeled finite histories, yet differ on consent status.
So no exact decoder of authentic authorization exists on that
unrestricted interpretation type from source histories alone.
A real source-semantic correspondence law might exclude one of those
interpretations. It needs independent evidence and proof.

These results test only the information carried by the fixed
six-basis-slot source and its modeled history. They do NOT refute
physicalist mind theories, disprove UPT or assert an actual forced
event; they do not redefine the six original-X3 duties.
-/

namespace PhysicalBridges.BCRDAuthorizationFreedomBoundary

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.BCRDSourceHistoryProvenance
open PhysicalBridges.BCRDParticularCarrierCriterion
open PhysicalBridges.IRHistoryProvenance

/-- IR131 Process with EXACTLY the one actual named frozen
M-sector generator action. The True predicate permits the
model's only action; it is not evidence of subjective consent. -/
def sourceOnlyProcess : PhysicalBridges.IR131.Process Index Unit :=
  { step := fun i _ j => ActualPositionStep i j
    authorised := fun _ _ => True }

/-- Frozen source event demonstrably makes a nontrivial move
from M0 to M1, so lack of choice is NOT because motion stops. -/
theorem source_only_process_moves_M0 :
    PhysicalBridges.IR131.CanMove sourceOnlyProcess (2 : Index) := by
  refine ⟨(), 3, ?_, ?_⟩
  · constructor
    · trivial
    · change ActualPositionStep (2 : Index) (3 : Index)
      unfold ActualPositionStep sourceTransport
      decide
  · decide

/-- Having a genuine reversible moving generator with one
modeled action does NOT supply two distinct action-labelled
alternatives (let alone maximal original-X3 freedom). -/
theorem no_two_distinct_actions_in_source_only_process (i : Index) :
    ¬ PhysicalBridges.IR131.TwoWayChoice sourceOnlyProcess i := by
  rintro ⟨a, b, x1, x2, hDistinct, _, _, _⟩
  cases a
  cases b
  exact hDistinct rfl

/-- A physical-source position and an UNVALIDATED semantic
authorization bit. That bit is NOT a field of the frozen source. -/
structure InterpretedSourceHistory where
  sourcePosition : Index
  semanticAuthorization : Bool

/-- Observed data: the entire sequence of physically GENERATED
finite event histories, physical and recorded, at every horizon.
No assumed subject authorization field is copied into the readout. -/
def allModeledSourceHistories (w : InterpretedSourceHistory) :
    Nat → PhysicalHistory Index SlotEvent × RecordedHistory Index SlotEvent :=
  fun n => (sourcePhysicalHistory w.sourcePosition n,
    sourceRecordedHistory w.sourcePosition n)

/-- Target interpretation. It is an independently meaningful
authorization judgment only if independently grounded later. -/
def claimedAuthorization (w : InterpretedSourceHistory) : Bool :=
  w.semanticAuthorization

/-- Two possible SEMANTIC EXTENSIONS of exactly the same
source history; not a claim of two physically realized events. -/
def approvedInterpretation : InterpretedSourceHistory :=
  ⟨2, true⟩

def unapprovedInterpretation : InterpretedSourceHistory :=
  ⟨2, false⟩

/-- The full infinite collection of frozen finite source
histories is identical for both semantic interpretations. -/
theorem entire_generated_histories_cannot_separate_authorization :
    allModeledSourceHistories approvedInterpretation =
      allModeledSourceHistories unapprovedInterpretation := rfl

theorem opposing_authorization_interpretations :
    claimedAuthorization approvedInterpretation = true ∧
      claimedAuthorization unapprovedInterpretation = false := by
  decide

/-- The exact IR132 no-decoder obstruction specialized even to
all n of modeled source history at once. The issue is missing
semantic restriction, not a weak finite observation window. -/
theorem no_authorization_decoder_from_complete_modeled_source_history :
    ¬ PhysicalBridges.IR132.ExactDecoder
      allModeledSourceHistories claimedAuthorization := by
  intro h
  have hFiber :=
    PhysicalBridges.IR132.exact_decoder_implies_fiber_constant
      allModeledSourceHistories claimedAuthorization h
  have heq :=
    hFiber approvedInterpretation unapprovedInterpretation
      entire_generated_histories_cannot_separate_authorization
  have hOppose := opposing_authorization_interpretations
  rw [hOppose.1, hOppose.2] at heq
  cases heq

/-- Any separately warranted authentic authorization detector
must discriminate semantic interpretations that have matching
pure source-position histories, or physics must demonstrate
that one interpretation is inadmissible. -/
theorem exact_authorization_receipt_must_distinguish_interpretations
    {D : Type} (receipt : InterpretedSourceHistory → D)
    (hExact : PhysicalBridges.IR132.ExactDecoder
      receipt claimedAuthorization) :
    receipt approvedInterpretation ≠ receipt unapprovedInterpretation := by
  intro hSame
  have hFiber :=
    PhysicalBridges.IR132.exact_decoder_implies_fiber_constant
      receipt claimedAuthorization hExact
  have heq := hFiber approvedInterpretation unapprovedInterpretation hSame
  have hOppose := opposing_authorization_interpretations
  rw [hOppose.1, hOppose.2] at heq
  cases heq

#print axioms source_only_process_moves_M0
#print axioms no_two_distinct_actions_in_source_only_process
#print axioms entire_generated_histories_cannot_separate_authorization
#print axioms no_authorization_decoder_from_complete_modeled_source_history
#print axioms exact_authorization_receipt_must_distinguish_interpretations

end PhysicalBridges.BCRDAuthorizationFreedomBoundary
