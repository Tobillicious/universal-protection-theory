/-
IR-63: Safe refusal is not progress. The IR-61 prospective
effect fence may remain safe while denying a useful fresh delivery
indefinitely, if a conservative external reserve is never discharged.

A source-level reserve release is possible only as a *separate*
certificate-driven transition. It cannot manufacture evidence that
physical external exposure has disappeared; future TraceFits remains
an independent load-bearing premise. No unbounded liveness claimed.
-/
import PhysicalBridges.IRPhysicalRefinementResidual

namespace PhysicalBridges.IRReserveReleaseLiveness

open IRNineRouteMediation
open IRProspectiveBudgetFence

/-- A disputed or unavailable reserve can be reduced in the accounting
model. The *physical authorization* to reduce it is intentionally not
inferred from this function; see certified_release_and_run. -/
def dischargeReserve (s : Reserved) (quantity : Nat) : Reserved :=
  { s with remainingExternal := s.remainingExternal - quantity }

/-- Releasing accounted reserve never worsens the numerical safety
bound. It may, however, invalidate the real-world environmental budget
unless independently certified. -/
theorem discharged_reserve_preserves_modeled_health
    (g base threshold : Nat) (s : Reserved) (quantity : Nat)
    (h : Healthy g base threshold s) :
    Healthy g base threshold (dischargeReserve s quantity) := by
  obtain ⟨hInvariant, hRoom⟩ := h
  constructor
  · exact hInvariant
  · change totalPhysical s.plant +
      (s.remainingExternal - quantity) ≤ threshold
    omega

/-- A successful discharge AND a valid subsequently certified trace
preserve forward safety. The future certificate is substantive: without
it, the release would merely suppress a bookkeeping allowance. -/
theorem certified_release_and_run
    (g base threshold : Nat) (s : Reserved)
    (quantity : Nat) (events : List Event)
    (h : Healthy g base threshold s)
    (hRelease : quantity ≤ s.remainingExternal)
    (hFuture : TraceFits g threshold
      (dischargeReserve s quantity) events) :
    Healthy g base threshold
      (guardedRun g threshold
        (dischargeReserve s quantity) events) := by
  exact healthy_guarded_run events g base threshold _
    (discharged_reserve_preserves_modeled_health
      g base threshold s quantity h) hFuture

/-- A permanently insufficient prospective permit simply leaves
the source-level actuator state unchanged at each delivery attempt.
This is a proof for ALL finite retry counts, not just one refusal. -/
theorem refused_delivery_stutters_forever
    (g threshold : Nat) (s : Reserved)
    (hDenied : guardedStep g threshold s .deliver = s) :
    ∀ n : Nat,
      guardedRun g threshold s (List.replicate n Event.deliver) = s := by
  intro n
  induction n with
  | zero => rfl
  | succ n ih =>
      change guardedRun g threshold
        (guardedStep g threshold s .deliver)
        (List.replicate n Event.deliver) = s
      rw [hDenied]
      exact ih

/-- For an external effect that fits its remaining reserve, spending
a budgeted environmental effect transfers allowance into the modeled
physical register but does NOT increase total free headroom. -/
theorem environmental_spend_preserves_reserved_total
    (g threshold : Nat) (s : Reserved) (n : Nat)
    (h : n ≤ s.remainingExternal) :
    totalPhysical
      (guardedStep g threshold s (.environmental n)).plant +
      (guardedStep g threshold s (.environmental n)).remainingExternal =
    totalPhysical s.plant + s.remainingExternal := by
  have hEffect := represented_external_total g s.plant n
    (.environmental n) (Or.inl rfl)
  change totalPhysical (IRNineRouteMediation.step g s.plant
      (.environmental n)) + (s.remainingExternal - n) =
    totalPhysical s.plant + s.remainingExternal
  rw [hEffect]
  omega

/-- Concrete synthetic witness: one outstanding fresh-generation
effect of size 1, physical threshold 1, and fully reserved possible
external harm of size 1. The controller is correctly SAFE but cannot
provide the pending one-step service, however many times it retries. -/
def freshPending : IRPostHoldInjection.Audited :=
  { core := { durableFloor := 0,
              live := { floor := 0, pending := [(1,1)], landed := 0 } },
    revokedLanded := 0 }

def blocked : Reserved := seedReserved freshPending 0 1

theorem blocked_is_healthy :
    Healthy 0 0 1 blocked := by
  exact seeded_healthy freshPending 0 1 1 (by decide)

theorem blocked_delivery_is_refused :
    guardedStep 0 1 blocked .deliver = blocked := by
  rfl

theorem blocked_service_for_every_finite_retry :
    ∀ n : Nat,
      (guardedRun 0 1 blocked
        (List.replicate n Event.deliver)).plant.device.core.live.landed = 0 := by
  intro n
  rw [refused_delivery_stutters_forever 0 1 blocked
    blocked_delivery_is_refused n]
  rfl

/-- An independently certified removal of the unused external
allowance can allow the SAME original source-level pending effect to
land, without altering the revoked-generation floor. -/
theorem discharged_reserve_allows_fresh_delivery :
    (guardedStep 0 1
      (dischargeReserve blocked 1) .deliver).plant.device.core.live.landed = 1 := by
  decide

theorem discharged_service_still_numerically_safe :
    totalPhysical
      (guardedStep 0 1 (dischargeReserve blocked 1) .deliver).plant ≤ 1 := by
  exact prospective_guarded_final_safety
    freshPending 0 0 1 [Event.deliver]
    (by decide)
    (by simp [TraceFits, ExternalFits, seedReserved])

/-- A release is UNSOUND if physical future exposure was never ruled
out. The same fresh work can land, followed by a bypass that breaches
the threshold; this trace lacks the needed external-effect certificate. -/
theorem release_without_external_certificate_can_breach :
    totalPhysical
      (guardedStep 0 1
        (guardedStep 0 1 (dischargeReserve blocked 1) .deliver)
        (.bypass 1)).plant > 1 := by
  decide

#print axioms discharged_reserve_preserves_modeled_health
#print axioms certified_release_and_run
#print axioms refused_delivery_stutters_forever
#print axioms environmental_spend_preserves_reserved_total
#print axioms blocked_is_healthy
#print axioms blocked_delivery_is_refused
#print axioms blocked_service_for_every_finite_retry
#print axioms discharged_reserve_allows_fresh_delivery
#print axioms discharged_service_still_numerically_safe
#print axioms release_without_external_certificate_can_breach
end PhysicalBridges.IRReserveReleaseLiveness
