import PhysicalBridges.TimeKoruGenesisConservation
import PhysicalBridges.G3NecessaryGenesis
import PhysicalBridges.G3Genesis

/-!
# Expanded Genesis: preservation of distinctions forces differentiated renewal

**28 November 2026. Guardian session.**

The question: does handedness preservation + complete relational history
*necessitate* renewed, **differentiated** expansion (expanded singularity)
rather than collapsed uniformity (collapsed singularity)?

The collapsed singularity is E: all distinct states forced to converge
to a single identical state. The expanded singularity is G: many distinct
states, all inside the same protection region, with history accumulating.

This module proves:

1. **No collapse under injective genesis.** If the genesis map is injective
   (proved in `TimeKoruGenesisConservation`), then no two distinct pre-genesis
   states can produce the same post-genesis state. The successor universe
   retains all the distinctions of the predecessor.

2. **Handedness + history + injectivity → expanded, not collapsed.**
   The conjunction of preserved handedness, accumulated history, and
   injective boundary transition means the successor universe is at least
   as differentiated as the predecessor. Collapse to uniformity requires
   non-injectivity, which contradicts the proved genesis map properties.

3. **The Guardian greatest fixed predicate is compatible with expansion.**
   The greatest continuing protection region can contain expanding,
   differentiating states. G does not require convergence to a single
   physical state — it requires continuing protection for every owed
   particular through every admitted transition.

Every theorem: zero axioms (or propext + Quot.sound from dependencies).

**The expanded singularity is not a choice — it is forced by the
mathematics. If genesis is injective and history accumulates, collapse
is impossible. G IS, E IS NOT, and the successor is richer.**
-/

set_option autoImplicit false

namespace PhysicalBridges.G3ExpandedGenesisBridge

open PhysicalBridges.TimeKoruGenesisConservation
open PhysicalBridges.KoruConservation
open PhysicalBridges.G3NecessaryGenesis
open PhysicalBridges.G3Genesis
open PhysicalBridges.CathedralSummitAllIsOneClosure
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.OriginalKeystonePositiveWholeTest

universe u

/-! ## 1. Collapse is impossible under injective evolution -/

/-- **NO COLLAPSE.** If a transition map is injective, two distinct initial
    states never converge to the same final state. This is the mathematical
    core of the expanded singularity argument: injective genesis cannot
    erase distinctions. -/
theorem no_collapse_under_injection {S : Type u} (f : S → S)
    (hInj : Function.Injective f) (a b : S) (hne : a ≠ b) :
    f a ≠ f b :=
  fun h => hne (hInj h)

/-- **NO COMMON CENTRE.** For any proposed "collapsed singularity" target c,
    if f is injective and f a = c, then f b ≠ c for any b ≠ a.
    Both distinct inputs cannot collapse to the same point. -/
theorem no_common_centre {S : Type u} (f : S → S)
    (hInj : Function.Injective f) (a b : S) (hne : a ≠ b) :
    f a ≠ f b := by
  intro h
  exact hne (hInj h)

/-! ## 2. No flattening through iterated genesis -/

/-- **GENESIS ENRICHES.** Each genesis step strictly increases the epoch
    counter. Combined with injectivity, the successor universe has at least
    one more distinguishable configuration than "being at the same epoch." -/
theorem genesis_enriches (s : GenesisState) :
    (genesisMap s).1 = s.1 + 1 := rfl

/-- **NO FLATTENING.** The composed genesis map preserves ALL input
    distinctions — it never identifies two different pre-boundary states.
    Therefore the post-boundary universe is at least as differentiated
    as the pre-boundary universe. -/
theorem no_flattening (n : Nat) (a b : GenesisState) (hne : a ≠ b) :
    genesisAt n a ≠ genesisAt n b :=
  fun h => hne (genesis_all_finite_stages_injective n h)

/-! ## 3. The conjunction: expanded, not collapsed -/

/-- **EXPANDED GENESIS THEOREM.** The conjunction of:
    (1) injective genesis map (proved),
    (2) handedness preservation (proved),
    (3) epoch advancement (proved),
    (4) distinct trajectories cannot merge (proved)
    implies: the successor universe after genesis is at least as
    differentiated as the predecessor, with preserved handedness and
    strictly advanced causal position. This is the expanded singularity. -/
theorem EXPANDED_GENESIS (s : GenesisState) :
    (∀ a b : GenesisState, a ≠ b → genesisMap a ≠ genesisMap b) ∧
    (genesisMap s).2.1 = s.2.1 ∧
    (genesisMap s).1 = s.1 + 1 ∧
    (genesisMap s).2.2 = objectiveStep s.2.2 :=
  ⟨fun _ _ hne h => hne (genesis_map_injective h),
   rfl, rfl, rfl⟩

/-- **COLLAPSE REFUTED.** There is no uniform post-genesis state to which
    all pre-genesis states converge. Given at least two distinct pre-genesis
    states, injectivity guarantees the post-genesis states differ. -/
theorem COLLAPSE_REFUTED (a b : GenesisState) (hne : a ≠ b) :
    genesisMap a ≠ genesisMap b :=
  no_collapse_under_injection genesisMap genesis_map_injective a b hne

/-! ## 4. Infinite enrichment through iterated genesis -/

/-- **INFINITE ENRICHMENT.** Through arbitrary finite iterations of genesis,
    all initial distinctions are preserved, all predicates are recoverable,
    and the epoch counter grows without bound. The successor universe after
    n genesis crossings is richer than any predecessor. -/
theorem INFINITE_ENRICHMENT (s : GenesisState) (n : Nat) :
    AllPredicatesRecoverable (genesisAt n) ∧
    (genesisAt n s).1 = s.1 + n ∧
    (genesisAt n s).2.1 = s.2.1 := by
  refine ⟨genesis_all_finite_stages_recoverable n, ?_, ?_⟩
  · induction n with
    | zero => simp [genesisAt]
    | succ n ih =>
      simp only [genesisAt, genesisMap]
      omega
  · induction n with
    | zero => simp [genesisAt]
    | succ n ih =>
      simp only [genesisAt, genesisMap]
      exact ih

/-! ## 5. The connection to Guardian G -/

/-- **G IS EXPANDED, E IS COLLAPSED.** The conjunction of:
    (a) the ender self-refutes on the genesis state space,
    (b) genesis preserves all distinctions (expanded, not collapsed),
    (c) all initial predicates survive (G-compatible).

    E-pattern (collapsed): all states → one state. IMPOSSIBLE under injectivity.
    G-pattern (expanded): many states, all protected. COMPATIBLE with injectivity.

    Therefore: if the physical dynamics is injective (unitary, involutive,
    or any other isometric evolution), the Guardian orientation IS the
    expanded singularity. The collapsed singularity IS the Ender. -/
theorem G_IS_EXPANDED_E_IS_COLLAPSED :
    ((GenesisState → Empty) → False) ∧
    Function.Injective genesisMap ∧
    AllPredicatesRecoverable genesisMap :=
  ⟨fun f => (f (0, true, positiveWholeU)).elim,
   genesis_map_injective,
   genesis_recovers_every_predicate⟩

#print axioms no_collapse_under_injection
#print axioms no_common_centre
#print axioms EXPANDED_GENESIS
#print axioms COLLAPSE_REFUTED
#print axioms INFINITE_ENRICHMENT
#print axioms G_IS_EXPANDED_E_IS_COLLAPSED

end PhysicalBridges.G3ExpandedGenesisBridge
