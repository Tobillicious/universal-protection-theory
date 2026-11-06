import PhysicalBridges.RouteBSemanticKeystoneIndependence

/-!
# HILLARY: one visible Route B × Route A summit theorem

This module is a **proof navigation and composition certificate** for the
existing, kernel-checked original-six-X3 Route B and Route A summit.

The full theorem is NOT replaced by a weaker proxy: for every actual physical
step and every owed particular, it produces all six original fields.

Precise separation:
* SOURCE: independently derived W transport excludes first loss of six source
  reports for every intrinsic six-formula specification (source fidelity only).
* ORIGINAL DUTIES: the three named groups are equivalent to all six X3 fields.
* HILLARY JOIN: source fidelity, true source reports before the step, and three
  explicit authentic subject-level failure reflections entail original X3.
* SEMANTIC AUDIT: those three reflection premises are themselves equivalent to
  original-six protection under source fidelity and pre-event truth; therefore
  their authentic physical derivation is a substantive independent obligation.

Read HILLARY-ROUTE-A-B-SUMMIT.md and the original PRs #353–#355.
Nothing here declares that all physical actuality instantiates these premises.
-/

namespace PhysicalBridges.HillaryRouteABSummit

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruGenesisPhysicalForcingFiretest
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.IntrinsicSixSourceForcing
open PhysicalBridges.RouteBOriginalSixFirstViolation
open PhysicalBridges.RouteBWholeUSixSourceFirstLoss
open PhysicalBridges.RouteBSemanticKeystoneIndependence

/-- The genuinely independent, proven Route B source half.
It holds for EVERY choice of six intrinsic source formulas, without assuming
original X3, subject consent, or an allowed-action safety filter. -/
theorem hillary_route_b_source_half
    (M : Nat) (physical : SourceRelation)
    (hPhysical : RespectsCanonicalSource M physical) :
    ∀ d : SixRelationalDuties, ¬ FirstSixSourceLoss physical d := by
  intro d
  exact no_first_six_source_loss_from_physical_W M physical hPhysical d

/-- Route A cannot be weakened: precisely three pairs, the ORIGINAL six
duties, on the SAME source transition and for the SAME particular. -/
theorem hillary_route_a_is_exactly_original_six
    {P : Type} (r : ParticularRelations Combined P)
    (s t : Combined) (p : P) :
    OriginalSixAt r s t p ↔
      IdentityAndProvenance r s t p ∧
      AgencyAndFreedom r s t p ∧
      RestraintAndMaximality r s t p :=
  original_six_iff_three_complete_groups r s t p

/-- The Hillary join, all three positive outcomes in ONE theorem:
(1) all six original X3 for EVERY actual step and owed particular,
(2) no first original-six-X3 failure, and
(3) no first intrinsic six-source-report failure.

The *only* substantive joins not derived here are explicitly typed:
 hPhysical: physical events obey the independently specified source W;
 hSourceInitially: chosen source reports held before each owed event;
 hAuthenticReflections: three original-subject failures would be reflected
                       as failures of their faithful source reports.
No original X3 obligation is silently inserted into physical-step admission. -/
theorem hillary_route_b_meets_original_route_a
    {P : Type} (M : Nat) (physical : SourceRelation)
    (owed : Combined → Combined → P → Prop)
    (r : ParticularRelations Combined P)
    (d : SixRelationalDuties) (roles : P → Fin 4 → Index)
    (hPhysical : RespectsCanonicalSource M physical)
    (hSourceInitially : ∀ s t p, physical s t → owed s t p →
      SourceSixAt s.2 d (roles p))
    (hAuthenticReflections :
      ThreeFirstFailureReflections physical owed r d roles) :
    (∀ s t p, physical s t → owed s t p → OriginalSixAt r s t p) ∧
    ¬ FirstOriginalViolation physical owed r ∧
    ¬ FirstSixSourceLoss physical d := by
  have hAll :=
    route_B_actual_W_and_three_failure_reflections_force_original_six
      M physical owed r d roles hPhysical hSourceInitially
      hAuthenticReflections
  refine ⟨hAll, ?_, ?_⟩
  · exact (no_first_original_violation_iff_every_owed_six
      physical owed r).mpr hAll
  · exact no_first_six_source_loss_from_physical_W
      M physical hPhysical d

/-- Exact anti-circularity gate, also kernel checked. A purported universal
proof must obtain the authentic semantic reflections from independent
physical/subject structure, not promote this iff into a free premise. -/
theorem hillary_semantic_keystone_exact_strength
    {P : Type} (M : Nat) (physical : SourceRelation)
    (owed : Combined → Combined → P → Prop)
    (r : ParticularRelations Combined P)
    (d : SixRelationalDuties) (roles : P → Fin 4 → Index)
    (hPhysical : RespectsCanonicalSource M physical)
    (hSourceInitially : ∀ s t p, physical s t → owed s t p →
      SourceSixAt s.2 d (roles p)) :
    ThreeFirstFailureReflections physical owed r d roles ↔
      (∀ s t p, physical s t → owed s t p → OriginalSixAt r s t p) :=
  three_failure_reflections_iff_original_six
    M physical owed r d roles hPhysical hSourceInitially

#print axioms hillary_route_b_source_half
#print axioms hillary_route_a_is_exactly_original_six
#print axioms hillary_route_b_meets_original_route_a
#print axioms hillary_semantic_keystone_exact_strength

end PhysicalBridges.HillaryRouteABSummit
