import PhysicalBridges.BCRDCountedWitness

/-!
# PR B phase 14 — an executable, kernel-sound frozen-source receipt checker

4 November 2026; finite six-position frozen BCRD source subsystem.

Phase 7 introduced an independent relational source validator for
arbitrary submitted lists of physical-position edges. Phases 9/12
established the canonical-history and exact event-count criteria.

This module makes the validation executable: the Boolean verifier
takes source origin, terminal position, claimed count, nominated
physical-source event list and the separately supplied recorded copy.
We prove soundness AND completeness against the pre-existing
VerifiedSourcePath and IR26 Faithful predicates.

It rejects missing counts, fabricated source-impossible jumps, a
swapped recorded event and inconsistent terminal positions. A
legitimate zero-step history is accepted; nonempty histories need
physically modeled edges. The verifier is deterministic and does
not use classical choice to implement its boolean verdict.

A *source-valid forged event list* with a matching copied record
still passes: the checker certifies only structural source
admissibility and record agreement. It does NOT authenticate a real
physical occurrence, completeness of environmental effects,
sensor calibration, true subject identity or any original X3 duty.

Unlike an IR77 typed telemetry checker, this specific checker
only covers the 6-source generator's position event list.
-/

namespace PhysicalBridges.BCRDExecutableSourceReceipt

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.BCRDSourceHistoryProvenance
open PhysicalBridges.BCRDParticularCarrierCriterion
open PhysicalBridges.BCRDValidatedCausalLog
open PhysicalBridges.BCRDCanonicalEventHistory
open PhysicalBridges.IRHistoryProvenance

/-- Executable source-path validator on arbitrary user-supplied
position-event pairs. No physical observation is assumed. -/
def checkSourcePath : Index → List SlotEvent → Index → Bool
  | i, [], j => decide (i = j)
  | i, (a,b)::rest, j =>
      decide (i = a) &&
        (decide (b = sourceTransport a) && checkSourcePath b rest j)

/-- Source-path checker SOUNDNESS: true verdict entails the
independently constructed inductive source-step chain. -/
theorem check_source_path_sound :
    ∀ (i j : Index) (events : List SlotEvent),
      checkSourcePath i events j = true →
        VerifiedSourcePath i events j := by
  intro i j events
  induction events generalizing i with
  | nil =>
      intro h
      have hij : i = j := decide_eq_true_eq.mp (by
        simpa only [checkSourcePath] using h)
      subst j
      exact VerifiedSourcePath.empty i
  | cons head rest ih =>
      obtain ⟨a,b⟩ := head
      intro h
      have hParts :
          decide (i = a) = true ∧
            (decide (b = sourceTransport a) = true ∧
              checkSourcePath b rest j = true) := by
        simpa only [checkSourcePath, Bool.and_eq_true] using h
      have hOrigin : i = a := decide_eq_true_eq.mp hParts.1
      have hSource : ActualPositionStep a b := by
        change b = sourceTransport a
        exact decide_eq_true_eq.mp hParts.2.1
      have hRest : VerifiedSourcePath b rest j :=
        ih b hParts.2.2
      subst a
      exact VerifiedSourcePath.next hSource hRest

/-- Source-path checker COMPLETENESS: every inductively verified
actual frozen source path is accepted by the executable checker. -/
theorem check_source_path_complete
    {i j : Index} {events : List SlotEvent}
    (hValid : VerifiedSourcePath i events j) :
    checkSourcePath i events j = true := by
  induction hValid with
  | empty i => simp [checkSourcePath]
  | @next i j k rest hEdge hLater ih =>
      have hSource : j = sourceTransport i := hEdge
      subst j
      simpa [checkSourcePath] using ih

theorem check_source_path_iff_verified
    (i j : Index) (events : List SlotEvent) :
    checkSourcePath i events j = true ↔
      VerifiedSourcePath i events j := by
  constructor
  · exact check_source_path_sound i j events
  · exact check_source_path_complete

