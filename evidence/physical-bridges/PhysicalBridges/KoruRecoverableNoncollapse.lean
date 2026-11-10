import PhysicalBridges.KoruFullOperatorSignature

/-!
# Complete Koru: recoverability and finite non-collapse

Additive theorem module. Does not redefine the historical Koru or assert that
arbitrary physical evolution is injective. A complete description is modeled
by a recoverable encoding; quantitative observations may forget distinctions.
-/

namespace PhysicalBridges.KoruRecoverableNoncollapse

universe u v w
variable {Thing : Type u} {Signature : Type v} {Quantity : Type w}

/-- A complete description has a left inverse, so each Thing is recoverable. -/
structure Recoverable (Thing : Type u) (Signature : Type v) where
  encode : Thing → Signature
  decode : Signature → Thing
  recover : ∀ x, decode (encode x) = x

/-- The encoding cannot collapse distinct Things. -/
theorem encode_injective (K : Recoverable Thing Signature) :
    Function.Injective K.encode := by
  intro a b h
  have h' := congrArg K.decode h
  simpa [K.recover] using h'

/-- A coarse observable may agree on distinct Things, but the complete
description still distinguishes them. -/
theorem equal_observation_not_equal_thing
    (K : Recoverable Thing Signature) (observe : Thing → Quantity)
    {a b : Thing} (different : a ≠ b) (same : observe a = observe b) :
    K.encode a ≠ K.encode b ∧ observe a = observe b := by
  exact ⟨fun h => different (encode_injective K h), same⟩

/-- The complete description retains every quantitative observation
obtained by applying the observable after decoding. -/
theorem observation_factors_through_complete
    (K : Recoverable Thing Signature) (observe : Thing → Quantity)
    (x : Thing) :
    (observe ∘ K.decode) (K.encode x) = observe x := by
  exact K.recover x

/-- Commutation of a modeled Thing step and its description step. -/
def Compatible (K : Recoverable Thing Signature)
    (step : Thing → Thing) (lift : Signature → Signature) : Prop :=
  ∀ x, lift (K.encode x) = K.encode (step x)

/-- Explicit finite iteration, avoiding any library-dependent iterate API. -/
def stages {A : Type u} (step : A → A) : Nat → A → A
  | 0 => id
  | n + 1 => fun x => step (stages step n x)

/-- Finite iteration commutes with complete description. -/
theorem iterate_compatible
    (K : Recoverable Thing Signature)
    (step : Thing → Thing) (lift : Signature → Signature)
    (h : Compatible K step lift) (n : Nat) (x : Thing) :
    stages lift n (K.encode x) = K.encode (stages step n x) := by
  induction n with
  | zero => rfl
  | succ n ih =>
      change lift (stages lift n (K.encode x)) =
        K.encode (step (stages step n x))
      rw [ih]
      exact h _

/-- An injective step remains injective after every finite stage. -/
theorem stages_injective {A : Type u} (step : A → A)
    (hinj : Function.Injective step) (n : Nat) :
    Function.Injective (stages step n) := by
  induction n with
  | zero =>
      intro a b hab
      exact hab
  | succ n ih =>
      intro a b hab
      apply ih
      exact hinj hab

/-- Every finite stage preserves distinction if the underlying
Thing transition is injective. No claim about limit stages. -/
theorem no_finite_collapse
    (K : Recoverable Thing Signature)
    (step : Thing → Thing) (lift : Signature → Signature)
    (h : Compatible K step lift) (hinj : Function.Injective step)
    (n : Nat) {a b : Thing} (hab : a ≠ b) :
    stages lift n (K.encode a) ≠ stages lift n (K.encode b) := by
  rw [iterate_compatible K step lift h n a,
      iterate_compatible K step lift h n b]
  intro heq
  apply hab
  apply stages_injective step hinj n
  exact encode_injective K heq

#print axioms encode_injective
#print axioms equal_observation_not_equal_thing
#print axioms observation_factors_through_complete
#print axioms iterate_compatible
#print axioms no_finite_collapse

end PhysicalBridges.KoruRecoverableNoncollapse
