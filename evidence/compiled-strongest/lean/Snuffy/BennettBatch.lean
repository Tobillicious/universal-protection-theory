/-
Snuffy — Canon Edition 4.2 working: premise 5 is forced for batched
administration once the reversible counterpart's non-heat lifecycle cost per
bit is below the irreversible heat per bit (review objection 6, the
parameter step).

Administer `b` merges in one batch. The irreversible option exports heat `Q`,
at least `q` per merged bit (Landauer: `q ≥ k_B T ln 2`), so `Q ≥ q b`. The
implemented Bennett counterpart's complete non-heat lifecycle charge is
`H ≤ η b`: provisioning, archive writes and holding, routing, reset, guard,
controller, verification and endpoints. Its drive constant is at most `a`.
`BennettExact` forces premise 5 inside the window `0 < Q − H` and
`A/(Q − H) < τ_max`.

  * batched_window — if `η < q`, every batch of at least `b₀` merges lies
    inside the window, for every deadline `τ_max > 0`.
  * premise5_batched — for such batches, no aligned option administers
    irreversibly.

The remaining physical input is the single inequality `η < q`: the
reversible counterpart's per-bit overhead stays below the irreversible heat
per bit. Adiabatic logic below `k_B T ln 2` per operation meets it.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.BennettExact

namespace Snuffy.BennettBatch

/-- **Large batches lie inside the adiabatic window.** -/
theorem batched_window {q η a τmax : ℝ} (hqη : η < q) (hτ : 0 < τmax) (ha : 0 ≤ a) :
    ∃ b₀ : ℕ, ∀ b : ℕ, b₀ ≤ b → ∀ Q H A : ℝ, q * b ≤ Q → H ≤ η * b → A ≤ a →
      0 < Q - H ∧ A / (Q - H) < τmax := by
  have hg : 0 < q - η := by linarith
  refine ⟨⌈a / ((q - η) * τmax)⌉₊ + 1, fun b hb Q H A hQ hH hA => ?_⟩
  have hbpos : (0 : ℝ) < b := by
    have : (1 : ℝ) ≤ b := by exact_mod_cast (show 1 ≤ b by omega)
    linarith
  have hceil : a / ((q - η) * τmax) < b := by
    have h1 := Nat.le_ceil (a / ((q - η) * τmax))
    have h2 : ((⌈a / ((q - η) * τmax)⌉₊ : ℕ) : ℝ) + 1 ≤ b := by exact_mod_cast hb
    linarith
  have hgap : (q - η) * b ≤ Q - H := by nlinarith
  have hpos : 0 < (q - η) * b := by positivity
  refine ⟨lt_of_lt_of_le hpos hgap, ?_⟩
  have hab : a < (q - η) * τmax * b := by
    rw [div_lt_iff₀ (by positivity)] at hceil; linarith
  calc A / (Q - H) ≤ a / ((q - η) * b) := by
        apply div_le_div₀ ha hA hpos hgap
    _ < τmax := by
        rw [div_lt_iff₀ hpos]; linarith

open Snuffy.Greatestness Snuffy.BennettExact in
/-- **Premise 5 for batched administration.** -/
theorem premise5_batched {Pol : Type*} {n : ℕ} {L : Fin n → Type*} [∀ i, SemilatticeSup (L i)]
    (Rpol : Set Pol) (out : Pol → ∀ i, L i) (j : Fin n) (stage : ℝ → L j)
    (hstage : StrictMono stage) (base : Pol → ℝ) {q η a τmax : ℝ} (hqη : η < q) (hτ : 0 < τmax)
    (ha : 0 ≤ a) :
    ∃ b₀ : ℕ, ∀ b : ℕ, b₀ ≤ b → ∀ {B Q A H : ℝ}, 0 ≤ A → q * b ≤ Q → H ≤ η * b → A ≤ a →
      ∀ pol ∈ Rpol, base pol + Q ≤ B →
      ¬ Aligned (feasible Rpol out j stage base B Q A H τmax)
          (tuple out j stage base B Q A H (pol, .irreversible)) := by
  obtain ⟨b₀, hb₀⟩ := batched_window hqη hτ ha
  refine ⟨b₀, fun b hb B Q A H hA0 hQ hH hA pol hpol hB ho => ?_⟩
  obtain ⟨hgap, hwin⟩ := hb₀ b hb Q H A hQ hH hA
  exact premise5_exact Rpol out j stage hstage base hA0 hτ hgap hwin pol hpol hB ho

end Snuffy.BennettBatch
