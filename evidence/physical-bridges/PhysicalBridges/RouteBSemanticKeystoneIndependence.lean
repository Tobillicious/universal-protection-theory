import PhysicalBridges.RouteBWholeUSixSourceFirstLoss

/-!
# Route B semantic-keystone independence audit

6 November 2026; additive to #354. No original X3 or summit edits.

The W-source first-loss theorem is derived, but its three
original-X3 failure-reflection assumptions are LOGICALLY
EQUIVALENT to the desired all-owed original six-X3 conclusion
under #354's source-fidelity and true-before premises.
The reflections therefore must be physically/semantically
grounded independently, not claimed as a consequence of W.

Six distinct duty field names can all carry the always-true
x0=x0 source formula, without conveying authentic subject
information. #353's nontrivial forward-W/genesis, nontrivial
Koru hostile control fails authorization despite those six
source reports. This is a synthetic semantic independence
test, not a claim about real subjects or cosmology.
-/

namespace PhysicalBridges.RouteBSemanticKeystoneIndependence

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruWActionFixedSymmetry
open PhysicalBridges.KoruCyclicGenesisForwardJoin
open PhysicalBridges.KoruGenesisPhysicalForcingFiretest
open PhysicalBridges.SummitIntrinsicDefinability
open PhysicalBridges.IntrinsicSixSourceForcing
open PhysicalBridges.RouteBOriginalSixFirstViolation
open PhysicalBridges.RouteBWholeUSixSourceFirstLoss
open PhysicalBridges.CathedralFullX3Assembly

universe u
variable {P : Type u}

/-- Exact no-gap criterion: absent independent source/subject
semantics, the three failure-reflection assumptions used in
#354 are just as strong as the original all-owed X3 result. -/
theorem three_failure_reflections_iff_original_six
    (M : Nat) (physical : SourceRelation)
    (owed : Combined → Combined → P → Prop)
    (r : ParticularRelations Combined P)
    (d : SixRelationalDuties)
    (roles : P → Fin 4 → Index)
    (hRef : RespectsCanonicalSource M physical)
    (hBefore : ∀ s t p, physical s t → owed s t p →
      SourceSixAt s.2 d (roles p)) :
    ThreeFirstFailureReflections physical owed r d roles ↔
      (∀ s t p, physical s t → owed s t p →
        OriginalSixAt r s t p) := by
  constructor
  · intro h
    exact route_B_actual_W_and_three_failure_reflections_force_original_six
      M physical owed r d roles hRef hBefore h
  · intro h
    refine ⟨?_, ?_, ?_⟩
    · intro s t p hs ho hBad
      have hSix := h s t p hs ho
      have hGood :=
        ((original_six_iff_three_complete_groups r s t p).mp hSix).1
      exact False.elim (hBad hGood)
    · intro s t p hs ho hBad
      have hSix := h s t p hs ho
      have hGood :=
        ((original_six_iff_three_complete_groups r s t p).mp hSix).2.1
      exact False.elim (hBad hGood)
    · intro s t p hs ho hBad
      have hSix := h s t p hs ho
      have hGood :=
        ((original_six_iff_three_complete_groups r s t p).mp hSix).2.2
      exact False.elim (hBad hGood)

/-- All six explicitly named source fields can be vacuous
self-equalities; this is NOT an authentic X3 interpretation. -/
def alwaysTrueSix : SixRelationalDuties where
  continuity := .equal 0 0
  authorization := .equal 0 0
  freedom := .equal 0 0
  restraint := .equal 0 0
  maximality := .equal 0 0
  provenance := .equal 0 0

theorem always_true_six_reports (U : FiniteObjectiveU)
    (roles : Fin 4 → Index) :
    SourceSixAt U alwaysTrueSix roles :=
  ⟨rfl, rfl, rfl, rfl, rfl, rfl⟩

/-- In the preexisting actual frozen W/genesis hostile model,
those true source formulas cannot reflect an independently
interpreted ORIGINAL-X3 authorization failure. -/
theorem tautological_source_cannot_reflect_original_agency
    (roles : Unit → Fin 4 → Index) :
    ¬ ThreeFirstFailureReflections (combinedStep 0)
      hostileOwed hostileOriginalDuties alwaysTrueSix roles := by
  intro hReflect
  have hBad :
      ¬ AgencyAndFreedom hostileOriginalDuties
        hostileStart hostileNext () :=
    hostile_right_hand_genesis_can_fail_original_authorization.2.2.2.1
  have hNo := hReflect.agency hostileStart hostileNext ()
    hostile_event_is_actual_canonical_genesis trivial hBad
  exact hNo (always_true_six_reports hostileNext.2
    (transportRoles (roles ())))

#print axioms three_failure_reflections_iff_original_six
#print axioms always_true_six_reports
#print axioms tautological_source_cannot_reflect_original_agency

end PhysicalBridges.RouteBSemanticKeystoneIndependence
