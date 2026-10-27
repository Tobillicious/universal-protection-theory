/-
IR-36: device-local final effect fencing does NOT imply fleet-wide fencing
unless every actuator and its independent restart history is covered.
This synthetic finite-list composition imports the unchanged IR-34
durable-epoch source and does not assume physically complete enumeration.
-/
import PhysicalBridges.IRDurableEpoch

namespace PhysicalBridges.IRDistributedEpoch

/-- One device and its own later crash/restart/delivery event sequence. -/
abbrev DeviceRun :=
  PhysicalBridges.IRDurableEpoch.Persisted ×
    List PhysicalBridges.IRDurableEpoch.Cmd

def beforeTotal (devices : List DeviceRun) : Nat :=
  (devices.map (fun p => p.1.live.landed)).sum

def afterTotal (devices : List DeviceRun) : Nat :=
  (devices.map (fun p =>
    (PhysicalBridges.IRDurableEpoch.run p.1 p.2).live.landed)).sum

def AllProtected (devices : List DeviceRun) (g : Nat) : Prop :=
  ∀ p, p ∈ devices → PhysicalBridges.IRDurableEpoch.Protected p.1 g

/-- A fleet already protected at each actuator keeps the sum of its
landed effects invariant through all of those actuator-local histories.
Proof is structural induction over the actual list of devices. -/
theorem protected_fleet_no_old_effects :
    ∀ (devices : List DeviceRun) (g : Nat),
      AllProtected devices g →
      afterTotal devices = beforeTotal devices := by
  intro devices
  induction devices with
  | nil =>
      intro g _
      rfl
  | cons p rest ih =>
      intro g all
      have hp : PhysicalBridges.IRDurableEpoch.Protected p.1 g :=
        all p (by simp)
      have ht : AllProtected rest g := by
        intro x hx
        exact all x (by simp [hx])
      have hHead :=
        (PhysicalBridges.IRDurableEpoch.protected_under_any_finite_restarts
          p.2 p.1 g hp).2
      have hTail := ih g ht
      simp only [afterTotal, beforeTotal, List.map_cons, List.sum_cons]
      rw [hHead]
      exact congrArg (fun n => p.1.live.landed + n) hTail

/-- A committed hold to EVERY represented device, with each device
known to have only old-generation queued effects, is sufficient even
when local reboot schedules differ arbitrarily. -/
theorem committed_fleet_hold_rejects_old_effects :
    ∀ (devices : List DeviceRun) (g : Nat),
      (∀ p, p ∈ devices →
        PhysicalBridges.IRFinalApplyFence.OldOnly p.1.live g) →
      (devices.map (fun p =>
        (PhysicalBridges.IRDurableEpoch.run
          (PhysicalBridges.IRDurableEpoch.commitHold p.1 g) p.2).live.landed)).sum =
      beforeTotal devices := by
  intro devices
  induction devices with
  | nil =>
      intro _ _
      rfl
  | cons p rest ih =>
      intro g old
      have hp : PhysicalBridges.IRFinalApplyFence.OldOnly p.1.live g :=
        old p (by simp)
      have ht : ∀ x, x ∈ rest →
          PhysicalBridges.IRFinalApplyFence.OldOnly x.1.live g := by
        intro x hx
        exact old x (by simp [hx])
      have hHead :=
        PhysicalBridges.IRDurableEpoch.committed_hold_prevents_old_effects_despite_restarts
          p.1 g p.2 hp
      have hTail := ih g ht
      simp only [beforeTotal, List.map_cons, List.sum_cons]
      rw [hHead]
      exact congrArg (fun n => p.1.live.landed + n) hTail

/-- Countermodel: one protected actuator does not protect its neighbour.
The neighbour's stale durable epoch can resurrect an old queued effect
on restart, despite the first device being perfectly fenced. -/
theorem one_unfenced_device_can_land :
    ∃ safeDevice staleDevice : PhysicalBridges.IRDurableEpoch.Persisted,
      (PhysicalBridges.IRDurableEpoch.deliver safeDevice).live.landed =
        safeDevice.live.landed ∧
      staleDevice.live.landed <
        (PhysicalBridges.IRDurableEpoch.deliver
          (PhysicalBridges.IRDurableEpoch.restart staleDevice)).live.landed := by
  refine ⟨⟨1, ⟨1, [(0, 1)], 0⟩⟩,
    ⟨0, ⟨1, [(0, 1)], 0⟩⟩, ?_, ?_⟩
  · rfl
  · change 0 < 1
    exact Nat.zero_lt_one

/-- A vacuous, empty fleet can satisfy a universal fleet-safety theorem.
Actual device enumeration and a meaningful protected population therefore
remain independent physical-coverage obligations. -/
theorem empty_fleet_is_vacuously_safe :
    AllProtected ([] : List DeviceRun) 0 ∧
      afterTotal ([] : List DeviceRun) = beforeTotal [] := by
  constructor
  · intro p hp
    cases hp
  · rfl

#print axioms protected_fleet_no_old_effects
#print axioms committed_fleet_hold_rejects_old_effects
#print axioms one_unfenced_device_can_land
#print axioms empty_fleet_is_vacuously_safe
end PhysicalBridges.IRDistributedEpoch
