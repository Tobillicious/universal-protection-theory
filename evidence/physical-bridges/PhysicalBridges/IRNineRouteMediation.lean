/-
IR-60: closed nine-constructor route accounting over the actual IR-59
source-level durable epoch/landing implementation.

This is a SYNTHETIC semantics theorem. The exhaustive transition grammar
does not demonstrate completeness of the physical world, instrument
enumeration, cancellation of already irreversible effects or prevention
of new-generation/side-channel harm. It explicitly includes a bypass.
-/ 
import PhysicalBridges.IRPostHoldInjection
import PhysicalBridges.IRChannelInventory

namespace PhysicalBridges.IRNineRouteMediation

open IRPostHoldInjection

/-- The modeled operational alphabet has exactly nine constructors.
Three exogenous physical routes are represented explicitly rather than
silently treated as harmless, and the delivery route reuses the actual
source-level guarded actuator from IR-59. -/
inductive Event where
  | hold (generation : Nat)
  | restart
  | inject (token impact : Nat)
  | deliver
  | sample (value : Nat)
  | tick
  | environmental (impact : Nat)
  | latent (impact : Nat)
  | bypass (impact : Nat)
  deriving DecidableEq, Repr

structure Plant where
  device : IRPostHoldInjection.Audited
  sidePhysical : Nat
  sideAccounted : Nat
  freshRecorded : Nat
  lastSample : Nat
  clock : Nat

/-- Operational integration: four commands operate the inherited
IR-59 machine; two are observation/time bookkeeping; three add
physically consequential exogenous effects that must be budgeted.
A bypass is RECORDED in this closed model, not prevented. -/
def step (g : Nat) (s : Plant) : Event → Plant
  | .hold next =>
      { s with device := IRPostHoldInjection.step g s.device (.hold next) }
  | .restart =>
      { s with device := IRPostHoldInjection.step g s.device .restart }
  | .inject token effect =>
      { s with device := IRPostHoldInjection.step g s.device (.inject token effect) }
  | .deliver =>
      { s with
        device := IRPostHoldInjection.step g s.device .deliver
        freshRecorded := s.freshRecorded +
          IRPostHoldInjection.freshImpact g s.device.core }
  | .sample value => { s with lastSample := value }
  | .tick => { s with clock := s.clock + 1 }
  | .environmental effect =>
      { s with
        sidePhysical := s.sidePhysical + effect
        sideAccounted := s.sideAccounted +
          IRChannelInventory.charge (.environmental effect) }
  | .latent effect =>
      { s with
        sidePhysical := s.sidePhysical + effect
        sideAccounted := s.sideAccounted +
          IRChannelInventory.charge (.latent effect) }
  | .bypass effect =>
      { s with
        sidePhysical := s.sidePhysical + effect
        sideAccounted := s.sideAccounted +
          IRChannelInventory.charge (.bypass effect) }

def run (g : Nat) (s : Plant) (events : List Event) : Plant :=
  events.foldl (step g) s

/-- Joint source-level invariant: IR-59 revoked authority remains
fenced; all guarded delivered impact since the baseline is fresh;
and all explicitly represented side effects are accounted exactly.
The second and third conjuncts are not physical measurements. -/
def Invariant (g base : Nat) (s : Plant) : Prop :=
  IRPostHoldInjection.Protected s.device g ∧
  s.device.core.live.landed = base + s.freshRecorded ∧
  s.sidePhysical = s.sideAccounted

/-- Full nine-case operational proof, rather than an assumption that an
arbitrary uninterpreted transition relation is safe. -/
theorem nine_constructor_invariant_step
    (g base : Nat) (s : Plant) (e : Event)
    (h : Invariant g base s) :
    Invariant g base (step g s e) := by
  obtain ⟨hProtected, hLanded, hSide⟩ := h
  cases e with
  | hold next =>
      exact ⟨(IRPostHoldInjection.protected_step s.device g (.hold next) hProtected).1,
        hLanded, hSide⟩
  | restart =>
      exact ⟨(IRPostHoldInjection.protected_step s.device g .restart hProtected).1,
        hLanded, hSide⟩
  | inject token effect =>
      exact ⟨(IRPostHoldInjection.protected_step s.device g (.inject token effect) hProtected).1,
        hLanded, hSide⟩
  | deliver =>
      refine ⟨(IRPostHoldInjection.protected_step s.device g .deliver hProtected).1,
        ?_, hSide⟩
      have hFresh :=
        IRPostHoldInjection.protected_source_delivery_is_fresh_only
          s.device.core g hProtected.2
      change (IRDurableEpoch.deliver s.device.core).live.landed =
        base + (s.freshRecorded +
          IRPostHoldInjection.freshImpact g s.device.core)
      omega
  | sample value => exact ⟨hProtected, hLanded, hSide⟩
  | tick => exact ⟨hProtected, hLanded, hSide⟩
  | environmental effect =>
      refine ⟨hProtected, hLanded, ?_⟩
      change s.sidePhysical + effect = s.sideAccounted + effect
      omega
  | latent effect =>
      refine ⟨hProtected, hLanded, ?_⟩
      change s.sidePhysical + effect = s.sideAccounted + effect
      omega
  | bypass effect =>
      refine ⟨hProtected, hLanded, ?_⟩
      change s.sidePhysical + effect = s.sideAccounted + effect
      omega