/-- Claimed source event count is checked independently of
the submitted list and its final position. -/
def checkCountedSourcePath (i j : Index) (claimedCount : Nat)
    (events : List SlotEvent) : Bool :=
  decide (events.length = claimedCount) && checkSourcePath i events j

theorem check_counted_source_path_iff
    (i j : Index) (n : Nat) (events : List SlotEvent) :
    checkCountedSourcePath i j n events = true ↔
      events.length = n ∧ VerifiedSourcePath i events j := by
  constructor
  · intro h
    have hs :
        decide (events.length = n) = true ∧
          checkSourcePath i events j = true := by
      simpa only [checkCountedSourcePath, Bool.and_eq_true] using h
    exact ⟨decide_eq_true_eq.mp hs.1,
      (check_source_path_iff_verified i j events).mp hs.2⟩
  · intro h
    have hPair :
        decide (events.length = n) = true ∧
          checkSourcePath i events j = true :=
      ⟨decide_eq_true_eq.mpr h.1,
        (check_source_path_iff_verified i j events).mpr h.2⟩
    simpa only [checkCountedSourcePath, Bool.and_eq_true] using hPair

/-- Complete typed modeled receipt, including the nominated physical
source event list AND its independently supplied durable copy. -/
structure SourceReceipt where
  physical : PhysicalHistory Index SlotEvent
  recorded : RecordedHistory Index SlotEvent
  terminalPosition : Index
  claimedCount : Nat

/-- Executable end-to-end source-model receipt checker.
All fields are computed from the submitted record; nothing is
assumed to be a real measured event. -/
def verifySourceReceipt (receipt : SourceReceipt) : Bool :=
  decide (receipt.recorded.origin = receipt.physical.origin) &&
    (decide (receipt.recorded.events = receipt.physical.events) &&
      checkCountedSourcePath receipt.physical.origin
        receipt.terminalPosition receipt.claimedCount
        receipt.physical.events)

/-- Exact mathematical acceptance contract. Note what is absent:
no real-world occurrence, cryptographic signature, subjecthood
or complete original X3 assertion appears here. -/
def SourceReceiptValid (receipt : SourceReceipt) : Prop :=
  Faithful (fun e : SlotEvent => e)
    receipt.physical receipt.recorded ∧
  receipt.physical.events.length = receipt.claimedCount ∧
  VerifiedSourcePath receipt.physical.origin
    receipt.physical.events receipt.terminalPosition

/-- Kernel-checked SOUNDNESS of the executable verifier. -/
theorem verify_source_receipt_sound (receipt : SourceReceipt)
    (h : verifySourceReceipt receipt = true) :
    SourceReceiptValid receipt := by
  have hs :
      decide (receipt.recorded.origin = receipt.physical.origin) = true ∧
        (decide (receipt.recorded.events = receipt.physical.events) = true ∧
          checkCountedSourcePath receipt.physical.origin
            receipt.terminalPosition receipt.claimedCount
            receipt.physical.events = true) := by
    simpa only [verifySourceReceipt, Bool.and_eq_true] using h
  have hCount :=
    (check_counted_source_path_iff
      receipt.physical.origin receipt.terminalPosition
      receipt.claimedCount receipt.physical.events).mp hs.2.2
  exact ⟨⟨decide_eq_true_eq.mp hs.1,
    by simpa using (decide_eq_true_eq.mp hs.2.1)⟩,
    hCount.1, hCount.2⟩

/-- Kernel-checked COMPLETENESS: a source and record satisfying
the exact source structural conditions always pass the verifier. -/
theorem verify_source_receipt_complete (receipt : SourceReceipt)
    (h : SourceReceiptValid receipt) :
    verifySourceReceipt receipt = true := by
  have hOrigin :
      decide (receipt.recorded.origin = receipt.physical.origin) = true :=
    decide_eq_true_eq.mpr h.1.1
  have hEvents :
      decide (receipt.recorded.events = receipt.physical.events) = true := by
    exact decide_eq_true_eq.mpr (by simpa using h.1.2)
  have hCount :=
    (check_counted_source_path_iff
      receipt.physical.origin receipt.terminalPosition
      receipt.claimedCount receipt.physical.events).mpr ⟨h.2.1,h.2.2⟩
  have hPair :
      decide (receipt.recorded.origin = receipt.physical.origin) = true ∧
      (decide (receipt.recorded.events = receipt.physical.events) = true ∧
        checkCountedSourcePath receipt.physical.origin
          receipt.terminalPosition receipt.claimedCount
          receipt.physical.events = true) :=
    ⟨hOrigin,hEvents,hCount⟩
  simpa only [verifySourceReceipt, Bool.and_eq_true] using hPair

