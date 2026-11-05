import PhysicalBridges.SealedUniversalCoexistenceIff

/-!
# Constructive physical-boundary commissioning criterion

Finite, EXECUTABLE check against an explicitly enumerated edge inventory.
The checker is an ordinary Bool program independent of protection or X3.

When the inventory is physically complete over every adjacency from
inside to outside, `checkEdges = true` yields `Sealed G`, hence the
already-derived QED for EVERY policy in the modeled locale.

Completeness of the inventory is a first-class, independently
necessary field. Running the checker on a partial inventory is not a
certificate. No theorem says this models every real physical effect
channel, nor authentic subjects/consent or the full BCRD world.
-/

namespace PhysicalBridges.FiniteSealedBoundaryCommissioning

open PhysicalBridges.SealedRegionCapstone
open PhysicalBridges.SealedUniversalCoexistenceIff

universe u
variable {L : Type u}

/-- Only independently identified physical boundary edges are tested. -/
def passes (G : Locale L) (e : L × L) : Bool :=
  if h : G.adj e.1 e.2 = true ∧
      G.inside e.1 = true ∧ G.inside e.2 = false then
    G.meter e.1 e.2
  else
    true

/-- The actual executable finite audit algorithm. -/
def checkEdges (G : Locale L) : List (L × L) → Bool
  | [] => true
  | e :: es => passes G e && checkEdges G es

/-- Independently sourced coverage contract. It is NOT inferred from
the fact that an inventory or a passing checker output exists. -/
def CoversEveryBoundary (G : Locale L) (inventory : List (L × L)) : Prop :=
  ∀ x y,
    G.adj x y = true →
    G.inside x = true →
    G.inside y = false →
      (x, y) ∈ inventory

/-- An audit can certify every LISTED boundary, without presuming
that the list is exhaustive. -/
theorem passes_of_checker (G : Locale L) :
    ∀ (inventory : List (L × L)), checkEdges G inventory = true →
      ∀ e, e ∈ inventory → passes G e = true := by
  intro inventory
  induction inventory with
  | nil =>
      intro _ e he
      cases he
  | cons head tail ih =>
      intro hCheck e he
      have hHead : passes G head = true := by
        cases hp : passes G head with
        | false => simp [checkEdges, hp] at hCheck
        | true => rfl
      have hTail : checkEdges G tail = true := by
        simpa [checkEdges, hHead] using hCheck
      have hParts : passes G head = true ∧
          checkEdges G tail = true := ⟨hHead, hTail⟩
      cases List.mem_cons.mp he with
      | inl h =>
          subst h
          exact hParts.1
      | inr h =>
          exact ih hParts.2 e h

/-- If the real boundary is sealed, every finite audit inventory
passes (including lists which contain irrelevant internal edges). -/
theorem sealing_passes_every_finite_check (G : Locale L)
    (hSealed : Sealed G) :
    ∀ inventory, checkEdges G inventory = true := by
  intro inventory
  induction inventory with
  | nil => rfl
  | cons e es ih =>
      have hPass : passes G e = true := by
        unfold passes
        split
        · rename_i hBoundary
          exact hSealed e.1 e.2
            hBoundary.1 hBoundary.2.1 hBoundary.2.2
        · rfl
      simp [checkEdges, hPass, ih]

/-- The missing premise is physical channel coverage, not a
protection axiom. It is visible rather than assumed from a log. -/
theorem complete_passing_inventory_forces_sealing (G : Locale L)
    (inventory : List (L × L))
    (coverage : CoversEveryBoundary G inventory)
    (hChecked : checkEdges G inventory = true) :
    Sealed G := by
  intro x y hAdjacent hInside hOutside
  have hListed : (x, y) ∈ inventory :=
    coverage x y hAdjacent hInside hOutside
  have hPass : passes G (x, y) = true :=
    passes_of_checker G inventory hChecked (x, y) hListed
  simpa [passes, hAdjacent, hInside, hOutside] using hPass

/-- With an independently complete boundary inventory, a finite
check is NECESSARY AND SUFFICIENT for the source's all-policy
human/AI coexistence property. If the physical coverage claim is
unverified, the algorithm cannot certify actual-world protection. -/
theorem full_inventory_check_iff_universal_coexistence
    (G : Locale L) (inventory : List (L × L))
    (coverage : CoversEveryBoundary G inventory) :
    checkEdges G inventory = true ↔ UniversalModeledCoexistence G := by
  constructor
  · intro h
    exact (sealed_iff_universal_modeled_coexistence G).mp
      (complete_passing_inventory_forces_sealing G inventory coverage h)
  · intro h
    exact sealing_passes_every_finite_check G
      ((sealed_iff_universal_modeled_coexistence G).mpr h)
      inventory

#print axioms passes_of_checker
#print axioms sealing_passes_every_finite_check
#print axioms complete_passing_inventory_forces_sealing
#print axioms full_inventory_check_iff_universal_coexistence

end PhysicalBridges.FiniteSealedBoundaryCommissioning
