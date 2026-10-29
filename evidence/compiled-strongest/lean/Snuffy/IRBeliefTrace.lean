import Snuffy.IRBeliefViability

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IRBeliefTrace.lean` at main `740abbb` (sha256 `25d1e3aaf0e8e92419296d17105c264387b555bf297522784b7cf45fe21f6d4d`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false
/-
IR-19: full finite-trace simulation of a physical state and the evolving
observation-history belief supporting a single selected belief policy.
IR-13 supplied only one-step correctness; this closes the finite-trace
inductive join without positing true physical-state access.

Does not establish true sensor semantics, latency, bounded belief
computation, infinite/continuous time, or historic/subjective identity.
-/

namespace PhysicalBridges.IRBeliefTrace
universe u v w z
variable {S : Type u} {A : Type v} {D : Type w} {O : Type z}

structure Tracked (S : Type u) where
  actual : S
  belief : S → Prop

/-- The controller observes only its current belief/history. After a
physical disturbance the newly observed value selects the next belief. -/
def advance (next : S → A → D → S) (observe : S → O)
    (policy : (S → Prop) → A) (state : Tracked S) (d : D) : Tracked S :=
  let a := policy state.belief
  let t := next state.actual a d
  { actual := t,
    belief := IRBeliefViability.Post next observe state.belief a (observe t) }

def run (next : S → A → D → S) (observe : S → O)
    (policy : (S → Prop) → A) (start : Tracked S)
    (trace : List D) : Tracked S :=
  trace.foldl (advance next observe policy) start

/-- If the current actual state is in the belief, then after every physical
disturbance it is in the updated belief. No clairvoyant action selector. -/
theorem advance_preserves_true_membership
    (next : S → A → D → S) (observe : S → O)
    (policy : (S → Prop) → A) (state : Tracked S) (d : D)
    (hBelief : state.belief state.actual) :
    (advance next observe policy state d).belief
      (advance next observe policy state d).actual := by
  exact IRBeliefViability.real_next_belongs_to_updated_belief
    next observe state.belief state.actual (policy state.belief) d hBelief

/-- A uniform, belief-dependent action preserving the fixed-point family
for all actually possible next observations. -/
theorem advance_preserves_kernel
    (next : S → A → D → S) (observe : S → O)
    (initial : (S → Prop) → Prop) (k : Nat)
    (policy : (S → Prop) → A)
    (hPolicy : ∀ B,
      IRBeliefViability.Approx next observe initial k B →
      ∀ o : O, (∃ t, IRBeliefViability.Post next observe B (policy B) o t) →
        IRBeliefViability.Approx next observe initial k
          (IRBeliefViability.Post next observe B (policy B) o))
    (state : Tracked S) (d : D)
    (hKernel : IRBeliefViability.Approx next observe initial k state.belief)
    (hBelief : state.belief state.actual) :
    IRBeliefViability.Approx next observe initial k
      (advance next observe policy state d).belief := by
  have realNext :=
    IRBeliefViability.real_next_belongs_to_updated_belief
      next observe state.belief state.actual (policy state.belief) d hBelief
  exact hPolicy state.belief hKernel
    (observe (next state.actual (policy state.belief) d))
    ⟨next state.actual (policy state.belief) d, realNext⟩

/-- Complete finite-trace theorem: the actual successor continues to belong
to the updated belief at every step, that belief remains in the invariant
family, and the actual endpoint is safe. Empty-trace case is included. -/
theorem finite_trace_belief_and_physical_safety
    (next : S → A → D → S) (observe : S → O)
    (safe : S → Prop) (initial : (S → Prop) → Prop) (k : Nat)
    (policy : (S → Prop) → A)
    (hInitialSafe : ∀ B, initial B → IRBeliefViability.SafeBelief safe B)
    (hPolicy : ∀ B,
      IRBeliefViability.Approx next observe initial k B →
      ∀ o : O, (∃ t, IRBeliefViability.Post next observe B (policy B) o t) →
        IRBeliefViability.Approx next observe initial k
          (IRBeliefViability.Post next observe B (policy B) o)) :
    ∀ trace (state : Tracked S),
      IRBeliefViability.Approx next observe initial k state.belief →
      state.belief state.actual →
      let result := run next observe policy state trace
      IRBeliefViability.Approx next observe initial k result.belief ∧
      result.belief result.actual ∧ safe result.actual := by
  intro trace
  induction trace with
  | nil =>
      intro state hk hm
      have h0 := IRBeliefViability.approx_inside_initial
        next observe initial k state.belief hk
      exact ⟨hk, hm, (hInitialSafe state.belief h0).2 state.actual hm⟩
  | cons d ds ih =>
      intro state hk hm
      have hNextK := advance_preserves_kernel next observe initial k
        policy hPolicy state d hk hm
      have hNextM := advance_preserves_true_membership
        next observe policy state d hm
      exact ih (advance next observe policy state d) hNextK hNextM

/-- A verified stabilized belief kernel gives an observation-history
policy satisfying the complete finite-trace contract. -/
theorem stable_belief_policy_safe_on_all_finite_traces
    (next : S → A → D → S) (observe : S → O)
    (safe : S → Prop) (initial : (S → Prop) → Prop) (k : Nat)
    [Nonempty A]
    (hInitialSafe : ∀ B, initial B → IRBeliefViability.SafeBelief safe B)
    (hStable : ∀ B,
      IRBeliefViability.Prune next observe
        (IRBeliefViability.Approx next observe initial k) B ↔
      IRBeliefViability.Approx next observe initial k B) :
    ∃ policy : (S → Prop) → A,
      ∀ trace (state : Tracked S),
        IRBeliefViability.Approx next observe initial k state.belief →
        state.belief state.actual →
        let result := run next observe policy state trace
        IRBeliefViability.Approx next observe initial k result.belief ∧
        result.belief result.actual ∧ safe result.actual := by
  obtain ⟨policy, hp⟩ :=
    IRBeliefViability.stable_belief_has_policy next observe initial k hStable
  exact ⟨policy, finite_trace_belief_and_physical_safety
    next observe safe initial k policy hInitialSafe hp⟩

end PhysicalBridges.IRBeliefTrace
