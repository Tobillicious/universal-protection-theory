import Snuffy.G3ArchiveStock
import Snuffy.G3PatchDecode

/-!
# G3 constructive recovery + charged archive

A thin composition of existing constructive G3 lemmas. Does not change the
original six X3 or existing G3 definitions. Source-level draft pending CI.
-/

namespace Snuffy.G3ConstructiveFullBillJoin

open Snuffy.G3ArchiveStock Snuffy.G3GoodEvent Snuffy.G3PatchDecode
open Snuffy.G3Sweep Snuffy.G3CompleteBill

variable {V Val X : Type*} [MetricSpace X]

/-- Recovery with patch decoding, plus all charged sweep work and live archive
holding. The archive stock parameter is independent of the wave spread. -/
theorem recovered_with_charged_archive
    {Code : Set X} {dmin rad : ℝ}
    (hsep : ∀ c ∈ Code, ∀ c' ∈ Code, c ≠ c' → dmin ≤ dist c c')
    (hrad : 2 * rad < dmin)
    {dec : X → X} (hdecC : ∀ y, dec y ∈ Code)
    (hnear : ∀ y, ∀ c ∈ Code, dist y (dec y) ≤ dist y c)
    (layer : V → ℕ) (target : V → Val)
    (read : V → (V → Val) → X) (extract : V → X → Val)
    (enc : V → X) (henc : ∀ v, enc v ∈ Code)
    (hext : ∀ v, extract v (enc v) = target v)
    (hradius : ∀ v s,
      (∀ u, layer u < layer v → s u = target u) →
        dist (read v s) (enc v) ≤ rad)
    (outer : ℕ → (V → Val) → (V → Val)) (s₀ : V → Val)
    (hfence : ∀ k s v, layer v < k → outer k s v = s v)
    (R : ℕ → ℕ) (c r : ℕ) (hspread : ∀ t, R t ≤ c * t + r)
    (cost : ℕ → ℕ) (rollback : ℕ → Bool)
    (reset fixed α β d t : ℕ)
    (hd : 1 ≤ d) (ht : 1 ≤ t) (hR : 1 ≤ R t)
    (hcost : ∀ k ∈ Finset.range (R t),
      cost (k + 1) ≤ α * (k + 1) ^ (d - 1) + β)
    (stock : ℕ → ℕ) (γ I₀ cStock : ℕ)
    (hstock : ∀ s < t, stock s ≤ I₀ + cStock * (s + 1) ^ (d - 1)) :
    (∀ v, layer v < R t →
      sweep layer (patchCorr read dec extract) outer s₀ (R t) v = target v) ∧
    cumulativeCharge cost rollback reset fixed (R t) +
      (Finset.range t).sum (fun s => γ * stock s) ≤
      (((fixed + α + β + reset) * (c + r) ^ d) +
        γ * (I₀ + cStock)) * t ^ d := by
  obtain ⟨hRecovery, hSweepBill⟩ :=
    patch_sweep_bill hsep hrad hdecC hnear layer target read extract
      enc henc hext hradius outer s₀ hfence R c r hspread
      cost rollback reset fixed α β d t hd ht hR hcost
  have hArchive :=
    live_stock_bill γ I₀ cStock d t hd stock hstock
  exact ⟨hRecovery,
    complete_bill_with_archive
      (cumulativeCharge cost rollback reset fixed (R t))
      (fun s => γ * stock s)
      ((fixed + α + β + reset) * (c + r) ^ d)
      (γ * (I₀ + cStock)) d t hSweepBill hArchive⟩

#print axioms recovered_with_charged_archive

end Snuffy.G3ConstructiveFullBillJoin
