import PhysicalBridges.BCRDB7ExactRelationGate

/-!
# BCRD B7: exact operational phase-intervention witness

Find-before-build: the pinned author BCRD M3d test already constructs
phase-port interventions and computes finite numerical operational
signalling matrices. Existing source Lean checks exact W, C_LM,
source amplitudes and relation-gated matrix entries. This module
adds an exact *intervention/measurement* discriminator on the SAME
source C_LM; it does not invent new physics or replace the generator.

An input is a coherent L+M superposition in a fixed relation-bit
sector, with independently normalized source weights. We compare
two input preparations differing by a local phase pi on L (a
unitary port intervention, not a change of physical generator)
and read the post-event M-site Born weight.

In sector r=0, C_LM acts as identity and the intervention cannot
change the M readout. In r=1, the fixed same C_LM is a nontrivial
partial swap: the destructive vs constructive phase alters the
M-site Born weight. Exact source amplitudes and squared norms are
checked over Q(sqrt(2),i), not floating point.

This is an operationally distinguishing FINITE intervention test.
It is not exhaustive CPTP signaling reconstruction, B7 geometry,
a metric, a continuum or GR/QG theorem, or subject-level ethics.
-/

namespace PhysicalBridges.BCRDB7ExactPhaseIntervention

open PhysicalBridges.BCRDComplexM3dStage
open PhysicalBridges.FrozenBCRDEvents

/-- Imaginary i in the pinned algebraic coefficient ring. -/
def imagUnit : Cx := ⟨sz, so⟩

/-- Unnormalized pure input |L,r> + i |M,r>. Exact normalization
comes from dividing all weights by the same squared norm 2. -/
def coherentInput (r : Nat) : State :=
  fun k => if k.val = r then co
           else if k.val = 2 + r then imagUnit
           else cz

/-- Same physical input after a local pi phase intervention at L:
-|L,r> + i |M,r>. It changes no M input population and does
not modify the source C_LM generator. -/
def phaseChangedInput (r : Nat) : State :=
  fun k => if k.val = r then cneg co
           else if k.val = 2 + r then imagUnit
           else cz

/-- Both preparations have equal norm-square 2, so comparing their
unnormalized M-output weights compares genuine normalized Born
probabilities after division by the same positive factor. -/
theorem equal_input_norms_in_both_relation_sectors :
    norm2 (coherentInput 0) = ⟨2,0⟩ ∧
    norm2 (phaseChangedInput 0) = ⟨2,0⟩ ∧
    norm2 (coherentInput 1) = ⟨2,0⟩ ∧
    norm2 (phaseChangedInput 1) = ⟨2,0⟩ := by
  decide +kernel

/-- In the disabled (r=0) sector, changing the L-phase cannot
change the M output population. The exact unnormalized M
weight is one for either preparation. -/
theorem disabled_sector_is_operationally_insensitive :
    cabs2 ((matVec sourceCLM (coherentInput 0)) (2 : Index)) = so ∧
    cabs2 ((matVec sourceCLM (phaseChangedInput 0)) (2 : Index)) = so := by
  decide +kernel

/-- In the enabled (r=1) sector, the same fixed C_LM operator
turns opposite L input phases into distinct M population
readouts: complete cancellation for the first, constructive
interference for the second. Raw M weights are 0 and 2,
respectively, before dividing by common input norm 2. -/
theorem enabled_sector_exhibits_exact_intervention_response :
    cabs2 ((matVec sourceCLM (coherentInput 1)) (3 : Index)) = sz ∧
    cabs2 ((matVec sourceCLM (phaseChangedInput 1)) (3 : Index)) = ⟨2,0⟩ := by
  decide +kernel

/-- The intervention is not distinguishable at the chosen output
for r=0, but is distinguishable for r=1. This constitutes
an exact source-model operational response witness, not the
entire original source signalling adjacency graph. -/
theorem relation_state_changes_operational_intervention_response :
    cabs2 ((matVec sourceCLM (coherentInput 0)) (2 : Index)) =
      cabs2 ((matVec sourceCLM (phaseChangedInput 0)) (2 : Index)) ∧
    cabs2 ((matVec sourceCLM (coherentInput 1)) (3 : Index)) ≠
      cabs2 ((matVec sourceCLM (phaseChangedInput 1)) (3 : Index)) := by
  constructor
  · rw [disabled_sector_is_operationally_insensitive.1,
        disabled_sector_is_operationally_insensitive.2]
  · rw [enabled_sector_exhibits_exact_intervention_response.1,
        enabled_sector_exhibits_exact_intervention_response.2]
    decide

/-- The phase port is actually changed in both sectors; the
zero-response in r=0 is not caused by a vacuous identical input. -/
theorem input_phase_intervention_is_nontrivial :
    coherentInput 0 ≠ phaseChangedInput 0 ∧
    coherentInput 1 ≠ phaseChangedInput 1 := by
  constructor
  · intro h
    have hAt := congrFun h (0 : Index)
    have hNe : co ≠ cneg co := by decide +kernel
    exact hNe (by simpa [coherentInput, phaseChangedInput] using hAt)
  · intro h
    have hAt := congrFun h (1 : Index)
    have hNe : co ≠ cneg co := by decide +kernel
    exact hNe (by simpa [coherentInput, phaseChangedInput] using hAt)

#print axioms equal_input_norms_in_both_relation_sectors
#print axioms disabled_sector_is_operationally_insensitive
#print axioms enabled_sector_exhibits_exact_intervention_response
#print axioms relation_state_changes_operational_intervention_response
#print axioms input_phase_intervention_is_nontrivial

end PhysicalBridges.BCRDB7ExactPhaseIntervention
