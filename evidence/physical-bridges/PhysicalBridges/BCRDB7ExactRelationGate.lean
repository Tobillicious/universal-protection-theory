import PhysicalBridges.BCRDComplexM3dStage

/-!
# BCRD M3d: exact relationally gated source coupling (B7 seed test)

Source: pinned physics-lane BCRD author-incubator M3d test
`verify_bcrd_m3d_state_determined_accessibility.py` @
`2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35`.

Find before build: `BCRDComplexM3dStage` already kernel-checks the
literal six-dimensional W and C_LM matrices, their unitarity,
and coherence produced from an M0 source input. The source Python
test separately estimates intervention-response signalling graphs.

This module proves a more narrowly stated, exact *source matrix*
discriminator: within the SAME fixed controlled L-M unitary, the
L-M cross-sector matrix element is zero for the r=0 block and
nonzero for the r=1 block. The endogenous W source update
makes two initial states at the SAME matter site M, differing only
in their relation bit, produce contrasting L-site amplitude after
the SAME subsequent controlled event.

No fixed adjacency is redefined by fiat; nothing here declares the
derived coupling matrix to be a physical spacetime metric.
Nonzero matrix amplitude is NOT an exhaustive operational causal
signalling criterion and these controls do NOT certify B7,
a gravitational constraint algebra, continuum geometry, GR, QG,
authentic subject meanings, or universal G3.

No changes to any original BCRD generator, Koru, OriginalX3 or
previous theorem statements. No additional axioms.
-/

namespace PhysicalBridges.BCRDB7ExactRelationGate

open PhysicalBridges.BCRDComplexM3dStage
open PhysicalBridges.FrozenBCRDEvents

/-- Same pinned C_LM has NO L0-M0 cross-amplitude when the
relational-bit sector is 0: its 0-sector is the identity. -/
theorem controlled_lm_cross_amplitude_disabled_at_r0 :
    sourceCLM (0 : Index) (2 : Index) = cz := by
  decide +kernel

/-- The identical fixed source matrix has a nonzero L1-M1
cross-amplitude in the 1-sector, equal to the pinned beta
coefficient -i sqrt(2)/2. -/
theorem controlled_lm_cross_amplitude_enabled_at_r1 :
    sourceCLM (1 : Index) (3 : Index) = beta := by
  decide +kernel

theorem pinned_control_coefficient_is_nonzero :
    beta ≠ cz := by
  decide +kernel

/-- The exact source matrix's cross-amplitude differs across
relation sectors without selecting a different event law. -/
theorem same_fixed_unitary_has_distinct_relation_sector_couplings :
    sourceCLM (0 : Index) (2 : Index) = cz ∧
    sourceCLM (1 : Index) (3 : Index) ≠ cz := by
  exact ⟨controlled_lm_cross_amplitude_disabled_at_r0,
    by rw [controlled_lm_cross_amplitude_enabled_at_r1]
       exact pinned_control_coefficient_is_nonzero⟩

/-- Source M0 has relational bit 0. The actual fixed endogenous
W stage maps it to M1, hence the SAME later C_LM produces the
nonzero L1 amplitude beta already certified by the exact
source complex-state history. -/
theorem endogenous_W_enables_L_amplitude_from_M0 :
    (matVec sourceCLM (matVec sourceW (basis 2))) (1 : Index) =
      beta ∧ beta ≠ cz := by
  constructor
  · have h := controlled_LM_produces_exact_complex_superposition
    exact congrFun h (1 : Index)
  · exact pinned_control_coefficient_is_nonzero

/-- By contrast, starting at M1 the same endogenous W reverses
the relational bit to 0 and the same subsequent controlled C_LM
does not generate an L0 amplitude. The process and operator
are not changed by the investigator between these cases. -/
theorem endogenous_W_disables_L_amplitude_from_M1 :
    (matVec sourceCLM (matVec sourceW (basis 3))) (0 : Index) =
      cz := by
  decide +kernel

/-- The paired source controls are NONTRIVIAL and discriminate two
different relation-bit inputs at the same matter site using the
one pinned operator sequence, not an invented safe-step filter. -/
theorem same_source_dynamics_distinguish_relational_inputs :
    (matVec sourceCLM (matVec sourceW (basis 2))) (1 : Index) ≠ cz ∧
    (matVec sourceCLM (matVec sourceW (basis 3))) (0 : Index) = cz := by
  exact ⟨by rw [(endogenous_W_enables_L_amplitude_from_M0).1]
            exact pinned_control_coefficient_is_nonzero,
    endogenous_W_disables_L_amplitude_from_M1⟩

#print axioms controlled_lm_cross_amplitude_disabled_at_r0
#print axioms controlled_lm_cross_amplitude_enabled_at_r1
#print axioms pinned_control_coefficient_is_nonzero
#print axioms same_fixed_unitary_has_distinct_relation_sector_couplings
#print axioms endogenous_W_enables_L_amplitude_from_M0
#print axioms endogenous_W_disables_L_amplitude_from_M1
#print axioms same_source_dynamics_distinguish_relational_inputs

end PhysicalBridges.BCRDB7ExactRelationGate
