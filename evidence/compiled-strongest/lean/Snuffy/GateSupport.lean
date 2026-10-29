import Mathlib.Algebra.Star.Basic
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.NoncommRing

/-! A structural gate condition preserving a protected operator subspace.
Trace preservation is not used as a substitute for this condition.
The result applies, in particular, to finite real or complex matrices. -/
namespace GeminiThirteenGate
open scoped BigOperators
variable {R : Type*} [Ring R] [StarRing R]

theorem kraus_branch_preserves_support (p k rho : R)
    (selfAdjoint : star p=p) (gate : p*k*p=k*p)
    (supported : p*rho*p=rho) :
    p*(k*rho*star k)*p=k*rho*star k := by
  have adjointGate : p*star k*p=p*star k := by
    simpa only [star_mul,selfAdjoint,mul_assoc] using congrArg star gate
  calc
    p*(k*rho*star k)*p = p*k*(p*rho*p)*star k*p := by rw [supported]; noncomm_ring
    _ = (p*k*p)*rho*(p*star k*p) := by noncomm_ring
    _ = (k*p)*rho*(p*star k) := by rw [gate,adjointGate]
    _ = k*(p*rho*p)*star k := by noncomm_ring
    _ = k*rho*star k := by rw [supported]

theorem kraus_sum_preserves_support {I : Type*} (branches : Finset I)
    (p rho : R) (k : I → R) (selfAdjoint : star p=p)
    (gate : ∀ i ∈ branches, p*k i*p=k i*p)
    (supported : p*rho*p=rho) :
    p*(∑ i ∈ branches, k i*rho*star (k i))*p=
      ∑ i ∈ branches, k i*rho*star (k i) := by
  rw [Finset.mul_sum,Finset.sum_mul]
  apply Finset.sum_congr rfl
  intro i hi
  exact kraus_branch_preserves_support p (k i) rho selfAdjoint (gate i hi) supported

omit [StarRing R] in
theorem support_preservation_composes (p : R) (first second : R → R)
    (firstSafe : ∀ rho, p*rho*p=rho → p*(first rho)*p=first rho)
    (secondSafe : ∀ rho, p*rho*p=rho → p*(second rho)*p=second rho)
    (rho : R) (supported : p*rho*p=rho) :
    p*(second (first rho))*p=second (first rho) :=
  secondSafe (first rho) (firstSafe rho supported)

end GeminiThirteenGate

