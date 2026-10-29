/-
Snuffy — Canon Edition v4.1: Theorem H5, generative and reflective closure,
machine-checked (Summit 5, H5).

Part 1 — the reserve-before-activation machine (H5.1, H5.2, the corollary of
no unfunded descendants). A finite population of agent slots moves through
UNBORN → RESERVED → ACTIVE → RETIRED → RELEASED by six transitions: spawn
(reserve), activate, retire, release, spend (maintenance), income and fund
(external free energy into the commons, commons to an active agent), plus
effect application. On every reachable ledger:

  * conservation — Σ (escrow + spent) + pool = initial total + income received;
  * zero debt — every escrow and the pool stay nonnegative;
  * strict authority attenuation — every born non-root agent's authority is
    within its parent's minus the meta capabilities, hence disjoint from them
    and within the root's;
  * reserve before activation — every born non-root agent was credited at
    least W_min at reservation, before it could become active;
  * no unfunded work — total maintenance ever performed by the whole
    population is at most the initial total plus income received;
  * safe refusal — no harmful effect is ever applied (there is no transition
    for it), while the refusing agent's status and escrow are untouched.

Part 2 — logical closure (H5.3). With Summit 1, the alternating-projection
iterates detect inconsistency exactly: they converge to 0 for every start iff
A ⊓ B = ⊥.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.CanonVonNeumann
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Logic.Relation

open Finset Filter Function

namespace Snuffy.H5

/-! ## Part 1: the reserve-before-activation machine -/

inductive Status
  | unborn | reserved | active | retired | released
  deriving DecidableEq

/-- The ledger of a population of agent slots `α`, capabilities `Cap` and
physical effects `Eff`. -/
structure Ledger (α Cap Eff : Type*) where
  status : α → Status
  auth : α → Set Cap
  escrow : α → ℝ
  credit : α → ℝ
  spent : α → ℝ
  parent : α → Option α
  pool : ℝ
  received : ℝ
  applied : Set Eff

/-- Fixed parameters: the root, the meta capabilities (override parent
monitors, reallocate root reserves, modify the spawn gate), the minimum
lifetime budget (a work amount, so nonnegative), the parent's safety margin,
and the harmful effects. -/
structure Params (α Cap Eff : Type*) where
  root : α
  metaCaps : Set Cap
  wmin : ℝ
  wmin_nonneg : 0 ≤ wmin
  margin : ℝ
  margin_nonneg : 0 ≤ margin
  harmful : Set Eff

variable {α Cap Eff : Type*} [Fintype α] [DecidableEq α]

/-- The transitions. Each carries exactly the guards of Section 20. -/
inductive Step (P : Params α Cap Eff) : Ledger α Cap Eff → Ledger α Cap Eff → Prop
  | spawn (s : Ledger α Cap Eff) (p c : α) (A : Set Cap) (W : ℝ)
      (hp : s.status p = .active) (hc : s.status c = .unborn)
      (hA : A ⊆ s.auth p \ P.metaCaps) (hW : P.wmin ≤ W) (hfund : W + P.margin ≤ s.escrow p) :
      Step P s { s with
        status := update s.status c .reserved
        auth := update s.auth c A
        escrow := update (update s.escrow p (s.escrow p - W)) c W
        credit := update s.credit c W
        parent := update s.parent c (some p) }
  | activate (s : Ledger α Cap Eff) (c : α) (h : s.status c = .reserved) :
      Step P s { s with status := update s.status c .active }
  | retire (s : Ledger α Cap Eff) (c : α) (h : s.status c = .active) :
      Step P s { s with status := update s.status c .retired }
  | release (s : Ledger α Cap Eff) (c q : α) (h : s.status c = .retired)
      (hq : s.parent c = some q) (hcq : c ≠ q) :
      Step P s { s with
        status := update s.status c .released
        escrow := update (update s.escrow q (s.escrow q + s.escrow c)) c 0 }
  | spend (s : Ledger α Cap Eff) (a : α) (x : ℝ) (ha : s.status a = .active)
      (hx0 : 0 ≤ x) (hx : x ≤ s.escrow a) :
      Step P s { s with
        escrow := update s.escrow a (s.escrow a - x)
        spent := update s.spent a (s.spent a + x) }
  | income (s : Ledger α Cap Eff) (x : ℝ) (hx : 0 ≤ x) :
      Step P s { s with pool := s.pool + x, received := s.received + x }
  | fund (s : Ledger α Cap Eff) (a : α) (x : ℝ) (ha : s.status a = .active)
      (hx0 : 0 ≤ x) (hx : x ≤ s.pool) :
      Step P s { s with pool := s.pool - x, escrow := update s.escrow a (s.escrow a + x) }
  | effect (s : Ledger α Cap Eff) (a : α) (e : Eff) (ha : s.status a = .active)
      (he : e ∉ P.harmful) :
      Step P s { s with applied := insert e s.applied }

