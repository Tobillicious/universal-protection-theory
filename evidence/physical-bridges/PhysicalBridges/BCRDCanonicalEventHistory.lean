import PhysicalBridges.BCRDExactCausalOrbit
import PhysicalBridges.IR132ExactBoundaryReconstruction

/-!
# PR B phase 9 — exact finite source-log reconstruction and execution gap

4 November 2026 · source-frozen physical position event subsystem.

Phase 7 separately checked whether arbitrary submitted event lists obey the
frozen M0↔M1 generator. Phase 9 identifies what this validator determines
EXACTLY: for a given origin and log length, all valid source-position event
lists are equal to the canonical generator history, and the terminal slot is
uniquely determined. We also connect this front-recursive canonical sequence
back to the independently constructed append-only source and recorded histories
from phase 4.

Hostile replay control: the SAME source-valid event list can be paired with
conflicting, independently uninterpreted occurrence claims. There is no
universal occurrence decoder from the pure model log on that unconstrained
interpretation domain. This is a test of unverified occurrence, NOT a
demonstration of an actual false physical event, and not a contradiction of
any source-observation law yet to be supplied.

Scope: frozen six-slot source; no independent sensor, actual subject,
within-event subjective history, consent, original X3 or universal coverage.
-/

namespace PhysicalBridges.BCRDCanonicalEventHistory

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.BCRDSourceHistoryProvenance
open PhysicalBridges.BCRDParticularCarrierCriterion
open PhysicalBridges.BCRDValidatedCausalLog
open PhysicalBridges.IRHistoryProvenance

/-- An independently defined exact canonical list of the first n frozen
source edges, starting from the requested physical basis position. -/
def canonicalEvents (i : Index) : Nat → List SlotEvent
  | 0 => []
  | n + 1 =>
      (i, sourceTransport i) :: canonicalEvents (sourceTransport i) n

/-- Canonical end position after n source transitions. -/
def canonicalEnd (i : Index) : Nat → Index
  | 0 => i
  | n + 1 => canonicalEnd (sourceTransport i) n

/-- The canonical list contains exactly the requested number of steps. -/
theorem canonical_events_length (i : Index) :
    ∀ n : Nat, (canonicalEvents i n).length = n := by
  intro n
  induction n generalizing i with
  | zero => rfl
  | succ n ih =>
      simp only [canonicalEvents, List.length_cons, ih]

/-- A canonical list independently passes the source-step checker. -/
theorem every_canonical_history_passes_source_checker (i : Index) :
    ∀ n : Nat,
      VerifiedSourcePath i (canonicalEvents i n) (canonicalEnd i n) := by
  intro n
  induction n generalizing i with
  | zero => exact VerifiedSourcePath.empty i
  | succ n ih =>
      exact VerifiedSourcePath.next rfl (ih (sourceTransport i))

/-- COMPLETENESS FOR LOGS: the exact source generator leaves no choice
about a submitted valid event list given its origin and length. The
terminal position is equally determined. This proof uses a separately
defined validator and canonical generator, not a true-by-definition
readout predicate. -/
theorem verified_history_has_unique_canonical_contents
    {i j : Index} {events : List SlotEvent}
    (h : VerifiedSourcePath i events j) :
    events = canonicalEvents i events.length ∧
      j = canonicalEnd i events.length := by
  induction h with
  | empty i => exact ⟨rfl, rfl⟩
  | @next i j k tail hStep hLater ih =>
      rcases ih with ⟨hEvents, hEndpoint⟩
      change j = sourceTransport i at hStep
      subst j
      constructor
      · simp only [List.length_cons, canonicalEvents]
        exact congrArg (List.cons (i, sourceTransport i)) hEvents
      · simpa only [List.length_cons, canonicalEnd] using hEndpoint

/-- Two independently presented source-valid event logs of the same
length and starting slot are necessarily identical, and their final
slots are identical. They need not correspond to events that ran. -/
theorem equal_length_valid_source_logs_are_identical
    {i j k : Index} {events other : List SlotEvent}
    (hFirst : VerifiedSourcePath i events j)
    (hSecond : VerifiedSourcePath i other k)
    (hCount : events.length = other.length) :
    events = other ∧ j = k := by
  obtain ⟨hEvents, hJ⟩ :=
    verified_history_has_unique_canonical_contents hFirst
  obtain ⟨hOther, hK⟩ :=
    verified_history_has_unique_canonical_contents hSecond
  constructor
  · calc
      events = canonicalEvents i events.length := hEvents
      _ = canonicalEvents i other.length := congrArg (canonicalEvents i) hCount
      _ = other := hOther.symm
  · calc
      j = canonicalEnd i events.length := hJ
      _ = canonicalEnd i other.length := congrArg (canonicalEnd i) hCount
      _ = k := hK.symm

/-- The existing trackedPosition recurrence commutes with the
underlying frozen source map: all paths follow the same actual step. -/
theorem tracked_position_commutes_with_source (i : Index) :
    ∀ n : Nat,
      trackedPosition (sourceTransport i) n =
        sourceTransport (trackedPosition i n) := by
  intro n
  induction n with
  | zero => rfl
  | succ n ih =>
      change sourceTransport (trackedPosition (sourceTransport i) n) =
        sourceTransport (sourceTransport (trackedPosition i n))
      exact congrArg sourceTransport ih

