import Snuffy.IRBoundedStalls
import Snuffy.IRClockedService

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IRClockedBoundedStalls.lean` at main `740abbb` (sha256 `c886710153e127d80ff9d728245b2e2134d19f444e753f3528311c79e70735f4`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false
/-
IR-46: compose source-level IR-44 finite-stall service and IR-41
per-COMPLETED-event maximum latency. This bounds completion time
only for an actually supplied physical event trace with a verified
stall budget. It does not imply that the required events take place.
-/

namespace PhysicalBridges.IRClockedBoundedStalls
universe u v
variable {T : Type u} {D : Type v}

/-- Service and invariant safety follow for the supplied finite event
trace, with a separate time bound relative to the number of completed
events. The time function must correspond to real committed events. -/
theorem actual_trace_service_and_elapsed_bound
    (step : T → D → T) (Inv Goal : T → Prop)
    (rank : T → Nat) (productive : D → Bool)
    (hInv : ∀ s d, Inv s → Inv (step s d))
    (hAbsorb : ∀ s d, Inv s → Goal s → Goal (step s d))
    (hZeroGoal : ∀ s, Inv s → rank s = 0 → Goal s)
    (hProductive : ∀ s d, Inv s → ¬ Goal s →
      productive d = true → rank (step s d) < rank s)
    (hStall : ∀ s d, Inv s → ¬ Goal s →
      productive d = false → rank (step s d) ≤ rank s)
    (time : Nat → Nat) (maxDelay : Nat)
    (hDelay : ∀ n, time (n + 1) ≤ time n + maxDelay)
    (trace : List D) (start : T) (maxStalls : Nat)
    (hInitial : Inv start)
    (hStalls : IRBoundedStalls.stallCount productive trace ≤ maxStalls)
    (hEnough : rank start + maxStalls ≤ trace.length) :
    Inv (trace.foldl step start) ∧
    Goal (trace.foldl step start) ∧
    time trace.length ≤ time 0 + trace.length * maxDelay := by
  refine ⟨IRBoundedStalls.invariant_through_trace
      step Inv hInv trace start hInitial, ?_, ?_⟩
  · exact IRBoundedStalls.bounded_stall_budget_forces_service
      step Inv Goal rank productive hInv hAbsorb hZeroGoal
      hProductive hStall trace start maxStalls hInitial hStalls hEnough
  · exact IRClockedService.interstep_upper_bound
      time maxDelay hDelay trace.length

/-- The advertised horizon is only justified if the supplied trace
actually completes at the critical rank+maxStalls event count.
Extra unbounded events must NOT be silently folded into a deadline. -/
theorem exact_horizon_clocked_service
    (step : T → D → T) (Inv Goal : T → Prop)
    (rank : T → Nat) (productive : D → Bool)
    (hInv : ∀ s d, Inv s → Inv (step s d))
    (hAbsorb : ∀ s d, Inv s → Goal s → Goal (step s d))
    (hZeroGoal : ∀ s, Inv s → rank s = 0 → Goal s)
    (hProductive : ∀ s d, Inv s → ¬ Goal s →
      productive d = true → rank (step s d) < rank s)
    (hStall : ∀ s d, Inv s → ¬ Goal s →
      productive d = false → rank (step s d) ≤ rank s)
    (time : Nat → Nat) (maxDelay : Nat)
    (hDelay : ∀ n, time (n + 1) ≤ time n + maxDelay)
    (trace : List D) (start : T) (maxStalls : Nat)
    (hInitial : Inv start)
    (hStalls : IRBoundedStalls.stallCount productive trace ≤ maxStalls)
    (hLength : trace.length = rank start + maxStalls) :
    Inv (trace.foldl step start) ∧
    Goal (trace.foldl step start) ∧
    time trace.length ≤ time 0 +
      (rank start + maxStalls) * maxDelay := by
  have hEnough : rank start + maxStalls ≤ trace.length := by
    omega
  obtain ⟨hSafe, hGoal, hClock⟩ :=
    actual_trace_service_and_elapsed_bound
      step Inv Goal rank productive
      hInv hAbsorb hZeroGoal hProductive hStall
      time maxDelay hDelay trace start maxStalls
      hInitial hStalls hEnough
  exact ⟨hSafe, hGoal, by simpa [hLength] using hClock⟩

/-- An event-count stall budget cannot bound elapsed physical time by
itself: arbitrarily late first events are possible without IR-41's
separate maximum-latency hypothesis. -/
theorem count_budget_alone_does_not_bound_wallclock :
    ∀ proposedDeadline : Nat,
      ∃ time : Nat → Nat,
        time 1 > time 0 + proposedDeadline ∧
        (∀ n, time n + 1 ≤ time (n + 1)) := by
  intro proposedDeadline
  exact IRClockedService.progress_without_latency_has_no_deadline
    proposedDeadline

end PhysicalBridges.IRClockedBoundedStalls
