import Snuffy.G2ServiceRun

/-!
# G2: derived one-step progress for a ready queue head

This theorem does NOT assume a delivery certificate. It derives
actual append in the next service-run state from the unchanged
R17-A Ready predicate and registry binding. Fair scheduling,
clock advancement and eventual readiness remain independent
obligations; no physical realization is asserted.
-/

namespace Snuffy.G2DerivedProgress

/-- A ready head is delivered at the next concrete service step.
The conclusion is about the actual iterated service state. -/
theorem ready_head_delivered_next
    (registry : UPTR17A.Registry) (initial : UPTR17A.Machine)
    (n ticket : Nat) (eff : UPTR12A.Effect)
    (rest : List (Nat × UPTR12A.Effect)) (p : UPTR17A.Contract)
    (hhead : (Snuffy.G2ServiceRun.serviceRun registry initial n).pending =
      (ticket, eff) :: rest)
    (hreg : registry ticket = some p)
    (hready : UPTR17A.Ready
      {(Snuffy.G2ServiceRun.serviceRun registry initial n) with
        pending := rest} ticket eff p) :
    (Snuffy.G2ServiceRun.serviceRun registry initial (n + 1)).applied =
      (Snuffy.G2ServiceRun.serviceRun registry initial n).applied ++
        [(ticket, eff)] := by
  classical
  let s := Snuffy.G2ServiceRun.serviceRun registry initial n
  change (Snuffy.G2FaithfulService.drainOrRetain registry s).applied =
    s.applied ++ [(ticket, eff)]
  rw [Snuffy.G2FaithfulService.ready_uses_original_application
    registry s ticket eff rest p hhead hreg hready]
  simp [UPTR17A.applyOne, hreg, hready]

/-- A ready head's delivery is observable in the next applied trace,
not just a hypothetical application. -/
theorem ready_head_in_next_trace
    (registry : UPTR17A.Registry) (initial : UPTR17A.Machine)
    (n ticket : Nat) (eff : UPTR12A.Effect)
    (rest : List (Nat × UPTR12A.Effect)) (p : UPTR17A.Contract)
    (hhead : (Snuffy.G2ServiceRun.serviceRun registry initial n).pending =
      (ticket, eff) :: rest)
    (hreg : registry ticket = some p)
    (hready : UPTR17A.Ready
      {(Snuffy.G2ServiceRun.serviceRun registry initial n) with
        pending := rest} ticket eff p) :
    (ticket, eff) ∈
      (Snuffy.G2ServiceRun.serviceRun registry initial (n + 1)).applied := by
  rw [ready_head_delivered_next registry initial n ticket eff rest p
    hhead hreg hready]
  simp

end Snuffy.G2DerivedProgress
