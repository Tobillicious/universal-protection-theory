import PhysicalBridges.SummitIntrinsicDefinability
import PhysicalBridges.OriginalX3Full

/-!
# Hostile control: ALL IS automorphism does not entail six-component X3

4 November 2026. Independent review countermodel, not a physical BCRD model.

The real positive result in SummitIntrinsicDefinability is retained unchanged:
every property definable in the intrinsic first-order language survives a
bijective automorphism of the whole relational structure.

The additional claim that arbitrary actual physical transitions preserve
all six original X3 duties does NOT follow from that theorem until the
physical transition, owed particulars, within-event transport, and X3
semantics are connected to those intrinsic relations independently.

This countermodel has a valid AllIsActuality, a valid full relational
automorphism, and real changing configuration states. It exhibits a first
violation of OriginalX3, since the subject's continuing process ends while
the intrinsic relation itself is left unchanged. The failure is semantic
correspondence, NOT a counterexample to a fully-specified ontological law
or to source-validated BCRD physical dynamics.
-/

namespace PhysicalBridges.HostileFrozenSummitControl

open PhysicalBridges.AllIsActuality
open PhysicalBridges.SummitIntrinsicDefinability
open PhysicalBridges.OriginalX3Full

/-- The identity reindexing is always a genuine whole-relation
automorphism. It does not by itself govern process-state changes. -/
def identityRelationalAutomorphism {P : Type}
    (W : AllIsActuality P) : RelationalAutomorphism W.rel where
  to := id
  undo := id
  leftInverse := by intro _; rfl
  rightInverse := by intro _; rfl
  preservesRelation := by intro _ _; exact Iff.rfl

/-- One independently described state transition from active to ended. -/
def firstLossStep (s t : Bool) : Prop :=
  s = true ∧ t = false

/-- A first-stage source duty for every particular, deliberately NOT
asserted to be determined by the intrinsic relation. -/
def everyParticularOwed (_s : Bool) (_x : Bool) : Prop :=
  True

/-- Only the historical-continuity component is allowed to fail.
The other five duties are set to True, making the failure unambiguous. -/
def stepHasFullOriginalX3 (s t : Bool) (x : Bool) : Prop :=
  OriginalX3
    (fun _ t _ => t = true)
    (fun _ _ _ => True)
    (fun _ _ _ => True)
    (fun _ _ _ => True)
    (fun _ _ _ => True)
    (fun _ _ _ => True)
    s t x

/-- The EXACT missing join after #279: even all the intrinsic
first-order automorphism invariants may hold while a separate
process-state transition loses historical continuity. This proves
a scope limit for the thin AllIsActuality formalisation, not for a
stronger physically completed ALL IS ontology. -/
theorem first_full_x3_loss_compatible_with_thin_all_is_automorphism :
    ∃ (W : AllIsActuality Bool)
      (A : RelationalAutomorphism W.rel),
        (∀ φ : RelFormula 1,
          evalRel W.rel (fun _ => false) φ ↔
          evalRel W.rel (fun _ => A.to false) φ) ∧
        ¬ DecisiveSummitTest W Bool firstLossStep
            everyParticularOwed stepHasFullOriginalX3 := by
  obtain ⟨W⟩ := allIsActuality_has_content
  refine ⟨W, identityRelationalAutomorphism W, ?_, ?_⟩
  · intro φ
    exact intrinsic_formula_is_automorphism_invariant
      W.rel (identityRelationalAutomorphism W) φ (fun _ => false)
  · intro hSummit
    have hEvent : stepHasFullOriginalX3 true false false :=
      hSummit true false false ⟨rfl, rfl⟩ trivial
    have hImpossible : (false : Bool) = true := hEvent.historicalContinuity
    cases hImpossible

/-!
Post-freeze hostile control for PR #280.
The theorem "the source permutation preserves the relation i = permutation j"
is generic to ANY involution when that relation is defined from the
permutation itself. It is a genuine group-theoretic fact, but does not
show preservation of a separately justified complete relational ontology.
-/

/-- Every involution preserves the graph relation deliberately built
from that very involution. No BCRD physics or X3 semantics are required. -/
def graphAutomorphismOfAnyInvolution {P : Type}
    (f : P → P) (hInvolution : ∀ x, f (f x) = x) :
    RelationalAutomorphism (fun x y => x = f y) where
  to := f
  undo := f
  leftInverse := hInvolution
  rightInverse := hInvolution
  preservesRelation := by
    intro x y
    constructor
    · intro h
      exact congrArg f h
    · intro h
      calc
        x = f (f x) := (hInvolution x).symm
        _ = f (f (f y)) := congrArg f h
        _ = f y := hInvolution (f y)

/-- The relation construction's validity is automatic for any
involution, independently of a proposed physical source relation. -/
theorem graph_source_relation_is_not_an_independent_covariance_test
    {P : Type} (f : P → P) (hInvolution : ∀ x, f (f x) = x) :
    ∀ x y, (x = f y) ↔ (f x = f (f y)) :=
  (graphAutomorphismOfAnyInvolution f hInvolution).preservesRelation

#print axioms graphAutomorphismOfAnyInvolution
#print axioms graph_source_relation_is_not_an_independent_covariance_test

#print axioms identityRelationalAutomorphism
#print axioms first_full_x3_loss_compatible_with_thin_all_is_automorphism

end PhysicalBridges.HostileFrozenSummitControl
