namespace Snuffy.G2Outcome

structure OutcomeTuple where
  preStateHash : UInt64
  postStateHash : UInt64
  workExpenditure : Nat
  isAuthorized : Bool
  isClosed : Bool
  deriving Repr, DecidableEq

def G2_ValidOutcome (o : OutcomeTuple) : Prop :=
  o.isAuthorized = true → (o.isClosed = true ∧ o.workExpenditure > 0)

abbrev OutcomeSequence := List OutcomeTuple

def G2_SequenceValid (seq : OutcomeSequence) : Prop :=
  ∀ o ∈ seq, G2_ValidOutcome o

theorem g2_compose_valid (seq : OutcomeSequence) (o : OutcomeTuple)
    (h_seq : G2_SequenceValid seq)
    (h_o : G2_ValidOutcome o) :
    G2_SequenceValid (seq ++ [o]) := by
  intro x hx
  rw [List.mem_append, List.mem_singleton] at hx
  rcases hx with h_in | h_eq
  · exact h_seq x h_in
  · subst h_eq
    exact h_o

end Snuffy.G2Outcome
