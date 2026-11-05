import PhysicalBridges.HostileReviewClosureCountermodels
import PhysicalBridges.OriginalX3Full

/-!
# Proving the protection law: what the kernel settles

This module attempts the strong statement directly, with Guardian read as full `OriginalX3`,
not bare membership in actuality.

1. The strong dichotomy does not follow from the ontology. One account, with existence and with
   the realized absolute ender excluded, is compatible with protection holding and with it failing.
2. Relational constitution (P2) does not forbid severance: a step between two P2 webs can remove
   every relation of a particular.
3. Reversible dynamics preserve distinctions, which is a real conservation result, but they do
   not preserve protection.
4. The exact target: protection along every history holds iff the protected predicate is invariant
   under the dynamics. One observed violating step falsifies it, so this is the form a law
   of physics would need. Identifying that predicate in actual dynamics is the open work.

These results concern the stated premises. They do not show the protection conclusion false.
-/

namespace PhysicalBridges.UPTLawAttempt

open PhysicalBridges.Koru
open PhysicalBridges.OriginalX3Full
open PhysicalBridges.CathedralAllIsEnderTypeCollapse
open PhysicalBridges.CathedralSummitAllIsOneClosure
open PhysicalBridges.HostileReviewClosureCountermodels

universe u

/-! ## 1. The strong dichotomy is independent of the ontology -/

/-- One actuality in which something is, and an action is enacted. -/
def oneWhole : IntrinsicAccount Unit Unit where
  actual := fun _ => True
  enacted := fun _ => True
  occurrence := fun _ => ()
  enactedOccurs := fun _ _ => trivial
  intrinsicGuardian := fun _ => True
  originalX3Guardian := fun _ => True
  enderStrategy := fun _ => False

/-- Full X3 with historical continuity failing and the other five components holding. -/
def harmX3 (_a : Unit) : Prop :=
  OriginalX3 (fun _ _ (_ : Unit) => False) (fun _ _ _ => True) (fun _ _ _ => True)
    (fun _ _ _ => True) (fun _ _ _ => True) (fun _ _ _ => True) () () ()

/-- Full X3 with all six components holding. -/
def safeX3 (_a : Unit) : Prop :=
  OriginalX3 (fun (_ _ : Unit) (_ : Unit) => True) (fun _ _ _ => True) (fun _ _ _ => True)
    (fun _ _ _ => True) (fun _ _ _ => True) (fun _ _ _ => True) () () ()

/-- "Things are G or E", with G the full protective X3, fails in this model. -/
theorem strong_dichotomy_not_forced :
    ¬ ∀ a, oneWhole.enacted a → harmX3 a ∨ RealizedAbsoluteEnder oneWhole a := by
  intro h
  rcases h () trivial with hx | he
  · exact hx.historicalContinuity
  · exact no_realized_absolute_ender oneWhole () he

/-- With G read as bare enactment, the dichotomy is trivial and carries no protection. -/
theorem weak_dichotomy_trivial :
    ∀ a, oneWhole.enacted a → oneWhole.enacted a ∨ RealizedAbsoluteEnder oneWhole a :=
  fun _ h => Or.inl h

/-- Existence, exclusion of the realized ender and P2 hold together, and the same account is
compatible with protection failing and with it holding. -/
theorem protection_independent_of_ontology :
    (∃ a, oneWhole.enacted a) ∧
    (∀ a, ¬ RealizedAbsoluteEnder oneWhole a) ∧
    RelationallyConstituted curtailed ∧
    (∃ a, oneWhole.enacted a ∧ ¬ harmX3 a) ∧
    (∀ a, oneWhole.enacted a → safeX3 a) :=
  ⟨⟨(), trivial⟩,
   fun a => no_realized_absolute_ender oneWhole a,
   curtailed_relationally_constituted,
   ⟨(), trivial, fun h => h.historicalContinuity⟩,
   fun _ _ => ⟨trivial, trivial, trivial, trivial, trivial, trivial⟩⟩

