import Mathlib

/-!
# Pooling with the keeper's own execution noise (Lemma P repair)

UPT-P Setting U: an intended pool fails with probability `ε`, an intended abstention
pools with probability `δ`, `ε + δ < 1`, independently of the others. Let `pHeld1` be
the probability the ender is held when this keeper's contribution is delivered and
`pHeld0` when it is not (others' behaviour, any law). Then

* `noisy_advantage` — intending to pool raises the holding probability by exactly
  `(1 - ε - δ)(pHeld1 - pHeld0)`;
* `noisy_pool_strictly_dominant` — so pooling is strictly better whenever the
  delivered contribution is pivotal with positive probability (`pHeld0 < pHeld1`,
  `OuterLane.pool_strictly_dominant`) and `ε + δ < 1`.
-/

namespace Snuffy.NoisyPooling

/-- Holding probability under an intention, with execution noise. -/
def heldIfPool (ε pHeld1 pHeld0 : ℝ) : ℝ := (1 - ε) * pHeld1 + ε * pHeld0
def heldIfAbstain (δ pHeld1 pHeld0 : ℝ) : ℝ := δ * pHeld1 + (1 - δ) * pHeld0

theorem noisy_advantage (ε δ pHeld1 pHeld0 : ℝ) :
    heldIfPool ε pHeld1 pHeld0 - heldIfAbstain δ pHeld1 pHeld0 =
      (1 - ε - δ) * (pHeld1 - pHeld0) := by
  unfold heldIfPool heldIfAbstain; ring

theorem noisy_pool_strictly_dominant (ε δ pHeld1 pHeld0 : ℝ)
    (hnoise : ε + δ < 1) (hpiv : pHeld0 < pHeld1) :
    heldIfAbstain δ pHeld1 pHeld0 < heldIfPool ε pHeld1 pHeld0 := by
  have h := noisy_advantage ε δ pHeld1 pHeld0
  have : 0 < (1 - ε - δ) * (pHeld1 - pHeld0) := mul_pos (by linarith) (by linarith)
  linarith

end Snuffy.NoisyPooling
