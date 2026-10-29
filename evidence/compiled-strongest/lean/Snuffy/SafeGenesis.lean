/-
Snuffy — Canon Edition v4.1: bridge 12, safe genesis with progress and
indefinite supply.

  * migration_progress — a progress measure `V` with `V' ≤ −c < 0` satisfies
    `V(t) ≤ V(0) − ct`, so migration reaches its target (`V ≤ 0`) by time
    `V(0)/c`.
  * safe_genesis — the commissioning trajectory stays safe for all time
    (barrier `h' + κh ≥ 0`, `AnalyticBridge`), reaches its target by `V(0)/c`,
    and, with every maintenance window funded (stewardship balance `≥ 0`,
    K1), its reserve never falls below the initial reserve at any window:
    safety, progress and indefinite supply together.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.AnalyticBridge
import Snuffy.FinalClosure

open Set

namespace Snuffy.SafeGenesis

/-- **Progress.** `V' ≤ −c` gives `V(t) ≤ V(0) − ct`. -/
theorem migration_progress (V V' : ℝ → ℝ) {c : ℝ} (hV : ∀ t, HasDerivAt V (V' t) t)
    (hprog : ∀ t, V' t ≤ -c) (t : ℝ) (ht : 0 ≤ t) : V t ≤ V 0 - c * t := by
  have hg : ∀ s, HasDerivAt (fun s => V s + c * s) (V' s + c) s := fun s => by
    have := (hV s).add ((hasDerivAt_id' s).const_mul c)
    convert this using 1
    ring
  have hanti : Antitone (fun s => V s + c * s) :=
    antitone_of_deriv_nonpos (fun s => (hg s).differentiableAt)
      (fun s => by rw [(hg s).deriv]; linarith [hprog s])
  have := hanti ht
  simp only [mul_zero, add_zero] at this
  linarith

/-- **Safe genesis.** Safety for all time, the target reached by `V(0)/c`, and
the reserve sustained at every funded window. -/
theorem safe_genesis (h h' V V' : ℝ → ℝ) {κ c : ℝ} (hc : 0 < c)
    (hh : ∀ t ∈ Ici (0 : ℝ), HasDerivAt h (h' t) t) (hbar : ∀ t ∈ Ici (0 : ℝ), 0 ≤ h' t + κ * h t)
    (h0 : 0 ≤ h 0) (hV : ∀ t, HasDerivAt V (V' t) t) (hprog : ∀ t, V' t ≤ -c) (hV0 : 0 ≤ V 0)
    (S₀ : ℝ) (k : ℕ → ℝ) (hk : ∀ i, 0 ≤ k i) :
    (∀ t, 0 ≤ t → 0 ≤ h t) ∧ V (V 0 / c) ≤ 0 ∧ ∀ n, S₀ ≤ Snuffy.FinalClosure.stock S₀ k n := by
  refine ⟨fun t ht => GeminiThirteenAnalysis.linear_barrier_preserves_safety h h' κ hh hbar h0 t ht,
    ?_, Snuffy.FinalClosure.stewardship_sustains S₀ k hk⟩
  have := migration_progress V V' hV hprog (V 0 / c) (div_nonneg hV0 hc.le)
  rw [mul_div_cancel₀ _ hc.ne'] at this
  linarith

end Snuffy.SafeGenesis