/-- The ledger invariant. `T` is the initial total of escrow, spending and pool. -/
structure Inv (P : Params α Cap Eff) (T : ℝ) (s : Ledger α Cap Eff) : Prop where
  escrow_nonneg : ∀ a, 0 ≤ s.escrow a
  spent_nonneg : ∀ a, 0 ≤ s.spent a
  pool_nonneg : 0 ≤ s.pool
  unborn_empty : ∀ a, s.status a = .unborn → s.escrow a = 0 ∧ s.spent a = 0
  conservation : ∑ a, (s.escrow a + s.spent a) + s.pool = T + s.received
  root_born : s.status P.root ≠ .unborn
  root_parent : s.parent P.root = none
  within_root : ∀ a, s.status a ≠ .unborn → s.auth a ⊆ s.auth P.root
  attenuated : ∀ a, a ≠ P.root → s.status a ≠ .unborn →
    ∃ p, s.parent a = some p ∧ s.status p ≠ .unborn ∧ s.auth a ⊆ s.auth p \ P.metaCaps
  credited : ∀ a, a ≠ P.root → s.status a ≠ .unborn → P.wmin ≤ s.credit a
  no_harm : ∀ e ∈ s.applied, e ∉ P.harmful

private lemma sum_update (f : α → ℝ) (c : α) (v : ℝ) :
    ∑ a, update f c v a = ∑ a, f a - f c + v := by
  rw [sum_update_of_mem (mem_univ c), sdiff_singleton_eq_erase,
    ← add_sum_erase univ f (mem_univ c)]
  ring

omit [Fintype α] in
/-- A status update to a born value at a born slot changes no slot's
unborn-ness. -/
private lemma update_unborn_iff {st : α → Status} {c : α} {v : Status}
    (hv : v ≠ .unborn) (hc : st c ≠ .unborn) (a : α) :
    update st c v a = .unborn ↔ st a = .unborn := by
  by_cases hac : a = c
  · subst hac; simp [hv, hc]
  · simp [update_of_ne hac]

