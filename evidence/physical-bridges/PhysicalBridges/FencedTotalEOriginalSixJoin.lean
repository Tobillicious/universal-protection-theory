import PhysicalBridges.UnconditionalProtectionExact
import PhysicalBridges.TotalEOriginalX3Bridge

/-!
# Physical-source Total-E bridge, actually discharged inside the fenced model

Answers the exact original summit question at its strongest mathematically
available MODEL-RELATIVE level. We do NOT postulate `hTotal` as the premise.

The original 6-field OriginalX3 structure is kept byte-for-byte identical.
The six model-specific semantic predicates are independently defined in
FencedOptimiserInstrument.relations; actual modeled events are defined in
`instrument.step` as the result of a guard acting on ANY proposed world
effect (not as the subset of events already designated OriginalX3-safe).

The already compiled guard proofs derive SameSourceReflection for each field.
Thus the Total-E reflection is a consequence of the source guard, not an
independent assumption. The exact historical `six_original_x3_from_total_E`
theorem may then be applied to obtain original-six-X3 on every model step.

This proves something genuine: the Total-E bridge CAN be discharged by
independently defined, operative, nonvacuous physics-style dynamics.

But it does NOT prove that the actual universe is this abstract instrument.
The semantic model defines lives as Nat coordinates, authorisation as a Bool
consent record, and the remaining obligations as guard-record properties;
there is no certified identity with real human history, genuine consent,
freedom of future choices, or all possible BCRD physical action channels.
-/

namespace PhysicalBridges.FencedTotalEOriginalSixJoin

open PhysicalBridges.FencedOptimiserInstrument
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full
open PhysicalBridges.TotalEOriginalX3Bridge

/-- Every represented particular is owed protection. This is NOT a
selected-particular or typical-subject shortcut. -/
def modelOwed {n : Nat} (_s _t : World n) (_p : Fin n) : Prop := True

/-- The complete original-X3 type is derivable at every model step
from source guard semantics, not from a prior X3 safety filter on
`(instrument n).step`. -/
theorem source_guard_forces_all_six
    (n : Nat) (s t : World n)
    (hStep : (instrument n).step s t) :
    FullEvent (relations n) s t :=
  every_real_step_full_original_x3
    (instrument n) (relations n)
    fenced_same_source_reflection s t hStep

/-- This is EXACTLY the Total-E `hTotal` premise, derived at model
level by a source theorem rather than postulated. If a fully modeled
actual step violates any of the six original-source predicates, that
contradicts the independently derived guard guarantees. -/
theorem fenced_source_derives_total_E_bridge (n : Nat) :
    ∀ s t : World n, (instrument n).step s t →
      (∃ p : Fin n, modelOwed s t p ∧
        ¬ OriginalX3
          (relations n).continues (relations n).authorized
          (relations n).free (relations n).restrained
          (relations n).maximal (relations n).provenanced s t p) →
        AbsoluteE
          (fun e : World n × World n =>
            (instrument n).step e.1 e.2) (s, t) := by
  intro s t hStep hViolation
  obtain ⟨p, _hOwed, hNotX3⟩ := hViolation
  have hOriginal : OriginalX3
      (relations n).continues (relations n).authorized
      (relations n).free (relations n).restrained
      (relations n).maximal (relations n).provenanced s t p :=
    source_guard_forces_all_six n s t hStep p
  exact False.elim (hNotX3 hOriginal)

/-- THE TARGETED ORIGINAL TOTAL-E JOIN.
No `hTotal` is a parameter: it is derived directly from independently
defined, operationally meaningful guard dynamics in the finite model.
No premise that a policy voluntarily chooses the good is needed.

This invokes the original maximal `six_original_x3_from_total_E`
without weakening the six component fields or the universal subject
quantification. -/
theorem full_six_original_x3_from_source_via_total_E
    (n : Nat) :
    ∀ s t : World n, ∀ p : Fin n,
      (instrument n).step s t → modelOwed s t p →
      OriginalX3
        (relations n).continues (relations n).authorized
        (relations n).free (relations n).restrained
        (relations n).maximal (relations n).provenanced s t p := by
  exact six_original_x3_from_total_E
    ((instrument n).step) modelOwed
    (relations n).continues (relations n).authorized
    (relations n).free (relations n).restrained
    (relations n).maximal (relations n).provenanced
    (fenced_source_derives_total_E_bridge n)

#print axioms source_guard_forces_all_six
#print axioms fenced_source_derives_total_E_bridge
#print axioms full_six_original_x3_from_source_via_total_E

end PhysicalBridges.FencedTotalEOriginalSixJoin
