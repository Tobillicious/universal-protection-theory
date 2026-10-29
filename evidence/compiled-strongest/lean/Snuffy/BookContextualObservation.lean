/-! Ported from `evidence/papers-11-12/lean/modules/ContextualObservation.lean` (sha256 `0c69deb0f28c71c5fdcadde6650e1eadb3df69de302d6e735421e0268c6ff50c`); namespace renamed for the canon's joint audit. -/

namespace Snuffy.Book.ContextualObservation
universe u v w

variable {S : Type u} {A : Type v} {O : Type w}

def after (step : S → A → S) (s : S) (word : List A) : S := word.foldl step s

def Congruent (obs : S → O) (step : S → A → S) : Prop :=
  ∀ s t, obs s = obs t → ∀ a, obs (step s a) = obs (step t a)

def ContextSafe (obs : S → O) (step : S → A → S) : Prop :=
  ∀ s t, obs s = obs t → ∀ word, obs (after step s word) = obs (after step t word)

/-- Exact finite-continuation criterion for a deterministic observable abstraction. -/
theorem contextual_iff_congruent (obs : S → O) (step : S → A → S) :
    ContextSafe obs step ↔ Congruent obs step := by
  constructor
  · intro h s t he a
    exact h s t he [a]
  · intro h s t he word
    induction word generalizing s t with
    | nil => exact he
    | cons a word ih => exact ih (step s a) (step t a) (h s t he a)

/-- A reachable-state invariant may justify hiding implementation fields. -/
theorem contextual_on_invariant (I : S → Prop) (obs : S → O) (step : S → A → S)
    (preserved : ∀ s, I s → ∀ a, I (step s a))
    (congruent : ∀ s t, I s → I t → obs s = obs t → ∀ a, obs (step s a) = obs (step t a)) :
    ∀ word s t, I s → I t → obs s = obs t → obs (after step s word) = obs (after step t word) := by
  intro word
  induction word with
  | nil => intro s t _ _ he; exact he
  | cons a word ih =>
    intro s t hs ht he
    exact ih (step s a) (step t a) (preserved s hs a) (preserved t ht a) (congruent s t hs ht he a)

/-- A sound-and-complete endpoint identity detector based only on a projection forces that projection
    to distinguish states. This does not say that all physical identity is necessary for contextual equivalence. -/
theorem identity_detector_implies_injective (obs : S → O) (monitor : O → O → Bool)
    (correct : ∀ s t, monitor (obs s) (obs t) = false ↔ s = t) :
    ∀ s t, obs s = obs t → s = t := by
  intro s t he
  apply (correct s t).mp
  rw [← he]
  exact (correct s s).mpr rfl

structure Sink where
  idPresent : Bool
  out : List Nat
  deriving DecidableEq

def crash (s : Sink) (_ : Unit) : Sink :=
  if s.idPresent then s else ⟨true, s.out ++ [7]⟩
def observe (s : Sink) := s.out

theorem forgotten_id_breaks_continuation :
    observe ⟨true, [7]⟩ = observe ⟨false, [7]⟩ ∧
    observe (after crash ⟨true, [7]⟩ [()]) ≠ observe (after crash ⟨false, [7]⟩ [()]) := by decide

theorem endpoint_sampling_misses_a_cycle :
    ([false, true, false] : List Bool).head? = [false, true, false].getLast? ∧
    ([false, true, false] : List Bool)[0]? ≠ [false, true, false][1]? := by decide

-- A counterexample to requiring every implementation field in every valid abstraction.
def cachedStep (s : Nat × Bool) (a : Nat) : Nat × Bool := (s.1 + a, !s.2)
theorem cache_can_be_hidden : Congruent (fun s : Nat × Bool => s.1) cachedStep := by
  intro s t he a
  exact congrArg (fun n => n + a) he

end Snuffy.Book.ContextualObservation
