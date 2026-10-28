import PhysicalBridges.IRObservedClockedStalls
import PhysicalBridges.IR93UnifiedConditional

/-!
IR-94: source-level service adapter.
This theorem imports the original IR-49 theorem without replacing
its physical observation, progress or clock premises.
-/
namespace PhysicalBridges.IR94

universe u v w z
variable {S : Type u} {A : Type v} {D : Type w} {O : Type z}

theorem original_ir49_safe_served_clocked
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
        (potential st.belief + maxStalls) * maxDelay :=
  IRObservedClockedStalls.actual_state_safe_and_served_with_bounded_stalls
    next observe policy safe served K potential productive
    hKernelSafe hPolicy hAbsorb hZero hProductive hStall
    time maxDelay hDelay trace st maxStalls hGood hStallBound hLength

end PhysicalBridges.IR94
