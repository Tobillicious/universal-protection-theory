import PhysicalBridges.BCRDExecutableSourceReceipt
import PhysicalBridges.BCRDWitnessedSourceRefinement
import PhysicalBridges.BCRDCountedWitness

/-!
# PR B phase 16 — compose real physical witnesses, counters and recorded receipt

4 November 2026. Positive finite-source correspondence theorem.

We now CLOSE the purely FORMAL handoff between PR B's phase-11
witnessed world traces, phase-13 actual-edge counter step law,
IR26 independent event-record fidelity and phase-14 executable
source receipt verifier.

If REAL PHYSICAL WORLD EDGES are independently supplied, every
such edge refines the exact frozen source, the counter increases
once per real edge, and an independently held event record agrees
with the witnessed trace, then the complete physical-source
receipt passes the actual executable Boolean verifier. It must
recover the unique canonical source-projected history.

The theorem does not assume the executable verifier's conclusion.
Its hypotheses are separate independently auditable obligations.
No claim is made that an instrument realizing these hypotheses
has been built, or that a physical-source position is a living
particular. Full X3 (identity, consent, freedom, restraint,
maximality, provenance) and the full BCRD source remain open.
-/

namespace PhysicalBridges.BCRDWitnessedReceiptComposition

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDSourceHistoryProvenance
open PhysicalBridges.BCRDWitnessedSourceRefinement
open PhysicalBridges.BCRDCountedWitness
open PhysicalBridges.BCRDExecutableSourceReceipt
open PhysicalBridges.IRHistoryProvenance

universe u

/-- A physical event list projected from independently supplied
world steps. This does NOT define which world transitions occurred. -/
def projectedHistory {W : Type u}
    (readPosition : W → Index) (w : W)
    (events : List SlotEvent) : PhysicalHistory Index SlotEvent :=
  ⟨readPosition w, events⟩

/-- A source receipt assembled from independently supplied world
endpoint readings and actual event counter, plus a SEPARATELY
supplied record. Record fidelity is a separate theorem hypothesis,
not baked into the constructor. -/
def witnessedReceipt {W : Type u}
    (readPosition : W → Index) (counter : W → Nat)
    (w v : W) (events : List SlotEvent)
    (recorded : RecordedHistory Index SlotEvent) : SourceReceipt :=
  ⟨projectedHistory readPosition w events,
    recorded, readPosition v, counter v - counter w⟩

/-- The positive physical-to-computational join. If a real
witnessed world trace and independent source refinement,
counter increment and record fidelity hypotheses all hold,
the executable checker ACCEPTS the complete finite
source-projected receipt. The checker's result is not assumed. -/
theorem independently_witnessed_source_trace_passes_receipt_checker
    {W : Type u} (realStep : W → W → Prop)
    (readPosition : W → Index) (counter : W → Nat)
    (hRefines : RealStepsRefineSource realStep readPosition)
    (hCounter : CounterIncrementsOnActualSteps realStep counter)
    {w v : W} {events : List SlotEvent}
    (hTrace : WitnessedTrace realStep readPosition w events v)
    (recorded : RecordedHistory Index SlotEvent)
    (hRecord : Faithful (fun e : SlotEvent => e)
      (projectedHistory readPosition w events) recorded) :
    verifySourceReceipt
      (witnessedReceipt readPosition counter w v events recorded) =
        true := by
  apply verify_source_receipt_complete
  unfold SourceReceiptValid witnessedReceipt
  constructor
  · exact hRecord
  constructor
  · dsimp [projectedHistory]
    have hN :=
      actual_witnessed_trace_count_matches_edge_count
        realStep readPosition counter hCounter hTrace
    omega
  · dsimp [projectedHistory]
    exact witnessed_trace_projects_to_valid_source
      realStep readPosition hRefines hTrace

