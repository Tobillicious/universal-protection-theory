import PhysicalBridges.KoruSourceCycleContinuation
import PhysicalBridges.CyclicGenesisBoundary

/-!
# Objective whole-U recurrence with the original right-pointing genesis flag

6 November 2026; source-model research only, stacked on #350.

This joins the *actual frozen-W* finite operator source with the old
#292 CyclicGenesisBoundary forward, orientation-preserving epoch model.
Within the combined mathematical model:
* every lawful interior step strictly advances global causal order;
* every permitted step (including at the heat-death terminus)
  preserves the orientation/handedness, never mirrors it;
* the *entire* nested-operator whole U follows the independent
  source W generator; W²=id does not rewind the interior rank;
* the ORIGINAL intrinsic Koru property and the internally sourced
  director/subject operator link are preserved at each actual modeled
  step, and along finite modeled paths;
* every valid interior position has arbitrarily far-forward reachable
  paths, each of which lifts to some W-consistent operator whole.
We supply a two-step witness where the complete objective U returns
to its initial structure while causal rank advances strictly.

This is NOT a theorem that real cosmology undergoes genesis at heat
death, that the multiverse is physically cyclic, or that repeated
source states equal lived continuity of any experiencing particular.
The genesis step is a *stipulated part of the existing model*;
its physical existence and the original six-X3 subject semantics
are separate physical/semantic obligations. The exact old summit
and original X3 definitions remain unchanged.
-/

namespace PhysicalBridges.KoruCyclicGenesisForwardJoin

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruWActionFixedSymmetry
open PhysicalBridges.KoruWholeUDirectedAgency
open PhysicalBridges.KoruDirectorCutCriterion
open PhysicalBridges.KoruDirectorNontrivialSector
open PhysicalBridges.KoruSourceCycleContinuation

abbrev Interior := PhysicalBridges.CyclicGenesisBoundary.St
abbrev Combined := Interior × FiniteObjectiveU

/-- An independently specified interior event and one independently
specified actual W source update happen together. -/
def combinedStep (M : Nat) (s t : Combined) : Prop :=
  PhysicalBridges.CyclicGenesisBoundary.step M s.1 t.1 ∧
    t.2 = objectiveStep s.2

def combinedCausal (M : Nat) (s : Combined) : Nat :=
  PhysicalBridges.CyclicGenesisBoundary.globalCausal M s.1

def combinedHandedness (s : Combined) : Bool :=
  PhysicalBridges.CyclicGenesisBoundary.orient s.1

/-- Interior causal direction points strictly forward across BOTH
ordinary epoch steps and the genesis/heat-death boundary. -/
theorem each_combined_event_is_causally_forward
    (M : Nat) (s t : Combined) (h : combinedStep M s t) :
    combinedCausal M s < combinedCausal M t :=
  PhysicalBridges.CyclicGenesisBoundary.step_advances_causal M s.1 t.1 h.1

/-- No mirror/handedness reversal in either permitted kind of step. -/
theorem each_combined_event_preserves_right_handedness
    (M : Nat) (s t : Combined) (h : combinedStep M s t) :
    combinedHandedness t = combinedHandedness s := by
  rcases h.1 with hLocal | hGenesis
  · obtain ⟨_, hPos⟩ := hLocal
    rw [hPos]
    rfl
  · exact PhysicalBridges.CyclicGenesisBoundary.genesis_preserves_handedness
      M s.1 t.1 hGenesis

/-- An inverse whole-source W map never provides an interior
backward step; an interior backward edge would contradict rank. -/
theorem no_backward_combined_event
    (M : Nat) (s t : Combined) (h : combinedStep M s t) :
    ¬ combinedStep M t s := by
  intro hBack
  have hFor := each_combined_event_is_causally_forward M s t h
  have hRev := each_combined_event_is_causally_forward M t s hBack
  omega

