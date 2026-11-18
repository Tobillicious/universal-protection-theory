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


/-- A fifth, causally distinguishable event is not in the four-constructor
    domain. This formally prevents promoting four-cause completeness to an
    unrestricted physical claim by silently omitting the new transition. -/
theorem fifth_cause_is_not_a_four_cause_transition :
    ∃ s t : Plant, ExtendedRealStep s t ∧ ¬ RealStep s t := by
  obtain ⟨s, t, hExtended, hNoWitness⟩ :=
    fifth_cause_defeats_four_cause_coverage
  refine ⟨s, t, hExtended, ?_⟩
  intro hFour
  exact hNoWitness (all_four_real_step_classes_are_witnessed s t hFour)

/-- To cover the extended plant, the fifth cause needs its OWN exact joint
    refinement. This extends the coverage result without changing any
    original duty or redefining an unknown event as a known one. -/
theorem five_causes_derive_extended_joint_coverage
    (J : JokerExperiment T FiniteObjectiveU H)
    (read : Plant → Joint T H E n)
    (hFour : FourCauseJointRefinement J read)
    (hUnclassified : ∀ s k,
      jointStep J (read s)
        (read { burden := s.burden + k, lastCause := CauseKind.unclassified })) :
    AllActualEffectsRefineJoint J ExtendedRealStep read := by
  intro s t hReal
  cases hReal with
  | known hKnown =>
      exact (four_causes_derive_complete_joint_coverage J read hFour) _ _ hKnown
  | unknown k =>
      exact hUnclassified _ k


/-- An explicit admission policy for the extended PLANT, not a claim that
    real unclassified physical events cannot happen. Unknown steps remain
    present in ExtendedRealStep but cannot acquire the admitted label. -/
def ClassifiedAdmission (s t : Plant) : Prop :=
  ExtendedRealStep s t ∧ t.lastCause ≠ CauseKind.unclassified

/-- The admission gate has a proof-producing completeness check: every
    admitted extended step is necessarily one of the four known types. -/
theorem classified_admission_has_known_cause
    {s t : Plant} (h : ClassifiedAdmission s t) : RealStep s t := by
  rcases h with ⟨hStep, hTag⟩
  cases hStep with
  | known hKnown => exact hKnown
  | unknown k => exact False.elim (hTag rfl)

/-- An unknown fifth-cause event cannot be admitted, regardless of magnitude. -/
theorem unknown_cause_is_not_admitted (s : Plant) (k : Nat) :
    ¬ ClassifiedAdmission s
        { burden := s.burden + k, lastCause := CauseKind.unclassified } := by
  intro h
  exact h.2 rfl

/-- Admission implies reviewed joint-step refinement, using only the four
    already named source obligations. This holds for the ADMITTED SUBSYSTEM,
    not the entire independent ExtendedRealStep physical relation. -/
theorem classified_admission_derives_joint_coverage
    (J : JokerExperiment T FiniteObjectiveU H)
    (read : Plant → Joint T H E n)
    (hFour : FourCauseJointRefinement J read) :
    AllActualEffectsRefineJoint J ClassifiedAdmission read := by
  intro s t h
  exact (four_causes_derive_complete_joint_coverage J read hFour) s t
    (classified_admission_has_known_cause h)

#print axioms classified_admission_has_known_cause
#print axioms unknown_cause_is_not_admitted
#print axioms classified_admission_derives_joint_coverage

#print axioms fifth_cause_is_not_a_four_cause_transition
#print axioms five_causes_derive_extended_joint_coverage

#print axioms four_causes_derive_complete_joint_coverage
#print axioms four_cause_plant_has_an_actual_modeled_step
#print axioms four_cause_nonvacuous_guardian_with_original_six

end PhysicalBridges.FourCausePhysicalGuardianBridge
