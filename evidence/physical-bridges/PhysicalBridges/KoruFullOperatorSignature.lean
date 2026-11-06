import PhysicalBridges.Koru
import PhysicalBridges.BCRDOperatorAlgebra

/-!
# Koru: retain the whole operator signature, not merely positions and one edge

6 November 2026. Additive strengthening; DO NOT redefine or overwrite Koru.lean
or the historic summit. The original conservative Koru names distinctions
within a binary relational web. That forgetful image does NOT contain the
identities, arities, ordered operands, enabling conditions, outputs or nested
composition laws of the operators intrinsic to the same actuality.

This formalization treats operators as a FAMILY OF INTRINSIC OPERATIONS,
indexed by arity, with one shared relational web. The names are not detachable
permissions, and the evaluation is not inferred from a scalar result.
Relabelling must transport *the entire operational signature*, including
enabledness and behavior, not merely the node positions and a binary link.

An explicit finite countercontrol has identical original Koru structures
but DIFFERENT operator behavior. Thus the old Koru is a lossy projection of
an operational web. The result does not itself prove that arbitrary physical
evolution preserves the full signature, nor original-six X3 or real consent.

The existing frozen W *-automorphism does preserve multiplication, transpose
and a nontrivial composite expression; it is an independently verified
source example of this stricter preservation requirement, not a blanket
universe-level physical law.
-/

namespace PhysicalBridges.KoruFullOperatorSignature

universe u v w

/-- A whole relational web WITH ITS INTERNAL OPERATOR FAMILY. Op n is the
operator type for precisely n ordered inputs; arity is not optional metadata.
One and the same actuality includes every operator's enabling condition
and its enacted output, together with the relation among its positions. -/
structure OperationalWeb (P : Type u) (Op : Nat → Type v) where
  link : P → P → Prop
  enabled : {n : Nat} → Op n → (Fin n → P) → Prop
  enact : {n : Nat} → Op n → (Fin n → P) → P

/-- The old Koru remembers only the intrinsic *binary link*. -/
def oldKoruProjection {P : Type u} {Op : Nat → Type v}
    (W : OperationalWeb P Op) : PhysicalBridges.Koru.Web P :=
  { link := W.link }

/-- Reindex the WHOLE web, preserving operator identity and arity, by
transporting each operation's ordered inputs, guard and output together.
The reindexing belongs to the same source, not a physical selection policy. -/
def reindexOperationalWeb {P : Type u} {Op : Nat → Type v}
    (σ : PhysicalBridges.Koru.Reindex P)
    (W : OperationalWeb P Op) : OperationalWeb P Op where
  link := fun a b => W.link (σ.inv a) (σ.inv b)
  enabled := fun {_n} op xs =>
    W.enabled op (fun i => σ.inv (xs i))
  enact := fun {_n} op xs =>
    σ.to (W.enact op (fun i => σ.inv (xs i)))

/-- Whole-source relabelling retains the entire old link. -/
theorem reindex_preserves_link
    {P : Type u} {Op : Nat → Type v}
    (σ : PhysicalBridges.Koru.Reindex P)
    (W : OperationalWeb P Op) (a b : P) :
    (reindexOperationalWeb σ W).link (σ.to a) (σ.to b) ↔
      W.link a b := by
  simp [reindexOperationalWeb, σ.left]

/-- The ORIGINAL n-ary operator and its ordering retain exactly the
same enabling/definedness truth after reindexing. -/
theorem reindex_preserves_enabledness
    {P : Type u} {Op : Nat → Type v}
    (σ : PhysicalBridges.Koru.Reindex P)
    (W : OperationalWeb P Op) {n : Nat}
    (op : Op n) (xs : Fin n → P) :
    (reindexOperationalWeb σ W).enabled op
      (fun i => σ.to (xs i)) ↔ W.enabled op xs := by
  simp [reindexOperationalWeb, σ.left]

/-- The central operational law. The OUTPUT of each exact operator
on all its ORDERED inputs is transported together. Operator labels
and arities have not been discarded or identified with a common score. -/
theorem reindex_preserves_operator_enactment
    {P : Type u} {Op : Nat → Type v}
    (σ : PhysicalBridges.Koru.Reindex P)
    (W : OperationalWeb P Op) {n : Nat}
    (op : Op n) (xs : Fin n → P) :
    (reindexOperationalWeb σ W).enact op
      (fun i => σ.to (xs i)) = σ.to (W.enact op xs) := by
  simp [reindexOperationalWeb, σ.left]

