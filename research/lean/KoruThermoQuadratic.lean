import Mathlib

/-!
# Finite coarse-graining: exact quadratic entropy inequality

This module proves an algebraic companion to the four-state Gibbs/Shannon
entropy example. It uses quadratic entropy (also called linear entropy),
NOT Gibbs entropy. The result is unconditional over rational weights;
normalization and nonnegativity are needed for probabilistic interpretation.

The Real.log Gibbs theorem remains a separate obligation.
-/

namespace KoruThermoQuadratic

/-- Sum of squared microscopic weights. -/
def concentration (a b c d : ℚ) : ℚ :=
  a*a + b*b + c*c + d*d

/-- The partition-uniformized two-cell state. -/
def coarseConcentration (a b c d : ℚ) : ℚ :=
  let x := (a+b)/2
  let y := (c+d)/2
  concentration x x y y

/-- Pair averaging cannot increase concentration; exact rational algebra. -/
theorem coarse_concentration_le (a b c d : ℚ) :
    coarseConcentration a b c d ≤ concentration a b c d := by
  unfold coarseConcentration concentration
  nlinarith [sq_nonneg (a-b), sq_nonneg (c-d)]

/-- Quadratic entropy, a separate entropy functional from Gibbs entropy. -/
def quadraticEntropy (a b c d : ℚ) : ℚ :=
  1 - concentration a b c d

theorem coarse_quadratic_entropy_ge (a b c d : ℚ) :
    quadraticEntropy ((a+b)/2) ((a+b)/2) ((c+d)/2) ((c+d)/2) ≥
      quadraticEntropy a b c d := by
  have h := coarse_concentration_le a b c d
  unfold coarseConcentration at h
  unfold quadraticEntropy
  linarith

/-- A permutation preserves the same quadratic entropy exactly. -/
theorem cyclic_quadratic_entropy_invariant (a b c d : ℚ) :
    quadraticEntropy d a b c = quadraticEntropy a b c d := by
  unfold quadraticEntropy concentration
  ring

end KoruThermoQuadratic
