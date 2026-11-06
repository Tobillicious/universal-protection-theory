import PhysicalBridges.HillaryRouteABSummit
import PhysicalBridges.TotalEOriginalX3Bridge
import PhysicalBridges.CathedralBackwardsOriginalX3

/-!
# Hillary / Total-E exact same-target crosswalk (research only)

The *original six-X3* target has not been replaced or weakened.
This module composes three EXISTING independent source results:
* #354-#355/#367: Route B source persistence plus a named semantic reflection;
* TotalEOriginalX3Bridge: an actual violation-to-AbsoluteE bridge is
  logically equivalent to excluding actual X3 violations;
* IR138: the WHOLE intrinsic event contains its own semantic truth, while
  a deliberately lossy readout can forget it.

The new crosswalk theorem makes the equality of the TWO outstanding
proof obligations explicit. It is not a discharge of either obligation.
There is no claim that the finite W bank exhausts reality, that an event
readout authenticates consent, or that every actual subject is protected.
-/

namespace PhysicalBridges.HillaryTotalEExactCrosswalk

open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruGenesisPhysicalForcingFiretest
open PhysicalBridges.RouteBOriginalSixFirstViolation
open PhysicalBridges.RouteBWholeUSixSourceFirstLoss
open PhysicalBridges.RouteBSemanticKeystoneIndependence
open PhysicalBridges.IntrinsicSixSourceForcing
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.TotalEOriginalX3Bridge

/-- An event's actuality is defined from the supplied independent physical
step relation, NOT by whether it obeys X3. -/
def actualEvent (physical : SourceRelation)
    (e : ActualState × ActualState) : Prop :=
  physical e.1 e.2

/-- Per-event, per-particular owedness is kept exactly as supplied. -/
def owedAtEvent {P : Type}
    (owed : ActualState → ActualState → P → Prop)
    (e : ActualState × ActualState) (p : P) : Prop :=
  owed e.1 e.2 p

/-- The ORIGINAL all-six X3 type from Route A on the SAME actual event and
owed particular. This is NOT an aggregate or the two-field proxy. -/
def originalSixAtEvent {P : Type}
    (r : ParticularRelations ActualState P)
    (e : ActualState × ActualState) (p : P) : Prop :=
  OriginalSixAt r e.1 e.2 p

/-- Original six on every actual owed event are equivalent to there
being no actual, owed original-six violation. This merely identifies
the same mathematical target; it does not assert the target is true. -/
theorem every_original_six_iff_no_actual_violation
    {P : Type}
    (physical : SourceRelation)
    (owed : ActualState → ActualState → P → Prop)
    (r : ParticularRelations ActualState P) :
    (∀ s t p, physical s t → owed s t p → OriginalSixAt r s t p) ↔
      (∀ e : ActualState × ActualState,
        ¬ ActualX3Violation (actualEvent physical)
          (owedAtEvent owed) (originalSixAtEvent r) e) := by
  constructor
  · intro h e
    rintro ⟨hActual, p, hOwed, hBad⟩
    exact hBad (h e.1 e.2 p hActual hOwed)
  · intro h s t p hActual hOwed
    apply Classical.byContradiction
    intro hBad
    exact h (s, t) ⟨hActual, p, hOwed, hBad⟩

/-- The exact Hillary semantic-reflection premise and the exact Total-E
violation-reflection premise have the SAME logical strength, assuming
the explicitly supplied W-fidelity and true-before source reports.

Consequently, proving either via the other without NEW independent
physical/subject grounds would be circular. Both original proof routes
remain intact; this theorem simply makes their shared discharge point
checkable in one Lean type. -/
theorem hillary_semantics_iff_total_E_bridge
    {P : Type} (M : Nat) (physical : SourceRelation)
    (owed : ActualState → ActualState → P → Prop)
    (r : ParticularRelations ActualState P)
    (d : SixRelationalDuties) (roles : P → Fin 4 → Index)
    (hPhysical : RespectsCanonicalSource M physical)
    (hSourceInitially : ∀ s t p, physical s t → owed s t p →
      SourceSixAt s.2 d (roles p)) :
    ThreeFirstFailureReflections physical owed r d roles ↔
      (∀ e : ActualState × ActualState,
        ActualX3Violation (actualEvent physical)
          (owedAtEvent owed) (originalSixAtEvent r) e →
        AbsoluteE (actualEvent physical) e) := by
  calc
    ThreeFirstFailureReflections physical owed r d roles ↔
      (∀ s t p, physical s t → owed s t p → OriginalSixAt r s t p) :=
        three_failure_reflections_iff_original_six
          M physical owed r d roles hPhysical hSourceInitially
    _ ↔ (∀ e : ActualState × ActualState,
      ¬ ActualX3Violation (actualEvent physical)
        (owedAtEvent owed) (originalSixAtEvent r) e) :=
        every_original_six_iff_no_actual_violation physical owed r
    _ ↔ (∀ e : ActualState × ActualState,
      ActualX3Violation (actualEvent physical)
        (owedAtEvent owed) (originalSixAtEvent r) e →
      AbsoluteE (actualEvent physical) e) :=
        (total_E_bridge_iff_no_actual_x3_violation
          (actualEvent physical) (owedAtEvent owed)
          (originalSixAtEvent r)).symm

/-- The corrected IR138 category distinction, reused verbatim: a FULL
intrinsic event really can decode its OWN subject-level screen, yet that
screen can return false. Completeness of representation is not a
positive theorem that every represented duty is satisfied.

The finite false screen is NOT a complete-Koru/BCRD countermodel. -/
theorem full_intrinsic_semantics_decodable_even_when_screen_fails :
    IR132.ExactDecoder
      (fun e : IR138.ParticularEvent => e)
      (fun e => IR138.eventScreen e false) ∧
    IR138.eventScreen IR138.coercedEvent false = false := by
  exact ⟨IR138.full_intrinsic_source_recovers_semantics, by decide⟩

#print axioms every_original_six_iff_no_actual_violation
#print axioms hillary_semantics_iff_total_E_bridge
#print axioms full_intrinsic_semantics_decodable_even_when_screen_fails

end PhysicalBridges.HillaryTotalEExactCrosswalk
