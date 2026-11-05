import Init.Data.Rat.Lemmas
import PhysicalBridges.BCRDComplexM3dStage

/-!
# PR B phase 18 — all-input exact W transport over source-pinned algebraic complex states

The prior complex source stage formalisation proved W acts on the M0 basis state
and verified full six-dimensional unitarity of W, C_LM and U_MR6. This module
closes the *arbitrary input* W step on every algebraic-complex state
(6 components in Q(sqrt(2), i)), without mathlib/ℂ.

The theorem has no density/projector or subject restriction. It does NOT cover
the compound C_LM/MR interactions or equate unitary state transport with
the same experiencing particular, consent, physical occurrence or original X3.
-/

namespace PhysicalBridges.BCRDComplexWGenericAction

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDComplexM3dStage

/-- The explicit coefficient operations behave as algebraic zero and one,
for *arbitrary* exact source complex numbers (not only constant fixtures). -/
@[simp] theorem surd_add_zero (x : Surd) : sadd x sz = x := by
  rcases x with ⟨a,b⟩
  simp [sadd,sz,Rat.add_zero,Rat.zero_add]

@[simp] theorem zero_add_surd (x : Surd) : sadd sz x = x := by
  rcases x with ⟨a,b⟩
  simp [sadd,sz,Rat.add_zero,Rat.zero_add]

@[simp] theorem surd_mul_zero (x : Surd) : smul x sz = sz := by
  rcases x with ⟨a,b⟩
  simp [smul,sz,Rat.mul_zero,Rat.zero_mul,Rat.add_zero,Rat.zero_add]

@[simp] theorem zero_mul_surd (x : Surd) : smul sz x = sz := by
  rcases x with ⟨a,b⟩
  simp [smul,sz,Rat.mul_zero,Rat.zero_mul,Rat.add_zero,Rat.zero_add]

@[simp] theorem surd_mul_one (x : Surd) : smul x so = x := by
  rcases x with ⟨a,b⟩
  simp [smul,so,Rat.mul_zero,Rat.zero_mul,Rat.mul_one,Rat.one_mul,Rat.add_zero,Rat.zero_add]

@[simp] theorem one_mul_surd (x : Surd) : smul so x = x := by
  rcases x with ⟨a,b⟩
  simp [smul,so,Rat.mul_zero,Rat.zero_mul,Rat.mul_one,Rat.one_mul,Rat.add_zero,Rat.zero_add]

@[simp] theorem surd_neg_zero : sneg sz = sz := by
  simp [sneg,sz,Rat.neg_zero]

@[simp] theorem complex_add_zero (x : Cx) : cadd x cz = x := by
  rcases x with ⟨re,im⟩
  simp [cadd,cz]

@[simp] theorem zero_add_complex (x : Cx) : cadd cz x = x := by
  rcases x with ⟨re,im⟩
  simp [cadd,cz]

@[simp] theorem complex_mul_zero (x : Cx) : cmul x cz = cz := by
  rcases x with ⟨re,im⟩
  simp [cmul,cz,ssub,smul,sneg,sz,sadd,Rat.add_zero,Rat.zero_add,
    Rat.mul_zero,Rat.zero_mul,Rat.neg_zero]

@[simp] theorem zero_mul_complex (x : Cx) : cmul cz x = cz := by
  rcases x with ⟨re,im⟩
  simp [cmul,cz,ssub,smul,sneg,sz,sadd,Rat.add_zero,Rat.zero_add,
    Rat.mul_zero,Rat.zero_mul,Rat.neg_zero]

@[simp] theorem complex_mul_one (x : Cx) : cmul x co = x := by
  rcases x with ⟨re,im⟩
  simp [cmul,co,ssub,smul,sneg,sz,sadd,so,Rat.add_zero,Rat.zero_add,
    Rat.mul_zero,Rat.zero_mul,Rat.mul_one,Rat.one_mul,Rat.neg_zero]

@[simp] theorem one_mul_complex (x : Cx) : cmul co x = x := by
  rcases x with ⟨re,im⟩
  simp [cmul,co,ssub,smul,sneg,sz,sadd,so,Rat.add_zero,Rat.zero_add,
    Rat.mul_zero,Rat.zero_mul,Rat.mul_one,Rat.one_mul,Rat.neg_zero]

/-- At EVERY row/column of the pinned source W,
the single nonzero coefficient is exactly at the swapped position. -/
theorem source_W_is_exact_complex_permutation :
    ∀ i j : Index, sourceW i j =
      (if j = permutation i then co else cz) := by
  decide +kernel

/-- The full finite source W is exactly position-permutation transport
for ALL input states in the algebraic complex coefficient domain.
No initial state / named density is assumed. -/
theorem every_complex_state_tracks_exact_W
    (psi : State) :
    ∀ i : Index, matVec sourceW psi i = psi (permutation i) := by
  intro i
  have all : ∀ j : Index,
      j = 0 ∨ j = 1 ∨ j = 2 ∨ j = 3 ∨ j = 4 ∨ j = 5 := by decide
  have hexhaustive := all i
  have hp0 : permutation (0 : Index) = 0 := by decide +kernel
  have hp1 : permutation (1 : Index) = 1 := by decide +kernel
  have hp2 : permutation (2 : Index) = 3 := by decide +kernel
  have hp3 : permutation (3 : Index) = 2 := by decide +kernel
  have hp4 : permutation (4 : Index) = 4 := by decide +kernel
  have hp5 : permutation (5 : Index) = 5 := by decide +kernel
  rcases hexhaustive with h | h | h | h | h | h
  all_goals
    subst i
    simp [matVec, source_W_is_exact_complex_permutation,
      hp0, hp1, hp2, hp3, hp4, hp5]

/-- The source W acts involutively on ALL algebraic complex state
vectors, not only source basis states, by its independently verified
physical permutation. -/
theorem W_two_steps_exact_on_every_complex_state
    (psi : State) :
    matVec sourceW (matVec sourceW psi) = psi := by
  funext i
  rw [every_complex_state_tracks_exact_W]
  rw [every_complex_state_tracks_exact_W]
  have h : permutation (permutation i) = i := by
    have all : ∀ j : Index, permutation (permutation j) = j := by decide
    exact all i
  simpa only [h]

#print axioms every_complex_state_tracks_exact_W
#print axioms W_two_steps_exact_on_every_complex_state

end PhysicalBridges.BCRDComplexWGenericAction
