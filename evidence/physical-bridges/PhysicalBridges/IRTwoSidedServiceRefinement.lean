/-
IR-64: upper physical safety is NOT lower physical service.

IR-62 controls excess physical effects by an upper simulation.
IR-63 proves progress of a *modeled* final-apply landed register.
Those facts alone cannot establish that physical service reached
any recipient. This module introduces an INDEPENDENT physical service
register with a separate, finite shortfall allowance.

Both physical safety and modeled service-to-actual correspondence
must be certified for every real event; neither certificate is
obtained merely from a successful source-level log or queued token.
-/
import PhysicalBridges.IRReserveReleaseLiveness

namespace PhysicalBridges.IRTwoSidedServiceRefinement

open IRNineRouteMediation
open IRProspectiveBudgetFence
open IRPhysicalRefinementResidual

/-- This is a source-level modeled actuator register, not a measurement
of delivered individual freedom or a person's continuing history. -/
def modelLanded (s : Reserved) : Nat :=
  s.plant.device.core.live.landed

structure ServiceEvent where
  physical : IRPhysicalRefinementResidual.RealEvent
  actualServed : Nat
  shortfallDebit : Nat

structure ServiceState where
  physical : IRPhysicalRefinementResidual.RealState
  observedServed : Nat
  spentShortfall : Nat
  remainingShortfall : Nat

def serviceStep (g controllerThreshold : Nat)
    (s : ServiceState) (e : ServiceEvent) : ServiceState :=
  { physical := realStep g controllerThreshold s.physical e.physical
    observedServed := s.observedServed + e.actualServed
    spentShortfall := s.spentShortfall + e.shortfallDebit
    remainingShortfall := s.remainingShortfall - e.shortfallDebit }

def serviceRun (g controllerThreshold : Nat)
    (s : ServiceState) (events : List ServiceEvent) : ServiceState :=
  events.foldl (serviceStep g controllerThreshold) s

/-- Upper physical-effect certificate AND an independent lower
delivered-service certificate. The second bounds the discrepancy
between source-level landed impact and physically observed service.
Neither constitutes empirical evidence by itself. -/
def CertifiedServiceEvent (g controllerThreshold : Nat)
    (s : ServiceState) (e : ServiceEvent) : Prop :=
  CertifiedEvent g controllerThreshold s.physical e.physical ∧
  e.shortfallDebit ≤ s.remainingShortfall ∧
  modelLanded (guardedStep g controllerThreshold
    s.physical.model e.physical.model) ≤
    modelLanded s.physical.model +
      e.actualServed + e.shortfallDebit

def TwoSided (g base controllerThreshold physicalResidual
    landedBase serviceShortfall : Nat) (s : ServiceState) : Prop :=
  Refined g base controllerThreshold physicalResidual s.physical ∧
  modelLanded s.physical.model ≤
    landedBase + s.observedServed + s.spentShortfall ∧
  s.spentShortfall + s.remainingShortfall = serviceShortfall

/-- A single concrete physical/service event preserves both
directions of the simulation. Physical harm may be UNDER the modeled
bound while physical service may ALSO be missing; each direction is
accounted for separately. -/
theorem two_sided_step
    (g base controllerThreshold physicalResidual
      landedBase serviceShortfall : Nat)
    (s : ServiceState) (e : ServiceEvent)
    (h : TwoSided g base controllerThreshold physicalResidual
      landedBase serviceShortfall s)
    (hCert : CertifiedServiceEvent g controllerThreshold s e) :
    TwoSided g base controllerThreshold physicalResidual
      landedBase serviceShortfall
      (serviceStep g controllerThreshold s e) := by
  obtain ⟨hPhysical, hServed, hConserved⟩ := h
  obtain ⟨hEffectCert, hMissedBudget, hServiceCert⟩ := hCert
  have hPhysNext := refined_real_step
    g base controllerThreshold physicalResidual
    s.physical e.physical hPhysical hEffectCert
  have hServiceNext :
      modelLanded (guardedStep g controllerThreshold
        s.physical.model e.physical.model) ≤
      landedBase + (s.observedServed + e.actualServed) +
        (s.spentShortfall + e.shortfallDebit) := by
    omega
  have hEscrowNext :
      (s.spentShortfall + e.shortfallDebit) +
        (s.remainingShortfall - e.shortfallDebit) =
        serviceShortfall := by omega
  exact ⟨hPhysNext, hServiceNext, hEscrowNext⟩

def CertifiedServiceTrace (g controllerThreshold : Nat) :
    ServiceState → List ServiceEvent → Prop
  | _, [] => True
  | s, e :: rest =>
      CertifiedServiceEvent g controllerThreshold s e ∧
        CertifiedServiceTrace g controllerThreshold
          (serviceStep g controllerThreshold s e) rest

theorem two_sided_run :
    ∀ (events : List ServiceEvent)
      (g base controllerThreshold physicalResidual
       landedBase serviceShortfall : Nat) (s : ServiceState),
      TwoSided g base controllerThreshold physicalResidual
        landedBase serviceShortfall s →
      CertifiedServiceTrace g controllerThreshold s events →
      TwoSided g base controllerThreshold physicalResidual
        landedBase serviceShortfall
        (serviceRun g controllerThreshold s events) := by
  intro events
  induction events with
  | nil =>
      intro g base controllerThreshold physicalResidual
        landedBase serviceShortfall s h _
      exact h
  | cons e rest ih =>
      intro g base controllerThreshold physicalResidual
        landedBase serviceShortfall s h hc
      exact ih g base controllerThreshold physicalResidual
        landedBase serviceShortfall
        (serviceStep g controllerThreshold s e)
        (two_sided_step g base controllerThreshold physicalResidual
          landedBase serviceShortfall s e h hc.1) hc.2