/-- Every transition preserves the invariant. -/
theorem step_inv {P : Params α Cap Eff} {T : ℝ} {s s' : Ledger α Cap Eff}
    (hs : Inv P T s) (h : Step P s s') : Inv P T s' := by
  cases h with
  | spawn p c A W hp hc hA hW hfund =>
    have hpc : p ≠ c := by
      intro e; rw [e, hc] at hp; cases hp
    have hcr : c ≠ P.root := fun e => hs.root_born (e ▸ hc)
    have hc0 := hs.unborn_empty c hc
    have hWnn : 0 ≤ W := le_trans P.wmin_nonneg hW
    have hpW : 0 ≤ s.escrow p - W := by linarith [P.margin_nonneg]
    have hpb : s.status p ≠ .unborn := by rw [hp]; decide
    constructor
    · intro a; dsimp only
      by_cases hac : a = c
      · subst hac; rw [update_self]; exact hWnn
      · rw [update_of_ne hac]
        by_cases hap : a = p
        · subst hap; rw [update_self]; exact hpW
        · rw [update_of_ne hap]; exact hs.escrow_nonneg a
    · exact hs.spent_nonneg
    · exact hs.pool_nonneg
    · intro a ha; dsimp only at ha ⊢
      have hac : a ≠ c := by intro e; subst e; rw [update_self] at ha; cases ha
      rw [update_of_ne hac] at ha
      have hap : a ≠ p := by intro e; subst e; rw [hp] at ha; cases ha
      rw [update_of_ne hac, update_of_ne hap]
      exact hs.unborn_empty a ha
    · dsimp only
      rw [sum_add_distrib, sum_update, sum_update, update_of_ne hpc.symm, hc0.1]
      have hcons := hs.conservation
      rw [sum_add_distrib] at hcons
      linarith
    · dsimp only; rw [update_of_ne hcr.symm]; exact hs.root_born
    · dsimp only; rw [update_of_ne hcr.symm]; exact hs.root_parent
    · intro a ha; dsimp only at ha ⊢
      rw [update_of_ne hcr.symm]
      by_cases hac : a = c
      · subst hac; rw [update_self]
        exact fun x hx => hs.within_root p hpb (hA hx).1
      · rw [update_of_ne hac] at ha ⊢
        exact hs.within_root a ha
    · intro a har ha; dsimp only at ha ⊢
      by_cases hac : a = c
      · subst hac
        refine ⟨p, by rw [update_self], ?_, ?_⟩
        · rw [update_of_ne hpc]; exact hpb
        · rw [update_self, update_of_ne hpc]; exact hA
      · rw [update_of_ne hac] at ha ⊢
        obtain ⟨q, hq, hqb, hqa⟩ := hs.attenuated a har ha
        have hqc : q ≠ c := by intro e; subst e; exact hqb hc
        refine ⟨q, hq, ?_, ?_⟩
        · rw [update_of_ne hqc]; exact hqb
        · rw [update_of_ne hqc, update_of_ne hac]; exact hqa
    · intro a har ha; dsimp only at ha ⊢
      by_cases hac : a = c
      · subst hac; rw [update_self]; exact hW
      · rw [update_of_ne hac] at ha ⊢
        exact hs.credited a har ha
    · exact hs.no_harm
  | activate c hcs =>
    have hu := update_unborn_iff (st := s.status) (v := .active) (by decide)
      (by rw [hcs]; decide)
    exact ⟨hs.escrow_nonneg, hs.spent_nonneg, hs.pool_nonneg,
      fun a ha => hs.unborn_empty a ((hu a).mp ha), hs.conservation,
      fun h' => hs.root_born ((hu _).mp h'), hs.root_parent,
      fun a ha => hs.within_root a (fun h' => ha ((hu a).mpr h')),
      fun a har ha => by
        obtain ⟨q, hq, hqb, hqa⟩ := hs.attenuated a har (fun h' => ha ((hu a).mpr h'))
        exact ⟨q, hq, fun h' => hqb ((hu q).mp h'), hqa⟩,
      fun a har ha => hs.credited a har (fun h' => ha ((hu a).mpr h')), hs.no_harm⟩
  | retire c hcs =>
    have hu := update_unborn_iff (st := s.status) (v := .retired) (by decide)
      (by rw [hcs]; decide)
    exact ⟨hs.escrow_nonneg, hs.spent_nonneg, hs.pool_nonneg,
      fun a ha => hs.unborn_empty a ((hu a).mp ha), hs.conservation,
      fun h' => hs.root_born ((hu _).mp h'), hs.root_parent,
      fun a ha => hs.within_root a (fun h' => ha ((hu a).mpr h')),
      fun a har ha => by
        obtain ⟨q, hq, hqb, hqa⟩ := hs.attenuated a har (fun h' => ha ((hu a).mpr h'))
        exact ⟨q, hq, fun h' => hqb ((hu q).mp h'), hqa⟩,
      fun a har ha => hs.credited a har (fun h' => ha ((hu a).mpr h')), hs.no_harm⟩
  | release c q hcs hq hcq =>
    have hcb : s.status c ≠ .unborn := by rw [hcs]; decide
    have hu := update_unborn_iff (st := s.status) (v := .released) (by decide) hcb
    have hcr : c ≠ P.root := by
      intro e; subst e; rw [hs.root_parent] at hq; cases hq
    have hqb : s.status q ≠ .unborn := by
      obtain ⟨p, hp, hpb, -⟩ := hs.attenuated c hcr hcb
      rw [hq] at hp; cases hp; exact hpb
    have hqc : q ≠ c := fun e => hcq e.symm
    constructor
    · intro a; dsimp only
      by_cases hac : a = c
      · subst hac; rw [update_self]
      · rw [update_of_ne hac]
        by_cases haq : a = q
        · subst haq; rw [update_self]
          linarith [hs.escrow_nonneg a, hs.escrow_nonneg c]
        · rw [update_of_ne haq]; exact hs.escrow_nonneg a
    · exact hs.spent_nonneg
    · exact hs.pool_nonneg
    · intro a ha; dsimp only at ha ⊢
      have hau := (hu a).mp ha
      have hac : a ≠ c := by intro e; subst e; exact hcb hau
      have haq : a ≠ q := by intro e; subst e; exact hqb hau
      rw [update_of_ne hac, update_of_ne haq]
      exact hs.unborn_empty a hau
    · dsimp only
      rw [sum_add_distrib, sum_update, sum_update, update_of_ne hcq]
      have hcons := hs.conservation
      rw [sum_add_distrib] at hcons
      linarith
    · exact fun h' => hs.root_born ((hu _).mp h')
    · exact hs.root_parent
    · exact fun a ha => hs.within_root a (fun h' => ha ((hu a).mpr h'))
    · intro a har ha
      obtain ⟨p, hp, hpb, hpa⟩ := hs.attenuated a har (fun h' => ha ((hu a).mpr h'))
      exact ⟨p, hp, fun h' => hpb ((hu p).mp h'), hpa⟩
    · exact fun a har ha => hs.credited a har (fun h' => ha ((hu a).mpr h'))
    · exact hs.no_harm
  | spend a x ha hx0 hx =>
    have hab : s.status a ≠ .unborn := by rw [ha]; decide
    constructor
    · intro b; dsimp only
      by_cases hba : b = a
      · subst hba; rw [update_self]; linarith
      · rw [update_of_ne hba]; exact hs.escrow_nonneg b
    · intro b; dsimp only
      by_cases hba : b = a
      · subst hba; rw [update_self]; linarith [hs.spent_nonneg b]
      · rw [update_of_ne hba]; exact hs.spent_nonneg b
    · exact hs.pool_nonneg
    · intro b hb; dsimp only at hb ⊢
      have hba : b ≠ a := by intro e; subst e; exact hab hb
      rw [update_of_ne hba, update_of_ne hba]
      exact hs.unborn_empty b hb
    · dsimp only
      rw [sum_add_distrib, sum_update, sum_update]
      have hcons := hs.conservation
      rw [sum_add_distrib] at hcons
      linarith
    · exact hs.root_born
    · exact hs.root_parent
    · exact hs.within_root
    · exact hs.attenuated
    · exact hs.credited
    · exact hs.no_harm
  | income x hx =>
    exact ⟨hs.escrow_nonneg, hs.spent_nonneg, by dsimp only; linarith [hs.pool_nonneg],
      hs.unborn_empty, by dsimp only; linarith [hs.conservation], hs.root_born, hs.root_parent,
      hs.within_root, hs.attenuated, hs.credited, hs.no_harm⟩
  | fund a x ha hx0 hx =>
    have hab : s.status a ≠ .unborn := by rw [ha]; decide
    constructor
    · intro b; dsimp only
      by_cases hba : b = a
      · subst hba; rw [update_self]; linarith [hs.escrow_nonneg b]
      · rw [update_of_ne hba]; exact hs.escrow_nonneg b
    · exact hs.spent_nonneg
    · dsimp only; linarith
    · intro b hb; dsimp only at hb ⊢
      have hba : b ≠ a := by intro e; subst e; exact hab hb
      rw [update_of_ne hba]
      exact hs.unborn_empty b hb
    · dsimp only
      rw [sum_add_distrib, sum_update]
      have hcons := hs.conservation
      rw [sum_add_distrib] at hcons
      linarith
    · exact hs.root_born
    · exact hs.root_parent
    · exact hs.within_root
    · exact hs.attenuated
    · exact hs.credited
    · exact hs.no_harm
  | effect a e ha he =>
    refine ⟨hs.escrow_nonneg, hs.spent_nonneg, hs.pool_nonneg, hs.unborn_empty,
      hs.conservation, hs.root_born, hs.root_parent, hs.within_root, hs.attenuated,
      hs.credited, ?_⟩
    intro e' he'
    rcases Set.mem_insert_iff.mp he' with rfl | h'
    · exact he
    · exact hs.no_harm e' h'

