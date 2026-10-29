import Snuffy.G1FullDomain

namespace Snuffy.G2WholeOutcome

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

theorem g2_authorized_implies_closed (o : OutcomeTuple) (h : G2_ValidOutcome o)
    (h_auth : o.isAuthorized = true) : o.isClosed = true := by
  have := h h_auth
  exact this.1

theorem g2_authorized_implies_positive_work (o : OutcomeTuple) (h : G2_ValidOutcome o)
    (h_auth : o.isAuthorized = true) : o.workExpenditure > 0 := by
  have := h h_auth
  exact this.2

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

/-- The represented outcome may be the complete dependent continuation and
freedom tuple. Journal/replay preserves its full source state and observation
history for every reactive policy, not just its stage-one component. -/
theorem journal_whole_outcome {X C Ev O Outcome : Type*} (T : X → C → Ev → X)
    (obs : X → O) (outcome : X × List O → Outcome)
    (ctrl : List O → C) (env : List O → C → Ev) (x₀ : X) (horizon : ℕ) :
    outcome
      ((Snuffy.Composition.run (Snuffy.G1FullDomain.journalStep T)
        (fun s => obs s.live) ctrl env (Snuffy.G1FullDomain.journalInit x₀) horizon).1.live,
       (Snuffy.Composition.run (Snuffy.G1FullDomain.journalStep T)
        (fun s => obs s.live) ctrl env (Snuffy.G1FullDomain.journalInit x₀) horizon).2) =
    outcome (Snuffy.Composition.run T obs ctrl env x₀ horizon) := by
  obtain ⟨hstate, hobs, -⟩ :=
    Snuffy.G1FullDomain.journal_reactive_fidelity T obs ctrl env x₀ horizon
  exact congrArg outcome (Prod.ext hstate hobs)

/-- The same complete outcome family is realisable before and after the
source journal is introduced. No affordability premise is used to infer
realisability; the controller is transported unchanged. -/
theorem journal_outcome_family {X C Ev O Outcome : Type*} (T : X → C → Ev → X)
    (obs : X → O) (outcome : X × List O → Outcome)
    (env : List O → C → Ev) (x₀ : X) (horizon : ℕ) :
    {o | ∃ ctrl : List O → C,
      outcome
        ((Snuffy.Composition.run (Snuffy.G1FullDomain.journalStep T)
          (fun s => obs s.live) ctrl env (Snuffy.G1FullDomain.journalInit x₀) horizon).1.live,
         (Snuffy.Composition.run (Snuffy.G1FullDomain.journalStep T)
          (fun s => obs s.live) ctrl env (Snuffy.G1FullDomain.journalInit x₀) horizon).2) = o} =
    {o | ∃ ctrl : List O → C,
      outcome (Snuffy.Composition.run T obs ctrl env x₀ horizon) = o} := by
  ext o
  simp_rw [journal_whole_outcome]

end Snuffy.G2WholeOutcome