/-- Even distinct outcomes of distinct operators on the SAME inputs
remain distinguishable. A mere equality of output values does not
identify operator provenance. -/
theorem reindex_preserves_operator_output_distinctions
    {P : Type u} {Op : Nat → Type v}
    (σ : PhysicalBridges.Koru.Reindex P)
    (W : OperationalWeb P Op) {n : Nat}
    (op₁ op₂ : Op n) (xs : Fin n → P) :
    (W.enact op₁ xs ≠ W.enact op₂ xs) ↔
    (reindexOperationalWeb σ W).enact op₁
      (fun i => σ.to (xs i)) ≠
    (reindexOperationalWeb σ W).enact op₂
      (fun i => σ.to (xs i)) := by
  rw [reindex_preserves_operator_enactment,
      reindex_preserves_operator_enactment]
  constructor
  · intro h hEq
    apply h
    have hu := congrArg σ.inv hEq
    simpa only [σ.left] using hu
  · intro h hEq
    exact h (congrArg σ.to hEq)

/-- An actual, fixed-source operator symmetry is STRONGER than an
arbitrary rename: it must preserve the old relation, enabledness and
every operator action *without modifying the source operator family*.
These are concrete obligations, not inferred from non-exteriority. -/
def PreservesFullSignature {P : Type u} {Op : Nat → Type v}
    (σ : PhysicalBridges.Koru.Reindex P)
    (W : OperationalWeb P Op) : Prop :=
    (∀ a b, W.link (σ.to a) (σ.to b) ↔ W.link a b) ∧
    (∀ {n} (op : Op n) (xs : Fin n → P),
      W.enabled op (fun i => σ.to (xs i)) ↔ W.enabled op xs) ∧
    (∀ {n} (op : Op n) (xs : Fin n → P),
      W.enact op (fun i => σ.to (xs i)) = σ.to (W.enact op xs))

/-- The genuine physical same-signature criterion implies every
operator's effect is conserved in the precise equivariant sense.
This is NOT supplied by the old Koru reindex theorem alone. -/
theorem same_signature_preserves_enactment
    {P : Type u} {Op : Nat → Type v}
    (σ : PhysicalBridges.Koru.Reindex P)
    (W : OperationalWeb P Op)
    (hFull : PreservesFullSignature σ W)
    {n : Nat} (op : Op n) (xs : Fin n → P) :
    W.enact op (fun i => σ.to (xs i)) = σ.to (W.enact op xs) :=
  hFull.2.2 op xs

/-- Two independent binary operators, both internal to the same web. -/
inductive ToyOp : Nat → Type
  | first : ToyOp 2
  | and_ : ToyOp 2

/-- A specific complete source with a noncommutative left projection
and a commutative conjunction; its operator identities matter. -/
def toyWhole : OperationalWeb Bool ToyOp where
  link := fun a b => a ≠ b
  enabled := fun {_n} _op _xs => True
  enact := fun {_n} op xs =>
    match op with
    | .first => xs 0
    | .and_ => xs 0 && xs 1

/-- The exact SAME positions, binary link, arities and enabledness,
but the two operator behaviors have been interchanged. -/
def toyChanged : OperationalWeb Bool ToyOp where
  link := fun a b => a ≠ b
  enabled := fun {_n} _op _xs => True
  enact := fun {_n} op xs =>
    match op with
    | .first => xs 0 && xs 1
    | .and_ => xs 0

/-- Ordered inputs show what a scalar-only final-state comparison loses. -/
def toyInputs : Fin 2 → Bool :=
  fun i => if i = 0 then true else false

/-- Old Koru sees NO difference, yet actual operator identity/behavior
is different. The old relational model is therefore an incomplete
projection of the stronger Koru requested by the author. -/
theorem old_koru_same_but_operator_different :
    (∀ a b : Bool,
      PhysicalBridges.Koru.koru (oldKoruProjection toyWhole) a b ↔
      PhysicalBridges.Koru.koru (oldKoruProjection toyChanged) a b) ∧
    toyWhole.enact ToyOp.first toyInputs ≠
      toyChanged.enact ToyOp.first toyInputs := by
  constructor
  · intro a b
    rfl
  · decide

/-- Even without changing the source web, different operators on
the same ordered inputs can enact genuinely different outputs. -/
theorem same_inputs_distinct_operator_behavior :
    toyWhole.enact ToyOp.first toyInputs ≠
      toyWhole.enact ToyOp.and_ toyInputs := by
  decide

