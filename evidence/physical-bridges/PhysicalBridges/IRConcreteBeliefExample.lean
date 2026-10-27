/-
IR-22: a NONEMPTY, explicitly stabilized partial-observation belief kernel,
with a concrete safe policy despite complete sensor ambiguity.
Contrasts IR-6's case where the same ambiguity makes control impossible.
Synthetic model only; not an instrument or a consciousness certificate.
-/
import PhysicalBridges.IRBeliefTrace

namespace PhysicalBridges.IRConcreteBeliefExample

/-- Two distinct safe values 0 and 1, with all higher states unsafe. -/
def safe (s : Nat) : Prop := s ≤ 1

/-- Deliberately maximally coarse sensor: no state information. -/
def observe (_ : Nat) : Unit := ()

/-- False is a universal safe hold; true advances physical state and
can destroy safety of state 1. -/
def next (s : Nat) (a : Bool) (_ : Unit) : Nat :=
  if a then s + 1 else s

def safeFamily : (Nat → Prop) → Prop :=
  IRBeliefViability.SafeBelief safe

def initialBelief (s : Nat) : Prop := s ≤ 1

theorem nonempty_initial_belief : safeFamily initialBelief := by
  constructor
  · exact ⟨0, Nat.zero_le 1⟩
  · intro s hs
    exact hs

/-- This particular partially observable belief family is a fixed point
IMMEDIATELY, for a nontrivial protected interval. No stable-k assumption. -/
theorem concrete_belief_family_stable :
    ∀ B : Nat → Prop,
      IRBeliefViability.Prune next observe safeFamily B ↔ safeFamily B := by
  intro B
  constructor
  · intro h; exact h.1
  · intro h
    refine ⟨h, false, ?_⟩
    intro o hp
    constructor
    · exact hp
    · intro t ht
      obtain ⟨_, s, hs, d, he⟩ := ht
      have st : s = t := by simpa [next] using he
      rw [← st]
      exact h.2 s hs

/-- A real safe physical state can be contained in the nonempty belief,
including the second safe state (despite identical sensor readings). -/
theorem both_safe_states_represented :
    initialBelief 0 ∧ initialBelief 1 ∧
    observe 0 = observe 1 := by
  constructor
  · exact Nat.zero_le 1
  constructor
  · exact Nat.le_refl 1
  · rfl

/-- A policy based on this ambiguous belief survives EVERY finite modeled
disturbance trace. Derived from the actual IR-19 arbitrary-trace theorem. -/
theorem coarse_sensor_safe_policy_exists :
    ∃ policy : (Nat → Prop) → Bool,
      ∀ trace : List Unit,
        safe (IRBeliefTrace.run next observe policy
          ⟨0, initialBelief⟩ trace).actual := by
  obtain ⟨policy, hAll⟩ :=
    IRBeliefTrace.stable_belief_policy_safe_on_all_finite_traces
      next observe safe safeFamily 0
      (fun B h => h) concrete_belief_family_stable
  refine ⟨policy, ?_⟩
  intro trace
  have hK : IRBeliefViability.Approx next observe safeFamily 0 initialBelief :=
    nonempty_initial_belief
  have hm : initialBelief 0 := Nat.zero_le 1
  have hResult := hAll trace ⟨0, initialBelief⟩ hK hm
  exact hResult.2.2

/-- Counterexample: the alternate action is not robustly safe across the
very same observation fiber (state 1 will leave the protected interval). -/
theorem ambiguous_belief_rejects_unsafe_action :
    ¬ ∀ s, initialBelief s → safe (next s true ()) := by
  intro h
  have bad := h 1 (Nat.le_refl 1)
  have impossible : ¬ safe 2 := by
    change ¬ 2 ≤ 1
    exact Nat.not_succ_le_self 1
  exact impossible (by simpa [next] using bad)

#print axioms nonempty_initial_belief
#print axioms concrete_belief_family_stable
#print axioms both_safe_states_represented
#print axioms coarse_sensor_safe_policy_exists
#print axioms ambiguous_belief_rejects_unsafe_action
end PhysicalBridges.IRConcreteBeliefExample
