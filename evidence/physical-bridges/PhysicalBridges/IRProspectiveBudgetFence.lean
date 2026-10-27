/-
IR-61: prospective effect authorization under a reserved exogenous budget.

This consumes the exact synthetic nine-route IR-60 model and actual
IR-59 source-level delivered-effect operation. Controllable delivery
must pass a BEFORE-delivery margin test. Environmental, latent and
bypass effects are NOT assumed controllable: safety is conditional on
an externally established bound, represented as remaining reserve.

This is not hardware verification, not a measured physical reserve,
not a proof of complete event coverage, and not original X3.
-/
import PhysicalBridges.IRNineRouteMediation

namespace PhysicalBridges.IRProspectiveBudgetFence

open IRNineRouteMediation

structure Reserved where
  plant : IRNineRouteMediation.Plant
  remainingExternal : Nat

/-- External effects are not blocked by our actuator. This is a
separate physical *admissibility* condition on their magnitude.
For all other operational events no external allowance is consumed. -/
def ExternalFits (s : Reserved) : Event → Prop
  | .environmental n => n ≤ s.remainingExternal
  | .latent n => n ≤ s.remainingExternal
  | .bypass n => n ≤ s.remainingExternal
  | _ => True

/-- The physical landing operation is the exact inherited IR-59
operation. Only .deliver is permit-gated; a denied delivery leaves
pending work pending. The bypass route is never silently rejected. -/
def guardedStep (g threshold : Nat) (s : Reserved) : Event → Reserved
  | .deliver =>
      if totalPhysical s.plant +
          IRPostHoldInjection.freshImpact g s.plant.device.core +
          s.remainingExternal ≤ threshold then
        { s with plant := IRNineRouteMediation.step g s.plant .deliver }
      else s
  | .environmental n =>
      { plant := IRNineRouteMediation.step g s.plant (.environmental n),
        remainingExternal := s.remainingExternal - n }
  | .latent n =>
      { plant := IRNineRouteMediation.step g s.plant (.latent n),
        remainingExternal := s.remainingExternal - n }
  | .bypass n =>
      { plant := IRNineRouteMediation.step g s.plant (.bypass n),
        remainingExternal := s.remainingExternal - n }
  | e => { s with plant := IRNineRouteMediation.step g s.plant e }

def guardedRun (g threshold : Nat)
    (s : Reserved) (events : List Event) : Reserved :=
  events.foldl (guardedStep g threshold) s

def Healthy (g base threshold : Nat) (s : Reserved) : Prop :=
  Invariant g base s.plant ∧
  totalPhysical s.plant + s.remainingExternal ≤ threshold

/-- Each represented exogenous physical channel adds its claimed
nonnegative charge. This equality is a theorem of the closed model,
not a new assumption about the actual world. -/
theorem represented_external_total
    (g : Nat) (s : Plant) (n : Nat)
    (e : Event)
    (h : e = .environmental n ∨
      e = .latent n ∨ e = .bypass n) :
    totalPhysical (IRNineRouteMediation.step g s e) =
      totalPhysical s + n := by
  rcases h with h | h | h
  · subst e
    simp only [totalPhysical, IRNineRouteMediation.step]
    omega
  · subst e
    simp only [totalPhysical, IRNineRouteMediation.step]
    omega
  · subst e
    simp only [totalPhysical, IRNineRouteMediation.step]
    omega

/-- The represented actuator final landing can only add the fresh
component after a valid durable generation floor; no post-hoc effect
oracle is used in the permission inequality. -/
theorem guarded_delivery_total
    (g base : Nat) (s : Plant)
    (h : Invariant g base s) :
    totalPhysical (IRNineRouteMediation.step g s .deliver) =
      totalPhysical s +
        IRPostHoldInjection.freshImpact g s.device.core := by
  have hp := h.1.2
  have hs := IRPostHoldInjection.protected_source_delivery_is_fresh_only
    s.device.core g hp
  change (IRDurableEpoch.deliver s.device.core).live.landed +
      s.sidePhysical =
    (s.device.core.live.landed + s.sidePhysical) +
      IRPostHoldInjection.freshImpact g s.device.core
  rw [hs]
  omega

