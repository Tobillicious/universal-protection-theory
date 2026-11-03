import PhysicalBridges.ParticularSemanticsAudit
import PhysicalBridges.FrozenBCRDEvents
import PhysicalBridges.IR132ExactBoundaryReconstruction

/-!
# PR B phase 3 — static orbit labels collapse, dynamical markers stay distinct

4 November 2026 · research-only · exact frozen M0↔M1 operator substrate.

PR #287 correctly proves that any label constant on the swapped pair
is preserved by the event. This module performs a necessary hostile
**particular-discrimination** test on that design rule:

  A STATIC, invariant position label cannot ALSO distinguish all six
  original positions, because it must equate positions 2 and 3.

Positive replacement: let the marker MOVE WITH the actual frozen
source permutation. A time-indexed, transported label retains an
injective code, and its transported history identifies its original
basis position across every finite number of swaps. This is
nonmerging causal tracking of physical BASIS POSITIONS.

None of this establishes subjective continuity, authentic consent,
per-particular X3, or an identity decoder for real consciousness.
The positive dynamic label is intentionally transported by definition;
it is an exact representation of source dynamics, not evidence
that an independent physical subject law chooses this label.
-/

namespace PhysicalBridges.BCRDTransportedParticularMarker

open PhysicalBridges.FrozenBCRDEvents

/-- Exact frozen generator transport; all six source basis positions. -/
def sourceTransport : Index → Index := permutation

theorem source_transport_is_involution :
    ∀ x : Index, sourceTransport (sourceTransport x) = x := by
  decide

theorem source_transport_swaps_distinct_positions :
    sourceTransport (2 : Index) = 3 ∧
    sourceTransport (3 : Index) = 2 ∧
    (2 : Index) ≠ 3 := by
  decide

/-- A STATIC label is required to remain unchanged at its transported
basis position. This is the structural premise behind PR #287's
orbit-constant carrier, not a subjective-identity premise. -/
def StaticInvariant {α : Type} (c : Index → α) : Prop :=
  ∀ i, c (sourceTransport i) = c i

/-- Invariant static labels necessarily identify M0 and M1.
This is a *deduction* from the source swap, not an axiom. -/
theorem static_invariance_identifies_swapped_positions
    {α : Type} (c : Index → α) (h : StaticInvariant c) :
    c 2 = c 3 := by
  have h2 := h (2 : Index)
  have hp : sourceTransport (2 : Index) = 3 := by decide
  rw [hp] at h2
  exact h2.symm

/-- A static orbit-invariant label CANNOT uniquely distinguish
every source position. Particularly, it collapses M0 with M1.
That is the distinction between orbit-class persistence and
individual-position individuation. -/
theorem no_static_invariant_injective_position_code
    {α : Type} (c : Index → α) (h : StaticInvariant c) :
    ¬ Function.Injective c := by
  intro hInj
  have hEq := static_invariance_identifies_swapped_positions c h
  have h23 : (2 : Index) = 3 := hInj hEq
  exact (by decide : (2 : Index) ≠ 3) h23

/-- Source-site equivalence is one example: it stays unchanged but
cannot distinguish the two positions within its M-site orbit. -/
def physicalSite (i : Index) : Nat := i.val / 2

theorem physical_site_is_static_invariant :
    StaticInvariant physicalSite := by
  decide

theorem physical_site_cannot_encode_all_positions :
    ¬ Function.Injective physicalSite :=
  no_static_invariant_injective_position_code
    physicalSite physical_site_is_static_invariant

/-- Exact decoder impossibility: a non-injective orbit-invariant
position label cannot reconstruct the exact original source basis
position. This uses the inherited IR132 criterion, not a semantic
assertion about actual minds. -/
theorem no_exact_position_decoder_from_static_orbit_label
    {α : Type} (c : Index → α) (h : StaticInvariant c) :
    ¬ PhysicalBridges.IR132.ExactDecoder c (fun x : Index => x) := by
  intro hDecoder
  obtain ⟨decode, hCorrect⟩ := hDecoder
  have hEq := static_invariance_identifies_swapped_positions c h
  have h2 := hCorrect (2 : Index)
  have h3 := hCorrect (3 : Index)
  have h23 : (2 : Index) = 3 := by
    calc
      (2 : Index) = decode (c 2) := h2.symm
      _ = decode (c 3) := congrArg decode hEq
      _ = (3 : Index) := h3
  exact (by decide : (2 : Index) ≠ 3) h23

