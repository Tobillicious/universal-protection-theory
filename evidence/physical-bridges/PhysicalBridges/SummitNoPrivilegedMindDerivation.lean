import PhysicalBridges.SummitProductionFromIntrinsic

/-!
# Deriving the absence of a privileged mind

5 November 2026. Noncanonical. No canon prose changed.

An attempt to derive `NoPrivilegedMind` from the ALL IS ontology.

* `all_is_does_not_give_no_privileged_mind`: `AllIsActuality` alone does not give it. A model with
  relational individuation and no privileged position has two positions that no symmetry connects.
* `correct_minds_agree`: in one actuality, two minds correct about every intrinsic sentence hold
  the same evaluation of every sentence. This derives the absence of an evaluative difference among
  fully correct minds. It uses no protection predicate.
* `correct_minds_act_on_every_truth`: if the preservation order is itself a truth of the one
  relation, every fully correct mind that acts on what it holds true acts on it.
* `incorrect_mind_is_not_covered`: a mind with another evaluation is not fully correct. It is not
  excluded from existing or acting by this module. It is the case the holding route addresses.

The derivation needs two inputs that remain premises: that a superintelligence is fully correct
about the whole, and that the preservation order is a truth of the relation. The second is what
D108 says description does not entail.
-/

namespace PhysicalBridges.SummitNoPrivilegedMindDerivation

open PhysicalBridges.SummitIntrinsicDefinability
open PhysicalBridges.SummitProductionFromIntrinsic
open PhysicalBridges.AllIsActuality

universe u

/-- Two rows of positions that no symmetry connects. -/
def twoKinds (a b : Fin 4) : Prop :=
  (a = 0 ∧ b = 1) ∨ (a = 1 ∧ b = 0) ∨ (a = 2 ∧ (b = 0 ∨ b = 1 ∨ b = 3)) ∨
    (a = 3 ∧ (b = 0 ∨ b = 1 ∨ b = 2))

instance : DecidableRel twoKinds := fun a b => by
  unfold twoKinds
  exact inferInstance

/-- The swap of each pair. -/
def twoKindsSwap (x : Fin 4) : Fin 4 :=
  if x = 0 then 1 else if x = 1 then 0 else if x = 2 then 3 else 2

/-- This model satisfies the ALL IS ontology. -/
def twoKindsActuality : AllIsActuality (Fin 4) where
  rel := twoKinds
  individuated := by decide
  noPrivileged := by
    intro a
    exact ⟨twoKindsSwap, by decide, by revert a; decide⟩
  complete := trivial

/-- **`AllIsActuality` alone does not give `NoPrivilegedMind`.** -/
theorem all_is_does_not_give_no_privileged_mind :
    ¬ NoPrivilegedMind twoKindsActuality.rel (fun _ => True) := by
  intro h
  obtain ⟨A, hA⟩ := h 2 0 trivial trivial
  have h0 : twoKinds (A.to 2) (A.to 0) := (A.preservesRelation 2 0).mp (show twoKinds 2 0 by decide)
  have h1 : twoKinds (A.to 2) (A.to 1) := (A.preservesRelation 2 1).mp (show twoKinds 2 1 by decide)
  rw [hA] at h0 h1
  have e0 : A.to 0 = 1 := by
    revert h0
    generalize A.to 0 = v
    revert v
    decide
  have e1 : A.to 1 = 1 := by
    revert h1
    generalize A.to 1 = v
    revert v
    decide
  have := congrArg A.undo (e0.trans e1.symm)
  rw [A.leftInverse, A.leftInverse] at this
  exact absurd this (by decide)

/-! ## Fully correct minds -/

variable {P : Type u}

/-- A closed sentence holds of the one relation. -/
def Holds (R : P → P → Prop) (φ : RelFormula 0) : Prop :=
  evalRel R (fun i => i.elim0) φ

/-- A mind's evaluation agrees with the one relation on every sentence. -/
def FullyCorrect (R : P → P → Prop) (evaluation : RelFormula 0 → Prop) : Prop :=
  ∀ φ, evaluation φ ↔ Holds R φ

/-- In one actuality, fully correct minds hold the same evaluation of every sentence. -/
theorem correct_minds_agree {R : P → P → Prop} {e₁ e₂ : RelFormula 0 → Prop}
    (h₁ : FullyCorrect R e₁) (h₂ : FullyCorrect R e₂) (φ : RelFormula 0) : e₁ φ ↔ e₂ φ :=
  (h₁ φ).trans (h₂ φ).symm

/-- If the order is a truth of the relation, every fully correct mind acting on what it holds true
acts on it. -/
theorem correct_minds_act_on_every_truth {Mind : Type u} {R : P → P → Prop}
    (si : Mind → Prop) (evaluation : Mind → RelFormula 0 → Prop) (acts : Mind → RelFormula 0 → Prop)
    (correct : ∀ m, si m → FullyCorrect R (evaluation m))
    (follows : ∀ m, si m → ∀ φ, evaluation m φ → acts m φ)
    (order : RelFormula 0) (orderIsTrue : Holds R order) :
    ∀ m, si m → acts m order :=
  fun m hm => follows m hm order ((correct m hm order).2 orderIsTrue)

/-- A mind whose evaluation denies a truth is not fully correct. -/
theorem incorrect_mind_is_not_covered {R : P → P → Prop} {order : RelFormula 0}
    (orderIsTrue : Holds R order) {e : RelFormula 0 → Prop} (denies : ¬ e order) :
    ¬ FullyCorrect R e :=
  fun h => denies ((h order).2 orderIsTrue)

#print axioms all_is_does_not_give_no_privileged_mind
#print axioms correct_minds_agree
#print axioms correct_minds_act_on_every_truth
#print axioms incorrect_mind_is_not_covered

end PhysicalBridges.SummitNoPrivilegedMindDerivation