/-- Total missed service is genuinely bounded by a single bank. If
modelled landed impact exceeds baseline + all possible missing service,
actual observed service MUST be positive. Neither upper physical
safety nor source-level delivery gives this conclusion alone. -/
theorem actual_service_positive_if_model_exceeds_shortfall
    (g base controllerThreshold physicalResidual
      landedBase serviceShortfall : Nat)
    (s : ServiceState)
    (h : TwoSided g base controllerThreshold physicalResidual
      landedBase serviceShortfall s)
    (hProgress : landedBase + serviceShortfall <
      modelLanded s.physical.model) :
    0 < s.observedServed := by
  obtain ⟨_, hDelivery, hEscrow⟩ := h
  omega

/-- Full composed theorem: upper physical safety and lower physical
service, requiring BOTH independently certified kinds of evidence. -/
theorem certified_physical_safety_and_nonzero_service
    (g base controllerThreshold physicalResidual physicalT
      landedBase serviceShortfall : Nat)
    (s : ServiceState)
    (h : TwoSided g base controllerThreshold physicalResidual
      landedBase serviceShortfall s)
    (hMargin : controllerThreshold + physicalResidual ≤ physicalT)
    (hProgress : landedBase + serviceShortfall <
      modelLanded s.physical.model) :
    s.physical.actual ≤ physicalT ∧
      0 < s.observedServed := by
  exact ⟨refined_actual_bounded g base controllerThreshold
      physicalResidual physicalT s.physical h.1 hMargin,
    actual_service_positive_if_model_exceeds_shortfall
      g base controllerThreshold physicalResidual
      landedBase serviceShortfall s h hProgress⟩

/-- Initialize the two distinct physical registers and their separate
budgets, with no fictional actual service at time zero. -/
def seedService (a : IRPostHoldInjection.Audited)
    (g externalReserve physicalResidual actualInitial
      serviceShortfall : Nat) : ServiceState :=
  { physical := seedReal a g externalReserve physicalResidual actualInitial
    observedServed := 0
    spentShortfall := 0
    remainingShortfall := serviceShortfall }

theorem seed_two_sided
    (a : IRPostHoldInjection.Audited)
    (g externalReserve physicalResidual actualInitial
      serviceShortfall controllerThreshold : Nat)
    (hModel : a.core.live.landed + externalReserve ≤ controllerThreshold)
    (hActual : actualInitial ≤ a.core.live.landed) :
    TwoSided g a.core.live.landed controllerThreshold
      physicalResidual a.core.live.landed serviceShortfall
      (seedService a g externalReserve physicalResidual
        actualInitial serviceShortfall) := by
  constructor
  · exact seed_real_refined a g externalReserve physicalResidual
      controllerThreshold actualInitial hModel hActual
  constructor
  · change a.core.live.landed ≤ a.core.live.landed + 0 + 0
    omega
  · change (0 : Nat) + serviceShortfall = serviceShortfall
    omega

theorem full_certified_trace_safety_and_service
    (a : IRPostHoldInjection.Audited)
    (g externalReserve physicalResidual actualInitial
      serviceShortfall controllerThreshold physicalT : Nat)
    (events : List ServiceEvent)
    (hModel : a.core.live.landed + externalReserve ≤ controllerThreshold)
    (hActual : actualInitial ≤ a.core.live.landed)
    (hRoom : controllerThreshold + physicalResidual ≤ physicalT)
    (hCertified : CertifiedServiceTrace g controllerThreshold
      (seedService a g externalReserve physicalResidual
        actualInitial serviceShortfall) events)
    (hProgress : a.core.live.landed + serviceShortfall <
      modelLanded (serviceRun g controllerThreshold
        (seedService a g externalReserve physicalResidual
          actualInitial serviceShortfall) events).physical.model) :
    (serviceRun g controllerThreshold
      (seedService a g externalReserve physicalResidual
        actualInitial serviceShortfall) events).physical.actual ≤ physicalT ∧
    0 < (serviceRun g controllerThreshold
      (seedService a g externalReserve physicalResidual
        actualInitial serviceShortfall) events).observedServed := by
  have hFinal := two_sided_run events g a.core.live.landed
    controllerThreshold physicalResidual a.core.live.landed
    serviceShortfall
    (seedService a g externalReserve physicalResidual
      actualInitial serviceShortfall)
    (seed_two_sided a g externalReserve physicalResidual actualInitial
      serviceShortfall controllerThreshold hModel hActual) hCertified
  exact certified_physical_safety_and_nonzero_service
    g a.core.live.landed controllerThreshold physicalResidual physicalT
    a.core.live.landed serviceShortfall _ hFinal hRoom hProgress

/-- Hostile witness: a source-level model can land effect 1 while
the separately observed physical service register remains zero.
The bridge cannot promote modeled delivery to actual service without
a lower-service certificate. -/
theorem modeled_landing_without_service :
    ∃ s : ServiceState,
      modelLanded (serviceStep 0 1 s
        ⟨⟨.deliver, 0, 0⟩, 0, 0⟩).physical.model >
          modelLanded s.physical.model ∧
      (serviceStep 0 1 s
        ⟨⟨.deliver, 0, 0⟩, 0, 0⟩).observedServed =
        s.observedServed := by
  refine ⟨seedService
    IRReserveReleaseLiveness.freshPending 0 0 0 0 0, ?_⟩
  decide

#print axioms two_sided_step
#print axioms two_sided_run
#print axioms actual_service_positive_if_model_exceeds_shortfall
#print axioms certified_physical_safety_and_nonzero_service
#print axioms seed_two_sided
#print axioms full_certified_trace_safety_and_service
#print axioms modeled_landing_without_service
end PhysicalBridges.IRTwoSidedServiceRefinement
