import Mathlib

/-!
# Maximality in the full staged order (compiled edition, S2)

The law's order compares outcomes stage by stage: at the first stage where two
outcomes differ, the strictly larger set wins. This module proves that a
maximal outcome exists in the full feasible family, for any finite number of
stages, under one structural hypothesis: **finite character** — every
infeasibility is witnessed by a finite conflict (the author's ruling that real
tragedies are finite). The family may carry

* a positive **mandatory baseline** `Req` that every feasible outcome keeps
  (never dropped to make the family nicer), and
* **prerequisites** `pre a` in strictly earlier stages (freedom of a
  particular requires its continuation).

The set of particulars is arbitrary, including uncountable. The proof is a
stage-by-stage Zorn argument; no enumeration of particulars is used.
`four_stage_original_maximal` instantiates the four original stages:
existing continuation, existing freedom, new continuation, new freedom.
-/

namespace Snuffy.StagedMaximality

variable {α : Type*}

/-- Feasibility with finite character: no forbidden finite pattern, the
mandatory baseline kept, and prerequisites closed. -/
structure Finitary (Bad : Finset α → Prop) (Req : Set α) (pre : α → Set α)
    (s : Set α) : Prop where
  noBad : ∀ F : Finset α, (↑F : Set α) ⊆ s → ¬ Bad F
  req : Req ⊆ s
  closed : ∀ a ∈ s, pre a ⊆ s

/-- The stage-`k` part of an outcome. -/
def slice (stage : α → ℕ) (s : Set α) (k : ℕ) : Set α :=
  {a | a ∈ s ∧ stage a = k}

/-- The law's strict order: at the first differing stage, `t` strictly
contains `s`. -/
def LexBetter (stage : α → ℕ) (s t : Set α) : Prop :=
  ∃ k, (∀ j < k, slice stage s j = slice stage t j) ∧
    slice stage s k ⊂ slice stage t k

/-- A finite set inside the union of a nonempty chain lies in one member. -/
theorem finset_subset_of_chain {c : Set (Set α)} (hc : IsChain (· ⊆ ·) c)
    (hne : c.Nonempty) (F : Finset α) :
    (↑F : Set α) ⊆ ⋃₀ c → ∃ s ∈ c, (↑F : Set α) ⊆ s := by
  classical
  refine Finset.induction_on F ?_ ?_
  · intro _
    obtain ⟨s, hs⟩ := hne
    exact ⟨s, hs, by simp⟩
  · intro a F _ ih hF
    obtain ⟨s, hs, hFs⟩ := ih (fun x hx => hF (by simp [hx]))
    obtain ⟨u, hu, hau⟩ : a ∈ ⋃₀ c := hF (by simp)
    rcases hc.total hs hu with h | h
    · refine ⟨u, hu, ?_⟩
      intro x hx
      rcases Finset.mem_insert.mp hx with rfl | hx
      · exact hau
      · exact h (hFs hx)
    · refine ⟨s, hs, ?_⟩
      intro x hx
      rcases Finset.mem_insert.mp hx with rfl | hx
      · exact h hau
      · exact hFs hx

variable (stage : α → ℕ) (Bad : Finset α → Prop) (Req : Set α) (pre : α → Set α)

/-- `W` is maximal at stage `k` among feasible outcomes agreeing with it on
every earlier stage. -/
def StageMax (W : Set α) (k : ℕ) : Prop :=
  ∀ t, Finitary Bad Req pre t →
    (∀ j < k, slice stage t j = slice stage W j) →
    ¬ slice stage W k ⊂ slice stage t k

