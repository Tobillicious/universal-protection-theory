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

#print axioms evaluate_reindex_covariant
#print axioms wellformed_reindex_iff
#print axioms evaluate_same_source_symmetry
#print axioms wellformed_same_source_symmetry
#print axioms frozen_W_preserves_complete_specified_signature
#print axioms frozen_W_preserves_every_composite_operator_expression
#print axioms frozen_W_preserves_every_composite_guard

end PhysicalBridges.KoruCompositionalExpression
