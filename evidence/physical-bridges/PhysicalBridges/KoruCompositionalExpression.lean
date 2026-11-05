import PhysicalBridges.KoruFullOperatorSignature

/-!
# Compositional Koru — entire operator expressions under actual BCRD W

6 November 2026. Additive to draft #341, no changes to the canonical summit.

The old Koru keeps a binary relation on positions, and the strengthened
OperationalWeb retains a signature of arbitrary-arity operators, guards and
their enactments. This module adds the missing arbitrarily *nested expressions*.

Each expression retains:
* the exact operator constructor, including its arity;
* the ordered list of child expressions, not merely an evaluated number;
* the source particulars at the leaves;
* a compositional evaluation into the one operational web.

Renaming transports the *whole syntax* and preserves its interpretation
under complete signature reindexing. For a true SAME-SOURCE symmetry the
mathematical theorem additionally requires independently demonstrated
preservation of the particular operator behavior.

Crucially, the actual frozen BCRD W matrix evolution supplies such a
same-source symmetry for one nontrivial operational signature containing:
identity, transpose and multiplication, with the intrinsic trace-pair
relation. This is a proof about arbitrary nested compositions of those
operators, not only three prechosen matrices.

It does not establish that the frozen W sector exhausts real physics, that
all physical BCRD operators have been enumerated, or that authentic subjective
authorization/OriginalX3 are expressible in this signature.
-/

namespace PhysicalBridges.KoruCompositionalExpression

open PhysicalBridges.KoruFullOperatorSignature
open PhysicalBridges.Koru
open PhysicalBridges.BCRDOperatorAlgebra
open PhysicalBridges.FrozenBCRDEvents

universe u v

/-- Full term syntax, with arbitrary operator arity and ordered operands.
No equality of scalar outputs identifies two different expression trees. -/
inductive Expr (P : Type u) (Op : Nat → Type v) where
  | atom : P → Expr P Op
  | apply : {n : Nat} → Op n → (Fin n → Expr P Op) → Expr P Op

/-- Reindex every leaf, retaining each operator identity, arity and
ordered tree of subexpressions without modification. -/
def mapAtoms {P Q : Type u} {Op : Nat → Type v}
    (f : P → Q) : Expr P Op → Expr Q Op
  | .atom p => .atom (f p)
  | .apply op args => .apply op (fun i => mapAtoms f (args i))

/-- Interpret an entire expression using the single source's own
operator family; all nested results arise compositionally. -/
def evaluate {P : Type u} {Op : Nat → Type v}
    (W : OperationalWeb P Op) : Expr P Op → P
  | .atom p => p
  | .apply op args => W.enact op (fun i => evaluate W (args i))

/-- This recursively checks the enabling/guard relation at EVERY
internal operator node, not just at the root. -/
def WellFormed {P : Type u} {Op : Nat → Type v}
    (W : OperationalWeb P Op) : Expr P Op → Prop
  | .atom _ => True
  | .apply op args =>
      (∀ i, WellFormed W (args i)) ∧
      W.enabled op (fun i => evaluate W (args i))

/-- The complete interpretation of a nested expression commutes with
whole-signature REINDEXING. This is a change of presentation, not yet
a physical evolution law. -/
theorem evaluate_reindex_covariant
    {P : Type u} {Op : Nat → Type v}
    (σ : Reindex P) (W : OperationalWeb P Op)
    (e : Expr P Op) :
    evaluate (reindexOperationalWeb σ W) (mapAtoms σ.to e) =
      σ.to (evaluate W e) := by
  induction e with
  | atom p => rfl
  | @apply n op args ih =>
      change σ.to (W.enact op (fun i =>
        σ.inv (evaluate (reindexOperationalWeb σ W)
          (mapAtoms σ.to (args i))))) =
        σ.to (W.enact op (fun i => evaluate W (args i)))
      have hArgs :
          (fun i => σ.inv
            (evaluate (reindexOperationalWeb σ W)
              (mapAtoms σ.to (args i)))) =
          (fun i => evaluate W (args i)) := by
        funext i
        rw [ih i, σ.left]
      rw [hArgs]

