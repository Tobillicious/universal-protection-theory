import PhysicalBridges.KoruJokerCausalProvenance

/-!
# Tree of Endless Knowledge: two-generation source provenance

A minimal proposed join, reusing the existing *global* one-step
`one_source_branch_bit_restores_injectivity` result without changing
the source operator, Koru, or any original X3 definition.

The trace stores the first branch tag and the complete tagged second
successor. It deliberately does NOT copy the full first parent.

This is a finite objective-W *model* result, not a proof of living
continuity, consent, ethical truth, actual cosmological genesis, or G.

Research PR: requires a pinned Lean build / CI receipt before it can
be described as kernel checked.
-/

namespace PhysicalBridges.KoruTreeTwoGenerationProvenance

open PhysicalBridges.KoruJokerCausalProvenance
open PhysicalBridges.KoruObjectiveWholeU

/-- Branch information from generation 0, plus the tagged generation-2
source. Both tags are derived from the intrinsic source probe. -/
noncomputable def twoGenerationTrace (U : FiniteObjectiveU) :
    Bool × (Bool × FiniteObjectiveU) :=
  (sourceBranchTag U, branchTaggedNext (sourceSelectedNext U))

/-- The pair of successive intrinsic branch tags and the complete
second-generation source determine the initial modeled source.

This follows by applying the existing one-step injectivity theorem
backwards twice; no original-X3 or semantic fidelity is assumed. -/
theorem two_generation_trace_injective :
    Function.Injective twoGenerationTrace := by
  intro U V h
  have hFirstTag :
      sourceBranchTag U = sourceBranchTag V :=
    congrArg Prod.fst h
  have hSecondTagged :
      branchTaggedNext (sourceSelectedNext U) =
        branchTaggedNext (sourceSelectedNext V) :=
    congrArg Prod.snd h
  have hFirstChild :
      sourceSelectedNext U = sourceSelectedNext V :=
    one_source_branch_bit_restores_injectivity hSecondTagged
  apply one_source_branch_bit_restores_injectivity
  exact Prod.ext hFirstTag hFirstChild

/-- At the source level, equality of two-generation traces implies
equality of all initial whole-source distinctions. -/
theorem two_generation_trace_recovers_source
    (U V : FiniteObjectiveU)
    (h : twoGenerationTrace U = twoGenerationTrace V) :
    U = V :=
  two_generation_trace_injective h

end PhysicalBridges.KoruTreeTwoGenerationProvenance