/-- Any finite interleaving of all nine modeled transitions preserves
the exact partition. The proof depends on the closed Event grammar. -/
theorem nine_constructor_invariant_run :
    ∀ (events : List Event) (g base : Nat) (s : Plant),
      Invariant g base s →
      Invariant g base (run g s events) := by
  intro events
  induction events with
  | nil =>
      intro g base s h
      exact h
  | cons e rest ih =>
      intro g base s h
      exact ih g base (step g s e)
        (nine_constructor_invariant_step g base s e h)

/-- Commit a durable revocation using the inherited source-level IR-59
hold. Accounting starts at the original actuator landed register.
The new observation and clock values are intentionally arbitrary. -/
def seedPlant (a : IRPostHoldInjection.Audited) (g : Nat) : Plant :=
  { device := IRPostHoldInjection.step g a (.hold g)
    sidePhysical := 0
    sideAccounted := 0
    freshRecorded := 0
    lastSample := 0
    clock := 0 }

theorem initialized_invariant
    (a : IRPostHoldInjection.Audited) (g : Nat) :
    Invariant g a.core.live.landed (seedPlant a g) := by
  have hProt : IRPostHoldInjection.Protected
      (IRPostHoldInjection.step g a (.hold g)) g := by
    constructor
    · change g + 1 ≤ max a.core.durableFloor (g + 1)
      exact Nat.le_max_right _ _
    · change g + 1 ≤ max a.core.live.floor (g + 1)
      exact Nat.le_max_right _ _
  exact ⟨hProt, by simp [seedPlant, IRPostHoldInjection.step,
    IRDurableEpoch.commitHold, IRFinalApplyFence.hold], rfl⟩

/-- The synthetic total includes actual inherited modeled actuator
landings and all three typed external paths, including bypass. -/
def totalPhysical (s : Plant) : Nat :=
  s.device.core.live.landed + s.sidePhysical

/-- This is the precise closed-model route-exclusion conclusion:
replayed revoked-token effects contribute ZERO, but fresh authorized-
by-token effects and recorded external effects may contribute nonzero.
It is an exact identity, not a general zero-breach assertion. -/
theorem exact_nine_route_physical_partition
    (a : IRPostHoldInjection.Audited)
    (g : Nat) (events : List Event) :
    let finish := run g (seedPlant a g) events
    IRPostHoldInjection.Protected finish.device g ∧
    totalPhysical finish =
      a.core.live.landed + finish.freshRecorded + finish.sideAccounted := by
  have h := nine_constructor_invariant_run
    events g a.core.live.landed (seedPlant a g)
    (initialized_invariant a g)
  obtain ⟨hp, hLanded, hSide⟩ := h
  exact ⟨hp, by
    dsimp [totalPhysical]
    omega⟩

/-- The available safety claim: if the residual/fresh effect budgets
are established and the starting margin covers BOTH, the modeled
physical total cannot breach the threshold. -/
theorem nine_route_bounded_final_safety
    (a : IRPostHoldInjection.Audited)
    (g threshold : Nat) (events : List Event)
    (hMargin :
      a.core.live.landed +
        (run g (seedPlant a g) events).freshRecorded +
        (run g (seedPlant a g) events).sideAccounted ≤ threshold) :
    totalPhysical (run g (seedPlant a g) events) ≤ threshold := by
  have hExact := (exact_nine_route_physical_partition a g events).2
  omega

/-- An unbounded explicitly represented bypass defeats unconditional
zero-breach despite completely correct revocation. -/
theorem bypass_can_breach_despite_revocation :
    ∃ a : IRPostHoldInjection.Audited,
      (run 0 (seedPlant a 0) [.bypass 2]).device.revokedLanded = 0 ∧
      1 < totalPhysical (run 0 (seedPlant a 0) [.bypass 2]) := by
  refine ⟨{
    core := { durableFloor := 0,
              live := { floor := 0, pending := [], landed := 0 } },
    revokedLanded := 0 }, ?_⟩
  decide

/-- Even in the absence of an exogenous path, an unchecked NEW
generation can land a harmful effect. Revocation alone cannot
certify the authorization or safety of fresh work. -/
theorem unguarded_fresh_effect_can_breach :
    ∃ a : IRPostHoldInjection.Audited,
      (run 0 (seedPlant a 0) [.inject 1 2, .deliver]).device.revokedLanded = 0 ∧
      1 < totalPhysical
        (run 0 (seedPlant a 0) [.inject 1 2, .deliver]) := by
  refine ⟨{
    core := { durableFloor := 0,
              live := { floor := 0, pending := [], landed := 0 } },
    revokedLanded := 0 }, ?_⟩
  decide

#print axioms nine_constructor_invariant_step
#print axioms nine_constructor_invariant_run
#print axioms initialized_invariant
#print axioms exact_nine_route_physical_partition
#print axioms nine_route_bounded_final_safety
#print axioms bypass_can_breach_despite_revocation
#print axioms unguarded_fresh_effect_can_breach

end PhysicalBridges.IRNineRouteMediation
