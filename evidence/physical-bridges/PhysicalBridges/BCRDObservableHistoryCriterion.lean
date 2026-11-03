import PhysicalBridges.BCRDEndpointHistoryAmbiguity
import PhysicalBridges.IR132ExactBoundaryReconstruction

/-!
# PR B phase 12 — the exact additional observation for complete source-log recovery

4 November 2026. Frozen six-position event dynamics only.

Phase 9 proved that a source-valid log is uniquely determined by
an initial position and a known event count. Phase 10 proved that
mere initial/final position measurements do not reveal the count,
due to the real M0 <-> M1 two-event loop.

We now derive a NECESSARY-AND-SUFFICIENT criterion, with no selected
number of events baked into the notion of source-validity:

For ANY supplementary observation extra(e), on the domain of
canonical frozen-source episodes, the FULL source-event list is
exactly reconstructible from [initial/final endpoints, extra] iff
that same observation determines the event count on every
observationally indistinguishable pair.

The sufficiency direction uses IR132's choice-based existence theorem
and is NOT an executable calibrated sensor. A separate explicit
computable decoder is furnished for the specific extra observation
eventCount: origin + witnessed count reconstructs the entire list.

Two source-generated negative controls show that neither endpoints
alone (zero vs two steps) nor count alone (M0 vs M1 one-step) suffices.
No physical event-counter is asserted to exist. Instrument receipts
and actual execution must be independently witnessed; this theorem
does not certify subject identity, consent or full original X3.
-/

namespace PhysicalBridges.BCRDObservableHistoryCriterion

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDCanonicalEventHistory
open PhysicalBridges.BCRDSourceHistoryProvenance (SlotEvent)
open PhysicalBridges.BCRDEndpointHistoryAmbiguity

/-- Additional evidence, submitted separately from the pre/post
source position measurements. No physical calibration is assumed. -/
def enrichedReadout {D : Type}
    (extra : SourceEpisode → D) (e : SourceEpisode) :
    (Index × Index) × D :=
  (endpoints e, extra e)

/-- Fundamental source-model information criterion: the full
source event list is reconstructible from endpoints and some
supplementary observation iff that observation resolves the
number of events within each endpoint-observation fiber.

The right-to-left direction is a mathematical decoder existence
theorem (IR132); the physical reliability of extra is not proved. -/
theorem exact_history_decoder_iff_event_count_fiber_constant
    {D : Type} (extra : SourceEpisode → D) :
    PhysicalBridges.IR132.ExactDecoder
        (enrichedReadout extra) generatedLog ↔
      PhysicalBridges.IR132.FiberConstant
        (enrichedReadout extra) SourceEpisode.eventCount := by
  constructor
  · intro hExact e f hSame
    have hEqual :=
      PhysicalBridges.IR132.exact_decoder_implies_fiber_constant
        (enrichedReadout extra) generatedLog hExact e f hSame
    have hLength := congrArg List.length hEqual
    simpa [generatedLog, canonical_events_length] using hLength
  · intro hCount
    apply (PhysicalBridges.IR132.exact_decoder_iff_fiber_constant
      (enrichedReadout extra) generatedLog).mpr
    intro e f hSame
    have hOrigin : e.origin = f.origin :=
      congrArg (fun z : (Index × Index) × D => z.1.1) hSame
    have hN : e.eventCount = f.eventCount := hCount e f hSame
    unfold generatedLog
    rw [hOrigin, hN]

/-- The concrete sufficient observation. Count is supplied
as a separate observation and the initial position is already
in the endpoint readout. No sensor truth is claimed here. -/
def exactCountReadout :
    SourceEpisode → (Index × Index) × Nat :=
  enrichedReadout SourceEpisode.eventCount

/-- An explicit, purely computational reconstruction function for
a SOURCE MODEL (not a device implementation). -/
def reconstructCanonicalLog
    (receipt : (Index × Index) × Nat) : List SlotEvent :=
  canonicalEvents receipt.1.1 receipt.2

/-- Constructive decoder: if an independently established event
count and origin are given correctly, the complete source event
list is recovered exactly for every finite source episode. -/
theorem exact_count_and_origin_reconstruct_full_source_log :
    ∀ e : SourceEpisode,
      reconstructCanonicalLog (exactCountReadout e) = generatedLog e := by
  intro e
  rfl

theorem exact_count_readout_has_explicit_decoder :
    PhysicalBridges.IR132.ExactDecoder
      exactCountReadout generatedLog :=
  ⟨reconstructCanonicalLog,
    exact_count_and_origin_reconstruct_full_source_log⟩

/-- Endpoint-only measurements cannot decode the canonical event
list, because the generator admits distinct zero/two-step loops. -/
theorem no_endpoint_only_full_history_decoder :
    ¬ PhysicalBridges.IR132.ExactDecoder endpoints generatedLog := by
  intro hExact
  have hFiber :=
    PhysicalBridges.IR132.exact_decoder_implies_fiber_constant
      endpoints generatedLog hExact
  exact different_generator_histories_at_same_endpoints
    (hFiber noEvents twoEvents
      same_start_and_end_for_zero_vs_two_source_steps)

/-- Two *different actual-source one-step MODEL histories*, both
with event count 1. Their source event lists are different because
the two M positions have distinct source predecessors. -/
def oneStepFromM0 : SourceEpisode := ⟨2, 1⟩
def oneStepFromM1 : SourceEpisode := ⟨3, 1⟩

theorem same_event_count_but_distinct_source_histories :
    oneStepFromM0.eventCount = oneStepFromM1.eventCount ∧
      generatedLog oneStepFromM0 ≠ generatedLog oneStepFromM1 := by
  decide

/-- Count alone cannot recover the full event list without the
initial source position (or equivalently enough source-location
information to determine the origin). -/
theorem no_event_count_only_full_history_decoder :
    ¬ PhysicalBridges.IR132.ExactDecoder
      SourceEpisode.eventCount generatedLog := by
  intro hExact
  have hFiber :=
    PhysicalBridges.IR132.exact_decoder_implies_fiber_constant
      SourceEpisode.eventCount generatedLog hExact
  have hPair := same_event_count_but_distinct_source_histories
  exact hPair.2 (hFiber oneStepFromM0 oneStepFromM1 hPair.1)

/-- Any extra observation that purports to fully reconstruct
history MUST distinguish the zero-event and two-event M0
episodes. This is the source-derived minimal discrimination
test for a proposed event-count sensor receipt. -/
theorem any_exact_supplemental_readout_separates_reversible_loops
    {D : Type} (extra : SourceEpisode → D)
    (hExact : PhysicalBridges.IR132.ExactDecoder
      (enrichedReadout extra) generatedLog) :
    extra noEvents ≠ extra twoEvents := by
  intro hExtraEq
  have hObs :
      enrichedReadout extra noEvents =
        enrichedReadout extra twoEvents := by
    unfold enrichedReadout
    rw [same_start_and_end_for_zero_vs_two_source_steps, hExtraEq]
  have hFiber :=
    PhysicalBridges.IR132.exact_decoder_implies_fiber_constant
      (enrichedReadout extra) generatedLog hExact
  exact different_generator_histories_at_same_endpoints
    (hFiber noEvents twoEvents hObs)

#print axioms exact_history_decoder_iff_event_count_fiber_constant
#print axioms exact_count_and_origin_reconstruct_full_source_log
#print axioms exact_count_readout_has_explicit_decoder
#print axioms no_endpoint_only_full_history_decoder
#print axioms no_event_count_only_full_history_decoder
#print axioms any_exact_supplemental_readout_separates_reversible_loops

end PhysicalBridges.BCRDObservableHistoryCriterion
