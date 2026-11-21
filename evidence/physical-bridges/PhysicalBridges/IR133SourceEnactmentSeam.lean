import PhysicalBridges.IR125FourChannelSeparation
import PhysicalBridges.LoadBearingPhysicalJoins

/-!
IR-133 — ACTUAL PHYSICAL READOUT / ENACTMENT SEAM.

This module turns the previously opaque EventToGenerator and hEnacted
premises in LoadBearingPhysicalJoins into an explicit decomposition:
  1. physically complete readout separation modulo an independently
     justified same-physical equivalence relation;
  2. certified capture of EACH changed readout and neutral real step;
  3. a genuine source generator for EACH captured real transition;
  4. proof that EACH captured real transition is an admitted successor
     under the controller action actually selected at that observation.

No assumption is inferred from the word "capture", the four readout
field names, an append-only log, or mathematical state conservation.
These are distinct physical proof/measurement obligations. A captured
event alone does NOT enforce any selected controller action.

The resulting theorem uses the SAME real physical trace and the
UNCHANGED original two-priority global feasible comparison of IR98.
No universal BCRD, X3 physical deployment or psychological/subjective
continuation is asserted. This is a formal certificate factoring, not
a source of independent hardware evidence.
-/

namespace PhysicalBridges.IR133

open PhysicalBridges
open PhysicalBridges.IR125
open PhysicalBridges.CathedralCutGuardianCriterion

variable {P Mind Gen Option Event Obs Actuator D F G Ch : Type}

/-- An event receipt is physically *sound* only when source labels and
actual enacted transitions are both supported. Logging and actuation
are logically distinct. An independently specified realistic physical
relation must be the same in every field. -/
structure SourceEnactmentReceipt
    (s : Oct10Continuity.Source P Mind Gen Option)
    (r : FourReadouts P D F G Ch)
    (samePhysical : P → P → Prop)
    (witness : P → Event → P → Prop)
    (captured : Event → Prop)
    (observe : P → Obs)
    (sourceAction : P → Actuator → P → Prop)
    (policy : Obs → Actuator) : Prop where
  separates : SeparatesRealTransitions r s.realStep samePhysical
  dagCaptured : ∀ p q, s.realStep p q →
    r.dag p ≠ r.dag q →
    ∃ e, CapturedWitness witness captured p e q
  fluxCaptured : ∀ p q, s.realStep p q →
    r.flux p ≠ r.flux q →
    ∃ e, CapturedWitness witness captured p e q
  gaugeCaptured : ∀ p q, s.realStep p q →
    r.gauge p ≠ r.gauge q →
    ∃ e, CapturedWitness witness captured p e q
  actuatorCaptured : ∀ p q, s.realStep p q →
    r.actuator p ≠ r.actuator q →
    ∃ e, CapturedWitness witness captured p e q
  neutralCaptured : ∀ p q, s.realStep p q →
    samePhysical p q →
    ∃ e, CapturedWitness witness captured p e q
  authenticGenerator : ∀ p q e,
    CapturedWitness witness captured p e q →
      ∃ g, s.source g p q
  enforcedAction : ∀ p q e,
    CapturedWitness witness captured p e q →
      sourceAction p (policy (observe p)) q

/-- IR-125 derives a complete CAPTURED witness for every real transition
from sensor separation plus genuinely independent channel-capture data. -/
theorem captured_event_for_every_real_transition
    (s : Oct10Continuity.Source P Mind Gen Option)
    (r : FourReadouts P D F G Ch)
    (samePhysical : P → P → Prop)
    (witness : P → Event → P → Prop)
    (captured : Event → Prop)
    (observe : P → Obs)
    (sourceAction : P → Actuator → P → Prop)
    (policy : Obs → Actuator)
    (cert : SourceEnactmentReceipt s r samePhysical
      witness captured observe sourceAction policy) :
    ∀ p q, s.realStep p q →
      ∃ e, CapturedWitness witness captured p e q := by
  exact full_step_capture_from_four_channels
    r s.realStep samePhysical witness captured
    cert.separates cert.dagCaptured cert.fluxCaptured
    cert.gaugeCaptured cert.actuatorCaptured cert.neutralCaptured

