/-
Snuffy — Canon Edition 4.2 working: circuit faults induce local stochastic
noise on the detector graph (review objection 7.2).

Let `φ` send each circuit fault (a location together with its Pauli) to the
detector-graph edge it produces. The edge set of a fault pattern `F` is the
image `φ(F)`. Distinct Paulis at one location exclude each other, so a law
that is local stochastic at rate `p` on locations is local stochastic at rate
`p` on (location, Pauli) pairs.

  * pushLaw, prob_push — the induced law on edge sets, and its events.
  * push_localStochastic — if at most `c` faults produce each edge, the
    induced edge law is local stochastic at rate `c p`. This is the
    hypothesis `Threshold.fail_le_geometric` takes on the detector graph.

For the rotated surface code with the standard CNOT schedule, the enumeration
in `checks/obj7-detector-graph/` gives `c = 52` per edge of the relevant
check type for d = 5 and 7, with maximum degree 12 and circuit distance d.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.Threshold

open Finset

namespace Snuffy.EdgeLaw

open Snuffy.Threshold

variable {Loc E : Type*} [Fintype Loc] [DecidableEq Loc] [Fintype E] [DecidableEq E]

/-- The law of the edge set `φ(F)`. -/
noncomputable def pushLaw (μ : FaultLaw Loc) (φ : Loc → E) : FaultLaw E where
  P S' := ∑ F, if F.image φ = S' then μ.P F else 0
  nonneg S' := sum_nonneg fun F _ => by split_ifs <;> simp [μ.nonneg F]
  sum_one := by
    rw [sum_comm]
    simp only [sum_ite_eq, mem_univ, ite_true]
    exact μ.sum_one

theorem prob_push (μ : FaultLaw Loc) (φ : Loc → E) (A : Finset E → Prop) [DecidablePred A] :
    prob (pushLaw μ φ) A = prob μ (fun F => A (F.image φ)) := by
  unfold prob pushLaw
  simp only
  calc (∑ S', if A S' then ∑ F, (if F.image φ = S' then μ.P F else 0) else 0)
      = ∑ S', ∑ F, (if F.image φ = S' then (if A S' then μ.P F else 0) else 0) := by
        refine sum_congr rfl fun S' _ => ?_
        split_ifs with h
        · rfl
        · simp
    _ = ∑ F, ∑ S', (if F.image φ = S' then (if A S' then μ.P F else 0) else 0) := sum_comm
    _ = ∑ F, if A (F.image φ) then μ.P F else 0 := by
        simp only [sum_ite_eq, mem_univ, ite_true]

/-- **The edge law is local stochastic.** -/
theorem push_localStochastic (μ : FaultLaw Loc) {p : ℝ} (hp : 0 ≤ p) (hμ : LocalStochastic μ p)
    (φ : Loc → E) {c : ℕ} (hc : ∀ e, (univ.filter fun ℓ => φ ℓ = e).card ≤ c) :
    LocalStochastic (pushLaw μ φ) (c * p) := by
  intro S
  rw [prob_push]
  -- sections: choose, for each edge of S, one fault producing it
  set fib : S → Finset Loc := fun e => univ.filter fun ℓ => φ ℓ = e.1
  set secs := Fintype.piFinset fib
  have hinj : ∀ g ∈ secs, (univ.image g).card = S.card := by
    intro g hg
    rw [card_image_of_injective _ ?_, card_univ, Fintype.card_coe]
    intro a b hab
    have ha := (mem_filter.mp (Fintype.mem_piFinset.mp hg a)).2
    have hb := (mem_filter.mp (Fintype.mem_piFinset.mp hg b)).2
    exact Subtype.ext (by rw [← ha, ← hb, hab])
  have hpt : ∀ F, (if S ⊆ F.image φ then μ.P F else 0) ≤
      ∑ g ∈ secs, if univ.image g ⊆ F then μ.P F else 0 := by
    intro F
    split_ifs with hS
    · have hch : ∀ e : S, ∃ ℓ ∈ F, φ ℓ = e.1 := fun e => mem_image.mp (hS e.2)
      choose g hgF hgφ using hch
      have hg : g ∈ secs := Fintype.mem_piFinset.mpr fun e => mem_filter.mpr ⟨mem_univ _, hgφ e⟩
      have hsub : univ.image g ⊆ F := by
        intro ℓ hℓ; obtain ⟨e, -, rfl⟩ := mem_image.mp hℓ; exact hgF e
      have := single_le_sum (f := fun g => if univ.image g ⊆ F then μ.P F else 0)
        (fun g _ => by split_ifs <;> simp [μ.nonneg F]) hg
      simp only [hsub, ↓reduceIte] at this
      exact this
    · exact sum_nonneg fun g _ => by split_ifs <;> simp [μ.nonneg F]
  calc prob μ (fun F => S ⊆ F.image φ)
      ≤ ∑ F, ∑ g ∈ secs, (if univ.image g ⊆ F then μ.P F else 0) := sum_le_sum fun F _ => hpt F
    _ = ∑ g ∈ secs, prob μ (fun F => univ.image g ⊆ F) := by rw [sum_comm]; rfl
    _ ≤ ∑ g ∈ secs, p ^ S.card := by
        refine sum_le_sum fun g hg => ?_
        have := hμ (univ.image g); rwa [hinj g hg] at this
    _ = (secs.card : ℝ) * p ^ S.card := by rw [sum_const, nsmul_eq_mul]
    _ ≤ (c : ℝ) ^ S.card * p ^ S.card := by
        apply mul_le_mul_of_nonneg_right _ (pow_nonneg hp _)
        have hcard : secs.card ≤ c ^ S.card := by
          rw [Fintype.card_piFinset]
          calc ∏ e : S, (fib e).card ≤ ∏ _e : S, c := prod_le_prod fun e _ => hc e.1
            _ = c ^ S.card := by rw [prod_const, card_univ, Fintype.card_coe]
        exact_mod_cast hcard
    _ = ((c : ℝ) * p) ^ S.card := by rw [mul_pow]

end Snuffy.EdgeLaw
