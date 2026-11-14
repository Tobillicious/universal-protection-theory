import Snuffy.G2FaithfulService

/-!
# G2 execution-wide queue safety

A finite sequence of faithful service attempts never silently loses
an unready head: each transition is either an unchanged machine or
the exact original R17-A drain operation. This is a structural
safety result, not eventual service or physical enactment.
Proof candidate; independent Lean compilation pending.
-/

namespace Snuffy.G2ServiceRun

/-- Every faithful-service step either leaves the machine unchanged
or performs exactly the original R17-A drain. -/
theorem step_is_hold_or_original_drain
    (registry : UPTR17A.Registry) (s : UPTR17A.Machine) :
    Snuffy.G2FaithfulService.drainOrRetain registry s = s ∨
    Snuffy.G2FaithfulService.drainOrRetain registry s =
      UPTR17A.drainOne registry s := by
  classical
  cases hq : s.pending with
  | nil =>
    left
    exact Snuffy.G2FaithfulService.empty_queue_stays registry s hq
  | cons request rest =>
    rcases request with ⟨ticket, eff⟩
    cases hr : registry ticket with
    | none =>
      left
      exact Snuffy.G2FaithfulService.missing_grant_retains
        registry s ticket eff rest hq hr
    | some p =>
      by_cases hready : UPTR17A.Ready
          {s with pending := rest} ticket eff p
      · right
        rw [Snuffy.G2FaithfulService.ready_uses_original_application
          registry s ticket eff rest p hq hr hready]
        simp [UPTR17A.drainOne, hq]
      · left
        exact Snuffy.G2FaithfulService.unready_retains
          registry s ticket eff rest p hq hr hready

/-- Iterated service attempts. The registry is immutable within the run. -/
noncomputable def serviceRun (registry : UPTR17A.Registry)
    (s : UPTR17A.Machine) : Nat → UPTR17A.Machine
  | 0 => s
  | n + 1 => Snuffy.G2FaithfulService.drainOrRetain registry
      (serviceRun registry s n)

/-- At every finite stage, the next service step is either a genuine
unchanged hold or the original authorized drain transition. -/
theorem every_service_step_is_hold_or_drain
    (registry : UPTR17A.Registry) (s : UPTR17A.Machine) (n : Nat) :
    serviceRun registry s (n + 1) = serviceRun registry s n ∨
    serviceRun registry s (n + 1) =
      UPTR17A.drainOne registry (serviceRun registry s n) := by
  exact step_is_hold_or_original_drain registry (serviceRun registry s n)

end Snuffy.G2ServiceRun
