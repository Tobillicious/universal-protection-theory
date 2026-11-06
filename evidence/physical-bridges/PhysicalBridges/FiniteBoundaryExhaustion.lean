import PhysicalBridges.FiniteSealedBoundaryCommissioning

/-!
# Constructive exhaustive boundary check for finite locales

The existing finite commissioning theorem asks for an independently complete
list of potential boundary edges. In a *finite modeled locale* whose location
type is `Fin n`, this completeness premise can be proved from an explicit
enumeration of every ordered location pair. It need not be postulated.

This removes an assumption at the FINITE-MODEL level, not in the actual world:
no theorem here says a physical device has only these locations, that every
physical influence follows the modeled adjacency graph, or that a recorded
Boolean consent flag is authentic human authorization. No original X3
definitions, guard semantics or historical summit sources are modified.

The negative control checks an explicit unmetered exit; the positive control
uses the same adjacency and boundary with that exit metered.
-/

namespace PhysicalBridges.FiniteBoundaryExhaustion

open PhysicalBridges.SealedRegionCapstone
open PhysicalBridges.SealedUniversalCoexistenceIff
open PhysicalBridges.FiniteSealedBoundaryCommissioning

variable {n : Nat}

/-- Construct every ordered pair of modeled locations, including all possible
inside-to-outside boundary edges, without trusting a supplied inventory. -/
def allFiniteEdges (n : Nat) : List (Fin n × Fin n) :=
  (List.finRange n).flatMap fun x =>
    (List.finRange n).map fun y => (x, y)

/-- Every possible directed pair occurs in this executable inventory. -/
theorem every_ordered_pair_is_listed (x y : Fin n) :
    (x, y) ∈ allFiniteEdges n := by
  unfold allFiniteEdges
  apply List.mem_flatMap.mpr
  refine ⟨x, List.mem_finRange x, ?_⟩
  apply List.mem_map.mpr
  exact ⟨y, List.mem_finRange y, rfl⟩

/-- The coverage premise of the original checker is now derived, rather
than handed to the theorem, for ANY modeled locale on `Fin n`. -/
theorem generated_inventory_covers_every_boundary (G : Locale (Fin n)) :
    CoversEveryBoundary G (allFiniteEdges n) := by
  intro x y _ _ _
  exact every_ordered_pair_is_listed x y

/-- The explicit finite checker is exactly the sealed-boundary property.
No coverage hypothesis is supplied by the caller. -/
theorem generated_check_iff_sealed (G : Locale (Fin n)) :
    checkEdges G (allFiniteEdges n) = true ↔ Sealed G := by
  constructor
  · intro h
    exact complete_passing_inventory_forces_sealing
      G (allFiniteEdges n) (generated_inventory_covers_every_boundary G) h
  · intro h
    exact sealing_passes_every_finite_check G h (allFiniteEdges n)

/-- Consequently the executable, exhaustively generated inventory is
necessary and sufficient for ALL-policy, ALL-horizon ORIGINAL-SIX-SHAPED
MODELED coexistence. There is no separate `CoversEveryBoundary` argument. -/
theorem generated_check_iff_universal_modeled_coexistence
    (G : Locale (Fin n)) :
    checkEdges G (allFiniteEdges n) = true ↔
      UniversalModeledCoexistence G :=
  full_inventory_check_iff_universal_coexistence
    G (allFiniteEdges n) (generated_inventory_covers_every_boundary G)

/-- A passing exhaustive check is a ready-to-use modeled protection
certificate for any represented policy, not just one selected optimizer. -/
theorem generated_check_protects_every_modeled_policy
    (G : Locale (Fin n))
    (hCheck : checkEdges G (allFiniteEdges n) = true) :
    UniversalModeledCoexistence G :=
  (generated_check_iff_universal_modeled_coexistence G).mp hCheck

/-- Same two-node physical-route model in both controls: an edge leaves the
inside region at 0 and reaches the outside location 1. -/
def twoNodeGraph (x y : Fin 2) : Bool :=
  decide (x = 0 ∧ y = 1)

def twoNodeInside (x : Fin 2) : Bool :=
  decide (x = 0)

/-- Metering the one crossing is enough for the positive model. -/
def sealedTwoNode : Locale (Fin 2) where
  adj := twoNodeGraph
  inside := twoNodeInside
  meter := fun _ _ => true

/-- Removing all meters while keeping adjacency unchanged is the
independent hostile control. -/
def unsealedTwoNode : Locale (Fin 2) where
  adj := twoNodeGraph
  inside := twoNodeInside
  meter := fun _ _ => false

theorem sealed_two_node_check_passes :
    checkEdges sealedTwoNode (allFiniteEdges 2) = true := by
  decide

theorem unsealed_two_node_check_fails :
    checkEdges unsealedTwoNode (allFiniteEdges 2) = false := by
  decide

theorem sealed_two_node_protects_all_modeled_policies :
    UniversalModeledCoexistence sealedTwoNode :=
  generated_check_protects_every_modeled_policy sealedTwoNode
    sealed_two_node_check_passes

theorem unsealed_two_node_has_no_universal_modeled_guarantee :
    ¬ UniversalModeledCoexistence unsealedTwoNode := by
  intro h
  have hCheck :=
    (generated_check_iff_universal_modeled_coexistence
      unsealedTwoNode).mpr h
  rw [unsealed_two_node_check_fails] at hCheck
  exact Bool.false_ne_true hCheck

#print axioms every_ordered_pair_is_listed
#print axioms generated_inventory_covers_every_boundary
#print axioms generated_check_iff_sealed
#print axioms generated_check_iff_universal_modeled_coexistence
#print axioms generated_check_protects_every_modeled_policy
#print axioms sealed_two_node_check_passes
#print axioms unsealed_two_node_check_fails
#print axioms sealed_two_node_protects_all_modeled_policies
#print axioms unsealed_two_node_has_no_universal_modeled_guarantee

end PhysicalBridges.FiniteBoundaryExhaustion
