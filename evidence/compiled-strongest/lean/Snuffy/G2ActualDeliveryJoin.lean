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


/-- The same guarded transition protects all particulars and applies
the currently authorized queue head. Assumptions are the unchanged
G1 decoder/drift budget and R17-A current Ready contract. -/
theorem guarded_step_holds_and_applies
    {X Part P Ω C Ev : Type*} [MetricSpace X]
    {rec : Part → X} {ε ρ t dmin : ℝ} {Code : Set X}
    (hrec : ∀ x, rec x ∈ Code)
    (hsep : ∀ a ∈ Code, ∀ b ∈ Code, a ≠ b → dmin ≤ dist a b)
    (ht : 2 * t < dmin)
    {dec : X → X} (hdecC : ∀ y, dec y ∈ Code)
    (hnear : ∀ y, ∀ a ∈ Code, dist y (dec y) ≤ dist y a)
    (hε : 0 ≤ ε)
    (read : P → Part → X) (correct : P → P)
    (hcorr : ∀ p x, read (correct p) x = dec (read p x))
    (perturb : Ω → P → C → Ev → P) (ω : Ω)
    (hdrift : ∀ p c e x,
      dist (read (perturb ω p c e) x) (rec x) ≤
      dist (read p x) (rec x) + ρ)
    (hbudget : ε + ρ ≤ t)
    (registry : UPTR17A.Registry)
    (s : P × UPTR17A.Machine) (c : C) (e : Ev)
    (hheld : ∀ x, Snuffy.G1Held.Continues rec ε (read s.1) x)
    (ticket : Nat) (eff : UPTR12A.Effect)
    (rest : List (Nat × UPTR12A.Effect))
    (contract : UPTR17A.Contract)
    (hhead : s.2.pending = (ticket, eff) :: rest)
    (hregistry : registry ticket = some contract)
    (hready : UPTR17A.Ready
      {s.2 with pending := rest} ticket eff contract) :
    let next := Snuffy.G1Refinement.guardedStep
      (Snuffy.G2Freedom.jointCorrect correct)
      (Snuffy.G2Freedom.jointPerturb perturb
        (fun m (_ : C) (_ : Ev) => UPTR17A.drainOne registry m))
      ω s c e
    (∀ x, Snuffy.G1Held.Continues rec ε (read next.1) x) ∧
    next.2.applied = s.2.applied ++ [(ticket, eff)] := by
  dsimp
  constructor
  · exact Snuffy.G1Refinement.guarded_step_continues
      hrec hsep ht hdecC hnear hε
      (fun z : P × UPTR17A.Machine => read z.1)
      (Snuffy.G2Freedom.jointCorrect correct)
      (fun z x => hcorr z.1 x)
      (Snuffy.G2Freedom.jointPerturb perturb
        (fun m (_ : C) (_ : Ev) => UPTR17A.drainOne registry m))
      ω (fun z c' e' x => hdrift z.1 c' e' x)
      hbudget s c e hheld
  · exact guarded_step_applies_ready_head
      correct perturb registry ω s c e ticket eff rest contract
      hhead hregistry hready

end Snuffy.G2ActualDeliveryJoin