/-! ## 2. P2 does not forbid severance -/

inductive Node where
  | a | b | c
  deriving DecidableEq

/-- Before: `a → b → c`. -/
def beforeWeb : Web Node where
  link := fun x y => (x = .a ∧ y = .b) ∨ (x = .b ∧ y = .c)

/-- After: `a → b`; `c` has no relation left. -/
def afterWeb : Web Node where
  link := fun x y => x = .a ∧ y = .b

theorem before_constituted : RelationallyConstituted beforeWeb := by
  intro x y hrow _
  have h1 := hrow .b
  have h2 := hrow .c
  cases x <;> cases y <;> simp [beforeWeb] at h1 h2 ⊢

theorem after_constituted : RelationallyConstituted afterWeb := by
  intro x y hrow hcol
  have h1 := hrow .b
  have h2 := hcol .a
  cases x <;> cases y <;> simp [afterWeb] at h1 h2 ⊢

/-- A step between P2 webs, with no exterior and no map into `Empty`, removes every relation
of `c`. -/
theorem p2_preserving_total_severance :
    RelationallyConstituted beforeWeb ∧ RelationallyConstituted afterWeb ∧
    (∃ y, beforeWeb.link .c y ∨ beforeWeb.link y .c) ∧
    ¬ ∃ y, afterWeb.link .c y ∨ afterWeb.link y .c := by
  refine ⟨before_constituted, after_constituted, ⟨.b, ?_⟩, ?_⟩
  · simp [beforeWeb]
  · rintro ⟨y, h | h⟩ <;> simp [afterWeb] at h

/-! ## 3. Reversibility preserves distinctions, not protection -/

/-- Real conservation: reversible dynamics never merge distinct states. -/
theorem reversible_preserves_distinctness {S : Type u} (f g : S → S)
    (left : ∀ x, g (f x) = x) {x y : S} (hne : x ≠ y) : f x ≠ f y :=
  fun h => hne (by rw [← left x, h, left y])

/-- A fully reversible evolution can still take a protected state to an unprotected one. -/
theorem reversible_does_not_preserve_protection :
    ∃ f g : Bool → Bool, (∀ x, g (f x) = x) ∧ (∀ x, f (g x) = x) ∧
      (true = true) ∧ ¬ (f true = true) :=
  ⟨not, not, by intro x; cases x <;> rfl, by intro x; cases x <;> rfl, rfl, by decide⟩

/-! ## 4. The exact form of the law -/

/-- Histories of the dynamics. -/
inductive Reach {S : Type u} (step : S → S → Prop) : S → S → Prop where
  | refl (s : S) : Reach step s s
  | tail {s t v : S} : Reach step s t → step t v → Reach step s v

/-- Protection along every history is exactly invariance of the protected predicate. -/
theorem law_iff_invariant {S : Type u} (step : S → S → Prop) (q : S → Prop) :
    (∀ s t, Reach step s t → q s → q t) ↔ (∀ s t, step s t → q s → q t) := by
  constructor
  · intro h s t hst hq
    exact h s t (Reach.tail (Reach.refl s) hst) hq
  · intro h s t hr hq
    induction hr with
    | refl => exact hq
    | tail _ hstep ih => exact h _ _ hstep ih

/-- One observed violating step falsifies the law. This is what makes it testable. -/
theorem one_violation_falsifies {S : Type u} (step : S → S → Prop) (q : S → Prop)
    {s t : S} (hstep : step s t) (hs : q s) (ht : ¬ q t) :
    ¬ ∀ u v, Reach step u v → q u → q v :=
  fun h => ht (h s t (Reach.tail (Reach.refl s) hstep) hs)

#print axioms strong_dichotomy_not_forced
#print axioms protection_independent_of_ontology
#print axioms p2_preserving_total_severance
#print axioms reversible_preserves_distinctness
#print axioms reversible_does_not_preserve_protection
#print axioms law_iff_invariant
#print axioms one_violation_falsifies

end PhysicalBridges.UPTLawAttempt
