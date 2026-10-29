import Snuffy.StagedMaximality

/-!
# Staged maximality with alternative requirements (S2 extension)

`StagedMaximality` handles conjunctive prerequisites (`pre a ⊆ s`). Here each fact `a`
carries a family `alts a` of alternative requirement sets, every member of every
alternative in a strictly earlier stage, and a feasible outcome containing `a` must
contain at least one alternative in full. One alternative gives the conjunctive case;
several give disjunctions ("x needs y, or else z"). The stage-by-stage Zorn argument
goes through unchanged: a chain's union keeps each member's chosen alternative, and
projecting below a stage keeps it because alternatives sit in earlier stages.

* `exists_lex_maximal_alt` — with finitely many stages, finite conflicts, a feasible
  mandatory baseline and alternative requirements in earlier stages, a feasible
  outcome exists that no feasible outcome strictly improves in the law's order.
-/

namespace Snuffy.StagedAlternatives

open Snuffy.StagedMaximality

variable {α : Type*}

structure FinitaryAlt (Bad : Finset α → Prop) (Req : Set α) (alts : α → Set (Set α))
    (s : Set α) : Prop where
  noBad : ∀ F : Finset α, (↑F : Set α) ⊆ s → ¬ Bad F
  req : Req ⊆ s
  closed : ∀ a ∈ s, ∃ B ∈ alts a, B ⊆ s

variable (stage : α → ℕ) (Bad : Finset α → Prop) (Req : Set α) (alts : α → Set (Set α))

def StageMaxAlt (W : Set α) (k : ℕ) : Prop :=
  ∀ t, FinitaryAlt Bad Req alts t →
    (∀ j < k, slice stage t j = slice stage W j) →
    ¬ slice stage W k ⊂ slice stage t k

