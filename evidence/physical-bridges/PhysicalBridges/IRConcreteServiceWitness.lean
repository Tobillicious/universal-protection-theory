/-
IR-39: fully concrete nonvacuity control for IR-38. An agent with no
useful sensor (all states have the same observation) nevertheless
delivers service to an initially unserved state after one transition.
No physical installation or general joint freedom is implied.
-/
import PhysicalBridges.IRBeliefService

namespace PhysicalBridges.IRConcreteServiceWitness

def next (_ : Bool) (_ : Unit) (_ : Unit) : Bool := true
def observe (_ : Bool) : Unit := ()
def policy (_ : Bool → Prop) : Unit := ()
def safe (_ : Bool) : Prop := True
def served (s : Bool) : Prop := s = true
def K (B : Bool → Prop) : Prop := ∃ s, B s

noncomputable def potential (B : Bool → Prop) : Nat := by
  classical
  exact if B false then 1 else 0

def initial : IRBeliefTrace.Tracked Bool :=
  ⟨false, fun _ => True⟩

/-- A nonempty belief containing two truly distinct possibilities.
Neither the observation nor the initial actual state promises service. -/
theorem initial_not_served : ¬ served initial.actual := by
  change ¬ (false = true)
  intro impossible
  cases impossible

theorem initial_is_ambiguous :
    initial.belief false ∧ initial.belief true ∧
      observe false = observe true := by
  exact ⟨trivial, trivial, rfl⟩

/-- The current actual state belongs to a nonempty safe belief. -/
theorem initial_good : IRBeliefService.Good K initial :=
  ⟨⟨false, trivial⟩, trivial⟩

/-- The controller's action keeps the belief inhabited as long as the
previous belief represented at least one actual possibility. -/
theorem uniform_policy_viable :
    ∀ B, K B →
      ∀ o : Unit,
        (∃ t, IRBeliefViability.Post next observe B (policy B) o t) →
          K (IRBeliefViability.Post next observe B (policy B) o) := by
  intro B _ o possible
  exact possible

theorem served_persists :
    ∀ s a d, served s → served (next s a d) := by
  intro s a d _
  rfl

theorem all_held_beliefs_are_safe :
    ∀ B, K B → ∀ s, B s → safe s := by
  intro B _ s _
  trivial

/-- If service has not yet been delivered in every still-possible
state, false is one of those possibilities. -/
theorem not_all_served_implies_false_possible
    (B : Bool → Prop)
    (h : ¬ IRBeliefService.ServedBelief served B) :
    B false := by
  by_cases hf : B false
  · exact hf
  · have all : IRBeliefService.ServedBelief served B := by
      intro s hs
      cases s with
      | false => exact False.elim (hf hs)
      | true => rfl
    exact False.elim (h all)

/-- Because physical next is always true, the updated belief cannot
contain false under any disturbance. -/
theorem false_excluded_after_update (B : Bool → Prop) :
    ¬ IRBeliefViability.Post next observe B () () false := by
  intro h
  obtain ⟨_, predecessor, _, disturbance, heq⟩ := h
  cases heq

/-- This is a *proved* rank drop in an explicit nonempty world,
not a declared existential liveness/viability premise. -/
theorem real_rank_decrease :
    ∀ (st : IRBeliefTrace.Tracked Bool) (d : Unit),
      IRBeliefService.Good K st →
      ¬ IRBeliefService.ServedBelief served st.belief →
      potential (IRBeliefTrace.advance next observe policy st d).belief <
      potential st.belief := by
  intro st d _ notServed
  have hf := not_all_served_implies_false_possible st.belief notServed
  have hn := false_excluded_after_update st.belief
  change potential (IRBeliefViability.Post next observe st.belief () ()) <
    potential st.belief
  simp [potential, hf, hn]

/-- One actual transition suffices although the initial sensor was
completely uninformative and the actual state had no service. This
instantiates the verified IR-38 source-level theorem. -/
theorem nonvacuous_one_step_service :
    safe (IRBeliefTrace.run next observe policy initial [()]).actual ∧
    served (IRBeliefTrace.run next observe policy initial [()]).actual := by
  have bound : potential initial.belief ≤ ([()] : List Unit).length := by
    simp [potential, initial]
  have final := IRBeliefService.bounded_observed_service_for_actual_physical_state
    next observe policy safe served K potential
    all_held_beliefs_are_safe uniform_policy_viable
    served_persists real_rank_decrease
    [()] initial initial_good bound
  exact ⟨final.2.2.1, final.2.2.2⟩

#print axioms initial_not_served
#print axioms initial_is_ambiguous
#print axioms initial_good
#print axioms real_rank_decrease
#print axioms nonvacuous_one_step_service
end PhysicalBridges.IRConcreteServiceWitness
