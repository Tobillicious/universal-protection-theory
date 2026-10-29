import Snuffy.StagedMaximality

/-!
# Finite character from compactness (S2: the hypothesis derived)

`StagedMaximality` takes a family of finite character: an outcome is infeasible only
through a finite conflict. Here that is derived. Let the executable policies form a
compact space `Π` (for example policies from finite observation histories to a finite
action set, compact by Tychonoff), let `out π` be the facts policy `π` realises, and
suppose each fact's realisation set `{π | a ∈ out π}` is closed. Then:

* `realisable_iff_finite` — an outcome is realised by some policy exactly when each of
  its finite parts is (finite intersection property);
* `realisable_finitary` — the realisable outcomes keeping the mandatory baseline and
  closed under prerequisites form a `Finitary` family, with `Bad F` meaning no policy
  realises `F`;
* `four_stage_maximal_of_compact` — so a maximal outcome in the four original stages
  exists for every compact policy space with closed realisation sets.
-/

namespace Snuffy.FiniteCharacter

open Snuffy.StagedMaximality

variable {α Pol : Type*} [TopologicalSpace Pol] [CompactSpace Pol]

theorem realisable_iff_finite (out : Pol → Set α)
    (hclosed : ∀ a, IsClosed {q | a ∈ out q}) (t : Set α) :
    (∃ q, t ⊆ out q) ↔ ∀ F : Finset α, (↑F : Set α) ⊆ t → ∃ q, (↑F : Set α) ⊆ out q := by
  constructor
  · rintro ⟨q, hq⟩ F hF
    exact ⟨q, hF.trans hq⟩
  · intro hfin
    classical
    have key := isCompact_univ.inter_iInter_nonempty
      (fun a : t => {q : Pol | (a : α) ∈ out q}) (fun a => hclosed a)
      (by
        intro u
        obtain ⟨q, hq⟩ := hfin (u.map (Function.Embedding.subtype _))
          (by intro x hx; simp at hx; obtain ⟨hxt, -⟩ := hx; exact hxt)
        refine ⟨q, Set.mem_univ _, ?_⟩
        simp only [Set.mem_iInter, Set.mem_ofPred_eq]
        intro a ha
        exact hq (by simp [ha]))
    obtain ⟨q, -, hq⟩ := key
    refine ⟨q, fun x hx => ?_⟩
    simp only [Set.mem_iInter, Set.mem_ofPred_eq] at hq
    exact hq ⟨x, hx⟩

/-- The realisable family, keeping the baseline and closed under prerequisites. -/
def RealisableFamily (out : Pol → Set α) (Req : Set α) (pre : α → Set α) (t : Set α) : Prop :=
  (∃ q, t ⊆ out q) ∧ Req ⊆ t ∧ ∀ a ∈ t, pre a ⊆ t

theorem realisable_finitary (out : Pol → Set α)
    (hclosed : ∀ a, IsClosed {q | a ∈ out q}) (Req : Set α) (pre : α → Set α) (t : Set α) :
    RealisableFamily out Req pre t ↔
      Finitary (fun F => ¬ ∃ q, (↑F : Set α) ⊆ out q) Req pre t := by
  constructor
  · rintro ⟨hreal, hreq, hpre⟩
    refine ⟨fun F hF hbad => hbad ((realisable_iff_finite out hclosed t).mp hreal F hF),
      hreq, hpre⟩
  · intro h
    refine ⟨(realisable_iff_finite out hclosed t).mpr (fun F hF => ?_), h.req, h.closed⟩
    by_contra hno
    exact h.noBad F hF hno

/-- **Four-stage maximality for every compact policy space.** -/
theorem four_stage_maximal_of_compact {P : Type*} (out : Pol → Set (Fact P))
    (hclosed : ∀ a, IsClosed {q | a ∈ out q}) (Req : Set (Fact P))
    (hReq : RealisableFamily out Req freedomPre Req) :
    ∃ m, RealisableFamily out Req freedomPre m ∧ Req ⊆ m ∧
      ∀ t, RealisableFamily out Req freedomPre t →
        ¬ LexBetter (fun a : Fact P => (a.1 : ℕ)) m t := by
  have hR := (realisable_finitary out hclosed Req freedomPre Req).mp hReq
  obtain ⟨m, hm, hreq, hmax⟩ := four_stage_original_maximal _ Req hR
  refine ⟨m, (realisable_finitary out hclosed Req freedomPre m).mpr hm, hreq, ?_⟩
  intro t ht
  exact hmax t ((realisable_finitary out hclosed Req freedomPre t).mp ht)

end Snuffy.FiniteCharacter
