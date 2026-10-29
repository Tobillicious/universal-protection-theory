import Snuffy.StagedMaximality

/-!
# Per-loss certification in a tragedy (IX.1)

Where the top outcome is not realisable, some facts are lost. Maximality in the law's
order then reduces to one check per lost fact:

* `maximal_iff_per_loss` — no feasible outcome is better than `m` exactly when, for
  every fact `b` that `m` loses, no feasible outcome contains `b` while agreeing with
  `m` at every earlier stage and keeping everything `m` keeps at `b`'s stage.

So an outcome is certified by checking each loss separately: each loss must be
forced, given everything kept before it and beside it.
-/

namespace Snuffy.PerLossCheck

open Snuffy.StagedMaximality

variable {α : Type*}

theorem maximal_iff_per_loss (stage : α → ℕ) (Feas : Set α → Prop) (m : Set α) :
    (∀ t, Feas t → ¬ LexBetter stage m t) ↔
      ∀ b ∉ m, ∀ t, Feas t →
        (∀ j < stage b, slice stage m j = slice stage t j) →
        slice stage m (stage b) ⊆ slice stage t (stage b) → b ∉ t := by
  constructor
  · intro hmax b hb t ht hagree hsub hbt
    refine hmax t ht ⟨stage b, hagree, hsub, fun h => hb ?_⟩
    exact (h ⟨hbt, rfl⟩).1
  · rintro hloss t ht ⟨k, hagree, hlt⟩
    obtain ⟨b, ⟨hbt, hbk⟩, hbm⟩ := Set.exists_of_ssubset hlt
    subst hbk
    have hb : b ∉ m := fun h => hbm ⟨h, rfl⟩
    exact hloss b hb t ht hagree hlt.1 hbt

end Snuffy.PerLossCheck
