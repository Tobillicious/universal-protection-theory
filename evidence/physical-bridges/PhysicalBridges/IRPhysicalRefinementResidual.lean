/-
IR-62: a real-transition *interface* for IR-61, with a conserving
residual budget and an independently evolving actual effect register.

A proposed correspondence certificate is checked per physical event:
the actual increment may exceed the modeled IR-61 increment, but
only by a charged residual whose total is budgeted once. The real
event type is distinct from the nine-constructor model event type.

This does NOT prove physical completeness, calibrated observations,
certified physical effects, empirical bounds, or historical identity.
-/
import PhysicalBridges.IRProspectiveBudgetFence
import PhysicalBridges.IRPhysicalAbstraction

namespace PhysicalBridges.IRPhysicalRefinementResidual

open IRNineRouteMediation
open IRProspectiveBudgetFence

/-- Independent reported physical event. The label is a PROPOSED
classifier, not proof that all real events have a sound label. -/
structure RealEvent where
  model : IRNineRouteMediation.Event
  actualIncrement : Nat
  residualDebit : Nat

/-- Physical register is independent of the modeled source actuator
and source-level accounting. Two residual counters make conservation
a consequence of per-step debits, rather than an assumed total. -/
structure RealState where
  model : IRProspectiveBudgetFence.Reserved
  actual : Nat
  spentResidual : Nat
  remainingResidual : Nat

def realStep (g controllerThreshold : Nat)
    (s : RealState) (e : RealEvent) : RealState :=
  { model := guardedStep g controllerThreshold s.model e.model
    actual := s.actual + e.actualIncrement
    spentResidual := s.spentResidual + e.residualDebit
    remainingResidual := s.remainingResidual - e.residualDebit }

def realRun (g controllerThreshold : Nat)
    (s : RealState) (events : List RealEvent) : RealState :=
  events.foldl (realStep g controllerThreshold) s

/-- The complete per-event semantic/physical bridge, NOT just an
arbitrary free 'realises' relation. Its load-bearing inequalities
must be measured or proved about a particular physical instrument. -/
def CertifiedEvent (g controllerThreshold : Nat)
    (s : RealState) (e : RealEvent) : Prop :=
  ExternalFits s.model e.model ∧
  e.residualDebit ≤ s.remainingResidual ∧
  e.actualIncrement ≤
    (totalPhysical (guardedStep g controllerThreshold s.model e.model).plant -
      totalPhysical s.model.plant) + e.residualDebit

/-- Actual physical register is dominated by the modeled register plus
the *spent* portion of one shared, conserving residual reserve. -/
def Refined (g base controllerThreshold totalResidual : Nat)
    (s : RealState) : Prop :=
  Healthy g base controllerThreshold s.model ∧
  s.actual ≤ totalPhysical s.model.plant + s.spentResidual ∧
  s.spentResidual + s.remainingResidual = totalResidual

/-- The guarded modeled total is nondecreasing even when delivery is
refused. External channels still move the modeled physical register. -/
theorem guarded_model_monotone
    (g controllerThreshold : Nat) (s : Reserved) (e : Event) :
    totalPhysical s.plant ≤
      totalPhysical (guardedStep g controllerThreshold s e).plant := by
  cases e with
  | deliver =>
      by_cases h :
          totalPhysical s.plant +
            IRPostHoldInjection.freshImpact g s.plant.device.core +
            s.remainingExternal ≤ controllerThreshold
      · simpa [guardedStep, h] using
          (IRNineRouteMediation.modeled_physical_monotone_step
            g s.plant Event.deliver)
      · simp [guardedStep, h]
  | hold next =>
      simpa [guardedStep] using
        (IRNineRouteMediation.modeled_physical_monotone_step
          g s.plant (.hold next))
  | restart =>
      simpa [guardedStep] using
        (IRNineRouteMediation.modeled_physical_monotone_step
          g s.plant .restart)
  | inject token impact =>
      simpa [guardedStep] using
        (IRNineRouteMediation.modeled_physical_monotone_step
          g s.plant (.inject token impact))
  | sample value =>
      simpa [guardedStep] using
        (IRNineRouteMediation.modeled_physical_monotone_step
          g s.plant (.sample value))
  | tick =>
      simpa [guardedStep] using
        (IRNineRouteMediation.modeled_physical_monotone_step
          g s.plant .tick)
  | environmental n =>
      simpa [guardedStep] using
        (IRNineRouteMediation.modeled_physical_monotone_step
          g s.plant (.environmental n))
  | latent n =>
      simpa [guardedStep] using
        (IRNineRouteMediation.modeled_physical_monotone_step
          g s.plant (.latent n))
  | bypass n =>
      simpa [guardedStep] using
        (IRNineRouteMediation.modeled_physical_monotone_step
          g s.plant (.bypass n))

