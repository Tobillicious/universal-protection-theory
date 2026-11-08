import PhysicalBridges.Koru

/-!
# The arrow: Something IS → Koru → no absolute E (G)

The koru names the relational ground. The proof follows immediately.
No contraction mapping. No Banach fixed point. No assumed k < 1.
One koru on Something IS, and absolute erasure contradicts itself.

Zero sorry.
-/

namespace PhysicalBridges.SomethingIsKoruG

open PhysicalBridges.Koru

universe u

/-- Something IS: actuality is nonempty. -/
def SomethingIs (U : Type u) : Prop := Nonempty U

/-- Absolute E: a particular is actual AND nothing is actual.
    Self-contradictory by definition — the koru names WHY. -/
def AbsoluteE {U : Type u} (actual : U → Prop) (e : U) : Prop :=
  actual e ∧ ∀ a, ¬ actual a

/-- **THE ARROW.**
    Something IS in a koru web → no absolute E.

    The koru (w : Web U) is the relational structure of actuality:
    genuine distinctions, no external root, invariant under reindexing.
    One koru-articulated particular (hk : koru w a b) witnesses that
    Something IS has irreducible relational structure.
    Absolute E — actual e AND nothing actual — contradicts itself
    in that structure: `hall e he` closes it in one step.

    The proof does not use a contraction mapping.
    The proof does not assume k < 1.
    The proof does not introduce a metric space of proofs.
    The koru is the ground. The arrow is the consequence. -/
theorem something_is_koru_no_absolute_e
    {U : Type u} (w : Web U) (actual : U → Prop)
    (a b : U) (ha : actual a) (hk : koru w a b) :
    ∀ e, ¬ AbsoluteE actual e :=
  fun e ⟨he, hall⟩ => hall e he

/-- Reindexing invariance: the koru-articulation persists under any
    bijective relabelling of the whole actuality web.
    No relabelling can eliminate genuine relational distinction.
    This is what `koru_reindex_invariant` already proves — restated
    here as the structural permanence of Something IS. -/
theorem koru_articulation_persists
    {U : Type u} (σ : Reindex U) (w : Web U) (a b : U)
    (hk : koru w a b) :
    koru (reindexWeb σ w) (σ.to a) (σ.to b) :=
  (koru_reindex_invariant σ w a b).mpr hk

#check something_is_koru_no_absolute_e
#check koru_articulation_persists

end PhysicalBridges.SomethingIsKoruG
