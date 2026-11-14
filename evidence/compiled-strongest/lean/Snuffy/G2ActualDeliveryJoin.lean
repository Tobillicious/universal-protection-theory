import Snuffy.G2Freedom

/-!
# G2: actual authorized queue application on the guarded transition

Protection-first proof candidate. No existing definitions changed.
This module is not yet independently Lean-compiled. No physical
actuator correspondence or eventual queue service is claimed.
-/

namespace Snuffy.G2ActualDeliveryJoin

/-- The real R17-A queue drain, rather than an unconstrained delivery
function, is the effect-machine component of this joint transition. -/
theorem guarded_step_uses_drain
    {P C Ev Ω : Type*}
    (correct : P → P) (perturb : Ω → P → C → Ev → P)
    (registry : UPTR17A.Registry) (ω : Ω)
    (s : P × UPTR17A.Machine) (c : C) (e : Ev) :
    (Snuffy.G1Refinement.guardedStep
      (Snuffy.G2Freedom.jointCorrect correct)
      (Snuffy.G2Freedom.jointPerturb perturb
        (fun m (_ : C) (_ : Ev) => UPTR17A.drainOne registry m))
      ω s c e).2 = UPTR17A.drainOne registry s.2 := by
  rfl

/-- Authorized queue-head application occurs on the actual guarded step.
The permit is checked on the exact post-dequeue machine state. -/
theorem guarded_step_applies_ready_head
    {P C Ev Ω : Type*}
    (correct : P → P) (perturb : Ω → P → C → Ev → P)
    (registry : UPTR17A.Registry) (ω : Ω)
    (s : P × UPTR17A.Machine) (c : C) (e : Ev)
    (ticket : Nat) (eff : UPTR12A.Effect)
    (rest : List (Nat × UPTR12A.Effect))
    (contract : UPTR17A.Contract)
    (hhead : s.2.pending = (ticket, eff) :: rest)
    (hregistry : registry ticket = some contract)
    (hready : UPTR17A.Ready
      {s.2 with pending := rest} ticket eff contract) :
    (Snuffy.G1Refinement.guardedStep
      (Snuffy.G2Freedom.jointCorrect correct)
      (Snuffy.G2Freedom.jointPerturb perturb
        (fun m (_ : C) (_ : Ev) => UPTR17A.drainOne registry m))
      ω s c e).2.applied = s.2.applied ++ [(ticket, eff)] := by
  classical
  rw [guarded_step_uses_drain correct perturb registry ω s c e]
  simp [UPTR17A.drainOne, hhead, UPTR17A.applyOne,
    hregistry, hready]

end Snuffy.G2ActualDeliveryJoin
