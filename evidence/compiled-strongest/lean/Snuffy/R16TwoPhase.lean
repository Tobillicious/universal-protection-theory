import Snuffy.R16Feedback

/-! Commands and environment responses have independently specified transitions.
The environment reads the actual intermediate observation. Both that observation
and the final observation enter the retained public history. -/
namespace UPTR16

def phaseTick {X C E O : Type} (commandStep : X → C → X)
    (responseStep : X → E → X) (obs : X → O)
    (controller : History O (C × O × O) → C)
    (environment : History O (C × O × O) → C → O → E)
    (z : Configuration X O (C × O × O)) : Configuration X O (C × O × O) :=
  let c := controller z.history
  let middle := commandStep z.state c
  let middleObs := obs middle
  let e := environment z.history c middleObs
  let next := responseStep middle e
  ⟨next, ⟨z.history.initial, z.history.rounds ++ [(c, middleObs, obs next)]⟩⟩

theorem phase_tick_commutes {S A C E O : Type}
    (sourceCommand : S → C → S) (abstractCommand : A → C → A)
    (sourceResponse : S → E → S) (abstractResponse : A → E → A)
    (p : S → A) (obsS : S → O) (obsA : A → O)
    (commandSquare : ∀ s c, p (sourceCommand s c) = abstractCommand (p s) c)
    (responseSquare : ∀ s e, p (sourceResponse s e) = abstractResponse (p s) e)
    (fidelity : ∀ s, obsS s = obsA (p s))
    (controller : History O (C × O × O) → C)
    (environment : History O (C × O × O) → C → O → E)
    (z : Configuration S O (C × O × O)) :
    mapState p (phaseTick sourceCommand sourceResponse obsS controller environment z) =
    phaseTick abstractCommand abstractResponse obsA controller environment (mapState p z) := by
  cases z with
  | mk s h =>
      simp only [phaseTick, mapState]
      simp only [fidelity, commandSquare, responseSquare]

theorem two_phase_lockstep {S A C E O : Type}
    (sourceCommand : S → C → S) (abstractCommand : A → C → A)
    (sourceResponse : S → E → S) (abstractResponse : A → E → A)
    (p : S → A) (obsS : S → O) (obsA : A → O)
    (commandSquare : ∀ s c, p (sourceCommand s c) = abstractCommand (p s) c)
    (responseSquare : ∀ s e, p (sourceResponse s e) = abstractResponse (p s) e)
    (fidelity : ∀ s, obsS s = obsA (p s))
    (controller : History O (C × O × O) → C)
    (environment : History O (C × O × O) → C → O → E)
    (n : Nat) (s : S) :
    mapState p (iterate (phaseTick sourceCommand sourceResponse obsS controller environment) n
      ⟨s, ⟨obsS s, []⟩⟩) =
    iterate (phaseTick abstractCommand abstractResponse obsA controller environment) n
      ⟨p s, ⟨obsA (p s), []⟩⟩ := by
  rw [map_iterate (mapState p) _ _ (phase_tick_commutes sourceCommand abstractCommand
    sourceResponse abstractResponse p obsS obsA commandSquare responseSquare fidelity
    controller environment)]
  simp only [mapState, fidelity]

end UPTR16