/-- Every combined step transports the originally defined whole
Koru relational property, including at the genesis crossing. -/
theorem each_combined_event_preserves_original_Koru
    (M : Nat) (s t : Combined) (h : combinedStep M s t) :
    WholeHasIntrinsicKoru t.2 ↔ WholeHasIntrinsicKoru s.2 := by
  rw [h.2]
  exact whole_Koru_existence_is_exact s.2

/-- The physical SOURCE director-to-subject edge at source positions
5 and 0 stays exact, not a claim of human consent/agency. -/
theorem each_combined_event_preserves_source_direction
    (M : Nat) (s t : Combined) (h : combinedStep M s t) :
    sourceDirectorFact t.2 ↔ sourceDirectorFact s.2 := by
  rw [h.2]
  exact director_fact_is_exact_under_W s.2

/-- Heat-death terminus -> the next genesis epoch exists *inside
the specified model*, advances global causal rank, preserves
handedness and preserves intrinsic Koru simultaneously. -/
theorem genesis_flag_points_right_and_Koru_survives
    (M epoch : Nat) (orient : Bool) (U : FiniteObjectiveU) :
    combinedStep M
      ((epoch, M, orient), U)
      ((epoch + 1, 0, orient), objectiveStep U) ∧
    combinedCausal M ((epoch, M, orient), U) <
      combinedCausal M ((epoch + 1, 0, orient), objectiveStep U) ∧
    combinedHandedness ((epoch + 1, 0, orient), objectiveStep U) =
      combinedHandedness ((epoch, M, orient), U) ∧
    (WholeHasIntrinsicKoru (objectiveStep U) ↔
      WholeHasIntrinsicKoru U) := by
  have hGenesis :
      combinedStep M
        ((epoch, M, orient), U)
        ((epoch + 1, 0, orient), objectiveStep U) := by
    exact ⟨Or.inr ⟨rfl, rfl⟩, rfl⟩
  exact ⟨hGenesis,
    each_combined_event_is_causally_forward M _ _ hGenesis,
    each_combined_event_preserves_right_handedness M _ _ hGenesis,
    each_combined_event_preserves_original_Koru M _ _ hGenesis⟩

/-- Forward journeys in the combined *modeled* world. -/
inductive CombinedReach (M : Nat) : Combined → Combined → Prop
  | refl (s : Combined) : CombinedReach M s s
  | step {s t u : Combined} :
      combinedStep M s t →
      CombinedReach M t u →
      CombinedReach M s u

/-- The entire objective operator structure can be exactly
recurrent across TWO events while the interior causal rank
nevertheless increases; these are not contradictory assertions. -/
theorem whole_U_returns_while_interior_arrow_advances
    (U : FiniteObjectiveU) :
    ∃ s t : Combined,
      CombinedReach 0 s t ∧
      s.2 = t.2 ∧
      combinedCausal 0 s < combinedCausal 0 t ∧
      combinedHandedness s = combinedHandedness t := by
  let a : Combined := ((0, 0, true), U)
  let b : Combined := ((1, 0, true), objectiveStep U)
  let c : Combined := ((2, 0, true), U)
  have hab : combinedStep 0 a b := by
    exact ⟨Or.inr ⟨rfl, rfl⟩, rfl⟩
  have hbc : combinedStep 0 b c := by
    refine ⟨Or.inr ⟨rfl, rfl⟩, ?_⟩
    change U = objectiveStep (objectiveStep U)
    exact (objective_W_is_an_involution U).symm
  refine ⟨a, c, CombinedReach.step hab
    (CombinedReach.step hbc (CombinedReach.refl _)),
    rfl, ?_, rfl⟩
  change (0 : Nat) < 2
  decide

/-- Every finite forward history preserves BOTH its intrinsic
whole-U Koru sector and its original right-pointing orientation. -/
theorem combined_forward_paths_preserve_Koru_and_handedness
    (M : Nat) {s t : Combined}
    (hPath : CombinedReach M s t)
    (hKoru : WholeHasIntrinsicKoru s.2) :
    WholeHasIntrinsicKoru t.2 ∧
      combinedHandedness t = combinedHandedness s := by
  induction hPath with
  | refl => exact ⟨hKoru, rfl⟩
  | @step s t u hMove hRest ih =>
      have hNextKoru : WholeHasIntrinsicKoru t.2 :=
        (each_combined_event_preserves_original_Koru M s t hMove).mpr hKoru
      obtain ⟨hLastKoru, hLastHand⟩ := ih hNextKoru
      exact ⟨hLastKoru,
        hLastHand.trans
          (each_combined_event_preserves_right_handedness M s t hMove)⟩

