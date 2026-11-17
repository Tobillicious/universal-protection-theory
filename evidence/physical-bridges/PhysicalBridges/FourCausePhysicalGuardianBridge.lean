import PhysicalBridges.G3SameEventCapstone
import PhysicalBridges.IR124ClosedWorldCoverageCountermodel

/-!
# Physical cause-by-cause discharge of the G3 external-event coverage premise

Additive, source-preserving research bridge. The independently specified IR124
four-cause physical plant includes actuator, environmental, latent AND bypass
steps. Rather than ASSUMING universal event refinement, we derive it by cases
from four per-primitive proof obligations. In particular a bypass is not
silently dropped from the domain.

This is a constructive finite-alphabet *plant* theorem. It does NOT assert
that the actual cosmos has exactly four physical cause classes, nor that the
per-class refinement evidence or authentic six subject meanings are verified
in nature. IR124's fifth-cause countermodel is retained unchanged.
-/

namespace PhysicalBridges.FourCausePhysicalGuardianBridge

open PhysicalBridges.IR124
open PhysicalBridges.G3SameEventCapstone
open PhysicalBridges.ExternalJointEffectRefinement
open PhysicalBridges.KoruJokerUniverseTrialFeedback
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.LivingTreeGenerations
open PhysicalBridges.LivingTreeFencedEffects
open PhysicalBridges.FencedOptimiserInstrument
open PhysicalBridges.OriginalX3Full
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.TotalEOriginalX3Bridge

variable {T H E P : Type} {n : Nat}

/-- Four concrete, independently checkable generators rather than a single
    quantified 'all real effects are safe' premise. The bypass constructor
    is INCLUDED and must independently satisfy the joint transition law. -/
structure FourCauseJointRefinement
    (J : JokerExperiment T FiniteObjectiveU H)
    (read : Plant → Joint T H E n) : Prop where
  actuator : ∀ s k, jointStep J (read s) (read (apply s (.actuator k)))
  environmental : ∀ s k, jointStep J (read s) (read (apply s (.environmental k)))
  latent : ∀ s k, jointStep J (read s) (read (apply s (.latent k)))
  bypass : ∀ s k, jointStep J (read s) (read (apply s (.bypass k)))

/-- Discharge the abstract G3 coverage gate BY PHYSICAL CAUSE ELIMINATION
    in the specified IR124 plant, with NO supplied hCoverage. -/
theorem four_causes_derive_complete_joint_coverage
    (J : JokerExperiment T FiniteObjectiveU H)
    (read : Plant → Joint T H E n)
    (hFour : FourCauseJointRefinement J read) :
    AllActualEffectsRefineJoint J RealStep read := by
  intro s t h
  cases h with
  | actuator k => exact hFour.actuator _ k
  | environmental k => exact hFour.environmental _ k
  | latent k => exact hFour.latent _ k
  | bypass k => exact hFour.bypass _ k

/-- Nonvacuity follows from the *independent* IR124 actuator constructor.
    This theorem does not assume a protected event exists. -/
theorem four_cause_plant_has_an_actual_modeled_step :
    ∃ s t : Plant, RealStep s t := by
  let s : Plant := { burden := 0, lastCause := .actuator }
  exact ⟨s, apply s (.actuator 0), RealStep.actuator s 0⟩

/-- Reuse the existing original-six and nonempty G3 capstone.
    Universal hCoverage and hWitness are now DERIVED inside the explicitly
    specified four-cause plant. Six authentic semantic implications remain
    independent premises and are not replaced by record or consent flags. -/
theorem four_cause_nonvacuous_guardian_with_original_six
    (J : JokerExperiment T FiniteObjectiveU H)
    (read : Plant → Joint T H E n)
    (carrier : P → Fin n)
    (owed : P → Prop)
    (actual : ParticularRelations Plant P)
    (hFour : FourCauseJointRefinement J read)
    (hMeaning : AuthenticSixReflections RealStep read carrier owed actual) :
    (∃ s t : Nat,
      PhysicalBridges.ConstructivePositiveWGuardian.canonicalPositiveWStep s t) ∧
    (∃ s t : Plant, RealStep s t ∧
      (∀ p, owed p →
        OriginalX3 actual.continues actual.authorized actual.free
          actual.restrained actual.maximal actual.provenanced s t p) ∧
      residualHarm (read s).2 (read t).2 = 0) ∧
    (∀ e : Plant × Plant,
      ¬ ActualX3Violation
        (fun e : Plant × Plant => RealStep e.1 e.2)
        (fun (_ : Plant × Plant) p => owed p)
        (fun (e : Plant × Plant) p =>
          OriginalX3 actual.continues actual.authorized actual.free
            actual.restrained actual.maximal actual.provenanced e.1 e.2 p)
        e) := by
  exact g3_nonvacuous_source_and_witnessed_external_protection
    J RealStep read carrier owed actual
    four_cause_plant_has_an_actual_modeled_step
    (four_causes_derive_complete_joint_coverage J read hFour)
    hMeaning

#print axioms four_causes_derive_complete_joint_coverage
#print axioms four_cause_plant_has_an_actual_modeled_step
#print axioms four_cause_nonvacuous_guardian_with_original_six

end PhysicalBridges.FourCausePhysicalGuardianBridge
