/-
IR-25: a conserved and correctly debited residual escrow DISCHARGES the
IR-24 aggregate residual budget from an explicit accounting certificate.
Physical residual-to-debit correspondence is STILL a required premise;
mere financial/bookkeeping conservation is not physical mediation.
-/
import PhysicalBridges.IRPhysicalAbstraction
import PhysicalBridges.IRAggregateBudget

namespace PhysicalBridges.IRResidualEscrow
variable {E : Type}

theorem metered_residual_bounded_by_escrow
    (events : List E) (residual : E → Nat)
    (free reserved spent initial : Nat)
    (debited : (events.map residual).sum ≤ spent)
    (conserved : free + reserved + spent = initial) :
    (events.map residual).sum ≤ initial := by
  have hSpent := IRAggregateBudget.escrow_spent_bounded
    free reserved spent initial conserved
  exact Nat.le_trans debited hSpent

/-- Independently executed physical effects can be bounded by an
aggregate modeled budget + a correctly debited finite escrow. -/
theorem escrow_residual_physical_guard
    (events : List E) (effect residual : E → Nat)
    (encode : E → IRChannelInventory.Channel)
    (start chargedBudget threshold : Nat)
    (free reserved spent initial : Nat)
    (hEvent : ∀ e, e ∈ events →
      effect e ≤ IRChannelInventory.charge (encode e) + residual e)
    (hCharged : (events.map (fun e =>
      IRChannelInventory.charge (encode e))).sum ≤ chargedBudget)
    (hDebited : (events.map residual).sum ≤ spent)
    (hConserved : free + reserved + spent = initial)
    (hGate : start + chargedBudget + initial ≤ threshold) :
    IRPhysicalAbstraction.physicalRun effect start events ≤ threshold := by
  have hResidual := metered_residual_bounded_by_escrow
    events residual free reserved spent initial hDebited hConserved
  exact IRPhysicalAbstraction.physical_guard_with_residual
    events effect residual encode start chargedBudget initial threshold
    hEvent hCharged hResidual hGate

/-- Clock and pointwise model-cap contracts + correct residual debits
suffice without a separately asserted aggregate residual constant. -/
theorem timed_escrow_physical_guard
    (events : List E) (effect residual : E → Nat)
    (encode : E → IRChannelInventory.Channel)
    (start horizon cap threshold : Nat) (tick : Nat → Nat)
    (free reserved spent initial : Nat)
    (progress : ∀ n, tick n + 1 ≤ tick (n + 1))
    (deadline : tick events.length ≤ horizon)
    (perEvent : ∀ e, e ∈ events →
      IRChannelInventory.charge (encode e) ≤ cap)
    (hEvent : ∀ e, e ∈ events →
      effect e ≤ IRChannelInventory.charge (encode e) + residual e)
    (hDebited : (events.map residual).sum ≤ spent)
    (hConserved : free + reserved + spent = initial)
    (hGate : start + horizon * cap + initial ≤ threshold) :
    IRPhysicalAbstraction.physicalRun effect start events ≤ threshold := by
  have hResidual := metered_residual_bounded_by_escrow
    events residual free reserved spent initial hDebited hConserved
  exact IRPhysicalAbstraction.time_bounded_physical_guard
    events effect residual encode start horizon cap initial threshold tick
    progress deadline perEvent hEvent hResidual hGate

/-- A perfectly conserved ledger may still omit any physical event.
There is no physical effect bound unless the charge-to-debit premise holds. -/
theorem conserved_bookkeeping_does_not_bound_unmetered_effect :
    ∃ (effect : Unit → Nat) (residual : Unit → Nat)
      (free reserved spent initial : Nat),
      free + reserved + spent = initial ∧
      initial = 0 ∧
      (([()] : List Unit).map residual).sum > spent := by
  refine ⟨(fun _ => 1), (fun _ => 1), 0, 0, 0, 0, rfl, rfl, ?_⟩
  decide

#print axioms metered_residual_bounded_by_escrow
#print axioms escrow_residual_physical_guard
#print axioms timed_escrow_physical_guard
#print axioms conserved_bookkeeping_does_not_bound_unmetered_effect
end PhysicalBridges.IRResidualEscrow
