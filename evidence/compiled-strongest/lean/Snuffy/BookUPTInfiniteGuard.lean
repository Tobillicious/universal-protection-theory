/-! Ported from Book I v2.0.5, Paper 12 evidence (`evidence/papers-11-12/lean/UPTInfiniteGuard.lean`, sha256 `48fc5240bbd9b7fe437deec5b7e94ac018404a34e157ea3877e9d0dcde5bdcb2`).
Namespace `UPTInfGuard` renamed to `Snuffy.Book.UPTInfiniteGuard` for the canon's joint audit; statements and proofs unchanged. -/

/-
The life guard in infinite families (Paper 12, section 3, "Life guard": "with the stated chain-upper-bound
condition by Zorn. The infinite existence argument is not formalised"). Core Lean has no Zorn's lemma; this
file proves the countable case directly. Definitions and `life_guard` are repeated verbatim from UPTLawLife.lean.
Setting: the feasible family is enumerated by the natural numbers, and every increasing sequence of feasible
options in the guard order has an upper bound in the family. Then the guard family has a maximal option, and
the life guard applies. (UPTExistence.lean shows the bound condition cannot simply be dropped.)
-/
namespace Snuffy.Book.UPTInfiniteGuard


universe u v

def Sub {α : Type u} (s t : α → Prop) : Prop := ∀ x, s x → t x
def SSub {α : Type u} (s t : α → Prop) : Prop := Sub s t ∧ ¬ Sub t s
theorem Sub.refl {α : Type u} (s : α → Prop) : Sub s s := fun _ h => h
theorem Sub.trans {α : Type u} {a b c : α → Prop} (h1 : Sub a b) (h2 : Sub b c) : Sub a c :=
  fun x hx => h2 x (h1 x hx)
def Aligned {α : Type u} {O : Type v} (F : O → Prop) (key : O → α → Prop) (o : O) : Prop :=
  F o ∧ ∀ p, F p → ¬ SSub (key o) (key p)
def Needless {α : Type u} {O : Type v} (F : O → Prop) (key : O → α → Prop) (o : O) (x : α) : Prop :=
  ¬ key o x ∧ ∃ p, F p ∧ Sub (key o) (key p) ∧ key p x
theorem U1 {α : Type u} {O : Type v} (F : O → Prop) (key : O → α → Prop) (o : O)
    (h : Aligned F key o) : ∀ x, ¬ Needless F key o x := by
  intro x hn
  obtain ⟨hnx, p, hp, hsub, hpx⟩ := hn
  exact h.2 p hp ⟨hsub, fun hback => hnx (hback x hpx)⟩

theorem SSub.trans_sub {α : Type u} {a b c : α → Prop} (h1 : SSub a b) (h2 : Sub b c) : SSub a c :=
  ⟨Sub.trans h1.1 h2, fun hca => h1.2 (Sub.trans h2 hca)⟩
theorem Sub.trans_ssub {α : Type u} {a b c : α → Prop} (h1 : Sub a b) (h2 : SSub b c) : SSub a c :=
  ⟨Sub.trans h1 h2.1, fun hca => h2.2 (Sub.trans hca h1)⟩

/-- Equal as sets (mutual inclusion). -/
def Equiv {α : Type u} (s t : α → Prop) : Prop := Sub s t ∧ Sub t s

/-- `LexBetter ks o p`: p is strictly better than o in the lexicographic partial order of the stage keys
    `ks`, consulting a later stage only when all earlier stages are equal. -/
def LexBetter {α : Type u} {O : Type v} : List (O → α → Prop) → O → O → Prop
  | [], _, _ => False
  | k :: ks, o, p => SSub (k o) (k p) ∨ (Equiv (k o) (k p) ∧ LexBetter ks o p)

/-- **O-8 (a).** The canonical order is irreflexive. -/
theorem lex_irrefl {α : Type u} {O : Type v} : ∀ (ks : List (O → α → Prop)) (o : O), ¬ LexBetter ks o o
  | [], _, h => h
  | k :: ks, o, h => by
    cases h with
    | inl hs => exact hs.2 (Sub.refl _)
    | inr he => exact lex_irrefl ks o he.2

/-- **O-8 (b).** The canonical order is transitive: a genuine strict partial order. -/
theorem lex_trans {α : Type u} {O : Type v} :
    ∀ (ks : List (O → α → Prop)) (o p q : O), LexBetter ks o p → LexBetter ks p q → LexBetter ks o q
  | [], _, _, _, h, _ => h
  | k :: ks, o, p, q, h1, h2 => by
    cases h1 with
    | inl s1 =>
      cases h2 with
      | inl s2 => exact Or.inl (SSub.trans_sub s1 s2.1)
      | inr e2 => exact Or.inl (SSub.trans_sub s1 e2.1.1)
    | inr e1 =>
      cases h2 with
      | inl s2 => exact Or.inl (Sub.trans_ssub e1.1.1 s2)
      | inr e2 =>
        exact Or.inr ⟨⟨Sub.trans e1.1.1 e2.1.1, Sub.trans e2.1.2 e1.1.2⟩, lex_trans ks o p q e1.2 e2.2⟩

/-- Aligned in the canonical order. -/
def LexAlignedL {α : Type u} {O : Type v} (F : O → Prop) (ks : List (O → α → Prop)) (o : O) : Prop :=
  F o ∧ ∀ p, F p → ¬ LexBetter ks o p

/-- No needless loss at any stage: at stage 1 among all feasible options, at stage 2 among those equal at
    stage 1, and so on. -/
def NoNeedlessAtEveryStage {α : Type u} {O : Type v} : (O → Prop) → List (O → α → Prop) → O → Prop
  | _, [], _ => True
  | F, k :: ks, o => (∀ x, ¬ Needless F k o x) ∧
      NoNeedlessAtEveryStage (fun p => F p ∧ Equiv (k o) (k p)) ks o

/-- **O-8 (c), U1 for the canonical order.** An agent aligned in the canonical order never needlessly loses
    anything at any stage. -/
theorem lex_U1 {α : Type u} {O : Type v} :
    ∀ (ks : List (O → α → Prop)) (F : O → Prop) (o : O), LexAlignedL F ks o → NoNeedlessAtEveryStage F ks o
  | [], _, _, _ => trivial
  | k :: ks, F, o, h => by
    refine ⟨U1 F k o ⟨h.1, fun p hp hs => h.2 p hp (Or.inl hs)⟩, ?_⟩
    apply lex_U1 ks
    refine ⟨⟨h.1, Sub.refl _, Sub.refl _⟩, fun p hp hl => h.2 p hp.1 (Or.inr ⟨hp.2, hl⟩)⟩

/-- **Legacy, freedom-first.** Kept for the record: this instance uses the order that preceded the
    life-first ruling. The adopted canonical order is life first; its instance is `canonical_life_first_U1` below.
    Original note: **O-8 (d), the canonical four-stage instance**: existing kept free, existing kept alive, new made free,
    new made alive. -/
theorem freedom_first_U1_legacy {α : Type u} {O : Type v} (F : O → Prop) (freeE aliveE freeN aliveN : O → α → Prop) (o : O)
    (h : LexAlignedL F [freeE, aliveE, freeN, aliveN] o) :
    NoNeedlessAtEveryStage F [freeE, aliveE, freeN, aliveN] o :=
  lex_U1 _ F o h

/-- **O-4 repaired (Codex N5): the guard lifts to the FULL canonical order for the first-stage key.**
    An option canonically aligned among the feasible options that keep everything standby keeps at stage 1 is
    canonically aligned in the whole family, and keeps everything standby keeps at stage 1. The guard therefore
    protects exactly what the order puts first. -/
theorem guard_first_stage {α : Type u} {O : Type v} (F : O → Prop) (k : O → α → Prop)
    (ks : List (O → α → Prop)) (s m : O)
    (h : LexAlignedL (fun p => F p ∧ Sub (k s) (k p)) (k :: ks) m) :
    LexAlignedL F (k :: ks) m ∧ Sub (k s) (k m) := by
  refine ⟨⟨h.1.1, fun p hp hl => ?_⟩, h.1.2⟩
  have hsp : Sub (k s) (k p) := by
    cases hl with
    | inl hs => exact Sub.trans h.1.2 hs.1
    | inr he => exact Sub.trans h.1.2 he.1.1
  exact h.2 p ⟨hp, hsp⟩ hl

/-- **R-ORDER (author ruling, 21 October 2026: "life first").** The canonical order is: existing kept alive;
    existing kept free; new made alive; new made free. Aligned agents never needlessly lose anything at any stage. -/
theorem canonical_life_first_U1 {α : Type u} {O : Type v} (F : O → Prop)
    (aliveE freeE aliveN freeN : O → α → Prop) (o : O)
    (h : LexAlignedL F [aliveE, freeE, aliveN, freeN] o) :
    NoNeedlessAtEveryStage F [aliveE, freeE, aliveN, freeN] o :=
  lex_U1 _ F o h

/-- **No innocent's life is ever required to be sacrificed.** Under the life-first order, an option canonically
    aligned among those keeping alive everyone standby keeps alive is canonically aligned in the whole family,
    and keeps all of them alive. -/
theorem life_guard {α : Type u} {O : Type v} (F : O → Prop) (aliveE freeE aliveN freeN : O → α → Prop) (s m : O)
    (h : LexAlignedL (fun p => F p ∧ Sub (aliveE s) (aliveE p)) [aliveE, freeE, aliveN, freeN] m) :
    LexAlignedL F [aliveE, freeE, aliveN, freeN] m ∧ Sub (aliveE s) (aliveE m) :=
  guard_first_stage F aliveE [freeE, aliveN, freeN] s m h


section countable
variable {O : Type v} (R : O → O → Prop) (e : Nat → O) (s : O)

/-- The greedy climb: start at `s`; at step n move to `e n` exactly when it is strictly above. -/
noncomputable def greedy : Nat → O
  | 0 => s
  | n + 1 => @ite O (R (greedy n) (e n)) (Classical.propDecidable _) (e n) (greedy n)

theorem greedy_pos (n : Nat) (h : R (greedy R e s n) (e n)) : greedy R e s (n + 1) = e n := by
  show @ite O (R (greedy R e s n) (e n)) (Classical.propDecidable _) (e n) (greedy R e s n) = e n
  simp [h]

theorem greedy_neg (n : Nat) (h : ¬ R (greedy R e s n) (e n)) : greedy R e s (n + 1) = greedy R e s n := by
  show @ite O (R (greedy R e s n) (e n)) (Classical.propDecidable _) (e n) (greedy R e s n) = greedy R e s n
  simp [h]

end countable

/-- **Countable Zorn.** Let `R` be irreflexive and transitive, the feasible family `F` be enumerated by `e`,
and `s` be feasible. If every `R`-increasing (or constant) sequence of feasible options has an upper bound in
`F`, then some feasible `u` is at or above `s` and nothing feasible is strictly above `u`. -/
theorem countable_maximal {O : Type v} (R : O → O → Prop) (tr : ∀ a b c, R a b → R b c → R a c)
    (irr : ∀ o, ¬ R o o) (F : O → Prop) (e : Nat → O) (he : ∀ n, F (e n)) (hcov : ∀ o, F o → ∃ n, e n = o)
    (s : O) (hs : F s)
    (bound : ∀ c : Nat → O, (∀ n, F (c n)) → (∀ n, c (n + 1) = c n ∨ R (c n) (c (n + 1))) →
      ∃ u, F u ∧ ∀ n, c n = u ∨ R (c n) u) :
    ∃ u, F u ∧ (u = s ∨ R s u) ∧ ∀ v, F v → ¬ R u v := by
  let g := greedy R e s
  have gF : ∀ n, F (g n) := by
    intro n
    induction n with
    | zero => exact hs
    | succ n ih =>
      by_cases h : R (g n) (e n)
      · rw [show g (n + 1) = e n from greedy_pos R e s n h]; exact he n
      · rw [show g (n + 1) = g n from greedy_neg R e s n h]; exact ih
  have gstep : ∀ n, g (n + 1) = g n ∨ R (g n) (g (n + 1)) := by
    intro n
    by_cases h : R (g n) (e n)
    · right; rw [show g (n + 1) = e n from greedy_pos R e s n h]; exact h
    · left; exact greedy_neg R e s n h
  obtain ⟨u, hu, hub⟩ := bound g gF gstep
  refine ⟨u, hu, ?_, ?_⟩
  · cases hub 0 with
    | inl h => exact Or.inl h.symm
    | inr h => exact Or.inr h
  · intro v hv huv
    obtain ⟨k, hk⟩ := hcov v hv
    have hgk : R (g k) v := by
      cases hub k with
      | inl h => exact h ▸ huv
      | inr h => exact tr _ _ _ h huv
    have hgk' : R (greedy R e s k) (e k) := by rw [hk]; exact hgk
    have hstep : greedy R e s (k + 1) = v := by
      rw [greedy_pos R e s k hgk']; exact hk
    cases hub (k + 1) with
    | inl h =>
      have hvu : v = u := by rw [← hstep]; exact h
      rw [hvu] at huv; exact irr u huv
    | inr h =>
      have hvu : R v u := by rw [← hstep]; exact h
      exact irr u (tr _ _ _ huv hvu)

/-- **The life guard in countable families.** If the feasible family is enumerated by the natural numbers,
contains the standby option `s`, and every increasing sequence of feasible options in the guard order (the
canonical order, restricted to options keeping alive everyone `s` keeps alive) has an upper bound in the
family, then some option is aligned in the full life-first canonical order and keeps alive everyone `s` keeps
alive. -/
theorem life_guard_countable {α : Type u} {O : Type v} (aliveE freeE aliveN freeN : O → α → Prop)
    (F : O → Prop) (e : Nat → O) (he : ∀ n, F (e n)) (hcov : ∀ o, F o → ∃ n, e n = o) (s : O) (hs : F s)
    (bound : ∀ c : Nat → O, (∀ n, F (c n)) →
      (∀ n, c (n + 1) = c n ∨ (LexBetter [aliveE, freeE, aliveN, freeN] (c n) (c (n + 1)) ∧
                                Sub (aliveE s) (aliveE (c (n + 1))))) →
      ∃ u, F u ∧ ∀ n, c n = u ∨ (LexBetter [aliveE, freeE, aliveN, freeN] (c n) u ∧ Sub (aliveE s) (aliveE u))) :
    ∃ m, F m ∧ LexAlignedL F [aliveE, freeE, aliveN, freeN] m ∧ Sub (aliveE s) (aliveE m) := by
  let ks : List (O → α → Prop) := [aliveE, freeE, aliveN, freeN]
  let R : O → O → Prop := fun o p => LexBetter ks o p ∧ Sub (aliveE s) (aliveE p)
  have tr : ∀ a b c, R a b → R b c → R a c :=
    fun a b c h1 h2 => ⟨lex_trans ks a b c h1.1 h2.1, h2.2⟩
  have irr : ∀ o, ¬ R o o := fun o h => lex_irrefl ks o h.1
  obtain ⟨m, hm, hsm, hmax⟩ := countable_maximal R tr irr F e he hcov s hs bound
  have hkeep : Sub (aliveE s) (aliveE m) := by
    cases hsm with
    | inl h => exact h ▸ Sub.refl _
    | inr h => exact h.2
  have hguard : LexAlignedL (fun p => F p ∧ Sub (aliveE s) (aliveE p)) ks m :=
    ⟨⟨hm, hkeep⟩, fun p hp hl => hmax p hp.1 ⟨hl, hp.2⟩⟩
  obtain ⟨hal, hk⟩ := life_guard F aliveE freeE aliveN freeN s m hguard
  exact ⟨m, hm, hal, hk⟩

/-- **The premises are satisfiable** (not vacuous): an infinite enumeration of a feasible family meets every
hypothesis of `countable_maximal`. Here the options are the natural numbers up to 5, enumerated with
repetition by `min n 5` and ordered by `<`; every sequence in the family is bounded by 5, and the theorem
yields a maximal option. -/
theorem countable_maximal_nonvacuous :
    ∃ u : Nat, u ≤ 5 ∧ (u = 0 ∨ 0 < u) ∧ ∀ v, v ≤ 5 → ¬ u < v :=
  countable_maximal (fun a b : Nat => a < b) (fun _ _ _ h1 h2 => Nat.lt_trans h1 h2) (fun o h => Nat.lt_irrefl o h)
    (fun o => o ≤ 5) (fun n => min n 5) (fun n => Nat.min_le_right n 5)
    (fun o ho => ⟨o, Nat.min_eq_left ho⟩) 0 (Nat.zero_le 5)
    (fun c hc _ => ⟨5, Nat.le_refl 5, fun n => by
      cases Nat.lt_or_ge (c n) 5 with
      | inl h => exact Or.inr h
      | inr h => exact Or.inl (Nat.le_antisymm (hc n) h)⟩)

end Snuffy.Book.UPTInfiniteGuard
