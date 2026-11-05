import PhysicalBridges.BCRDValidatedCausalLog

/-!
# PR B phase 8 — exact causal reachability, not merely site covariance

4 November 2026 · frozen six-position source only.

Physical site L/M/R is preserved under the source generator, but
site equality is NOT a sufficient criterion for a possible causal
path. The exact frozen source relation is four singleton orbits
{L0}, {L1}, {R0}, {R1}, plus one M0↔M1 two-cycle.

This module proves both directions of a complete reachability
characterization, and supplies positive/negative controls.
It also proves that the source permits only one predecessor of
each basis position for any one-step event. These are
source-level causal structural facts, NOT actual experiencing
particulars, consent, X3, observation of execution or universal
BCRD physical source coverage.

One key anti-promotion control: sharing the stable L-site label
does not imply even eventual causal reachability between L0/L1.
Conversely M0/M1 are mutually reachable yet remain different
physical positions: an orbit class cannot stand in for a
unique individual subject.
-/

namespace PhysicalBridges.BCRDExactCausalOrbit

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.BCRDParticularCarrierCriterion
open PhysicalBridges.BCRDSourceHistoryProvenance (SlotEvent)
open PhysicalBridges.BCRDValidatedCausalLog

/-- The independently enumerated orbit partition of the
frozen source step, using original index values. -/
def SourceOrbit (i j : Index) : Prop :=
  i = j ∨ (i = 2 ∧ j = 3) ∨ (i = 3 ∧ j = 2)

/-- Every actual single source event stays within this orbit. -/
theorem each_source_edge_stays_in_orbit
    {i j : Index} (h : ActualPositionStep i j) :
    SourceOrbit i j := by
  have hAll : ∀ x : Index, SourceOrbit x (sourceTransport x) := by
    unfold SourceOrbit sourceTransport
    decide
  unfold ActualPositionStep at h
  rw [h]
  exact hAll i

/-- The listed orbit partition is transitive (6×6×6 finite
verification, independently of the event relation). -/
theorem source_orbit_transitive :
    ∀ i j k : Index,
      SourceOrbit i j → SourceOrbit j k → SourceOrbit i k := by
  unfold SourceOrbit
  decide

/-- NECESSITY: all finite paths of actual frozen source steps
remain within the precisely enumerated orbit, not just same
site. No subject or protection semantics are assumed. -/
theorem reachable_implies_same_source_orbit
    {i j : Index}
    (h : PhysicalBridges.IR96.Reach ActualPositionStep i j) :
    SourceOrbit i j := by
  induction h with
  | refl => exact Or.inl rfl
  | tail previous edge ih =>
      exact source_orbit_transitive _ _ _ ih
        (each_source_edge_stays_in_orbit edge)

/-- SUFFICIENCY: every pair of positions in the enumerated
source orbit is connected by zero or one source transition. -/
theorem same_source_orbit_implies_reachable
    {i j : Index} (h : SourceOrbit i j) :
    PhysicalBridges.IR96.Reach ActualPositionStep i j := by
  rcases h with hEq | h23 | h32
  · subst j
    exact PhysicalBridges.IR96.Reach.refl i
  · rcases h23 with ⟨rfl, rfl⟩
    apply PhysicalBridges.IR96.Reach.tail (PhysicalBridges.IR96.Reach.refl (2 : Index))
    unfold ActualPositionStep sourceTransport
    decide
  · rcases h32 with ⟨rfl, rfl⟩
    apply PhysicalBridges.IR96.Reach.tail (PhysicalBridges.IR96.Reach.refl (3 : Index))
    unfold ActualPositionStep sourceTransport
    decide

/-- EXACT frozen-source reachability classification. This
closes the finite reachability question for the six-slot event,
not the physical or experiencing-subject continuation question. -/
theorem exact_source_reachability_iff_orbit (i j : Index) :
    PhysicalBridges.IR96.Reach ActualPositionStep i j ↔
      SourceOrbit i j := by
  constructor
  · exact reachable_implies_same_source_orbit
  · exact same_source_orbit_implies_reachable

