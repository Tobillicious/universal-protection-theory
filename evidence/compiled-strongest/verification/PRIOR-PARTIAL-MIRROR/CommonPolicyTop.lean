import Snuffy.FiniteCharacter

/-!
# One policy realising the top in every world (finding 13, greatestness form)

Facts may be indexed by world, as in `CommonPolicyMaximal`. Suppose the policy space is
compact with closed realisation sets, and **union-closed**: any two policies can be
combined into one realising everything either realises (the canon's concurrent-emulation
premise, derived from locality in G.9 by block splicing, `G2Splice`). Then:

* `top_policy_exists` — a single policy realises the union of all policies' outcomes;
* `top_policy_greatest` — its outcome contains every realisable outcome stage by stage,
  so no realisable outcome is better in the law's order: it is the greatest, in every
  world at once.
-/

namespace Snuffy.CommonPolicyTop

open Snuffy.StagedMaximality Snuffy.FiniteCharacter

variable {α Pol : Type*} [TopologicalSpace Pol] [CompactSpace Pol] [Nonempty Pol]

theorem top_policy_exists (out : Pol → Set α)
    (hclosed : ∀ a, IsClosed {q | a ∈ out q})
    (hunion : ∀ q₁ q₂ : Pol, ∃ q, out q₁ ∪ out q₂ ⊆ out q) :
    ∃ q, ∀ q', out q' ⊆ out q := by
  classical
  have hfin : ∀ F : Finset α, (↑F : Set α) ⊆ ⋃ q', out q' → ∃ q, (↑F : Set α) ⊆ out q := by
    intro F
    refine Finset.induction_on F ?_ ?_
    · intro _
      obtain ⟨q⟩ := (inferInstance : Nonempty Pol)
      exact ⟨q, by simp⟩
    · intro a F _ ih hF
      obtain ⟨qF, hqF⟩ := ih (fun x hx => hF (by simp [hx]))
      obtain ⟨qa, hqa⟩ : ∃ q, a ∈ out q := by
        have := hF (by simp : a ∈ (↑(insert a F) : Set α))
        simpa using this
      obtain ⟨q, hq⟩ := hunion qa qF
      refine ⟨q, fun x hx => ?_⟩
      rcases Finset.mem_insert.mp hx with rfl | hx
      · exact hq (Or.inl hqa)
      · exact hq (Or.inr (hqF hx))
  obtain ⟨q, hq⟩ := (realisable_iff_finite out hclosed (⋃ q', out q')).mpr hfin
  exact ⟨q, fun q' => (Set.subset_iUnion out q').trans hq⟩

/-- The top policy's outcome contains every realisable outcome stage by stage, so no
realisable outcome is strictly better in the law's order. -/
theorem top_policy_greatest (stage : α → ℕ) (out : Pol → Set α)
    (hclosed : ∀ a, IsClosed {q | a ∈ out q})
    (hunion : ∀ q₁ q₂ : Pol, ∃ q, out q₁ ∪ out q₂ ⊆ out q) :
    ∃ q, ∀ t : Set α, (∃ q', t ⊆ out q') →
      t ⊆ out q ∧ ¬ LexBetter stage (out q) t := by
  obtain ⟨q, hq⟩ := top_policy_exists out hclosed hunion
  refine ⟨q, fun t ⟨q', ht⟩ => ⟨ht.trans (hq q'), ?_⟩⟩
  rintro ⟨k, -, hlt⟩
  obtain ⟨b, hbt, hbq⟩ := Set.exists_of_ssubset hlt
  exact hbq ⟨(ht.trans (hq q')) hbt.1, hbt.2⟩

end Snuffy.CommonPolicyTop
