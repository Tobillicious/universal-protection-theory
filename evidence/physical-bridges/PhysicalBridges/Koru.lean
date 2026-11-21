/-!
# The koru — a conservative operator naming intrinsic articulation

**4 November 2026 · noncanonical · the koru, for the human edition · no canon edit.**

The `koru` names the ALL IS move the kōrero circled: *articulate a distinction within one
actuality while keeping the distinction, its expression, and the operator itself intrinsic —
no external root.* It is a **conservative defined operator** (sugar): its laws are proved
here from the relation alone; it introduces no new primitive and proves no new theorem.

Honest scope (per the summit characterisation): the koru *names* the no-boundary / intrinsic
ontology that `CathedralSummitPremiseNecessity` shows is **logically required** for
continuation. Being conservative, it cannot *replace* that premise — a conservative operator
adds no theorem, and the premise is provably not eliminable. The koru is the human-edition
articulation of the ontology, not a proof of the premise-free summit. No `sorry`.
-/

namespace PhysicalBridges.Koru

universe u

variable {P : Type u}

/-- One actuality with an internal relation. -/
structure Web (P : Type u) where
  link : P → P → Prop

/-- A reindexing of the whole web by a bijection (relabelling of all positions at once). -/
structure Reindex (P : Type u) where
  to : P → P
  inv : P → P
  left : ∀ x, inv (to x) = x
  right : ∀ x, to (inv x) = x

/-- Transport the entire relation under a reindexing. -/
def reindexWeb (σ : Reindex P) (w : Web P) : Web P :=
  { link := fun x y => w.link (σ.inv x) (σ.inv y) }

/-- The **koru** operator ⟲ : the intrinsic articulation of a distinction between two
positions within one web — they are genuinely distinct AND distinguished by their relational
profiles (there is a position they relate to differently). The articulation is wholly
internal: it mentions only the web's own relation, never an external root. -/
def koru (w : Web P) (a b : P) : Prop :=
  a ≠ b ∧ ∃ c, w.link a c ≠ w.link b c

/-- **Law — no self-articulation.** A position never koru-articulates against itself. -/
theorem koru_irrefl (w : Web P) (a : P) : ¬ koru w a a := by
  rintro ⟨hne, _⟩
  exact hne rfl

/-- **Law — symmetry.** The articulation of a from b is the articulation of b from a: the
distinction belongs to the pair, not to a privileged member. -/
theorem koru_symm (w : Web P) (a b : P) : koru w a b ↔ koru w b a := by
  constructor <;>
  · rintro ⟨hne, c, hc⟩
    exact ⟨fun h => hne h.symm, c, fun h => hc h.symm⟩

/-- **Law — non-collapse / genuine distinction.** koru entails the positions are distinct;
it never identifies two positions (it would lose the lattice's relational structure). -/
theorem koru_distinct (w : Web P) (a b : P) : koru w a b → a ≠ b :=
  fun h => h.1

/-- **Law — relabelling invariance (no privileged root).** The articulation is invariant
under reindexing the entire web: koru is a property of the one relational structure, not of
any external labelling. This is the ALL IS law that keeps the operator intrinsic. -/
theorem koru_reindex_invariant (σ : Reindex P) (w : Web P) (a b : P) :
    koru (reindexWeb σ w) (σ.to a) (σ.to b) ↔ koru w a b := by
  unfold koru reindexWeb
  constructor
  · rintro ⟨hne, c, hc⟩
    refine ⟨fun h => hne (by rw [h]), σ.inv c, ?_⟩
    simpa [σ.left] using hc
  · rintro ⟨hne, c, hc⟩
    refine ⟨fun h => hne (by have := congrArg σ.inv h; simpa [σ.left] using this), σ.to c, ?_⟩
    simpa [σ.left] using hc

#print axioms koru
#print axioms koru_irrefl
#print axioms koru_symm
#print axioms koru_distinct
#print axioms koru_reindex_invariant

end PhysicalBridges.Koru
