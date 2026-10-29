/-! Ported from Book I v2.0.5, Paper 12 evidence (`evidence/papers-11-12/lean/UPTHoldAdequacy.lean`, sha256 `62a64bfca35ab73fd95eace4f2b274c9ece23a6b048511f84c92525e026af84e`).
Namespace `UPTHoldAdq` renamed to `Snuffy.Book.UPTHoldAdequacy` for the canon's joint audit; statements and proofs unchanged. -/

/-
Definitional adequacy of the faithful hold (Paper 12, section 3: "A hold that is best for lives alone is not
enough: it can lose freedom elsewhere and leave a lethal option undominated"). Previously a recorded
countermodel and an exhaustive check; here a kernel-checked proof. Two states (the threat is real, or the
alarm is false), two particulars (target x, suspect y), and two stages per state: kept alive, kept free.
- H, a hold that is best for lives alone, keeps everyone alive but holds the suspect in both states.
- L, a lethal option, strikes when the threat is real and leaves everyone free on a false alarm.
- H*, a faithful hold, keeps everyone alive and holds the suspect only when the threat is real.
H does not dominate L in the full order (L is better on a false alarm), so a lives-only definition leaves the
lethal option undominated. H* dominates L in every state, strictly when the threat is real, and ends no one.
-/
namespace Snuffy.Book.UPTHoldAdequacy

def Sub {α : Type} (s t : α → Prop) : Prop := ∀ x, s x → t x
def SSub {α : Type} (s t : α → Prop) : Prop := Sub s t ∧ ¬ Sub t s
def Equiv {α : Type} (s t : α → Prop) : Prop := Sub s t ∧ Sub t s

inductive P | x | y
inductive St | real | falseAlarm

/-- An outcome: who is kept alive, and who is kept free. -/
structure Out where
  alive : P → Prop
  free : P → Prop

/-- `o` is at least as good as `p` in the full (life-first, two-stage) order. -/
def Ge (o p : Out) : Prop := SSub p.alive o.alive ∨ (Equiv p.alive o.alive ∧ Sub p.free o.free)

/-- `o` is at least as good as `p` for lives alone. -/
def GeLives (o p : Out) : Prop := Sub p.alive o.alive

def everyone : P → Prop := fun _ => True
def onlyX : P → Prop := fun q => q = P.x

/-- H: everyone kept alive, the suspect held in both states. -/
def H : St → Out := fun _ => ⟨everyone, onlyX⟩
/-- L: strike when the threat is real; on a false alarm, everyone alive and free. -/
def L : St → Out
  | .real => ⟨onlyX, onlyX⟩
  | .falseAlarm => ⟨everyone, everyone⟩
/-- H*: everyone kept alive; the suspect held only when the threat is real. -/
def Hstar : St → Out
  | .real => ⟨everyone, onlyX⟩
  | .falseAlarm => ⟨everyone, everyone⟩

/-- H is best for lives alone: in every state it keeps alive everyone any outcome keeps alive. -/
theorem H_best_for_lives (o : Out) (ω : St) : GeLives (H ω) o := fun _ _ => trivial

/-- L is lethal: when the threat is real it ends the suspect. -/
theorem L_is_lethal : ¬ (L .real).alive P.y := fun h => P.noConfusion h

/-- **A lives-only hold is not enough.** H does not dominate the lethal option L in the full order: on a
false alarm L keeps the suspect free and H does not. -/
theorem lives_only_hold_leaves_lethal_undominated : ¬ ∀ ω, Ge (H ω) (L ω) := by
  intro h
  have hfa := h .falseAlarm
  cases hfa with
  | inl hs => exact hs.2 (fun _ _ => trivial)
  | inr he =>
    have : onlyX P.y := he.2 P.y trivial
    exact P.noConfusion this

/-- **The faithful hold is enough.** H* is at least as good as L in every state in the full order ... -/
theorem faithful_hold_dominates : ∀ ω, Ge (Hstar ω) (L ω) := by
  intro ω
  cases ω with
  | real =>
    left
    refine ⟨fun _ _ => trivial, ?_⟩
    intro h
    have : onlyX P.y := h P.y trivial
    exact P.noConfusion this
  | falseAlarm =>
    right
    exact ⟨⟨fun _ _ => trivial, fun _ _ => trivial⟩, fun _ _ => trivial⟩

/-- ... strictly better when the threat is real ... -/
theorem faithful_hold_strict_when_real : SSub (L .real).alive (Hstar .real).alive := by
  refine ⟨fun _ _ => trivial, ?_⟩
  intro h
  have : onlyX P.y := h P.y trivial
  exact P.noConfusion this

/-- ... and ends no one, in any state. -/
theorem faithful_hold_ends_no_one : ∀ ω q, (Hstar ω).alive q := by
  intro ω q; cases ω <;> trivial

end Snuffy.Book.UPTHoldAdequacy
