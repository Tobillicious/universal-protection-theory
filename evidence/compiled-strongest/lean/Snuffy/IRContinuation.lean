import Snuffy.BookContextualObservation

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IRContinuation.lean` at main `740abbb` (sha256 `900f66f5a0f09754dc8fb915890b7b0cfb310d1ba34e8af0b986f01ad58d8089`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false
/-
IR-8: historical continuation as an explicit *forward simulation*, relative
to an observable projection and trusted transition correspondence.
The original ContextualObservation.lean is imported unchanged from main.
Finite future-observation agreement is NOT by itself a proof of personal
identity, ontological continuity, subjective experience, or complete hardware
event coverage. See counterexample and outstanding obligations.
-/

namespace PhysicalBridges.IRContinuation
universe u v w z
variable {C : Type u} {A : Type v} {E : Type w} {O : Type z}

/-- Every admitted physical transition has a matching model transition
preserving a declared relation between concrete and abstract state. -/
def StepRefines
    (rel : C → A → Prop) (physicalStep : C → E → C)
    (abstractStep : A → E → A) : Prop :=
  ∀ c a, rel c a → ∀ e, rel (physicalStep c e) (abstractStep a e)

/-- The actual source module's foldl execution function is used on both sides.
Local one-step simulation composes over arbitrary finite event words. -/
theorem source_level_finite_simulation
    (rel : C → A → Prop) (physicalStep : C → E → C)
    (abstractStep : A → E → A)
    (hStep : StepRefines rel physicalStep abstractStep) :
    ∀ trace : List E, ∀ c a, rel c a →
      rel (Snuffy.Book.ContextualObservation.after physicalStep c trace)
          (Snuffy.Book.ContextualObservation.after abstractStep a trace) := by
  intro trace
  induction trace with
  | nil =>
      intro c a h
      simpa [Snuffy.Book.ContextualObservation.after] using h
  | cons e tail ih =>
      intro c a h
      simpa [Snuffy.Book.ContextualObservation.after] using
        ih (physicalStep c e) (abstractStep a e) (hStep c a h e)

/-- A correct correspondence at every related pair gives equality of the
observed physical and journal-model futures, for all finite histories. -/
theorem future_observations_agree_under_refinement
    (rel : C → A → Prop) (physicalStep : C → E → C)
    (abstractStep : A → E → A) (physObs : C → O) (modelObs : A → O)
    (hStep : StepRefines rel physicalStep abstractStep)
    (hObs : ∀ c a, rel c a → physObs c = modelObs a)
    (c : C) (a : A) (hInitial : rel c a) (trace : List E) :
    physObs (Snuffy.Book.ContextualObservation.after physicalStep c trace) =
      modelObs (Snuffy.Book.ContextualObservation.after abstractStep a trace) := by
  apply hObs
  exact source_level_finite_simulation
    rel physicalStep abstractStep hStep trace c a hInitial

/-- Existing contextual-observation source proves the exact criterion:
one-step congruence suffices to preserve all finite observed continuations. -/
theorem reuse_contextual_observation_certificate
    (physicalObs : C → O) (physicalStep : C → E → C)
    (hCongruent : Snuffy.Book.ContextualObservation.Congruent physicalObs physicalStep) :
    Snuffy.Book.ContextualObservation.ContextSafe physicalObs physicalStep :=
  (Snuffy.Book.ContextualObservation.contextual_iff_congruent
    physicalObs physicalStep).2 hCongruent

/-- Observation equality does not imply identity of distinct physical states.
The semantics of what counts as a continuing subject is an independent
application-level relation, not a conclusion of this observational theorem. -/
theorem same_observation_different_physical_states :
    ∃ (first second : Bool) (obs : Bool → Unit),
      obs first = obs second ∧ first ≠ second := by
  refine ⟨false, true, fun _ => (), rfl, ?_⟩
  decide

end PhysicalBridges.IRContinuation
