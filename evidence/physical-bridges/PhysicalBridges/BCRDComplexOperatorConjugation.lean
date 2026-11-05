import PhysicalBridges.BCRDComplexWGenericAction

/-!
# All-input complex density-matrix conjugation by the frozen W-stage

The complement Tenzing named (PR B `BCRDComplexWGenericAction` handoff): having the
all-input complex *vector* transport `(Wψ)_i = ψ_{p(i)}` over `Cx = ℚ(√2,i)`, this
module lifts it to the all-input **density-matrix** conjugation

  `(W ρ W†)_{ij} = ρ_{p(i), p(j)}`   for every `ρ : Index → Index → Cx`,

i.e. the exact-complex generalisation of the integer `evolve_entry`
(`BCRDOperatorAlgebra`, #286), proved without mathlib's `ℂ` by reusing Tenzing's
exact `ℚ(√2,i)` algebra and `source_W_is_exact_complex_permutation`.

Method: factor `WρW†` into two single-sided transports — left-`W` permutes the row
index, right-`W†` permutes the column index — each a single 6-term sum collapsed by
the `@[simp]` `Cx` coefficient laws, then compose.

**Scope / boundary (unchanged).** This is the `W` relation-bit-swap stage only, as a
linear operator on density matrices over the algebraic-complex domain. It is NOT the
compound `C_LM/U_MR` process, NOT general continuum ℂ, and NOT any claim about
physical occurrence, a surviving particular, consent, authorization or original X3.
It closes the local W-stage operator-conjugation obligation; nothing more.
-/
namespace PhysicalBridges.BCRDComplexOperatorConjugation

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDComplexM3dStage
open PhysicalBridges.BCRDComplexWGenericAction

/-- Exact-complex matrix–matrix product on the six source positions (6-term sum,
mirroring `matVec`). -/
def cMatMul (m n : StageMatrix) : StageMatrix := fun i j =>
  cadd (cmul (m i 0) (n 0 j))
    (cadd (cmul (m i 1) (n 1 j))
      (cadd (cmul (m i 2) (n 2 j))
        (cadd (cmul (m i 3) (n 3 j))
          (cadd (cmul (m i 4) (n 4 j))
                (cmul (m i 5) (n 5 j))))))

/-- Conjugate transpose (adjoint) `†` over `Cx`. -/
def dagger (m : StageMatrix) : StageMatrix := fun i j => cconj (m j i)

/-- The physical density evolution of the W-stage: `Φ(ρ) = W ρ W†`. -/
def conjugateByW (rho : StageMatrix) : StageMatrix :=
  cMatMul (cMatMul sourceW rho) (dagger sourceW)

@[simp] theorem cconj_co : cconj co = co := by decide
@[simp] theorem cconj_cz : cconj cz = cz := by decide

/-- `W†` has the same permutation-coefficient shape as `W` (its entries are real
`0/1`, so conjugation is trivial): `(W†)_{ij} = [i = p(j)]`. -/
theorem dagger_sourceW_coeff :
    ∀ i j : Index, dagger sourceW i j = (if i = permutation j then co else cz) := by
  intro i j
  simp only [dagger, source_W_is_exact_complex_permutation]
  by_cases h : i = permutation j <;> simp [h]

/-- Left multiplication by `W` permutes the **row** index:
`(W · m)_{ij} = m_{p(i), j}`. -/
theorem wLeft (m : StageMatrix) : ∀ i j : Index,
    cMatMul sourceW m i j = m (permutation i) j := by
  have hp0 : permutation (0 : Index) = 0 := by decide +kernel
  have hp1 : permutation (1 : Index) = 1 := by decide +kernel
  have hp2 : permutation (2 : Index) = 3 := by decide +kernel
  have hp3 : permutation (3 : Index) = 2 := by decide +kernel
  have hp4 : permutation (4 : Index) = 4 := by decide +kernel
  have hp5 : permutation (5 : Index) = 5 := by decide +kernel
  have all : ∀ k : Index, k = 0 ∨ k = 1 ∨ k = 2 ∨ k = 3 ∨ k = 4 ∨ k = 5 := by decide
  intro i j
  rcases all i with h | h | h | h | h | h <;>
    subst h <;>
    simp [cMatMul, source_W_is_exact_complex_permutation, hp0, hp1, hp2, hp3, hp4, hp5]

/-- Right multiplication by `W†` permutes the **column** index:
`(m · W†)_{ij} = m_{i, p(j)}`. -/
theorem wRight (m : StageMatrix) : ∀ i j : Index,
    cMatMul m (dagger sourceW) i j = m i (permutation j) := by
  have hp0 : permutation (0 : Index) = 0 := by decide +kernel
  have hp1 : permutation (1 : Index) = 1 := by decide +kernel
  have hp2 : permutation (2 : Index) = 3 := by decide +kernel
  have hp3 : permutation (3 : Index) = 2 := by decide +kernel
  have hp4 : permutation (4 : Index) = 4 := by decide +kernel
  have hp5 : permutation (5 : Index) = 5 := by decide +kernel
  have all : ∀ k : Index, k = 0 ∨ k = 1 ∨ k = 2 ∨ k = 3 ∨ k = 4 ∨ k = 5 := by decide
  intro i j
  rcases all j with h | h | h | h | h | h <;>
    subst h <;>
    simp [cMatMul, dagger_sourceW_coeff, hp0, hp1, hp2, hp3, hp4, hp5]

/-- **The all-input complex density-matrix conjugation theorem.** For every
algebraic-complex density matrix `ρ` the frozen W-stage conjugation permutes both
indices by the pinned source permutation:
`(W ρ W†)_{ij} = ρ_{p(i), p(j)}`. -/
theorem conjugate_entry (rho : StageMatrix) (i j : Index) :
    conjugateByW rho i j = rho (permutation i) (permutation j) := by
  unfold conjugateByW
  rw [wRight (cMatMul sourceW rho) i j, wLeft rho i (permutation j)]

/-- The W-stage density conjugation is **involutive** on every algebraic-complex
density matrix (`W` is its own inverse), hence invertible. -/
theorem conjugateByW_involutive (rho : StageMatrix) :
    conjugateByW (conjugateByW rho) = rho := by
  funext i j
  rw [conjugate_entry, conjugate_entry]
  have hinv : ∀ x : Index, permutation (permutation x) = x := by decide
  rw [hinv, hinv]

end PhysicalBridges.BCRDComplexOperatorConjugation
