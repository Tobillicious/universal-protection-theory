/-!
# Koru Conservation: finite-stage injectivity and predicate recoverability

This mathematical theorem is conditional on injectivity; it does not assert
that every physical evolution is injective or that physical subjects persist.
-/

universe u v

namespace PhysicalBridges.KoruConservation

structure History where
  State : Nat → Type u
  step : (n : Nat) → State n → State (n + 1)
  step_injective : ∀ n, Function.Injective (step n)

def carry (H : History) : (n : Nat) → H.State 0 → H.State n
  | 0 => fun x => x
  | n + 1 => fun x => H.step n (carry H n x)

theorem carry_injective (H : History) :
    ∀ n, Function.Injective (carry H n) := by
  intro n
  induction n with
  | zero =>
      intro x y h
      exact h
  | succ n ih =>
      intro x y h
      apply ih
      apply H.step_injective n
      exact h

def recovered (H : History) (n : Nat)
    (P : H.State 0 → Prop) (y : H.State n) : Prop :=
  ∃ x, carry H n x = y ∧ P x

theorem recover_iff (H : History) (n : Nat)
    (P : H.State 0 → Prop) (x : H.State 0) :
    recovered H n P (carry H n x) ↔ P x := by
  constructor
  · rintro ⟨z, hz, hp⟩
    have hzx : z = x := carry_injective H n hz
    subst z
    exact hp
  · intro hp
    exact ⟨x, rfl, hp⟩

def AllPredicatesRecoverable {A : Type u} {B : Type v}
    (f : A → B) : Prop :=
  ∀ P : A → Prop, ∃ Q : B → Prop, ∀ x, Q (f x) ↔ P x

theorem all_predicates_recoverable_of_injective
    {A : Type u} {B : Type v} (f : A → B)
    (hf : Function.Injective f) : AllPredicatesRecoverable f := by
  intro P
  refine ⟨fun y => ∃ x, f x = y ∧ P x, ?_⟩
  intro x
  constructor
  · rintro ⟨z, hz, hp⟩
    have hzx : z = x := hf hz
    subst z
    exact hp
  · intro hp
    exact ⟨x, rfl, hp⟩

theorem injective_of_all_predicates_recoverable
    {A : Type u} {B : Type v} (f : A → B)
    (h : AllPredicatesRecoverable f) : Function.Injective f := by
  intro x y hxy
  obtain ⟨Q, hQ⟩ := h (fun z => z = x)
  have hx : Q (f x) := (hQ x).2 rfl
  have hy : Q (f y) := by simpa [hxy] using hx
  have hyx : y = x := (hQ y).1 hy
  exact hyx.symm

theorem injective_iff_all_predicates_recoverable
    {A : Type u} {B : Type v} (f : A → B) :
    Function.Injective f ↔ AllPredicatesRecoverable f := by
  constructor
  · exact all_predicates_recoverable_of_injective f
  · exact injective_of_all_predicates_recoverable f

#print axioms carry_injective
#print axioms recover_iff
#print axioms all_predicates_recoverable_of_injective
#print axioms injective_of_all_predicates_recoverable
#print axioms injective_iff_all_predicates_recoverable

end PhysicalBridges.KoruConservation
