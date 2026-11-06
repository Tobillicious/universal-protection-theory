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
  intro a b included p hp
  have hAB : a = b := by
    by_cases ha0 : a.val = 0
    · have h0 : keeps b (0 : Particular) :=
        included 0 (by simp [keeps, ha0])
      have h1 : keeps b (1 : Particular) :=
        included 1 (by simp [keeps, ha0])
      have hb0 : b.val = 0 := by
        unfold keeps at h0 h1
        omega
      exact Fin.ext (by omega)
    · by_cases ha1 : a.val = 1
      · have h0 : keeps b (0 : Particular) :=
          included 0 (by simp [keeps, ha1])
        have h2 : keeps b (2 : Particular) :=
          included 2 (by simp [keeps, ha1])
        have hb1 : b.val = 1 := by
          unfold keeps at h0 h2
          omega
        exact Fin.ext (by omega)
      · by_cases ha2 : a.val = 2
        · have h1 : keeps b (1 : Particular) :=
            included 1 (by simp [keeps, ha2])
          have h2 : keeps b (2 : Particular) :=
            included 2 (by simp [keeps, ha2])
          have hb2 : b.val = 2 := by
            unfold keeps at h1 h2
            omega
          exact Fin.ext (by omega)
        · have ha3 : a.val = 3 := by
            have hlt := a.isLt
            omega
          have h3 : keeps b (3 : Particular) :=
            included 3 (by simp [keeps, ha3] <;> decide)
          have h4 : keeps b (4 : Particular) :=
            included 4 (by simp [keeps, ha3] <;> decide)
          have hb3 : b.val = 3 := by
            unfold keeps at h3 h4
            omega
          exact Fin.ext (by omega)
  rw [hAB]
  exact hp

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
