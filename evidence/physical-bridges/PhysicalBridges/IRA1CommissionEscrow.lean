/-
IR-89 — original A1 T3.1 commissioning / escrow funding.

Recovered original A1 T3.1 says "commissioning: escrow sufficient for
initial and continuing costs". A finite escrow that pays startup alone
does not fund even one positive recurring mandatory service obligation.

We source-check:
 * exact finite-horizon escrow affordability, including ALL earlier
   ticks, not just the endpoint;
 * no finite bank without replenishment covers ALL horizons when
   recurring cost > 0 (a direct original A1/T3.1 obstruction);
 * a constructive composition with IR-74/IR-72: after initial
   commissioning payout, if enough reserve remains and actual supply
   per step is UNIFORMLY at least the recurring cost across every
   disturbance, there is an indefinitely reserve-safe modeled policy.

A uniform future supply lower bound is an independently warranted
PHYSICAL assumption. This theorem does not establish real-world
commissioning, eventual service to any historical particular, freedom
to change, or original full X3 physically feasible universality.
-/
import PhysicalBridges.IREnergyReplenishment
import PhysicalBridges.IRA1PacketJournalJoin

namespace PhysicalBridges.IRA1CommissionEscrow

def commissionPermit
    (escrow initialCost recurringCost horizon : Nat) : Bool :=
  decide (initialCost + horizon * recurringCost ≤ escrow)

theorem commissioning_for_window_implies_every_earlier_tick_funded
    (escrow initialCost recurringCost horizon : Nat)
    (h : commissionPermit escrow initialCost recurringCost horizon = true) :
    ∀ tick, tick ≤ horizon →
      initialCost + tick * recurringCost ≤ escrow := by
  have hBudget : initialCost + horizon * recurringCost ≤ escrow :=
    decide_eq_true_eq.mp (by simpa [commissionPermit] using h)
  intro tick hTick
  have hMul : tick * recurringCost ≤ horizon * recurringCost :=
    Nat.mul_le_mul_right recurringCost hTick
  omega

theorem insufficient_finite_commission_is_rejected
    (escrow initialCost recurringCost horizon : Nat)
    (h : escrow < initialCost + horizon * recurringCost) :
    commissionPermit escrow initialCost recurringCost horizon = false := by
  simp [commissionPermit, Nat.not_le.mpr h]

/-- For positive per-tick mandatory costs and NO replenishment, no
finite escrow can guarantee funding for all future finite horizons.
The counterexample is not a failure of IR72 compactness: its premise
cannot hold for a fixed positive-drain finite resource model. -/
theorem positive_recurring_cost_precludes_unfunded_infinite_commission
    (escrow initialCost recurringCost : Nat)
    (hPositive : 0 < recurringCost) :
    ¬ (∀ horizon : Nat,
      initialCost + horizon * recurringCost ≤ escrow) := by
  intro hAll
  have hOne : 1 ≤ recurringCost := by omega
  have hProduct : (escrow+1)*1 ≤ (escrow+1)*recurringCost :=
    Nat.mul_le_mul_left (escrow+1) hOne
  have hHorizon := hAll (escrow+1)
  omega

/-- An independently warranted replenishing source permits an
indefinite RESERVE-SAFE policy in the modeled plant. Pay initial
cost at admission, retain reserve, and require per-disturbance
supplied energy to cover EACH future mandatory spend. -/
theorem replenished_commission_derives_all_horizon_reserve_policy
    {D : Type}
    (supply : D → Nat)
    (escrow initialCost recurringCost reserve : Nat)
    (hInitial : initialCost + reserve ≤ escrow)
    (hReplenish : ∀ d, recurringCost ≤ supply d) :
    ∃ policy : Nat → Bool,
      ∀ stream : Nat → D, ∀ n : Nat,
        IREnergyReplenishment.reserveSafe reserve
          (IRInfiniteHistoryCompactness.stateAt
            (IREnergyReplenishment.suppliedStep supply recurringCost)
            policy stream (escrow - initialCost) n) := by
  apply IREnergyReplenishment.uniform_paid_supply_derives_infinite_safe_policy
    supply recurringCost reserve (escrow - initialCost) hReplenish
  unfold IREnergyReplenishment.reserveSafe
  omega

/-- Numeric countermodel: "startup cost is funded" is not a
sufficient commissioning rule for a mandatory continuing duty. -/
theorem initial_only_funding_can_fail_first_service :
    (100 ≤ 100) ∧ commissionPermit 100 100 1 1 = false := by
  decide

/-- The good source-model permit never INVENTS replenishment;
even an arbitrary number of bounded finite-horizon checks cannot
supply the uniform physically real future lower bound for all
disturbances. This is made explicit by the IR74 hostile intermittent
supply theorem. -/
theorem favorable_supply_not_robust_even_for_one_tick :
    ¬ IRViability.Viable
      (IREnergyReplenishment.reserveSafe 1)
      (IREnergyReplenishment.suppliedStep
        IREnergyReplenishment.intermittentSupply 1) 1 1 := by
  exact IREnergyReplenishment.intermittent_supply_fails_one_step

#print axioms commissioning_for_window_implies_every_earlier_tick_funded
#print axioms insufficient_finite_commission_is_rejected
#print axioms positive_recurring_cost_precludes_unfunded_infinite_commission
#print axioms replenished_commission_derives_all_horizon_reserve_policy
#print axioms initial_only_funding_can_fail_first_service
#print axioms favorable_supply_not_robust_even_for_one_tick

end PhysicalBridges.IRA1CommissionEscrow
