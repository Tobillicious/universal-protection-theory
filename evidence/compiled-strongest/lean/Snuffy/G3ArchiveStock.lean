/-
Snuffy — Canon Edition 4.2 working: archive holding is charged on the held
stock, not on the write rate (G3; review objection 5, archive holding).

The holding charge at step `s` is the per-bit-step rate `γ` times the number of
bits actually held at `s`. Two stock profiles are distinguished.

  * live_stock_bill — when the held stock is the record's information `I₀` plus
    the live boundary transcript, at most `c (s+1)^(d−1)`, the summed holding
    charge is at most `γ (I₀ + c) t^d` for every `d ≥ 1`, including `d = 1`.
  * retained_stock_quadratic — when every transcript increment is retained,
    the stock is at least `r s` (`r` bits per step) and the summed charge is at least
    `γ r t (t − 1) / 2`.
  * rollover_quadratic — an epoch-rollover archive that copies the whole
    accumulated stock into fresh media at each of `N` epoch boundaries, at `η`
    per bit, pays at least `η r T N (N − 1) / 2`: quadratic in age, the same
    order as constant-rate refresh.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.G3GoodEvent

namespace Snuffy.G3ArchiveStock

/-- **Live-stock holding bill.** -/
theorem live_stock_bill (γ I₀ c d t : ℕ) (hd : 1 ≤ d) (stock : ℕ → ℕ)
    (hstock : ∀ s < t, stock s ≤ I₀ + c * (s + 1) ^ (d - 1)) :
    (Finset.range t).sum (fun s => γ * stock s) ≤ γ * (I₀ + c) * t ^ d := by
  have hterm : ∀ s ∈ Finset.range t, γ * stock s ≤ γ * (I₀ + c * t ^ (d - 1)) := by
    intro s hs
    have hs' := Finset.mem_range.mp hs
    apply Nat.mul_le_mul_left
    calc stock s ≤ I₀ + c * (s + 1) ^ (d - 1) := hstock s hs'
      _ ≤ I₀ + c * t ^ (d - 1) := by
        apply Nat.add_le_add_left
        exact Nat.mul_le_mul_left _ (Nat.pow_le_pow_left hs' _)
  calc (Finset.range t).sum (fun s => γ * stock s)
      ≤ (Finset.range t).sum (fun _ => γ * (I₀ + c * t ^ (d - 1))) := Finset.sum_le_sum hterm
    _ = t * (γ * (I₀ + c * t ^ (d - 1))) := by simp
    _ = γ * I₀ * t + γ * c * (t * t ^ (d - 1)) := by ring
    _ = γ * I₀ * t + γ * c * t ^ d := by
        rw [← pow_succ', Nat.sub_add_cancel hd]
    _ ≤ γ * I₀ * t ^ d + γ * c * t ^ d := by
        apply Nat.add_le_add_right
        exact Nat.mul_le_mul_left _ (Nat.le_self_pow (by omega) t)
    _ = γ * (I₀ + c) * t ^ d := by ring

/-- **Retaining every increment makes holding quadratic.** -/
theorem retained_stock_quadratic (γ r t : ℕ) (stock : ℕ → ℕ)
    (hstock : ∀ s < t, r * s ≤ stock s) :
    γ * r * (t * (t - 1)) ≤ 2 * (Finset.range t).sum (fun s => γ * stock s) := by
  have h : (Finset.range t).sum (fun s => γ * r * s) ≤
      (Finset.range t).sum (fun s => γ * stock s) := by
    apply Finset.sum_le_sum
    intro s hs
    rw [mul_assoc]
    exact Nat.mul_le_mul_left _ (hstock s (Finset.mem_range.mp hs))
  have hid := Finset.sum_range_id_mul_two t
  calc γ * r * (t * (t - 1)) = 2 * (Finset.range t).sum (fun s => γ * r * s) := by
        rw [← Finset.mul_sum, ← hid]; ring
    _ ≤ 2 * (Finset.range t).sum (fun s => γ * stock s) := Nat.mul_le_mul_left _ h

/-- **Epoch rollover of the whole stock is quadratic in age.** At boundary `k`
the archive copies the stock accumulated over `k` epochs of length `T`. -/
theorem rollover_quadratic (η r T N : ℕ) (stock : ℕ → ℕ)
    (hstock : ∀ k < N, r * (k * T) ≤ stock (k * T)) :
    η * r * T * (N * (N - 1)) ≤
      2 * (Finset.range N).sum (fun k => η * stock (k * T)) := by
  have h := retained_stock_quadratic η (r * T) N (fun k => stock (k * T))
    (fun k hk => (show r * T * k = r * (k * T) by ring) ▸ hstock k hk)
  calc η * r * T * (N * (N - 1)) = η * (r * T) * (N * (N - 1)) := by ring
    _ ≤ _ := h

end Snuffy.G3ArchiveStock
