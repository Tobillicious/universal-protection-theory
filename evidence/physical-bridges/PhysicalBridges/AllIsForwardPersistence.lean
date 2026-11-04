import PhysicalBridges.AllIsWithinEventHistory

/-!
# ALL IS: the exact preservation envelope for one-way relational evolution

Tenzing II; 4 November 2026; noncanonical and no publication.

PRs #298/#299 require an *isomorphism* at every modeled microstep,
including a TWO-SIDED inverse. But a relational actuality might undergo
fresh-node formation or irreversible evolution while retaining past
particulars. The math should not equate "survives" with "globally
invertible."

This file proves three different, precise preservation levels:

1. INJECTIVE FORWARD HOMOMORPHISM (not necessarily surjective):
   every positive existential first-order relational formula, built
   from relation, equality, and/or, and existential quantification,
   transports FORWARD across a step. Its old positions cannot merge.
2. INDUCED EMBEDDING (injective plus exact truth reflection for the
   old positions): any QUANTIFIER-FREE formula, including negation,
   transports with equivalence. It still need not be surjective.
3. WHOLE ISOMORPHISM (#298): all first-order formulas including
   nested negation/quantification transport in BOTH directions.

The hostile controls are actual countermodels, not rhetoric:
- a forward embedding can add new edges; a negated atomic fact fails;
- even an induced embedding can add new nodes satisfying an
  existential first-order sentence false in the old world;
- a finite genuine injection into a larger stage witnesses lack
  of surjectivity without merging the old source positions.

Therefore, as source-preservation claims become more permissive,
the guaranteed logical properties become more limited. We DO NOT
assert that any of these fragments equals the original six X3
semantic duties or guarantees that an experiencing particular
continues, authorizes or can refuse. All physical/ontological source
correspondence is explicitly open.
-/

namespace PhysicalBridges.AllIsForwardPersistence

open PhysicalBridges.SummitIntrinsicDefinability
open PhysicalBridges.AllIsDynamicRelationalTransport

universe u

/-- NON-surjective relational one-way embedding. The before/after
relations are independently given, with no protection predicate.
Preservation is one-way, and old positions are not merged. -/
structure ForwardEmbedding {P Q : Type u}
    (before : P → P → Prop) (after : Q → Q → Prop) where
  to : P → Q
  injective : Function.Injective to
  preservesPositiveEdges : ∀ x y, before x y → after (to x) (to y)

/-- Positive first-order relational formulas, with no negation and
no universal quantifier (though disjunction is allowed). -/
inductive PositiveFormula : Nat → Type
  | related {n : Nat} : Fin n → Fin n → PositiveFormula n
  | equal {n : Nat} : Fin n → Fin n → PositiveFormula n
  | and_ {n : Nat} : PositiveFormula n → PositiveFormula n → PositiveFormula n
  | or_ {n : Nat} : PositiveFormula n → PositiveFormula n → PositiveFormula n
  | exists_ {n : Nat} : PositiveFormula (n + 1) → PositiveFormula n

/-- Truth of a positive relational formula, independent of any
preferred action, subject status, or protective conclusion. -/
def evalPositive {P : Type u} (R : P → P → Prop)
    {n : Nat} (env : Fin n → P) : PositiveFormula n → Prop
  | .related i j => R (env i) (env j)
  | .equal i j => env i = env j
  | .and_ p q => evalPositive R env p ∧ evalPositive R env q
  | .or_ p q => evalPositive R env p ∨ evalPositive R env q
  | .exists_ p => ∃ x, evalPositive R (Fin.cases x env) p

/-- Strong positive result WITHOUT a global inverse: the truth of
every positive existential formula of the intrinsic relation is
preserved FORWARD by any relation-preserving map. Injectivity is
carried separately to prevent old-particular merger; it is not
needed by this positive-logical preservation argument. -/
theorem positive_formula_moves_forward
    {P Q : Type u}
    (before : P → P → Prop) (after : Q → Q → Prop)
    (F : ForwardEmbedding before after)
    {n : Nat} (φ : PositiveFormula n) (env : Fin n → P) :
    evalPositive before env φ →
      evalPositive after (fun i => F.to (env i)) φ := by
  induction φ with
  | related i j =>
      exact F.preservesPositiveEdges (env i) (env j)
  | equal i j =>
      intro h
      exact congrArg F.to h
  | and_ p q ihp ihq =>
      rintro ⟨hp, hq⟩
      exact ⟨ihp env hp, ihq env hq⟩
  | or_ p q ihp ihq =>
      intro h
      rcases h with hp | hq
      · exact Or.inl (ihp env hp)
      · exact Or.inr (ihq env hq)
  | exists_ p ih =>
      rintro ⟨x, hx⟩
      refine ⟨F.to x, ?_⟩
      have h := ih (Fin.cases x env) hx
      rw [map_extended_environment_between_types] at h
      exact h

/-- Independently specified potentially NON-surjective microstages.
This is a mathematical history interface; physical occurrence,
total within-event coverage and subject correspondences are open. -/
structure ForwardMicrohistory where
  Position : Nat → Type u
  relation : (n : Nat) → Position n → Position n → Prop
  microstep : (n : Nat) →
    ForwardEmbedding (relation n) (relation (n + 1))

def carry (H : ForwardMicrohistory) :
    (n : Nat) → H.Position 0 → H.Position n
  | 0 => fun x => x
  | n + 1 => fun x => (H.microstep n).to (carry H n x)

/-- A true positive intrinsic relational formula remains true
at EVERY represented microstage, without any two-sided inverse.
This covers a strictly broader class of modeled histories than #299,
but a strictly narrower class of formulas. -/
theorem positive_truth_at_every_stage
    (H : ForwardMicrohistory)
    (φ : PositiveFormula 1) (x : H.Position 0)
    (hOrigin : evalPositive (H.relation 0) (fun _ => x) φ) :
    ∀ n, evalPositive (H.relation n) (fun _ => carry H n x) φ := by
  intro n
  induction n with
  | zero =>
      simpa [carry] using hOrigin
  | succ n ih =>
      have hStep := positive_formula_moves_forward
        (H.relation n) (H.relation (n + 1))
        (H.microstep n) φ (fun _ => carry H n x) ih
      simpa [carry] using hStep

/-- No loss of a previously true positive intrinsic formula can
occur at any REPRESENTED forward relational microstep. -/
theorem no_first_loss_of_positive_intrinsic_formula
    (H : ForwardMicrohistory)
    (φ : PositiveFormula 1) (x : H.Position 0) :
    ¬ ∃ n,
      evalPositive (H.relation n) (fun _ => carry H n x) φ ∧
      ¬ evalPositive (H.relation (n + 1))
        (fun _ => carry H (n + 1) x) φ := by
  rintro ⟨n, hBefore, hLost⟩
  apply hLost
  have hNext := positive_formula_moves_forward
    (H.relation n) (H.relation (n + 1))
    (H.microstep n) φ (fun _ => carry H n x) hBefore
  simpa [carry] using hNext

/-- True source-position NONMERGING survives arbitrary one-way
microsteps because injectivity composes; no surjectivity required.
Not an experiencing-subject identity theorem. -/
theorem no_merging_of_old_positions
    (H : ForwardMicrohistory) :
    ∀ n, Function.Injective (carry H n) := by
  intro n
  induction n with
  | zero => intro x y h; exact h
  | succ n ih =>
      intro x y h
      apply ih
      apply (H.microstep n).injective
      simpa [carry] using h

/-! ## Exactness of the syntactic boundary: negation can fail -/

def emptyEdges : Bool → Bool → Prop := fun _ _ => False
def addedEdges : Bool → Bool → Prop := fun _ _ => True

def addingEdges : ForwardEmbedding emptyEdges addedEdges where
  to := id
  injective := by intro x y h; exact h
  preservesPositiveEdges := by intro x y h; exact False.elim h

/-- A negated relational property true before the forward embedding
becomes false after it. Thus forward edge-preservation does NOT
preserve full negative/closed-world semantic assertions. -/
theorem negated_relation_can_fail_under_forward_embedding :
    evalRel emptyEdges (fun _ : Fin 1 => false) (.not_ (.related 0 0)) ∧
    ¬ evalRel addedEdges (fun _ : Fin 1 => false) (.not_ (.related 0 0)) := by
  constructor
  · change ¬ False
    intro h
    exact h
  · change ¬ (¬ True)
    intro h
    exact h trivial

/-! ## Stronger non-surjective induced embeddings -/

/-- An embedding that exactly preserves AND reflects relation truth
between old positions, but may add new positions and relations
involving them. This does not supply a whole inverse. -/
structure InducedEmbedding {P Q : Type u}
    (before : P → P → Prop) (after : Q → Q → Prop) where
  to : P → Q
  injective : Function.Injective to
  reflectsEdges : ∀ x y, before x y ↔ after (to x) (to y)

/-- Quantifier-free formulas, including arbitrary nested negation. -/
def QuantifierFree {n : Nat} : RelFormula n → Prop
  | .related _ _ => True
  | .equal _ _ => True
  | .and_ p q => QuantifierFree p ∧ QuantifierFree q
  | .not_ p => QuantifierFree p
  | .exists_ _ => False

/-- Exact truth equivalence for all quantifier-free formulas under
any induced embedding; a global inverse is NOT necessary for this
fragment. Existential quantification is excluded on purpose: a
fresh target-world witness may be outside the embedding's image. -/
theorem quantifier_free_truth_invariant
    {P Q : Type u}
    (before : P → P → Prop) (after : Q → Q → Prop)
    (F : InducedEmbedding before after)
    {n : Nat} (φ : RelFormula n) (env : Fin n → P)
    (hQf : QuantifierFree φ) :
    evalRel before env φ ↔
      evalRel after (fun i => F.to (env i)) φ := by
  induction φ with
  | related i j =>
      exact F.reflectsEdges (env i) (env j)
  | equal i j =>
      change (env i = env j) ↔ (F.to (env i) = F.to (env j))
      constructor
      · intro h
        exact congrArg F.to h
      · intro h
        exact F.injective h
  | and_ p q ihp ihq =>
      change QuantifierFree p ∧ QuantifierFree q at hQf
      change (evalRel before env p ∧ evalRel before env q) ↔
        (evalRel after (fun i => F.to (env i)) p ∧
         evalRel after (fun i => F.to (env i)) q)
      exact and_congr (ihp env hQf.1) (ihq env hQf.2)
  | not_ p ih =>
      change QuantifierFree p at hQf
      change (¬ evalRel before env p) ↔
        (¬ evalRel after (fun i => F.to (env i)) p)
      exact not_congr (ih env hQf)
  | exists_ p ih =>
      change False at hQf
      exact False.elim hQf

/-! ## Independent countermodels: fresh nodes and existential truth -/

def oldEquality (x y : Bool) : Prop := x = y
def extendedEquality (x y : Fin 3) : Prop := x = y

def boolIntoThree : Bool → Fin 3
  | false => 0
  | true => 1

def freshNodeForward : ForwardEmbedding oldEquality extendedEquality where
  to := boolIntoThree
  injective := by
    intro x y h
    cases x <;> cases y <;> simp [boolIntoThree] at h ⊢
  preservesPositiveEdges := by
    intro x y h
    exact congrArg boolIntoThree h

/-- A *non-surjective* source embedding into a strictly larger
position space, with no merger of either old position. -/
theorem genuine_fresh_node_embedding_is_not_surjective :
    ¬ Function.Surjective freshNodeForward.to := by
  intro h
  obtain ⟨b, hb⟩ := h (2 : Fin 3)
  cases b <;> simp [freshNodeForward, boolIntoThree] at hb

def oldNoEdges : Unit → Unit → Prop := fun _ _ => False
def newSelfEdge : Bool → Bool → Prop :=
  fun x y => x = true ∧ y = true

def freshInducedEmbedding : InducedEmbedding oldNoEdges newSelfEdge where
  to := fun _ => false
  injective := by intro x y _; cases x; cases y; rfl
  reflectsEdges := by
    intro x y
    cases x
    cases y
    change False ↔ (false = true ∧ false = true)
    decide

def zeroEnvironment {P : Type u} : Fin 0 → P := fun i => Fin.elim0 i

/-- A full induced substructure embedding can introduce fresh
witnesses for an existential first-order sentence: absence of
self-related positions is true in the old one-node world, while
the new two-node world has a fresh self-related position. -/
theorem fresh_nodes_can_change_existential_first_order_truth :
    ¬ evalRel oldNoEdges (zeroEnvironment (P := Unit))
      (.exists_ (.related 0 0)) ∧
    evalRel newSelfEdge (zeroEnvironment (P := Bool))
      (.exists_ (.related 0 0)) := by
  constructor
  · change ¬ (∃ _ : Unit, False)
    rintro ⟨_, h⟩
    exact h
  · change ∃ x : Bool, x = true ∧ x = true
    exact ⟨true, rfl, rfl⟩

/-- The existential countermodel is a genuine induced embedding,
not a relation-preserving assumption invented after the fact. -/
theorem induced_fresh_embedding_is_non_surjective :
    ¬ Function.Surjective freshInducedEmbedding.to := by
  intro h
  obtain ⟨u, hu⟩ := h true
  cases u
  exact Bool.noConfusion hu

#print axioms positive_formula_moves_forward
#print axioms positive_truth_at_every_stage
#print axioms no_first_loss_of_positive_intrinsic_formula
#print axioms no_merging_of_old_positions
#print axioms negated_relation_can_fail_under_forward_embedding
#print axioms quantifier_free_truth_invariant
#print axioms genuine_fresh_node_embedding_is_not_surjective
#print axioms fresh_nodes_can_change_existential_first_order_truth
#print axioms induced_fresh_embedding_is_non_surjective

end PhysicalBridges.AllIsForwardPersistence