/-- Enabling/definedness of the WHOLE recursively composed expression
also survives the complete change of representation. -/
theorem wellformed_reindex_iff
    {P : Type u} {Op : Nat → Type v}
    (σ : Reindex P) (W : OperationalWeb P Op)
    (e : Expr P Op) :
    WellFormed (reindexOperationalWeb σ W) (mapAtoms σ.to e) ↔
      WellFormed W e := by
  induction e with
  | atom p => exact Iff.rfl
  | @apply n op args ih =>
      change
        ((∀ i, WellFormed (reindexOperationalWeb σ W)
          (mapAtoms σ.to (args i))) ∧
         (reindexOperationalWeb σ W).enabled op (fun i =>
           evaluate (reindexOperationalWeb σ W)
             (mapAtoms σ.to (args i)))) ↔
        ((∀ i, WellFormed W (args i)) ∧
         W.enabled op (fun i => evaluate W (args i)))
      constructor
      · rintro ⟨hChildren, hEnabled⟩
        constructor
        · intro i
          exact (ih i).mp (hChildren i)
        · have hArguments :
            (fun i => evaluate (reindexOperationalWeb σ W)
                (mapAtoms σ.to (args i))) =
              (fun i => σ.to (evaluate W (args i))) := by
            funext i
            exact evaluate_reindex_covariant σ W (args i)
          rw [hArguments] at hEnabled
          exact (reindex_preserves_enabledness σ W op
            (fun i => evaluate W (args i))).mp hEnabled
      · rintro ⟨hChildren, hEnabled⟩
        constructor
        · intro i
          exact (ih i).mpr (hChildren i)
        · have hArguments :
            (fun i => evaluate (reindexOperationalWeb σ W)
                (mapAtoms σ.to (args i))) =
              (fun i => σ.to (evaluate W (args i))) := by
            funext i
            exact evaluate_reindex_covariant σ W (args i)
          rw [hArguments]
          exact (reindex_preserves_enabledness σ W op
            (fun i => evaluate W (args i))).mpr hEnabled

/-- Stronger SAME-SOURCE result: when a physical symmetry preserves
the actual source operators (not merely their transported description),
it preserves EVERY arbitrarily nested expression. -/
theorem evaluate_same_source_symmetry
    {P : Type u} {Op : Nat → Type v}
    (σ : Reindex P) (W : OperationalWeb P Op)
    (hFull : PreservesFullSignature σ W)
    (e : Expr P Op) :
    evaluate W (mapAtoms σ.to e) = σ.to (evaluate W e) := by
  induction e with
  | atom p => rfl
  | @apply n op args ih =>
      change W.enact op
        (fun i => evaluate W (mapAtoms σ.to (args i))) =
          σ.to (W.enact op (fun i => evaluate W (args i)))
      have hArgs :
          (fun i => evaluate W (mapAtoms σ.to (args i))) =
            (fun i => σ.to (evaluate W (args i))) := by
        funext i
        exact ih i
      rw [hArgs]
      exact hFull.2.2 op (fun i => evaluate W (args i))