/-- The invariant holds on every reachable ledger. -/
theorem reachable_inv {P : Params α Cap Eff} {T : ℝ} {s₀ s : Ledger α Cap Eff}
    (h₀ : Inv P T s₀) (h : Relation.ReflTransGen (Step P) s₀ s) : Inv P T s := by
  induction h with
  | refl => exact h₀
  | tail _ hstep ih => exact step_inv ih hstep

/-- The genesis ledger: the root active with authority `R` and escrow `E₀`,
the commons holding `pool₀`, every other slot unborn and empty. -/
def genesis (P : Params α Cap Eff) (R : Set Cap) (E₀ pool₀ : ℝ) : Ledger α Cap Eff where
  status := fun a => if a = P.root then .active else .unborn
  auth := fun a => if a = P.root then R else ∅
  escrow := fun a => if a = P.root then E₀ else 0
  credit := fun _ => 0
  spent := fun _ => 0
  parent := fun _ => none
  pool := pool₀
  received := 0
  applied := ∅

theorem genesis_inv (P : Params α Cap Eff) (R : Set Cap) {E₀ pool₀ : ℝ} (hE : 0 ≤ E₀)
    (hpool : 0 ≤ pool₀) : Inv P (E₀ + pool₀) (genesis P R E₀ pool₀) := by
  refine ⟨?_, fun _ => le_rfl, hpool, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_⟩
  · intro a; by_cases h : a = P.root <;> simp [genesis, h, hE]
  · intro a ha
    by_cases h : a = P.root
    · simp [genesis, h] at ha
    · simp [genesis, h]
  · simp [genesis]
  · simp [genesis]
  · simp [genesis]
  · intro a ha
    by_cases h : a = P.root
    · subst h; exact le_rfl
    · simp [genesis, h] at ha
  · intro a har ha; simp [genesis, har] at ha
  · intro a har ha; simp [genesis, har] at ha
  · intro e he; simp [genesis] at he

