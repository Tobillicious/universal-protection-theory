/-
Snuffy — Canon Edition v4.1: bridge 6, correlated risk from the stress
process. Faults are produced by shocks: shock `σ` damages the locations
`cover σ`, at most `k` of them (bounded footprint, common causes included).
The shocks fired are a law on shock sets that is local stochastic with rate
`q` (`Threshold.LocalStochastic`; no independence assumed).

  * correlated_stress — for every set `S` of locations, the probability that
    all of `S` is damaged is at most `C(|N(S)|, ⌊|S|/k⌋) q^⌊|S|/k⌋`, where
    `N(S)` is the set of shocks touching `S`. Correlated, common-cause damage
    is still suppressed exponentially in `|S|/k`.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.Threshold

open Finset

namespace Snuffy.CorrelatedStress

open Snuffy.Threshold

variable {Loc Shock : Type*} [DecidableEq Loc] [Fintype Shock] [DecidableEq Shock]

/-- Shocks touching `S`. -/
def near (cover : Shock → Finset Loc) (S : Finset Loc) : Finset Shock :=
  univ.filter fun σ => (cover σ ∩ S).Nonempty

omit [DecidableEq Shock] in
/-- If the fired shocks damage all of `S`, they contain `⌊|S|/k⌋` shocks
touching `S`. -/
lemma many_touching (cover : Shock → Finset Loc) {k : ℕ} (hk : ∀ σ, (cover σ).card ≤ k)
    {S : Finset Loc} {G : Finset Shock} (hS : S ⊆ G.biUnion cover) :
    ∃ T ∈ powersetCard (S.card / k) (near cover S), T ⊆ G := by
  set T₀ := G.filter fun σ => (cover σ ∩ S).Nonempty
  have hcov : S ⊆ T₀.biUnion fun σ => cover σ ∩ S := by
    intro x hx
    obtain ⟨σ, hσ, hxσ⟩ := mem_biUnion.mp (hS hx)
    exact mem_biUnion.mpr ⟨σ, mem_filter.mpr ⟨hσ, ⟨x, mem_inter.mpr ⟨hxσ, hx⟩⟩⟩,
      mem_inter.mpr ⟨hxσ, hx⟩⟩
  have hcard : S.card ≤ k * T₀.card := by
    calc S.card ≤ (T₀.biUnion fun σ => cover σ ∩ S).card := card_le_card hcov
      _ ≤ ∑ σ ∈ T₀, (cover σ ∩ S).card := card_biUnion_le
      _ ≤ ∑ _σ ∈ T₀, k := sum_le_sum fun σ _ => (card_le_card inter_subset_left).trans (hk σ)
      _ = k * T₀.card := by rw [sum_const, smul_eq_mul, mul_comm]
  obtain ⟨T, hT, hTc⟩ := exists_subset_card_eq (Nat.div_le_of_le_mul hcard)
  refine ⟨T, mem_powersetCard.mpr ⟨fun σ hσ => ?_, hTc⟩, fun σ hσ => (mem_filter.mp (hT hσ)).1⟩
  exact mem_filter.mpr ⟨mem_univ _, (mem_filter.mp (hT hσ)).2⟩

/-- **Correlated stress.** Bounded-footprint shocks, local stochastic at rate
`q`, damage all of `S` with probability at most
`C(|N(S)|, ⌊|S|/k⌋) q^⌊|S|/k⌋`. -/
theorem correlated_stress (ν : FaultLaw Shock) {q : ℝ} (hν : LocalStochastic ν q)
    (cover : Shock → Finset Loc) {k : ℕ} (hk : ∀ σ, (cover σ).card ≤ k) (S : Finset Loc) :
    prob ν (fun G => S ⊆ G.biUnion cover) ≤
      ((near cover S).card.choose (S.card / k) : ℝ) * q ^ (S.card / k) := by
  set t := S.card / k
  set N := near cover S
  have hind : ∀ G, (if S ⊆ G.biUnion cover then ν.P G else 0)
      ≤ ∑ T ∈ powersetCard t N, if T ⊆ G then ν.P G else 0 := by
    intro G
    split_ifs with h
    · obtain ⟨T, hT, hTG⟩ := many_touching cover hk h
      calc ν.P G = if T ⊆ G then ν.P G else 0 := by simp [hTG]
        _ ≤ ∑ T ∈ powersetCard t N, if T ⊆ G then ν.P G else 0 :=
          single_le_sum (f := fun T => if T ⊆ G then ν.P G else 0)
            (fun T _ => by split_ifs <;> simp [ν.nonneg G]) hT
    · exact sum_nonneg fun T _ => by split_ifs <;> simp [ν.nonneg G]
  calc prob ν (fun G => S ⊆ G.biUnion cover)
      ≤ ∑ G, ∑ T ∈ powersetCard t N, if T ⊆ G then ν.P G else 0 := sum_le_sum fun G _ => hind G
    _ = ∑ T ∈ powersetCard t N, prob ν (fun G => T ⊆ G) := by rw [sum_comm]; rfl
    _ ≤ ∑ T ∈ powersetCard t N, q ^ t := by
        refine sum_le_sum fun T hT => ?_
        have := hν T
        rwa [(mem_powersetCard.mp hT).2] at this
    _ = (N.card.choose t : ℝ) * q ^ t := by rw [sum_const, card_powersetCard, nsmul_eq_mul]

end Snuffy.CorrelatedStress
