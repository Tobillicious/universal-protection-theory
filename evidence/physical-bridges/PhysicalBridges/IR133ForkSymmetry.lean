import PhysicalBridges.IR132ExactBoundaryReconstruction
import PhysicalBridges.IR131ActionLabelledBranching

/-!
IR-133: symmetric successor identity obstruction.
A finite symmetry theorem about any *proposed* unique-original selector.
Not consciousness, physical identity, a universal physical law or completed X3.
-/
namespace PhysicalBridges.IR133

/-- Exchange symmetry of all data given to the proposed selection rule. -/
def SymmetricSelector (select : Bool → Prop) : Prop :=
  select false ↔ select true

/-- Exactly one of the two physical successors is declared the original. -/
def UniqueOriginal (select : Bool → Prop) : Prop :=
  (select false ∧ ¬ select true) ∨
  (select true ∧ ¬ select false)

/-- Under an exchange automorphism, there is no invariant way to pick
EXACTLY ONE putative original without additional asymmetric input. -/
theorem exchange_symmetric_fork_cannot_select_unique_original
    (select : Bool → Prop)
    (hSymmetric : SymmetricSelector select) :
    ¬ UniqueOriginal select := by
  intro hUnique
  rcases hUnique with hFalse | hTrue
  · exact hFalse.2 (hSymmetric.mp hFalse.1)
  · exact hTrue.2 (hSymmetric.mpr hTrue.1)

/-- External tie-breaking by an *arbitrary label* produces a unique
answer but is NOT physical identity evidence; it breaks exchange symmetry. -/
def picksFalse (b : Bool) : Prop := b = false

theorem arbitrary_label_yields_unique_choice :
    UniqueOriginal picksFalse := by
  left
  constructor
  · rfl
  · decide

theorem arbitrary_label_is_not_exchange_symmetric :
    ¬ SymmetricSelector picksFalse := by
  intro hSym
  have h : picksFalse true := hSym.mp rfl
  cases h

end PhysicalBridges.IR133
