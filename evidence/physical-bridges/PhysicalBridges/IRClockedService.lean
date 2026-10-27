/-
IR-41: a bounded number of controlled transitions does not guarantee
a real-world deadline. An externally established upper delay between
ACTUALLY COMMITTED events is essential. Lean checks the implication,
not the truth of the hardware timing certificate.
-/
import PhysicalBridges.IRBeliefService
namespace PhysicalBridges.IRClockedService
universe u v w z
variable {S : Type u} {A : Type v} {D : Type w} {O : Type z}

/-- A max inter-step delay yields an upper bound on elapsed time
for n genuinely completed physical transitions. -/
theorem interstep_upper_bound
    (time : Nat → Nat) (maxDelay : Nat)
    (hDelay : ∀ n, time (n + 1) ≤ time n + maxDelay) :
    ∀ n, time n ≤ time 0 + n * maxDelay := by
  intro n
  induction n with
  | zero => simp
  | succ n ih =>
      calc
        time (n + 1) ≤ time n + maxDelay := hDelay n
        _ ≤ (time 0 + n * maxDelay) + maxDelay :=
          Nat.add_le_add_right ih maxDelay
        _ = time 0 + (n + 1) * maxDelay := by
          simp [Nat.succ_mul, Nat.add_assoc]

/-- The IR-38 observed-belief policy delivers actual physical service
at a bounded real time only if the supplied completed trace is
physically truthful and its event clock has a genuine latency bound. -/
theorem clocked_observed_service_if_steps_complete
    (next : S → A → D → S) (observe : S → O)
    (policy : (S → Prop) → A) (safe served : S → Prop)
    (K : (S → Prop) → Prop)
    (potential : (S → Prop) → Nat) [Nonempty D]
    (time : Nat → Nat) (maxDelay : Nat)
    (hDelay : ∀ n, time (n + 1) ≤ time n + maxDelay)
    (hSafe : ∀ B, K B → ∀ s, B s → safe s)
    (hPolicy : ∀ B, K B →
      ∀ o : O, (∃ t, IRBeliefViability.Post
        next observe B (policy B) o t) →
        K (IRBeliefViability.Post next observe B (policy B) o))
    (hAbsorb : ∀ s a d, served s → served (next s a d))
    (hDecrease : ∀ (st : IRBeliefTrace.Tracked S) (d : D),
      IRBeliefService.Good K st →
      ¬ IRBeliefService.ServedBelief served st.belief →
      potential (IRBeliefTrace.advance next observe policy st d).belief <
        potential st.belief)
    (trace : List D) (st : IRBeliefTrace.Tracked S)
    (hGood : IRBeliefService.Good K st)
    (hLength : trace.length = potential st.belief) :
    let final := IRBeliefTrace.run next observe policy st trace
    safe final.actual ∧ served final.actual ∧
      time trace.length ≤ time 0 + potential st.belief * maxDelay := by
  have hEnough : potential st.belief ≤ trace.length := by omega
  have result := IRBeliefService.bounded_observed_service_for_actual_physical_state
    next observe policy safe served K potential
    hSafe hPolicy hAbsorb hDecrease trace st hGood hEnough
  have clock := interstep_upper_bound time maxDelay hDelay trace.length
  dsimp
  refine ⟨result.2.2.1, result.2.2.2, ?_⟩
  simpa [hLength] using clock

def slowClock (delay n : Nat) : Nat := n * (delay + 1)

/-- For every proposed deadline, a physically progressive clock can
make the first event later than that deadline, absent an upper bound. -/
theorem progress_without_latency_has_no_deadline :
    ∀ proposed : Nat, ∃ time : Nat → Nat,
      time 1 > time 0 + proposed ∧
      (∀ n, time n + 1 ≤ time (n + 1)) := by
  intro proposed
  refine ⟨slowClock proposed, ?_, ?_⟩
  · simp [slowClock]
  · intro n
    simp only [slowClock, Nat.succ_mul]
    omega

/-- Timestamps alone cannot prove real physical steps occurred. -/
theorem frozen_clock_is_not_completion_evidence :
    ∀ bound : Nat,
      ∀ n, (fun _ : Nat => 0) (n + 1) ≤
        (fun _ : Nat => 0) n + bound := by
  intro bound n
  exact Nat.zero_le _

#print axioms interstep_upper_bound
#print axioms clocked_observed_service_if_steps_complete
#print axioms progress_without_latency_has_no_deadline
#print axioms frozen_clock_is_not_completion_evidence
end PhysicalBridges.IRClockedService
