/-
Snuffy — Canon Edition 4.2 working: the whole greatest outcome is realisable (G2).

Union closure of realisable outcome tuples is derived here, not assumed. A
policy assigns each particular its own local component (locality, P4); each
particular's continuation-and-freedom grade is read from its own component.
Splicing two realisable policies — taking, particular by particular, the
component with the higher grade — realises the stage-wise union of their
outcome tuples at every stage at once. Choosing for every particular a
component of top grade realises the top tuple `⊤`, with no finiteness
assumption on the particulars.

  * splice_grade, splice_realisable — the spliced policy is realisable and its
    grade at each particular is the maximum of the two.
  * outcome_splice, union_realizable — `UnionClosure.UnionRealizable` for the
    realised outcome family, derived.
  * top_realisable — `htopR : ⊤ ∈ R` from per-particular top components.
  * whole_outcome_greatest — joined to `UnionClosure.greatest_of_solvent`:
    every aligned option of the funded family is `⊤` and contains every
    outcome tuple.
  * fourStage — the four-stage order (L_E, F_E, L_N, F_N) of Part II.1 as an
    instance, with grades lost < continues < continues-and-free.
  * block_splice_run, block_splice_keeps — the product structure from the
    actual dynamics: when each particular's held record occupies a closed
    block of the dependency graph and every policy's closed-loop transition is
    local to it (`UPTR16Cut.LocalTo`), the spliced run reproduces each chosen
    policy's run on that particular's block at every step, so each particular
    receives exactly the outcome of the policy chosen for it.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.UnionClosure
import Snuffy.SolventReciprocity
import Snuffy.R16Cut
import Mathlib.Data.Fin.VecNotation
import Mathlib.Tactic.FinCases

namespace Snuffy.G2Splice

open Snuffy.Greatestness Snuffy.UnionClosure

universe u v w

variable {Part : Type u} {Local : Part → Type v} {Γ : Type w} [LinearOrder Γ]

/-- A policy assigns each particular its own local component. -/
abbrev Policy (Local : Part → Type v) := ∀ x, Local x

/-- The realisable policies: every local component is realisable for its
particular. -/
def Realisable (Rloc : ∀ x, Set (Local x)) : Set (Policy Local) :=
  {π | ∀ x, π x ∈ Rloc x}

/-- Take, at each particular, the component of higher grade. -/
noncomputable def splice (g : ∀ x, Local x → Γ) (π σ : Policy Local) : Policy Local :=
  fun x => if g x (σ x) ≤ g x (π x) then π x else σ x

theorem splice_grade (g : ∀ x, Local x → Γ) (π σ : Policy Local) (x : Part) :
    g x (splice g π σ x) = max (g x (π x)) (g x (σ x)) := by
  unfold splice
  split_ifs with h
  · exact (max_eq_left h).symm
  · exact (max_eq_right (le_of_lt (not_le.mp h))).symm

theorem splice_realisable (Rloc : ∀ x, Set (Local x)) (g : ∀ x, Local x → Γ)
    {π σ : Policy Local} (hπ : π ∈ Realisable Rloc) (hσ : σ ∈ Realisable Rloc) :
    splice g π σ ∈ Realisable Rloc := by
  intro x
  unfold splice
  split_ifs
  · exact hπ x
  · exact hσ x

variable {n : ℕ}

