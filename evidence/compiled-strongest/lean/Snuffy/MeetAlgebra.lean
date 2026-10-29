/-
Snuffy — Canon Edition: the H5 meet algebra (Chapter 4 / §13).

Projection-lattice formalization of the logical-extension layer. The lattice
axioms below are the laws satisfied by the projection lattice of a Hilbert
space (meet = intersection of ranges; complement = orthogonal complement;
bot = zero projection). The theorems proved:

  * anchor_preserved        — P_T0 ≤ P_φ  →  P_T0 ⊓ P_φ = P_T0
  * anchor_preserved_over   — deduced extensions ΔΣ preserve the anchor meet:
                              P_{T0 ∪ ΔΣ} = P_{T0}       (the tactic target)
  * contradiction_collapse  — P_T0 ≤ ¬P_φ  →  P_T0 ⊓ P_φ = ⊥
  * collapse_over           — one contradictory extension zeroes the global meet
  * a concrete model: predicates on a model carrier (classical semantics),
    instantiating every axiom, so the theorems are not vacuous.

The operator-level fact that the alternating-product limit (PQ)^n realises the
range intersection (von Neumann) is the analytic bridge from this lattice to
concrete operators; it is the next Mathlib-dependent target and is not claimed
here. Pure Lean 4 core; no imports.
-/

namespace Snuffy

/- The laws of a projection lattice with orthogonal complement, as used by H5. -/
class ProjectionLattice (P : Type) where
  le : P → P → Prop
  meet : P → P → P
  top : P
  bot : P
  complement : P → P
  refl (p : P) : le p p
  antisymm {p q : P} : le p q → le q p → p = q
  trans {p q r : P} : le p q → le q r → le p r
  meet_left (p q : P) : le (meet p q) p
  meet_right (p q : P) : le (meet p q) q
  meet_greatest {p q r : P} : le r p → le r q → le r (meet p q)
  meet_comm (p q : P) : meet p q = meet q p
  top_greatest (p : P) : le p top
  bot_least (p : P) : le bot p
  meet_complement (p : P) : meet p (complement p) = bot

open ProjectionLattice

variable {P : Type} [ProjectionLattice P]

/- A presentation is consistent when its meet is not the zero projection. -/
def Consistent (p : P) : Prop := p ≠ bot

/- Anchor preservation: a deduced formula contains the anchor subspace, so
   meeting with it changes nothing. -/
theorem anchor_preserved {p q : P} (h : le p q) : meet p q = p :=
  antisymm (meet_left p q) (meet_greatest (refl p) h)

/- Contradiction: an anchor contained in the complement of φ meets φ in zero. -/
theorem contradiction_collapse {p q : P} (h : le p (complement q)) :
    meet p q = bot := by
  have h1 : le (meet p q) (complement q) := trans (meet_left p q) h
  have h2 : le (meet p q) q := meet_right p q
  have h3 : le (meet p q) (meet (complement q) q) := meet_greatest h1 h2
  have h4 : meet (complement q) q = bot := by
    rw [meet_comm]
    exact meet_complement q
  rw [h4] at h3
  exact antisymm h3 (bot_least (meet p q))

/- The zero projection absorbs. -/
theorem bot_absorb (p : P) : meet bot p = bot :=
  antisymm (meet_left bot p) (bot_least (meet bot p))

/- The global meet of an anchor with a finite extension, folded left. -/
def meetAll (base : P) : List P → P
  | [] => base
  | φ :: rest => meetAll (meet base φ) rest

/- THE TACTIC TARGET.  Every formula of the extension is deduced from the
   anchor set (P_T0 ≤ P_φ); therefore  P_{T0 ∪ ΔΣ} = P_{T0}. -/
theorem anchor_preserved_over (T0 : P) :
    ∀ (ext : List P), (∀ φ, φ ∈ ext → le T0 φ) → meetAll T0 ext = T0
  | [], _ => rfl
  | φ :: rest, h => by
      have hφ : le T0 φ := h φ (List.Mem.head _)
      have hstep : meet T0 φ = T0 := anchor_preserved hφ
      have hrest : ∀ ψ, ψ ∈ rest → le T0 ψ :=
        fun ψ hm => h ψ (List.Mem.tail _ hm)
      show meetAll (meet T0 φ) rest = T0
      rw [hstep]
      exact anchor_preserved_over T0 rest hrest

/- Adversarial perturbation: once any extension formula contradicts the
   anchor, the global meet is the zero projection — rollback fires. -/
theorem meetAll_bot : ∀ (ext : List P), meetAll (bot : P) ext = bot
  | [] => rfl
  | φ :: rest => by
      show meetAll (meet bot φ) rest = bot
      rw [bot_absorb]
      exact meetAll_bot rest

theorem collapse_over (T0 : P) (φ : P) (rest : List P)
    (h : le T0 (complement φ)) : meetAll T0 (φ :: rest) = bot := by
  show meetAll (meet T0 φ) rest = bot
  rw [contradiction_collapse h]
  exact meetAll_bot rest

/- Consistency is preserved by valid deduction: a consistent anchor set stays
   consistent under any deduced extension. -/
theorem consistent_preserved (T0 : P) (ext : List P)
    (hc : Consistent T0) (h : ∀ φ, φ ∈ ext → le T0 φ) :
    Consistent (meetAll T0 ext) := by
  rw [anchor_preserved_over T0 ext h]
  exact hc

/- A concrete model: predicates on a carrier of models (classical semantics).
   meet = conjunction, complement = negation, top = True, bot = False.
   Every lattice law is discharged, so the theorems above are not vacuous. -/
instance predicateModel (α : Type) : ProjectionLattice (α → Prop) where
  le p q := ∀ a, p a → q a
  meet p q := fun a => p a ∧ q a
  top := fun _ => True
  bot := fun _ => False
  complement q := fun a => ¬ q a
  refl _ := fun _ h => h
  antisymm h1 h2 := funext (fun a => propext ⟨fun hp => h1 a hp, fun hq => h2 a hq⟩)
  trans h1 h2 := fun a hp => h2 a (h1 a hp)
  meet_left _ _ := fun _ h => h.1
  meet_right _ _ := fun _ h => h.2
  meet_greatest h1 h2 := fun a h => ⟨h1 a h, h2 a h⟩
  meet_comm _ _ := funext (fun _ => propext ⟨fun h => ⟨h.2, h.1⟩, fun h => ⟨h.2, h.1⟩⟩)
  top_greatest _ := fun _ _ => trivial
  bot_least _ := fun _ h => h.elim
  meet_complement _ := funext (fun _ => propext ⟨fun h => (h.2 h.1).elim, fun h => h.elim⟩)

/- Sanity instance of the target in the concrete model. -/
example (α : Type) (T0 φ : α → Prop) (h : ∀ a, T0 a → φ a) :
    meetAll T0 [φ] = T0 :=
  anchor_preserved_over T0 [φ] (fun ψ hm => by
    cases hm with
    | head _ => exact h
    | tail _ hm' => cases hm')

end Snuffy