/-- The accepted receipt also contains the exact canonical SOURCE
trajectory; every event and terminal position are determined
by the independently witnessed starting slot and counter delta. -/
theorem independently_witnessed_receipt_has_canonical_contents
    {W : Type u} (realStep : W → W → Prop)
    (readPosition : W → Index) (counter : W → Nat)
    (hRefines : RealStepsRefineSource realStep readPosition)
    (hCounter : CounterIncrementsOnActualSteps realStep counter)
    {w v : W} {events : List SlotEvent}
    (hTrace : WitnessedTrace realStep readPosition w events v)
    (recorded : RecordedHistory Index SlotEvent)
    (hRecord : Faithful (fun e : SlotEvent => e)
      (projectedHistory readPosition w events) recorded) :
    events =
        PhysicalBridges.BCRDCanonicalEventHistory.canonicalEvents
          (readPosition w) (counter v - counter w) ∧
      readPosition v =
        PhysicalBridges.BCRDCanonicalEventHistory.canonicalEnd
          (readPosition w) (counter v - counter w) := by
  have hAccepted :=
    independently_witnessed_source_trace_passes_receipt_checker
      realStep readPosition counter hRefines hCounter
      hTrace recorded hRecord
  have hValid := verify_source_receipt_sound
    (witnessedReceipt readPosition counter w v events recorded) hAccepted
  have hCanonical :=
    PhysicalBridges.BCRDCanonicalEventHistory.verified_history_has_unique_canonical_contents
      hValid.2.2
  have hN : events.length = counter v - counter w := by
    simpa only [witnessedReceipt, projectedHistory] using hValid.2.1
  simpa only [witnessedReceipt, projectedHistory, hN] using hCanonical

/-- Positive, deliberately SYNTHETIC small world: the source
position and a monotone event counter. It is not a physical
installation. This is a nonvacuous model for every premise. -/
abbrev CountedWorld := Index × Nat

def countedWorldStep (s t : CountedWorld) : Prop :=
  t.1 = PhysicalBridges.BCRDTransportedParticularMarker.sourceTransport s.1 ∧
    t.2 = s.2 + 1

def countedWorldPosition (s : CountedWorld) : Index := s.1

def countedWorldCounter (s : CountedWorld) : Nat := s.2

theorem counted_world_exact_source_refinement :
    RealStepsRefineSource countedWorldStep countedWorldPosition := by
  intro s t h
  exact h.1

theorem counted_world_exact_counter_step :
    CounterIncrementsOnActualSteps countedWorldStep countedWorldCounter := by
  intro s t h
  exact h.2

theorem synthetic_counted_world_has_nontrivial_witness :
    WitnessedTrace countedWorldStep countedWorldPosition
      (2,0) [(2,3)] (3,1) := by
  change WitnessedTrace countedWorldStep countedWorldPosition
    ((2 : Index), (0 : Nat))
    ((countedWorldPosition (2,0), countedWorldPosition (3,1)) :: [])
    ((3 : Index), (1 : Nat))
  apply WitnessedTrace.next
  · unfold countedWorldStep countedWorldPosition
      PhysicalBridges.BCRDTransportedParticularMarker.sourceTransport
    decide
  · exact WitnessedTrace.empty _

def syntheticWitnessRecord : RecordedHistory Index SlotEvent :=
  ⟨2,[(2,3)]⟩

theorem synthetic_world_has_faithful_independent_record :
    Faithful (fun e : SlotEvent => e)
      (projectedHistory countedWorldPosition (2,0) [(2,3)])
      syntheticWitnessRecord :=
  ⟨rfl,rfl⟩

/-- Nonvacuity: a concrete source-world execution, incrementing
counter and separately given record satisfies the independent
contracts and is accepted by the actual executable checker. -/
theorem witnessed_and_counted_nontrivial_example_is_accepted :
    verifySourceReceipt
      (witnessedReceipt countedWorldPosition countedWorldCounter
        (2,0) (3,1) [(2,3)] syntheticWitnessRecord) = true :=
  independently_witnessed_source_trace_passes_receipt_checker
    countedWorldStep countedWorldPosition countedWorldCounter
    counted_world_exact_source_refinement
    counted_world_exact_counter_step
    synthetic_counted_world_has_nontrivial_witness
    syntheticWitnessRecord
    synthetic_world_has_faithful_independent_record

#print axioms independently_witnessed_source_trace_passes_receipt_checker
#print axioms independently_witnessed_receipt_has_canonical_contents
#print axioms witnessed_and_counted_nontrivial_example_is_accepted

end PhysicalBridges.BCRDWitnessedReceiptComposition
