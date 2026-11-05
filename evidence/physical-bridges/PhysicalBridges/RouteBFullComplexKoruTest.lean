import PhysicalBridges.RouteBSemanticKeystoneIndependence
import PhysicalBridges.BCRDComplexCarrierAudit
import PhysicalBridges.Koru

/-!
# Route B on the actual complex BCRD source: with and without original Koru

6 November 2026, research-only additive stone stacked on #355.
Frozen summit, original six X3 protections and main are untouched.

NO TOY DYNAMICS: This test uses the independently source-pinned
exact algebraic-complex BCRD M3d stage equations from
BCRDComplexM3dStage/BCRDComplexCarrierAudit:
W, C_LM, U_MR6, C_LM, on all SIX initial source basis carriers.
Complex amplitudes are exact Q(sqrt(2),i), with no floating-point
approximations or a replacement binary toy transition.

1. WITHOUT KORU as an extra assumption: all six source carrier
   full-amplitude signatures remain injective at each of the five
   mathematically calculated stage boundaries.
2. WITH THE ORIGINAL KORU: equip the same actual source stages with
   the independently calculated relation "the full complex signatures
   of two source origins coincide". Prove Koru(a,b) IFF a != b
   at EVERY stage. Thus NO first source-carrier Koru distinction
   can be lost across ANY source stage boundary; this uses the
   banked exact complex separation theorem, not a handpicked
   safety-filtered physical step.
3. PHYSICAL INFORMATION LIMIT: the complete binary Koru relation
   on six origins is UNCHANGED when the pinned actual W -> C_LM
   evolution introduces nonzero off-diagonal imaginary coherence.
   Hence original Koru individuation alone is a FORGETFUL
   projection of the full complex operator/source dynamics.
   Stronger full-signature information may matter for Route B.

IMPORTANT: These six 'origins' are physical SOURCE candidates, NOT
authenticated experiencing individuals. Amplitude injectivity,
Koru individuation and quantum coherence do NOT entail authentic
consent, freedom, restraint, maximality, subjective historical
continuation or provenance. They do not close the original X3
source-to-particular keystone. The mathematical stage sequence
W then C_LM then U_MR6 then C_LM is explicitly the CONSTRUCTED
pinned-source sequence already formalised by the bank; actual
physical occurrence and full cosmological BCRD coverage remain open.
-/

namespace PhysicalBridges.RouteBFullComplexKoruTest

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDComplexM3dStage
open PhysicalBridges.BCRDComplexCarrierAudit
open PhysicalBridges.Koru

/-- The full complex SOURCE amplitude signature of each initial
basis carrier at an actual pinned M3d stage. The source dynamics
are exactly the previously verified 6x6 complex matrices,
not a stipulated no-merger or protection predicate. -/
def physicalComplexStageWeb (m : SourceMoment) : Web Index where
  link := fun i j => snapshot m i = snapshot m j

/-- Without using Koru, the exact algebraic-complex BCRD
stage equations independently prevent any two initially
distinct source basis carriers from merging in full amplitude
signature at EVERY one of the five computed stage boundaries. -/
theorem complex_source_signatures_injective_without_Koru
    (m : SourceMoment) :
    Function.Injective (snapshot m) := by
  intro i j hSame
  by_cases h : i = j
  · exact h
  · obtain ⟨coordinate,hDifferent⟩ :=
      all_six_basis_candidates_separate_through_every_stage
        m i j h
    exact False.elim (hDifferent (congrFun hSame coordinate))

/-- On the SAME real operator-derived complex stage, the original
nonreflexive Koru precisely articulates every genuinely
distinguishable initial source basis carrier. It is earned
from the independently calculated amplitude signatures. -/
theorem complex_source_Koru_iff_distinct_origins
    (m : SourceMoment) (i j : Index) :
    koru (physicalComplexStageWeb m) i j ↔ i ≠ j := by
  constructor
  · exact koru_distinct _ _ _
  · intro hDiff
    refine ⟨hDiff,i,?_⟩
    change
      ((snapshot m i = snapshot m i) : Prop) ≠
        (snapshot m j = snapshot m i)
    intro hSameTruth
    have hSelf : snapshot m i = snapshot m i := rfl
    have hSame : snapshot m j = snapshot m i :=
      Eq.mp hSameTruth hSelf
    exact hDiff ((complex_source_signatures_injective_without_Koru m)
      hSame.symm)

