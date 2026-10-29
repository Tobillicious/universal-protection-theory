/-! Independent Codex formalization of the received R16 mathematical statement.
The attachment named Lean candidates but supplied only the proof manuscript.
Histories retain the initial observation and all commands and next observations.
The abstract transition is a parameter, not defined by transporting the source.
This is a deterministic observable-history theorem; no probability law is inferred.
-/
namespace UPTR16

structure History (O R : Type) where
  initial : O
  rounds : List R

structure Configuration (X O R : Type) where
  state : X
  history : History O R

def mapState {S A O R : Type} (p : S → A) (z : Configuration S O R) :
    Configuration A O R := ⟨p z.state, z.history⟩

def iterate {X : Type} (f : X → X) : Nat → X → X
  | 0, x => x
  | n + 1, x => f (iterate f n x)

theorem map_iterate {S A : Type} (p : S → A) (f : S → S) (g : A → A)
    (square : ∀ s, p (f s) = g (p s)) (n : Nat) (s : S) :
    p (iterate f n s) = iterate g n (p s) := by
  induction n with
  | zero => rfl
  | succ n ih => simp only [iterate, square, ih]

def tick {X C E O : Type} (T : X → C → E → X) (obs : X → O)
    (controller : History O (C × O) → C)
    (environment : History O (C × O) → C → E)
    (z : Configuration X O (C × O)) : Configuration X O (C × O) :=
  let c := controller z.history
  let e := environment z.history c
  let next := T z.state c e
  ⟨next, ⟨z.history.initial, z.history.rounds ++ [(c, obs next)]⟩⟩

theorem tick_commutes {S A C E O : Type}
    (T : S → C → E → S) (U : A → C → E → A) (p : S → A)
    (obsS : S → O) (obsA : A → O)
    (square : ∀ s c e, p (T s c e) = U (p s) c e)
    (fidelity : ∀ s, obsS s = obsA (p s))
    (controller : History O (C × O) → C)
    (environment : History O (C × O) → C → E)
    (z : Configuration S O (C × O)) :
    mapState p (tick T obsS controller environment z) =
      tick U obsA controller environment (mapState p z) := by
  cases z with
  | mk s h =>
      simp only [mapState, tick]
      rw [fidelity, square]

theorem reactive_lockstep {S A C E O : Type}
    (T : S → C → E → S) (U : A → C → E → A) (p : S → A)
    (obsS : S → O) (obsA : A → O)
    (square : ∀ s c e, p (T s c e) = U (p s) c e)
    (fidelity : ∀ s, obsS s = obsA (p s))
    (controller : History O (C × O) → C)
    (environment : History O (C × O) → C → E)
    (n : Nat) (s : S) :
    mapState p (iterate (tick T obsS controller environment) n
      ⟨s, ⟨obsS s, []⟩⟩) =
    iterate (tick U obsA controller environment) n
      ⟨p s, ⟨obsA (p s), []⟩⟩ := by
  rw [map_iterate (mapState p) _ _
    (tick_commutes T U p obsS obsA square fidelity controller environment)]
  simp only [mapState, fidelity]

end UPTR16

