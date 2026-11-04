import Snuffy.G2Splice
import Snuffy.Greatestness

/-!
CATHEDRAL: mathematical invariance -> original full four-stage UPT endgame.

This is an IMPORT-AND-COMPOSE proof, not a replacement theorem.
- Mathematical truth does not depend on an internal process state.
- The source's already-proved G2Splice.fourStage gives original four
  stages at top under local feasibility, budget solvency and actual
  selected canonical alignment.
- Already-proved Greatestness.aligned_iff_no_needless_loss yields
  no needless loss at ANY of the four stages.

CRITICAL: No theorem here derives physical alignment/realizability
from ordinary mathematical consistency. The physical BCRD source
bridge is deliberately NOT smuggled into a definition. New file
uncompiled in this environment, original UPT unchanged.
-/

namespace PhysicalBridges.CathedralMathematicalEndgame

open Snuffy.G2Splice Snuffy.Greatestness Snuffy.UnionClosure

universe u v
variable {Part : Type u} {Local : Part → Type v}

/-- The trivially valid *logical* core of the author's ender paradox:
    a theorem remains true regardless of which internal state
    transition was described. This alone is NOT preservation of
    all physical histories or living particulars. -/
theorem mathematical_fact_independent_of_internal_state
    {State : Type u} (step : State → State)
    {P : Prop} (proved : P) (s : State) : P := by
  exact proved

/-- Exact composition of two ALREADY-PROVED source theorems:
    G2Splice.fourStage, with the author's original ordered
    existing-life / existing-freedom / new-life / new-freedom
    outcomes, and Greatestness.aligned_iff_no_needless_loss.

    Feasible top-grade local options, solvency and the physical
    outcome's canonical selection remain explicit assumptions.
    Proving them for every actual BCRD physical source is the
    missing non-circular necessity bridge. -/
theorem full_original_four_stage_endgame
    (Rloc : ∀ x, Set (Local x))
    (grade : ∀ x, Local x → Fin 3)
    (E N : Set Part)
    (hfree : ∀ x, ∃ l ∈ Rloc x, grade x l = 2)
    {c : (∀ i : Fin 4, Set {x // x ∈ fourCat E N i}) → ℝ}
    {B : ℝ} (hsolv : c ⊤ ≤ B)
    {o : ∀ i : Fin 4, Set {x // x ∈ fourCat E N i}}
    (hselected : Aligned
      (budgetFamily (outcomes Rloc grade fourθ (fourCat E N)) c B)
      o) :
    o = ⊤ ∧
    (∀ q, q ≤ o) ∧
    (∀ j : Fin 4,
      ¬ NeedlessLoss
        (budgetFamily (outcomes Rloc grade fourθ (fourCat E N)) c B)
        o j) := by
  have hfour :=
    fourStage Rloc grade E N hfree hsolv hselected
  refine ⟨hfour.2.2.1, hfour.2.2.2, ?_⟩
  exact
    (aligned_iff_no_needless_loss
      (budgetFamily (outcomes Rloc grade fourθ (fourCat E N)) c B)
      hselected.1).mp hselected

/-- A mathematically describable internal operation can have
    a terminating activity flag. This is a LOGICAL independence
    control, not an assertion of physically BCRD-admitted killing. -/
theorem terminates_activity_without_invalidating_logic :
    ∃ step : Bool → Bool,
      step true = false ∧
      (∀ state : Bool, step state = false) := by
  refine ⟨fun _ => false, rfl, ?_⟩
  intro state
  rfl

end PhysicalBridges.CathedralMathematicalEndgame
