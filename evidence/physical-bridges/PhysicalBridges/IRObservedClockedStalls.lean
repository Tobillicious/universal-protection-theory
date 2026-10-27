/-
IR-49: source-level composition of partially observed physical-state
safety (IR-38) with bounded stalls plus clock (IR-46). Neither hidden
state clairvoyance nor real physical event completion is inferred.
The rank and finite stall budget remain explicit conditional premises.
-/
import PhysicalBridges.IRBeliefService
import PhysicalBridges.IRClockedBoundedStalls

namespace PhysicalBridges.IRObservedClockedStalls
universe u v w z
variable {S : Type u} {A : Type v} {D : Type w} {O : Type z}

/-- A safe observation-history policy with a FINITE BUDGET on actual
nonproductive disturbances, a well-founded belief progress rank, and
certified physical event timing delivers the modeled service to the
actual physical endpoint by the stated (conditional) deadline. -/
theorem actual_state_safe_and_served_with_bounded_stalls
    (next : S → A → D → S) (observe : S → O)
    (policy : (S → Prop) → A) (safe served : S → Prop)
    (K : (S → Prop) → Prop)
    (potential : (S → Prop) → Nat)
    (productive : D → Bool)
    (hKernelSafe : ∀ B, K B → ∀ s, B s → safe s)
    (hPolicy : ∀ B, K B →
      ∀ o : O, (∃ t, IRBeliefViability.Post
        next observe B (policy B) o t) →
        K (IRBeliefViability.Post next observe B (policy B) o))
    (hAbsorb : ∀ s a d, served s → served (next s a d))
    (hZero : ∀ (st : IRBeliefTrace.Tracked S),
      IRBeliefService.Good K st →
      potential st.belief = 0 →
      IRBeliefService.ServedBelief served st.belief)
    (hProductive : ∀ (st : IRBeliefTrace.Tracked S) (d : D),
      IRBeliefService.Good K st →
      ¬ IRBeliefService.ServedBelief served st.belief →
      productive d = true →
      potential (IRBeliefTrace.advance next observe policy st d).belief <
        potential st.belief)
    (hStall : ∀ (st : IRBeliefTrace.Tracked S) (d : D),
      IRBeliefService.Good K st →
      ¬ IRBeliefService.ServedBelief served st.belief →
      productive d = false →
      potential (IRBeliefTrace.advance next observe policy st d).belief ≤
        potential st.belief)
    (time : Nat → Nat) (maxDelay : Nat)
    (hDelay : ∀ n, time (n + 1) ≤ time n + maxDelay)
    (trace : List D) (st : IRBeliefTrace.Tracked S)
    (maxStalls : Nat)
    (hGood : IRBeliefService.Good K st)
    (hStallBound :
      IRBoundedStalls.stallCount productive trace ≤ maxStalls)
    (hLength : trace.length = potential st.belief + maxStalls) :
    let final := IRBeliefTrace.run next observe policy st trace
    K final.belief ∧ final.belief final.actual ∧
      safe final.actual ∧ served final.actual ∧
      time trace.length ≤ time 0 +
        (potential st.belief + maxStalls) * maxDelay := by
  have hInv : ∀ (current : IRBeliefTrace.Tracked S) (d : D),
      IRBeliefService.Good K current →
      IRBeliefService.Good K
        (IRBeliefTrace.advance next observe policy current d) := by
    intro current d hc
    exact IRBeliefService.guarded_belief_step
      next observe policy K hPolicy current d hc
  have hGoalAbsorb : ∀ (current : IRBeliefTrace.Tracked S) (d : D),
      IRBeliefService.Good K current →
      IRBeliefService.ServedBelief served current.belief →
      IRBeliefService.ServedBelief served
        (IRBeliefTrace.advance next observe policy current d).belief := by
    intro current d _ hg
    exact IRBeliefService.service_absorbing_across_belief_update
      next observe policy served hAbsorb current d hg
  obtain ⟨hFinalGood, hFinalServed, hClock⟩ :=
    IRClockedBoundedStalls.exact_horizon_clocked_service
      (IRBeliefTrace.advance next observe policy)
      (IRBeliefService.Good K)
      (fun current => IRBeliefService.ServedBelief served current.belief)
      (fun current => potential current.belief)
      productive
      hInv hGoalAbsorb hZero hProductive hStall
      time maxDelay hDelay trace st maxStalls
      hGood hStallBound hLength
  dsimp
  exact ⟨hFinalGood.1, hFinalGood.2,
    hKernelSafe _ hFinalGood.1 _ hFinalGood.2,
    hFinalServed _ hFinalGood.2,
    hClock⟩

#print axioms actual_state_safe_and_served_with_bounded_stalls
end PhysicalBridges.IRObservedClockedStalls
