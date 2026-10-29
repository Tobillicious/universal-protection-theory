import Snuffy.FoundingDominance

/-!
# Founding without coordination for a non-excludable good (Part XI.5 repair)

The hostile referee of 29 October 2026 observed that for a public good the
already-funded advantage is `-c`, so `FoundingDominance.contribution_strictly_dominant`
needs an excludable benefit there. Book I §9.16‴'s own witness sets the provision
point to the total of all pledges, so every pledge is necessary and the
already-funded state never arises. Then:

* `others_short` — with `B` equal to the total pledge and every pledge positive,
  the others' pledges fall short of `B` (they can never fund alone);
* `pivotal_contribution_dominant` — whenever the others' pledged funds fall short
  of `B`, contribution is strictly better given only a positive failure bonus and a
  pivotal benefit above the pledge;
* `all_necessary_dominant` — the two together: in the all-pledges-necessary
  campaign, contribution is strictly dominant for every funder at every profile.
-/

namespace Snuffy.FoundingPivotal

open Snuffy.FoundingDominance Finset

theorem pivotal_contribution_dominant (B c β bpiv bfund Y : ℝ)
    (hshort : Y < B) (hβ : 0 < β) (hpiv : c < bpiv) :
    0 < advantage B c β bpiv bfund Y := by
  unfold advantage
  split_ifs with h1
  · exact hβ
  · linarith

/-- With the provision point equal to the total pledge, the others' total falls
short of it by the funder's own (positive) pledge. -/
theorem others_short {ι : Type*} [DecidableEq ι] (N : Finset ι) (c : ι → ℝ)
    (hpos : ∀ j ∈ N, 0 < c j) (i : ι) (hi : i ∈ N) (S : Finset ι)
    (hS : S ⊆ N.erase i) :
    ∑ j ∈ S, c j < ∑ j ∈ N, c j := by
  have h1 : ∑ j ∈ S, c j ≤ ∑ j ∈ N.erase i, c j :=
    Finset.sum_le_sum_of_subset_of_nonneg hS
      (fun j hj _ => (hpos j (Finset.mem_of_mem_erase hj)).le)
  have h2 : ∑ j ∈ N.erase i, c j + c i = ∑ j ∈ N, c j := Finset.sum_erase_add N c hi
  linarith [hpos i hi]

/-- **All pledges necessary ⇒ contribution strictly dominant**, whatever subset of
the others pledges, for a non-excludable good. -/
theorem all_necessary_dominant {ι : Type*} [DecidableEq ι] (N : Finset ι) (c : ι → ℝ)
    (hpos : ∀ j ∈ N, 0 < c j) (i : ι) (hi : i ∈ N) (S : Finset ι) (hS : S ⊆ N.erase i)
    (β bpiv bfund : ℝ) (hβ : 0 < β) (hpiv : c i < bpiv) :
    0 < advantage (∑ j ∈ N, c j) (c i) β bpiv bfund (∑ j ∈ S, c j) :=
  pivotal_contribution_dominant _ _ _ _ _ _ (others_short N c hpos i hi S hS) hβ hpiv

end Snuffy.FoundingPivotal
