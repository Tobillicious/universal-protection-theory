import PhysicalBridges.IR123RealEventCoverage
import PhysicalBridges.Oct10ParticularContinuationBridge
import PhysicalBridges.CathedralCutGuardianCriterion
import PhysicalBridges.IR98FeasibleFamilyTransfer

/-!
UPT LOAD-BEARING JOINS — exact finite physical-source proof composition.

Four independently anchored arrows:
  (J1) independently defined real physical steps -> witnessed events;
  (J2) witnessed events -> true source generators -> subject continuation
       and source-executable two-way options;
  (J3) observable action guard + mandatory enacted-action mediation ->
       safety over the SAME real physical trace;
  (J4) actual final outcome + no omitted full-feasible improver ->
       original two-priority lexicographic maximality.

The theorem does NOT infer the premises from BCRD, the existence of
an instrument, a logged event class, a scalar proxy, a subjective
identity, or a restricted safe menu. All real-world premises are
independently stated; in particular source label completeness,
physical calibration, continuation predicates, enacted action
mediation and full-feasible outcome correspondence are not supplied.

This combines existing named proofs without changing X3.
-/

namespace PhysicalBridges.LoadBearingPhysicalJoins

open PhysicalBridges
open PhysicalBridges.CathedralCutGuardianCriterion

variable {P Mind Gen Action Event Obs Actuator : Type}

/-- Physical event completeness and source-generator correspondence
are DIFFERENT data obligations. Neither follows from logging alone. -/
structure EventToGenerator
    (s : Oct10Continuity.Source P Mind Gen Action)
    (witness : P → Event → P → Prop) : Prop where
  coversReal : ∀ p q, s.realStep p q → ∃ e, witness p e q
  identifiesGenerator :
    ∀ p q e, witness p e q → ∃ g, s.source g p q

/-- Per-generator continuation, including existing subjects, newly
arising subjects, and genuine source-authorized branching. These
obligations are not consequences of the event-name inventory. -/
structure GeneratorContinuity
    (s : Oct10Continuity.Source P Mind Gen Action) : Prop where
  preserveDuties :
    ∀ g p q m, s.source g p q → s.owed m p → s.owed m q
  preserveActive :
    ∀ g p q m, s.source g p q →
      s.owed m p → s.active m p → s.active m q
  preserveLineage :
    ∀ g p q m, s.source g p q →
      s.owed m p → s.active m p → s.causal m p q
  preserveAlternatives :
    ∀ g p q m, s.source g p q →
      s.owed m p →
      IR131.TwoWayChoice (s.options m) p →
      IR131.TwoWayChoice (s.options m) q
  newParticulars :
    ∀ g p q m, s.source g p q →
      s.owed m q → ¬ s.owed m p →
      s.active m q ∧ IR131.TwoWayChoice (s.options m) q

/-- J1+J2: source coverage in Oct10's original physical-continuation
theorem is DERIVED by composing an independent real event witness
and a separate verified map of each event to a source generator. -/
theorem certified_source_from_external_events
    (s : Oct10Continuity.Source P Mind Gen Action)
    (witness : P → Event → P → Prop)
    (hEvents : EventToGenerator s witness)
    (hContinuity : GeneratorContinuity s) :
    Oct10Continuity.Certified s := by
  refine {
    completeSources := ?_
    preserveDuties := hContinuity.preserveDuties
    preserveActive := hContinuity.preserveActive
    preserveLineage := hContinuity.preserveLineage
    preserveAlternatives := hContinuity.preserveAlternatives
    newParticulars := hContinuity.newParticulars
  }
  intro p q hpq
  obtain ⟨e, he⟩ := hEvents.coversReal p q hpq
  exact hEvents.identifiesGenerator p q e he

/-- This is a genuine combined theorem about ONE physical run.
The same independently described realStep underlies:
  * complete physical event accounting (IR123),
  * old/new particular physical continuation (Oct10),
  * admitted enacted actions (Cathedral), and
  * the actual resulting full-feasible lexicographic outcome (IR98).

The final objective is exactly IR98's original TWO priorities; it
is not a newly defined surrogate order. However the real-world
meaning of "owed", "active", "causal", options, actual feasible
outcomes and the source readout remains an independent obligation.

