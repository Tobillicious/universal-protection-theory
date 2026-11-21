import PhysicalBridges.G3SixWitnessPhysicalFidelity

/-!
# Independently grounded owing and subject-rights evidence

Find-before-build. This module reuses:
* G3SixWitnessPhysicalFidelity.scoped_protection_with_a_nonempty_owed_subject
* G3SixWitnessPhysicalFidelity.SixWitnessChecks
* HumeHillaryReciprocalHand's hostile consent counterexample
* FourCausePhysicalGuardianBridge's exact bounded four-cause effect scope.

It does NOT define owed merely as "a member of P", or actual
authorization as the modeled authorization predicate. It exposes
the independent ethical and validation obligations rather than
claiming that logic, signatures or source reciprocity discharged them.

The existing external research lanes for authority signatures, rights
triage, and withdrawal vetoes are intentionally NOT connected to a
live actuator here.
-/

namespace PhysicalBridges.G3GroundedOwedRightsBridge

open PhysicalBridges.G3SixWitnessPhysicalFidelity
open PhysicalBridges.G3BoundedGuardianDischarge
open PhysicalBridges.FourCausePhysicalGuardianBridge
open PhysicalBridges.ExternalJointEffectRefinement
open PhysicalBridges.G3SameEventCapstone
open PhysicalBridges.IR124
open PhysicalBridges.LivingTreeFencedEffects
open PhysicalBridges.LivingTreeGenerations
open PhysicalBridges.KoruJokerUniverseTrialFeedback
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.FencedOptimiserInstrument
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full
open PhysicalBridges.TotalEOriginalX3Bridge

variable {T H E P : Type} {n : Nat}

/-- The INDEPENDENT moral bridge: presence and protectable interests
must be related to owing via a separately defended normative warrant.

`warrant` is not defined in terms of the model, its six predicates,
or the desired result. `recognition_grounds_owing` is the Hume
step needing explicit ethical justification, human review and
counterexample analysis, not a theorem of bare existence. -/
structure EthicalGrounding (P : Type) where
  present : P → Prop
  interests : P → Prop
  warrant : P → Prop
  owed : P → Prop
  recognition_grounds_owing :
    ∀ p, present p → interests p → warrant p → owed p

/-- A particular independently witnessed as present, having protectable
interests, and owed protection by a defended normative warrant cannot
be silently omitted from the domain of owed particulars. -/
theorem grounded_particular_is_owed
    (g : EthicalGrounding P) (p : P)
    (hPresent : g.present p)
    (hInterest : g.interests p)
    (hWarrant : g.warrant p) :
    g.owed p :=
  g.recognition_grounds_owing p hPresent hInterest hWarrant

/-- In a four-cause plant with six independently justified evidence
checks, an independently recognized owed subject gets the actual
unchanged OriginalX3 duties on a genuinely witnessed model step.

The moral warrant and six real-world evidence checks are EXPLICIT
premises; the theorem does not manufacture them. -/
theorem grounded_nonvacuous_six_witness_guardian
    (J : JokerExperiment T FiniteObjectiveU H)
    (read : Plant → Joint T H E n)
    (carrier : P → Fin n)
    (g : EthicalGrounding P)
    (actual : ParticularRelations Plant P)
    (e : SixEvidence P)
    (hFour : FourCauseJointRefinement J read)
    (hChecks : SixWitnessChecks read carrier g.owed actual e)
    (p : P)
    (hPresent : g.present p)
    (hInterest : g.interests p)
    (hWarrant : g.warrant p) :
    ∃ s t : Plant, RealStep s t ∧
      g.owed p ∧
      OriginalX3 actual.continues actual.authorized actual.free
        actual.restrained actual.maximal actual.provenanced s t p := by
  have hp := grounded_particular_is_owed g p hPresent hInterest hWarrant
  obtain ⟨s, t, hs, q, hq, hSix⟩ :=
    scoped_protection_with_a_nonempty_owed_subject
      J read carrier g.owed actual e hFour hChecks ⟨p, hp⟩
  have hAll := (four_causes_and_six_witnesses_protect_scoped_events
    J read carrier g.owed actual e hFour hChecks).2.1
  obtain ⟨s', t', hStep', hDuties, _⟩ := hAll
  exact ⟨s', t', hStep', hp, hDuties p hp⟩

/-- A subject-specific authorization evidence packet needs independently
validated rights facts in addition to any token/signature. None of the
fields is defined as authentic authorization. -/
structure RightsEvidence (P : Type) where
  issuerTrusted : Plant → Plant → P → Prop
  subjectIdentified : Plant → Plant → P → Prop
  scopeAndPurposeMatch : Plant → Plant → P → Prop
  voluntary : Plant → Plant → P → Prop
  withdrawn : Plant → Plant → P → Prop

/-- All necessary *record-level* checks for a candidate event. This
predicate is deliberately NOT called consent or authorized; a positive
record check has not established the moral legitimacy of the action. -/
def RecordEligible (rights : RightsEvidence P) (s t : Plant) (p : P) : Prop :=
  rights.issuerTrusted s t p ∧
  rights.subjectIdentified s t p ∧
  rights.scopeAndPurposeMatch s t p ∧
  rights.voluntary s t p ∧
  ¬ rights.withdrawn s t p

/-- Withdrawal is a genuine veto at the record eligibility boundary,
regardless of other valid fields. -/
theorem withdrawal_blocks_record_eligibility
    (rights : RightsEvidence P) (s t : Plant) (p : P)
    (hWithdrawn : rights.withdrawn s t p) :
    ¬ RecordEligible rights s t p := by
  intro h
  exact h.2.2.2.2 hWithdrawn

/-- Positive authorization evidence must be mapped to independently
validated record facts. An external subject-rights authority must then
establish that the specific eligible record really supports *authentic*
authorization. The second argument is the unresolved empirical-ethical
soundness condition; it is NOT extracted from a signature or source W. -/
theorem externally_validated_rights_support_authentic_authorization
    (actual : ParticularRelations Plant P)
    (e : SixEvidence P)
    (rights : RightsEvidence P)
    (hEvidenceToRecord :
      ∀ s t p, RealStep s t →
        e.authority s t p → RecordEligible rights s t p)
    (hIndependentRightsSound :
      ∀ s t p, RealStep s t →
        RecordEligible rights s t p → actual.authorized s t p) :
    ∀ s t p, RealStep s t →
      e.authority s t p → actual.authorized s t p := by
  intro s t p hs he
  exact hIndependentRightsSound s t p hs
    (hEvidenceToRecord s t p hs he)

/-- HOSTILE CONTROL. Bare existence does not logically require that
every possible independent owed predicate is true. Hence an ethical
premise is needed even when a particular exists. -/
theorem bare_existence_cannot_force_every_owed_interpretation :
    ¬ (∀ owed : Unit → Prop, owed ()) := by
  intro h
  exact h (fun _ => False)

/-- HOSTILE CONTROL. A signed-looking or merely asserted receipt is
not enough if independent withdrawal is recorded. -/
theorem positive_token_cannot_override_withdrawal :
    ¬ ((True ∧ True ∧ True ∧ True ∧ ¬ True)) := by
  intro h
  exact h.2.2.2.2 True.intro

#print axioms grounded_particular_is_owed
#print axioms grounded_nonvacuous_six_witness_guardian
#print axioms withdrawal_blocks_record_eligibility
#print axioms externally_validated_rights_support_authentic_authorization
#print axioms bare_existence_cannot_force_every_owed_interpretation
#print axioms positive_token_cannot_override_withdrawal

end PhysicalBridges.G3GroundedOwedRightsBridge
