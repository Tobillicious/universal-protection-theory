/-
IR-65: aggregate service and protected particular service are distinct.

The strong IR-64 dual safety/service theorem is *single-register*.
An aggregate successful delivery may leave particular individuals
unserved. Here a generic type of recipients may be infinite; the
pointwise protection conclusion only follows from evidence that
EVERY recipient actually has its own two-sided certified instrument
and a sufficient progress/shortfall margin.

This is conditional quantification, NOT empirical every-mind coverage
or original X3 full feasible maximality.
-/
import PhysicalBridges.IRTwoSidedServiceRefinement
import PhysicalBridges.IRUniformChannelMargin

namespace PhysicalBridges.IRUnrestrictedRecipientService

open IRTwoSidedServiceRefinement

universe u

/-- An aggregate total of 1 can hide that a particular member of a
two-recipient population received no service at all. -/
theorem aggregate_service_does_not_serve_every_recipient :
    ∃ served : Bool → Nat,
      served true + served false = 1 ∧
      ¬ (∀ a : Bool, 0 < served a) := by
  refine ⟨fun a => if a then 1 else 0, ?_, ?_⟩
  · decide
  · intro all
    have h := all false
    norm_num at h

/-- Even a maximal total under a one-unit budget can fail individual
service. Both feasible distributions are Pareto-undominated within
the one-unit feasible set; no way to fulfill both exists at that cap. -/
theorem one_unit_aggregate_optimum_can_exclude_a_person :
    ∃ served : Bool → Nat,
      served true + served false = 1 ∧
      (∀ other : Bool → Nat,
        other true + other false ≤ 1 →
        served true + served false ≥ other true + other false) ∧
      served false = 0 := by
  refine ⟨fun a => if a then 1 else 0, ?_, ?_, ?_⟩
  · decide
  · intro other h
    simp
    omega
  · rfl

/-- The IR-64 physical safety and service theorem composes POINTWISE
over ANY Agent type, without enumerating the population or imposing
a finite-cardinality requirement. The premises must hold for every
agent, and that is a substantive universal physical obligation. -/
theorem every_certified_recipient_physically_safe_and_served
    {Agent : Type u}
    (devices : Agent → ServiceState)
    (g base controllerThreshold physicalResidual physicalT
      landedBase serviceShortfall : Nat)
    (hEvery : ∀ a, TwoSided g base controllerThreshold
      physicalResidual landedBase serviceShortfall (devices a))
    (hRoom : controllerThreshold + physicalResidual ≤ physicalT)
    (hEachProgress : ∀ a,
      landedBase + serviceShortfall <
        modelLanded (devices a).physical.model) :
    ∀ a : Agent,
      (devices a).physical.actual ≤ physicalT ∧
        0 < (devices a).observedServed := by
  intro a
  exact certified_physical_safety_and_nonzero_service
    g base controllerThreshold physicalResidual physicalT
    landedBase serviceShortfall (devices a)
    (hEvery a) hRoom (hEachProgress a)

/-- When each physical recipient has a separately certified finite
execution, the same pointwise conclusion holds. The finite traces
belong to each individual instrument; the RECIPIENT TYPE is not
assumed finite and no uniform aggregate fleet budget is inferred. -/
theorem every_recipient_from_independent_certified_traces
    {Agent : Type u}
    (devices : Agent → ServiceState)
    (traces : Agent → List ServiceEvent)
    (g base controllerThreshold physicalResidual physicalT
      landedBase serviceShortfall : Nat)
    (hInitial : ∀ a,
      TwoSided g base controllerThreshold physicalResidual
        landedBase serviceShortfall (devices a))
    (hCertificate : ∀ a,
      CertifiedServiceTrace g controllerThreshold
        (devices a) (traces a))
    (hRoom : controllerThreshold + physicalResidual ≤ physicalT)
    (hProgress : ∀ a,
      landedBase + serviceShortfall <
        modelLanded (serviceRun g controllerThreshold
          (devices a) (traces a)).physical.model) :
    ∀ a : Agent,
      (serviceRun g controllerThreshold
        (devices a) (traces a)).physical.actual ≤ physicalT ∧
      0 < (serviceRun g controllerThreshold
        (devices a) (traces a)).observedServed := by
  intro a
  have hFinal := two_sided_run (traces a)
    g base controllerThreshold physicalResidual landedBase
    serviceShortfall (devices a)
    (hInitial a) (hCertificate a)
  exact certified_physical_safety_and_nonzero_service
    g base controllerThreshold physicalResidual physicalT
    landedBase serviceShortfall
    (serviceRun g controllerThreshold (devices a) (traces a))
    hFinal hRoom (hProgress a)

/-- A common per-recipient finite impact cap does not yield one
unconditional total fleet-wide cap for an unbounded population. -/
theorem no_unconditional_fleet_total_from_local_unit_cap :
    ∀ proposed : Nat,
      ∃ weights : List Nat,
        (∀ w, w ∈ weights → w ≤ 1) ∧
        proposed < weights.sum :=
  IRUniformChannelMargin.per_channel_cap_without_degree_cap_is_insufficient

/-- A pointwise conditional result may be true even for empty Agent
type; nonemptiness and actual individual identification remain
separate. This countercontrol must not be promoted to existence. -/
theorem empty_population_vacuity :
    (∀ a : Empty, False) := by
  intro a
  cases a

#print axioms aggregate_service_does_not_serve_every_recipient
#print axioms one_unit_aggregate_optimum_can_exclude_a_person
#print axioms every_certified_recipient_physically_safe_and_served
#print axioms every_recipient_from_independent_certified_traces
#print axioms no_unconditional_fleet_total_from_local_unit_cap
#print axioms empty_population_vacuity
end PhysicalBridges.IRUnrestrictedRecipientService
