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

/-! ## Arbitrary finite source generations

This is distinct from the pre-existing `KoruEternalKnowledgeSeed`
record-copying theorem: here the source-selected dynamics may merge
parents, and the trace retains *derived branch choices* to prevent it.
The final source and n branch tags suffice; the initial whole source
is not simply copied into the trace when n > 0.
-/

/-- A trace's information shape: n branch tags followed by one
complete final objective source. -/
def generationTraceShape : Nat → Type
  | 0 => FiniteObjectiveU
  | n + 1 => Bool × generationTraceShape n

/-- The source-derived tag at each stage, then the complete terminal
source. No independent ethics or subject authorization is introduced. -/
noncomputable def generationTrace :
    (n : Nat) → FiniteObjectiveU → generationTraceShape n
  | 0, U => U
  | n + 1, U =>
      (sourceBranchTag U, generationTrace n (sourceSelectedNext U))

/-- All finite traces are source-injective, by induction using the
existing global one-step branch-tag injectivity result. -/
theorem generation_trace_injective (n : Nat) :
    Function.Injective (generationTrace n) := by
  induction n with
  | zero =>
      intro U V h
      exact h
  | succ n ih =>
      intro U V h
      have hTag : sourceBranchTag U = sourceBranchTag V :=
        congrArg Prod.fst h
      have hTail :
          generationTrace n (sourceSelectedNext U) =
            generationTrace n (sourceSelectedNext V) :=
        congrArg Prod.snd h
      have hChild : sourceSelectedNext U = sourceSelectedNext V :=
        ih hTail
      apply one_source_branch_bit_restores_injectivity
      exact Prod.ext hTag hChild

/-- Recover the initial complete source from any finite-length
branch-tagged genealogy. This is mathematical source recoverability,
not real subject continuation or original-six protection. -/
theorem generation_trace_recovers_source (n : Nat)
    (U V : FiniteObjectiveU)
    (h : generationTrace n U = generationTrace n V) :
    U = V :=
  generation_trace_injective n h

end PhysicalBridges.KoruTreeTwoGenerationProvenance
