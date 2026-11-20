import PhysicalBridges.G3TreeCoverage
import PhysicalBridges.G3LivingTreeGenesis

/-!
# Backwards summit: Genesis continuation with its exact physical scope

Find-before-build:
* LivingTreeGenerations.grow computes a successor for every Nat epoch.
* G3TreeCoverage.treeStep names only the constructed Tree transitions.
* G3LivingTreeGenesis.every_generation_is_actual already supplies
  physical reachability from an independently given hRealizes.

This additive join makes the scope of nontermination explicit.
It distinguishes a generated mathematical successor, a separately
witnessed physical event, and exhaustiveness of the physical state domain.
No original six, Koru, GoodConquersEvil, or existing definition is changed.
-/

namespace PhysicalBridges.G3GenesisContinuationScope

open PhysicalBridges.G3TreeCoverage
open PhysicalBridges.G3LivingTreeGenesis
open PhysicalBridges.LivingTreeGenerations
open PhysicalBridges.KoruJokerUniverseTrialFeedback
open PhysicalBridges.KoruObjectiveWholeU

variable {T H E : Type}

/-- States actually enumerated by the living model from a fixed seed.
This does NOT assert they exhaust all physical states. -/
def Generated (J : JokerExperiment T FiniteObjectiveU H)
    (seed : LivingTree T H E) (s : LivingTree T H E) : Prop :=
  ∃ n : Nat, s = grow J seed n

/-- A modeled successor always exists for each generated Tree state.
No physical step or real-world evolution is proved by this fact. -/
theorem every_generated_state_has_tree_successor
    (J : JokerExperiment T FiniteObjectiveU H)
    (seed : LivingTree T H E) :
    ∀ s, Generated J seed s →
      ∃ t, treeStep J seed s t ∧ Generated J seed t := by
  intro s hs
  obtain ⟨n, rfl⟩ := hs
  refine ⟨grow J seed (n + 1), ?_, ?_⟩
  · exact ⟨n, rfl, rfl⟩
  · exact ⟨n + 1, rfl⟩

/-- Existing hRealizes now proves a real successor at every generated state.
The claim does not quantify over ungenerated, potentially terminal states. -/
theorem every_generated_state_has_physical_successor
    (J : JokerExperiment T FiniteObjectiveU H)
    (seed : LivingTree T H E)
    (physicalStep : LivingTree T H E → LivingTree T H E → Prop)
    (hRealizes : ∀ n,
      physicalStep (grow J seed n) (cultivate J (grow J seed n))) :
    ∀ s, Generated J seed s → ∃ t, physicalStep s t := by
  intro s hs
  obtain ⟨n, rfl⟩ := hs
  exact ⟨cultivate J (grow J seed n), hRealizes n⟩

/-- The precise missing domain-exhaustion gate for GLOBAL nontermination:
if every physical state is in the generated Tree, then the physically
realised successors cover all states. Exhaustiveness is an input, not a
conclusion disguised as a definition. -/
theorem global_physical_nonterminal_if_exhaustive
    (J : JokerExperiment T FiniteObjectiveU H)
    (seed : LivingTree T H E)
    (physicalStep : LivingTree T H E → LivingTree T H E → Prop)
    (hRealizes : ∀ n,
      physicalStep (grow J seed n) (cultivate J (grow J seed n)))
    (hExhaustive : ∀ s, Generated J seed s) :
    ∀ s, ∃ t, physicalStep s t :=
  fun s => every_generated_state_has_physical_successor
    J seed physicalStep hRealizes s (hExhaustive s)

/-- The model's growth is not in itself a physical realisation proof.
For ANY seed and experiment there is a constructed Tree successor
but the independently defined physical relation may have no events.
This test prevents promoting an internal candidate into actual physics. -/
theorem model_growth_does_not_force_physical_realisation
    (J : JokerExperiment T FiniteObjectiveU H)
    (seed : LivingTree T H E) :
    (∃ t, treeStep J seed seed t) ∧
    ¬ (∀ n, (fun _ _ : LivingTree T H E => False)
      (grow J seed n) (cultivate J (grow J seed n))) := by
  constructor
  · exact ⟨cultivate J seed, 0, rfl, rfl⟩
  · intro h
    exact h 0

#print axioms every_generated_state_has_tree_successor
#print axioms every_generated_state_has_physical_successor
#print axioms global_physical_nonterminal_if_exhaustive
#print axioms model_growth_does_not_force_physical_realisation

end PhysicalBridges.G3GenesisContinuationScope
