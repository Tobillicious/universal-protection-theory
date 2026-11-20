import PhysicalBridges.BCRDB7ExactPhaseIntervention

/-!
# B7 source check: operational response through the FULL pinned compound

The preceding exact B7 test checked the isolated C_LM stage. This
additional test checks the ORIGINAL BCRD M3d frozen compound
U_FIXED = C_LM * U_MR_6 * C_LM, not a hand-picked alternate matrix.

The pinned theory incubator's finite operational signalling test
used a phase-port intervention and Q_M output measurement under
U_FIXED. Here the controlled intervention is fixed: pi phase
shift on the L coefficient of a coherent L+ i M pure preparation.
The squared norms of the two input states are equal to two.

At relational bit r=0, the original compound leaves L isolated,
and M readout does not change when L's phase is inverted.
At relational bit r=1, exact complex interference affects the
M readout. The raw M weights are one and one-half (normalized
probabilities one-half and one-quarter).

These are *one particular* phase/input/output witness from the
original pinned source operator. Not the full M3d intervention
optimization or CPTP channel claim, not emergent metric/geometry,
not B7 closure, not gravity, and not QG.
-/

namespace PhysicalBridges.BCRDB7FullCompoundResponse

set_option maxRecDepth 16384

open PhysicalBridges.BCRDComplexM3dStage
open PhysicalBridges.BCRDB7ExactPhaseIntervention
open PhysicalBridges.FrozenBCRDEvents

/-- The same source-fixed U_FIXED, for both intervention cases. -/
def compoundReadout (v : State) (index : Index) : Surd :=
  cabs2 ((matVec sourceUFixed v) index)

/-- Source normalized inputs have equal norm and no chosen
'guardian' or X3 predicate enters the dynamics. -/
theorem full_compound_inputs_equal_norm :
    norm2 (coherentInput 0) = norm2 (phaseChangedInput 0) ∧
    norm2 (coherentInput 1) = norm2 (phaseChangedInput 1) := by
  exact ⟨equal_input_norms_in_both_relation_sectors.1.trans
    equal_input_norms_in_both_relation_sectors.2.1.symm,
    equal_input_norms_in_both_relation_sectors.2.2.1.trans
    equal_input_norms_in_both_relation_sectors.2.2.2.symm⟩

/-- Exact finite negative control: in the relation-0 block,
the L0 input cannot contribute to the M0 output via U_FIXED.
The two M0 readouts are identical and equal to squared amplitude 1. -/
theorem full_compound_r0_no_L_phase_response :
    compoundReadout (coherentInput 0) (2 : Index) = so ∧
    compoundReadout (phaseChangedInput 0) (2 : Index) = so := by
  decide +kernel

/-- Exact finite positive control: under the SAME U_FIXED,
the relation-1 block permits an L1 input phase to change the
M1 output through the full LM-MR-LM stage sequence.
Raw weights 1 and 1/2; normalized M probabilities 1/2 and 1/4
because both inputs have norm-square 2. -/
theorem full_compound_r1_has_L_phase_response :
    compoundReadout (coherentInput 1) (3 : Index) = so ∧
    compoundReadout (phaseChangedInput 1) (3 : Index) =
      ⟨(1 : Rat)/2, 0⟩ := by
  decide +kernel

/-- One nontrivial and one genuinely absent operational
intervention response under the SAME full BCRD compound operator.
This recovers a source-grounded restricted operational locality
discriminator without assuming a physical graph or metric. -/
theorem fixed_compound_relationally_gates_operational_response :
    compoundReadout (coherentInput 0) (2 : Index) =
      compoundReadout (phaseChangedInput 0) (2 : Index) ∧
    compoundReadout (coherentInput 1) (3 : Index) ≠
      compoundReadout (phaseChangedInput 1) (3 : Index) := by
  constructor
  · rw [full_compound_r0_no_L_phase_response.1,
        full_compound_r0_no_L_phase_response.2]
  · rw [full_compound_r1_has_L_phase_response.1,
        full_compound_r1_has_L_phase_response.2]
    decide +kernel

/-- Nonvacuity: the two local phase inputs are distinct for each
sector; no output difference is introduced by switching the source
physical operator between the cases. -/
theorem full_compound_intervention_is_genuine :
    coherentInput 0 ≠ phaseChangedInput 0 ∧
    coherentInput 1 ≠ phaseChangedInput 1 :=
  input_phase_intervention_is_nontrivial

#print axioms full_compound_inputs_equal_norm
#print axioms full_compound_r0_no_L_phase_response
#print axioms full_compound_r1_has_L_phase_response
#print axioms fixed_compound_relationally_gates_operational_response
#print axioms full_compound_intervention_is_genuine

end PhysicalBridges.BCRDB7FullCompoundResponse
