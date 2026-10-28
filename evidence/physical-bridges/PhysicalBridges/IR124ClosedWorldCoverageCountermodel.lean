import PhysicalBridges.IR123RealEventCoverage

/-!
IR-124: constructive coverage of a FOUR-CAUSE physical plant, and a
deliberately unclassifiable FIFTH cause that defeats coverage.

An exhaustive finite inductive physical transition law can supply
IR-123's one-step physical-event witness premise by cases, rather
than merely assuming completeness of a digital event log.

Important: the exhaustiveness is relative to THIS SPECIFIED PLANT.
It is not a derivation that BCRD or real hardware has only these
four channels. A novel hidden physical event is a concrete
countermodel to extending the result without a renewed coverage proof.

The witness includes CAUSAL ORIGIN (kind), not only an effect
magnitude: otherwise an unrecorded event with the same scalar impact
could be relabelled as a known event after the fact.
-/
namespace PhysicalBridges.IR124

open IR123

inductive CauseKind where
  | actuator
  | environmental
  | latent
  | bypass
  | unclassified
  deriving DecidableEq, Repr

inductive Cause where
  | actuator (magnitude : Nat)
  | environmental (magnitude : Nat)
  | latent (magnitude : Nat)
  | bypass (magnitude : Nat)
  deriving DecidableEq, Repr

def kind : Cause → CauseKind
  | .actuator _ => .actuator
  | .environmental _ => .environmental
  | .latent _ => .latent
  | .bypass _ => .bypass

def impact : Cause → Nat
  | .actuator n => n
  | .environmental n => n
  | .latent n => n
  | .bypass n => n

/-- Environmental, latent and bypass effects consume RESIDUAL escrow;
only actual actuator delivery is charged to the IR-32 landed counter.
This is one illustrative unit-consistent accounting convention. -/
def channel : Cause → IRChannelInventory.Channel
  | .actuator n => .authorised n
  | .environmental _ => .environmental 0
  | .latent _ => .latent 0
  | .bypass _ => .bypass 0

def residual : Cause → Nat
  | .actuator _ => 0
  | .environmental n => n
  | .latent n => n
  | .bypass n => n

/-- The physical state carries a true cause-kind witness separate
from the numerical physical burden. This must be observable or
independently certified in a real installation. -/
structure Plant where
  burden : Nat
  lastCause : CauseKind
  deriving DecidableEq, Repr

def apply (s : Plant) (e : Cause) : Plant :=
  { burden := s.burden + impact e, lastCause := kind e }

/-- An independently stated *four-constructor* plant step relation.
It includes a bypass event; bypass need not be authorized to occur. -/
inductive RealStep : Plant → Plant → Prop where
  | actuator (s : Plant) (n : Nat) :
      RealStep s (apply s (.actuator n))
  | environmental (s : Plant) (n : Nat) :
      RealStep s (apply s (.environmental n))
  | latent (s : Plant) (n : Nat) :
      RealStep s (apply s (.latent n))
  | bypass (s : Plant) (n : Nat) :
      RealStep s (apply s (.bypass n))

/-- Unlike comparing charges, source-event witness equality checks
the true kind as well as physical effect and final state. -/
def Witness (s : Plant) (e : Cause) (t : Plant) : Prop :=
  t = apply s e

theorem all_four_real_step_classes_are_witnessed :
    ∀ s t, RealStep s t → ∃ e, Witness s e t := by
  intro s t h
  cases h with
  | actuator s n => exact ⟨.actuator n, rfl⟩
  | environmental s n => exact ⟨.environmental n, rfl⟩
  | latent s n => exact ⟨.latent n, rfl⟩
  | bypass s n => exact ⟨.bypass n, rfl⟩

/-- A physically identified event completely accounts for the exact
effect increment in this toy plant. In an actual plant, this would
require calibration, physical observability and causal verification. -/
theorem exact_effect_calibration :
    ∀ s t e, Witness s e t →
      ∀ _m : Unit, t.burden ≤ s.burden + impact e := by
  intro s t e h _
  rw [h]
  rfl

theorem event_charge_and_residual_exact
    (e : Cause) :
    impact e = IRChannelInventory.charge (channel e) + residual e := by
  cases e <;> rfl

/-- Every finite trace of the independently specified four-class
physical plant admits a COMPLETE event list, with a proved physical
burden bound from the source-level IR-123 trace simulation. -/
theorem finite_real_plant_trace_has_complete_calibrated_events
    (s t : Plant) (h : IR96.Reach RealStep s t) :
    ∃ events : List Cause,
      WitnessedPhysicalReach Witness s events t ∧
        t.burden ≤ s.burden + (events.map impact).sum := by
  obtain ⟨events, hEvents⟩ :=
    IR123.all_real_steps_witnessed_yield_complete_trace
      RealStep Witness all_four_real_step_classes_are_witnessed h
  have hBound :=
    IR123.complete_physical_trace_burden_bound
      (Mind := Unit) Witness
      (fun p (_ : Unit) => p.burden)
      (fun (_ : Unit) e => impact e)
      exact_effect_calibration hEvents ()
  exact ⟨events, hEvents, hBound⟩

/-- The four typed causes have a fully exact synthetic source/residual
decomposition for every event word. This alone does NOT prove either
the actuator landed count or the residual spend ledger was physically
updated to match these sums. -/
theorem all_four_causes_split_into_charge_and_residual
    (events : List Cause) :
    (events.map impact).sum =
      (events.map (fun e =>
        IRChannelInventory.charge (channel e))).sum +
      (events.map residual).sum := by
  induction events with
  | nil => simp
  | cons e es ih =>
      simp only [List.map_cons, List.sum_cons]
      have hPiece := event_charge_and_residual_exact e
      omega

/-- A FIFTH real cause cannot be accounted for by post hoc relabeling
as one of the four known sources. It carries a distinguishable true
unclassified causal tag, even when its scalar burden matches. -/
inductive ExtendedRealStep : Plant → Plant → Prop where
  | known {s t : Plant} : RealStep s t → ExtendedRealStep s t
  | unknown (s : Plant) (magnitude : Nat) :
      ExtendedRealStep s
        { burden := s.burden + magnitude, lastCause := .unclassified }

/-- Exact proof that the four-cause witness is NOT complete for the
extended real plant. This defeats treating a "complete modeled
alphabet" as a universal physical interface certificate. -/
theorem fifth_cause_defeats_four_cause_coverage :
    ∃ (s t : Plant),
      ExtendedRealStep s t ∧ ¬ ∃ e : Cause, Witness s e t := by
  let s : Plant := { burden := 0, lastCause := .actuator }
  let t : Plant := { burden := 1, lastCause := .unclassified }
  refine ⟨s, t, ?_, ?_⟩
  · exact ExtendedRealStep.unknown s 1
  · rintro ⟨e, h⟩
    have hTag : CauseKind.unclassified = kind e := by
      have hKind := congrArg Plant.lastCause h
      exact hKind
    cases e <;> cases hTag

end PhysicalBridges.IR124
