import PhysicalBridges.IR122PhysicalEventMeteringAdapter
import PhysicalBridges.IR96DisturbanceSimulation

/-!
IR-123: independently specified real-step coverage to a COMPLETE
physical-event list, and a calibration-sensitive adapter to IR-122.

IR-122 assumes a physicalEvents list whose replay upper-bounds the
real change in each particular's physical burden. This module
does not simply assert that endpoint replay bound again:

1. A REAL binary transition relation is kept distinct from the
   instrument's labelled-event relation.
2. For each real step, an EXTERNAL coverage warrant must supply a
   corresponding physical-event witness.
3. Every witnessed step has an EXTERNALLY calibrated physical effect
   envelope for each particular.
4. These premises derive a single complete event list and a bound
   on the independent real-plant burden for ANY finite real execution.
5. Independent endpoint sensors and independent charge/escrow ledger
   reconciliations then BUILD IR-122's physical event certificate.

The real-step coverage and calibration warranties remain physical
assumptions. A synthetic closed-world model may establish them,
but no enumeration of model constructors proves nature has no
outside channels. Real-world BCRD-completeness, subject identity
and maximal X3 remain open.
-/
namespace PhysicalBridges.IR123

open IR121
open IR122
open IR117
open IR119

universe u v w x y
variable {Mind : Type u} {Option : Type v} {Origin : Type w}
variable {E : Type x} {Code : Type y}
variable {P PhysEvent : Type}

/-- A physical-event word is complete relative to the independently
specified binary physical-step relation and its event witness. The
word contains ONE witnessed event for EVERY step in the execution,
including any environmental/latent/bypass steps admitted by the
real-step relation. -/
inductive WitnessedPhysicalReach
    (witness : P → PhysEvent → P → Prop) :
    P → List PhysEvent → P → Prop where
  | refl (p : P) : WitnessedPhysicalReach witness p [] p
  | tail {p q r : P} {events : List PhysEvent} {e : PhysEvent} :
      WitnessedPhysicalReach witness p events q →
      witness q e r →
      WitnessedPhysicalReach witness p (events ++ [e]) r

/-- Finite physical coverage theorem. This is not a classifier
completeness tautology: its explicit premise quantifies over an
INDEPENDENT real-step relation, not only recorded event objects.
To apply it to hardware, every consequential physical step must
be proved in the scope of that real-step relation. -/
theorem all_real_steps_witnessed_yield_complete_trace
    (realStep : P → P → Prop)
    (witness : P → PhysEvent → P → Prop)
    (hCoverage : ∀ p q, realStep p q →
      ∃ e, witness p e q)
    {initial final : P}
    (execution : IR96.Reach realStep initial final) :
    ∃ events : List PhysEvent,
      WitnessedPhysicalReach witness initial events final := by
  induction execution with
  | refl =>
      exact ⟨[], WitnessedPhysicalReach.refl _⟩
  | tail earlier edge ih =>
      obtain ⟨events, hEvents⟩ := ih
      obtain ⟨e, hWitness⟩ := hCoverage _ _ edge
      exact ⟨events ++ [e],
        WitnessedPhysicalReach.tail hEvents hWitness⟩

/-- A calibrated per-event physical envelope composes through every
real trace, yielding an independent real-burden bound. The effect
function is a PHYSICAL measurement/derivation, not a renamed
ledger charge. -/
theorem complete_physical_trace_burden_bound
    (witness : P → PhysEvent → P → Prop)
    (burden : P → Mind → Nat)
    (trueEffect : Mind → PhysEvent → Nat)
    (hCalibrated : ∀ p q e, witness p e q →
      ∀ m, burden q m ≤ burden p m + trueEffect m e)
    {initial final : P} {events : List PhysEvent}
    (execution : WitnessedPhysicalReach witness initial events final) :
    ∀ m, burden final m ≤
      burden initial m + (events.map (trueEffect m)).sum := by
  induction execution with
  | refl =>
      intro m
      simp
  | tail earlier edge ih =>
      intro m
      have hEarlier := ih m
      have hLatest := hCalibrated _ _ _ edge m
      simp only [List.map_append, List.map_cons, List.map_nil,
        List.sum_append, List.sum_cons, List.sum_nil] 
      omega

/-- Turn independently covered REAL physical execution into IR-122's
actual source/effect certificate. This establishes the replay upper
bound from a per-step calibrated real-plant trace, rather than
assuming replay is sound by assertion.

