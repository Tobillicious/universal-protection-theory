import Mathlib

/-!
  R7-DIA, the interval demand condition (Whole Edition 3.5, 23 Oct 2026). Lean 4 with Mathlib.

  The R7 review candidate's exact deadline test: care jobs j with release r j, deadline d j and work p j on one
  unit-capacity lane whose available slots under outage calendar ω are Av ω. A schedule gives each job a set of slots
  S j, of size p j, inside its window [r j, d j) and available, the sets pairwise disjoint.
  * `demand_le_supply`: every such schedule forces, for every interval [a, b), the total work of the jobs whose window
    lies inside [a, b) to be at most the available slots in [a, b).
  * `robust_demand`: a schedule meeting every deadline under every admitted calendar forces the condition against
    the least available supply over the calendars.
  Sufficiency (the condition lets earliest-deadline-first meet every deadline under every calendar) is the classical
  optimality of earliest-deadline-first for preemptive unit-capacity scheduling (Dertouzos 1974; the processor-demand
  criterion, Baruah, Rosier and Howell 1990), checked exactly by R7's audit over 31,572 instances.
-/

namespace UPTDeadline

open Finset

variable {J : Type*}

theorem demand_le_supply (jobs : Finset J) (r d p : J → ℕ) (Av : Finset ℕ) (S : J → Finset ℕ)
    (hcard : ∀ j ∈ jobs, (S j).card = p j)
    (hwin : ∀ j ∈ jobs, S j ⊆ Av.filter (fun t => r j ≤ t ∧ t < d j))
    (hdisj : (jobs : Set J).PairwiseDisjoint S) (a b : ℕ) :
    (∑ j ∈ jobs.filter (fun j => a ≤ r j ∧ d j ≤ b), p j) ≤ (Av.filter (fun t => a ≤ t ∧ t < b)).card := by
  classical
  set inside := jobs.filter (fun j => a ≤ r j ∧ d j ≤ b)
  have hsub : inside.biUnion S ⊆ Av.filter (fun t => a ≤ t ∧ t < b) := by
    intro t ht
    obtain ⟨j, hj, htj⟩ := Finset.mem_biUnion.mp ht
    have hj' := Finset.mem_filter.mp hj
    have := hwin j hj'.1 htj
    rw [Finset.mem_filter] at this ⊢
    exact ⟨this.1, le_trans hj'.2.1 this.2.1, lt_of_lt_of_le this.2.2 hj'.2.2⟩
  have hdisj' : (inside : Set J).PairwiseDisjoint S :=
    hdisj.subset (by intro x hx; exact (Finset.mem_filter.mp hx).1)
  calc (∑ j ∈ inside, p j) = ∑ j ∈ inside, (S j).card := by
        refine Finset.sum_congr rfl (fun j hj => ?_)
        exact (hcard j (Finset.mem_filter.mp hj).1).symm
    _ = (inside.biUnion S).card := (Finset.card_biUnion hdisj').symm
    _ ≤ _ := Finset.card_le_card hsub

theorem robust_demand {Ω : Type*} (Dset : Finset Ω) (jobs : Finset J) (r d p : J → ℕ) (Av : Ω → Finset ℕ)
    (S : Ω → J → Finset ℕ)
    (hcard : ∀ ω ∈ Dset, ∀ j ∈ jobs, (S ω j).card = p j)
    (hwin : ∀ ω ∈ Dset, ∀ j ∈ jobs, S ω j ⊆ (Av ω).filter (fun t => r j ≤ t ∧ t < d j))
    (hdisj : ∀ ω ∈ Dset, (jobs : Set J).PairwiseDisjoint (S ω)) (a b : ℕ) :
    ∀ ω ∈ Dset, (∑ j ∈ jobs.filter (fun j => a ≤ r j ∧ d j ≤ b), p j) ≤
      ((Av ω).filter (fun t => a ≤ t ∧ t < b)).card :=
  fun ω hω => demand_le_supply jobs r d p (Av ω) (S ω) (hcard ω hω) (hwin ω hω) (hdisj ω hω) a b

end UPTDeadline