/-- One certified physical event preserves an ACTUAL-to-MODEL
simulation upper bound, with one exact residual debit. Notice
that the physical actual increment is independent input data. -/
theorem refined_real_step
    (g base controllerThreshold totalResidual : Nat)
    (s : RealState) (e : RealEvent)
    (h : Refined g base controllerThreshold totalResidual s)
    (hCert : CertifiedEvent g controllerThreshold s e) :
    Refined g base controllerThreshold totalResidual
      (realStep g controllerThreshold s e) := by
  obtain ⟨hHealthy, hRel, hConserve⟩ := h
  obtain ⟨hExternal, hDebit, hEffect⟩ := hCert
  have hMode := healthy_guarded_step g base controllerThreshold
    s.model e.model hHealthy hExternal
  have hMono := guarded_model_monotone
    g controllerThreshold s.model e.model
  have hNextActual :
      s.actual + e.actualIncrement ≤
        totalPhysical
          (guardedStep g controllerThreshold s.model e.model).plant +
        (s.spentResidual + e.residualDebit) := by
    omega
  have hNextEscrow :
      (s.spentResidual + e.residualDebit) +
        (s.remainingResidual - e.residualDebit) =
      totalResidual := by omega
  exact ⟨hMode, hNextActual, hNextEscrow⟩

/-- The complete finite physical trace certificate is recursively
checked against each ACTUALLY reached intermediate real state. -/
def CertifiedTrace (g controllerThreshold : Nat) :
    RealState → List RealEvent → Prop
  | _, [] => True
  | s, e :: rest =>
      CertifiedEvent g controllerThreshold s e ∧
        CertifiedTrace g controllerThreshold
          (realStep g controllerThreshold s e) rest

theorem refined_real_run :
    ∀ (events : List RealEvent)
      (g base controllerThreshold totalResidual : Nat)
      (s : RealState),
      Refined g base controllerThreshold totalResidual s →
      CertifiedTrace g controllerThreshold s events →
      Refined g base controllerThreshold totalResidual
        (realRun g controllerThreshold s events) := by
  intro events
  induction events with
  | nil =>
      intro g base controllerThreshold totalResidual s h _
      exact h
  | cons e rest ih =>
      intro g base controllerThreshold totalResidual s h cert
      exact ih g base controllerThreshold totalResidual
        (realStep g controllerThreshold s e)
        (refined_real_step g base controllerThreshold totalResidual
          s e h cert.1) cert.2

/-- A physical threshold follows at ALL certified event boundaries.
The controller budget is deliberately tighter by the full worst-case
residual allocation: controllerThreshold + totalResidual <= physicalT. -/
theorem refined_actual_bounded
    (g base controllerThreshold totalResidual physicalT : Nat)
    (s : RealState)
    (h : Refined g base controllerThreshold totalResidual s)
    (hThreshold : controllerThreshold + totalResidual ≤ physicalT) :
    s.actual ≤ physicalT := by
  obtain ⟨hHealthy, hActual, hReserve⟩ := h
  have hModel := hHealthy.2
  omega

theorem certified_physical_trace_safe :
    ∀ (events : List RealEvent)
      (g base controllerThreshold totalResidual physicalT : Nat)
      (s : RealState),
      Refined g base controllerThreshold totalResidual s →
      CertifiedTrace g controllerThreshold s events →
      controllerThreshold + totalResidual ≤ physicalT →
      (realRun g controllerThreshold s events).actual ≤ physicalT := by
  intro events g base controllerThreshold totalResidual physicalT
    s hInitial hCert hBudget
  exact refined_actual_bounded g base controllerThreshold
    totalResidual physicalT _
    (refined_real_run events g base controllerThreshold
      totalResidual s hInitial hCert) hBudget

