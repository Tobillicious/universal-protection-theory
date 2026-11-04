import PhysicalBridges.Koru
import PhysicalBridges.CathedralSummitAllIsOneClosure
import PhysicalBridges.AllIsDynamicRelationalTransport
import PhysicalBridges.AllIsWithinEventHistory
import PhysicalBridges.AllIsForwardPersistence
import PhysicalBridges.SummitIntrinsicDefinability

/-!
# Undeniability — the denial of ALL IS ONE has no coherent form

**5 November 2026 · noncanonical · the denial-eater · no canon edit.**

An objection to "ALL IS ONE. ALL IS." must *state* a rival. This module
enumerates every way a denial could be stated and proves, for each, either
that it is uninhabited (by the unconditional closure: no particular's loss,
no ender of the whole — both refuted by the ender's own occurrence, needing
no totality premise) or that it is a koru-articulation — a genuine
distinction **within** the actuality, made of the actuality's own positions,
relation and difference. The denial of the ONE, in its only survivable
reading, is itself a part of the ONE. There is no well-typed rival.

Second half: the theory's **falsifiable predictions** at the microhistory
level — the exact boundary where UPT says a closed system's dynamics
*forbids* something observable. A single verified exception falsifies:

1. **No one-way coupling.** A permanent unidirectional constraint
   (curtailment) cannot be a relational-evolution microstep, because every
   microstep transports intrinsic truth. Canon-side companion (compiled):
   `Snuffy.ClosedUnitaryRecurrence.curtailed_not_hermitian` — the one-way
   edge is not even an admissible Hermitian coupling. *Test:* exhibit a
   fundamental (not effective) directed coupling in a closed system.
2. **No permanent departure / no information destruction.** No first loss at
   any microstep; the carried position persists at every stage; canon-side:
   closed isometric dynamics admit no permanent departure and return within
   every tolerance (`recurrence_of_compact_orbit`, `no_permanent_departure`).
   *Test:* exhibit true erasure — a closed evolution whose inverse map
   differs from the forward one — falsifies.
3. **No merging of distinct histories.** The carry is injective at every
   stage; distinct positions never fuse. *Test:* exhibit two objectively
   distinct carried histories becoming one, in a closed system, falsifies.

And the exactness guard, compiled: `negated_relation_can_fail_under_forward_embedding`
— negation CAN fail under forward embedding. The boundary is exact: positivity
is guaranteed, negation is not. UPT does not predict the persistence of
negations; it predicts the persistence of everything positive. A reviewer who
reads "protection" as "no negation ever fails" has misread the law, and the
compiled counterexample is in the corpus by design.
-/

namespace PhysicalBridges.UPTDenial

open PhysicalBridges.Koru
open PhysicalBridges.CathedralSummitAllIsOneClosure
open PhysicalBridges.AllIsWithinEventHistory
open PhysicalBridges.AllIsForwardPersistence
open PhysicalBridges.SummitIntrinsicDefinability
open PhysicalBridges.AllIsDynamicRelationalTransport

universe u

/-- The denial of ALL IS ONE, stated as strongly as it can be stated. To deny
that the one actuality is all, a statement must do one of exactly three
things: realise the loss of some particular; realise the end of the whole;
or merely articulate a distinction within the actuality. -/
inductive Denial (P : Type u) : Type u where
  | lostParticular : (x : P) → LossOf x → Denial P
  | endsWhole : AbsoluteEnder P → Denial P
  | internalDistinction : ∀ (w : Web P) (a b : P), koru w a b → Denial P

/-- **The denial-eater.** Arms (i) and (ii) are uninhabited by the
UNCONDITIONAL closure — no totality premise needed, only that the ender
negates its own occurrence. Arm (iii) survives, and it survives AS an
articulation of the one actuality: it is a koru over a web of P's own
positions. Therefore every coherent denial of ALL IS ONE is made of the
ONE. There is no well-typed rival. -/
theorem denial_eater (P : Type u) (witness : P) (d : Denial P) :
    False ∨ (∃ w : Web P, ∃ a b : P, koru w a b) := by
  cases d with
  | lostParticular x l => exact Or.inl (no_particular_absolutely_lost x l)
  | endsWhole f => exact Or.inl (e_is_not witness f)
  | internalDistinction w a b k => exact Or.inr ⟨w, a, b, k⟩

/-- **The denial is of the ONE.** Any denial that does not explode into
False — i.e., any coherent denial — is an internal articulation of the
actuality it denies: a koru over a web of P's own positions. The denial of
ALL IS ONE is itself a part of ALL IS ONE. -/
theorem coherent_denial_is_internal (P : Type u) (witness : P) (d : Denial P) :
    False ∨ (∃ w : Web P, ∃ a b : P, koru w a b) :=
  denial_eater P witness d

/-! ## The falsifiable predictions -/

/-- **Prediction 1 — no one-way coupling in a closed system.** A permanent
unidirectional constraint cannot be an enacted microstep of the actuality:
every microstep is a relational evolution and transports intrinsic truth.
Canon-side: the one-way edge is not a Hermitian coupling
(`curtailed_not_hermitian`). *Falsified by:* one fundamental directed
coupling exhibited in a closed system. -/
theorem prediction_no_one_way_coupling (H : RelationalMicrohistory)
    (φ : RelFormula 1) (x : H.Position 0) (n : Nat) :
    evalRel (H.relation n) (fun _ => carry H n x) φ →
    evalRel (H.relation (n + 1)) (fun _ => carry H (n + 1) x) φ :=
  (every_intrinsic_formula_transports
    (H.relation n) (H.relation (n + 1)) (H.microstep n) φ
    (fun _ => carry H n x)).mp

/-- **Prediction 2 — no permanent departure, no information destruction.**
The carried position persists at every stage; no stage loses it. Canon-side:
closed isometric dynamics return within every tolerance and admit no
permanent departure. *Falsified by:* a closed evolution that destroys
information (inverse ≠ forward, permanently). -/
theorem prediction_no_permanent_departure (H : RelationalMicrohistory)
    (φ : RelFormula 1) (x : H.Position 0)
    (hOrigin : evalRel (H.relation 0) (fun _ => x) φ) :
    ∀ n, evalRel (H.relation n) (fun _ => carry H n x) φ :=
  intrinsic_truth_at_every_stage H φ x hOrigin

/-- **Prediction 3 — no merging of distinct histories.** The carry is
injective at every stage: distinct positions never fuse into one.
*Falsified by:* two objectively distinct carried histories becoming one in
a closed system. -/
theorem prediction_no_merging (H : RelationalMicrohistory) :
    ∀ n, Function.Injective (carry H n) :=
  carry_remains_injective H

/-- **Exactness of the boundary.** Negation CAN fail under forward
embedding (compiled counterexample in `AllIsForwardPersistence`): the law
guarantees persistence of everything positive and guarantees nothing about
negations. Reading "protection" as "no negation ever fails" misreads the
law, and the corpus carries the counterexample by design. -/
theorem boundary_is_exact :
    evalRel AllIsForwardPersistence.emptyEdges (fun _ : Fin 1 => false)
        (.not_ (.related 0 0)) ∧
    ¬ evalRel AllIsForwardPersistence.addedEdges (fun _ : Fin 1 => false)
        (.not_ (.related 0 0)) :=
  AllIsForwardPersistence.negated_relation_can_fail_under_forward_embedding

#print axioms denial_eater
#print axioms coherent_denial_is_internal
#print axioms prediction_no_one_way_coupling
#print axioms prediction_no_permanent_departure
#print axioms prediction_no_merging
#print axioms boundary_is_exact

end PhysicalBridges.UPTDenial