/-- J1 + J3 have now been derived from smaller SOURCE-SPECIFIED
and PHYSICALLY AUDITABLE premises. Captured event completeness is
not silently equated to generator authenticity or effect enforcement. -/
theorem captured_events_supply_both_load_bearing_interfaces
    (s : Oct10Continuity.Source P Mind Gen Option)
    (r : FourReadouts P D F G Ch)
    (samePhysical : P → P → Prop)
    (witness : P → Event → P → Prop)
    (captured : Event → Prop)
    (observe : P → Obs)
    (sourceAction : P → Actuator → P → Prop)
    (policy : Obs → Actuator)
    (cert : SourceEnactmentReceipt s r samePhysical
      witness captured observe sourceAction policy) :
    LoadBearingPhysicalJoins.EventToGenerator s
      (CapturedWitness witness captured) ∧
    (∀ p q, s.realStep p q →
      sourceAction p (policy (observe p)) q) := by
  have hCaptured :=
    captured_event_for_every_real_transition
      s r samePhysical witness captured observe sourceAction policy cert
  constructor
  · exact {
      coversReal := hCaptured
      identifiesGenerator := cert.authenticGenerator
    }
  · intro p q hReal
    obtain ⟨e, hEvent⟩ := hCaptured p q hReal
    exact cert.enforcedAction p q e hEvent

/-- J1, J2, J3 and original-global-order J4, with the event and
actual-enactment premises explicitly decomposed into readout,
capture, source-mapping and source-action-refinement certificates.
The calibration, real subject meaning, guard, full feasible-family
comparison and the physical validity of this receipt remain EXTERNAL
to Lean, not hidden in the conclusion. -/
theorem captured_source_run_retains_original_order_protections
    (s : Oct10Continuity.Source P Mind Gen Option)
    (r : FourReadouts P D F G Ch)
    (samePhysical : P → P → Prop)
    (witness : P → Event → P → Prop)
    (captured : Event → Prop)
    (observe : P → Obs)
    (sourceAction : P → Actuator → P → Prop)
    (allowed : P → Actuator → Prop)
    (policy : Obs → Actuator)
    (cert : SourceEnactmentReceipt s r samePhysical
      witness captured observe sourceAction policy)
    (hContinuity : LoadBearingPhysicalJoins.GeneratorContinuity s)
    (burden : P → Mind → Nat)
    (trueEffect : Mind → Event → Nat)
    (hCalibrated : ∀ p q e,
      CapturedWitness witness captured p e q →
      ∀ m, burden q m ≤ burden p m + trueEffect m e)
    (hGuard : ∀ p, Oct10Continuity.Protected s p →
      GuardAction sourceAction allowed
        (Oct10Continuity.Protected s) p (policy (observe p)))
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
      IR123.WitnessedPhysicalReach
        (CapturedWitness witness captured) initial events final ∧
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
  obtain ⟨hEvents, hEnacted⟩ :=
    captured_events_supply_both_load_bearing_interfaces
      s r samePhysical witness captured observe sourceAction policy cert
  exact LoadBearingPhysicalJoins.finite_real_run_joins_event_continuity_guard_and_maximality
    s (CapturedWitness witness captured) hEvents hContinuity
    burden trueEffect hCalibrated observe sourceAction allowed
    policy hGuard hEnacted initial final execution hInitial
    outcomeAt modeled actual hModeled hActuallyFeasible hNoOmittedImprover

/-! NEGATIVE CONTROL: a real, durably recorded event can be generated
while the selected source controller action was never enacted. An
event-sourcing implementation must independently certify the atomic
final-effect action boundary. -/
theorem captured_event_does_not_imply_enacted_policy_action :
    ∃ (realStep : Bool → Bool → Prop)
      (witness : Bool → Unit → Bool → Prop)
      (captured : Unit → Prop)
      (sourceAction : Bool → Bool → Bool → Prop),
      realStep false true ∧
      CapturedWitness witness captured false () true ∧
      ¬ sourceAction false false true := by
  refine ⟨(fun _ _ => True), (fun _ _ _ => True),
    (fun _ => True), (fun p _ q => p = q),
    trivial, ⟨trivial, trivial⟩, ?_⟩
  intro h
  cases h

#print axioms captured_event_for_every_real_transition
#print axioms captured_events_supply_both_load_bearing_interfaces
#print axioms captured_source_run_retains_original_order_protections
#print axioms captured_event_does_not_imply_enacted_policy_action

end PhysicalBridges.IR133
