/-
Snuffy — Canon Edition 4.2 working: the wavefront's local correction is
finite-code decoding of the patch (G3 joined to the holding decoder).

The single-shot local correction of a vertex reads its patch — the static
gauge-fixed boundary of the recovered interior together with the vertex's own
local data — decodes that read-out with the nearest-codeword decoder, and
extracts the vertex's value. If, with the interior recovered, the read-out
lies within the unique-decoding radius of the codeword encoding the target
(the patch's errors within the code headroom, `E9SelfHealing.code_headroom`),
decoding returns that codeword (`Bridge.nearest_decodes`).

  * patch_correction_succeeds — the hypothesis `hcorr` of
    `G3Sweep.sweep_recovers` is derived.
  * patch_sweep_bill — `G3Sweep.sweep_bill` with the local correction given
    by patch decoding: recovery succeeds on the whole region and the complete
    bill is at most an age-independent constant times `t^d`.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.G3Sweep
import Snuffy.Bridge

namespace Snuffy.G3PatchDecode

open Snuffy.G3Sweep Snuffy.G3CompleteBill

variable {V Val X : Type*} [MetricSpace X]

/-- The local correction: decode the patch read-out and extract the value. -/
def patchCorr (read : V → (V → Val) → X) (dec : X → X) (extract : V → X → Val) :
    V → (V → Val) → Val :=
  fun v s => extract v (dec (read v s))

/-- **The local correction succeeds against a recovered interior.** -/
theorem patch_correction_succeeds {Code : Set X} {dmin t : ℝ}
    (hsep : ∀ c ∈ Code, ∀ c' ∈ Code, c ≠ c' → dmin ≤ dist c c') (ht : 2 * t < dmin)
    {dec : X → X} (hdecC : ∀ y, dec y ∈ Code)
    (hnear : ∀ y, ∀ c ∈ Code, dist y (dec y) ≤ dist y c)
    (layer : V → ℕ) (target : V → Val) (read : V → (V → Val) → X) (extract : V → X → Val)
    (enc : V → X) (henc : ∀ v, enc v ∈ Code) (hext : ∀ v, extract v (enc v) = target v)
    (hradius : ∀ v s, (∀ u, layer u < layer v → s u = target u) → dist (read v s) (enc v) ≤ t) :
    ∀ v s, (∀ u, layer u < layer v → s u = target u) →
      patchCorr read dec extract v s = target v := by
  intro v s h
  unfold patchCorr
  rw [Snuffy.Bridge.nearest_decodes hsep ht hdecC hnear (henc v) (hradius v s h), hext]

/-- **G3 with patch decoding.** Recovery succeeds on the whole region and the
complete bill is at most an age-independent constant times `t^d`. -/
theorem patch_sweep_bill {Code : Set X} {dmin rad : ℝ}
    (hsep : ∀ c ∈ Code, ∀ c' ∈ Code, c ≠ c' → dmin ≤ dist c c') (hrad : 2 * rad < dmin)
    {dec : X → X} (hdecC : ∀ y, dec y ∈ Code)
    (hnear : ∀ y, ∀ c ∈ Code, dist y (dec y) ≤ dist y c)
    (layer : V → ℕ) (target : V → Val) (read : V → (V → Val) → X) (extract : V → X → Val)
    (enc : V → X) (henc : ∀ v, enc v ∈ Code) (hext : ∀ v, extract v (enc v) = target v)
    (hradius : ∀ v s, (∀ u, layer u < layer v → s u = target u) → dist (read v s) (enc v) ≤ rad)
    (outer : ℕ → (V → Val) → (V → Val)) (s₀ : V → Val)
    (hfence : ∀ k s v, layer v < k → outer k s v = s v)
    (R : ℕ → ℕ) (c r : ℕ) (hspread : ∀ t, R t ≤ c * t + r)
    (cost : ℕ → ℕ) (rollback : ℕ → Bool) (reset fixed α β d t : ℕ)
    (hd : 1 ≤ d) (ht : 1 ≤ t) (hR : 1 ≤ R t)
    (hcost : ∀ k ∈ Finset.range (R t), cost (k + 1) ≤ α * (k + 1) ^ (d - 1) + β) :
    (∀ v, layer v < R t →
      sweep layer (patchCorr read dec extract) outer s₀ (R t) v = target v) ∧
      cumulativeCharge cost rollback reset fixed (R t) ≤
        ((fixed + α + β + reset) * (c + r) ^ d) * t ^ d :=
  sweep_bill layer (patchCorr read dec extract) outer s₀ target
    (patch_correction_succeeds hsep hrad hdecC hnear layer target read extract enc henc hext
      hradius)
    hfence R c r hspread cost rollback reset fixed α β d t hd ht hR hcost

end Snuffy.G3PatchDecode
