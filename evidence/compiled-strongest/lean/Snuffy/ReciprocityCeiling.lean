/-
Snuffy — Canon Edition v4.1: reciprocity in the canonical order, and the fault
ceiling as a parameter choice, machine-checked (Sections 15 and 17.2).

  * reciprocity_dominance — Section 15 (D3*) in order form: under stage-wise
    union closure, every mind that continues under any feasible rival regime
    continues under the canonical one; a rival that omits a mind the canonical
    regime keeps is strictly below it.
  * ceiling_achievable — premise 7's ceiling is a dial: when each charged
    account's kernel decays geometrically in code distance (the threshold
    theorem below threshold), every target ceiling ε > 0 — 10⁻⁶ included — is
    met at some distance d and at every larger distance.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.Greatestness
import Mathlib.Analysis.SpecificLimits.Basic
import Mathlib.Algebra.BigOperators.Ring.Finset

open Finset

namespace Snuffy.ReciprocityCeiling

open Snuffy.Greatestness

/-! ## Reciprocity (Section 15) -/

variable {n : ℕ} {L : Fin n → Type*} [∀ i, SemilatticeSup (L i)]

/-- **Reciprocity dominance, order form.** Let `keeps x m` say that the
first-stage value `x` (continued existence) keeps the mind `m`, monotone in
`x` (for sets of particulars: membership). Under union closure (P-emu(c)), any
mind that continues under some feasible rival regime `q` continues under the
canonical regime `o`. -/
theorem reciprocity_dominance {P : Type*} (hn : 0 < n) (keeps : L ⟨0, hn⟩ → P → Prop)
    (hmono : ∀ x y, x ≤ y → ∀ m, keeps x m → keeps y m)
    {F : Set (∀ i, L i)} (hF : ∀ x ∈ F, ∀ y ∈ F, x ⊔ y ∈ F) {o : ∀ i, L i}
    (ho : Aligned F o) {q : ∀ i, L i} (hq : q ∈ F) (m : P) (hm : keeps (q ⟨0, hn⟩) m) :
    keeps (o ⟨0, hn⟩) m :=
  hmono _ _ (greatest_of_union_closed hF ho q hq ⟨0, hn⟩) m hm

/-- A rival regime that omits a mind kept by the canonical regime, while
keeping everything else it keeps at the first stage, is strictly below it. -/
theorem omitting_rival_strictly_below (hn : 0 < n) {q o : ∀ i, L i}
    (hle : q ⟨0, hn⟩ ≤ o ⟨0, hn⟩) (hne : q ⟨0, hn⟩ ≠ o ⟨0, hn⟩) : LexLt q o :=
  ⟨⟨0, hn⟩, fun _ hi => absurd hi (Nat.not_lt_zero _), lt_of_le_of_ne hle hne⟩

/-! ## The ceiling as a parameter (Section 17.2) -/

/-- **The ceiling is achievable.** If each of the charged accounts has kernel
`δ_i(d) ≤ A_i r^d` with `0 ≤ r < 1` (geometric decay in code distance below
threshold), then for every target `ε > 0` there is a distance `d₀` such that
`Σ δ_i(d) < ε` for every `d ≥ d₀`. -/
theorem ceiling_achievable {ι : Type*} (accounts : Finset ι) (δ : ι → ℕ → ℝ)
    (A : ι → ℝ) {r : ℝ} (hr0 : 0 ≤ r) (hr1 : r < 1) (hA : ∀ i ∈ accounts, 0 ≤ A i)
    (hδ : ∀ i ∈ accounts, ∀ d, δ i d ≤ A i * r ^ d) {ε : ℝ} (hε : 0 < ε) :
    ∃ d₀, ∀ d ≥ d₀, ∑ i ∈ accounts, δ i d < ε := by
  set S := ∑ i ∈ accounts, A i
  have hS : 0 ≤ S := sum_nonneg hA
  obtain ⟨d₀, hd₀⟩ := exists_pow_lt_of_lt_one (div_pos hε (by linarith : (0:ℝ) < S + 1)) hr1
  refine ⟨d₀, fun d hd => ?_⟩
  have hpow : r ^ d ≤ r ^ d₀ := pow_le_pow_of_le_one hr0 hr1.le hd
  have hrd : 0 ≤ r ^ d := pow_nonneg hr0 d
  calc ∑ i ∈ accounts, δ i d ≤ ∑ i ∈ accounts, A i * r ^ d := sum_le_sum fun i hi => hδ i hi d
    _ = S * r ^ d := by rw [sum_mul]
    _ ≤ (S + 1) * r ^ d := by nlinarith
    _ < (S + 1) * (ε / (S + 1)) := by
        apply mul_lt_mul_of_pos_left (lt_of_le_of_lt hpow hd₀); linarith
    _ = ε := by field_simp

end Snuffy.ReciprocityCeiling