/-- One stage of the construction (Zorn). -/
theorem stage_step (hReq : Finitary Bad Req pre Req)
    (hpre : ∀ a, ∀ b ∈ pre a, stage b < stage a)
    (k : ℕ) (W : Set α) (hW : Finitary Bad Req pre W) :
    ∃ W', Finitary Bad Req pre W' ∧
      (∀ j < k, slice stage W' j = slice stage W j) ∧
      StageMax stage Bad Req pre W' k := by
  classical
  -- candidates: feasible, agreeing with `W` below `k`, nothing above `k` but `Req`
  let S : Set (Set α) := {t | Finitary Bad Req pre t ∧
    (∀ j < k, slice stage t j = slice stage W j) ∧
    t ⊆ {a | stage a ≤ k} ∪ Req}
  -- projecting a feasible outcome below stage `k` (keeping `Req`) stays in `S`
  have proj : ∀ t, Finitary Bad Req pre t →
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
    · intro a ha b hb
      rcases ha with ha | ha
      · exact Or.inl ⟨ht.closed a ha.1 hb, (hpre a b hb).le.trans ha.2⟩
      · exact Or.inr (hReq.closed a ha hb)
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
      exact ((hcS hs).1.closed a has).trans (Set.subset_sUnion_of_mem hs)
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

/-- Iterating the stage step: maximal at every stage below `n`. -/
theorem exists_stagemax_upto (hReq : Finitary Bad Req pre Req)
    (hpre : ∀ a, ∀ b ∈ pre a, stage b < stage a) (n : ℕ) :
    ∃ W, Finitary Bad Req pre W ∧ ∀ k < n, StageMax stage Bad Req pre W k := by
  induction n with
  | zero => exact ⟨Req, hReq, fun k hk => absurd hk (Nat.not_lt_zero k)⟩
  | succ n ih =>
    obtain ⟨W, hW, hmax⟩ := ih
    obtain ⟨W', hW', hsame, hnew⟩ := stage_step stage Bad Req pre hReq hpre n W hW
    refine ⟨W', hW', fun k hk => ?_⟩
    rcases Nat.lt_succ_iff_lt_or_eq.mp hk with hk | rfl
    · intro t ht hts hlt
      apply hmax k hk t ht
      · intro j hj; rw [hts j hj, hsame j (hj.trans hk)]
      · rwa [hsame k hk] at hlt
    · exact hnew

/-- **Existence of a maximal outcome in the full staged order.** With finitely
many stages, a feasible mandatory baseline and earlier-stage prerequisites,
finite character of infeasibility gives a feasible outcome that no feasible
outcome strictly improves in the law's order. -/
theorem exists_lex_maximal (N : ℕ) (hN : ∀ a, stage a < N)
    (hReq : Finitary Bad Req pre Req)
    (hpre : ∀ a, ∀ b ∈ pre a, stage b < stage a) :
    ∃ m, Finitary Bad Req pre m ∧ Req ⊆ m ∧
      ∀ t, Finitary Bad Req pre t → ¬ LexBetter stage m t := by
  obtain ⟨W, hW, hmax⟩ := exists_stagemax_upto stage Bad Req pre hReq hpre N
  refine ⟨W, hW, hW.req, ?_⟩
  rintro t ht ⟨k, heq, hlt⟩
  by_cases hk : k < N
  · exact hmax k hk t ht (fun j hj => (heq j hj).symm) hlt
  · obtain ⟨b, hbt, -⟩ := Set.exists_of_ssubset hlt
    exact hk (hbt.2 ▸ hN b)

/-! ## The four original stages -/

/-- A fact: stage `0` existing continuation, `1` existing freedom,
`2` new continuation, `3` new freedom, of a particular. -/
abbrev Fact (P : Type*) := Fin 4 × P

/-- Freedom of a particular requires its continuation. -/
def freedomPre {P : Type*} (a : Fact P) : Set (Fact P) :=
  if a.1 = 1 then {(0, a.2)} else if a.1 = 3 then {(2, a.2)} else ∅

theorem freedomPre_earlier {P : Type*} :
    ∀ a : Fact P, ∀ b ∈ freedomPre a, (b.1 : ℕ) < (a.1 : ℕ) := by
  rintro ⟨i, p⟩ b hb
  simp only [freedomPre] at hb
  split_ifs at hb with h1 h3
  · rw [Set.mem_singleton_iff] at hb; subst hb; subst h1; simp
  · rw [Set.mem_singleton_iff] at hb; subst hb; subst h3; simp
  · exact absurd hb (Set.notMem_empty b)

/-- **Four-stage original maximality.** For any set of particulars, any finite
conflicts, and any feasible mandatory baseline closed under the freedom
prerequisite, there is a feasible outcome keeping the baseline that no
feasible outcome strictly improves in the original four-stage order. -/
theorem four_stage_original_maximal {P : Type*}
    (Bad : Finset (Fact P) → Prop) (Req : Set (Fact P))
    (hReq : Finitary Bad Req freedomPre Req) :
    ∃ m, Finitary Bad Req freedomPre m ∧ Req ⊆ m ∧
      ∀ t, Finitary Bad Req freedomPre t →
        ¬ LexBetter (fun a : Fact P => (a.1 : ℕ)) m t :=
  exists_lex_maximal (fun a : Fact P => (a.1 : ℕ)) Bad Req freedomPre 4
    (fun a => a.1.isLt) hReq freedomPre_earlier

end Snuffy.StagedMaximality