/-- Prospective one-step safety: no final outcome budget as premise.
Before each guarded delivery, the modeled actuator checks its pending
impact against CURRENT physical total plus remaining external reserve.
External channels must individually fit the remaining reserve.
Their effects are not physically blocked by this function. -/
theorem healthy_guarded_step
    (g base threshold : Nat) (s : Reserved) (e : Event)
    (healthy : Healthy g base threshold s)
    (fits : ExternalFits s e) :
    Healthy g base threshold (guardedStep g threshold s e) := by
  obtain ⟨hInvariant, hRoom⟩ := healthy
  cases e with
  | hold next =>
      refine ⟨nine_constructor_invariant_step g base s.plant (.hold next) hInvariant,
        ?_⟩
      change totalPhysical s.plant + s.remainingExternal ≤ threshold
      exact hRoom
  | restart =>
      refine ⟨nine_constructor_invariant_step g base s.plant .restart hInvariant,
        ?_⟩
      change totalPhysical s.plant + s.remainingExternal ≤ threshold
      exact hRoom
  | inject token impact =>
      refine ⟨nine_constructor_invariant_step g base s.plant
          (.inject token impact) hInvariant, ?_⟩
      change totalPhysical s.plant + s.remainingExternal ≤ threshold
      exact hRoom
  | deliver =>
      by_cases permitted :
          totalPhysical s.plant +
            IRPostHoldInjection.freshImpact g s.plant.device.core +
            s.remainingExternal ≤ threshold
      · have hDeliver := nine_constructor_invariant_step
          g base s.plant .deliver hInvariant
        have hTotal := guarded_delivery_total g base s.plant hInvariant
        simp only [guardedStep, if_pos permitted]
        refine ⟨hDeliver, ?_⟩
        rw [hTotal]
        exact permitted
      · simp [guardedStep, permitted, Healthy, hInvariant, hRoom]
  | sample value =>
      refine ⟨nine_constructor_invariant_step g base s.plant
          (.sample value) hInvariant, ?_⟩
      change totalPhysical s.plant + s.remainingExternal ≤ threshold
      exact hRoom
  | tick =>
      refine ⟨nine_constructor_invariant_step g base s.plant
          .tick hInvariant, ?_⟩
      change totalPhysical s.plant + s.remainingExternal ≤ threshold
      exact hRoom
  | environmental n =>
      have hn : n ≤ s.remainingExternal := fits
      have he : totalPhysical (IRNineRouteMediation.step g s.plant
          (.environmental n)) = totalPhysical s.plant + n :=
        represented_external_total g s.plant n (.environmental n) (Or.inl rfl)
      refine ⟨nine_constructor_invariant_step g base s.plant
          (.environmental n) hInvariant, ?_⟩
      change totalPhysical (IRNineRouteMediation.step g s.plant
        (.environmental n)) + (s.remainingExternal - n) ≤ threshold
      rw [he]
      omega
  | latent n =>
      have hn : n ≤ s.remainingExternal := fits
      have he : totalPhysical (IRNineRouteMediation.step g s.plant
          (.latent n)) = totalPhysical s.plant + n :=
        represented_external_total g s.plant n (.latent n)
          (Or.inr (Or.inl rfl))
      refine ⟨nine_constructor_invariant_step g base s.plant
          (.latent n) hInvariant, ?_⟩
      change totalPhysical (IRNineRouteMediation.step g s.plant
        (.latent n)) + (s.remainingExternal - n) ≤ threshold
      rw [he]
      omega
  | bypass n =>
      have hn : n ≤ s.remainingExternal := fits
      have he : totalPhysical (IRNineRouteMediation.step g s.plant
          (.bypass n)) = totalPhysical s.plant + n :=
        represented_external_total g s.plant n (.bypass n)
          (Or.inr (Or.inr rfl))
      refine ⟨nine_constructor_invariant_step g base s.plant
          (.bypass n) hInvariant, ?_⟩
      change totalPhysical (IRNineRouteMediation.step g s.plant
        (.bypass n)) + (s.remainingExternal - n) ≤ threshold
      rw [he]
      omega

