import PhysicalBridges.BCRDIdentityCharge

/-!
# The determining invariant, found in the actual source — reversibility

**4 November 2026 · noncanonical · summit foothold on real source rock · no canon edit.**

Reading the actual frozen BCRD generator (`FrozenBCRDEvents.evolve rho = W·rho·Wᵀ`, with `W`
the self-inverse unitary permutation `wUpdate`), the retained X3-independent invariant is
**reversibility**: `evolve` is an involution on the physical basis states (apply it twice and
you are back where you started), because `W` is its own inverse.

Why this matters for the summit:
* It is a **dynamical constraint** (a law restricting which transformations occur), NOT a
  conserved scalar — exactly the class #271's countermodel does not touch, and the class the
  verdict (#272) identified as the open route.
* It is **X3-independent**: `evolve`/`wUpdate` never mention protection, continuation or any
  particular's status.
* It is **retained by the real source** (proved from `BCRDIdentityCharge.source_action_on_all_matrix_units`).
* It **forces information-persistence**: no physical basis state is erased or terminal — every
  state has a recoverable predecessor (the same state, by self-inverse).

This is the candidate determining invariant GPT predicted, now exhibited in the frozen source.
Honest boundary: reversibility forces the *persistence / non-erasure* component of continuation;
whether it determines the FULL original X3 (experience, agency, freedom, restraint, maximality,
provenance) is the refined open top. Not fabricated; what is proved is proved, and the boundary
is named.
-/

namespace PhysicalBridges.SummitBCRDReversibility

open FrozenBCRDEvents

/-- The source's index permutation is an involution (`W` self-inverse at the index level). -/
theorem permutation_involution : ∀ i, permutation (permutation i) = i := by decide

/-- **The actual frozen source generator is reversible** on every physical basis state:
`evolve (evolve (matrixUnit i j)) = matrixUnit i j`. Proved from the source's own permutation
action and the index-involution — the retained, X3-independent dynamical invariant. -/
theorem source_generator_reverses_basis_states (i j : Index) :
    evolve (evolve (matrixUnit i j)) = matrixUnit i j := by
  have h1 : evolve (matrixUnit i j) = matrixUnit (permutation i) (permutation j) := by
    funext a b; exact BCRDIdentityCharge.source_action_on_all_matrix_units i j a b
  rw [h1]
  funext a b
  rw [BCRDIdentityCharge.source_action_on_all_matrix_units (permutation i) (permutation j) a b,
      permutation_involution i, permutation_involution j]

/-- **No physical basis state is an information sink.** For every source basis state there is a
state `evolve` maps onto it — nothing is erased or terminal. This is the persistence component
of continuation, forced by the source's reversibility (not postulated). -/
theorem source_erases_no_basis_state (i j : Index) :
    ∃ rho : Matrix6, evolve rho = matrixUnit i j :=
  ⟨evolve (matrixUnit i j), source_generator_reverses_basis_states i j⟩

/-- Reversibility is X3-independent yet forces persistence: the abstract fact that a self-inverse
step erases nothing — applied to the source generator above. (A self-inverse `f` is a bijection;
its image is everything, so no point is unreachable/terminal.) -/
theorem self_inverse_step_erases_nothing {α : Type} (f : α → α)
    (hinv : ∀ x, f (f x) = x) (y : α) : ∃ x, f x = y :=
  ⟨f y, hinv y⟩

#print axioms permutation_involution
#print axioms source_generator_reverses_basis_states
#print axioms source_erases_no_basis_state
#print axioms self_inverse_step_erases_nothing

end PhysicalBridges.SummitBCRDReversibility
