/-
Lottery invariance under option representation (answering a referee's menu-manipulation test, 22 October 2026).
An option is a feasible OUTCOME. Actions are descriptions of outcomes; two actions are equivalent exactly when they
have the same outcome. The impartial draw is uniform over the distinct eligible outcomes, never over descriptions.
- `draw_invariant`: two menus offering the same set of outcomes induce the same draw, however many descriptions
  either uses for any outcome. Duplicating, renaming or reordering descriptions cannot move it.
- `draw_over_descriptions_is_manipulable`: the naive draw over descriptions is not invariant: describing A three
  times and B once gives A three shares to B's one, while the menu of outcomes is unchanged.
- `tragic_pair_equal_chances`: with X keeping {A} and Y keeping {B, C}, the draw over outcomes gives each of A, B
  and C one chance in two of surviving.
Weights are counts over a fixed finite list of outcomes; a probability is the weight over the class count.
Eligibility (which outcomes are feasible and aligned) is agreed input, stated as a premise. Core Lean 4 only.
-/
namespace UPTLotteryMenu

def cnt {ι : Type} (p : ι → Prop) [DecidablePred p] (L : List ι) : Nat := (L.filter (fun i => decide (p i))).length

theorem cnt_congr {ι : Type} (p q : ι → Prop) [DecidablePred p] [DecidablePred q] (L : List ι)
    (h : ∀ i, p i ↔ q i) : cnt p L = cnt q L := by
  induction L with
  | nil => rfl
  | cons i L ih =>
    by_cases hp : p i
    · have hq : q i := (h i).mp hp
      simp [cnt, hp, hq] at ih ⊢; exact ih
    · have hq : ¬ q i := fun hq => hp ((h i).mpr hq)
      simp [cnt, hp, hq] at ih ⊢; exact ih

variable {A O : Type} [DecidableEq O]

/-- The outcomes a menu of actions offers. -/
def Offers (out : A → O) (menu : List A) (o : O) : Prop := o ∈ menu.map out

instance (out : A → O) (menu : List A) : DecidablePred (Offers out menu) := fun o =>
  inferInstanceAs (Decidable (o ∈ menu.map out))

/-- The draw over outcome classes: each offered outcome gets weight one, out of the number of offered outcomes
(counted over a fixed list `U` of all outcomes, each listed once). -/
def weight (out : A → O) (menu : List A) (o : O) : Nat := if Offers out menu o then 1 else 0
def classes (U : List O) (out : A → O) (menu : List A) : Nat := cnt (Offers out menu) U

/-- **Representation invariance.** Menus offering the same outcomes induce the same draw: the same weight on every
outcome and the same number of classes, so the same probability for every outcome. -/
theorem draw_invariant (U : List O) (out : A → O) (m₁ m₂ : List A)
    (same : ∀ o, Offers out m₁ o ↔ Offers out m₂ o) :
    (∀ o, weight out m₁ o = weight out m₂ o) ∧ classes U out m₁ = classes U out m₂ := by
  refine ⟨fun o => ?_, cnt_congr _ _ U same⟩
  unfold weight
  by_cases h : Offers out m₁ o
  · simp [h, (same o).mp h]
  · have h2 : ¬ Offers out m₂ o := fun h2 => h ((same o).mpr h2)
    simp [h, h2]

/-- Duplicating a description of an outcome already offered changes nothing. -/
theorem duplicate_description_changes_nothing (U : List O) (out : A → O) (menu : List A) (a b : A)
    (ha : a ∈ menu) (hb : out b = out a) :
    (∀ o, weight out (b :: menu) o = weight out menu o) ∧ classes U out (b :: menu) = classes U out menu := by
  apply draw_invariant
  intro o
  unfold Offers
  constructor
  · intro h
    simp only [List.map_cons, List.mem_cons] at h
    rcases h with h | h
    · rw [h, hb]; exact List.mem_map_of_mem ha
    · exact h
  · intro h; simp only [List.map_cons, List.mem_cons]; exact Or.inr h

/-- The naive draw over descriptions: an outcome's weight is how many descriptions it has. -/
def descriptionWeight (out : A → O) (menu : List A) (o : O) : Nat := cnt (fun a => out a = o) menu

/-- **The control.** Over descriptions the draw is manipulable: menus [A, A, A, B] and [A, B] offer the same two
outcomes, yet A has three shares to B's one in the first and one to one in the second. -/
theorem draw_over_descriptions_is_manipulable :
    (∀ o, Offers (fun b : Bool => b) [true, true, true, false] o ↔ Offers (fun b : Bool => b) [true, false] o) ∧
    descriptionWeight (fun b : Bool => b) [true, true, true, false] true = 3 ∧
    descriptionWeight (fun b : Bool => b) [true, true, true, false] false = 1 ∧
    descriptionWeight (fun b : Bool => b) [true, false] true = 1 := by
  refine ⟨fun o => ?_, by decide, by decide, by decide⟩
  cases o <;> simp [Offers]

/-- Three beings. -/
inductive Being | a | b | c deriving DecidableEq

/-- **The tragic pair.** X keeps {A}; Y keeps {B, C}. Drawing uniformly over the two outcomes, each being is kept in
exactly one of the two: each of A, B and C survives with probability one in two. -/
theorem tragic_pair_equal_chances :
    let X : Being → Bool := fun x => x == .a
    let Y : Being → Bool := fun x => x != .a
    ∀ x : Being, cnt (fun k : Being → Bool => k x = true) [X, Y] = 1 := by
  intro X Y x
  cases x <;> decide

end UPTLotteryMenu