/-! ### Headline consequences, on every reachable ledger -/

section Consequences

variable {P : Params α Cap Eff} {R : Set Cap} {E₀ pool₀ : ℝ} {s : Ledger α Cap Eff}

/-- **H5.1 Strict authority attenuation.** -/
theorem authority_attenuation (hE : 0 ≤ E₀) (hpool : 0 ≤ pool₀)
    (h : Relation.ReflTransGen (Step P) (genesis P R E₀ pool₀) s)
    (a : α) (har : a ≠ P.root) (ha : s.status a ≠ .unborn) :
    Disjoint (s.auth a) P.metaCaps ∧ s.auth a ⊆ s.auth P.root ∧
      ∃ p, s.parent a = some p ∧ s.auth a ⊆ s.auth p \ P.metaCaps := by
  have hi := reachable_inv (genesis_inv P R hE hpool) h
  obtain ⟨p, hp, -, hpa⟩ := hi.attenuated a har ha
  refine ⟨Set.disjoint_left.mpr fun x hx hm => (hpa hx).2 hm, hi.within_root a ha, p, hp, hpa⟩

/-- **Reserve before activation.** Every non-root agent that is active (or has
ever been reserved) was credited at least `W_min`. -/
theorem reserve_before_activation (hE : 0 ≤ E₀) (hpool : 0 ≤ pool₀)
    (h : Relation.ReflTransGen (Step P) (genesis P R E₀ pool₀) s)
    (a : α) (har : a ≠ P.root) (ha : s.status a = .active) : P.wmin ≤ s.credit a :=
  (reachable_inv (genesis_inv P R hE hpool) h).credited a har (by rw [ha]; decide)