/-- No first original-Koru SOURCE distinction loss across any
two actual BCRD complex-stage boundaries, including coherence
creation by controlled source interactions. The claim is about
tracked physical source origins, NOT original X3 subjects. -/
theorem original_Koru_never_loses_source_carrier_distinction
    (before after : SourceMoment) (i j : Index) :
    koru (physicalComplexStageWeb before) i j ↔
      koru (physicalComplexStageWeb after) i j := by
  rw [complex_source_Koru_iff_distinct_origins,
      complex_source_Koru_iff_distinct_origins]

/-- This is an explicit first-loss impossibility over the
actual banked stage sequence, not merely its W substage.
It holds at all five exact full complex source boundaries. -/
theorem no_first_original_Koru_loss_across_complex_M3d :
    ¬ ∃ before after : SourceMoment, ∃ i j : Index,
      koru (physicalComplexStageWeb before) i j ∧
        ¬ koru (physicalComplexStageWeb after) i j := by
  rintro ⟨before,after,i,j,hBefore,hAfterBad⟩
  exact hAfterBad
    ((original_Koru_never_loses_source_carrier_distinction
      before after i j).mp hBefore)

/-- The true source event is demonstrably NOT frozen:
the W-produced physical state has no L1-M1 coherence,
but the EXACT C_LM complex partial swap creates a nonzero
purely imaginary L1-M1 density entry. -/
theorem actual_controlled_LM_step_changes_complex_coherence :
    density (snapshot .afterW 2) 1 3 = cz ∧
      density (snapshot .afterLM 2) 1 3 ≠ cz := by
  constructor
  · have hW : snapshot .afterW 2 = BCRDComplexM3dStage.afterW := rfl
    rw [hW, W_moves_M0_to_M1]
    decide +kernel
  · have hLM : snapshot .afterLM 2 = BCRDComplexM3dStage.afterC := rfl
    rw [hLM]
    exact source_state_has_nonzero_imaginary_coherence.2

/-- THE MAIN WITH/WITHOUT TEST: on the SAME actual pinned
complex BCRD W -> C_LM event, ALL original binary
Koru distinctions are unchanged while genuinely new
complex coherence appears. Original Koru is therefore
not by itself a complete invariant of physical dynamics:
its full source/operator signature has MORE information
than the binary distinction operator records. -/
theorem original_Koru_is_stable_but_does_not_capture_all_physics :
    (∀ i j : Index,
      koru (physicalComplexStageWeb .afterW) i j ↔
        koru (physicalComplexStageWeb .afterLM) i j) ∧
    density (snapshot .afterW 2) 1 3 = cz ∧
    density (snapshot .afterLM 2) 1 3 ≠ cz := by
  refine ⟨?_,actual_controlled_LM_step_changes_complex_coherence.1,
    actual_controlled_LM_step_changes_complex_coherence.2⟩
  intro i j
  exact original_Koru_never_loses_source_carrier_distinction
    .afterW .afterLM i j

/-- Real nontrivial Koru pair (M0/M1 source origins) exists
through all five exact complex BCRD stage boundaries,
including the coherence-generating stage. -/
theorem pinned_complex_BCRD_has_nontrivial_Koru_at_every_stage
    (m : SourceMoment) :
    koru (physicalComplexStageWeb m) 2 3 := by
  exact (complex_source_Koru_iff_distinct_origins m 2 3).mpr (by decide)

#print axioms complex_source_signatures_injective_without_Koru
#print axioms complex_source_Koru_iff_distinct_origins
#print axioms original_Koru_never_loses_source_carrier_distinction
#print axioms no_first_original_Koru_loss_across_complex_M3d
#print axioms actual_controlled_LM_step_changes_complex_coherence
#print axioms original_Koru_is_stable_but_does_not_capture_all_physics
#print axioms pinned_complex_BCRD_has_nontrivial_Koru_at_every_stage

end PhysicalBridges.RouteBFullComplexKoruTest
