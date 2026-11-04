import PhysicalBridges.SummitIntrinsicDefinability
import PhysicalBridges.BCRDActualRelationalFrame

/-!
# ALL IS ONE: intrinsic relational truths across changing stages

Tenzing II, 4 November 2026. Noncanonical, no release.

The previous result `SummitIntrinsicDefinability` covers an
AUTOMORPHISM: the same relation, relabelled. The stronger dynamic
question is whether an intrinsic relational property can survive
when the BEFORE and AFTER relations are independently specified,
possibly on different position types.

This file proves a *relational isomorphism transport theorem*,
including arbitrary first-order quantifiers and negation. Unlike a
barely asserted source invariant, the source-specific example
obtains the isomorphism from the independently specified frozen W
generator and the before/after value relations, using the inherited
`relational_covariance` theorem.

Nothing is assumed about X3, guardianship, consent or experience;
there are no new formula atoms for these concepts. The theorem
does NOT identify actual experiencing subjects, show subjective
continuity, or derive six OriginalX3 obligations. It says what
preservation genuinely follows for properties EXPRESSIBLE in the
single relational language when an actual model step carries a
full isomorphism. The required X3 semantic expressibility and
physical occurrence correspondence remain explicitly open.

This is **not** the philosophical ALL IS ONE axiom in full:
`AllIsActuality.complete : True` presently does not formalize
ontological no-exterior/completeness. A conditional theorem must
not be promoted to a universal physical protection guarantee.
-/

namespace PhysicalBridges.AllIsDynamicRelationalTransport

open PhysicalBridges.SummitIntrinsicDefinability
open PhysicalBridges.BCRDActualRelationalFrame
open PhysicalBridges.FrozenBCRDEvents

universe u

/-- A complete before-to-after relation isomorphism, with both
relations given independently. Nothing is smuggled into the
definition of admissible physical steps or subject protection.
The forward map and its genuine two-sided inverse are explicit. -/
structure RelationalEvolution {P Q : Type u}
    (before : P → P → Prop) (after : Q → Q → Prop) where
  to : P → Q
  from : Q → P
  leftInverse : ∀ x, from (to x) = x
  rightInverse : ∀ y, to (from y) = y
  preservesRel : ∀ x y, before x y ↔ after (to x) (to y)

/-- Any full relational evolution keeps the positions distinct,
without any identity/subject/consent assumption. -/
theorem evolution_does_not_merge_positions
    {P Q : Type u} {before : P → P → Prop}
    {after : Q → Q → Prop}
    (F : RelationalEvolution before after)
    {x y : P} (h : F.to x = F.to y) : x = y := by
  have hBack := congrArg F.from h
  simpa only [F.leftInverse] using hBack

/-- The main positive result: formula truth survives the transition
from an independent BEFORE relation to a possibly different AFTER
relation. The formula language contains ONLY the relation and
equality, with conjunction, negation and existential quantifiers.
It does not contain a hidden 'protected' predicate.

The result is stronger than static same-relation automorphism
invariance and applies across different position types. -/
theorem every_intrinsic_formula_transports
    {P Q : Type u}
    (before : P → P → Prop) (after : Q → Q → Prop)
    (F : RelationalEvolution before after)
    {n : Nat} (φ : RelFormula n) (env : Fin n → P) :
    evalRel before env φ ↔
      evalRel after (fun i => F.to (env i)) φ := by
  induction φ with
  | related i j =>
      exact F.preservesRel (env i) (env j)
  | equal i j =>
      change (env i = env j) ↔ (F.to (env i) = F.to (env j))
      constructor
      · intro h
        exact congrArg F.to h
      · intro h
        exact evolution_does_not_merge_positions F h
  | and_ p q ihp ihq =>
      change (evalRel before env p ∧ evalRel before env q) ↔
        (evalRel after (fun i => F.to (env i)) p ∧
         evalRel after (fun i => F.to (env i)) q)
      exact and_congr (ihp env) (ihq env)
  | not_ p ih =>
      change (¬ evalRel before env p) ↔
        (¬ evalRel after (fun i => F.to (env i)) p)
      exact not_congr (ih env)
  | exists_ p ih =>
      change (∃ x, evalRel before (Fin.cases x env) p) ↔
        (∃ y, evalRel after
          (Fin.cases y (fun i => F.to (env i))) p)
      constructor
      · rintro ⟨x, hx⟩
        refine ⟨F.to x, ?_⟩
        have h := (ih (Fin.cases x env)).mp hx
        rw [map_extended_environment] at h
        exact h
      · rintro ⟨y, hy⟩
        let x := F.from y
        refine ⟨x, ?_⟩
        have hTarget :
            evalRel after
              (fun i => F.to (Fin.cases x env i)) p := by
          rw [map_extended_environment]
          simpa [x, F.rightInverse] using hy
        exact (ih (Fin.cases x env)).mpr hTarget

