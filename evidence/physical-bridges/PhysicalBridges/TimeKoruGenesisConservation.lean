import PhysicalBridges.KoruConservation
import PhysicalBridges.KoruCyclicGenesisForwardJoin

/-!
# Time Koru to Genesis: a recoverable, forward-moving boundary model

The constructed genesis map acts on an epoch, handedness, and the
complete finite operator source. It advances the epoch, preserves
handedness, and applies the existing involutive objective W step.

Because it retains the full epoch and source, its one-step map is
injective and hence every prior predicate is recoverable on its image.
The original combined-step Genesis theorem independently certifies the
boundary transition and causal advancement.

This is a theorem about the specified epoch/source model, not proof
that actual cosmology has a genesis transition, or that all physical
particulars and experiences survive an epoch boundary.
-/

namespace PhysicalBridges.TimeKoruGenesisConservation

open PhysicalBridges.KoruConservation
open PhysicalBridges.KoruCyclicGenesisForwardJoin
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruSourceCycleContinuation
open PhysicalBridges.KoruWActionFixedSymmetry

/-- Boundary metadata, right-hand orientation, and entire objective
source operator world. We do not discard causal epoch provenance. -/
abbrev GenesisState := Nat × Bool × FiniteObjectiveU

def genesisMap (s : GenesisState) : GenesisState :=
  (s.1 + 1, s.2.1, objectiveStep s.2.2)

/-- The complete boundary transition is injective: two distinct
epoch/orientation/operator-source states never merge. -/
theorem genesis_map_injective : Function.Injective genesisMap := by
  intro a b h
  have he : a.1 + 1 = b.1 + 1 :=
    congrArg (fun z : GenesisState => z.1) h
  have ho : a.2.1 = b.2.1 := by
    have hOrient := congrArg (fun z : GenesisState => z.2.1) h
    change a.2.1 = b.2.1 at hOrient
    exact hOrient
  have hu : objectiveStep a.2.2 = objectiveStep b.2.2 :=
    congrArg (fun z : GenesisState => z.2.2) h
  have hU : a.2.2 = b.2.2 := by
    have hW := congrArg objectiveStep hu
    simpa only [objective_W_is_an_involution] using hW
  apply Prod.ext
  · exact Nat.add_right_cancel he
  · exact Prod.ext ho hU

/-- All predicates on complete initial modeled boundary states
are recoverable after Genesis, including negative predicates. -/
theorem genesis_recovers_every_predicate :
    AllPredicatesRecoverable genesisMap :=
  all_predicates_recoverable_of_injective genesisMap genesis_map_injective

/-- A genus of arbitrarily many consecutive boundary renewals.
No requirement that the resulting universe equal the old universe. -/
def genesisAt : Nat → GenesisState → GenesisState
  | 0 => id
  | n + 1 => fun s => genesisMap (genesisAt n s)

/-- Every finite iteration preserves initial-state distinguishability. -/
theorem genesis_all_finite_stages_injective (n : Nat) :
    Function.Injective (genesisAt n) := by
  induction n with
  | zero =>
      intro a b h
      simpa [genesisAt] using h
  | succ n ih =>
      change Function.Injective (genesisMap ∘ genesisAt n)
      exact genesis_map_injective.comp ih

/-- Hence every finite Time Koru boundary stage admits full
predicate recoverability on the range of the carried map. -/
theorem genesis_all_finite_stages_recoverable (n : Nat) :
    AllPredicatesRecoverable (genesisAt n) :=
  all_predicates_recoverable_of_injective _ (genesis_all_finite_stages_injective n)

/-- The Genesis step on a terminus has the existing independently
specified forward causal, handedness, and intrinsic-Koru properties. -/
theorem genesis_has_forward_Koru_witness
    (M epoch : Nat) (o : Bool) (U : FiniteObjectiveU) :
    combinedStep M
      ((epoch, M, o), U)
      ((epoch + 1, 0, o), objectiveStep U) ∧
    combinedCausal M ((epoch, M, o), U) <
      combinedCausal M ((epoch + 1, 0, o), objectiveStep U) ∧
    combinedHandedness ((epoch + 1, 0, o), objectiveStep U) =
      combinedHandedness ((epoch, M, o), U) ∧
    (WholeHasIntrinsicKoru (objectiveStep U) ↔
      WholeHasIntrinsicKoru U) :=
  genesis_flag_points_right_and_Koru_survives M epoch o U

#print axioms genesis_map_injective
#print axioms genesis_recovers_every_predicate
#print axioms genesis_all_finite_stages_injective
#print axioms genesis_all_finite_stages_recoverable
#print axioms genesis_has_forward_Koru_witness

end PhysicalBridges.TimeKoruGenesisConservation
