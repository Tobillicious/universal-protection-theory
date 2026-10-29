import Snuffy.R14Rivals

/-! R15: greatestness reduced exactly to a covering family of feasible fibre
representatives. Policies and reactive worlds are arbitrary types. No finite
enumeration, clairvoyant per-world selection or physical independence is assumed.
Constructing complete causal fibres and their representatives is a separate
application obligation. This formalization was independently written from the
received mathematical statement; no Lean attachment was available.
-/
namespace UPTR15

universe u v w z

def Greatest {Policy : Type u} {World : Type v} {O : Type w}
    (feasible : Policy → Prop) (le : O → O → Prop)
    (outcome : Policy → World → O) (p : Policy) : Prop :=
  feasible p ∧ ∀ q, feasible q → ∀ world, le (outcome q world) (outcome p world)

theorem boundary_representatives_iff
    {Policy : Type u} {World : Type v} {O : Type w} {B : Type z}
    (feasible : Policy → Prop) (le : O → O → Prop)
    (trans : ∀ a b c, le a b → le b c → le a c)
    (outcome : Policy → World → O) (boundary : Policy → B) (rep : B → Policy)
    (implemented : ∀ b, feasible (rep b))
    (fibre : ∀ p, feasible p → ∀ world,
      le (outcome p world) (outcome (rep (boundary p)) world)) :
    (∃ p, Greatest feasible le outcome p) ↔
      ∃ b, ∀ c world, le (outcome (rep c) world) (outcome (rep b) world) := by
  constructor
  · rintro ⟨p, hp, hg⟩
    refine ⟨boundary p, fun c world => ?_⟩
    exact trans _ _ _ (hg (rep c) (implemented c) world) (fibre p hp world)
  · rintro ⟨b, hb⟩
    refine ⟨rep b, implemented b, fun p hp world => ?_⟩
    exact trans _ _ _ (fibre p hp world) (hb (boundary p) world)

theorem selected_representative_greatest
    {Policy : Type u} {World : Type v} {O : Type w} {B : Type z}
    (feasible : Policy → Prop) (le : O → O → Prop)
    (trans : ∀ a b c, le a b → le b c → le a c)
    (outcome : Policy → World → O) (boundary : Policy → B) (rep : B → Policy)
    (implemented : ∀ b, feasible (rep b))
    (fibre : ∀ p, feasible p → ∀ world,
      le (outcome p world) (outcome (rep (boundary p)) world))
    (b : B) (best : ∀ c world, le (outcome (rep c) world) (outcome (rep b) world)) :
    Greatest feasible le outcome (rep b) :=
  ⟨implemented b, fun p hp world => trans _ _ _ (fibre p hp world) (best (boundary p) world)⟩

/-- The canonical four-stage predicates are Paper 12's original predicates,
    using the transitivity already proved in R14Rivals. -/
theorem canonical_boundary_iff {P : Type} {O : Type} {Policy World B : Type}
    (stages : List (O → P → Prop)) (feasible : Policy → Prop)
    (outcome : Policy → World → O) (boundary : Policy → B) (rep : B → Policy)
    (implemented : ∀ b, feasible (rep b))
    (fibre : ∀ p, feasible p → ∀ world,
      UPTR14Rivals.LE stages (outcome p world) (outcome (rep (boundary p)) world)) :
    (∃ p, Greatest feasible (UPTR14Rivals.LE stages) outcome p) ↔
      ∃ b, ∀ c world,
        UPTR14Rivals.LE stages (outcome (rep c) world) (outcome (rep b) world) :=
  boundary_representatives_iff feasible _ (UPTR14Rivals.trans stages)
    outcome boundary rep implemented fibre

/-- A conservative interface envelope is sufficient even without greatest
    representatives. Coverage is over every feasible policy in the same world. -/
theorem interface_envelope_transfer
    {Policy : Type u} {World : Type v} {O : Type w} {B : Type z}
    (feasible : Policy → Prop) (le : O → O → Prop)
    (trans : ∀ a b c, le a b → le b c → le a c)
    (outcome : Policy → World → O) (boundary : Policy → B)
    (upper : B → World → O) (lower : World → O) (chosen : Policy)
    (implemented : feasible chosen)
    (cover : ∀ p, feasible p → ∀ world, le (outcome p world) (upper (boundary p) world))
    (compare : ∀ b world, le (upper b world) (lower world))
    (attain : ∀ world, le (lower world) (outcome chosen world)) :
    Greatest feasible le outcome chosen := by
  refine ⟨implemented, fun p hp world => ?_⟩
  exact trans _ _ _ (trans _ _ _ (cover p hp world) (compare (boundary p) world)) (attain world)

/-- Choosing separately for unobserved worlds reverses the policy/world
    quantifiers. This finite control has a winner per world, but no common winner. -/
theorem hidden_world_control :
    (∀ world : Bool, ∃ choice : Bool, choice = world) ∧
      ¬ (∃ choice : Bool, ∀ world : Bool, choice = world) := by
  refine ⟨fun world => ⟨world, rfl⟩, ?_⟩
  rintro ⟨choice, h⟩
  have hf := h false
  have ht := h true
  cases choice <;> simp_all

end UPTR15
