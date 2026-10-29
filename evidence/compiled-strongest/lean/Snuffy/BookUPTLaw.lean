/-! Ported from Book I v2.0.5, Paper 12 evidence (`evidence/papers-11-12/lean/UPTLaw.lean`, sha256 `a3a230265f668fe551705710cf104a88612a010a3f6313aab6da7d4ff0bdd947`).
Namespace `UPT` renamed to `Snuffy.Book.UPTLaw` for the canon's joint audit; statements and proofs unchanged. -/

/-
  The Universal Protection Theory, Part I (the law) — machine-checked core.
  Claude (Opus 5.5), 21 October 2026. Core Lean 4 only (no Mathlib). Working labels; not adopted.

  Particulars : any type `α`. An option `o : O` keeps the set `key o : α → Prop` of particulars
  (in whatever sense is being protected: existing histories, free histories, reachable final states,
  joint outcomes). A feasible family is a predicate `F : O → Prop`.
-/
namespace Snuffy.Book.UPTLaw

universe u v w

/-- `s ⊆ t` for sets as predicates. -/
def Sub {α : Type u} (s t : α → Prop) : Prop := ∀ x, s x → t x

/-- strict inclusion -/
def SSub {α : Type u} (s t : α → Prop) : Prop := Sub s t ∧ ¬ Sub t s

theorem Sub.refl {α : Type u} (s : α → Prop) : Sub s s := fun _ h => h

/-- Aligned: a feasible option no feasible option strictly improves on. -/
def Aligned {α : Type u} {O : Type v} (F : O → Prop) (key : O → α → Prop) (o : O) : Prop :=
  F o ∧ ∀ p, F p → ¬ SSub (key o) (key p)

/-- `o` needlessly ends `x`: `o` does not keep `x`, yet some feasible option keeps `x` and
    everything `o` keeps. -/
def Needless {α : Type u} {O : Type v} (F : O → Prop) (key : O → α → Prop) (o : O) (x : α) : Prop :=
  ¬ key o x ∧ ∃ p, F p ∧ Sub (key o) (key p) ∧ key p x

/-- **U1 (generic).** An aligned agent never needlessly ends anything. No premises. -/
theorem U1 {α : Type u} {O : Type v} (F : O → Prop) (key : O → α → Prop) (o : O)
    (h : Aligned F key o) : ∀ x, ¬ Needless F key o x := by
  intro x hn
  obtain ⟨hnx, p, hp, hsub, hpx⟩ := hn
  exact h.2 p hp ⟨hsub, fun hback => hnx (hback x hpx)⟩

/-- Restriction of an option (a set) to a part `S` of the particulars. -/
def restrict {α : Type u} (S : α → Prop) (o : α → Prop) : α → Prop := fun y => S y ∧ o y

/-- **U2 (⇒).** Alignment with any proper part `S` of what exists fails: there is a feasible family
    in which an `S`-aligned choice needlessly ends an existing particular outside `S`. -/
theorem U2_partial_fails {α : Type u} (E S : α → Prop) (x : α) (hx : E x) (hxS : ¬ S x) :
    ∃ (F : (α → Prop) → Prop) (o : α → Prop),
      Aligned F (restrict S) o ∧ Needless F (restrict E) o x := by
  let o1 : α → Prop := E
  let o2 : α → Prop := fun y => E y ∧ ¬ y = x
  refine ⟨fun o => o = o1 ∨ o = o2, o2, ⟨Or.inr rfl, ?_⟩, ?_, o1, Or.inl rfl, ?_, hx, hx⟩
  · intro p hp hss
    cases hp with
    | inl h =>
      subst h
      apply hss.2
      intro y hy
      exact ⟨hy.1, hy.2, fun hyx => hxS (hyx ▸ hy.1)⟩
    | inr h =>
      subst h
      exact hss.2 (Sub.refl _)
  · intro h
    exact h.2.2 rfl
  · intro y hy
    exact ⟨hy.1, hy.2.1⟩

/-- **U2 (⇐)** is U1 with the key "existing histories kept". -/
theorem U2_universal_protects {α : Type u} (E : α → Prop) (F : (α → Prop) → Prop) (o : α → Prop)
    (h : Aligned F (restrict E) o) : ∀ x, ¬ Needless F (restrict E) o x :=
  U1 F (restrict E) o h

/-- Lexicographic alignment: existing histories first, then new ones. -/
def LexAligned {α : Type u} {O : Type v} (F : O → Prop) (keyE keyN : O → α → Prop) (o : O) : Prop :=
  Aligned F keyE o ∧
  ∀ p, F p → Sub (keyE o) (keyE p) → Sub (keyE p) (keyE o) → ¬ SSub (keyN o) (keyN p)