/-- DYNAMIC alternative: move the full marker through the actual
frozen source permutation. The code itself is not defined to be
constant at fixed positions. -/
def transportedCode {α : Type} (c : Index → α) : Index → α :=
  fun j => c (sourceTransport j)

/-- A basis marker travels with the source event. -/
theorem code_is_carried_to_the_transport
    {α : Type} (c : Index → α) (i : Index) :
    transportedCode c (sourceTransport i) = c i := by
  simp only [transportedCode, source_transport_is_involution]

/-- Injective source-position markers stay injective after actual
transport. Unlike a static orbit label, they do not merge M0/M1. -/
theorem transported_code_preserves_injectivity
    {α : Type} (c : Index → α)
    (hInj : Function.Injective c) :
    Function.Injective (transportedCode c) := by
  intro i j h
  have hp : sourceTransport i = sourceTransport j := hInj h
  have hp2 := congrArg sourceTransport hp
  simpa only [source_transport_is_involution] using hp2

/-- Concrete exact output distinction: originally different source
positions remain distinguishable through the swap by their
TRANSPORTED (not static) position markers. -/
theorem distinct_M_positions_remain_distinct_after_transport :
    transportedCode (fun i : Index => i) 2 ≠
      transportedCode (fun i : Index => i) 3 := by
  decide

/-- A decoder for the full dynamically transported POSITION code
exists, because the actual source transport is invertible. No
subject identity/agency/authorization detector is asserted. -/
theorem dynamic_position_code_has_exact_decoder :
    PhysicalBridges.IR132.ExactDecoder
      (transportedCode (fun i : Index => i)) (fun i : Index => i) := by
  refine ⟨sourceTransport, ?_⟩
  intro i
  exact source_transport_is_involution i

/-- Physical basis-position track after n repeated source events. -/
def trackedPosition (i : Index) : Nat → Index
  | 0 => i
  | n + 1 => sourceTransport (trackedPosition i n)

/-- Time-indexed marker field produced by the same source events. -/
def markerAt {α : Type} (c : Index → α) : Nat → Index → α
  | 0 => c
  | n + 1 => transportedCode (markerAt c n)

/-- A given original marker stays attached to its physically
tracked basis position along EVERY finite source trajectory. -/
theorem marker_history_tracks_original_basis_position
    {α : Type} (c : Index → α) (i : Index) :
    ∀ n : Nat, markerAt c n (trackedPosition i n) = c i := by
  intro n
  induction n with
  | zero => rfl
  | succ n ih =>
      change transportedCode (markerAt c n)
        (sourceTransport (trackedPosition i n)) = c i
      rw [code_is_carried_to_the_transport]
      exact ih

/-- No loss of position-code discrimination at ANY finite horizon:
source-injective initial labels remain source-injective after all
repeated M0↔M1 events. -/
theorem all_finite_source_steps_keep_position_codes_injective
    {α : Type} (c : Index → α)
    (hInjective : Function.Injective c) :
    ∀ n : Nat, Function.Injective (markerAt c n) := by
  intro n
  induction n with
  | zero => exact hInjective
  | succ n ih =>
      exact transported_code_preserves_injectivity
        (markerAt c n) ih

#print axioms static_invariance_identifies_swapped_positions
#print axioms no_static_invariant_injective_position_code
#print axioms no_exact_position_decoder_from_static_orbit_label
#print axioms code_is_carried_to_the_transport
#print axioms transported_code_preserves_injectivity
#print axioms marker_history_tracks_original_basis_position
#print axioms all_finite_source_steps_keep_position_codes_injective

end PhysicalBridges.BCRDTransportedParticularMarker