/-- Existing physically sourced W operator algebra: actual W
conjugation preserves product, adjoint (here transpose) and a
nontrivial NESTED expression, not just node identities or trace. -/
theorem frozen_W_respects_nested_operator_expression
    (A B C : PhysicalBridges.FrozenBCRDEvents.Matrix6) :
    PhysicalBridges.FrozenBCRDEvents.evolve
      (PhysicalBridges.FrozenBCRDEvents.mul
        (PhysicalBridges.FrozenBCRDEvents.transpose A)
        (PhysicalBridges.FrozenBCRDEvents.mul B C)) =
    PhysicalBridges.FrozenBCRDEvents.mul
      (PhysicalBridges.FrozenBCRDEvents.transpose
        (PhysicalBridges.FrozenBCRDEvents.evolve A))
      (PhysicalBridges.FrozenBCRDEvents.mul
        (PhysicalBridges.FrozenBCRDEvents.evolve B)
        (PhysicalBridges.FrozenBCRDEvents.evolve C)) := by
  rw [PhysicalBridges.BCRDOperatorAlgebra.evolve_preserves_product,
      PhysicalBridges.BCRDOperatorAlgebra.evolve_preserves_transpose,
      PhysicalBridges.BCRDOperatorAlgebra.evolve_preserves_product]


/-- The ordered inputs of a binary operator, as a source relationship
rather than two detached scalar parameters. -/
def binaryInputs {P : Type u} (a b : P) : Fin 2 → P :=
  fun i => if i = 0 then a else b

/-- Reindexing both operands and recovering their provenance gives
back the SAME ordered input pair. -/
theorem reindex_binary_inputs_left
    {P : Type u} (σ : PhysicalBridges.Koru.Reindex P) (a b : P) :
    (fun i : Fin 2 =>
      σ.inv (binaryInputs (σ.to a) (σ.to b) i)) =
        binaryInputs a b := by
  funext i
  by_cases hi : i = 0 <;> simp [binaryInputs, hi, σ.left]

/-- The inverse reindexing also respects the operand order. -/
theorem reindex_binary_inputs_inv
    {P : Type u} (σ : PhysicalBridges.Koru.Reindex P) (a b : P) :
    (fun i : Fin 2 => σ.inv (binaryInputs a b i)) =
      binaryInputs (σ.inv a) (σ.inv b) := by
  funext i
  by_cases hi : i = 0 <;> simp [binaryInputs, hi]

/-- One example of an operator's distinctive LAW, not merely its
evaluation on a particular input: it must commute on all pairs. -/
def OperatorCommutative {P : Type u} {Op : Nat → Type v}
    (W : OperationalWeb P Op) (op : Op 2) : Prop :=
  ∀ a b : P, W.enact op (binaryInputs a b) =
    W.enact op (binaryInputs b a)

/-- Whole-signature reindexing preserves AND reflects an intrinsic
operator-specific algebraic law. This strengthens output covariance
to a property of the operator's entire possible behavior. -/
theorem reindex_preserves_commutativity
    {P : Type u} {Op : Nat → Type v}
    (σ : PhysicalBridges.Koru.Reindex P)
    (W : OperationalWeb P Op) (op : Op 2) :
    OperatorCommutative (reindexOperationalWeb σ W) op ↔
      OperatorCommutative W op := by
  constructor
  · intro h a b
    have hNew := h (σ.to a) (σ.to b)
    change
      σ.to (W.enact op (fun i =>
        σ.inv (binaryInputs (σ.to a) (σ.to b) i))) =
      σ.to (W.enact op (fun i =>
        σ.inv (binaryInputs (σ.to b) (σ.to a) i))) at hNew
    rw [reindex_binary_inputs_left σ a b,
        reindex_binary_inputs_left σ b a] at hNew
    have hUndo := congrArg σ.inv hNew
    simpa only [σ.left] using hUndo
  · intro h a b
    have hOld := h (σ.inv a) (σ.inv b)
    change
      σ.to (W.enact op (fun i => σ.inv (binaryInputs a b i))) =
      σ.to (W.enact op (fun i => σ.inv (binaryInputs b a i)))
    rw [reindex_binary_inputs_inv σ a b,
        reindex_binary_inputs_inv σ b a]
    exact congrArg σ.to hOld

/-- The old Koru may not distinguish the two different operators,
but the augmented one proves different laws for them. -/
theorem toy_and_is_commutative :
    OperatorCommutative toyWhole ToyOp.and_ := by
  intro a b
  cases a <;> cases b <;> decide

theorem toy_first_is_not_commutative :
    ¬ OperatorCommutative toyWhole ToyOp.first := by
  intro h
  have hExample := h true false
  change (true : Bool) = false at hExample
  cases hExample

#print axioms reindex_preserves_link
#print axioms reindex_preserves_enabledness
#print axioms reindex_preserves_operator_enactment
#print axioms reindex_preserves_operator_output_distinctions
#print axioms same_signature_preserves_enactment
#print axioms old_koru_same_but_operator_different
#print axioms same_inputs_distinct_operator_behavior
#print axioms frozen_W_respects_nested_operator_expression
#print axioms reindex_binary_inputs_left
#print axioms reindex_binary_inputs_inv
#print axioms reindex_preserves_commutativity
#print axioms toy_and_is_commutative
#print axioms toy_first_is_not_commutative

end PhysicalBridges.KoruFullOperatorSignature
