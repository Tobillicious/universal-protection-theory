/-
Snuffy — Canon Edition 4.2 working: the smeared boundary reconstruction is
exact (G.4, the integral step).

For a complete operator basis of the historical code's algebra and any real
weight with total integral one, the smeared dual-kernel expression is, at
every flow parameter, the original operator (`historical_dual_kernel`).
Its Bochner integral is therefore the operator itself, on the bulk algebra and
after boundary transport.

  * smeared_reconstruction — `∫ w(s) Σ_j c_j(s) σ_s(B_j) ds = A`.
  * smeared_boundary_reconstruction — the same for the boundary representative
    `α(A)`.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.DecoderRetraction
import Mathlib.MeasureTheory.Integral.Bochner.Basic

open MeasureTheory

namespace Snuffy.SmearingIntegral

open Snuffy.DecoderRetraction

universe u v

variable {H : Type u} {B : Type v}
variable [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable [NormedAddCommGroup B] [InnerProductSpace ℂ B] [CompleteSpace B]

theorem smeared_reconstruction {ι : Type*} [Fintype ι]
    (b : Module.Basis ι ℂ (H →L[ℂ] H)) (G A : H →L[ℂ] H) (z : ℝ → ℂ) (w : ℝ → ℝ)
    (hw : ∫ s, w s = 1) :
    ∫ s, w s • (∑ i, b.repr (historicalFlow G A (-(z s))) i • historicalFlow G (b i) (z s)) = A := by
  simp_rw [historical_dual_kernel]
  rw [integral_smul_const, hw, one_smul]

theorem smeared_boundary_reconstruction {ι : Type*} [Fintype ι]
    (E : H →ₗᵢ[ℂ] B) (b : Module.Basis ι ℂ (H →L[ℂ] H)) (G A : H →L[ℂ] H) (z : ℝ → ℂ)
    (w : ℝ → ℝ) (hw : ∫ s, w s = 1) :
    ∫ s, w s • boundaryObservable E
      (∑ i, b.repr (historicalFlow G A (-(z s))) i • historicalFlow G (b i) (z s)) =
      boundaryObservable E A := by
  simp_rw [historical_dual_kernel]
  rw [integral_smul_const, hw, one_smul]

end Snuffy.SmearingIntegral
