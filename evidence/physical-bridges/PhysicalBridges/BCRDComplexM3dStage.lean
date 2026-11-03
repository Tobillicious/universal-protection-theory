import PhysicalBridges.FrozenBCRDEvents

/-!
# PR B phase 17 — exact complex-state source stages: endogenous W then controlled L–M

This module transcribes the frozen physical *source* definition from
Tobillicious/physics-lane@2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35
orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/
tests/verify_bcrd_m3d_state_determined_accessibility.py

  W = (I3 - Q_M) ⊗ I2 + Q_M ⊗ X2
  C_LM = I3 ⊗ P0 + U_LM ⊗ P1
  U_LM = partial-swap(L,M, theta=pi/4)
  cos(pi/4) = sin(pi/4) = sqrt(2)/2, offdiagonal -i sin(pi/4).

All complex coefficients are represented exactly as four rationals
a + b sqrt(2) + i(c + d sqrt(2)).  This is an exact algebraic
coefficient model, NOT a float or an irrational approximation.
The six-component vectors preserve the original L0,L1,M0,M1,R0,R1 basis.

Proves source W is literally the pinned six-by-six frozen permutation
operator and that source C_LM produces genuine complex coherence:
  |M0> --W--> |M1> --C_LM--> (|M1> - i |L1>)/sqrt(2).

The last state has norm one, an off-diagonal imaginary density entry,
and cannot be represented as ANY one source basis position.

This does NOT establish subjective continuity, consent, source-wide
physical execution, exhaustive BCRD process stages or original X3.
-/

namespace PhysicalBridges.BCRDComplexM3dStage

open PhysicalBridges.FrozenBCRDEvents

/-- Formal real coefficient a+b sqrt(2), with sqrt(2)^2 = 2. -/
structure Surd where
  a : Rat
  b : Rat
deriving DecidableEq, Repr

def sz : Surd := ⟨0,0⟩
def so : Surd := ⟨1,0⟩
def sadd (x y : Surd) : Surd := ⟨x.a+y.a,x.b+y.b⟩
def sneg (x : Surd) : Surd := ⟨-x.a,-x.b⟩
def ssub (x y : Surd) : Surd := sadd x (sneg y)
def smul (x y : Surd) : Surd :=
  ⟨x.a*y.a + 2*x.b*y.b, x.a*y.b + x.b*y.a⟩

/-- Exact algebraic complex a+b√2 + i(c+d√2). -/
structure Cx where
  re : Surd
  im : Surd
deriving DecidableEq, Repr

def cz : Cx := ⟨sz,sz⟩
def co : Cx := ⟨so,sz⟩
def cadd (x y : Cx) : Cx := ⟨sadd x.re y.re,sadd x.im y.im⟩
def cneg (x : Cx) : Cx := ⟨sneg x.re,sneg x.im⟩
def csub (x y : Cx) : Cx := cadd x (cneg y)
def cmul (x y : Cx) : Cx :=
  ⟨ssub (smul x.re y.re) (smul x.im y.im),
    sadd (smul x.re y.im) (smul x.im y.re)⟩
def cconj (x : Cx) : Cx := ⟨x.re,sneg x.im⟩
def cabs2 (x : Cx) : Surd :=
  sadd (smul x.re x.re) (smul x.im x.im)

/-- α = cos(pi/4) = √2/2; β = -i sin(pi/4) = -i√2/2. -/
def alpha : Cx := ⟨⟨0,1/2⟩,sz⟩
def beta : Cx := ⟨sz,⟨0,-1/2⟩⟩

theorem exact_partial_swap_coefficient_norm :
    sadd (cabs2 alpha) (cabs2 beta) = so := by decide +kernel

abbrev State := Index → Cx
abbrev StageMatrix := Index → Index → Cx

def basis (k : Index) : State := fun i => if i = k then co else cz

/-- Exact matrix-vector multiplication on the six-source basis. -/
def matVec (m : StageMatrix) (v : State) : State := fun i =>
  cadd (cmul (m i 0) (v 0))
    (cadd (cmul (m i 1) (v 1))
      (cadd (cmul (m i 2) (v 2))
        (cadd (cmul (m i 3) (v 3))
          (cadd (cmul (m i 4) (v 4))
                (cmul (m i 5) (v 5))))))

