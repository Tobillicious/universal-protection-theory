import PhysicalBridges.Koru

/-!
# Koru dual-closure: global reciprocity does not imply link persistence

Tests the proposed proof-chain step:
  a complete, fully intrinsic, reciprocal graph cannot sustain even one
  internal relational loss without contradicting its *global* closure.

A finite countermodel has THREE relationally individuated nodes,
reciprocal links and connectedness at both stages. A symmetric pair of
links disappears between stages without leaving an unmatched reverse
at either stage. The global node type has no exterior.

Thus two static K-fixed relations need not be one dynamically conserved
relation; even strengthened by connectedness + relational individuation.
This is an abstract *independence test*. It does not assert that the
real BCRD source admits this transition, or that edge persistence alone
is the full original six-X3 continuation/authorization/freedom/etc.

The existing Koru.koru operator is NOT the same as edge-reversal: it
means intrinsic articulation of relationally individuated positions.
-/

namespace PhysicalBridges.KoruClosureStressTest

open PhysicalBridges.Koru

inductive Node where
  | a | b | c
  deriving DecidableEq

/-- Before: all off-diagonal relations, together with self-relation at 0. -/
def beforeLink (a b : Node) : Prop :=
  (a = .a ∧ b = .a) ∨ a ≠ b

/-- After: the 0--1 pair is removed BOTH ways; 0--2--1 remains linked. -/
def afterLink (a b : Node) : Prop :=
  (a = .a ∧ b = .a) ∨
    (a ≠ b ∧ ¬ ((a = .a ∧ b = .b) ∨ (a = .b ∧ b = .a)))

/-- The proposed K is edge reversal. K-fixed means reciprocal,
not that every edge present at one stage must persist into the next. -/
def ReverseClosed (R : Node → Node → Prop) : Prop :=
  ∀ a b, R a b ↔ R b a

/-- Rows distinguish all positions: a strong version of the P2
relational-individuation condition; no external labels are needed. -/
def RowIndividuated (R : Node → Node → Prop) : Prop :=
  ∀ a b, (∀ c, R a c ↔ R b c) → a = b

/-- The entire source remains connected by at most two relational
links, even after the internal pair is removed. -/
def TwoStepConnected (R : Node → Node → Prop) : Prop :=
  ∀ a b, a = b ∨ R a b ∨ ∃ c, R a c ∧ R c b

theorem both_stages_reverse_closed :
    ReverseClosed beforeLink ∧ ReverseClosed afterLink := by
  constructor
  · intro a b
    cases a <;> cases b <;> simp [beforeLink]
  · intro a b
    cases a <;> cases b <;> simp [afterLink]

theorem both_stages_individuated :
    RowIndividuated beforeLink ∧ RowIndividuated afterLink := by
  constructor
  · intro a b h
    cases a <;> cases b
    all_goals try rfl
    all_goals
      have ha := h .a
      have hb := h .b
      have hc := h .c
      simp [beforeLink] at ha hb hc
  · intro a b h
    cases a <;> cases b
    all_goals try rfl
    all_goals
      have ha := h .a
      have hb := h .b
      have hc := h .c
      simp [afterLink] at ha hb hc

theorem both_stages_connected :
    TwoStepConnected beforeLink ∧ TwoStepConnected afterLink := by
  constructor
  · intro a b
    cases a <;> cases b
    all_goals first
      | exact Or.inl rfl
      | exact Or.inr (Or.inl (by simp [beforeLink, afterLink]))
      | exact Or.inr (Or.inr ⟨.c, by simp [beforeLink, afterLink], by simp [beforeLink, afterLink]⟩)
  · intro a b
    cases a <;> cases b
    all_goals first
      | exact Or.inl rfl
      | exact Or.inr (Or.inl (by simp [beforeLink, afterLink]))
      | exact Or.inr (Or.inr ⟨.c, by simp [beforeLink, afterLink], by simp [beforeLink, afterLink]⟩)

/-- There is a real relational change at a particular pair. But it is
not a dangling, unmatched directed edge: BOTH directions disappear. -/
theorem pair_lost_reciprocally :
    beforeLink .a .b ∧ beforeLink .b .a ∧
    ¬ afterLink .a .b ∧ ¬ afterLink .b .a := by
  simp [beforeLink, afterLink]

/-- The exact independence result for the proposed step
"boundary closure => no first internal loss". Fixed points of K at
each stage, no disconnected component, and relational individuation
do not give temporal conservation across a stage transition. -/
theorem closure_does_not_force_edge_persistence :
    ReverseClosed beforeLink ∧ ReverseClosed afterLink ∧
    RowIndividuated beforeLink ∧ RowIndividuated afterLink ∧
    TwoStepConnected beforeLink ∧ TwoStepConnected afterLink ∧
    beforeLink .a .b ∧ ¬ afterLink .a .b := by
  exact ⟨both_stages_reverse_closed.1,
    both_stages_reverse_closed.2,
    both_stages_individuated.1,
    both_stages_individuated.2,
    both_stages_connected.1,
    both_stages_connected.2,
    pair_lost_reciprocally.1,
    pair_lost_reciprocally.2.2.1⟩

/-- Stronger than the previous one-sided hostile control:
a *reciprocal* link loss cannot be ruled out by bare K-involution. -/
theorem no_dangling_edge_does_not_imply_no_local_loss :
    (ReverseClosed beforeLink ∧ ReverseClosed afterLink) ∧
      ¬ (∀ a b, beforeLink a b → afterLink a b) := by
  constructor
  · exact both_stages_reverse_closed
  · intro h
    exact pair_lost_reciprocally.2.2.1
      (h .a .b pair_lost_reciprocally.1)

#print axioms both_stages_reverse_closed
#print axioms both_stages_individuated
#print axioms both_stages_connected
#print axioms pair_lost_reciprocally
#print axioms closure_does_not_force_edge_persistence
#print axioms no_dangling_edge_does_not_imply_no_local_loss

end PhysicalBridges.KoruClosureStressTest