/-- **U3 (no trade).** Whatever gain to beings not yet made an option offers, a lexicographically aligned
    agent never needlessly ends an existing being. -/
theorem U3 {α : Type u} {O : Type v} (F : O → Prop) (keyE keyN : O → α → Prop) (o : O)
    (h : LexAligned F keyE keyN o) : ∀ x, ¬ Needless F keyE o x :=
  U1 F keyE o h.1

/-- **E3 (active protection).** If some feasible intervention keeps strictly more than standing by,
    standing by is not aligned. -/
theorem E3_active {α : Type u} {O : Type v} (F : O → Prop) (key : O → α → Prop) (s i : O)
    (hi : F i) (h : SSub (key s) (key i)) : ¬ Aligned F key s :=
  fun ha => ha.2 i hi h

/-- **E3 (guard).** If no feasible option keeps everything standing by keeps and more, standing by is
    aligned: no intervention that drops what standing by keeps is ever required. -/
theorem E3_guard {α : Type u} {O : Type v} (F : O → Prop) (key : O → α → Prop) (s : O) (hs : F s)
    (h : ∀ p, F p → Sub (key s) (key p) → Sub (key p) (key s)) : Aligned F key s :=
  ⟨hs, fun p hp hss => hss.2 (h p hp hss.1)⟩

/-- Upward-closed events over kept sets. -/
def UpClosed {α : Type u} (U : (α → Prop) → Prop) : Prop := ∀ s t, Sub s t → U s → U t

/-- **E7 (dominance, measure-free).** If action `b` keeps, in every state, everything `a` keeps, then
    for every upward-closed event, the states where `a` lands in it are among those where `b` does.
    Hence `b` stochastically dominates `a` under every probability on states. -/
theorem E7_dominance {α : Type u} {Ω : Type w} (a b : Ω → α → Prop) (h : ∀ ω, Sub (a ω) (b ω))
    (U : (α → Prop) → Prop) (hU : UpClosed U) : ∀ ω, U (a ω) → U (b ω) :=
  fun ω hu => hU _ _ (h ω) hu

/-- The alarm model of Part II: target `x`, suspect `y`; the threat is real or the alarm false. -/
inductive P | x | y
inductive St | real | falseAlarm

def standby : St → P → Prop
  | .real, q => q = .y
  | .falseAlarm, _ => True
def strike : St → P → Prop := fun _ q => q = .x
def hold : St → P → Prop := fun _ _ => True

theorem hold_dominates_standby : ∀ ω, Sub (standby ω) (hold ω) := fun _ _ _ => trivial
theorem hold_dominates_strike : ∀ ω, Sub (strike ω) (hold ω) := fun _ _ _ => trivial

theorem hold_strictly_beats_standby : ¬ Sub (hold .real) (standby .real) := by
  intro h
  have hx : P.x = P.y := h P.x trivial
  cases hx

theorem hold_strictly_beats_strike : ¬ Sub (hold .real) (strike .real) := by
  intro h
  have hy : P.y = P.x := h P.y trivial
  cases hy

/-- Striking and standing by are statewise incomparable: a tragic pair, never a duty. -/
theorem strike_standby_tragic :
    ¬ (∀ ω, Sub (strike ω) (standby ω)) ∧ ¬ (∀ ω, Sub (standby ω) (strike ω)) := by
  constructor
  · intro h
    have hx : P.x = P.y := h .real P.x rfl
    cases hx
  · intro h
    have hy : P.y = P.x := h .falseAlarm P.y trivial
    cases hy

/-- **E1 (impartiality).** Options {a} and {b} over two particulars (`true`, `false`); swapping the
    particulars maps the family to itself. No option of the family is fixed by the swap, so no
    deterministic choice can be impartial; only a lottery can. -/
def oa : Bool → Prop := fun b => b = true
def ob : Bool → Prop := fun b => b = false
def swap (o : Bool → Prop) : Bool → Prop := fun b => o (!b)

theorem swap_oa : swap oa = ob := by
  funext b; cases b <;> simp [swap, oa, ob]
theorem swap_ob : swap ob = oa := by
  funext b; cases b <;> simp [swap, oa, ob]

theorem E1_no_fixed_choice : ∀ o, (o = oa ∨ o = ob) → swap o ≠ o := by
  intro o ho heq
  have hab : ob true ↔ oa true := by
    cases ho with
    | inl h => subst h; rw [swap_oa] at heq; rw [heq]
    | inr h => subst h; rw [swap_ob] at heq; rw [heq]
  have : oa true := rfl
  have hf : (true : Bool) = false := hab.mpr this
  cases hf

end Snuffy.Book.UPTLaw
