import PhysicalBridges.BCRDOperatorAlgebra
import PhysicalBridges.CyclicGenesisBoundary

/-!
# Exact historical #297 unique mathematics, recovered additively

7 November 2026. Historical PR #297 was closed WITHOUT merging; it
contains multiple genuine operator and time-order results absent from the
corresponding files on current main. Do not overwrite those files or
confuse their newer original theorems with the older alternative claims.

This isolated module recovers the earlier theorem statements and proof
constructions under a new namespace using the current, already imported
source definitions. Its proof targets are precisely the old:
* W evolution is additive and integer-scalar homogeneous on matrices.
* The Nat interior has unique immediate predecessors when they exist.
* An objective Int translation is a genuine two-sided bijection and
  agrees with the embedded forward interior history, without providing
  an interior past to rank zero.
* All allowed genesis paths are causal-rank nondecreasing, so a genuinely
  forward step cannot be followed by an allowed journey back.

These are mathematical-model statements, NOT a proof that our actual
universe has this ontology or that objective bijectivity enforces
real-world original-six-X3/consent. No historical source overwritten.
-/

namespace PhysicalBridges.Historical297UniqueLemmas

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDOperatorAlgebra
open PhysicalBridges.CyclicGenesisInterior
open PhysicalBridges.CyclicGenesisBoundary

/-- Historical #297 algebra: Φ is additive on the complete frozen-W
integer-matrix source, strengthening the previously merged
product-preservation/involution results. -/
theorem evolve_preserves_add (A B : Matrix6) :
    evolve (fun i j => A i j + B i j) =
      fun i j => evolve A i j + evolve B i j := by
  funext i j
  simp only [BCRDOperatorAlgebra.evolve_entry]

/-- Historical #297 algebra: Φ commutes with integer scalar actions. -/
theorem evolve_preserves_smul (c : Int) (A : Matrix6) :
    evolve (fun i j => c * A i j) =
      fun i j => c * evolve A i j := by
  funext i j
  simp only [BCRDOperatorAlgebra.evolve_entry]

/-- The successor-only Nat interior has a unique immediate prior stage
*when* one exists. This is not objective global surjectivity. -/
theorem natInterior_past_recoverable (a b c : Nat) :
    natInterior.step a c → natInterior.step b c → a = b := by
  intro hac hbc
  have e1 : c = a + 1 := hac
  have e2 : c = b + 1 := hbc
  omega

/-- Concrete, rather than merely assumed, objective bijective shift. -/
def objectiveForward (z : Int) : Int := z + 1

def objectiveBackward (z : Int) : Int := z - 1

theorem objective_shift_has_two_sided_inverse (z : Int) :
    objectiveBackward (objectiveForward z) = z ∧
      objectiveForward (objectiveBackward z) = z := by
  dsimp [objectiveBackward, objectiveForward]
  omega

theorem objective_shift_is_surjective :
    ∀ z : Int, ∃ before : Int, objectiveForward before = z := by
  intro z
  exact ⟨objectiveBackward z, (objective_shift_has_two_sided_inverse z).2⟩

def embedInterior (n : Nat) : Int := (n : Int)

theorem forward_interior_agrees_with_objective (n : Nat) :
    embedInterior (n + 1) = objectiveForward (embedInterior n) := by
  simp [embedInterior, objectiveForward]

/-- Even though the objective shift is bijective, the unique inverse
at the embedded Nat origin is not inside the interior image. -/
theorem objective_inverse_escapes_interior_at_origin :
    ¬ ∃ n : Nat,
      embedInterior n = objectiveBackward (embedInterior 0) := by
  rintro ⟨n, h⟩
  dsimp [embedInterior, objectiveBackward] at h
  omega

theorem interior_has_a_forward_step :
    natInterior.step (0 : Nat) (1 : Nat) := by
  change (1 : Nat) = (0 : Nat) + 1
  rfl

/-- Historical #297's *concrete* category seal, kept distinct
from main's newer universal-Reindex interior no-rewind lemma. -/
theorem objective_reversibility_does_not_descend :
    (∀ z : Int,
      objectiveBackward (objectiveForward z) = z ∧
      objectiveForward (objectiveBackward z) = z) ∧
    (∀ n : Nat,
      embedInterior (n + 1) = objectiveForward (embedInterior n)) ∧
    (∀ a b : Nat, natInterior.step a b → ¬ natInterior.step b a) ∧
    (¬ ∃ n : Nat,
      embedInterior n = objectiveBackward (embedInterior 0)) := by
  exact ⟨objective_shift_has_two_sided_inverse,
    forward_interior_agrees_with_objective,
    fun a b => CyclicGenesisInterior.no_backward_time natInterior a b,
    objective_inverse_escapes_interior_at_origin⟩

/-- The original #297 path-length theorem: along ANY modeled genesis
journey, global causal rank is nondecreasing, beyond the single-step
right-handed result already on main. -/
theorem reaches_causal_monotone (M : Nat) :
    ∀ {a b : St}, Reaches M a b →
      globalCausal M a ≤ globalCausal M b := by
  intro a b h
  induction h with
  | refl => exact Nat.le_refl _
  | step hst _ ih =>
      exact Nat.le_trans
        (Nat.le_of_lt (step_advances_causal M _ _ hst)) ih

/-- Once a genuine forward step happens, no nonempty or empty allowed
return journey can reverse it. No cosmological claim is asserted. -/
theorem no_return_after_step (M : Nat) (a b : St)
    (hstep : step M a b) (hback : Reaches M b a) : False := by
  have h1 := step_advances_causal M a b hstep
  have h2 := reaches_causal_monotone M hback
  omega

#print axioms evolve_preserves_add
#print axioms evolve_preserves_smul
#print axioms natInterior_past_recoverable
#print axioms objective_shift_has_two_sided_inverse
#print axioms objective_shift_is_surjective
#print axioms forward_interior_agrees_with_objective
#print axioms objective_inverse_escapes_interior_at_origin
#print axioms objective_reversibility_does_not_descend
#print axioms reaches_causal_monotone
#print axioms no_return_after_step

end PhysicalBridges.Historical297UniqueLemmas
