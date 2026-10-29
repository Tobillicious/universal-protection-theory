import Mathlib

/-!
# The hold is a common viable action (compiled edition, Part XI)

IR-113 proves that one observation-only protective policy exists exactly when
every observation class has an action keeping every compatible viable state
viable. This module derives that premise from the holding route: a faithful
hold lands no effect, so its safety does not depend on which hidden state is
actual; if every successor reached during the hold interval stays viable (the
holding cycle's radius bound, `Bridge.qsl_within_radius`), the hold is a common
viable action for every observation class.

`two_world_resolved` is the two-world countermodel (action `a` needed in one
hidden world and harmful in the other, `b` the reverse): no effect-landing
action is safe in both, but the hold is.
-/

namespace Snuffy.HoldCommonAction

universe u v w
variable {S : Type u} {A : Type v} {O : Type w}

/-- IR-113's criterion: `a` keeps every viable state of observation class `o`
viable after every admitted transition. -/
def ClassViableAction (observe : S → O) (step : S → A → S → Prop)
    (viable : S → Prop) (o : O) (a : A) : Prop :=
  ∀ s, observe s = o → viable s → ∀ t, step s a t → viable t

/-- A hold whose every admitted successor of a viable state is viable is a
common viable action for every observation class. -/
theorem hold_is_common_viable_action (observe : S → O)
    (step : S → A → S → Prop) (viable : S → Prop) (hold : A)
    (hsafe : ∀ s, viable s → ∀ t, step s hold t → viable t) :
    ∀ o, ∃ a, ClassViableAction observe step viable o a :=
  fun _ => ⟨hold, fun s _ hs t ht => hsafe s hs t ht⟩

/-- Hence one observation-only policy keeps viability at every class. -/
theorem common_policy_from_hold (observe : S → O)
    (step : S → A → S → Prop) (viable : S → Prop) (hold : A)
    (hsafe : ∀ s, viable s → ∀ t, step s hold t → viable t) :
    ∃ policy : O → A, ∀ o, ClassViableAction observe step viable o (policy o) :=
  ⟨fun _ => hold, fun _ s _ hs t ht => hsafe s hs t ht⟩

/-- A policy may act wherever an action is safe for the whole class and hold
elsewhere: it still keeps viability at every class. -/
theorem act_or_hold_policy (observe : S → O)
    (step : S → A → S → Prop) (viable : S → Prop) (hold : A)
    (hsafe : ∀ s, viable s → ∀ t, step s hold t → viable t)
    (act : O → Option A)
    (hact : ∀ o a, act o = some a → ClassViableAction observe step viable o a) :
    ∀ o, ClassViableAction observe step viable o ((act o).getD hold) := by
  intro o
  cases h : act o with
  | none => exact fun s _ hs t ht => hsafe s hs t ht
  | some a => exact hact o a h

/-! ## The two-world countermodel, resolved by the hold -/

/-- Two hidden worlds that look the same, and a protected/harmed outcome. -/
inductive World | w1 | w2 deriving DecidableEq
inductive Act | a | b | hold deriving DecidableEq

/-- States: before acting (in a hidden world), or after (protected or harmed). -/
inductive St | start (w : World) | safe | harmed deriving DecidableEq

def obs : St → Unit := fun _ => ()

def viableSt : St → Prop
  | .harmed => False
  | _ => True

/-- `a` protects in `w1` and harms in `w2`; `b` the reverse; the hold lands no
effect and leaves the particular protected while the ambiguity is resolved. -/
def stepSt : St → Act → St → Prop
  | .start .w1, .a, t => t = .safe
  | .start .w1, .b, t => t = .harmed
  | .start .w2, .a, t => t = .harmed
  | .start .w2, .b, t => t = .safe
  | .start _, .hold, t => t = .safe
  | .safe, _, t => t = .safe
  | .harmed, _, t => t = .harmed

/-- Without the hold, no action is safe in both hidden worlds. -/
theorem no_effect_action_safe_in_both :
    ¬ ∃ x : Act, x ≠ .hold ∧ ClassViableAction obs stepSt viableSt () x := by
  rintro ⟨x, hx, hsafe⟩
  cases x with
  | a => exact hsafe (.start .w2) rfl trivial .harmed rfl
  | b => exact hsafe (.start .w1) rfl trivial .harmed rfl
  | hold => exact hx rfl

/-- With the hold, a common viable action exists. -/
theorem two_world_resolved : ClassViableAction obs stepSt viableSt () .hold := by
  intro s _ hs t ht
  cases s with
  | start w => cases w <;> (simp only [stepSt] at ht; subst ht; trivial)
  | safe => simp only [stepSt] at ht; subst ht; trivial
  | harmed => exact absurd hs id

end Snuffy.HoldCommonAction
