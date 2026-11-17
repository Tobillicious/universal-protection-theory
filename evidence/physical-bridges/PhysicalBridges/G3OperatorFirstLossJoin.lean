import PhysicalBridges.BCRDOperatorSubjectEventJoin
import PhysicalBridges.BCRDSixSourceHistoryPositiveJoin

/-!
# G3 complete-operator first-loss join

Reuse the physical-source-generated microhistory of the evaluated nested BCRD
operator expression (not an arbitrary postulated step isomorphism), and the
already proven first-loss exclusion for all six intrinsic source reports.

No "safe"/Guardian predicate appears in the source generator.  The theorem
is source-level: it does not relabel these reports as independently established
real-world authorization, continuation, freedom, restraint, maximality or
provenance, nor identify the frozen W generator with all physical events.
-/

namespace PhysicalBridges.G3OperatorFirstLossJoin

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDOperatorAlgebra
open PhysicalBridges.KoruCompositionalExpression
open PhysicalBridges.BCRDOperatorSubjectEventJoin
open PhysicalBridges.BCRDSixSourceHistoryPositiveJoin
open PhysicalBridges.IntrinsicSixSourceForcing
open PhysicalBridges.AllIsWithinEventHistory
open PhysicalBridges.SummitIntrinsicDefinability

/-- A *first* loss of the entire six-duty SOURCE REPORT cannot occur at
any intermediate microstep in the evaluated complete-operator W history.
No protection, original-X3 or separately provided microstep-isomorphism
hypothesis is needed to build the source history. -/
theorem no_first_six_source_loss_in_complete_operator_history
    (e : Expr Matrix6 WOperator)
    (d : SixRelationalDuties)
    (roles : Index → Fin 4 → Index)
    (p : Index) :
    ¬ ∃ n : Nat,
      SourceSixHold
        ((operatorRelationalHistory e).relation n) d
        (fun i => carry (operatorRelationalHistory e) n (roles p i)) ∧
      ¬ SourceSixHold
        ((operatorRelationalHistory e).relation (n + 1)) d
        (fun i => carry (operatorRelationalHistory e) (n + 1) (roles p i)) := by
  exact no_first_six_source_reports_loss
    (operatorRelationalHistory e) d (roles p)

/-- When the six reports are true at the source origin, every represented
operator microstage retains all six, and any first-loss claim is excluded.
This is a complete-history conclusion, not an endpoint-only certificate. -/
theorem every_operator_microstage_six_and_no_first_loss
    (e : Expr Matrix6 WOperator)
    (d : SixRelationalDuties)
    (roles : Index → Fin 4 → Index)
    (hOrigin : ∀ p : Index,
      SourceSixHold (operatorEventLink e) d (roles p)) :
    (∀ (n : Nat) (p : Index),
      SourceSixHold
        ((operatorRelationalHistory e).relation n) d
        (fun i => carry (operatorRelationalHistory e) n (roles p i))) ∧
    (∀ p : Index,
      ¬ ∃ n : Nat,
        SourceSixHold
          ((operatorRelationalHistory e).relation n) d
          (fun i => carry (operatorRelationalHistory e) n (roles p i)) ∧
        ¬ SourceSixHold
          ((operatorRelationalHistory e).relation (n + 1)) d
          (fun i => carry (operatorRelationalHistory e) (n + 1) (roles p i))) := by
  constructor
  · intro n p
    have hAtOrigin :
        SourceSixHold ((operatorRelationalHistory e).relation 0)
          d (roles p) := by
      simpa [operatorRelationalHistory, frozenWIter, mapAtoms_id]
        using hOrigin p
    exact six_source_reports_at_every_stage
      (operatorRelationalHistory e) d (roles p) hAtOrigin n
  · intro p
    exact no_first_six_source_loss_in_complete_operator_history
      e d roles p

#print axioms no_first_six_source_loss_in_complete_operator_history
#print axioms every_operator_microstage_six_and_no_first_loss

end PhysicalBridges.G3OperatorFirstLossJoin