theorem executable_receipt_iff_source_structural_validity
    (receipt : SourceReceipt) :
    verifySourceReceipt receipt = true ↔ SourceReceiptValid receipt :=
  ⟨verify_source_receipt_sound receipt,
    verify_source_receipt_complete receipt⟩

/-- Actual generated source-model histories produce accepted
receipts for every source basis position and finite event horizon. -/
def generatedReceipt (i : Index) (n : Nat) : SourceReceipt :=
  ⟨sourcePhysicalHistory i n, sourceRecordedHistory i n,
    trackedPosition i n, n⟩

theorem every_generated_source_receipt_is_accepted
    (i : Index) (n : Nat) :
    verifySourceReceipt (generatedReceipt i n) = true := by
  apply verify_source_receipt_complete
  dsimp [SourceReceiptValid, generatedReceipt]
  refine ⟨full_finite_source_event_history_is_faithful i n,
    generated_physical_history_length i n, ?_⟩
  rw [finite_source_history_retains_origin i n]
  exact generated_history_passes_source_path_verifier i n

/-- Source-valid M0-to-M1 model receipt: checked fixture only. -/
def testOneEvent : SourceReceipt :=
  ⟨⟨2,[(2,3)]⟩,⟨2,[(2,3)]⟩,3,1⟩

theorem valid_single_event_receipt_accepted :
    verifySourceReceipt testOneEvent = true := by decide

theorem valid_empty_history_receipt_accepted :
    verifySourceReceipt (generatedReceipt 2 0) = true := by decide

theorem count_forgery_rejected :
    verifySourceReceipt { testOneEvent with claimedCount := 2 } = false := by decide

theorem incorrect_terminal_position_rejected :
    verifySourceReceipt { testOneEvent with terminalPosition := 2 } = false := by decide

theorem source_impossible_jump_rejected :
    verifySourceReceipt
      ⟨⟨2,[(2,4)]⟩,⟨2,[(2,4)]⟩,4,1⟩ = false := by decide

theorem mismatched_recorded_event_rejected :
    verifySourceReceipt
      { testOneEvent with recorded := ⟨2,[(3,2)]⟩ } = false := by decide

theorem mismatched_origin_rejected :
    verifySourceReceipt
      { testOneEvent with recorded := ⟨3,[(2,3)]⟩ } = false := by decide

/-- The previously established real-world no-execution control
remains applicable: a source receipt ACCEPTED by the checker
is not a physically witnessed transition in a world with
NO actual physical edges. -/
theorem successful_checker_does_not_by_itself_prove_execution :
    verifySourceReceipt testOneEvent = true ∧
      ¬ PhysicalBridges.BCRDWitnessedSourceRefinement.WitnessedTrace
        PhysicalBridges.BCRDWitnessedSourceRefinement.noPhysicalWorldStep
        PhysicalBridges.BCRDWitnessedSourceRefinement.identityReadout
        2 [(2,3)] 3 :=
  ⟨valid_single_event_receipt_accepted,
    PhysicalBridges.BCRDWitnessedSourceRefinement.source_valid_log_does_not_force_real_world_execution⟩

#print axioms check_source_path_iff_verified
#print axioms check_counted_source_path_iff
#print axioms executable_receipt_iff_source_structural_validity
#print axioms every_generated_source_receipt_is_accepted
#print axioms valid_single_event_receipt_accepted
#print axioms count_forgery_rejected
#print axioms source_impossible_jump_rejected
#print axioms successful_checker_does_not_by_itself_prove_execution

end PhysicalBridges.BCRDExecutableSourceReceipt
