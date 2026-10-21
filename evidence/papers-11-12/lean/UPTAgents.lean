/-
Agents together (Paper 12, section 3). Agents aligned with all share one order, so their objectives never
conflict; yet independent best responses can stall, so joint maximality needs a joint choice.
Sets of particulars are predicates, compared by inclusion, as in UPTLaw.lean.
-/
namespace UPTAgents

universe u

def Sub {α : Type u} (s t : α → Prop) : Prop := ∀ x, s x → t x
def SSub {α : Type u} (s t : α → Prop) : Prop := Sub s t ∧ ¬ Sub t s

/-- **One order, no conflict.** Two agents that compare outcomes by the same order agree on every strict
improvement: whatever is strictly better for one is strictly better for the other. -/
theorem shared_order_no_conflict {α : Type u} {O : Type} (key₁ key₂ : O → α → Prop)
    (same : key₁ = key₂) (o p : O) : SSub (key₁ o) (key₁ p) ↔ SSub (key₂ o) (key₂ p) := by
  subst same; exact Iff.rfl

inductive P | x | y

/-- Two agents each choose `true` (coordinate) or `false` (go alone). Coordinating together keeps both
particulars; going alone together keeps `x`; a mismatch keeps nothing. -/
def kept : Bool → Bool → P → Prop
  | true, true => fun _ => True
  | false, false => fun p => p = P.x
  | _, _ => fun _ => False

/-- No unilateral deviation from (false, false) is a strict improvement, for either agent, under the
shared order: each choice is a best response to the other. -/
theorem stall_is_best_response :
    ¬ SSub (kept false false) (kept true false) ∧ ¬ SSub (kept false false) (kept false true) := by
  constructor
  · intro ⟨h, _⟩; exact h P.x rfl
  · intro ⟨h, _⟩; exact h P.x rfl

/-- Yet the joint move (true, true) keeps strictly more: the stall is not jointly maximal. -/
theorem stall_not_jointly_maximal : SSub (kept false false) (kept true true) := by
  refine ⟨fun _ _ => trivial, ?_⟩
  intro h
  have : (P.y : P) = P.x := h P.y trivial
  exact P.noConfusion this

/-- **Independent best responses can stall** (the two facts together). -/
theorem best_responses_can_stall :
    (¬ SSub (kept false false) (kept true false) ∧ ¬ SSub (kept false false) (kept false true)) ∧
    SSub (kept false false) (kept true true) :=
  ⟨stall_is_best_response, stall_not_jointly_maximal⟩

theorem ssub_irrefl {α : Type u} (s : α → Prop) : ¬ SSub s s := fun h => h.2 h.1

theorem ssub_trans {α : Type u} {a b c : α → Prop} (hab : SSub a b) (hbc : SSub b c) : SSub a c :=
  ⟨fun x hx => hbc.1 x (hab.1 x hx), fun hca => hab.2 (fun x hbx => hca x (hbc.1 x hbx))⟩

/-- **A joint choice suffices.** Among finitely many joint options (a list), every option is either
maximal or strictly below a maximal one, so a joint choice procedure that picks a maximal option is
always available. -/
theorem joint_maximal_exists {α : Type u} (L : List (α → Prop)) :
    ∀ b, b ∈ L → ∃ m, m ∈ L ∧ (m = b ∨ SSub b m) ∧ ∀ c, c ∈ L → ¬ SSub m c := by
  intro b hb
  have key : ∀ (M : List (α → Prop)) (b : α → Prop),
      ∃ m, (m = b ∨ m ∈ M) ∧ (m = b ∨ SSub b m) ∧ ∀ c, c ∈ M → ¬ SSub m c := by
    intro M
    induction M with
    | nil => intro b; exact ⟨b, Or.inl rfl, Or.inl rfl, fun c hc => nomatch hc⟩
    | cons x M ih =>
      intro b
      obtain ⟨m, hmem, hbm, hmax⟩ := ih b
      by_cases hmx : SSub m x
      · refine ⟨x, Or.inr List.mem_cons_self, ?_, ?_⟩
        · cases hbm with
          | inl h => exact Or.inr (h ▸ hmx)
          | inr h => exact Or.inr (ssub_trans h hmx)
        · intro c hc hxc
          cases hc with
          | head => exact ssub_irrefl x hxc
          | tail _ hcM => exact hmax c hcM (ssub_trans hmx hxc)
      · refine ⟨m, ?_, hbm, ?_⟩
        · cases hmem with
          | inl h => exact Or.inl h
          | inr h => exact Or.inr (List.mem_cons_of_mem x h)
        · intro c hc hmc
          cases hc with
          | head => exact hmx hmc
          | tail _ hcM => exact hmax c hcM hmc
  obtain ⟨m, hmem, hbm, hmax⟩ := key L b
  refine ⟨m, ?_, hbm, hmax⟩
  cases hmem with
  | inl h => exact h ▸ hb
  | inr h => exact h

end UPTAgents
