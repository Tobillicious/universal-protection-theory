/-
Independent finite countermodel: a uniform lottery across distinct,
globally maximal UPT outcomes need not give equal retention probability
to each original individual. A different explicit ticket weighting can
equalize individual marginals, with no change to the original priority
order, feasible family, or definition of a protected particular.

This is a mathematical selection illustration, NOT normative proof
that individual-marginal equality is the correct tragic-choice rule.
-/
import PhysicalBridges.IRSelectedMaximality

namespace PhysicalBridges.IRLotteryMarginalFairness

abbrev Outcome := Fin 4
abbrev Particular := Fin 5
def feasible (_ : Outcome) : Prop := True

/-- Four feasible outcomes, each keeping precisely two particular
individuals. Every pair of distinct outcome sets is incomparable. -/
def keeps (o : Outcome) (p : Particular) : Prop :=
  (o.val = 0 ∧ (p.val = 0 ∨ p.val = 1)) ∨
  (o.val = 1 ∧ (p.val = 0 ∨ p.val = 2)) ∨
  (o.val = 2 ∧ (p.val = 1 ∨ p.val = 2)) ∨
  (o.val = 3 ∧ (p.val = 3 ∨ p.val = 4))

instance (o : Outcome) (p : Particular) : Decidable (keeps o p) := by
  unfold keeps
  infer_instance

def keys : List (Outcome → Particular → Prop) := [keeps]
def uniformTickets : List Outcome := [0, 1, 2, 3]
def individualFairTickets : List Outcome := [0, 1, 2, 3, 3]

/-- In this explicit finite model, inclusion among the
size-two retained sets is symmetric. Direct executable verification
uses the original set-membership relation, not an altered ordering. -/
private theorem pair_inclusion_is_symmetric :
    ∀ a b : Outcome,
      (∀ p : Particular, keeps a p → keeps b p) →
      (∀ p : Particular, keeps b p → keeps a p) := by
  unfold keeps
  decide

/-- Every available choice is maximal in the unchanged original UPT
retention order; no outcome can strictly improve on another. -/
theorem all_four_outcomes_globally_maximal :
    ∀ o : Outcome, UPTExist.LexAlignedL feasible keys o := by
  intro o
  constructor
  · trivial
  · intro other _ better
    change UPTExist.SSub (keeps o) (keeps other) ∨
      (UPTExist.Equiv (keeps o) (keeps other) ∧ False) at better
    rcases better with hs | ⟨_, contradiction⟩
    · have hBack : UPTExist.Sub (keeps other) (keeps o) :=
        pair_inclusion_is_symmetric o other hs.1
      exact hs.2 hBack
    · exact contradiction

/-- Ticket count is a finite, exact natural-number surrogate for
marginal probability: successCount / numberOfTickets. -/
def retentionTickets (tickets : List Outcome) (p : Particular) : Nat :=
  (tickets.filter (fun o => decide (keeps o p))).length

/-- Uniform randomization over these four maximal outcomes favors
people 0,1,2: each appears in two of four options, while 3 and 4
appear in only one of four. -/
theorem uniform_maximal_lottery_has_unequal_individual_marginals :
    retentionTickets uniformTickets 0 = 2 ∧
    retentionTickets uniformTickets 1 = 2 ∧
    retentionTickets uniformTickets 2 = 2 ∧
    retentionTickets uniformTickets 3 = 1 ∧
    retentionTickets uniformTickets 4 = 1 := by
  decide

/-- A different distribution over the SAME four maximal outcomes
gives each individual two retention tickets out of five. This is
not uniform over outcomes, yet its individual marginals are equal. -/
theorem nonuniform_lottery_equalizes_individual_marginals :
    ∀ p : Particular, retentionTickets individualFairTickets p = 2 := by
  decide

/-- Changing the lottery changes only the distribution, never the
original feasible choices or the order used to judge maximality. -/
theorem uniform_and_fair_distribution_keep_same_feasible_choices :
    (∀ o : Outcome, o ∈ uniformTickets) ∧
    (∀ o : Outcome, o ∈ individualFairTickets) := by
  decide

#print axioms all_four_outcomes_globally_maximal
#print axioms uniform_maximal_lottery_has_unequal_individual_marginals
#print axioms nonuniform_lottery_equalizes_individual_marginals
#print axioms uniform_and_fair_distribution_keep_same_feasible_choices
end PhysicalBridges.IRLotteryMarginalFairness
