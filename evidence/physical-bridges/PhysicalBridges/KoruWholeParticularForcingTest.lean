import PhysicalBridges.AllIsActuality
import PhysicalBridges.SummitIntrinsicDefinability
import PhysicalBridges.OriginalX3Full

/-!
# Exact test: does the existing ALL IS formal ontology force all original X3?

This targets the exact old summit question, not a weakened replacement.
It supplies a two-position relational actuality satisfying EVERY FIELD of
`AllIsActuality`, a source-covariant invertible internal step, and the FULL
unweakened six-component `OriginalX3` type. Historical continuity fails on
that step. The complete source transition and every local first-order
invariant of the specified intrinsic binary relation remain coherent.

This is a counterexample ONLY to forcing from the *currently formalised*
ALL IS signature / that single relation; it is not a BCRD-complete physical
counterexample. In particular, Koru as proposed by the author may be a
richer complete relational structure than this signature.

It also proves every first-order unary formula of this limited web is
invariant under the source flip: a formula of that limited language
cannot encode an additional stage-sensitive duty which changes.
Thus the smallest honest route to a full QED is a genuinely source-
derived richer relational signature plus actual-step preservation of
its independently identified original X3 meaning.
-/

namespace PhysicalBridges.KoruWholeParticularForcingTest

open PhysicalBridges.AllIsActuality
open PhysicalBridges.SummitIntrinsicDefinability
open PhysicalBridges.OriginalX3Full

/-- The same nontrivial no-privileged-root model used by the existing
ontology's `allIsActuality_has_content` theorem. Nothing about protection
or Guardian status is included. -/
def whole : AllIsActuality Bool where
  rel := fun a b => a ≠ b
  individuated := by decide
  noPrivileged := by
    intro a
    exact ⟨fun x => !x, by decide, by cases a <;> decide⟩
  complete := trivial

/-- A reversible transformation of the actual two-position source. -/
def flip : Bool → Bool := Bool.not

/-- A whole-web relation-preserving physical-source candidate, without
an externally supplied predicate claiming the step is safe. -/
def flipAutomorphism : RelationalAutomorphism whole.rel where
  to := flip
  undo := flip
  leftInverse := by decide
  rightInverse := by decide
  preservesRelation := by decide

/-- EVERY first-order intrinsic unary statement of the whole's binary
relation is invariant under this actual source symmetry. -/
theorem all_intrinsic_unary_formulas_are_preserved
    (φ : RelFormula 1) (a : Bool) :
    evalRel whole.rel (fun _ => a) φ ↔
      evalRel whole.rel (fun _ => flip a) φ := by
  exact intrinsic_formula_is_automorphism_invariant
    whole.rel flipAutomorphism φ (fun _ => a)

/-- A genuine step, defined independently of protection. -/
def physicalStep (s t : Bool) : Prop := t = flip s

/-- Every such step is wholly internal to the supplied relational web. -/
theorem each_physical_step_is_internal :
    ∀ s t, physicalStep s t → whole.rel s t := by decide

/-- A genuine particular-level duty, not included in the web's limited
relation: the particular's stage-sensitive historical continuation. -/
def historicalContinuation (s t : Bool) (_p : Bool) : Prop := s = t

def otherOriginalDuty (_s _t : Bool) (_p : Bool) : Prop := True

/-- Exact full original six-X3 type, not a safe=existence proxy. -/
def originalX3 (s t : Bool) (p : Bool) : Prop :=
  OriginalX3 historicalContinuation otherOriginalDuty
    otherOriginalDuty otherOriginalDuty otherOriginalDuty otherOriginalDuty s t p

/-- A real nonempty owed-particular domain. -/
def owed (_s : Bool) (_p : Bool) : Prop := True

/-- The exact previous summit target fails for this genuinely complete
model of the CURRENT SIGNATURE, despite all its symmetries. -/
theorem current_formal_ontology_does_not_force_original_x3 :
    ¬ DecisiveSummitTest whole Bool physicalStep owed originalX3 := by
  intro h
  have hStep : physicalStep true false := by decide
  have hProof : originalX3 true false true :=
    h true false true hStep trivial
  have hBad : (true : Bool) = false := hProof.historicalContinuity
  cases hBad

/-- No unary intrinsic formula of just this binary relation can
express an additional, non-symmetric `true`-only historical flag.

This proves a genuine EXPRESSIVENESS GAP, not the falsity of the
author's richer Koru or complete BCRD physical ontology. -/
theorem no_intrinsic_formula_for_orientation :
    ¬ ∃ φ : RelFormula 1,
       evalRel whole.rel (fun _ => true) φ ∧
       ¬ evalRel whole.rel (fun _ => false) φ := by
  rintro ⟨φ, hTrue, hFalse⟩
  have hSame :=
    (all_intrinsic_unary_formulas_are_preserved φ true).mp hTrue
  exact hFalse hSame

#print axioms all_intrinsic_unary_formulas_are_preserved
#print axioms each_physical_step_is_internal
#print axioms current_formal_ontology_does_not_force_original_x3
#print axioms no_intrinsic_formula_for_orientation

end PhysicalBridges.KoruWholeParticularForcingTest
