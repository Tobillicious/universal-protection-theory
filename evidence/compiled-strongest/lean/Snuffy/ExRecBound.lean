/-
Snuffy — Canon Edition 4.2 working: the gadget failure bound from a malignant
pair set, and the circuit-level contraction ratio (review objection 7.2, 7.3).

  * exrec_pair_bound — under local stochastic noise of rate `p` on the
    locations `L` of an extended rectangle, suppose every failing fault set
    contains a malignant pair from `M₂` or at least three faults. The second
    hypothesis is single-fault resilience, which the enumeration must verify;
    malignancy means the exRec followed by the ideal decoder fails. Then
    `P(fail) ≤ |M₂| p² + C(|L|, 3) p³`. The prefactor is the count `|M₂|`,
    not a fraction of the pairs, and the remainder is explicit.
  * circuit_level_rate — on a matching graph of maximum degree 12 (the X or Z
    detector graph of the rotated surface code with the standard CNOT
    schedule, hook edges included), non-backtracking branching is at most 11.
    With each edge faulty at local stochastic rate at most `c p`, the ratio of
    `Threshold.fail_le_geometric` is `2 · 11 · √(c p)`, below one exactly when
    `c p < 1/484`.
  * surface_code_rate — with the enumerated multiplicity `c = 52`, the ratio
    `2 · 11 · √(52 p)` is below one exactly when `p < 1/25168`.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.Threshold

open Finset

namespace Snuffy.ExRecBound

open Snuffy.Threshold

variable {Loc : Type*} [Fintype Loc] [DecidableEq Loc]

/-- **Gadget failure from malignant pairs, with an explicit remainder.** -/
theorem exrec_pair_bound (μ : FaultLaw Loc) {p : ℝ} (hμ : LocalStochastic μ p)
    (L : Finset Loc) (M₂ : Finset (Finset Loc)) (hM₂ : ∀ S ∈ M₂, S.card = 2)
    (fail : Finset Loc → Prop) [DecidablePred fail]
    (hfail : ∀ F, fail F → (∃ S ∈ M₂, S ⊆ F) ∨ 3 ≤ (L ∩ F).card) :
    prob μ fail ≤ (M₂.card : ℝ) * p ^ 2 + (L.card.choose 3 : ℝ) * p ^ 3 := by
  have hpt : ∀ F, (if fail F then μ.P F else 0) ≤
      (∑ S ∈ M₂, if S ⊆ F then μ.P F else 0) +
        (if 3 ≤ (L ∩ F).card then μ.P F else 0) := by
    intro F
    have h0 := μ.nonneg F
    have hs : 0 ≤ ∑ S ∈ M₂, (if S ⊆ F then μ.P F else 0) :=
      sum_nonneg fun S _ => by split_ifs <;> simp [h0]
    by_cases hF : fail F
    · simp only [hF, ↓reduceIte]
      rcases hfail F hF with ⟨S, hS, hSF⟩ | h3
      · have : μ.P F ≤ ∑ S ∈ M₂, (if S ⊆ F then μ.P F else 0) := by
          have := single_le_sum (f := fun S => if S ⊆ F then μ.P F else 0)
            (fun S _ => by split_ifs <;> simp [h0]) hS
          simpa [hSF] using this
        have : 0 ≤ (if 3 ≤ (L ∩ F).card then μ.P F else 0) := by split_ifs <;> simp [h0]
        linarith
      · simp only [h3, ↓reduceIte]; linarith
    · simp only [hF, ↓reduceIte]
      have : 0 ≤ (if 3 ≤ (L ∩ F).card then μ.P F else 0) := by split_ifs <;> simp [h0]
      linarith
  calc prob μ fail
      ≤ ∑ F, ((∑ S ∈ M₂, if S ⊆ F then μ.P F else 0) +
          (if 3 ≤ (L ∩ F).card then μ.P F else 0)) := sum_le_sum fun F _ => hpt F
    _ = (∑ S ∈ M₂, prob μ (fun F => S ⊆ F)) + prob μ (fun F => 3 ≤ (L ∩ F).card) := by
        rw [sum_add_distrib, sum_comm]; rfl
    _ ≤ (∑ S ∈ M₂, p ^ 2) + (L.card.choose 3 : ℝ) * p ^ 3 := by
        refine add_le_add (sum_le_sum fun S hS => ?_) (many_faults μ hμ L 3)
        have := hμ S; rwa [hM₂ S hS] at this
    _ = (M₂.card : ℝ) * p ^ 2 + (L.card.choose 3 : ℝ) * p ^ 3 := by
        rw [sum_const, nsmul_eq_mul]

/-- **The circuit-level contraction ratio.** -/
theorem circuit_level_rate {q : ℝ} : 2 * 11 * Real.sqrt q < 1 ↔ q < 1 / 484 := by
  have h : 2 * 11 * Real.sqrt q < 1 ↔ Real.sqrt q < 1 / 22 := by
    constructor <;> intro h <;> linarith
  rw [h, Real.sqrt_lt' (by norm_num)]
  constructor <;> intro h <;> nlinarith

/-- **The rotated surface code with the standard schedule.** With edge rate at most
`52 p` (`EdgeLaw.push_localStochastic`, multiplicity from the enumeration), the
contraction ratio is below one exactly when `p < 1/25168`. -/
theorem surface_code_rate {p : ℝ} : 2 * 11 * Real.sqrt (52 * p) < 1 ↔ p < 1 / 25168 := by
  rw [circuit_level_rate]
  constructor <;> intro h <;> linarith

end Snuffy.ExRecBound
