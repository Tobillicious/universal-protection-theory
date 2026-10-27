/-
IR-34: crash/restart must not resurrect invalid old physical-effect tokens.
The authoritative generation floor is DURABLY raised before hold is
acknowledged, and recovery restores it without rollback. Otherwise a
seemingly correct check-at-final-apply fence can fail after power loss.

This is a synthetic protocol proof, not evidence for real storage
durability, ordering, or distributed failover.
-/
import PhysicalBridges.IRFinalApplyFence

namespace PhysicalBridges.IRDurableEpoch

structure Persisted where
  durableFloor : Nat
  live : IRFinalApplyFence.Machine

/-- The idealized hold atomically raises both the durable authority
and the currently enforced actuator floor. -/
def commitHold (s : Persisted) (g : Nat) : Persisted :=
  { durableFloor := max s.durableFloor (g + 1),
    live := IRFinalApplyFence.hold s.live g }

/-- Recovery reconstructs the enforcement floor from durable authority.
Whether actual hardware honors this ordering remains a premise. -/
def restart (s : Persisted) : Persisted :=
  { s with live := { s.live with floor := s.durableFloor } }

def deliver (s : Persisted) : Persisted :=
  { s with live := IRFinalApplyFence.deliver s.live }

inductive Cmd
  | commitHold (g : Nat)
  | restart
  | deliver

def step (s : Persisted) : Cmd → Persisted
  | .commitHold g => commitHold s g
  | .restart => restart s
  | .deliver => deliver s

def run (s : Persisted) (cmds : List Cmd) : Persisted :=
  cmds.foldl step s

/-- The durable and live floor both reject every already queued effect,
whose credential generation is at most g. -/
def Protected (s : Persisted) (g : Nat) : Prop :=
  g + 1 ≤ s.durableFloor ∧
  g + 1 ≤ s.live.floor ∧
  IRFinalApplyFence.OldOnly s.live g

theorem committed_hold_is_protected
    (s : Persisted) (g : Nat)
    (hOld : IRFinalApplyFence.OldOnly s.live g) :
    Protected (commitHold s g) g := by
  constructor
  · change g + 1 ≤ max s.durableFloor (g + 1)
    exact Nat.le_max_right _ _
  constructor
  · change g + 1 ≤ max s.live.floor (g + 1)
    exact Nat.le_max_right _ _
  · simpa [Protected, commitHold, IRFinalApplyFence.hold,
      IRFinalApplyFence.OldOnly] using hOld

/-- Each later hold, recovery, or delivery maintains the raised floor.
Deliveries cannot land any previously queued old-generation effect. -/
theorem protected_step (s : Persisted) (g : Nat) (cmd : Cmd)
    (h : Protected s g) :
    Protected (step s cmd) g ∧
      (step s cmd).live.landed = s.live.landed := by
  obtain ⟨hDurable, hLive, hOld⟩ := h
  cases cmd with
  | commitHold next =>
      constructor
      · constructor
        · change g + 1 ≤ max s.durableFloor (next + 1)
          exact Nat.le_trans hDurable (Nat.le_max_left _ _)
        constructor
        · change g + 1 ≤ max s.live.floor (next + 1)
          exact Nat.le_trans hLive (Nat.le_max_left _ _)
        · simpa [step, commitHold, IRFinalApplyFence.hold,
            IRFinalApplyFence.OldOnly] using hOld
      · rfl
  | restart =>
      constructor
      · exact ⟨hDurable, hDurable, by
          simpa [step, restart, IRFinalApplyFence.OldOnly] using hOld⟩
      · rfl
  | deliver =>
      obtain ⟨hEffect, hRemaining, hFloor⟩ :=
        IRFinalApplyFence.rejected_old_delivery s.live g hLive hOld
      constructor
      · exact ⟨hDurable, hFloor, hRemaining⟩
      · exact hEffect

/-- Safety survives EVERY finite mixture of restarts, later raises and
old-effect delivery attempts. The model does not admit fresh dispatch. -/
theorem protected_under_any_finite_restarts :
    ∀ cmds (s : Persisted) (g : Nat),
      Protected s g →
      Protected (run s cmds) g ∧
      (run s cmds).live.landed = s.live.landed := by
  intro cmds
  induction cmds with
  | nil =>
      intro s g h
      exact ⟨h, rfl⟩
  | cons cmd rest ih =>
      intro s g h
      obtain ⟨hNext, hEffect⟩ := protected_step s g cmd h
      obtain ⟨hLast, hAfter⟩ := ih (step s cmd) g hNext
      refine ⟨hLast, ?_⟩
      calc
        (run s (cmd :: rest)).live.landed = (run (step s cmd) rest).live.landed := rfl
        _ = (step s cmd).live.landed := hAfter
        _ = s.live.landed := hEffect

theorem committed_hold_prevents_old_effects_despite_restarts
    (s : Persisted) (g : Nat) (cmds : List Cmd)
    (hOld : IRFinalApplyFence.OldOnly s.live g) :
    (run (commitHold s g) cmds).live.landed = s.live.landed := by
  have hs := committed_hold_is_protected s g hOld
  exact (protected_under_any_finite_restarts cmds (commitHold s g) g hs).2

/-- Wrong alternative: update the volatile actuator generation, but
not its durable counterpart. Restart reverts the floor and revalidates
an old queued physical effect. -/
def volatileOnlyHold (s : Persisted) (g : Nat) : Persisted :=
  { s with live := IRFinalApplyFence.hold s.live g }

theorem volatile_only_hold_fails_after_restart :
    ∃ s : Persisted,
      (volatileOnlyHold s 0).live.floor = 1 ∧
      s.live.landed < (deliver (restart (volatileOnlyHold s 0))).live.landed := by
  refine ⟨⟨0, ⟨0, [(0, 1)], 0⟩⟩, rfl, ?_⟩
  change 0 < 1
  exact Nat.zero_lt_one

#print axioms committed_hold_is_protected
#print axioms protected_step
#print axioms protected_under_any_finite_restarts
#print axioms committed_hold_prevents_old_effects_despite_restarts
#print axioms volatile_only_hold_fails_after_restart
end PhysicalBridges.IRDurableEpoch
