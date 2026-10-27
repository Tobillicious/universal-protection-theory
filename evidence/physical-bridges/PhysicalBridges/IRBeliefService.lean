/-
IR-38: apply IR-37's bounded eventual-service rank to the ACTUAL physical
state tracked by IR-19's observation-history belief. A safe belief alone
does not deliver service, but a decreasing rank and absorbing service
goal suffice for every finite disturbance trace at the declared horizon.

The theorem does NOT establish an implementable physical rank, complete
observation model, or that original UPT freedoms can all be delivered.
-/
import PhysicalBridges.IRServiceProgress

namespace PhysicalBridges.IRBeliefService
universe u v w z
variable {S : Type u} {A : Type v} {D : Type w} {O : Type z}

/-- The protected state is the pair of the real modeled physical state
and the observation-history belief that contains it. -/
def Good (K : (S → Prop) → Prop)
    (st : IRBeliefTrace.Tracked S) : Prop :=
  K st.belief ∧ st.belief st.actual

/-- To claim service from a partially observed controller, EVERY
still-possible physical state must meet the goal. -/
def ServedBelief (served : S → Prop) (B : S → Prop) : Prop :=
  ∀ s, B s → served s

/-- An absorbing goal cannot be lost by the post-action observation
update, provided it truly remains satisfied by all physical successors. -/
theorem service_absorbing_across_belief_update
    (next : S → A → D → S) (observe : S → O)
    (policy : (S → Prop) → A) (served : S → Prop)
    (hAbsorb : ∀ s a d, served s → served (next s a d))
    (st : IRBeliefTrace.Tracked S) (d : D)
    (hs : ServedBelief served st.belief) :
    ServedBelief served
      (IRBeliefTrace.advance next observe policy st d).belief := by
  intro target hTarget
  obtain ⟨_, prior, hPrior, disturbance, hMatch⟩ := hTarget
  have previous : served prior := hs prior hPrior
  rw [← hMatch]
  exact hAbsorb prior (policy st.belief) disturbance previous

/-- The chosen policy is observation-history based, never clairvoyantly
based on the hidden actual state. We use IR-19's source member theorem
and IR-13's source observation-update relation at every transition. -/
theorem guarded_belief_step
    (next : S → A → D → S) (observe : S → O)
    (policy : (S → Prop) → A)
    (K : (S → Prop) → Prop)
    (hPolicy : ∀ B, K B →
      ∀ o : O, (∃ t, IRBeliefViability.Post
          next observe B (policy B) o t) →
        K (IRBeliefViability.Post next observe B (policy B) o))
    (st : IRBeliefTrace.Tracked S) (d : D)
    (hGood : Good K st) :
    Good K (IRBeliefTrace.advance next observe policy st d) := by
  obtain ⟨hKernel, hActual⟩ := hGood
  have hPhysical := IRBeliefViability.real_next_belongs_to_updated_belief
    next observe st.belief st.actual (policy st.belief) d hActual
  have hNextKernel :=
    hPolicy st.belief hKernel
      (observe (next st.actual (policy st.belief) d))
      ⟨next st.actual (policy st.belief) d, hPhysical⟩
  exact ⟨hNextKernel,
    IRBeliefTrace.advance_preserves_true_membership
      next observe policy st d hActual⟩

/-- The physical state and associated belief remain correct for every
finite history. This is reusable without any eventual-service claim. -/
theorem guarded_belief_trace
    (next : S → A → D → S) (observe : S → O)
    (policy : (S → Prop) → A)
    (K : (S → Prop) → Prop)
    (hPolicy : ∀ B, K B →
      ∀ o : O, (∃ t, IRBeliefViability.Post
          next observe B (policy B) o t) →
        K (IRBeliefViability.Post next observe B (policy B) o)) :
    ∀ (trace : List D) (st : IRBeliefTrace.Tracked S),
      Good K st → Good K (IRBeliefTrace.run next observe policy st trace) := by
  intro trace
  induction trace with
  | nil =>
      intro st hs
      exact hs
  | cons d ds ih =>
      intro st hs
      exact ih (IRBeliefTrace.advance next observe policy st d)
        (guarded_belief_step next observe policy K hPolicy st d hs)

/-- Combine actual-state/observation correctness and IR-37's adversarial
rank theorem: after at least potential(initialBelief) transitions, the
ACTUAL physical state is safe and HAS received the modeled service.

The decreasing belief-rank condition is a substantive additional
obligation and cannot be inferred from safety or controller finality. -/
theorem bounded_observed_service_for_actual_physical_state
    (next : S → A → D → S) (observe : S → O)
    (policy : (S → Prop) → A)
    (safe served : S → Prop)
    (K : (S → Prop) → Prop)
    (potential : (S → Prop) → Nat)
    [Nonempty D]
    (hKernelSafe : ∀ B, K B → ∀ s, B s → safe s)
    (hPolicy : ∀ B, K B →
      ∀ o : O, (∃ t, IRBeliefViability.Post
          next observe B (policy B) o t) →
        K (IRBeliefViability.Post next observe B (policy B) o))
    (hAbsorb : ∀ s a d, served s → served (next s a d))
    (hDecrease : ∀ (st : IRBeliefTrace.Tracked S) (d : D),
      Good K st → ¬ ServedBelief served st.belief →
      potential (IRBeliefTrace.advance next observe policy st d).belief <
      potential st.belief) :
    ∀ (trace : List D) (st : IRBeliefTrace.Tracked S),
      Good K st → potential st.belief ≤ trace.length →
      let final := IRBeliefTrace.run next observe policy st trace
      K final.belief ∧ final.belief final.actual ∧
        safe final.actual ∧ served final.actual := by
  have inv : ∀ (st : IRBeliefTrace.Tracked S) (d : D),
      Good K st → Good K (IRBeliefTrace.advance next observe policy st d) := by
    intro st d hs
    exact guarded_belief_step next observe policy K hPolicy st d hs
  have absorb : ∀ (st : IRBeliefTrace.Tracked S) (d : D),
      Good K st → ServedBelief served st.belief →
      ServedBelief served
        (IRBeliefTrace.advance next observe policy st d).belief := by
    intro st d _ hs
    exact service_absorbing_across_belief_update
      next observe policy served hAbsorb st d hs
  have progress := IRServiceProgress.ranked_trace_reaches_goal
    (IRBeliefTrace.advance next observe policy)
    (Good K)
    (fun st => ServedBelief served st.belief)
    (fun st => potential st.belief)
    inv absorb hDecrease
  intro trace st hs hLength
  have stillGood : Good K
      (IRBeliefTrace.run next observe policy st trace) :=
    guarded_belief_trace next observe policy K hPolicy trace st hs
  have nowServed : ServedBelief served
      (IRBeliefTrace.run next observe policy st trace).belief :=
    progress trace st hs hLength
  dsimp
  exact ⟨stillGood.1, stillGood.2,
    hKernelSafe _ stillGood.1 _ stillGood.2,
    nowServed _ stillGood.2⟩

#print axioms service_absorbing_across_belief_update
#print axioms guarded_belief_step
#print axioms guarded_belief_trace
#print axioms bounded_observed_service_for_actual_physical_state
end PhysicalBridges.IRBeliefService