We STILL require independent, observable endpoint correspondence
(real burden to installation snapshots), and independent charge
reconciliation against the source landing counter and residual escrow.
These are hardware/instrument validation obligations. -/
theorem real_execution_builds_physical_event_certificate
    (s t : EscrowedInstallation Mind Option Origin E Code)
    (realStep : P → P → Prop)
    (witness : P → PhysEvent → P → Prop)
    (burden : P → Mind → Nat)
    (trueEffect residual : Mind → PhysEvent → Nat)
    (channel : Mind → PhysEvent → IRChannelInventory.Channel)
    (realStart realEnd : P)
    (execution : IR96.Reach realStep realStart realEnd)
    (hCoverage : ∀ p q, realStep p q →
      ∃ e, witness p e q)
    (hCalibrated : ∀ p q e, witness p e q →
      ∀ m, burden q m ≤ burden p m + trueEffect m e)
    (hInitialPhysical : ∀ m, burden realStart m ≤ s.plant.harm m)
    (hFinalPhysical : ∀ m, t.plant.harm m ≤ burden realEnd m)
    (hEventCharge : ∀ m e,
      trueEffect m e ≤
        IRChannelInventory.charge (channel m e) + residual m e)
    (hLandedReconciliation :
      ∀ (events : List PhysEvent),
        WitnessedPhysicalReach witness realStart events realEnd →
        ∀ m, (events.map
          (fun e => IRChannelInventory.charge (channel m e))).sum ≤
          t.plant.pipeline.landed - s.plant.pipeline.landed)
    (hResidualReconciliation :
      ∀ (events : List PhysEvent),
        WitnessedPhysicalReach witness realStart events realEnd →
        ∀ m, (events.map (residual m)).sum ≤
          t.spent m - s.spent m) :
    ∃ cert : PhysicalEventCertificate s t PhysEvent,
      ∀ m, t.plant.harm m ≤ s.plant.harm m +
        (t.plant.pipeline.landed - s.plant.pipeline.landed) +
        (t.spent m - s.spent m) := by
  obtain ⟨events, hFullTrace⟩ :=
    all_real_steps_witnessed_yield_complete_trace
      realStep witness hCoverage execution
  have hRealBound :=
    complete_physical_trace_burden_bound
      witness burden trueEffect hCalibrated hFullTrace
  let cert : PhysicalEventCertificate s t PhysEvent := {
    physicalEvents := fun _ => events
    trueEffect := trueEffect
    residual := residual
    channel := channel
    physicalReplaySound := by
      intro m
      have hTrace := hRealBound m
      have hInitial := hInitialPhysical m
      have hFinal := hFinalPhysical m
      rw [IRPhysicalAbstraction.physical_run_sum]
      omega
    eventChargeSound := by
      intro m e _
      exact hEventCharge m e
    modeledChargePaid := by
      intro m
      exact hLandedReconciliation events hFullTrace m
    residualsDebited := by
      intro m
      exact hResidualReconciliation events hFullTrace m
  }
  exact ⟨cert, eventwise_effects_imply_metered_harm s t cert⟩

/-- Two real physical states can have identical event logs while
the unobserved state's true damage differs: a closed digital event
inventory alone cannot establish completeness of the real dynamics.
This is an exact negative control against "there were no logged
events, therefore there were no physical effects." -/
theorem unobserved_event_breaks_empty_log :
    ∃ before after : Nat,
      IRPhysicalAbstraction.physicalRun
        (fun _ : Unit => 0) before [] = before ∧
      before = 0 ∧ after = 1 ∧
      ¬ after ≤
        IRPhysicalAbstraction.physicalRun
          (fun _ : Unit => 0) before [] := by
  exact ⟨0, 1, rfl, rfl, rfl, by decide⟩

/-- Every modelled event can be calibrated, yet a physical edge
outside its witness relation defeats coverage. This makes the
missing physical-world completeness obligation explicit. -/
theorem sound_event_calibration_does_not_imply_coverage :
    ∃ (realStep : Bool → Bool → Prop)
      (witness : Bool → Unit → Bool → Prop),
      (∀ p q e, witness p e q → p = q) ∧
      (∃ p q, realStep p q ∧
        ¬ ∃ e, witness p e q) := by
  refine ⟨(fun p q => p = false ∧ q = true),
    (fun p _ q => p = q), ?_, ?_⟩
  · intro p q _ h
    exact h
  · refine ⟨false, true, ⟨rfl, rfl⟩, ?_⟩
    intro h
    obtain ⟨_, impossible⟩ := h
    cases impossible

end PhysicalBridges.IR123
