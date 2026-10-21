import TrustedCounter

namespace UPTObserved
open CodexCounter
universe u

/-- An entry emitted by the trusted operation driver. Coverage, classification and clock correctness
    are interface premises; the theorem states what accepting this complete trace guarantees. -/
structure Operation (S : Type u) where
  held : Bool
  live : Bool
  emits : Bool
  before : S
  after : S

def forbidden {S : Type u} [DecidableEq S] (e : Operation S) : Bool :=
  e.held && (e.live || e.emits || decide (e.before ≠ e.after))

def Safe {S : Type u} (e : Operation S) : Prop :=
  e.held = true → e.live = false ∧ e.emits = false ∧ e.before = e.after

theorem not_forbidden_iff_safe {S : Type u} [DecidableEq S] (e : Operation S) :
    forbidden e = false ↔ Safe e := by
  cases e with
  | mk held live emits before after =>
    cases held <;> cases live <;> cases emits <;> by_cases h : before = after <;>
      simp [forbidden,Safe,h]

def SafeTrace {S : Type u} : List (Operation S) → Prop
  | [] => True
  | e :: es => Safe e ∧ SafeTrace es

theorem clean_iff_safe_trace {S : Type u} [DecidableEq S] :
    ∀ es : List (Operation S), clean forbidden es ↔ SafeTrace es
  | [] => Iff.rfl
  | e :: es => by
    change (forbidden e = false ∧ clean forbidden es) ↔ (Safe e ∧ SafeTrace es)
    exact and_congr (not_forbidden_iff_safe e) (clean_iff_safe_trace es)

theorem accepted_iff_safe_trace {S : Type u} [DecidableEq S] (es : List (Operation S)) :
    count forbidden es = 0 ↔ SafeTrace es :=
  (count_zero_iff_clean forbidden es).trans (clean_iff_safe_trace es)

theorem safe_trace_member {S : Type u} : ∀ (es : List (Operation S)), SafeTrace es →
    ∀ e, e ∈ es → Safe e
  | [], _, _, hm => by cases hm
  | x :: xs, h, e, hm => by
    cases List.mem_cons.mp hm with
    | inl he => cases he; exact h.1
    | inr hm => exact safe_trace_member xs h.2 e hm

/-- Every held operation in an accepted complete trace has no live call, no emission and no state write,
    including changes later rolled back. S can include the lived journal, ordered sink and delivery IDs. -/
theorem accepted_preserves_each_held_operation {S : Type u} [DecidableEq S]
    (es : List (Operation S)) (accepted : count forbidden es = 0) :
    ∀ e, e ∈ es → e.held = true → e.live = false ∧ e.emits = false ∧ e.before = e.after :=
  safe_trace_member es ((accepted_iff_safe_trace es).mp accepted)

#print axioms not_forbidden_iff_safe
#print axioms accepted_iff_safe_trace
#print axioms accepted_preserves_each_held_operation
end UPTObserved