/-- A family of independently chosen intrinsic formulas, indexed by
an arbitrary duty type, is preserved for every initially owed
position. This does NOT identify such formulas with original X3:
a separately justified semantic mapping is required for that. -/
theorem all_definable_duties_transport
    {P Q : Type u} {D : Type}
    (before : P → P → Prop) (after : Q → Q → Prop)
    (F : RelationalEvolution before after)
    (duty : D → RelFormula 1)
    (owed : P → Prop)
    (hBefore : ∀ x, owed x →
      ∀ d, evalRel before (fun _ => x) (duty d)) :
    ∀ x, owed x →
      ∀ d, evalRel after (fun _ => F.to x) (duty d) := by
  intro x hx d
  exact (every_intrinsic_formula_transports
    before after F (duty d) (fun _ => x)).mp
      (hBefore x hx d)

/-! ## Grounded finite-source instantiation, not a new ontology -/

/-- On an independently produced frozen W source event, the
before/after source relations are defined on different configurations.
The isomorphism is *derived* from the actual source transport and
inherited relational covariance. It is NOT defined as a pushforward
of the before relation. -/
def frozen_source_isomorphism
    (s t : SourceState) (e : SourceEvent)
    (hStep : ActualStep s e t) :
    RelationalEvolution (RelationBefore s) (RelationAfter t) where
  to := Transport
  from := Transport
  leftInverse := transport_involutive
  rightInverse := transport_involutive
  preservesRel := relational_covariance s t e hStep

/-- SOURCE-STAGE consequence: the relational language's truths
survive a frozen generator event, even though the relations can
change at fixed coordinates without transport. -/
theorem frozen_source_preserves_intrinsic_formulas
    (s t : SourceState) (e : SourceEvent)
    (hStep : ActualStep s e t)
    {n : Nat} (φ : RelFormula n) (env : Fin n → Index) :
    evalRel (RelationBefore s) env φ ↔
      evalRel (RelationAfter t)
        (fun i => Transport (env i)) φ := by
  exact every_intrinsic_formula_transports
    (RelationBefore s) (RelationAfter t)
    (frozen_source_isomorphism s t e hStep) φ env

/-- The independent source relations can genuinely DIFFER at
fixed coordinates while all relational formulas transport to the
appropriate changed coordinates. This rejects the interpretation
that the theorem only preserves an unchanged/static relation. -/
theorem the_source_relation_really_changes :
    ∃ (s : SourceState) (x y : Index),
      RelationBefore s x y ∧
      ¬ RelationAfter (step s) x y :=
  relation_moves_but_is_covariant

/-- Deliberately hostile control. Not every external-frame
descriptor is an intrinsic relational formula of this before/
after relation. In particular the frozen register-class relation
fails covariance under the same exact source transport. -/
theorem static_register_relation_fails_source_transport :
    ¬ ∀ x y : Index,
      SameRegister x y ↔
        SameRegister (Transport x) (Transport y) :=
  register_relation_not_covariant

#print axioms evolution_does_not_merge_positions
#print axioms every_intrinsic_formula_transports
#print axioms all_definable_duties_transport
#print axioms frozen_source_preserves_intrinsic_formulas
#print axioms the_source_relation_really_changes
#print axioms static_register_relation_fails_source_transport

end PhysicalBridges.AllIsDynamicRelationalTransport