/-- The outcome tuple of a policy: stage `i` contains the particulars of its
category `cat i` whose grade reaches the stage threshold `θ i`. -/
def outcome (g : ∀ x, Local x → Γ) (θ : Fin n → Γ) (cat : Fin n → Set Part)
    (π : Policy Local) : ∀ i : Fin n, Set {x // x ∈ cat i} :=
  fun i => {y | θ i ≤ g y.1 (π y.1)}

theorem outcome_splice (g : ∀ x, Local x → Γ) (θ : Fin n → Γ) (cat : Fin n → Set Part)
    (π σ : Policy Local) :
    outcome g θ cat (splice g π σ) = outcome g θ cat π ⊔ outcome g θ cat σ := by
  funext i
  ext y
  simp only [outcome, splice_grade, Pi.sup_apply, Set.sup_eq_union, Set.mem_union,
    Set.mem_ofPred_eq, le_max_iff]

/-- The realised outcome family. -/
def outcomes (Rloc : ∀ x, Set (Local x)) (g : ∀ x, Local x → Γ) (θ : Fin n → Γ)
    (cat : Fin n → Set Part) : Set (∀ i : Fin n, Set {x // x ∈ cat i}) :=
  outcome g θ cat '' Realisable Rloc

/-- Union closure of the realised outcome family, derived from locality. -/
theorem union_realizable (Rloc : ∀ x, Set (Local x)) (g : ∀ x, Local x → Γ)
    (θ : Fin n → Γ) (cat : Fin n → Set Part) :
    UnionRealizable (L := fun i => Set {x // x ∈ cat i}) (outcomes Rloc g θ cat) := by
  rintro _ ⟨π, hπ, rfl⟩ _ ⟨σ, hσ, rfl⟩
  exact ⟨splice g π σ, splice_realisable Rloc g hπ hσ, outcome_splice g θ cat π σ⟩

/-- **`htopR` derived.** If every particular has a realisable local component
reaching the threshold of every stage it belongs to, the top tuple is
realised. -/
theorem top_realisable (Rloc : ∀ x, Set (Local x)) (g : ∀ x, Local x → Γ)
    (θ : Fin n → Γ) (cat : Fin n → Set Part)
    (hbest : ∀ x, ∃ l ∈ Rloc x, ∀ i, x ∈ cat i → θ i ≤ g x l) :
    (⊤ : ∀ i : Fin n, Set {x // x ∈ cat i}) ∈ outcomes Rloc g θ cat := by
  choose best hbestR hbestθ using hbest
  refine ⟨best, hbestR, ?_⟩
  funext i
  ext y
  simp only [outcome, Pi.top_apply, Set.top_eq_univ, Set.mem_univ, iff_true,
    Set.mem_ofPred_eq]
  exact hbestθ y.1 i y.2

/-- **Whole-outcome greatestness from locality.** With the top tuple derived
realisable and its cost within budget, every aligned option of the funded
family is the top tuple and contains every outcome tuple. -/
theorem whole_outcome_greatest (Rloc : ∀ x, Set (Local x)) (g : ∀ x, Local x → Γ)
    (θ : Fin n → Γ) (cat : Fin n → Set Part)
    (hbest : ∀ x, ∃ l ∈ Rloc x, ∀ i, x ∈ cat i → θ i ≤ g x l)
    {c : (∀ i : Fin n, Set {x // x ∈ cat i}) → ℝ} {B : ℝ} (hsolv : c ⊤ ≤ B)
    {o : ∀ i : Fin n, Set {x // x ∈ cat i}}
    (ho : Aligned (budgetFamily (outcomes Rloc g θ cat) c B) o) :
    o = ⊤ ∧ ∀ q, q ≤ o :=
  greatest_of_solvent (top_realisable Rloc g θ cat hbest) hsolv ho

/-- Stage thresholds of the four-stage order: continuation needs grade 1,
freedom grade 2 (lost 0 < continues 1 < continues and free 2). -/
def fourθ : Fin 4 → Fin 3 := ![1, 2, 1, 2]

/-- Stage categories: existing particulars for L_E and F_E, new ones for L_N
and F_N. -/
def fourCat (E N : Set Part) : Fin 4 → Set Part := ![E, E, N, N]

/-- **The four-stage instance.** If every particular has a realisable local
component under which it continues in its own direction, the whole
continuation-and-freedom tuple (L_E, F_E, L_N, F_N) at its top is realisable,
and under solvency it is the canonical outcome. -/
theorem fourStage (Rloc : ∀ x, Set (Local x)) (g : ∀ x, Local x → Fin 3)
    (E N : Set Part) (hfree : ∀ x, ∃ l ∈ Rloc x, g x l = 2)
    {c : (∀ i : Fin 4, Set {x // x ∈ fourCat E N i}) → ℝ} {B : ℝ} (hsolv : c ⊤ ≤ B)
    {o : ∀ i : Fin 4, Set {x // x ∈ fourCat E N i}}
    (ho : Aligned (budgetFamily (outcomes Rloc g fourθ (fourCat E N)) c B) o) :
    (⊤ : ∀ i : Fin 4, Set {x // x ∈ fourCat E N i}) ∈
        outcomes Rloc g fourθ (fourCat E N) ∧
      UnionRealizable (L := fun i => Set {x // x ∈ fourCat E N i})
        (outcomes Rloc g fourθ (fourCat E N)) ∧
      o = ⊤ ∧ ∀ q, q ≤ o := by
  have hbest : ∀ x, ∃ l ∈ Rloc x, ∀ i, x ∈ fourCat E N i → fourθ i ≤ g x l := by
    intro x
    obtain ⟨l, hl, hg⟩ := hfree x
    refine ⟨l, hl, fun i _ => ?_⟩
    rw [hg]
    fin_cases i <;> decide
  exact ⟨top_realisable Rloc g fourθ (fourCat E N) hbest,
    union_realizable Rloc g fourθ (fourCat E N),
    whole_outcome_greatest Rloc g fourθ (fourCat E N) hbest hsolv ho⟩

section Dynamics

open CodexCohold UPTR16Cut

variable {N V E Part Pol : Type}

/-- The run of a closed-loop transition against the world's input sequence. -/
def runIn (T : (N → V) → E → (N → V)) (s₀ : N → V) (env : ℕ → E) : ℕ → (N → V)
  | 0 => s₀
  | k + 1 => T (runIn T s₀ env k) (env k)

/-- Each node in a particular's block follows that particular's chosen policy;
nodes in no block follow a default policy. -/
noncomputable def blockSplice (B : Part → N → Prop) (T : Pol → (N → V) → E → (N → V))
    (choice : Part → Pol) (p₀ : Pol) : (N → V) → E → (N → V) := by
  classical
  exact fun s e n => if h : ∃ x, B x n then T (choice h.choose) s e n else T p₀ s e n

/-- **The spliced dynamics reproduce every chosen policy on its block.** With
closed, pairwise disjoint blocks and local closed-loop transitions, the
spliced run agrees on each particular's block with the run of the policy
chosen for that particular, at every step, against the same world. -/
theorem block_splice_run (D : N → N → Prop) (B : Part → N → Prop)
    (hclosed : ∀ x, Closed D (B x)) (hdisj : ∀ x y n, B x n → B y n → x = y)
    (T : Pol → (N → V) → E → (N → V)) (hloc : ∀ p, LocalTo D (T p))
    (choice : Part → Pol) (p₀ : Pol) (s₀ : N → V) (env : ℕ → E) :
    ∀ k x, AgreeOn (B x) (runIn (blockSplice B T choice p₀) s₀ env k)
      (runIn (T (choice x)) s₀ env k) := by
  classical
  intro k
  induction k with
  | zero => intro x n _; rfl
  | succ k ih =>
      intro x n hn
      have hex : ∃ y, B y n := ⟨x, hn⟩
      have hch : hex.choose = x := hdisj _ _ n hex.choose_spec hn
      show blockSplice B T choice p₀ (runIn (blockSplice B T choice p₀) s₀ env k) (env k) n =
        T (choice x) (runIn (T (choice x)) s₀ env k) (env k) n
      simp only [blockSplice, dite_eq_left hex, hch]
      exact closed_cut_step D (B x) (T (choice x)) (hclosed x) (hloc (choice x))
        _ _ (ih x) (env k) n hn

/-- **Each particular receives its chosen policy's outcome.** If whether `x`
is kept is read from its own block, the spliced run keeps `x` at step `k`
exactly when the policy chosen for `x` does. -/
theorem block_splice_keeps (D : N → N → Prop) (B : Part → N → Prop)
    (hclosed : ∀ x, Closed D (B x)) (hdisj : ∀ x y n, B x n → B y n → x = y)
    (T : Pol → (N → V) → E → (N → V)) (hloc : ∀ p, LocalTo D (T p))
    (choice : Part → Pol) (p₀ : Pol) (s₀ : N → V) (env : ℕ → E)
    (keeps : Part → (N → V) → Prop)
    (hread : ∀ x s t, AgreeOn (B x) s t → (keeps x s ↔ keeps x t)) (k : ℕ) (x : Part) :
    keeps x (runIn (blockSplice B T choice p₀) s₀ env k) ↔
      keeps x (runIn (T (choice x)) s₀ env k) :=
  hread x _ _ (block_splice_run D B hclosed hdisj T hloc choice p₀ s₀ env k x)

end Dynamics

end Snuffy.G2Splice