/-- A physical source-signature symmetry also retains EACH guard
condition at each level of the composite, not just the final output. -/
theorem wellformed_same_source_symmetry
    {P : Type u} {Op : Nat → Type v}
    (σ : Reindex P) (W : OperationalWeb P Op)
    (hFull : PreservesFullSignature σ W)
    (e : Expr P Op) :
    WellFormed W (mapAtoms σ.to e) ↔ WellFormed W e := by
  induction e with
  | atom p => exact Iff.rfl
  | @apply n op args ih =>
      change
        ((∀ i, WellFormed W (mapAtoms σ.to (args i))) ∧
          W.enabled op (fun i =>
            evaluate W (mapAtoms σ.to (args i)))) ↔
         ((∀ i, WellFormed W (args i)) ∧
          W.enabled op (fun i => evaluate W (args i)))
      have hArguments :
          (fun i => evaluate W (mapAtoms σ.to (args i))) =
            (fun i => σ.to (evaluate W (args i))) := by
        funext i
        exact evaluate_same_source_symmetry σ W hFull (args i)
      rw [hArguments]
      exact and_congr
        (forall_congr' (fun i => ih i))
        (hFull.2.1 op (fun i => evaluate W (args i)))

/-- Frozen six-position W source supports three nontrivial intrinsic
operator types with arities 0, 1, 2. -/
inductive WOperator : Nat → Type where
  | identity : WOperator 0
  | transpose : WOperator 1
  | multiply : WOperator 2

/-- A genuine nonempty source relation, preserved by W via the
independently established trace-pair form invariant. -/
def matrixOperationalWeb : OperationalWeb Matrix6 WOperator where
  link := fun A B => trace (mul A B) = 0
  enabled := fun {_n} _op _xs => True
  enact := fun {_n} op xs =>
    match op with
    | .identity => identityMatrix
    | .transpose => transpose (xs 0)
    | .multiply => mul (xs 0) (xs 1)

/-- The W-conjugation is an actual fixed source operator, not a free
reindexing parameter; its inverse is itself, kernel-checked above. -/
def frozenWReindex : Reindex Matrix6 where
  to := evolve
  inv := evolve
  left := evolve_involutive
  right := evolve_involutive

/-- Physical SOURCE certificate: the exact frozen W evolution is an
automorphism of the full specified operator signature, not only
of the six site labels or the one binary link.

The nontrivial link's invariance uses preservation of trace(A B).
The operator laws use unit, transpose and product preservation from
BCRDOperatorAlgebra, independently derived from frozen W entries. -/
theorem frozen_W_preserves_complete_specified_signature :
    PreservesFullSignature frozenWReindex matrixOperationalWeb := by
  refine ⟨?_, ?_, ?_⟩
  · intro A B
    change (trace (mul (evolve A) (evolve B)) = 0) ↔
      trace (mul A B) = 0
    rw [evolve_preserves_trace_form]
  · intro n op xs
    exact Iff.rfl
  · intro n op xs
    cases op with
    | identity =>
        change identityMatrix = evolve identityMatrix
        exact evolve_preserves_identity.symm
    | transpose =>
        change transpose (evolve (xs 0)) =
          evolve (transpose (xs 0))
        exact (evolve_preserves_transpose _).symm
    | multiply =>
        change mul (evolve (xs 0)) (evolve (xs 1)) =
          evolve (mul (xs 0) (xs 1))
        exact (evolve_preserves_product _ _).symm

/-- Frozen-W source theorem for ALL nested expressions of any finite
size built from identity, transpose and multiplication. This is
stronger than the three-input example in #341. -/
theorem frozen_W_preserves_every_composite_operator_expression
    (e : Expr Matrix6 WOperator) :
    evaluate matrixOperationalWeb (mapAtoms evolve e) =
      evolve (evaluate matrixOperationalWeb e) :=
  evaluate_same_source_symmetry
    frozenWReindex matrixOperationalWeb
    frozen_W_preserves_complete_specified_signature e

/-- Every guard on every nested operator is preserved as well. -/
theorem frozen_W_preserves_every_composite_guard
    (e : Expr Matrix6 WOperator) :
    WellFormed matrixOperationalWeb (mapAtoms evolve e) ↔
      WellFormed matrixOperationalWeb e :=
  wellformed_same_source_symmetry
    frozenWReindex matrixOperationalWeb
    frozen_W_preserves_complete_specified_signature e


/-! ## Full-expression provenance and arbitrary finite frozen-W histories

The result of evaluating an expression may coincide with the result of
another expression. The **full syntax tree** must not be identified
with that result. We now prove the source transport itself is injective
on exact expressions, including every nested operator occurrence.
-/

/-- Map every source position through two reindexings IN ORDER;
the operator tree itself is unchanged. -/
theorem mapAtoms_comp
    {P Q R : Type u} {Op : Nat → Type v}
    (f : P → Q) (g : Q → R) (e : Expr P Op) :
    mapAtoms g (mapAtoms f e) =
      mapAtoms (fun p => g (f p)) e := by
  induction e with
  | atom p => rfl
  | @apply n op args ih =>
      simp only [mapAtoms]
      congr 1
      funext i
      exact ih i

theorem mapAtoms_id
    {P : Type u} {Op : Nat → Type v} (e : Expr P Op) :
    mapAtoms (fun p => p) e = e := by
  induction e with
  | atom p => rfl
  | @apply n op args ih =>
      simp only [mapAtoms]
      congr 1
      funext i
      exact ih i

/-- A complete Koru syntax tree survives and can be reconstructed
under a genuine reversible source reindexing, including the operator
identities and ordering that value-only approaches discard. -/
theorem mapAtoms_inverse
    {P : Type u} {Op : Nat → Type v}
    (σ : Reindex P) (e : Expr P Op) :
    mapAtoms σ.inv (mapAtoms σ.to e) = e := by
  rw [mapAtoms_comp]
  have hfun :
      (fun p => σ.inv (σ.to p)) = (fun p => p) := by
    funext p
    exact σ.left p
  rw [hfun, mapAtoms_id]

/-- Whole-expression nonmerging: complete operator expressions stay
distinct, even when they evaluate to the same numerical result. -/
theorem mapAtoms_no_expression_merging
    {P : Type u} {Op : Nat → Type v}
    (σ : Reindex P) :
    Function.Injective
      (fun e : Expr P Op => mapAtoms σ.to e) := by
  intro a b hSame
  have hUndo := congrArg
    (fun e : Expr P Op => mapAtoms σ.inv e) hSame
  simpa only [mapAtoms_inverse] using hUndo

/-- The exact frozen source W evolution, iterated over any finite
number of source steps (no external chronological clock). -/
def frozenWIter : Nat → Matrix6 → Matrix6
  | 0 => fun A => A
  | n + 1 => fun A => evolve (frozenWIter n A)

/-- Every finite stage carries EVERY finitely nested W-operator expression.
This strengthens one-step covariance to entire source-generated histories. -/
theorem frozen_W_preserves_every_composite_at_every_stage
    (n : Nat) (e : Expr Matrix6 WOperator) :
    evaluate matrixOperationalWeb (mapAtoms (frozenWIter n) e) =
      frozenWIter n (evaluate matrixOperationalWeb e) := by
  induction n with
  | zero =>
      change evaluate matrixOperationalWeb
        (mapAtoms (fun A : Matrix6 => A) e) =
        evaluate matrixOperationalWeb e
      rw [mapAtoms_id]
  | succ n ih =>
      change evaluate matrixOperationalWeb
        (mapAtoms (fun A => evolve (frozenWIter n A)) e) =
        evolve (frozenWIter n (evaluate matrixOperationalWeb e))
      rw [← mapAtoms_comp (frozenWIter n) evolve e]
      rw [frozen_W_preserves_every_composite_operator_expression, ih]

/-- All internal operator-enabling conditions stay valid or invalid
through the SAME source W history, rather than just at one endpoint. -/
theorem frozen_W_preserves_all_guards_at_every_stage
    (n : Nat) (e : Expr Matrix6 WOperator) :
    WellFormed matrixOperationalWeb (mapAtoms (frozenWIter n) e) ↔
      WellFormed matrixOperationalWeb e := by
  induction n with
  | zero =>
      change WellFormed matrixOperationalWeb
        (mapAtoms (fun A : Matrix6 => A) e) ↔
        WellFormed matrixOperationalWeb e
      rw [mapAtoms_id]
  | succ n ih =>
      change WellFormed matrixOperationalWeb
        (mapAtoms (fun A => evolve (frozenWIter n A)) e) ↔
        WellFormed matrixOperationalWeb e
      rw [← mapAtoms_comp (frozenWIter n) evolve e]
      exact (frozen_W_preserves_every_composite_guard
        (mapAtoms (frozenWIter n) e)).trans ih

/-- A source-generated W step never merges distinct full expressions,
including operator identities, ordered operands or nested structure. -/
theorem frozen_W_one_step_expr_injective :
    Function.Injective
      (fun e : Expr Matrix6 WOperator => mapAtoms evolve e) :=
  mapAtoms_no_expression_merging frozenWReindex

/-- Nor can any FINITE number of actual W steps merge two distinct
complete expressions: retain their entire histories, not a scalar score. -/
theorem frozen_W_expression_histories_do_not_merge
    (n : Nat) :
    Function.Injective
      (fun e : Expr Matrix6 WOperator => mapAtoms (frozenWIter n) e) := by
  induction n with
  | zero =>
      intro a b h
      change mapAtoms (fun A : Matrix6 => A) a =
        mapAtoms (fun A : Matrix6 => A) b at h
      simpa only [mapAtoms_id] using h
  | succ n ih =>
      intro a b h
      change
        mapAtoms (fun A => evolve (frozenWIter n A)) a =
        mapAtoms (fun A => evolve (frozenWIter n A)) b at h
      rw [← mapAtoms_comp (frozenWIter n) evolve a,
          ← mapAtoms_comp (frozenWIter n) evolve b] at h
      have hEarlier :
          mapAtoms (frozenWIter n) a =
            mapAtoms (frozenWIter n) b :=
        frozen_W_one_step_expr_injective h
      exact ih hEarlier

#print axioms mapAtoms_comp
#print axioms mapAtoms_id
#print axioms mapAtoms_inverse
#print axioms mapAtoms_no_expression_merging
#print axioms frozen_W_preserves_every_composite_at_every_stage
#print axioms frozen_W_preserves_all_guards_at_every_stage
#print axioms frozen_W_one_step_expr_injective
#print axioms frozen_W_expression_histories_do_not_merge

#print axioms evaluate_reindex_covariant
#print axioms wellformed_reindex_iff
#print axioms evaluate_same_source_symmetry
#print axioms wellformed_same_source_symmetry
#print axioms frozen_W_preserves_complete_specified_signature
#print axioms frozen_W_preserves_every_composite_operator_expression
#print axioms frozen_W_preserves_every_composite_guard

end PhysicalBridges.KoruCompositionalExpression
