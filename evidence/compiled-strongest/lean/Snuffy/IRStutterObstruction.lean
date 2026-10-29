import Snuffy.IRBeliefService

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IRStutterObstruction.lean` at main `740abbb` (sha256 `2a25a3f21cc2d831d70630e7ef1e743f6c9afdc558066a0fb596440ecf8ad719`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false
/-
IR-43: robust bounded service is incompatible with an unserved,
observation-invariant stuttering disturbance. Formal error control for
reading IR-37..IR-41 as universal service guarantees. The possibility of
a helpful action or branch does not defeat an adversarial stutter.

All results are about explicitly specified synthetic transition systems.
-/

namespace PhysicalBridges.IRStutterObstruction
universe u v
variable {T : Type u} {D : Type v}

/-- A truly non-goal, invariant state with one stuttering disturbance
cannot have a rank STRICTLY decreasing at every non-goal transition. -/
theorem stuttering_non_goal_refutes_any_progress_rank
    (step : T → D → T) (Inv Goal : T → Prop)
    (st : T) (disturbance : D)
    (hInv : Inv st) (hNoGoal : ¬ Goal st)
    (hStutter : step st disturbance = st) :
    ¬ ∃ rank : T → Nat,
      ∀ x d, Inv x → ¬ Goal x → rank (step x d) < rank x := by
  rintro ⟨rank, hDecrease⟩
  have impossible := hDecrease st disturbance hInv hNoGoal
  rw [hStutter] at impossible
  omega

/-- IR-38's rank is over the observation-history belief, not merely
the hidden physical state. A belief-stuttering disturbance blocks the
required all-disturbance progress premise even when the physical state
or controller action might otherwise change. -/
theorem unchanged_unserved_belief_blocks_rank
    {S : Type u} {A : Type v} {E : Type} {O : Type}
    (next : S → A → E → S) (observe : S → O)
    (policy : (S → Prop) → A) (served : S → Prop)
    (K : (S → Prop) → Prop)
    (st : IRBeliefTrace.Tracked S) (d : E)
    (hGood : IRBeliefService.Good K st)
    (hNotServed : ¬ IRBeliefService.ServedBelief served st.belief)
    (hSameBelief :
      (IRBeliefTrace.advance next observe policy st d).belief = st.belief) :
    ¬ ∃ potential : (S → Prop) → Nat,
      ∀ (current : IRBeliefTrace.Tracked S) (event : E),
        IRBeliefService.Good K current →
        ¬ IRBeliefService.ServedBelief served current.belief →
        potential (IRBeliefTrace.advance next observe policy current event).belief <
          potential current.belief := by
  rintro ⟨potential, hDecrease⟩
  have impossible := hDecrease st d hGood hNotServed
  rw [hSameBelief] at impossible
  omega

/-- A constant sensor plus a physically available stuttering event.
The helpful event can serve, but the adversarial event does not. -/
def adversarialNext (s : Bool) (_ : Unit) (d : Bool) : Bool :=
  if d then true else s

def observe (_ : Bool) : Unit := ()
def policy (_ : Bool → Prop) : Unit := ()
def served (s : Bool) : Prop := s = true
def K (B : Bool → Prop) : Prop := B false

def initial : IRBeliefTrace.Tracked Bool :=
  ⟨false, fun _ => True⟩

theorem initially_unserved :
    ¬ IRBeliefService.ServedBelief served initial.belief := by
  intro h
  have impossible := h false trivial
  change false = true at impossible
  cases impossible

theorem initial_is_good : IRBeliefService.Good K initial :=
  ⟨trivial, trivial⟩

theorem helpful_and_stalling_disturbances :
    adversarialNext false () true = true ∧
    adversarialNext false () false = false := by
  exact ⟨rfl, rfl⟩

/-- The entire set of possible states remains possible after the adverse
event, even though the other event would provide the desired service. -/
theorem adverse_event_keeps_belief_unchanged :
    (IRBeliefTrace.advance adversarialNext observe policy initial false).belief =
      initial.belief := by
  funext target
  apply propext
  constructor
  · intro _
    trivial
  · intro _
    change IRBeliefViability.Post adversarialNext observe initial.belief ()
      (observe (adversarialNext initial.actual () false)) target
    refine ⟨rfl, target, trivial, false, ?_⟩
    cases target <;> rfl

/-- Nonvacuous countermodel: safe possible progress exists, but the
robust all-disturbance rank required by IR-38 cannot exist. -/
theorem beneficial_option_does_not_force_robust_belief_progress :
    (adversarialNext false () true = true) ∧
    ¬ ∃ potential : (Bool → Prop) → Nat,
      ∀ (current : IRBeliefTrace.Tracked Bool) (d : Bool),
        IRBeliefService.Good K current →
        ¬ IRBeliefService.ServedBelief served current.belief →
        potential (IRBeliefTrace.advance
          adversarialNext observe policy current d).belief <
          potential current.belief := by
  constructor
  · rfl
  · exact unchanged_unserved_belief_blocks_rank
      adversarialNext observe policy served K initial false
      initial_is_good initially_unserved
      adverse_event_keeps_belief_unchanged

end PhysicalBridges.IRStutterObstruction
