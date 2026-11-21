import PhysicalBridges.RouteBFullComplexKoruTest

/-!
# Exact complex source: the binary Koru observation cannot recover the whole event

This module is additive to #356. It formalises the information gap with an
explicit nonfactorisation proof, using the *original* Koru relation on the
*actual pinned exact-complex BCRD M3d* source-stage matrices. No Boolean
replacement dynamics, no artificial mutation, no weakened original X3.

The afterW -> afterLM source step preserves every binary Koru relation
between the six source origins, while the exact complex L1/M1 off-diagonal
coherence changes from zero to nonzero. Thus no function of binary Koru
alone can reconstruct that source observable, nor all six full-amplitude
signatures. In contrast, the complete six-origin amplitude readout
constructively recovers that observable without a stage oracle.

This settles a precise finite-source factorisation question, *not* the
real-world original-X3/authorization/continuation bridge. It does not show
that a BCRD process, original Koru or full source signatures force the
authentic protections of actual people, or that these finite computed
stages are cosmological events.
-/

namespace PhysicalBridges.RouteBComplexKoruFactorization

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDComplexM3dStage
open PhysicalBridges.BCRDComplexCarrierAudit
open PhysicalBridges.Koru
open PhysicalBridges.RouteBFullComplexKoruTest

/-- The complete original-binary-Koru truth table computed from one
exact algebraic-complex M3d source stage. -/
def binaryKoruObservation (m : SourceMoment) : Index → Index → Prop :=
  fun i j => koru (physicalComplexStageWeb m) i j

/-- Physical source observable, computed from amplitudes rather than
stored as a separate tag indicating the stage or its operator. -/
def complexCoherence (m : SourceMoment) : Cx :=
  density (snapshot m 2) 1 3

/-- The full six-origin amplitude readout derived by exact source dynamics. -/
def fullAmplitudeObservation (m : SourceMoment) : Index → State :=
  fun i => snapshot m i

/-- The physically computed W -> controlled-L/M step is invisible to the
entire *original binary-Koru* relational truth table. -/
theorem original_binary_Koru_observation_unchanged :
    binaryKoruObservation .afterW = binaryKoruObservation .afterLM := by
  funext i j
  apply propext
  exact original_Koru_never_loses_source_carrier_distinction
    .afterW .afterLM i j

/-- That exact same source step is distinguishable by the original
complex source operator's off-diagonal density entry. -/
theorem exact_complex_source_coherence_changes :
    complexCoherence .afterW ≠ complexCoherence .afterLM := by
  intro hEq
  apply actual_controlled_LM_step_changes_complex_coherence.2
  exact (show
    density (snapshot SourceMoment.afterLM 2) 1 3 =
      density (snapshot SourceMoment.afterW 2) 1 3 from hEq.symm).trans
    actual_controlled_LM_step_changes_complex_coherence.1

/-- Nonfactorisation: no decoder using *only* the original binary Koru
truth table can compute the correct complex coherence across every
pinned exact-complex BCRD M3d source stage. This is an information
theorem, not an assumption that binary Koru is incomplete. -/
theorem no_binary_Koru_only_complex_coherence_decoder :
    ¬ ∃ decode : (Index → Index → Prop) → Cx,
      ∀ m : SourceMoment,
        decode (binaryKoruObservation m) = complexCoherence m := by
  rintro ⟨decode, hDecode⟩
  apply exact_complex_source_coherence_changes
  calc
    complexCoherence .afterW =
        decode (binaryKoruObservation .afterW) := (hDecode .afterW).symm
    _ = decode (binaryKoruObservation .afterLM) := by
          rw [original_binary_Koru_observation_unchanged]
    _ = complexCoherence .afterLM := hDecode .afterLM

/-- Positive recovery: the complete six-origin amplitude signatures
already contain the exact coherence. This decoder reads the independent
complex source coordinates; it does not assume safety, authorization
or the desired output as a new field. -/
theorem complete_amplitude_source_recovers_complex_coherence :
    ∃ decode : (Index → State) → Cx,
      ∀ m : SourceMoment,
        decode (fullAmplitudeObservation m) = complexCoherence m := by
  refine ⟨(fun signatures => density (signatures 2) 1 3), ?_⟩
  intro m
  rfl

/-- A fortiori, no original binary-Koru-only decoder reconstructs the
whole six-origin complex amplitude signature at each source stage. -/
theorem no_binary_Koru_only_complete_amplitude_decoder :
    ¬ ∃ decode : (Index → Index → Prop) → (Index → State),
      ∀ m : SourceMoment,
        decode (binaryKoruObservation m) = fullAmplitudeObservation m := by
  rintro ⟨decode, hDecode⟩
  apply no_binary_Koru_only_complex_coherence_decoder
  refine ⟨(fun observation => density ((decode observation) 2) 1 3), ?_⟩
  intro m
  exact congrArg (fun signatures : Index → State =>
    density (signatures 2) 1 3) (hDecode m)

#print axioms original_binary_Koru_observation_unchanged
#print axioms exact_complex_source_coherence_changes
#print axioms no_binary_Koru_only_complex_coherence_decoder
#print axioms complete_amplitude_source_recovers_complex_coherence
#print axioms no_binary_Koru_only_complete_amplitude_decoder

end PhysicalBridges.RouteBComplexKoruFactorization
