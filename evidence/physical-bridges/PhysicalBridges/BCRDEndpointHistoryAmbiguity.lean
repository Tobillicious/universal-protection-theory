import PhysicalBridges.BCRDCanonicalEventHistory
import PhysicalBridges.IR132ExactBoundaryReconstruction

/-!
# PR B phase 10 — exact source endpoint ambiguity and reversible event loops

4 November 2026 · independent, finite frozen BCRD source control.

Phase 9 establishes that with a FIXED origin and event count, there is
precisely one source-valid history. This module tests the indispensable
converse limitation: if the number of events is NOT supplied, the initial
and final physical basis positions do not identify the event history.

The real frozen source generator is an involution, so zero events and two
source-valid events both take M0 to M0. Both source-generated histories
pass the independent source step checker and the IR26 fidelity check.
They are still distinct physical-source MODEL histories.

Hence no decoder from only the initial/final position pair can recover
exact event count or whether any event occurred over this finite episode
domain. Unlike the earlier free semantic flags, this ambiguity arises
within two distinctly generated and source-valid histories.

This is a mathematically exact limitation of the frozen source. It does
NOT claim that a two-step event really happened, or that independent
clock, physical sensor, complete source history or fuller BCRD data
could not distinguish the histories. It gives no authentic subject
continuity, consent or original-X3 theorem.
-/

namespace PhysicalBridges.BCRDEndpointHistoryAmbiguity

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.BCRDSourceHistoryProvenance
open PhysicalBridges.BCRDValidatedCausalLog
open PhysicalBridges.BCRDCanonicalEventHistory
open PhysicalBridges.IRHistoryProvenance

/-- Source involution, expressed in the independently defined
canonical finite-step semantics; ALL six basis positions. -/
theorem two_frozen_steps_return_to_origin (i : Index) :
    canonicalEnd i 2 = i := by
  change sourceTransport (sourceTransport i) = i
  exact source_transport_is_involution i

/-- A valid zero-event history AND a valid two-event history
can have the same physical endpoint, for every frozen source
position. The source-generated logs are distinct. -/
theorem two_valid_histories_share_source_endpoints (i : Index) :
    VerifiedSourcePath i (canonicalEvents i 0) i ∧
    VerifiedSourcePath i (canonicalEvents i 2) i ∧
    canonicalEvents i 0 ≠ canonicalEvents i 2 := by
  constructor
  · exact every_canonical_history_passes_source_checker i 0
  constructor
  · have h := every_canonical_history_passes_source_checker i 2
    rw [two_frozen_steps_return_to_origin i] at h
    exact h
  · intro h
    have hlen := congrArg List.length h
    simp [canonical_events_length] at hlen

/-- A finite source-generated episode, not a claimed real execution.
There is no freely assigned semantic field: both its endpoint and
whole event list are computed from the same frozen generator. -/
structure SourceEpisode where
  origin : Index
  eventCount : Nat

def endpoints (e : SourceEpisode) : Index × Index :=
  (e.origin, canonicalEnd e.origin e.eventCount)

def generatedLog (e : SourceEpisode) : List SlotEvent :=
  canonicalEvents e.origin e.eventCount

def hasEvents (e : SourceEpisode) : Bool :=
  if e.eventCount = 0 then false else true

/-- Genuine two-model-episode control, without invented consent
or occurrence flags. Both are valid possible source trajectories. -/
def noEvents : SourceEpisode := ⟨2, 0⟩
def twoEvents : SourceEpisode := ⟨2, 2⟩

theorem same_start_and_end_for_zero_vs_two_source_steps :
    endpoints noEvents = endpoints twoEvents := by
  decide

theorem different_generator_histories_at_same_endpoints :
    generatedLog noEvents ≠ generatedLog twoEvents := by
  decide

theorem different_event_counts_at_same_endpoints :
    noEvents.eventCount ≠ twoEvents.eventCount := by
  decide

theorem different_whether_any_source_step_was_modeled :
    hasEvents noEvents = false ∧ hasEvents twoEvents = true := by
  decide

/-- Both logs independently pass the actual source-step verifier,
not merely a self-copied ledger check. -/
theorem both_ambiguous_endpoint_histories_are_source_valid :
    VerifiedSourcePath 2 (generatedLog noEvents) 2 ∧
    VerifiedSourcePath 2 (generatedLog twoEvents) 2 :=
  two_valid_histories_share_source_endpoints 2 |>.1 |>.elim
    (fun _ => by
      have h := two_valid_histories_share_source_endpoints 2
      exact ⟨h.1, h.2.1⟩)

/-- Both internally generated histories also satisfy inherited IR26
record/physical-source consistency. This is NOT external sensing. -/
theorem both_ambiguous_endpoint_histories_have_faithful_records :
    Faithful (fun e : SlotEvent => e)
      (sourcePhysicalHistory 2 0) (sourceRecordedHistory 2 0) ∧
    Faithful (fun e : SlotEvent => e)
      (sourcePhysicalHistory 2 2) (sourceRecordedHistory 2 2) :=
  ⟨full_finite_source_event_history_is_faithful 2 0,
    full_finite_source_event_history_is_faithful 2 2⟩

/-- IR132 exact readout failure derives from two ACTUALLY distinct
source-generated finite histories with the same endpoints. The
missing quantity is event count, not an arbitrary semantic flag. -/
theorem no_endpoint_only_exact_event_count_decoder :
    ¬ PhysicalBridges.IR132.ExactDecoder
      endpoints SourceEpisode.eventCount := by
  intro hDecoder
  have hFiber :=
    PhysicalBridges.IR132.exact_decoder_implies_fiber_constant
      endpoints SourceEpisode.eventCount hDecoder
  have hEq :=
    hFiber noEvents twoEvents
      same_start_and_end_for_zero_vs_two_source_steps
  exact different_event_counts_at_same_endpoints hEq

/-- Even the binary question whether there were zero vs positive
modeled source events cannot be decoded from endpoints alone. -/
theorem no_endpoint_only_has_events_decoder :
    ¬ PhysicalBridges.IR132.ExactDecoder endpoints hasEvents := by
  intro hDecoder
  have hFiber :=
    PhysicalBridges.IR132.exact_decoder_implies_fiber_constant
      endpoints hasEvents hDecoder
  have hEq :=
    hFiber noEvents twoEvents
      same_start_and_end_for_zero_vs_two_source_steps
  have hOpp := different_whether_any_source_step_was_modeled
  rw [hOpp.1, hOpp.2] at hEq
  cases hEq

#print axioms two_frozen_steps_return_to_origin
#print axioms two_valid_histories_share_source_endpoints
#print axioms both_ambiguous_endpoint_histories_are_source_valid
#print axioms both_ambiguous_endpoint_histories_have_faithful_records
#print axioms no_endpoint_only_exact_event_count_decoder
#print axioms no_endpoint_only_has_events_decoder

end PhysicalBridges.BCRDEndpointHistoryAmbiguity
