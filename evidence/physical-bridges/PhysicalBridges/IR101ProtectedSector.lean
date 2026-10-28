import PhysicalBridges.IR100PhysicalAccountingWitness

/-!
IR-101: an invariant isProtected sector is closed under actual transitions
only when every transition preserves sector membership.
Reversible dynamics alone do not imply this closure.
-/
namespace PhysicalBridges.IR101

universe u

def PreservesSector {S : Type u} (isProtected : S → Prop)
    (step : S → S → Prop) : Prop :=
  ∀ s t, isProtected s → step s t → isProtected t

inductive Reach {S : Type u} (step : S → S → Prop) : S → S → Prop where
  | refl (s : S) : Reach step s s
  | tail {s t v : S} : Reach step s t → step t v → Reach step s v

theorem sector_preserved_along_reach
    {S : Type u} (isProtected : S → Prop) (step : S → S → Prop)
    (closed : PreservesSector isProtected step)
    {s t : S} (h : Reach step s t) (initial : isProtected s) :
    isProtected t := by
  induction h with
  | refl => exact initial
  | tail earlier edge ih => exact closed _ _ ih edge

/-- A reversible transition can still leave the isProtected sector. -/
theorem reversible_does_not_force_protection :
    ∃ (step : Bool → Bool → Prop) (isProtected : Bool → Prop),
      (∀ a b, step a b → step b a) ∧
      ¬ PreservesSector isProtected step := by
  refine ⟨(fun a b => a ≠ b), (fun a => a = true), ?_, ?_⟩
  · intro a b hab
    exact Ne.symm hab
  · intro h
    have hBad := h true false rfl (by decide : true ≠ false)
    cases hBad

end PhysicalBridges.IR101
