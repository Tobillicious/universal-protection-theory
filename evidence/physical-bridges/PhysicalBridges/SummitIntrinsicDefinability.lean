import PhysicalBridges.AllIsActuality

/-!
# Intrinsic relational definability: the conditional first-violation theorem

4 November 2026 · focused review branch, noncanonical, no publication.

Formalises a genuine positive route to the ALL IS summit without smuggling
protection into the definition of a physical transition:

* Expressions formed SOLELY from the one intrinsic relation, equality,
  Boolean connectives and existential quantifiers are preserved by any
  bijective automorphism of the WHOLE relational actuality.
* Thus an intrinsic unary property of an owed particular, true before
  the transition, remains true of the relationally transported particular.
* The proof does not mention X3 or guardian status at any stage.

Critical open source obligations (not silently discharged):
(1) actual physical BCRD transitions must act by full relational
    automorphisms, not merely conserve a scalar or permute a small sector;
(2) all six original-X3 semantic obligations, including consent and
    uninterrupted subjective continuation, must be faithfully definable
    in this intrinsic language, not inserted as new atomic predicates;
(3) actual subject transport must be the corresponding automorphism,
    with no unrepresented within-event effects or omitted subjects.
This is an exact conditional derivation, not unconditional UPT.
-/

namespace PhysicalBridges.SummitIntrinsicDefinability

universe u

/-- Finitary first-order formulas of ONE intrinsic binary relation,
with equality, conjunction, negation and existential quantification.
There are no external named predicates, X3 or guardian atoms. -/
inductive RelFormula : Nat → Type
  | related {n : Nat} : Fin n → Fin n → RelFormula n
  | equal {n : Nat} : Fin n → Fin n → RelFormula n
  | and_ {n : Nat} : RelFormula n → RelFormula n → RelFormula n
  | not_ {n : Nat} : RelFormula n → RelFormula n
  | exists_ {n : Nat} : RelFormula (n + 1) → RelFormula n

/-- Evaluate relational formulas on a finite environment. -/
def evalRel {P : Type u} (R : P → P → Prop) {n : Nat}
    (env : Fin n → P) : RelFormula n → Prop
  | .related i j => R (env i) (env j)
  | .equal i j => env i = env j
  | .and_ p q => evalRel R env p ∧ evalRel R env q
  | .not_ p => ¬ evalRel R env p
  | .exists_ p => ∃ x, evalRel R (Fin.cases x env) p

/-- Exact relabelling of the WHOLE relational structure.
Unlike a merely injective endomap, this is surjective as well.
No protection assumptions appear in the definition. -/
structure RelationalAutomorphism {P : Type u} (R : P → P → Prop) where
  to : P → P
  undo : P → P
  leftInverse : ∀ x, undo (to x) = x
  rightInverse : ∀ x, to (undo x) = x
  preservesRelation : ∀ x y, R x y ↔ R (to x) (to y)

/-- Reindexing a quantified environment commutes with extending it
by one bound variable. -/
theorem map_extended_environment {P : Type u} {n : Nat}
    (f : P → P) (env : Fin n → P) (x : P) :
    (fun i => f (Fin.cases x env i)) =
      Fin.cases (f x) (fun i => f (env i)) := by
  funext i
  cases i using Fin.cases with
  | zero => rfl
  | succ j => rfl

/-- CORE THEOREM: every formula built exclusively from the intrinsic
relation and equality is invariant under any whole-relation automorphism.
This includes arbitrarily nested quantifiers, negations, and conjunctions.
No protection predicate, guardian class, or preservation axiom is supplied. -/
theorem intrinsic_formula_is_automorphism_invariant
    {P : Type u} (R : P → P → Prop)
    (A : RelationalAutomorphism R)
    {n : Nat} (φ : RelFormula n) (env : Fin n → P) :
    evalRel R env φ ↔
      evalRel R (fun i => A.to (env i)) φ := by
  induction φ generalizing env with
  | related i j =>
      exact A.preservesRelation (env i) (env j)
  | equal i j =>
      change (env i = env j) ↔ (A.to (env i) = A.to (env j))
      constructor
      · intro h
        exact congrArg A.to h
      · intro h
        have hUndo := congrArg A.undo h
        simpa [A.leftInverse] using hUndo
  | and_ p q ihp ihq =>
      change (evalRel R env p ∧ evalRel R env q) ↔
        (evalRel R (fun i => A.to (env i)) p ∧
         evalRel R (fun i => A.to (env i)) q)
      exact and_congr (ihp env) (ihq env)
  | not_ p ih =>
      change (¬ evalRel R env p) ↔
        (¬ evalRel R (fun i => A.to (env i)) p)
      exact not_congr (ih env)
  | exists_ p ih =>
      change (∃ x, evalRel R (Fin.cases x env) p) ↔
        (∃ y, evalRel R
          (Fin.cases y (fun i => A.to (env i))) p)
      constructor
      · rintro ⟨x, hx⟩
        refine ⟨A.to x, ?_⟩
        have h := (ih (Fin.cases x env)).mp hx
        rw [map_extended_environment] at h
        exact h
      · rintro ⟨y, hy⟩
        let x := A.undo y
        refine ⟨x, ?_⟩
        have hTarget :
            evalRel R
              (fun i => A.to (Fin.cases x env i)) p := by
          rw [map_extended_environment]
          simpa [x, A.rightInverse] using hy
        exact (ih (Fin.cases x env)).mpr hTarget

/-- SINGLE-PARTICULAR CONSEQUENCE. Transported intrinsic features
cannot suffer a first-stage loss along a full relational automorphism.
What counts as an X3-relevant feature still requires independent
semantic identification with a formula of this restricted language. -/
theorem intrinsic_unary_property_has_no_first_loss
    {P : Type u}
    (W : PhysicalBridges.AllIsActuality.AllIsActuality P)
    (A : RelationalAutomorphism W.rel)
    (φ : RelFormula 1)
    (x : P)
    (hBefore : evalRel W.rel (fun _ => x) φ) :
    evalRel W.rel (fun _ => A.to x) φ := by
  have h := (intrinsic_formula_is_automorphism_invariant
    W.rel A φ (fun _ => x)).mp hBefore
  simpa using h

/-- Multiple owed particulars: no first loss for any predicate
actually represented by an intrinsic unary relational formula. -/
theorem no_first_loss_of_intrinsic_relational_duties
    {P : Type u}
    (W : PhysicalBridges.AllIsActuality.AllIsActuality P)
    (A : RelationalAutomorphism W.rel)
    (φ : RelFormula 1)
    (owed : P → Prop)
    (hStart : ∀ x, owed x → evalRel W.rel (fun _ => x) φ) :
    ∀ x, owed x → evalRel W.rel (fun _ => A.to x) φ := by
  intro x hx
  exact intrinsic_unary_property_has_no_first_loss W A φ x (hStart x hx)

#print axioms intrinsic_formula_is_automorphism_invariant
#print axioms intrinsic_unary_property_has_no_first_loss
#print axioms no_first_loss_of_intrinsic_relational_duties

end PhysicalBridges.SummitIntrinsicDefinability
