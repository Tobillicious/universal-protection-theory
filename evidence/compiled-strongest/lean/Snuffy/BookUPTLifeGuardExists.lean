/-! Ported from Book I v2.0.5, Paper 12 evidence (`evidence/papers-11-12/lean/UPTLifeGuardExists.lean`, sha256 `5eebc4c309b316cb59f0b5ce579dadfd318356a74097e57f97dc574201b19aae`).
Namespace `UPTGuard` renamed to `Snuffy.Book.UPTLifeGuardExists` for the canon's joint audit; statements and proofs unchanged. -/

/-
The life guard always applies in finite families (Paper 12, section 3, "Life guard"). Definitions and the
theorems `guard_first_stage` and `life_guard` are repeated verbatim from UPTLawLife.lean.
`life_guard` assumes an option aligned within the guard family; here that option is shown to exist in every
finite feasible family containing the standby option, so the guard needs no further premise.
-/
namespace Snuffy.Book.UPTLifeGuardExists


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


/-- Climb within a finite list under an irreflexive, transitive relation, remembering where we started:
the result is the start itself or strictly above it, and nothing in the list is strictly above the result. -/
theorem climb_from {O : Type v} (R : O → O → Prop) (tr : ∀ a b c, R a b → R b c → R a c)
    (irr : ∀ o, ¬ R o o) : ∀ (L : List O) (b : O),
      ∃ m, (m = b ∨ m ∈ L) ∧ (m = b ∨ R b m) ∧ ∀ c, c ∈ L → ¬ R m c := by
  intro L
  induction L with
  | nil => intro b; exact ⟨b, Or.inl rfl, Or.inl rfl, fun c hc => nomatch hc⟩
  | cons x L ih =>
    intro b
    obtain ⟨m, hmem, hbm, hmax⟩ := ih b
    by_cases hmx : R m x
    · refine ⟨x, Or.inr List.mem_cons_self, ?_, ?_⟩
      · cases hbm with
        | inl h => exact Or.inr (h ▸ hmx)
        | inr h => exact Or.inr (tr b m x h hmx)
      · intro c hc hxc
        cases hc with
        | head => exact irr x hxc
        | tail _ hcL => exact hmax c hcL (tr m x c hmx hxc)
    · refine ⟨m, ?_, hbm, ?_⟩
      · cases hmem with
        | inl h => exact Or.inl h
        | inr h => exact Or.inr (List.mem_cons_of_mem x h)
      · intro c hc hmc
        cases hc with
        | head => exact hmx hmc
        | tail _ hcL => exact hmax c hcL hmc

/-- **The life guard always applies in finite families.** In every finite feasible family that contains the
standby option, some option is aligned in the full life-first canonical order and keeps alive everyone the
standby option keeps alive. No further premise. -/
theorem life_guard_exists {α : Type u} {O : Type v} (aliveE freeE aliveN freeN : O → α → Prop)
    (L : List O) (s : O) (hs : s ∈ L) :
    ∃ m, m ∈ L ∧ LexAlignedL (fun p => p ∈ L) [aliveE, freeE, aliveN, freeN] m ∧ Sub (aliveE s) (aliveE m) := by
  let ks : List (O → α → Prop) := [aliveE, freeE, aliveN, freeN]
  let R : O → O → Prop := fun o p => LexBetter ks o p ∧ Sub (aliveE s) (aliveE p)
  have tr : ∀ a b c, R a b → R b c → R a c :=
    fun a b c h1 h2 => ⟨lex_trans ks a b c h1.1 h2.1, h2.2⟩
  have irr : ∀ o, ¬ R o o := fun o h => lex_irrefl ks o h.1
  obtain ⟨m, hmem, hsm, hmax⟩ := climb_from R tr irr L s
  have hmL : m ∈ L := by
    cases hmem with
    | inl h => exact h ▸ hs
    | inr h => exact h
  have hkeep : Sub (aliveE s) (aliveE m) := by
    cases hsm with
    | inl h => exact h ▸ Sub.refl _
    | inr h => exact h.2
  have hguard : LexAlignedL (fun p => p ∈ L ∧ Sub (aliveE s) (aliveE p)) ks m :=
    ⟨⟨hmL, hkeep⟩, fun p hp hl => hmax p hp.1 ⟨hl, hp.2⟩⟩
  obtain ⟨hal, hk⟩ := life_guard (fun p => p ∈ L) aliveE freeE aliveN freeN s m hguard
  exact ⟨m, hmL, hal, hk⟩

end Snuffy.Book.UPTLifeGuardExists