def kron (a : Nat → Nat → Cx) (b : Nat → Nat → Cx) :
    StageMatrix :=
  fun i j => cmul (a (i.val / 2) (j.val / 2))
                  (b (i.val % 2) (j.val % 2))

def ident (i j : Nat) : Cx := if i = j then co else cz
def middleProjector (i j : Nat) : Cx :=
  if i = 1 ∧ j = 1 then co else cz
def regZeroProjector (i j : Nat) : Cx :=
  if i = 0 ∧ j = 0 then co else cz
def regOneProjector (i j : Nat) : Cx :=
  if i = 1 ∧ j = 1 then co else cz
def regFlip (i j : Nat) : Cx :=
  if (i = 0 ∧ j = 1) ∨ (i = 1 ∧ j = 0) then co else cz

/-- Literal pinned tensor-source W equation. -/
def sourceW : StageMatrix := fun i j =>
  cadd
    (kron (fun a b => csub (ident a b) (middleProjector a b)) ident i j)
    (kron middleProjector regFlip i j)

/-- Source pinning: the complex-state W is exactly the original
six-index frozen real/integer permutation promoted to Cx. -/
theorem source_W_matches_frozen_matrix :
    ∀ i j : Index,
      sourceW i j =
        (if wUpdate i j = 1 then co else cz) := by decide +kernel

/-- Source partial swap at θ=π/4 on matter L/M, leaving R fixed. -/
def sourceULM (a b : Nat) : Cx :=
  if a = b then
    if a = 0 ∨ a = 1 then alpha else co
  else if (a = 0 ∧ b = 1) ∨ (a = 1 ∧ b = 0) then beta
  else cz

/-- Literal pinned C_LM = I3 ⊗ P0 + U_LM ⊗ P1. -/
def sourceCLM : StageMatrix := fun i j =>
  cadd (kron ident regZeroProjector i j)
       (kron sourceULM regOneProjector i j)

/-- Original state, source W-stage, then controlled L/M-stage. -/
def initial : State := basis 2
def afterW : State := matVec sourceW initial
def afterC : State := matVec sourceCLM afterW

def coherentLM : State := fun i =>
  if i = 1 then beta else if i = 3 then alpha else cz

theorem W_moves_M0_to_M1 : afterW = basis 3 := by
  funext i
  have h : ∀ k : Index, afterW k = basis 3 k := by decide +kernel
  exact h i

/-- Genuine source-controlled L–M transition: complex superposition,
not a basis permutation or invented collapse. -/
theorem controlled_LM_produces_exact_complex_superposition :
    afterC = coherentLM := by
  funext i
  have h : ∀ k : Index, afterC k = coherentLM k := by decide +kernel
  exact h i

/-- Norm square in the exact algebraic real subfield. -/
def norm2 (v : State) : Surd :=
  sadd (cabs2 (v 0))
    (sadd (cabs2 (v 1))
      (sadd (cabs2 (v 2))
        (sadd (cabs2 (v 3))
          (sadd (cabs2 (v 4)) (cabs2 (v 5))))))

theorem original_and_intermediate_state_norm_one :
    norm2 initial = so ∧ norm2 afterW = so := by decide +kernel

theorem coherent_state_norm_one : norm2 afterC = so := by decide +kernel

/-- Exact complex density |ψ><ψ|. The L1-M1 coherence is
imaginary and NONZERO, unlike every single basis projector. -/
def density (v : State) : StageMatrix :=
  fun i j => cmul (v i) (cconj (v j))

def negativeImaginaryHalf : Cx := ⟨sz,⟨-1/2,0⟩⟩

theorem source_state_has_nonzero_imaginary_coherence :
    density afterC 1 3 = negativeImaginaryHalf ∧
    negativeImaginaryHalf ≠ cz := by decide +kernel

/-- The transformed source state cannot be assigned a UNIQUE
basis-position label without discarding physical coherence. -/
theorem coherent_state_is_not_any_basis_state :
    ¬ ∃ k : Index, afterC = basis k := by
  intro ⟨k,h⟩
  have h1 := congrFun h 1
  have h3 := congrFun h 3
  have bad : ∀ j : Index,
      ¬ (afterC 1 = basis j 1 ∧ afterC 3 = basis j 3) := by decide +kernel
  exact bad k ⟨h1,h3⟩

