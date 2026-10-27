/-
IR-47: a concrete two-productive, one-stalled event witness for IR-46.
Completely synthetic state, physical event tags and clock.
-/
import PhysicalBridges.IRClockedBoundedStalls
namespace PhysicalBridges.IRConcreteClockedStalls

def step (n : Nat) (productive : Bool) : Nat :=
  if productive then n - 1 else n
def Inv (_ : Nat) : Prop := True
def Goal (n : Nat) : Prop := n = 0
def rank (n : Nat) : Nat := n
def productive (e : Bool) : Bool := e
def clock (n : Nat) : Nat := n * 4
def trace : List Bool := [false, true, true]

theorem invariant : ∀ s e, Inv s → Inv (step s e) := by
  intro s e _
  trivial

theorem service_absorbs : ∀ s e, Inv s → Goal s → Goal (step s e) := by
  intro s e _ hg
  change s = 0 at hg
  subst s
  cases e <;> rfl

theorem zero_rank_is_service :
    ∀ s, Inv s → rank s = 0 → Goal s := by
  intro s _ h
  exact h

theorem productive_step_progresses :
    ∀ s e, Inv s → ¬ Goal s →
      productive e = true → rank (step s e) < rank s := by
  intro s e _ hNoGoal hp
  cases e with
  | false => cases hp
  | true =>
      change s - 1 < s
      have hn : s ≠ 0 := by
        intro hz
        exact hNoGoal hz
      omega

theorem stall_never_increases_rank :
    ∀ s e, Inv s → ¬ Goal s →
      productive e = false → rank (step s e) ≤ rank s := by
  intro s e _ _ hp
  cases e with
  | false => exact Nat.le_refl s
  | true => cases hp

theorem clock_maximum_delay :
    ∀ n, clock (n + 1) ≤ clock n + 4 := by
  intro n
  change (n + 1) * 4 ≤ n * 4 + 4
  omega

theorem exactly_one_stall :
    IRBoundedStalls.stallCount productive trace = 1 := by
  decide

theorem exactly_three_events : trace.length = rank 2 + 1 := by
  decide

theorem initially_unserved : ¬ Goal 2 := by
  decide

/-- Replay the full imported IR-46 theorem in an initially unserved
world, with one actual modeled stall and two productive transitions. -/
theorem clocked_service_witness :
    Inv (trace.foldl step 2) ∧
    Goal (trace.foldl step 2) ∧
    clock trace.length ≤ clock 0 + (rank 2 + 1) * 4 := by
  exact IRClockedBoundedStalls.exact_horizon_clocked_service
    step Inv Goal rank productive
    invariant service_absorbs zero_rank_is_service
    productive_step_progresses stall_never_increases_rank
    clock 4 clock_maximum_delay trace 2 1
    trivial (by simpa using (Nat.le_of_eq exactly_one_stall))
    exactly_three_events

theorem three_stalls_fail_service :
    ¬ Goal (([false, false, false] : List Bool).foldl step 2) := by
  decide

#print axioms clocked_service_witness
#print axioms three_stalls_fail_service
end PhysicalBridges.IRConcreteClockedStalls
