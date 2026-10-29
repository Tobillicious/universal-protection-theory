import Snuffy.R16TwoPhase

/-! Equal public transcripts for different internal realizations of one interface
strategy. The command square certifies that every actual realization implements
the demanded port. It cannot be established merely by labelling a policy with beta.
The state includes any pending effects, shared load and environment memory that
affect boundary responses. Prefix feasibility and outcome locality are separate.
-/
namespace UPTR16

theorem screened_fibre_lockstep {Policy S B U E O : Type}
    (sourceCommand : Policy → S → U → S)
    (sourceResponse : Policy → S → E → S)
    (boundaryCommand : B → U → B) (boundaryResponse : B → E → B)
    (p : S → B) (obsS : S → O) (obsB : B → O)
    (commandScreen : ∀ policy s u,
      p (sourceCommand policy s u) = boundaryCommand (p s) u)
    (responseScreen : ∀ policy s e,
      p (sourceResponse policy s e) = boundaryResponse (p s) e)
    (fidelity : ∀ s, obsS s = obsB (p s))
    (beta : History O (U × O × O) → U)
    (environment : History O (U × O × O) → U → O → E)
    (left right : Policy) (s t : S) (sameBoundary : p s = p t) (n : Nat) :
    mapState p (iterate (phaseTick (sourceCommand left) (sourceResponse left) obsS
      beta environment) n ⟨s, ⟨obsS s, []⟩⟩) =
    mapState p (iterate (phaseTick (sourceCommand right) (sourceResponse right) obsS
      beta environment) n ⟨t, ⟨obsS t, []⟩⟩) := by
  rw [two_phase_lockstep (sourceCommand left) boundaryCommand
    (sourceResponse left) boundaryResponse p obsS obsB
    (commandScreen left) (responseScreen left) fidelity beta environment n s]
  rw [two_phase_lockstep (sourceCommand right) boundaryCommand
    (sourceResponse right) boundaryResponse p obsS obsB
    (commandScreen right) (responseScreen right) fidelity beta environment n t]
  rw [sameBoundary]

end UPTR16

