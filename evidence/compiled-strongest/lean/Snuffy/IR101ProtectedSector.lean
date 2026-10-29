import Snuffy.IR100PhysicalAccountingWitness

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IR101ProtectedSector.lean` at main `740abbb` (sha256 `f442bad5decd4981052482e28b50deec6b412ceff3e618bfb08ea12299835315`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false

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