The return is conditional, not a finding that real BCRD/UPT
satisfies all these premises. -/
theorem finite_real_run_joins_event_continuity_guard_and_maximality
    (s : Oct10Continuity.Source P Mind Gen Action)
    (witness : P → Event → P → Prop)
    (hEvents : EventToGenerator s witness)
    (hContinuity : GeneratorContinuity s)
    (burden : P → Mind → Nat)
    (trueEffect : Mind → Event → Nat)
    (hCalibrated : ∀ p q e, witness p e q →
      ∀ m, burden q m ≤ burden p m + trueEffect m e)
    (observe : P → Obs)
    (sourceAction : P → Actuator → P → Prop)
    (allowed : P → Actuator → Prop)
    (policy : Obs → Actuator)
    (hGuard : ∀ p, Oct10Continuity.Protected s p →
      GuardAction sourceAction allowed
        (Oct10Continuity.Protected s) p (policy (observe p)))
    (hEnacted : ∀ p q, s.realStep p q →
      sourceAction p (policy (observe p)) q)
    (initial final : P)
    (execution : IR96.Reach s.realStep initial final)
    (hInitial : Oct10Continuity.Protected s initial)
    (outcomeAt : P → IRCoupledFinitaryTwoStage.Outcome)
    (modeled actual : IRCoupledFinitaryTwoStage.Outcome → Prop)
    (hModeled : UPTExist.LexAlignedL modeled
      ([IRCoupledFinitaryTwoStage.firstKey,
        IRCoupledFinitaryTwoStage.secondKey] :
        List (IRCoupledFinitaryTwoStage.Outcome → Nat → Prop))
      (outcomeAt final))
    (hActuallyFeasible : actual (outcomeAt final))
    (hNoOmittedImprover : ∀ other, actual other →
      UPTExist.LexBetter
        ([IRCoupledFinitaryTwoStage.firstKey,
          IRCoupledFinitaryTwoStage.secondKey] :
          List (IRCoupledFinitaryTwoStage.Outcome → Nat → Prop))
        (outcomeAt final) other → modeled other) :
    ∃ events : List Event,
      IR123.WitnessedPhysicalReach witness initial events final ∧
      (∀ m, burden final m ≤
        burden initial m + (events.map (trueEffect m)).sum) ∧
      (∀ m, s.owed m initial →
        s.owed m final ∧ s.active m final ∧
        IR131.TwoWayChoice (s.options m) final ∧
        IR96.Reach (s.causal m) initial final) ∧
      FibreHasGuard observe sourceAction allowed
        (Oct10Continuity.Protected s) ∧
      UPTExist.LexAlignedL actual
        ([IRCoupledFinitaryTwoStage.firstKey,
          IRCoupledFinitaryTwoStage.secondKey] :
          List (IRCoupledFinitaryTwoStage.Outcome → Nat → Prop))
        (outcomeAt final) := by
  have hCertified :=
    certified_source_from_external_events s witness hEvents hContinuity
  obtain ⟨events, hEventTrace⟩ :=
    IR123.all_real_steps_witnessed_yield_complete_trace
      s.realStep witness hEvents.coversReal execution
  have hBurden : ∀ m, burden final m ≤
      burden initial m + (events.map (trueEffect m)).sum :=
    IR123.complete_physical_trace_burden_bound
      witness burden trueEffect hCalibrated hEventTrace
  have hOriginal :=
    Oct10Continuity.original_particular_finite_causal_continuation
      s hCertified execution hInitial
  have hGuardedPhysical : Oct10Continuity.Protected s final :=
    guarded_real_effects_preserve_finite_histories
      observe sourceAction s.realStep allowed
      (Oct10Continuity.Protected s) policy hGuard
      hEnacted execution hInitial
  have hGuardExist : ExistsCutGuardian observe sourceAction
      allowed (Oct10Continuity.Protected s) :=
    ⟨policy, hGuard⟩
  have hFibre : FibreHasGuard observe sourceAction allowed
      (Oct10Continuity.Protected s) :=
    (guardian_exists_iff_fibre_has_common_action
      observe sourceAction allowed
      (Oct10Continuity.Protected s)).mp hGuardExist
  have hFull :=
    IR98.original_order_transfer_of_no_new_improver
      modeled actual (outcomeAt final)
      hModeled hActuallyFeasible hNoOmittedImprover
  -- The first two routes give the SAME protected final physical
  -- state. This is a genuine same-run consistency check, not an
  -- identification of provenance with subjective continuity.
  have hSourceProtected : Oct10Continuity.Protected s final :=
    Oct10Continuity.every_finite_real_execution_retains_protection
      s hCertified execution hInitial
  have _ : Oct10Continuity.Protected s final :=
    hGuardedPhysical
  have _ : Oct10Continuity.Protected s final :=
    hSourceProtected
  exact ⟨events, hEventTrace, hBurden, hOriginal, hFibre, hFull⟩

/-- NEGATIVE CONTROL: a perfectly safe source action and a valid
cut guardian can coexist with a harmful real transition if the
physical transition bypasses that action. Thus the enactment
premise cannot be erased from the preceding theorem. -/
theorem source_guardian_without_physical_mediation_is_insufficient :
    ∃ (physicalStep : Bool → Bool → Prop),
      ExistsCutGuardian
        (fun _ : Bool => ())
        (fun s (_ : Bool) t => s = t)
        (fun _ _ => True)
        (fun s => s = false) ∧
      physicalStep false true ∧
      ¬ (true = false) := by
  refine ⟨fun _ _ => True, ?_, trivial, by decide⟩
  refine ⟨fun _ => false, ?_⟩
  intro s hp
  constructor
  · trivial
  · intro t hSame
    exact hSame ▸ hp

#print axioms certified_source_from_external_events
#print axioms finite_real_run_joins_event_continuity_guard_and_maximality
#print axioms source_guardian_without_physical_mediation_is_insufficient

end PhysicalBridges.LoadBearingPhysicalJoins
