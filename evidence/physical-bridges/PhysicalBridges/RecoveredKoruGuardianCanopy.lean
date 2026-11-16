import PhysicalBridges.KoruWholeUSixDutyWebJoin
import PhysicalBridges.FullPhysicalDomainGuardianAssembly
import PhysicalBridges.EthicsCanopyExtended

/-!
# Recovered Koru G: whole-source carriage to all owed actual duties

Source-preserving assembly. This explicitly separates exact W source carriage
from independently justified real-event coverage, subject reflection, and
ethical fulfillment. No original X3 definition, Koru, or physical law is changed.
No theorem assumes that source links constitute authentic consent.
-/
namespace PhysicalBridges.RecoveredKoruGuardianCanopy

open PhysicalBridges.KoruWholeUSixDutyWebJoin
open PhysicalBridges.FullPhysicalDomainGuardianAssembly
open PhysicalBridges.EthicsCanopySameEvent
open PhysicalBridges.OriginalX3Full
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.PhysicalSemanticLastMileGates
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.TotalEOriginalX3Bridge

/-- A complete six-field SOURCE profile is carried through every W
stage from the SAME initial objective whole, for every owed position. -/
theorem recovered_whole_source_all_owed
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (owed : Index → Prop) (hInitial : AllOwedWholeSourceSix U roles owed 0) :
    ∀ n, AllOwedWholeSourceSix U roles owed n := by
  intro n
  exact (all_owed_whole_U_six_source_truth_iff_origin U roles owed n).mpr hInitial

/-- Positive real-domain G theorem and all-ethics canopy on the SAME
physical event. Authentic subject correspondence and applicable ethics
are separately supplied; neither is inferred from an operator link. -/
theorem recovered_physical_guardian_with_ethics
    {S P E : Type}
    (physicalStep modeledStep : S → S → Prop)
    (source : S → FiniteObjectiveU) (stage : S → Nat)
    (carrier : P → Index) (r : ParticularRelations S P)
    (owed : P → Prop)
    (valid : E → Prop)
    (applies fulfills : S → S → P → E → Prop)
    (hCoverage : CompleteWEventCoverage physicalStep modeledStep
      source stage positiveWholeU)
    (hReflection : ForwardRealEventReflection
      modeledStep stage positiveWholeU sixDiagonalRoles carrier r owed)
    (hEthics : ∀ s t p, physicalStep s t → owed p →
      AllApplicableEthics valid applies fulfills s t p) :
    ∀ s t, physicalStep s t →
      (∀ p, owed p →
        OriginalX3 r.continues r.authorized r.free
          r.restrained r.maximal r.provenanced s t p ∧
        AllApplicableEthics valid applies fulfills s t p) ∧
      ¬ AbsoluteE
        (fun e : S × S => physicalStep e.1 e.2) (s, t) := by
  intro s t hStep
  have hFull :=
    every_physical_event_has_complete_koru_full_six_G_and_no_absolute_E
      physicalStep modeledStep source stage carrier r owed
      hCoverage hReflection s t hStep
  refine ⟨?_, hFull.2.2.2⟩
  intro p hp
  exact ⟨hFull.2.2.1 p hp, hEthics s t p hStep hp⟩

#print axioms recovered_whole_source_all_owed
#print axioms recovered_physical_guardian_with_ethics

end PhysicalBridges.RecoveredKoruGuardianCanopy
