import PhysicalBridges.EverestActualWEventJoin
import Mathlib.Tactic

/-!
# Last-mile coverage: exact-state recurrence negative controls

The physical coverage contract carries an explicit forward Nat stage:
every covered physical event satisfies stage(t) = stage(s) + 1.

These two small propositions demonstrate a necessary consequence of that
contract WITHOUT assuming X3, authentic authorization, Guardian, or any
physical ontology. A same-state loop (including a two-edge return to
precisely the same S state) is incompatible with CompleteWEventCoverage.

This does NOT prohibit cyclic *patterns* at different states/stages,
ever-advancing Genesis, or longer models with a non-Nat time notion.
It also does not independently certify that any physical system satisfies
CompleteWEventCoverage or ForwardRealEventReflection.

No canonical Koru, original-six duty, or historical theorem is changed.
-/

namespace PhysicalBridges.WCoverageCycleObstructions

open PhysicalBridges.EverestActualWEventJoin
open PhysicalBridges.KoruObjectiveWholeU

variable {S : Type}

/-- The complete-W coverage contract prohibits a physical self-loop on the
very same underlying state, because its stage would strictly increase. -/
theorem coverage_excludes_exact_state_self_loop
    (physicalStep modeledStep : S → S → Prop)
    (source : S → FiniteObjectiveU)
    (stage : S → Nat) (U : FiniteObjectiveU)
    (hCoverage : CompleteWEventCoverage
      physicalStep modeledStep source stage U)
    (s : S) : ¬ physicalStep s s := by
  intro hLoop
  have hNext := (hCoverage s s hLoop).2.2.2
  omega

/-- Nor can a covered physical step immediately return to the identical
state. This is not an objection to renewed relational configurations at
distinct stages or to a spiral with a monotonically advancing epoch count. -/
theorem coverage_excludes_exact_state_two_cycle
    (physicalStep modeledStep : S → S → Prop)
    (source : S → FiniteObjectiveU)
    (stage : S → Nat) (U : FiniteObjectiveU)
    (hCoverage : CompleteWEventCoverage
      physicalStep modeledStep source stage U)
    (s t : S) :
    ¬ (physicalStep s t ∧ physicalStep t s) := by
  rintro ⟨hForward, hReturn⟩
  have hFirst := (hCoverage s t hForward).2.2.2
  have hSecond := (hCoverage t s hReturn).2.2.2
  omega

#print axioms coverage_excludes_exact_state_self_loop
#print axioms coverage_excludes_exact_state_two_cycle

end PhysicalBridges.WCoverageCycleObstructions
