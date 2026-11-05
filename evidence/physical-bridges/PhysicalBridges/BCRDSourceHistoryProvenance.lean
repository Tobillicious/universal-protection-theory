import PhysicalBridges.BCRDTransportedParticularMarker
import PhysicalBridges.IRHistoryProvenance

/-!
# PR B phase 4 — source-generated finite event history with faithful provenance

4 November 2026. Source-grounded instantiation of IR26.

The frozen M-sector basis-position update gives a deterministic
transition for every source basis position (M0↔M1, four other fixed
positions). A modeled event records the actual position before and
after that step; the physical model history and durable coded record
append the SAME independently specified source event. The inherited
IR26 theorem then certifies provenance over every finite history.

This constitutes an exact internally faithful physical-SOURCE
position-event record, not an independently measured physical
installation, universal effect inventory, actual human/digital
subject, subjective continuation, authentic authorization,
OriginalX3.6 in the full physical sense, or universal UPT.
-/

namespace PhysicalBridges.BCRDSourceHistoryProvenance

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.IRHistoryProvenance

/-- Frozen event payload: actual old and new basis positions. -/
abbrev SlotEvent := Index × Index

/-- Event n is SOURCE-GENERATED, not a freely chosen
post-hoc label: its endpoints come from the exact frozen
position generator. -/
def eventAt (i : Index) (n : Nat) : SlotEvent :=
  (trackedPosition i n, sourceTransport (trackedPosition i n))

/-- Every recorded event's endpoints agree with the actual
source transition and the next tracked position. -/
theorem event_payload_is_actual_source_step
    (i : Index) (n : Nat) :
    (eventAt i n).1 = trackedPosition i n ∧
      (eventAt i n).2 = trackedPosition i (n+1) := by
  constructor <;> rfl

/-- Physical-source model's event-bearing history. This is
not a physical experiment or a living subject's biography. -/
def sourcePhysicalHistory (i : Index) : Nat → PhysicalHistory Index SlotEvent
  | 0 => ⟨i, []⟩
  | n + 1 =>
      physicalStep (sourcePhysicalHistory i n) (eventAt i n)

/-- The source-generated durable-event counterpart. No
independent sensor witness is claimed. -/
def sourceRecordedHistory (i : Index) : Nat → RecordedHistory Index SlotEvent
  | 0 => ⟨i, []⟩
  | n + 1 =>
      recordedStep (fun e : SlotEvent => e)
        (sourceRecordedHistory i n) (eventAt i n)

/-- Exact provenance of the entire source-generated event list
at every finite stage, by reuse of the existing IR26
one_step_faithful theorem — not by assuming Faithful. -/
theorem full_finite_source_event_history_is_faithful
    (i : Index) :
    ∀ n : Nat,
      Faithful (fun e : SlotEvent => e)
        (sourcePhysicalHistory i n) (sourceRecordedHistory i n) := by
  intro n
  induction n with
  | zero => exact ⟨rfl, rfl⟩
  | succ n ih =>
      exact one_step_faithful
        (fun e : SlotEvent => e)
        (sourcePhysicalHistory i n)
        (sourceRecordedHistory i n)
        ih (eventAt i n)

/-- Generated physical-source origin is retained across
every step; this is a basis-origin marker, not consciousness. -/
theorem finite_source_history_retains_origin
    (i : Index) :
    ∀ n : Nat, (sourcePhysicalHistory i n).origin = i := by
  intro n
  induction n with
  | zero => rfl
  | succ n ih =>
      simpa [sourcePhysicalHistory, physicalStep] using ih

/-- Source transport is injective on ALL basis positions. -/
theorem source_transport_is_injective :
    Function.Injective sourceTransport := by
  intro i j h
  have hh := congrArg sourceTransport h
  simpa only [source_transport_is_involution] using hh

/-- Finite sequences of actual source events never merge
two distinct basis-position tracks. Unlike immutable-orbit
labels, the tracked physical POSITION remains individuated. -/
theorem tracked_basis_positions_do_not_merge :
    ∀ n : Nat, Function.Injective (fun i : Index => trackedPosition i n) := by
  intro n
  induction n with
  | zero =>
      intro i j h
      exact h
  | succ n ih =>
      intro i j h
      apply ih
      exact source_transport_is_injective h

/-- The model simultaneously exhibits a nontrivial position
move, an exact event payload and a faithfully recorded source
history. This is a positive, non-vacuous event example, not X3. -/
theorem frozen_M0_event_has_faithful_source_record :
    (eventAt 2 0).1 = 2 ∧
    (eventAt 2 0).2 = 3 ∧
    Faithful (fun e : SlotEvent => e)
      (sourcePhysicalHistory 2 1) (sourceRecordedHistory 2 1) := by
  constructor
  · decide
  constructor
  · decide
  · exact full_finite_source_event_history_is_faithful 2 1

#print axioms event_payload_is_actual_source_step
#print axioms full_finite_source_event_history_is_faithful
#print axioms finite_source_history_retains_origin
#print axioms source_transport_is_injective
#print axioms tracked_basis_positions_do_not_merge
#print axioms frozen_M0_event_has_faithful_source_record

end PhysicalBridges.BCRDSourceHistoryProvenance
