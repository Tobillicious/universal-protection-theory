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

namespace PhysicalBridges.IR133

universe u
variable {State : Type u}

/-- A stipulated, physically certified direct process relation is NOT
established merely by introducing this predicate. -/
def AtStep (edge : State → State → Prop) : Nat → State → State → Prop
  | 0, start, finish => start = finish
  | n+1, start, finish =>
      ∃ middle, AtStep edge n start middle ∧ edge middle finish

/-- A nonforking *already certified* physical edge relation has at most
one successor at a fixed number of steps from the same origin. -/
theorem unique_fixed_depth_carrier_if_nonforking
    (edge : State → State → Prop)
    (hSingle : ∀ a b c, edge a b → edge a c → b = c) :
    ∀ n (start finish₁ finish₂ : State),
      AtStep edge n start finish₁ →
      AtStep edge n start finish₂ →
      finish₁ = finish₂ := by
  intro n
  induction n with
  | zero =>
      intro start finish₁ finish₂ h₁ h₂
      exact h₁.symm.trans h₂
  | succ n ih =>
      intro start finish₁ finish₂ h₁ h₂
      obtain ⟨middle₁, hBefore₁, hEdge₁⟩ := h₁
      obtain ⟨middle₂, hBefore₂, hEdge₂⟩ := h₂
      have hSame : middle₁ = middle₂ :=
        ih start middle₁ middle₂ hBefore₁ hBefore₂
      subst middle₂
      exact hSingle middle₁ finish₁ finish₂ hEdge₁ hEdge₂

end PhysicalBridges.IR133
