import PhysicalBridges.BCRDObservableHistoryCriterion
import PhysicalBridges.BCRDWitnessedSourceRefinement

/-!
# PR B phase 13 — witnessed event-count consistency and its missing converse

4 November 2026. Source-to-instrument contract, not a real instrument.

Phase 12 proves a correct origin and an EVENT COUNT decode the entire
finite frozen-source event list. This module identifies the next
independently testable physical obligation:

For EACH actual real-world edge, an event counter increases by one.
On a WitnessedTrace of real-world edges, that counter consequently
agrees with the exact number of actual edges in that trace.
If those same edges independently refine the frozen source, the
initial physical position and witnessed counter delta reconstruct
the complete source-projected event list.

Counterexample: the one-direction counter-increment contract is
insufficient to infer actual execution from two arbitrary readings.
In a world with NO real steps, counters can differ between two
unrelated sampled world states. Their difference is not a witnessed
real-world edge. Therefore the counter must additionally have a
trusted chronological observational connection, anti-phantom/
anti-replay controls and physical sensor-source correspondence.

No real sensor, full complex BCRD source, subject survival, consent
or original six-component X3 is independently certified here.
-/

namespace PhysicalBridges.BCRDCountedWitness

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDWitnessedSourceRefinement
open PhysicalBridges.BCRDCanonicalEventHistory
open PhysicalBridges.BCRDObservableHistoryCriterion
open PhysicalBridges.BCRDSourceHistoryProvenance (SlotEvent)

universe u

/-- A count fidelity law on each ACTUAL world transition.
This obligation is separate from source algebra, and is not
defined by a reported source-model event log. -/
def CounterIncrementsOnActualSteps {W : Type u}
    (realStep : W → W → Prop) (counter : W → Nat) : Prop :=
  ∀ w v, realStep w v → counter v = counter w + 1

/-- A genuinely witnessed physical trace obeying this independent
counter-step contract contains exactly as many edges as the
difference of its counter readings. In particular, the count
cannot decrease on a witnessed trace. -/
theorem actual_witnessed_trace_count_matches_edge_count
    {W : Type u} (realStep : W → W → Prop)
    (readPosition : W → Index) (counter : W → Nat)
    (hCounter : CounterIncrementsOnActualSteps realStep counter)
    {w v : W} {events : List SlotEvent}
    (hTrace : WitnessedTrace realStep readPosition w events v) :
    counter v = counter w + events.length := by
  induction hTrace with
  | empty w =>
      simp
  | next hEdge later ih =>
      have hInc := hCounter _ _ hEdge
      simp only [List.length_cons]
      omega

/-- An external source-refinement law plus an independently
verified actual-event counter are sufficient to reconstruct the
exact SOURCE-PROJECTED world event list from the starting slot
and observed counter difference. This is not an inference that
the counter itself proves events took place. -/
theorem actual_trace_reconstructs_from_initial_slot_and_count_delta
    {W : Type u} (realStep : W → W → Prop)
    (readPosition : W → Index) (counter : W → Nat)
    (hRefines : RealStepsRefineSource realStep readPosition)
    (hCounter : CounterIncrementsOnActualSteps realStep counter)
    {w v : W} {events : List SlotEvent}
    (hTrace : WitnessedTrace realStep readPosition w events v) :
    events =
        canonicalEvents (readPosition w) (counter v - counter w) ∧
      readPosition v =
        canonicalEnd (readPosition w) (counter v - counter w) := by
  have hCanonical :=
    witnessed_trace_is_the_unique_canonical_source_history
      realStep readPosition hRefines hTrace
  have hObserved :=
    actual_witnessed_trace_count_matches_edge_count
      realStep readPosition counter hCounter hTrace
  have hN : counter v - counter w = events.length := by omega
  simpa only [hN] using hCanonical

/-- Count receipt (starting slot, endpoint slot and observed event
delta) uses only the independent physical readout and counter.
Does not directly carry the already known modeled event list. -/
def sourceObservationReceipt {W : Type u}
    (readPosition : W → Index) (counter : W → Nat)
    (w v : W) : (Index × Index) × Nat :=
  ((readPosition w, readPosition v), counter v - counter w)

/-- Reuses the explicit phase-12 decoder. The source log reconstructed
from a world receipt equals the full source projection of every
physically witnessed trace satisfying the two independent contracts. -/
theorem real_world_receipt_decodes_full_witnessed_source_trace
    {W : Type u} (realStep : W → W → Prop)
    (readPosition : W → Index) (counter : W → Nat)
    (hRefines : RealStepsRefineSource realStep readPosition)
    (hCounter : CounterIncrementsOnActualSteps realStep counter)
    {w v : W} {events : List SlotEvent}
    (hTrace : WitnessedTrace realStep readPosition w events v) :
    reconstructCanonicalLog
      (sourceObservationReceipt readPosition counter w v) = events := by
  have h :=
    actual_trace_reconstructs_from_initial_slot_and_count_delta
      realStep readPosition counter hRefines hCounter hTrace
  exact h.1.symm

/-- Separate hostile world: no transitions occur, even though
the proposed sensor has an arbitrary count reading for each
unrelated world state. -/
def noActualNatStep : Nat → Nat → Prop := fun _ _ => False
def identityNatCounter : Nat → Nat := fun n => n
def fixedMSourceReadout : Nat → Index := fun _ => 2

/-- The one-direction "each real step increments" contract is
vacuously true if there are no real steps. -/
theorem silent_world_satisfies_one_direction_counter_contract :
    CounterIncrementsOnActualSteps
      noActualNatStep identityNatCounter := by
  intro w v h
  exact False.elim h

theorem silent_world_satisfies_source_refinement :
    RealStepsRefineSource noActualNatStep fixedMSourceReadout := by
  intro w v h
  exact False.elim h

/-- Readings 0 and 1 differ but there is NO witnessed real-world
edge connecting them. Counter difference alone is not a causal
receipt of actual event occurrence. -/
theorem counter_difference_does_not_establish_physical_step :
    (identityNatCounter 1 - identityNatCounter 0 = 1) ∧
      ¬ WitnessedTrace noActualNatStep fixedMSourceReadout
        0 [(2,2)] 1 := by
  constructor
  · rfl
  · intro h
    cases h with
    | next actualEdge later =>
        exact actualEdge

/-- All source and counter consistency laws can hold while two
unrelated world states show a counter increment without an
actual trace. This blocks promotion of counter-delta alone
to proven physical execution. -/
theorem instrument_counter_law_alone_cannot_certify_execution :
    CounterIncrementsOnActualSteps
        noActualNatStep identityNatCounter ∧
      RealStepsRefineSource noActualNatStep fixedMSourceReadout ∧
      (identityNatCounter 1 - identityNatCounter 0 = 1) ∧
      ¬ WitnessedTrace noActualNatStep fixedMSourceReadout
        0 [(2,2)] 1 :=
  ⟨silent_world_satisfies_one_direction_counter_contract,
    silent_world_satisfies_source_refinement,
    counter_difference_does_not_establish_physical_step.1,
    counter_difference_does_not_establish_physical_step.2⟩

#print axioms actual_witnessed_trace_count_matches_edge_count
#print axioms actual_trace_reconstructs_from_initial_slot_and_count_delta
#print axioms real_world_receipt_decodes_full_witnessed_source_trace
#print axioms counter_difference_does_not_establish_physical_step
#print axioms instrument_counter_law_alone_cannot_certify_execution

end PhysicalBridges.BCRDCountedWitness