/-- Recursive path-wise external-budget obligation. It must hold
at each state reached by prior guarded events; this is not a claim
that a real physical environment respects the reserve. -/
def TraceFits (g threshold : Nat) :
    Reserved → List Event → Prop
  | _, [] => True
  | s, e :: rest =>
      ExternalFits s e ∧
        TraceFits g threshold (guardedStep g threshold s e) rest

/-- For ANY finite certified trace, the safety envelope is preserved
without needing the unknown FINAL fresh-effect total as a premise. -/
theorem healthy_guarded_run :
    ∀ (events : List Event) (g base threshold : Nat) (s : Reserved),
      Healthy g base threshold s →
      TraceFits g threshold s events →
      Healthy g base threshold (guardedRun g threshold s events) := by
  intro events
  induction events with
  | nil =>
      intro g base threshold s h _
      exact h
  | cons e rest ih =>
      intro g base threshold s h hFit
      exact ih g base threshold (guardedStep g threshold s e)
        (healthy_guarded_step g base threshold s e h hFit.1)
        hFit.2

def seedReserved
    (a : IRPostHoldInjection.Audited)
    (g externalReserve : Nat) : Reserved :=
  { plant := IRNineRouteMediation.seedPlant a g,
    remainingExternal := externalReserve }

theorem seeded_healthy
    (a : IRPostHoldInjection.Audited)
    (g reserve threshold : Nat)
    (hStart : a.core.live.landed + reserve ≤ threshold) :
    Healthy g a.core.live.landed threshold
      (seedReserved a g reserve) := by
  refine ⟨IRNineRouteMediation.initialized_invariant a g, ?_⟩
  change (a.core.live.landed + 0) + reserve ≤ threshold
  omega

theorem prospective_guarded_final_safety
    (a : IRPostHoldInjection.Audited)
    (g reserve threshold : Nat) (events : List Event)
    (hStart : a.core.live.landed + reserve ≤ threshold)
    (hExternal : TraceFits g threshold
      (seedReserved a g reserve) events) :
    totalPhysical (guardedRun g threshold
      (seedReserved a g reserve) events).plant ≤ threshold := by
  have h := healthy_guarded_run events g a.core.live.landed threshold
    (seedReserved a g reserve)
    (seeded_healthy a g reserve threshold hStart) hExternal
  exact Nat.le_trans (Nat.le_add_right _ _) h.2

/-- A fresh-credential injection exceeding the prospective physical
margin is DENIED at the actual modeled delivery operation. -/
theorem overbudget_fresh_delivery_is_refused :
    ∃ a : IRPostHoldInjection.Audited,
      (guardedRun 0 1 (seedReserved a 0 0)
        [.inject 1 2, .deliver]).plant.device.core.live.landed = 0 := by
  refine ⟨{
    core := { durableFloor := 0,
              live := { floor := 0, pending := [], landed := 0 } },
    revokedLanded := 0 }, ?_⟩
  decide

/-- No amount of actuator-side prospectivity prevents a bypass whose
actual effect violates the claimed exogenous allowance. An omitted
physical-channel cap remains a genuine countermodel. -/
theorem unbounded_bypass_violates_uncertified_reserve :
    ∃ a : IRPostHoldInjection.Audited,
      ¬ TraceFits 0 1 (seedReserved a 0 0) [.bypass 2] ∧
      totalPhysical (guardedRun 0 1
        (seedReserved a 0 0) [.bypass 2]).plant > 1 := by
  refine ⟨{
    core := { durableFloor := 0,
              live := { floor := 0, pending := [], landed := 0 } },
    revokedLanded := 0 }, ?_⟩
  decide

#print axioms represented_external_total
#print axioms guarded_delivery_total
#print axioms healthy_guarded_step
#print axioms healthy_guarded_run
#print axioms seeded_healthy
#print axioms prospective_guarded_final_safety
#print axioms overbudget_fresh_delivery_is_refused
#print axioms unbounded_bypass_violates_uncertified_reserve
end PhysicalBridges.IRProspectiveBudgetFence