/-!
## Exact full-space algebra for the source stage matrices

These checks quantify over ALL 36 matrix coefficients. They do not
merely test the original basis-density input. The controlled L/M
and M/R 45-degree partial swaps are exact algebraic unitary matrices
over the finite coefficient ring Q(sqrt(2),i). This is local M3d
operator structure, not a claim that every density is physically
instantiated or that any protected subject continues.
-/

/-- Adjoint: transpose and complex conjugation on exact coefficients. -/
def adjoint (a : StageMatrix) : StageMatrix :=
  fun i j => cconj (a j i)

/-- Exact six-by-six matrix product; no floating point or sampling. -/
def matrixProduct (a b : StageMatrix) : StageMatrix := fun i j =>
  cadd (cmul (a i 0) (b 0 j))
    (cadd (cmul (a i 1) (b 1 j))
      (cadd (cmul (a i 2) (b 2 j))
        (cadd (cmul (a i 3) (b 3 j))
          (cadd (cmul (a i 4) (b 4 j))
                (cmul (a i 5) (b 5 j))))))

def unitMatrix : StageMatrix := fun i j => if i = j then co else cz

/-- Source W is a full-space exact complex unitary. -/
theorem source_W_unitary :
    ∀ i j : Index,
      matrixProduct (adjoint sourceW) sourceW i j =
        unitMatrix i j := by decide +kernel

/-- The source enabled controlled L/M stage is unitary on the
WHOLE exact complex six-dimensional basis, including states
with off-diagonal coherences and relational-sector superpositions. -/
theorem source_controlled_LM_unitary :
    ∀ i j : Index,
      matrixProduct (adjoint sourceCLM) sourceCLM i j =
        unitMatrix i j := by decide +kernel

/-- The second genuine source generator: U_MR at theta pi/4
on matter positions M and R, independently within both
relation sectors. It is NOT another W swap. -/
def sourceUMR (a b : Nat) : Cx :=
  if a = b then
    if a = 1 ∨ a = 2 then alpha else co
  else if (a = 1 ∧ b = 2) ∨ (a = 2 ∧ b = 1) then beta
  else cz

/-- Literal source U_MR_6 = U_MR ⊗ I2. -/
def sourceUMR6 : StageMatrix := kron sourceUMR ident

theorem source_MR_partial_swap_unitary :
    ∀ i j : Index,
      matrixProduct (adjoint sourceUMR6) sourceUMR6 i j =
        unitMatrix i j := by decide +kernel

/-- The source's fixed controlled compound process, with
right-to-left matrix composition. The source defines
U_FIXED = C_LM * U_MR_6 * C_LM, whereas the separate
endogenous-update control starts with W. -/
def sourceUFixed : StageMatrix :=
  matrixProduct sourceCLM (matrixProduct sourceUMR6 sourceCLM)

/-- Concrete source-run stages: the appended W followed by
the first enabled C_LM. This fixes their temporal distinction
without asserting that W is part of source U_FIXED. -/
inductive SourceStage where
  | endogenousW | enabledLM | middleRight
deriving DecidableEq, Repr

def operatorFor : SourceStage → StageMatrix
  | .endogenousW => sourceW
  | .enabledLM => sourceCLM
  | .middleRight => sourceUMR6

def runStages (stages : List SourceStage) (psi : State) : State :=
  stages.foldl (fun s stage => matVec (operatorFor stage) s) psi

theorem pinned_two_stage_history_is_exact :
    runStages [.endogenousW, .enabledLM] (basis 2) = coherentLM := by
  apply funext
  intro i
  have h : ∀ j : Index,
      runStages [.endogenousW, .enabledLM] (basis 2) j =
        coherentLM j := by decide +kernel
  exact h i

#print axioms source_W_unitary
#print axioms source_controlled_LM_unitary
#print axioms source_MR_partial_swap_unitary
#print axioms pinned_two_stage_history_is_exact

#print axioms source_W_matches_frozen_matrix
#print axioms W_moves_M0_to_M1
#print axioms controlled_LM_produces_exact_complex_superposition
#print axioms exact_partial_swap_coefficient_norm
#print axioms coherent_state_norm_one
#print axioms source_state_has_nonzero_imaginary_coherence
#print axioms coherent_state_is_not_any_basis_state

end PhysicalBridges.BCRDComplexM3dStage