/-- Lift any historically proved #292 interior forward journey
into a WHOLE-source-consistent trajectory. This theorem does not
claim that an external physical device enacts the trajectory. -/
theorem lift_forward_interior_path
    (M : Nat) {s t : Interior}
    (hPath : PhysicalBridges.CyclicGenesisBoundary.Reaches M s t) :
    ∀ U : FiniteObjectiveU,
      ∃ V : FiniteObjectiveU, CombinedReach M (s, U) (t, V) := by
  induction hPath with
  | refl =>
      intro U
      exact ⟨U, CombinedReach.refl _⟩
  | @step s t u hFirst hRest ih =>
      intro U
      obtain ⟨V, hRestLift⟩ := ih (objectiveStep U)
      exact ⟨V, CombinedReach.step ⟨hFirst, rfl⟩ hRestLift⟩

/-- Source-aware version of the original planted-flag theorem:
from EVERY valid initial interior state with an originally
articulated Koru world, arbitrarily remote FORWARD causal stages
are reachable by actual modeled events, retaining both the Koru
property and the right-hand orientation. -/
theorem forward_genesis_reaches_arbitrarily_far_with_Koru
    (M e l : Nat) (o : Bool) (U : FiniteObjectiveU)
    (hl : l ≤ M) (hKoru : WholeHasIntrinsicKoru U) :
    ∀ N : Nat,
      ∃ t : Combined,
        CombinedReach M ((e, l, o), U) t ∧
        N ≤ combinedCausal M t ∧
        combinedHandedness t = o ∧
        WholeHasIntrinsicKoru t.2 := by
  intro N
  obtain ⟨next, hReach, hLarge, hHand⟩ :=
    PhysicalBridges.CyclicGenesisBoundary.reachable_forward_continuation
      M e l o hl N
  obtain ⟨V, hLift⟩ := lift_forward_interior_path M hReach U
  have hKeep :=
    combined_forward_paths_preserve_Koru_and_handedness M hLift hKoru
  refine ⟨(next, V), hLift, hLarge, ?_, hKeep.1⟩
  exact hKeep.2.trans hHand

/-- The original summit's no-reversal / future continuation
holds simultaneously for a CONCRETE source whole with an original
nontrivial Koru distinction: no empty protected sector. -/
theorem actual_witness_forward_genesis_has_no_final_Koru_stage
    (M : Nat) (o : Bool) :
    ∀ N : Nat,
      ∃ t : Combined,
        CombinedReach M ((0, 0, o), ordinaryObjective) t ∧
        N ≤ combinedCausal M t ∧
        combinedHandedness t = o ∧
        WholeHasIntrinsicKoru t.2 := by
  exact forward_genesis_reaches_arbitrarily_far_with_Koru
    M 0 0 o ordinaryObjective (Nat.zero_le M)
    ordinary_source_world_has_nontrivial_Koru

#print axioms each_combined_event_is_causally_forward
#print axioms each_combined_event_preserves_right_handedness
#print axioms no_backward_combined_event
#print axioms each_combined_event_preserves_original_Koru
#print axioms each_combined_event_preserves_source_direction
#print axioms genesis_flag_points_right_and_Koru_survives
#print axioms whole_U_returns_while_interior_arrow_advances
#print axioms combined_forward_paths_preserve_Koru_and_handedness
#print axioms lift_forward_interior_path
#print axioms forward_genesis_reaches_arbitrarily_far_with_Koru
#print axioms actual_witness_forward_genesis_has_no_final_Koru_stage

end PhysicalBridges.KoruCyclicGenesisForwardJoin