theorem stage_step_alt (hReq : FinitaryAlt Bad Req alts Req)
    (halts : ∀ a, ∀ B ∈ alts a, ∀ b ∈ B, stage b < stage a)
    (k : ℕ) (W : Set α) (hW : FinitaryAlt Bad Req alts W) :
    ∃ W', FinitaryAlt Bad Req alts W' ∧
      (∀ j < k, slice stage W' j = slice stage W j) ∧
      StageMaxAlt stage Bad Req alts W' k := by
  classical
  let S : Set (Set α) := {t | FinitaryAlt Bad Req alts t ∧
    (∀ j < k, slice stage t j = slice stage W j) ∧
    t ⊆ {a | stage a ≤ k} ∪ Req}
  have proj : ∀ t, FinitaryAlt Bad Req alts t →
      (∀ j < k, slice stage t j = slice stage W j) →
      ({a | a ∈ t ∧ stage a ≤ k} ∪ Req) ∈ S := by
    intro t ht hts
    refine ⟨⟨?_, ?_, ?_⟩, ?_, ?_⟩
    · intro F hF
      apply ht.noBad F
      intro x hx
      rcases hF hx with h | h
      · exact h.1
      · exact ht.req h
    · exact Set.subset_union_right
    · intro a ha
      rcases ha with ha | ha
      · obtain ⟨B, hB, hBt⟩ := ht.closed a ha.1
        exact ⟨B, hB, fun b hb => Or.inl ⟨hBt hb, (halts a B hB b hb).le.trans ha.2⟩⟩
      · obtain ⟨B, hB, hBR⟩ := hReq.closed a ha
        exact ⟨B, hB, fun b hb => Or.inr (hBR hb)⟩
    · intro j hj
      ext a
      constructor
      · rintro ⟨h, rfl⟩
        rcases h with h | h
        · have : a ∈ slice stage t (stage a) := ⟨h.1, rfl⟩
          rwa [hts _ hj] at this
        · exact ⟨hW.req h, rfl⟩
      · rintro ⟨h, rfl⟩
        have : a ∈ slice stage W (stage a) := ⟨h, rfl⟩
        rw [← hts _ hj] at this
        exact ⟨Or.inl ⟨this.1, hj.le⟩, rfl⟩
    · intro a ha
      rcases ha with ha | ha
      · exact Or.inl ha.2
      · exact Or.inr ha
  have hx0 : ({a | a ∈ W ∧ stage a ≤ k} ∪ Req) ∈ S := proj W hW (fun _ _ => rfl)
  have chains : ∀ c ⊆ S, IsChain (· ⊆ ·) c → c.Nonempty →
      ∃ ub ∈ S, ∀ s ∈ c, s ⊆ ub := by
    intro c hcS hc hne
    obtain ⟨s0, hs0⟩ := hne
    refine ⟨⋃₀ c, ⟨⟨?_, ?_, ?_⟩, ?_, ?_⟩, fun s hs => Set.subset_sUnion_of_mem hs⟩
    · intro F hF
      obtain ⟨s, hs, hFs⟩ := finset_subset_of_chain hc ⟨s0, hs0⟩ F hF
      exact (hcS hs).1.noBad F hFs
    · exact (hcS hs0).1.req.trans (Set.subset_sUnion_of_mem hs0)
    · rintro a ⟨s, hs, has⟩
      obtain ⟨B, hB, hBs⟩ := (hcS hs).1.closed a has
      exact ⟨B, hB, hBs.trans (Set.subset_sUnion_of_mem hs)⟩
    · intro j hj
      ext a
      constructor
      · rintro ⟨⟨s, hs, has⟩, rfl⟩
        have : a ∈ slice stage s (stage a) := ⟨has, rfl⟩
        rwa [(hcS hs).2.1 _ hj] at this
      · intro ha
        have ha' := ha
        rw [← (hcS hs0).2.1 _ hj] at ha'
        exact ⟨⟨s0, hs0, ha'.1⟩, ha'.2⟩
    · rintro a ⟨s, hs, has⟩
      exact (hcS hs).2.2 has
  obtain ⟨m, -, hmax⟩ := zorn_subset_nonempty S chains _ hx0
  have hmS : m ∈ S := hmax.prop
  refine ⟨m, hmS.1, hmS.2.1, ?_⟩
  intro t ht hts hlt
  have hts' : ∀ j < k, slice stage t j = slice stage W j := by
    intro j hj; rw [hts j hj, hmS.2.1 j hj]
  have ht'S := proj t ht hts'
  have hsub : m ⊆ {a | a ∈ t ∧ stage a ≤ k} ∪ Req := by
    intro a ha
    rcases hmS.2.2 ha with hk | hr
    · have hk : stage a ≤ k := hk
      rcases lt_or_eq_of_le hk with hlt' | heq
      · have : a ∈ slice stage m (stage a) := ⟨ha, rfl⟩
        rw [← hts _ hlt'] at this
        exact Or.inl ⟨this.1, hk⟩
      · have : a ∈ slice stage m k := ⟨ha, heq⟩
        exact Or.inl ⟨(hlt.1 this).1, hk⟩
    · exact Or.inr hr
  obtain ⟨b, hbt, hbm⟩ := Set.exists_of_ssubset hlt
  have hb : b ∈ m := hmax.2 ht'S hsub (Or.inl ⟨hbt.1, hbt.2.le⟩)
  exact hbm ⟨hb, hbt.2⟩

theorem exists_stagemax_upto_alt (hReq : FinitaryAlt Bad Req alts Req)
    (halts : ∀ a, ∀ B ∈ alts a, ∀ b ∈ B, stage b < stage a) (n : ℕ) :
    ∃ W, FinitaryAlt Bad Req alts W ∧ ∀ k < n, StageMaxAlt stage Bad Req alts W k := by
  induction n with
  | zero => exact ⟨Req, hReq, fun k hk => absurd hk (Nat.not_lt_zero k)⟩
  | succ n ih =>
    obtain ⟨W, hW, hmax⟩ := ih
    obtain ⟨W', hW', hsame, hnew⟩ := stage_step_alt stage Bad Req alts hReq halts n W hW
    refine ⟨W', hW', fun k hk => ?_⟩
    rcases Nat.lt_succ_iff_lt_or_eq.mp hk with hk | rfl
    · intro t ht hts hlt
      apply hmax k hk t ht
      · intro j hj; rw [hts j hj, hsame j (hj.trans hk)]
      · rwa [hsame k hk] at hlt
    · exact hnew

/-- **Maximality in the staged order with alternative requirements.** -/
theorem exists_lex_maximal_alt (N : ℕ) (hN : ∀ a, stage a < N)
    (hReq : FinitaryAlt Bad Req alts Req)
    (halts : ∀ a, ∀ B ∈ alts a, ∀ b ∈ B, stage b < stage a) :
    ∃ m, FinitaryAlt Bad Req alts m ∧ Req ⊆ m ∧
      ∀ t, FinitaryAlt Bad Req alts t → ¬ LexBetter stage m t := by
  obtain ⟨W, hW, hmax⟩ := exists_stagemax_upto_alt stage Bad Req alts hReq halts N
  refine ⟨W, hW, hW.req, ?_⟩
  rintro t ht ⟨k, heq, hlt⟩
  by_cases hk : k < N
  · exact hmax k hk t ht (fun j hj => (heq j hj).symm) hlt
  · obtain ⟨b, hbt, -⟩ := Set.exists_of_ssubset hlt
    exact hk (hbt.2 ▸ hN b)

end Snuffy.StagedAlternatives