/-- Canonical front-recursive final position agrees with the
independently constructed original tracked physical position. -/
theorem canonical_end_is_tracked_position (i : Index) :
    ∀ n : Nat, canonicalEnd i n = trackedPosition i n := by
  intro n
  induction n generalizing i with
  | zero => rfl
  | succ n ih =>
      change canonicalEnd (sourceTransport i) n =
        sourceTransport (trackedPosition i n)
      calc
        canonicalEnd (sourceTransport i) n =
          trackedPosition (sourceTransport i) n := ih (sourceTransport i)
        _ = sourceTransport (trackedPosition i n) :=
          tracked_position_commutes_with_source i n

/-- Old phase-4 append-only histories really record n source steps. -/
theorem generated_physical_history_length (i : Index) :
    ∀ n : Nat, (sourcePhysicalHistory i n).events.length = n := by
  intro n
  induction n with
  | zero => rfl
  | succ n ih =>
      simp [sourcePhysicalHistory, physicalStep, ih]

/-- Exact bridge: the pre-existing independently constructed
generator-derived physical-source history has canonical event contents.
The source checker is used to derive rather than merely declare this. -/
theorem generated_physical_history_has_canonical_events
    (i : Index) (n : Nat) :
    (sourcePhysicalHistory i n).events = canonicalEvents i n := by
  have hValid := generated_history_passes_source_path_verifier i n
  have hCanonical := (verified_history_has_unique_canonical_contents hValid).1
  rw [generated_physical_history_length i n] at hCanonical
  exact hCanonical

/-- The IR26 faithful recorded history has the same canonical
source event list (as a logical model record, not external evidence). -/
theorem generated_recorded_history_has_canonical_events
    (i : Index) (n : Nat) :
    (sourceRecordedHistory i n).events = canonicalEvents i n := by
  have hFaithful := full_finite_source_event_history_is_faithful i n
  calc
    (sourceRecordedHistory i n).events =
        (sourcePhysicalHistory i n).events.map (fun e : SlotEvent => e) :=
      hFaithful.2
    _ = (sourcePhysicalHistory i n).events := by simp
    _ = canonicalEvents i n := generated_physical_history_has_canonical_events i n

/-- A SOURCE-COMPATIBLE event log, with a separate interpretation of
whether the event was actually observed to have occurred. The latter
is deliberately not declared to follow from source validity. -/
structure InterpretedExecution where
  reportedEvents : List SlotEvent
  occurrenceClaim : Bool

def logReadout (x : InterpretedExecution) : List SlotEvent :=
  x.reportedEvents

def occurrenceStatus (x : InterpretedExecution) : Bool :=
  x.occurrenceClaim

/-- The two interpretations contain the SAME single actual-generator
edge as their submitted source-valid list; they differ only by a
separate occurrence claim. Neither is asserted as real-world fact. -/
def reportedPerformed : InterpretedExecution :=
  ⟨canonicalEvents 2 1, true⟩

def reportedReplay : InterpretedExecution :=
  ⟨canonicalEvents 2 1, false⟩

theorem both_reports_are_source_admissible :
    VerifiedSourcePath 2 (logReadout reportedPerformed) 3 ∧
      VerifiedSourcePath 2 (logReadout reportedReplay) 3 := by
  have h : VerifiedSourcePath 2 (canonicalEvents 2 1) (canonicalEnd 2 1) :=
    every_canonical_history_passes_source_checker 2 1
  have heq : canonicalEnd 2 1 = 3 := by
    unfold canonicalEnd sourceTransport
    decide
  rw [heq] at h
  exact ⟨h, h⟩

theorem same_source_log_but_opposite_occurrence_claim :
    logReadout reportedPerformed = logReadout reportedReplay ∧
      occurrenceStatus reportedPerformed = true ∧
      occurrenceStatus reportedReplay = false :=
  ⟨rfl, rfl, rfl⟩

/-- Even exact source-log validity does NOT independently furnish a
decoder of executed physical occurrence on this unrestricted
interpretation domain. An independently grounded observer or
physical-source event correspondence could restrict this domain. -/
theorem no_source_log_only_decoder_of_physical_occurrence :
    ¬ PhysicalBridges.IR132.ExactDecoder logReadout occurrenceStatus := by
  intro hDecoder
  have hFiber :=
    PhysicalBridges.IR132.exact_decoder_implies_fiber_constant
      logReadout occurrenceStatus hDecoder
  have heq := hFiber reportedPerformed reportedReplay
    same_source_log_but_opposite_occurrence_claim.1
  have hDiff := same_source_log_but_opposite_occurrence_claim
  rw [hDiff.2.1, hDiff.2.2] at heq
  cases heq

#print axioms verified_history_has_unique_canonical_contents
#print axioms equal_length_valid_source_logs_are_identical
#print axioms canonical_end_is_tracked_position
#print axioms generated_physical_history_has_canonical_events
#print axioms generated_recorded_history_has_canonical_events
#print axioms both_reports_are_source_admissible
#print axioms no_source_log_only_decoder_of_physical_occurrence

end PhysicalBridges.BCRDCanonicalEventHistory