/-- A concrete baseline starts with an independently set actual
quantity. The initial physical/model correspondence is an explicit
hypothesis rather than definitional identity. -/
def seedReal (a : IRPostHoldInjection.Audited)
    (g externalReserve totalResidual actualInitial : Nat) : RealState :=
  { model := seedReserved a g externalReserve
    actual := actualInitial
    spentResidual := 0
    remainingResidual := totalResidual }

theorem seed_real_refined
    (a : IRPostHoldInjection.Audited)
    (g externalReserve totalResidual controllerThreshold actualInitial : Nat)
    (hModel : a.core.live.landed + externalReserve ≤ controllerThreshold)
    (hReal : actualInitial ≤ a.core.live.landed) :
    Refined g a.core.live.landed controllerThreshold totalResidual
      (seedReal a g externalReserve totalResidual actualInitial) := by
  refine ⟨seeded_healthy a g externalReserve controllerThreshold hModel,
    ?_, ?_⟩
  · change actualInitial ≤ a.core.live.landed + 0
    omega
  · change 0 + totalResidual = totalResidual
    omega

/-- A guarded physical trace stays below the physical threshold,
including the total residual reserve, without using a retrospective
assumption about final actual effect. -/
theorem real_instrument_conditional_safety
    (a : IRPostHoldInjection.Audited)
    (g externalReserve totalResidual controllerThreshold physicalT
      actualInitial : Nat) (events : List RealEvent)
    (hModel : a.core.live.landed + externalReserve ≤ controllerThreshold)
    (hReal : actualInitial ≤ a.core.live.landed)
    (hPhysicalRoom : controllerThreshold + totalResidual ≤ physicalT)
    (hCertified : CertifiedTrace g controllerThreshold
      (seedReal a g externalReserve totalResidual actualInitial) events) :
    (realRun g controllerThreshold
      (seedReal a g externalReserve totalResidual actualInitial)
      events).actual ≤ physicalT := by
  exact certified_physical_trace_safe events g a.core.live.landed
    controllerThreshold totalResidual physicalT
    (seedReal a g externalReserve totalResidual actualInitial)
    (seed_real_refined a g externalReserve totalResidual
      controllerThreshold actualInitial hModel hReal)
    hCertified hPhysicalRoom

/-- If a physical event has an unrepresented actual effect, the
nine-route classifier and the seemingly safe controller still permit
a physical breach. Here .tick accounts for zero in the model while
the independent physical register increases by two. -/
theorem unrepresented_real_effect_counterexample :
    ∃ a : IRPostHoldInjection.Audited,
      let s := seedReal a 0 0 0 0
      let e : RealEvent := ⟨.tick, 2, 0⟩
      ¬ CertifiedEvent 0 1 s e ∧
      (realStep 0 1 s e).actual > 1 ∧
      totalPhysical (guardedStep 0 1 s.model e.model).plant = 0 := by
  refine ⟨
    { core := { durableFloor := 0,
                live := { floor := 0, pending := [], landed := 0 } },
      revokedLanded := 0 }, ?_⟩
  change
    (¬ (True ∧ (0 : Nat) ≤ 0 ∧ 2 ≤ (0 - 0) + 0)) ∧
      2 > 1 ∧ 0 = 0
  decide

/-- Each residual debit may be finite, but without conservation its
aggregate cannot be uniformly bounded. -/
theorem arbitrary_unmetered_residual_defeats_any_budget :
    ∀ budget : Nat,
      ∃ e : RealEvent,
        budget < e.actualIncrement ∧
        e.model = .tick ∧ e.residualDebit = 0 := by
  intro budget
  refine ⟨⟨.tick, budget + 1, 0⟩, ?_, rfl, rfl⟩
  change budget < budget + 1
  omega

#print axioms guarded_model_monotone
#print axioms refined_real_step
#print axioms refined_real_run
#print axioms refined_actual_bounded
#print axioms certified_physical_trace_safe
#print axioms seed_real_refined
#print axioms real_instrument_conditional_safety
#print axioms unrepresented_real_effect_counterexample
#print axioms arbitrary_unmetered_residual_defeats_any_budget

end PhysicalBridges.IRPhysicalRefinementResidual
