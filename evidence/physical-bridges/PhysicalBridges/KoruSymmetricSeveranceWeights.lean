/-!
# Lemma D control: balanced reciprocal weights can vanish together

This finite, exact weighted-graph family tests the claim that if all relational
weights are reciprocal, continuously removing a particular's interactions must
at some point break reciprocity or node-wise flux balance.

The family uses an arbitrary natural parameter q. For EVERY q, every weight
is symmetric and every node is balanced. Moving q from 1 to 0 simultaneously
removes all couplings incident to p while preserving the a--b edge.

This is a discrete algebraic verification of the exact pairwise invariants,
NOT a formal proof of real-parameter continuity. The continuous extension is
W_t(p,a)=W_t(a,p)=W_t(p,b)=W_t(b,p)=1-t for 0 <= t <= 1,
W_t(a,b)=W_t(b,a)=1. It is polynomial, hence continuous, and remains reciprocal
for every t (equal derivatives in both directions).

This controls only one mathematical implication in the proposed "Lemma D".
It is not a physically validated BCRD transition, not a model of subjectivity,
and not a refutation of the entire maximal original six-X3 thesis.
-/

namespace PhysicalBridges.KoruSymmetricSeveranceWeights

inductive Node where
  | p | a | b
  deriving DecidableEq

/-- Two reciprocal bonds of strength q from p, and one fixed bond a--b. -/
def weight (q : Nat) (u v : Node) : Nat :=
  match u, v with
  | .p, .a => q
  | .a, .p => q
  | .p, .b => q
  | .b, .p => q
  | .a, .b => 1
  | .b, .a => 1
  | _, _ => 0

/-- All pairwise directed weights are equal for every value of q. -/
theorem reciprocity_at_every_parameter (q : Nat) (u v : Node) :
    weight q u v = weight q v u := by
  cases u <;> cases v <;> rfl

def outgoing (q : Nat) (u : Node) : Nat :=
  weight q u .p + weight q u .a + weight q u .b

def incoming (q : Nat) (u : Node) : Nat :=
  weight q .p u + weight q .a u + weight q .b u

/-- Kirchhoff-style balance remains exact at each node at every q. -/
theorem balanced_at_every_parameter (q : Nat) (u : Node) :
    outgoing q u = incoming q u := by
  cases u <;> rfl

/-- The outgoing degree of p is twice the parameter; no conserved degree
follows from instantaneous reciprocity or balanced flux. -/
theorem degree_p (q : Nat) :
    outgoing q .p = q + q := by
  simp [outgoing, weight]

theorem positive_degree_to_zero :
    outgoing 1 .p = 2 ∧ outgoing 0 .p = 0 := by
  decide

theorem all_relations_of_p_vanish (u : Node) :
    weight 0 .p u = 0 ∧ weight 0 u .p = 0 := by
  cases u <;> decide

theorem remaining_pair_is_still_coupled :
    weight 0 .a .b = 1 ∧ weight 0 .b .a = 1 := by
  decide

/-- There is no q at which a directed pair becomes unmatched. -/
theorem no_parameter_has_an_asymmetric_edge :
    ∀ (q : Nat), ¬ ∃ (u v : Node), weight q u v ≠ weight q v u := by
  intro q h
  obtain ⟨u, v, hUnequal⟩ := h
  exact hUnequal (reciprocity_at_every_parameter q u v)

/-- Precise independence control: exact flux balance and reciprocity for
every sampled stage are compatible with p losing all its incident weights.
This does not assert a physically admitted transition or any X3 semantics. -/
theorem boundary_balance_does_not_force_positive_continuation :
    (∀ q u, outgoing q u = incoming q u) ∧
    (∀ q u v, weight q u v = weight q v u) ∧
    outgoing 1 .p = 2 ∧
    outgoing 0 .p = 0 ∧
    weight 0 .a .b = 1 := by
  exact ⟨balanced_at_every_parameter, reciprocity_at_every_parameter,
    positive_degree_to_zero.1, positive_degree_to_zero.2,
    remaining_pair_is_still_coupled.1⟩

#print axioms reciprocity_at_every_parameter
#print axioms balanced_at_every_parameter
#print axioms degree_p
#print axioms positive_degree_to_zero
#print axioms all_relations_of_p_vanish
#print axioms remaining_pair_is_still_coupled
#print axioms no_parameter_has_an_asymmetric_edge
#print axioms boundary_balance_does_not_force_positive_continuation

end PhysicalBridges.KoruSymmetricSeveranceWeights
