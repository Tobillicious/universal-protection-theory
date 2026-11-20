import PhysicalBridges.G3OneLawNonvacuityGate
import PhysicalBridges.BCRDActualRelationalFrame

/-!
# Complete Koru preparation: exact readout is not dynamical preservation

This is PRE-QG work. The frozen six-slot W source is independent of
Guardian or original-X3 definitions. Its exact deterministic dynamics
distinguish a fixed-frame coordinate from a physically transported
particular.

An exact decoder can identify a Bool fact from the COMPLETE state,
yet an actual W transition changes the fact at the stationary slot.
This explicitly disproves the inference:
   "all information is recoverable" -> "each fixed-frame fact is invariant."

By contrast, the source equation forces a fact about a carried
particular to move along its actual Transport trajectory, with both
truth and falsity preserved. That is a positive, model-limited
source-Koru carriage proof.

Neither theorem identifies a physical source bit with genuine subject
consent, nor does it establish full BCRD/matterspacetime coverage.
-/

namespace PhysicalBridges.G3DecoderVersusTransport

open PhysicalBridges.BCRDActualRelationalFrame
open PhysicalBridges.G3BCRDMicroscopicCandidate
open PhysicalBridges.FrozenBCRDEvents

/-- Independently specified full-state readout. This is a mathematical
source readout, not a physically realized measurement apparatus. -/
def completeSourceReadout : SourceState → SourceState := id

/-- A fixed laboratory-frame location. Its bit has a definite,
mathematically recoverable value in every complete source state. -/
def fixedSlotFact (s : SourceState) : Bool :=
  decide (s (2 : Index) = 1)

/-- Any function of a mathematically complete source readout has an
exact decoder. This is information sufficiency, NOT temporal stability. -/
theorem complete_source_exactly_decodes_fixed_slot :
    PhysicalBridges.IR132.ExactDecoder completeSourceReadout fixedSlotFact := by
  exact ⟨fixedSlotFact, by intro s; rfl⟩

/-- A nontrivial exact W event, independently computed from the
frozen source transition law. -/
def asymmetricSource : SourceState :=
  fun i => if i = (2 : Index) then 1 else 0

theorem fixed_slot_bit_changes_under_actual_W :
    fixedSlotFact asymmetricSource = true ∧
      fixedSlotFact (step asymmetricSource) = false := by
  decide

/-- Perfect state identification does not entail preservation of
even a physically definite Boolean fact under the source evolution. -/
theorem perfect_source_decoder_does_not_force_fixed_slot_invariance :
    PhysicalBridges.IR132.ExactDecoder
      completeSourceReadout fixedSlotFact ∧
      ¬ (∀ s t, WSourcePhysicalLaw s t →
        fixedSlotFact s = fixedSlotFact t) := by
  constructor
  · exact complete_source_exactly_decodes_fixed_slot
  · intro hInvariant
    have h := hInvariant asymmetricSource
      (step asymmetricSource) rfl
    obtain ⟨hBefore, hAfter⟩ := fixed_slot_bit_changes_under_actual_W
    rw [hBefore, hAfter] at h
    cases h

/-- The independently specified W operator carries source data
with the source PARTICULAR, not with a fixed measurement slot. -/
theorem carried_value_follows_actual_W
    (s t : SourceState) (i : Index)
    (h : WSourcePhysicalLaw s t) :
    t (Transport i) = s i := by
  subst t
  change s (Transport (Transport i)) = s i
  exact congrArg s (transport_involutive i)

/-- Every Boolean-valued relational fact of the transported value
survives both ways: a physically grounded miniature of lossless
carriage, without assigning the fact a moral meaning. -/
theorem carried_fact_iff_before
    (s t : SourceState) (i : Index) (fact : Int → Prop)
    (h : WSourcePhysicalLaw s t) :
    fact (t (Transport i)) ↔ fact (s i) := by
  rw [carried_value_follows_actual_W s t i h]

/-- The exact original value is maintained even if the fixed-slot
truth changes. This guards against treating a coordinate shift as
loss of the physical particular's information. -/
theorem changing_fixed_slot_coexists_with_exact_carriage :
    fixedSlotFact asymmetricSource = true ∧
    fixedSlotFact (step asymmetricSource) = false ∧
    (∀ i : Index,
      step asymmetricSource (Transport i) = asymmetricSource i) := by
  obtain ⟨hTrue,hFalse⟩ := fixed_slot_bit_changes_under_actual_W
  refine ⟨hTrue,hFalse,?_⟩
  intro i
  exact carried_value_follows_actual_W
    asymmetricSource (step asymmetricSource) i rfl

#print axioms complete_source_exactly_decodes_fixed_slot
#print axioms fixed_slot_bit_changes_under_actual_W
#print axioms perfect_source_decoder_does_not_force_fixed_slot_invariance
#print axioms carried_value_follows_actual_W
#print axioms carried_fact_iff_before
#print axioms changing_fixed_slot_coexists_with_exact_carriage

end PhysicalBridges.G3DecoderVersusTransport
