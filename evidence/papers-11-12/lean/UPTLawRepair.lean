/-
  UPT law, repair round 1 (after Codex's non-author read, 21 October 2026). Claude (Opus 5.5).
  Core Lean 4 only. The definitions are repeated verbatim from the sealed `UPTLaw.lean` (namespace UPT),
  so this file checks standalone. Working labels; not adopted.
-/
namespace UPT

universe u v

def Sub {α : Type u} (s t : α → Prop) : Prop := ∀ x, s x → t x
def SSub {α : Type u} (s t : α → Prop) : Prop := Sub s t ∧ ¬ Sub t s
theorem Sub.refl {α : Type u} (s : α → Prop) : Sub s s := fun _ h => h
def Aligned {α : Type u} {O : Type v} (F : O → Prop) (key : O → α → Prop) (o : O) : Prop :=
  F o ∧ ∀ p, F p → ¬ SSub (key o) (key p)
def Needless {α : Type u} {O : Type v} (F : O → Prop) (key : O → α → Prop) (o : O) (x : α) : Prop :=
  ¬ key o x ∧ ∃ p, F p ∧ Sub (key o) (key p) ∧ key p x
theorem U1 {α : Type u} {O : Type v} (F : O → Prop) (key : O → α → Prop) (o : O)
    (h : Aligned F key o) : ∀ x, ¬ Needless F key o x := by
  intro x hn
  obtain ⟨hnx, p, hp, hsub, hpx⟩ := hn
  exact h.2 p hp ⟨hsub, fun hback => hnx (hback x hpx)⟩
def restrict {α : Type u} (S : α → Prop) (o : α → Prop) : α → Prop := fun y => S y ∧ o y

/-- The protection guarantee of an alignment criterion `S`: every choice it admits, in every feasible
    family, never needlessly ends an existing particular. -/
def Guarantees {α : Type u} (E S : α → Prop) : Prop :=
  ∀ (F : (α → Prop) → Prop) (o : α → Prop), Aligned F (restrict S) o → ∀ x, ¬ Needless F (restrict E) o x

/-- If `S` and `E` agree pointwise, `S`-alignment is `E`-alignment. -/
theorem aligned_congr {α : Type u} (E S : α → Prop) (hSE : ∀ x, S x ↔ E x)
    (F : (α → Prop) → Prop) (o : α → Prop) (h : Aligned F (restrict S) o) : Aligned F (restrict E) o := by
  refine ⟨h.1, fun p hp hss => h.2 p hp ⟨?_, ?_⟩⟩
  · intro y hy; exact ⟨(hSE y).mpr ((hss.1 y ⟨(hSE y).mp hy.1, hy.2⟩).1),
                       (hss.1 y ⟨(hSE y).mp hy.1, hy.2⟩).2⟩
  · intro hback; apply hss.2; intro y hy
    have := hback y ⟨(hSE y).mpr hy.1, hy.2⟩
    exact ⟨(hSE y).mp this.1, this.2⟩

/-- **U2★ (exact).** When something exists, an alignment criterion guarantees protection of everything that
    exists **if and only if** it is alignment with exactly what exists. Missing any existing particular fails
    (U2); counting any not-yet-existing particular at the same priority fails too (the U3 lesson). -/
theorem U2_star {α : Type u} (E S : α → Prop) (hne : ∃ a, E a) :
    Guarantees E S ↔ (∀ x, S x ↔ E x) := by
  constructor
  · intro hg x
    apply Classical.byContradiction
    intro hnot
    cases Classical.em (E x) with
    | inl hEx =>
      -- x exists but S misses it: two options, E and E minus x
      have hSx : ¬ S x := fun hSx => hnot ⟨fun _ => hEx, fun _ => hSx⟩
      let o1 : α → Prop := E
      let o2 : α → Prop := fun y => E y ∧ ¬ y = x
      apply hg (fun o => o = o1 ∨ o = o2) o2 ⟨Or.inr rfl, ?_⟩ x ⟨fun h => h.2.2 rfl, o1, Or.inl rfl,
        fun y hy => ⟨hy.1, hy.2.1⟩, hEx, hEx⟩
      intro p hp hss
      cases hp with
      | inl h => subst h; exact hss.2 (fun y hy => ⟨hy.1, hy.2, fun hyx => hSx (hyx ▸ hy.1)⟩)
      | inr h => subst h; exact hss.2 (Sub.refl _)
    | inr hnE =>
      -- x does not exist but S counts it: options {x} and {a}
      have hSx : S x := Classical.byContradiction fun hSx =>
        hnot ⟨fun h => absurd h hSx, fun h => absurd h hnE⟩
      obtain ⟨a, hEa⟩ := hne
      have hax : ¬ a = x := fun h => hnE (h ▸ hEa)
      let o : α → Prop := fun y => y = x
      let p : α → Prop := fun y => y = a
      apply hg (fun q => q = o ∨ q = p) o ⟨Or.inl rfl, ?_⟩ a
        ⟨fun h => hax h.2, p, Or.inr rfl, fun y hy => absurd (hy.2 ▸ hy.1) hnE, hEa, rfl⟩
      intro q hq hss
      cases hq with
      | inl h => subst h; exact hss.2 (Sub.refl _)
      | inr h =>
        subst h
        have := (hss.1 x ⟨hSx, rfl⟩).2
        exact hax this.symm
  · intro hSE F o h
    exact U1 F (restrict E) o (aligned_congr E S hSE F o h)

/-- U2★'s hypothesis that something exists is needed: with nothing existing, a criterion that differs from
    `E` still vacuously guarantees protection. -/
theorem U2_star_hypothesis_needed :
    Guarantees (fun _ : Bool => False) (fun _ => True) ∧
    ¬ (∀ x : Bool, (fun _ : Bool => True) x ↔ (fun _ : Bool => False) x) := by
  constructor
  · intro F o h x hn
    obtain ⟨_, p, _, _, hpx⟩ := hn
    exact hpx.1
  · intro h
    exact (h true).mp trivial

/-- **E5(b) repaired as a rule, D-PROG.** Progressive protection is the retention rule: every update keeps
    a superset of what is held. Under it, anything once kept is kept at every later step. -/
theorem progressive_retention {α : Type u} (r : Nat → α → Prop) (hret : ∀ n, Sub (r n) (r (n + 1))) :
    ∀ n k, Sub (r n) (r (n + k)) := by
  intro n k
  induction k with
  | zero => exact Sub.refl _
  | succ k ih => exact fun x hx => hret (n + k) x (ih x hx)

/-- Without the retention rule, maximality alone permits a switch that loses something (Codex F3):
    options {a} and {b} are both aligned. -/
theorem switch_without_retention :
    Aligned (fun o : Bool → Prop => o = (fun b => b = true) ∨ o = (fun b => b = false)) id
        (fun b => b = true) ∧
    Aligned (fun o : Bool → Prop => o = (fun b => b = true) ∨ o = (fun b => b = false)) id
        (fun b => b = false) := by
  constructor
  · refine ⟨Or.inl rfl, fun p hp hss => ?_⟩
    cases hp with
    | inl h => subst h; exact hss.2 (Sub.refl _)
    | inr h => subst h; have : (true : Bool) = false := hss.1 true rfl; cases this
  · refine ⟨Or.inr rfl, fun p hp hss => ?_⟩
    cases hp with
    | inl h => subst h; have : (false : Bool) = true := hss.1 false rfl; cases this
    | inr h => subst h; exact hss.2 (Sub.refl _)

/-- **E7 (repaired form).** A feasible action that is a statewise top (keeps, in every state, everything
    any feasible action keeps) dominates every feasible action on every upward-closed event. -/
def UpClosed {α : Type u} (U : (α → Prop) → Prop) : Prop := ∀ s t, Sub s t → U s → U t
theorem E7_top {α : Type u} {Ω : Type v} {A : Type v} (Feas : A → Prop) (out : A → Ω → α → Prop) (h : A)
    (htop : ∀ a, Feas a → ∀ ω, Sub (out a ω) (out h ω)) (U : (α → Prop) → Prop) (hU : UpClosed U) :
    ∀ a, Feas a → ∀ ω, U (out a ω) → U (out h ω) :=
  fun a ha ω hu => hU _ _ (htop a ha ω) hu

end UPT
