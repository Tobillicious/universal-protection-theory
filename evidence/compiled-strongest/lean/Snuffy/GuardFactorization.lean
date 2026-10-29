import Mathlib.Data.Matrix.Basic
import Mathlib.LinearAlgebra.Matrix.Kronecker

namespace Snuffy.GuardFactorization

open Matrix Kronecker

variable {d n : Type*} [Fintype d] [Fintype n] [DecidableEq d] [DecidableEq n]
variable {R : Type*} [CommSemiring R]

def T_int (A : Matrix d d R) : Matrix (d × n) (d × n) R :=
  A ⊗ₖ (1 : Matrix n n R)

def T_ext (B : Matrix n n R) : Matrix (d × n) (d × n) R :=
  (1 : Matrix d d R) ⊗ₖ B

theorem commutativity (A : Matrix d d R) (B : Matrix n n R) :
    T_int A * T_ext B = T_ext B * T_int A := by
  unfold T_int T_ext
  rw [← mul_kronecker_mul A (1 : Matrix d d R) (1 : Matrix n n R) B]
  rw [← mul_kronecker_mul (1 : Matrix d d R) A B (1 : Matrix n n R)]
  simp

theorem factorization_zero (A : Matrix d d R) (B : Matrix n n R) :
    (T_int A * T_ext B) ^ 0 = (1 : Matrix (d × n) (d × n) R) := by
  simp

end Snuffy.GuardFactorization