/-- Each independently source-validated submitted event log
must remain within the exact orbit of its declared origin. -/
theorem validated_log_implies_exact_source_orbit
    {i j : Index} {events : List SlotEvent}
    (h : VerifiedSourcePath i events j) :
    SourceOrbit i j :=
  (exact_source_reachability_iff_orbit i j).mp
    (verified_source_path_implies_actual_source_reach h)

/-- Conversely every orbit-reachable pair has SOME valid source
event log (zero or one event here): a complete representation
of all modeled possible endpoint transitions, not proof any
such event actually executed. -/
theorem orbit_pair_has_valid_source_event_log
    {i j : Index} (h : SourceOrbit i j) :
    ∃ events : List SlotEvent, VerifiedSourcePath i events j := by
  rcases h with hEq | h23 | h32
  · subst j
    exact ⟨[], VerifiedSourcePath.empty i⟩
  · rcases h23 with ⟨rfl, rfl⟩
    refine ⟨[(2, 3)], VerifiedSourcePath.next ?_ (VerifiedSourcePath.empty 3)⟩
    unfold ActualPositionStep sourceTransport
    decide
  · rcases h32 with ⟨rfl, rfl⟩
    refine ⟨[(3, 2)], VerifiedSourcePath.next ?_ (VerifiedSourcePath.empty 2)⟩
    unfold ActualPositionStep sourceTransport
    decide

/-- The L0/L1 indices share a stable qutrit site but have
NO finite source history that takes one to the other. -/
theorem same_site_not_sufficient_for_causal_reachability :
    ((0 : Index).val / 2 = (1 : Index).val / 2) ∧
    ¬ PhysicalBridges.IR96.Reach ActualPositionStep 0 1 := by
  constructor
  · decide
  · intro h
    have hOrb := (exact_source_reachability_iff_orbit 0 1).mp h
    have hNo : ¬ SourceOrbit 0 1 := by
      unfold SourceOrbit
      decide
    exact hNo hOrb

/-- Mutually reachable M0 and M1 are still two different
physical positions; their shared orbit is not a distinctness-
preserving identifier. -/
theorem mutual_M_reachability_does_not_identify_positions :
    (2 : Index) ≠ 3 ∧
      PhysicalBridges.IR96.Reach ActualPositionStep 2 3 ∧
      PhysicalBridges.IR96.Reach ActualPositionStep 3 2 := by
  refine ⟨(by decide), ?_, ?_⟩
  · exact (exact_source_reachability_iff_orbit 2 3).mpr
      (Or.inr (Or.inl ⟨rfl, rfl⟩))
  · exact (exact_source_reachability_iff_orbit 3 2).mpr
      (Or.inr (Or.inr ⟨rfl, rfl⟩))

/-- The source generator is FUNCTIONAL: one source basis
position has a unique immediate successor. -/
theorem source_next_position_is_unique
    {i j k : Index}
    (hij : ActualPositionStep i j)
    (hik : ActualPositionStep i k) : j = k := by
  unfold ActualPositionStep at hij hik
  exact hij.trans hik.symm

/-- The source generator is also one-to-one: every reachable
basis position has at most one immediate predecessor. -/
theorem source_predecessor_is_unique
    {i j k : Index}
    (hik : ActualPositionStep i k)
    (hjk : ActualPositionStep j k) : i = j := by
  unfold ActualPositionStep at hik hjk
  have hp : sourceTransport i = sourceTransport j := hik.symm.trans hjk
  have hh := congrArg sourceTransport hp
  simpa only [source_transport_is_involution] using hh

#print axioms exact_source_reachability_iff_orbit
#print axioms validated_log_implies_exact_source_orbit
#print axioms orbit_pair_has_valid_source_event_log
#print axioms same_site_not_sufficient_for_causal_reachability
#print axioms mutual_M_reachability_does_not_identify_positions
#print axioms source_next_position_is_unique
#print axioms source_predecessor_is_unique

end PhysicalBridges.BCRDExactCausalOrbit
