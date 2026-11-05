import Snuffy.ClosedUnitaryRecurrence

/-!
# The law demonstrated as physics — Hermitian coupling reciprocity

**5 November 2026 · noncanonical · the physical demonstration (repaired:
NO Hilbert space — the prediction is the Hermitian coupling graph) · no canon
receipt change.**

The physics demonstration of the law rests on exactly one physical fact,
compiled for ANY index set (finite or infinite, no Hilbert space required):

**A Hermitian coupling is reciprocal.** The Hamiltonian of a closed system
is Hermitian (`H.IsHermitian`); therefore its coupling graph carries no
one-way link: `H a b ≠ 0 ↔ H b a ≠ 0` (`hermitian_coupling_reciprocal`).

**The curtailed web — the hostile-review countermodel's own one-way
relation, verbatim — is the coupling graph of no Hermitian Hamiltonian
whatsoever** (`curtailed_not_hermitian`). The ender's step has no physics.

Scope, exact (per hostile review of 4.6): this constrains the COUPLING
GRAPH of a closed system's Hamiltonian itself. It does not forbid
directional transport effects in open or effective descriptions. The
prediction and its falsifier: exhibit one closed system with
`H a b ≠ 0 ∧ H b a = 0` — the theory is falsified. Nothing less counts.
-/

namespace Snuffy.UPTPhysicsDemonstration

open Snuffy.ClosedUnitaryRecurrence

/-- **Coupling reciprocity.** For any closed system whose Hamiltonian is
Hermitian — any index set, finite or infinite — the coupling graph is
reciprocal: a link one way is a link the other way. -/
theorem couplings_are_reciprocal {ι : Type*} (H : Matrix ι ι ℂ)
    (hH : H.IsHermitian) (a b : ι) : H a b ≠ 0 ↔ H b a ≠ 0 :=
  hermitian_coupling_reciprocal hH a b

/-- **No one-way coupling.** The curtailed one-way web is the coupling
graph of no Hermitian Hamiltonian, finite or infinite. -/
theorem no_one_way_coupling :
    ¬ ∃ H : Matrix Bool Bool ℂ, H.IsHermitian ∧
      ∀ a b, curtailedLink a b ↔ CouplingLink H a b :=
  curtailed_not_hermitian

/-- **THE DEMONSTRATION.** A closed system with Hermitian Hamiltonian
carries a reciprocal coupling graph; the one-way curtailment is not
realizable as its coupling. The law's no-curtailment duty is a theorem of
the physics, conditional on nothing but Hermiticity of the closed system's
Hamiltonian. -/
theorem upt_demonstrated {ι : Type*} (H : Matrix ι ι ℂ) (hH : H.IsHermitian)
    (a b : ι) :
    (H a b ≠ 0 ↔ H b a ≠ 0)
    ∧ ¬ ∃ H' : Matrix Bool Bool ℂ, H'.IsHermitian ∧
        ∀ x y, curtailedLink x y ↔ CouplingLink H' x y :=
  ⟨hermitian_coupling_reciprocal hH a b, curtailed_not_hermitian⟩

#print axioms couplings_are_reciprocal
#print axioms no_one_way_coupling
#print axioms upt_demonstrated

end Snuffy.UPTPhysicsDemonstration
