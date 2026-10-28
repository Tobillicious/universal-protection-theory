import PhysicalBridges.IR121MeteredResidualEscrow
import PhysicalBridges.IRPhysicalAbstraction

/-!
IR-122 — Source-event adapter for IR-121's physical metering premise.

IR-121's meteredHarm is a real physical-effect correspondence premise.
Here we derive it from independently inspectable eventwise warranties:
(1) the actual physical burden register is bounded by replaying the
    complete observed physical-event list through IR-24's physicalRun;
(2) EVERY observed event has a justified charge + residual envelope;
(3) the cumulative channel charge is paid by IR-32 landed effects;
(4) the cumulative residual is correctly debited from IR-121 escrow.

The result refines event-witnessed real transitions into the same
IR-121 finite-trace protection theorem, retaining ALL of its stronger
source/duty/provenance/freedom requirements.

No theorem here derives that a real installation's event inventory
is complete, calibrates physical effects, or establishes that a
continuing recorded history is the same living subject. No universal
BCRD/X3 conclusion follows automatically.
-/
namespace PhysicalBridges.IR122

open IR121
open IR117
open IR119

universe u v w x y
variable {Mind : Type u} {Option : Type v} {Origin : Type w}
variable {E : Type x} {Code : Type y} {PhysicalEvent : Type}

/-- All non-damage source contracts from IR-121, separated so their
physical-harm premise can genuinely be DERIVED from IR-24 witnesses
rather than restated or smuggled into this certificate. -/
structure SourceRightsCertificate
    (ceiling : Mind → Nat) (encode : E → Code)
    (s t : EscrowedInstallation Mind Option Origin E Code)
    (cmd : IRInFlightQuiescence.Cmd)
    (events : Mind → E) : Prop where
  source : t.plant.pipeline =
    IRInFlightQuiescence.step s.plant.pipeline cmd
  history : t.witnesses = appendEvent encode s.witnesses events
  residualMonotone : ∀ m, s.spent m ≤ t.spent m
  escrowConserved : ∀ m,
    s.free m + s.reserved m + s.spent m =
      t.free m + t.reserved m + t.spent m
  preserveDuties : ∀ m, s.plant.owed m → t.plant.owed m
  preserveOptions : ∀ m a,
    s.plant.executable m a → t.plant.executable m a
  coverNewRequirements : ∀ m a,
    t.plant.owed m → t.plant.required m a →
      s.plant.required m a ∨ t.plant.executable m a
  nonemptyRequired : ∀ m,
    t.plant.owed m → ∃ a, t.plant.required m a
  certifyNewEntrant : ∀ m, t.plant.owed m → ¬ s.plant.owed m →
    (t.plant.harm m +
      t.plant.pipeline.inFlight.sum + t.plant.pipeline.pending.sum +
      t.free m + t.reserved m ≤ ceiling m) ∧
    (∀ a, t.plant.required m a → t.plant.executable m a)

/-- A physically witnessed event list, with explicit observation-to-
physical-state soundness and per-event channel+residual envelope.

This DOES NOT claim a closed typed channel alphabet represents all
real external/latent hazards. It supplies the precise adapter
obligations that an independent installation audit must validate. -/
structure PhysicalEventCertificate
    (s t : EscrowedInstallation Mind Option Origin E Code)
    (PhysicalEvent : Type) where
  physicalEvents : Mind → List PhysicalEvent
  trueEffect : Mind → PhysicalEvent → Nat
  residual : Mind → PhysicalEvent → Nat
  channel : Mind → PhysicalEvent → IRChannelInventory.Channel
  physicalReplaySound : ∀ m,
    t.plant.harm m ≤
      IRPhysicalAbstraction.physicalRun
        (trueEffect m) (s.plant.harm m) (physicalEvents m)
  eventChargeSound : ∀ m event,
    event ∈ physicalEvents m →
      trueEffect m event ≤
        IRChannelInventory.charge (channel m event) +
          residual m event
  modeledChargePaid : ∀ m,
    ((physicalEvents m).map
      (fun event => IRChannelInventory.charge (channel m event))).sum ≤
        t.plant.pipeline.landed - s.plant.pipeline.landed
  residualsDebited : ∀ m,
    ((physicalEvents m).map (residual m)).sum ≤
      t.spent m - s.spent m

