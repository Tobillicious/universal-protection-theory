import PhysicalBridges.BCRDSourceHistoryProvenance
import PhysicalBridges.IR96DisturbanceSimulation

/-!
# PR B phase 5 — exact source-carrier criterion for candidate particulars

4 November 2026. Physical-source proof, *not* subjective identity.

The exact frozen BCRD six-position generator is an involution.
Given ANY proposed map from a type P of candidate particulars to
physical basis positions, its finite transported trajectories:
- satisfy the exact source-step transition relation;
- have source-generated, faithfully matching event histories (IR26);
- preserve AND REFLECT whether the original map was injective.

The crucial biconditional is "injective after n steps ↔ injective at
the start". An automorphism CANNOT CREATE a missing subject-to-carrier
injection. Thus source nonmerging does not itself justify that each
actual experiencing subject already has a distinct authentic carrier.

The countercontrol maps two different Bool candidate particulars to
the SAME physical source position. Every source-step/record theorem
still holds separately, but the trajectories remain merged forever.
This is a source/representation *scope test*, NOT an actual event
destroying or merging two real subjects.

Neither semantic identity nor authentic authorization nor the six
OriginalX3 duties are assumed, derived or redefined here.
-/

namespace PhysicalBridges.BCRDParticularCarrierCriterion

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.BCRDSourceHistoryProvenance
open PhysicalBridges.IRHistoryProvenance

universe u

/-- The physical source-step relation independent of any putative
subject type, consent flag, X3 duty or safety criterion. -/
def ActualPositionStep (i j : Index) : Prop :=
  j = sourceTransport i

/-- Every event emitted by the frozen generator has exact physical
source-step endpoints. -/
theorem generated_event_is_actual_position_step (i : Index) (n : Nat) :
    ActualPositionStep (eventAt i n).1 (eventAt i n).2 :=
  rfl

/-- Every finite frozen source trajectory is a causal chain of
genuine source-generator steps, not a list of fabricated endpoints. -/
theorem each_finite_track_has_actual_source_path (i : Index) :
    ∀ n : Nat,
      PhysicalBridges.IR96.Reach ActualPositionStep
        i (trackedPosition i n) := by
  intro n
  induction n with
  | zero => exact PhysicalBridges.IR96.Reach.refl i
  | succ n ih =>
      exact PhysicalBridges.IR96.Reach.tail ih rfl

/-- An UNVALIDATED candidate mapping of putative particulars to
physical source positions. No map is declared to represent a real
subject just by its type. -/
def CarrierAt {P : Type u} (c : P → Index) (n : Nat) (p : P) : Index :=
  trackedPosition (c p) n

/-- The exact criterion: a proposed map of distinct particulars to
physical positions is injective AFTER N source steps IF AND ONLY IF
it was already injective BEFORE evolution. This does not assume
injection, and source dynamics does not produce it out of nothing. -/
theorem carrier_injective_after_iff_before {P : Type u}
    (c : P → Index) (n : Nat) :
    Function.Injective (CarrierAt c n) ↔ Function.Injective c := by
  constructor
  · intro h p q hCode
    exact h (congrArg (fun i : Index => trackedPosition i n) hCode)
  · intro h p q hTrack
    exact h ((tracked_basis_positions_do_not_merge n) hTrack)

/-- The source causal chain exists for every candidate carrier,
regardless of whether the proposed carrier map is valid as a
real-person interpretation. -/
theorem candidate_carrier_has_exact_source_path {P : Type u}
    (c : P → Index) (p : P) (n : Nat) :
    PhysicalBridges.IR96.Reach ActualPositionStep
      (c p) (CarrierAt c n p) :=
  each_finite_track_has_actual_source_path (c p) n

/-- Source-generated record agreement follows the actual exact
physical history for each candidate; this is a formal history
agreement, not a separate authenticated observation or consent. -/
theorem candidate_carrier_has_faithful_finite_history {P : Type u}
    (c : P → Index) (p : P) (n : Nat) :
    Faithful (fun e : SlotEvent => e)
      (sourcePhysicalHistory (c p) n)
      (sourceRecordedHistory (c p) n) :=
  full_finite_source_event_history_is_faithful (c p) n

/-- One source-grounded conditional package: IF an independent
model has justified an injective carrier, then physical positions
stay distinguished, exact causal traces exist, and source-event
histories match for every finite horizon. No OriginalX3 semantic
field occurs among the hypotheses or conclusions. -/
theorem justified_injective_carrier_retains_finite_source_witness
    {P : Type u} (c : P → Index)
    (hIdentified : Function.Injective c) :
    ∀ n : Nat,
      Function.Injective (CarrierAt c n) ∧
      (∀ p : P,
        PhysicalBridges.IR96.Reach ActualPositionStep
          (c p) (CarrierAt c n p) ∧
        Faithful (fun e : SlotEvent => e)
          (sourcePhysicalHistory (c p) n)
          (sourceRecordedHistory (c p) n)) := by
  intro n
  refine ⟨(carrier_injective_after_iff_before c n).mpr hIdentified, ?_⟩
  intro p
  exact ⟨candidate_carrier_has_exact_source_path c p n,
    candidate_carrier_has_faithful_finite_history c p n⟩

/-- Hostile representation: two distinct *candidate identifiers*
may be mapped to a single physical position. This is not a
claim that two real conscious subjects share an actual basis slot. -/
def collidingCandidateCarrier : Bool → Index := fun _ => 2

theorem colliding_candidates_share_every_source_position :
    ∀ n : Nat,
      CarrierAt collidingCandidateCarrier n false =
        CarrierAt collidingCandidateCarrier n true := by
  intro n
  rfl

/-- Nonmerging dynamics cannot repair an already colliding candidate
map. A true subject identity theorem needs an independently warranted
faithful carrier rather than relying on physical reversibility alone. -/
theorem source_nonmerging_cannot_certify_colliding_candidates :
    ∀ n : Nat,
      ¬ Function.Injective (CarrierAt collidingCandidateCarrier n) := by
  intro n hInj
  have hEq : (false : Bool) = true :=
    hInj (colliding_candidates_share_every_source_position n)
  cases hEq

/-- Even when carrier individuation fails, each candidate can have
a formally faithful exact generator history; IR26 fidelity alone
does not certify that it refers to the right subject. -/
theorem colliding_candidates_still_have_faithful_source_histories :
    ∀ (p : Bool) (n : Nat),
      Faithful (fun e : SlotEvent => e)
        (sourcePhysicalHistory (collidingCandidateCarrier p) n)
        (sourceRecordedHistory (collidingCandidateCarrier p) n) := by
  intro p n
  exact candidate_carrier_has_faithful_finite_history
    collidingCandidateCarrier p n

#print axioms generated_event_is_actual_position_step
#print axioms each_finite_track_has_actual_source_path
#print axioms carrier_injective_after_iff_before
#print axioms justified_injective_carrier_retains_finite_source_witness
#print axioms source_nonmerging_cannot_certify_colliding_candidates
#print axioms colliding_candidates_still_have_faithful_source_histories

end PhysicalBridges.BCRDParticularCarrierCriterion
