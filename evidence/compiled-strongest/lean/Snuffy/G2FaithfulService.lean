import Snuffy.G2ActualDeliveryJoin

/-!
# G2: non-dropping authorized service

The existing R17-A drainOne removes the head even when application is
refused. This optional service wrapper retains an unready request
rather than silently discarding it. No original definition is changed.

This is a proof candidate pending Lean kernel compilation.
-/

namespace Snuffy.G2FaithfulService

/-- A pending request is not discarded merely because it is currently
unready. Once the current R17-A Ready checks hold, application uses
the unchanged original applyOne. -/
noncomputable def drainOrRetain (registry : UPTR17A.Registry)
    (s : UPTR17A.Machine) : UPTR17A.Machine := by
  classical
  exact match s.pending with
  | [] => s
  | (ticket, eff) :: rest =>
      match registry ticket with
      | none => s
      | some p =>
          if UPTR17A.Ready {s with pending := rest} ticket eff p then
            UPTR17A.applyOne registry {s with pending := rest} ticket eff
          else s

/-- An empty queue remains unchanged. -/
theorem empty_queue_stays (registry : UPTR17A.Registry)
    (s : UPTR17A.Machine) (h : s.pending = []) :
    drainOrRetain registry s = s := by
  simp [drainOrRetain, h]

/-- Missing authorization leaves the entire machine and pending
request unchanged, instead of consuming the request. -/
theorem missing_grant_retains (registry : UPTR17A.Registry)
    (s : UPTR17A.Machine) (ticket : Nat) (eff : UPTR12A.Effect)
    (rest : List (Nat × UPTR12A.Effect))
    (hhead : s.pending = (ticket, eff) :: rest)
    (hmissing : registry ticket = none) :
    drainOrRetain registry s = s := by
  simp [drainOrRetain, hhead, hmissing]

/-- Failed current authorization leaves the request available
for a later recheck; this does not claim eventual authorization. -/
theorem unready_retains (registry : UPTR17A.Registry)
    (s : UPTR17A.Machine) (ticket : Nat) (eff : UPTR12A.Effect)
    (rest : List (Nat × UPTR12A.Effect)) (p : UPTR17A.Contract)
    (hhead : s.pending = (ticket, eff) :: rest)
    (hreg : registry ticket = some p)
    (hnot : ¬ UPTR17A.Ready {s with pending := rest} ticket eff p) :
    drainOrRetain registry s = s := by
  simp [drainOrRetain, hhead, hreg, hnot]

/-- Ready service delegates to the original R17-A atomic operation. -/
theorem ready_uses_original_application
    (registry : UPTR17A.Registry)
    (s : UPTR17A.Machine) (ticket : Nat) (eff : UPTR12A.Effect)
    (rest : List (Nat × UPTR12A.Effect)) (p : UPTR17A.Contract)
    (hhead : s.pending = (ticket, eff) :: rest)
    (hreg : registry ticket = some p)
    (hready : UPTR17A.Ready {s with pending := rest} ticket eff p) :
    drainOrRetain registry s =
      UPTR17A.applyOne registry {s with pending := rest} ticket eff := by
  simp [drainOrRetain, hhead, hreg, hready]

end Snuffy.G2FaithfulService
