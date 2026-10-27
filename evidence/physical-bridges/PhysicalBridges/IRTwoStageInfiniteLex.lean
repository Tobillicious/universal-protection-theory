/-
IR-67: two-stage ORIGINAL UPTExist.LexBetter infinite maximality.

(1) General theorem for independent finite-obstruction stages:
both original stagewise priority inclusion predicates are kept;
the feasible outcome family is infinite, not a safe-menu quotient.

(2) Nontrivial COUPLED infinite-feasible synthetic example where
stage-one and stage-two protected facts conflict. Prove the
lexically aligned outcome DIRECTLY against the entire coupled
feasible family, not by falsely combining independent maxima.

(3) Countermodel: independent optimization can violate joint
feasibility when the priorities have interacting constraints.

Neither general arbitrary X3 multistage existence nor actual
physical feasibility is claimed.
-/
import PhysicalBridges.IRInfiniteFinitaryMaximality

namespace PhysicalBridges.IRTwoStageInfiniteLex

open IRInfiniteFinitaryMaximality

abbrev Outcome := (Nat → Prop) × (Nat → Prop)

def firstKey (o : Outcome) (k : Nat) : Prop := o.1 k
def secondKey (o : Outcome) (k : Nat) : Prop := o.2 k

def fullIndependent (f0 f1 : List Nat → Prop) (o : Outcome) : Prop :=
  Feasible f0 o.1 ∧ Feasible f1 o.2

def independentChoice (f0 f1 : List Nat → Prop) : Outcome :=
  (limit f0, limit f1)

/-- Multi-stage source-level extension for a clearly identified
separable infinite-feasible class. The original original lex
comparator is applied to TWO full inclusion stages, not rewritten. -/
theorem independent_two_stage_global_lex_maximum
    (f0 f1 : List Nat → Prop)
    (h0 : Feasible f0 (fun _ => False))
    (h1 : Feasible f1 (fun _ => False)) :
    UPTExist.LexAlignedL (fullIndependent f0 f1)
      ([firstKey, secondKey] : List (Outcome → Nat → Prop))
      (independentChoice f0 f1) := by
  have ha0 := infinite_full_feasible_aligned_exists f0 h0
  have ha1 := infinite_full_feasible_aligned_exists f1 h1
  refine ⟨⟨ha0.1, ha1.1⟩, ?_⟩
  intro other hOther hBetter
  change
    UPTExist.SSub (limit f0) other.1 ∨
    (UPTExist.Equiv (limit f0) other.1 ∧
      (UPTExist.SSub (limit f1) other.2 ∨
        (UPTExist.Equiv (limit f1) other.2 ∧ False))) at hBetter
  rcases hBetter with hFirst | ⟨_, hLater⟩
  · exact ha0.2 other.1 hOther.1 hFirst
  · rcases hLater with hSecond | ⟨_, hImpossible⟩
    · exact ha1.2 other.2 hOther.2 hSecond
    · exact hImpossible

/-- A coupled, two-stage finite conflict: first stage retaining
particular 0 and second stage retaining particular 0 cannot be
simultaneously achieved. This is a SYNTHETIC feasibility rule. -/
def coupledFull (o : Outcome) : Prop :=
  ¬ (o.1 0 ∧ o.2 0)

/-- The first-stage priority keeps everyone, while the second-stage
retains everybody but its incompatible 0. The outcome space contains
ALL pairs of Nat-indexed retention subsets, including infinite ones. -/
def coupledChoice : Outcome :=
  ((fun _ => True), (fun k => k ≠ 0))

theorem coupled_choice_feasible : coupledFull coupledChoice := by
  intro h
  exact h.2 rfl

/-- This is an actual two-stage lex maximality proof for a
NONSEPARABLE infinite feasible outcome family, under the exact
source-level UPT lex order. Any higher-priority increase is
impossible because all first-stage facts are retained. Any
lower-stage strict increase must add the forbidden pair member,
making the outcome infeasible. -/
theorem coupled_two_stage_lex_maximum :
    UPTExist.LexAlignedL coupledFull
      ([firstKey, secondKey] : List (Outcome → Nat → Prop))
      coupledChoice := by
  refine ⟨coupled_choice_feasible, ?_⟩
  intro other hFeasible hBetter
  change
    UPTExist.SSub coupledChoice.1 other.1 ∨
    (UPTExist.Equiv coupledChoice.1 other.1 ∧
      (UPTExist.SSub coupledChoice.2 other.2 ∨
        (UPTExist.Equiv coupledChoice.2 other.2 ∧ False))) at hBetter
  rcases hBetter with hFirst | ⟨hEqualFirst, hLater⟩
  · exact hFirst.2 (by intro k hk; trivial)
  · rcases hLater with hSecond | ⟨_, hImpossible⟩
    · have hFirst0 : other.1 0 :=
        hEqualFirst.1 0 trivial
      have hSecond0 : other.2 0 := by
        by_cases h : other.2 0
        · exact h
        · have hReverse : UPTExist.Sub other.2 coupledChoice.2 := by
            intro k hk
            change k ≠ 0
            intro heq
            subst k
            exact h hk
          exact False.elim (hSecond.2 hReverse)
      exact hFeasible ⟨hFirst0, hSecond0⟩
    · exact hImpossible

/-- An unrestricted empty no-good family allows ALL retention sets. -/
def noForbidden (_ : List Nat) : Prop := False

theorem empty_feasible_without_prohibitions :
    Feasible noForbidden (fun _ => False) := by
  intro _ hForbidden _
  exact hForbidden

theorem unconstrained_limit_includes_every_particular (k : Nat) :
    limit noForbidden k := by
  apply cannot_feasibly_add_missing_particular noForbidden k
  intro _ hForbidden _
  exact hForbidden

/-- Independent optimization at BOTH priority stages violates the
physical joint constraint when even a single cross-stage forbidden
pair exists. Thus the general independent theorem cannot silently be
used for a coupled X3 feasible universe. -/
theorem independent_maxima_not_jointly_feasible :
    ¬ coupledFull (independentChoice noForbidden noForbidden) := by
  intro h
  exact h ⟨unconstrained_limit_includes_every_particular 0,
    unconstrained_limit_includes_every_particular 0⟩

/-- In this coupled example a first-stage objective completely
dominates the second-stage tradeoff. This is **lexically** maximal,
not a universal proof that both individual stage maxima can coexist. -/
theorem coupled_choice_not_joint_independent_maximum :
    coupledFull coupledChoice ∧
    ¬ coupledFull (independentChoice noForbidden noForbidden) := by
  exact ⟨coupled_choice_feasible,
    independent_maxima_not_jointly_feasible⟩

#print axioms independent_two_stage_global_lex_maximum
#print axioms coupled_choice_feasible
#print axioms coupled_two_stage_lex_maximum
#print axioms unconstrained_limit_includes_every_particular
#print axioms independent_maxima_not_jointly_feasible
#print axioms coupled_choice_not_joint_independent_maximum
end PhysicalBridges.IRTwoStageInfiniteLex