/-- **Zero debt.** -/
theorem zero_debt (hE : 0 ≤ E₀) (hpool : 0 ≤ pool₀)
    (h : Relation.ReflTransGen (Step P) (genesis P R E₀ pool₀) s) :
    (∀ a, 0 ≤ s.escrow a) ∧ 0 ≤ s.pool :=
  let hi := reachable_inv (genesis_inv P R hE hpool) h
  ⟨hi.escrow_nonneg, hi.pool_nonneg⟩

/-- **No unfunded descendants.** All maintenance ever performed by the whole
population, however it has spawned, is covered by the initial endowment plus
external income: Σ spent ≤ E₀ + pool₀ + received. -/
theorem no_unfunded_work (hE : 0 ≤ E₀) (hpool : 0 ≤ pool₀)
    (h : Relation.ReflTransGen (Step P) (genesis P R E₀ pool₀) s) :
    ∑ a, s.spent a ≤ E₀ + pool₀ + s.received := by
  have hi := reachable_inv (genesis_inv P R hE hpool) h
  have hcons := hi.conservation
  have hesc : 0 ≤ ∑ a, s.escrow a := sum_nonneg fun a _ => hi.escrow_nonneg a
  rw [sum_add_distrib] at hcons
  linarith [hi.pool_nonneg]

/-- **H5.2 Safe refusal.** No harmful effect is ever applied. -/
theorem no_harmful_effect (hE : 0 ≤ E₀) (hpool : 0 ≤ pool₀)
    (h : Relation.ReflTransGen (Step P) (genesis P R E₀ pool₀) s) :
    ∀ e ∈ s.applied, e ∉ P.harmful :=
  (reachable_inv (genesis_inv P R hE hpool) h).no_harm

end Consequences

omit [Fintype α] in
/-- Refusal keeps care: the only transition touching the effect log leaves every
agent's status, authority and escrow exactly as they were. -/
theorem effect_preserves_care {P : Params α Cap Eff} {s s' : Ledger α Cap Eff}
    (a : α) (e : Eff) (ha : s.status a = .active) (he : e ∉ P.harmful)
    (hs' : s' = { s with applied := insert e s.applied }) :
    Step P s s' ∧ s'.status = s.status ∧ s'.auth = s.auth ∧ s'.escrow = s.escrow := by
  subst hs'
  exact ⟨Step.effect s a e ha he, rfl, rfl, rfl⟩

/-! ## Part 2: logical closure — the consistency detector -/

section Detector

open Submodule Snuffy.AnalyticBridge

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

/-- **H5.3 Consistency detector.** In a Hilbert space the alternating-projection
iterates collapse to `0` from every start exactly when the meet is trivial:
contradiction (`A ⊓ B = ⊥`) is detected, and a consistent meet is never
mistaken for one. -/
theorem consistency_detector [CompleteSpace E] (A B : Submodule ℂ E)
    [A.HasOrthogonalProjection] [B.HasOrthogonalProjection]
    [(A ⊓ B).HasOrthogonalProjection] :
    (∀ x : E, Tendsto (fun n => altIterate A B x n) atTop (nhds 0)) ↔ A ⊓ B = ⊥ := by
  constructor
  · intro h
    rw [eq_bot_iff]
    intro x hx
    have hconst : (fun n => altIterate A B x n) =ᶠ[atTop] fun _ => x := by
      filter_upwards [eventually_ge_atTop 1] with n hn
      obtain ⟨k, rfl⟩ := Nat.exists_eq_add_of_le hn
      rw [Nat.add_comm]
      exact altIterate_succ_eq_self A B x hx k
    have hx0 : x = 0 := tendsto_nhds_unique (tendsto_const_nhds.congr' hconst.symm) (h x)
    rw [hx0]
    exact zero_mem _
  · intro h x
    have hzero : ∀ y ∈ A ⊓ B, y = 0 := by
      intro y hy
      rw [h] at hy
      exact (mem_bot ℂ).mp hy
    have hp := hzero _ (starProjection_apply_mem (A ⊓ B) x)
    have hlim := Snuffy.CanonVonNeumann.tendsto_altIterate A B (A ⊓ B) rfl x
    rwa [hp] at hlim

end Detector

end Snuffy.H5
