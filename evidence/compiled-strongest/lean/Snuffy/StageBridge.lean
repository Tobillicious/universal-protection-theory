import Snuffy.StagedMaximality
import Snuffy.Greatestness

/-!
# Four-stage maximality in the law's own terms (S2 bridge)

`StagedMaximality` works with staged facts `Fin 4 × P`; the canon's law
(`Greatestness`, Proposition 1) works with four-tuples of sets `Fin 4 → Set P`. This
module joins them.

* `toTuple` reads a fact set as a four-tuple of sets.
* `lexBetter_of_lexLt` — the law's strict order on tuples implies the staged order.
* `four_stage_aligned` — the outcome of `four_stage_original_maximal` is **aligned** in the
  law's sense (`Greatestness.Aligned`) in the image of the feasible family, and therefore,
  by Proposition 1, needlessly loses nothing at any of the four stages
  (`four_stage_no_needless_loss`).
-/

namespace Snuffy.StageBridge

open Snuffy.StagedMaximality

variable {P : Type*}

/-- A fact set as a four-tuple of sets of particulars. -/
def toTuple (m : Set (Fact P)) : Fin 4 → Set P := fun i => {p | (i, p) ∈ m}

/-- The stage of a fact. -/
abbrev stg (a : Fact P) : ℕ := (a.1 : ℕ)

theorem mem_slice_iff (m : Set (Fact P)) (i : Fin 4) (p : P) :
    (i, p) ∈ slice stg m (i : ℕ) ↔ p ∈ toTuple m i := by
  simp [slice, toTuple, stg]

theorem slice_eq_of_tuple_eq {m t : Set (Fact P)} {i : Fin 4}
    (h : toTuple m i = toTuple t i) : slice stg m (i : ℕ) = slice stg t (i : ℕ) := by
  ext ⟨j, p⟩
  simp only [slice, Set.mem_ofPred_eq]
  constructor
  · rintro ⟨hm, hj⟩
    have hji : j = i := Fin.ext hj
    subst hji
    have : p ∈ toTuple m j := hm
    rw [h] at this
    exact ⟨this, rfl⟩
  · rintro ⟨ht, hj⟩
    have hji : j = i := Fin.ext hj
    subst hji
    have : p ∈ toTuple t j := ht
    rw [← h] at this
    exact ⟨this, rfl⟩

theorem slice_ssubset_of_tuple_lt {m t : Set (Fact P)} {i : Fin 4}
    (h : toTuple m i < toTuple t i) : slice stg m (i : ℕ) ⊂ slice stg t (i : ℕ) := by
  rw [Set.ssubset_iff_subset_ne] at h
  obtain ⟨hsub, hne⟩ := h
  refine Set.ssubset_iff_subset_ne.mpr ⟨?_, ?_⟩
  · rintro ⟨j, p⟩ ⟨hm, hj⟩
    have hji : j = i := Fin.ext hj
    subst hji
    exact ⟨hsub hm, hj⟩
  · intro heq
    apply hne
    ext p
    constructor
    · intro hp
      have h1 : (i, p) ∈ slice stg m (i : ℕ) := ⟨hp, rfl⟩
      rw [heq] at h1
      exact h1.1
    · intro hp
      have h1 : (i, p) ∈ slice stg t (i : ℕ) := ⟨hp, rfl⟩
      rw [← heq] at h1
      exact h1.1

/-- The law's strict order on tuples implies the staged order. -/
theorem lexBetter_of_lexLt {m t : Set (Fact P)}
    (h : Greatestness.LexLt (toTuple m) (toTuple t)) : LexBetter stg m t := by
  obtain ⟨j, heq, hlt⟩ := h
  refine ⟨(j : ℕ), fun k hk => ?_, slice_ssubset_of_tuple_lt hlt⟩
  have hk4 : k < 4 := lt_trans hk j.isLt
  have := slice_eq_of_tuple_eq (i := ⟨k, hk4⟩) (heq ⟨k, hk4⟩ (Fin.mk_lt_of_lt_val hk))
  simpa using this

/-- **The four-stage maximal outcome is aligned in the law's sense.** -/
theorem four_stage_aligned (Bad : Finset (Fact P) → Prop) (Req : Set (Fact P))
    (hReq : Finitary Bad Req freedomPre Req) :
    ∃ m, Finitary Bad Req freedomPre m ∧ Req ⊆ m ∧
      Greatestness.Aligned (toTuple '' {t | Finitary Bad Req freedomPre t}) (toTuple m) := by
  obtain ⟨m, hm, hreq, hmax⟩ := four_stage_original_maximal Bad Req hReq
  refine ⟨m, hm, hreq, ⟨⟨m, hm, rfl⟩, ?_⟩⟩
  rintro q ⟨t, ht, rfl⟩ hlt
  exact hmax t ht (lexBetter_of_lexLt hlt)

/-- **And it needlessly loses nothing at any of the four stages** (Proposition 1). -/
theorem four_stage_no_needless_loss (Bad : Finset (Fact P) → Prop) (Req : Set (Fact P))
    (hReq : Finitary Bad Req freedomPre Req) :
    ∃ m, Finitary Bad Req freedomPre m ∧ Req ⊆ m ∧
      ∀ j, ¬ Greatestness.NeedlessLoss (toTuple '' {t | Finitary Bad Req freedomPre t})
        (toTuple m) j := by
  obtain ⟨m, hm, hreq, hal⟩ := four_stage_aligned Bad Req hReq
  exact ⟨m, hm, hreq, (Greatestness.aligned_iff_no_needless_loss _ hal.1).mp hal⟩

end Snuffy.StageBridge