/-- IR-24's ORIGINAL per-event effect bound, combined with real
physical-replay correspondence and independently settled channel
charges, discharges IR-121's opaque meteredHarm contract. -/
theorem eventwise_effects_imply_metered_harm
    (s t : EscrowedInstallation Mind Option Origin E Code)
    (h : PhysicalEventCertificate s t PhysicalEvent) :
    ∀ m, t.plant.harm m ≤ s.plant.harm m +
      (t.plant.pipeline.landed - s.plant.pipeline.landed) +
      (t.spent m - s.spent m) := by
  intro m
  have hSourceBound :=
    IRPhysicalAbstraction.residual_sum_bound
      (h.physicalEvents m)
      (h.trueEffect m) (h.residual m) (h.channel m)
      (h.eventChargeSound m)
  have hTrue := h.physicalReplaySound m
  have hRun := IRPhysicalAbstraction.physical_run_sum
    (h.trueEffect m) (h.physicalEvents m)
    (s.plant.harm m)
  rw [hRun] at hTrue
  have hPaid := h.modeledChargePaid m
  have hDebited := h.residualsDebited m
  omega

/-- Compose the source certificate with the real-event certificate
to BUILD IR-121's required physical step from smaller premises.
The physical effect inequality is no longer a field in the supplied
source contract. -/
theorem event_and_source_certificates_build_ir121
    (ceiling : Mind → Nat) (encode : E → Code)
    (s t : EscrowedInstallation Mind Option Origin E Code)
    (cmd : IRInFlightQuiescence.Cmd) (historyEvents : Mind → E)
    (source : SourceRightsCertificate ceiling encode s t cmd historyEvents)
    (physical : PhysicalEventCertificate s t PhysicalEvent) :
    ResidualCertifiedStep ceiling encode s t cmd historyEvents := by
  exact {
    source := source.source
    history := source.history
    residualMonotone := source.residualMonotone
    escrowConserved := source.escrowConserved
    meteredHarm := eventwise_effects_imply_metered_harm s t physical
    preserveDuties := source.preserveDuties
    preserveOptions := source.preserveOptions
    coverNewRequirements := source.coverNewRequirements
    nonemptyRequired := source.nonemptyRequired
    certifyNewEntrant := source.certifyNewEntrant
  }

/-- A source-level physical transition must actually supply BOTH
independent source-rights and physical-effect warranties. -/
def EventAccountedStep
    (ceiling : Mind → Nat) (encode : E → Code)
    (s t : EscrowedInstallation Mind Option Origin E Code) : Prop :=
  ∃ (cmd : IRInFlightQuiescence.Cmd) (historyEvents : Mind → E)
      (physical : PhysicalEventCertificate s t PhysicalEvent),
    SourceRightsCertificate ceiling encode s t cmd historyEvents

theorem event_accounted_step_refines_ir121
    (ceiling : Mind → Nat) (encode : E → Code)
    (s t : EscrowedInstallation Mind Option Origin E Code)
    (h : EventAccountedStep (PhysicalEvent := PhysicalEvent)
      ceiling encode s t) :
    ResidualInstalledStep ceiling encode s t := by
  obtain ⟨cmd, events, hPhysical, hSource⟩ := h
  exact ⟨cmd, events,
    event_and_source_certificates_build_ir121
      ceiling encode s t cmd events hSource hPhysical⟩

/-- Every finite trace admitted through the more concrete eventwise
source certificate maps to IR-121's certified physical transition
relation, so the verified IR-121 finite-trace conclusion applies
unchanged. -/
theorem event_accounted_finite_trace_preserves_all_owed
    (ceiling : Mind → Nat) (encode : E → Code)
    (start finish : EscrowedInstallation Mind Option Origin E Code)
    (execution : IR96.Reach
      (EventAccountedStep (PhysicalEvent := PhysicalEvent)
        ceiling encode) start finish)
    (hClosed : start.plant.pipeline.closed = true)
    (hGuard : ReservedGuard ceiling start)
    (hFaithful : FaithfulAll encode start.witnesses) :
    ReservedGuard ceiling finish ∧
      FaithfulAll encode finish.witnesses ∧
      (∀ m, start.plant.owed m → finish.plant.owed m) := by
  have hRefined : IR96.Reach
      (ResidualInstalledStep ceiling encode) start finish := by
    induction execution with
    | refl => exact IR96.Reach.refl _
    | tail earlier edge ih =>
        exact IR96.Reach.tail ih
          (event_accounted_step_refines_ir121
            ceiling encode _ _ edge)
  obtain ⟨_, hGuardFinal, hFaithfulFinal, hDuties, _, _⟩ :=
    IR121.all_finite_residual_traces_preserve_guard
      ceiling encode start finish hRefined
      hClosed hGuard hFaithful
  exact ⟨hGuardFinal, hFaithfulFinal, hDuties⟩

/-- A coded source log alone does not cover environmental or bypass
effects. This reuses IR-15's actual finite hidden-channel witness,
rather than silently treating classification as completeness. -/
theorem missing_external_channel_is_fatal_to_naive_inventory :
    ∃ trace : List IRChannelInventory.Channel,
      (trace.map IRChannelInventory.incompleteCharge).sum = 0 ∧
      0 < (trace.map IRChannelInventory.charge).sum :=
  IRChannelInventory.incomplete_inventory_counterexample

end PhysicalBridges.IR122
