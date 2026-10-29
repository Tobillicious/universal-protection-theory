/-
Snuffy — Canon Edition 4.2 working: from state-vector distance to pure-state
infidelity (§23.3, the norm conversion for Branch A).

For unit vectors the infidelity is bounded by the squared state-vector
distance:

  1 − |⟨ψ, φ⟩|² ≤ ‖ψ − φ‖².

With the standard pure-state identity ½‖ρ − σ‖₁ = √(1 − |⟨ψ, φ⟩|²) for
ρ = |ψ⟩⟨ψ|, σ = |φ⟩⟨φ|, this gives ½‖ρ − σ‖₁ ≤ ‖ψ − φ‖. The speed-limit bounds
of `SpeedLimit` and `Bridge.qsl_growth`, stated in state-vector norm, thereby
bound the infidelity and the trace distance of the held state.

  * pure_infidelity_le — the displayed inequality.
  * pure_fidelity_ge — `1 − ‖ψ − φ‖² ≤ |⟨ψ, φ⟩|²`.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.Analysis.InnerProductSpace.Basic

namespace Snuffy.PureStateDistance

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

theorem pure_infidelity_le (ψ φ : E) (hψ : ‖ψ‖ = 1) (hφ : ‖φ‖ = 1) :
    1 - ‖inner ℂ ψ φ‖ ^ 2 ≤ ‖ψ - φ‖ ^ 2 := by
  have hsq : ‖ψ - φ‖ ^ 2 = ‖ψ‖ ^ 2 - 2 * RCLike.re (inner ℂ ψ φ) + ‖φ‖ ^ 2 :=
    norm_sub_sq (𝕜 := ℂ) ψ φ
  have hre : RCLike.re (inner ℂ ψ φ) ≤ ‖inner ℂ ψ φ‖ := RCLike.re_le_norm _
  have hcs : ‖inner ℂ ψ φ‖ ≤ 1 := by
    calc ‖inner ℂ ψ φ‖ ≤ ‖ψ‖ * ‖φ‖ := norm_inner_le_norm ψ φ
      _ = 1 := by rw [hψ, hφ, one_mul]
  have hn : 0 ≤ ‖inner ℂ ψ φ‖ := norm_nonneg _
  rw [hsq, hψ, hφ]
  nlinarith

theorem pure_fidelity_ge (ψ φ : E) (hψ : ‖ψ‖ = 1) (hφ : ‖φ‖ = 1) :
    1 - ‖ψ - φ‖ ^ 2 ≤ ‖inner ℂ ψ φ‖ ^ 2 := by
  have := pure_infidelity_le ψ φ hψ hφ
  linarith

end Snuffy.PureStateDistance
