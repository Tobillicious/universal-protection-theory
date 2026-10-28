/-
IR-91 — original A1 T3.3 source controller retirement/finality.

Recovered A1-REGISTER.md T3.3: terminated controller and no locks
before release. Strengthened using the already exposed IR-32/33
quiescence boundary: ALSO require no pending or in-flight effects and
a positive independent HANDOFF receipt before releasing custody.

"Controller termination" is NOT termination of a living particular.
A retiring supervisory device must not strand protected histories.
The handoff receipt is a source Boolean, not physical authentication.

The source has an absorbing *retired controller* state, not an
absorbing protected subject state; its disabled future source
effects do not automatically imply physical effects cannot occur.

We prove full retirement permission soundness, arbitrary finite
trace release safety and model finality; weak-release controls
show why locks alone do not bound in-flight effect consequences.
-/
import PhysicalBridges.IRA1Delegation
import PhysicalBridges.IRInFlightQuiescence

namespace PhysicalBridges.IRA1Retirement

structure ControllerState where
  controllerTerminated : Bool
  heldLocks : Nat
  pendingEffects : Nat
  inFlightEffects : Nat
  handoffAcknowledged : Bool
  custodyReleased : Bool
deriving Repr, DecidableEq

def ReleaseReady (s : ControllerState) : Prop :=
  s.controllerTerminated = true ∧
  s.heldLocks = 0 ∧
  s.pendingEffects = 0 ∧
  s.inFlightEffects = 0 ∧
  s.handoffAcknowledged = true

def releasePermit (s : ControllerState) : Bool :=
  decide (ReleaseReady s)

instance (s : ControllerState) : Decidable (ReleaseReady s) := by
  unfold ReleaseReady
  infer_instance

theorem release_permit_sound
    (s : ControllerState) (h : releasePermit s = true) :
    ReleaseReady s := by
  exact decide_eq_true_eq.mp (by simpa [releasePermit] using h)

/-- Event types are source controller lifecycle transitions.
External handoff "recorded" here is not assumed to prove an actual
recipient is present, aware or able to continue the same history. -/
inductive Event
  | terminateController
  | unlockOne
  | drainPending
  | drainInFlight
  | recordHandoff
  | releaseCustody

def step (s : ControllerState) (e : Event) : ControllerState :=
  if s.custodyReleased then s
  else
    match e with
    | .terminateController =>
        { s with controllerTerminated := true }
    | .unlockOne =>
        { s with heldLocks := s.heldLocks - 1 }
    | .drainPending =>
        { s with pendingEffects := 0 }
    | .drainInFlight =>
        { s with inFlightEffects := 0 }
    | .recordHandoff =>
        { s with handoffAcknowledged := true }
    | .releaseCustody =>
        if releasePermit s then
          { s with custodyReleased := true }
        else s

/-- The substantive boundary obligation: once custody has been
released, the controller was terminated, had no held locks,
and reported no in-flight/pending effects, and had recorded handoff.
The source no longer allows mutating these fields AFTER release. -/
def ReleaseSafe (s : ControllerState) : Prop :=
  s.custodyReleased = true → ReleaseReady s

theorem released_controller_is_source_absorbing
    (s : ControllerState) (e : Event)
    (h : s.custodyReleased = true) :
    step s e = s := by
  simp [step,h]

theorem denied_release_keeps_custody
    (s : ControllerState)
    (h : releasePermit s = false)
    (hHeld : s.custodyReleased = false) :
    step s .releaseCustody = s := by
  simp [step,h,hHeld]

theorem authorized_release_satisfies_full_finality
    (s : ControllerState)
    (h : s.custodyReleased = false)
    (hPermit : releasePermit s = true) :
    ReleaseSafe (step s .releaseCustody) := by
  have hReady := release_permit_sound s hPermit
  simpa [ReleaseSafe,step,h,hPermit,ReleaseReady] using hReady

theorem one_lifecycle_step_preserves_release_safety
    (s : ControllerState) (e : Event)
    (h : ReleaseSafe s) :
    ReleaseSafe (step s e) := by
  by_cases hr : s.custodyReleased = true
  · simpa [released_controller_is_source_absorbing s e hr] using h
  · have hrf : s.custodyReleased = false := by
      cases he : s.custodyReleased <;> simp_all
    cases e with
    | terminateController =>
        simp [ReleaseSafe,step,hrf]
    | unlockOne =>
        simp [ReleaseSafe,step,hrf]
    | drainPending =>
        simp [ReleaseSafe,step,hrf]
    | drainInFlight =>
        simp [ReleaseSafe,step,hrf]
    | recordHandoff =>
        simp [ReleaseSafe,step,hrf]
    | releaseCustody =>
        by_cases hp : releasePermit s = true
        · exact authorized_release_satisfies_full_finality s hrf hp
        · have hf : releasePermit s = false := by
            cases hEval : releasePermit s <;> simp_all
          simpa [denied_release_keeps_custody s hf hrf] using h

def run (s : ControllerState) (events : List Event) : ControllerState :=
  events.foldl step s

theorem arbitrary_finite_retirement_lifecycle_is_safe
    (s : ControllerState) (events : List Event)
    (h : ReleaseSafe s) :
    ReleaseSafe (run s events) := by
  induction events generalizing s with
  | nil => exact h
  | cons event rest ih =>
      change ReleaseSafe (run (step s event) rest)
      exact ih (step s event)
        (one_lifecycle_step_preserves_release_safety s event h)

def weakRelease (s : ControllerState) : ControllerState :=
  if s.controllerTerminated && decide (s.heldLocks = 0) then
    { s with custodyReleased := true }
  else s

/-- Controller terminated + no LOCKS is not enough: pending
and in-flight effects can still land, and nobody may have accepted
continuing custody of the protected history. -/
theorem weak_retirement_ignores_inflight_effects_and_handoff :
    ∃ s : ControllerState,
      s.controllerTerminated = true ∧ s.heldLocks = 0 ∧
      (weakRelease s).custodyReleased = true ∧
      ¬ ReleaseSafe (weakRelease s) := by
  refine ⟨{
    controllerTerminated := true,
    heldLocks := 0,
    pendingEffects := 0,
    inFlightEffects := 1,
    handoffAcknowledged := false,
    custodyReleased := false
  }, by decide, rfl, by decide, ?_⟩
  intro h
  have hUnsafe := h (by decide)
  have hFlight := hUnsafe.2.2.2.1
  norm_num at hFlight

def emptyReadyController : ControllerState :=
  ⟨false,0,0,0,false,false⟩

theorem model_retirement_requires_handoff_and_termination :
    (step emptyReadyController .releaseCustody).custodyReleased = false ∧
    (run emptyReadyController
      [.terminateController,.recordHandoff,.releaseCustody]).custodyReleased =
        true := by
  decide

#print axioms release_permit_sound
#print axioms released_controller_is_source_absorbing
#print axioms denied_release_keeps_custody
#print axioms authorized_release_satisfies_full_finality
#print axioms one_lifecycle_step_preserves_release_safety
#print axioms arbitrary_finite_retirement_lifecycle_is_safe
#print axioms weak_retirement_ignores_inflight_effects_and_handoff
#print axioms model_retirement_requires_handoff_and_termination

end PhysicalBridges.IRA1Retirement
