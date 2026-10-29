/-! Ported from Book I v2.0.5, Paper 12 evidence (`evidence/papers-11-12/lean/UPTRestraint.lean`, sha256 `30471bb2ac30dd96db5a2873d703c43f39739f58f01c677de763c7e458a651ae`).
Namespace `UPTRestraint` renamed to `Snuffy.Book.UPTRestraint` for the canon's joint audit; statements and proofs unchanged. -/

/-
Restraint, judged only from the agent's OWN options (Paper 12, section 3, "Restraint"; author's O-1 ruling).
Sets of particulars are predicates `α → Prop`, as in UPTLaw.lean. These theorems generalise the exhaustive
check `checks/o1_check.py` (every family of at most three options over three particulars) to all sizes.
-/
namespace Snuffy.Book.UPTRestraint

universe u

/-- `s ⊆ t` for sets as predicates. -/
def Sub {α : Type u} (s t : α → Prop) : Prop := ∀ x, s x → t x

/-- strict inclusion -/
def SSub {α : Type u} (s t : α → Prop) : Prop := Sub s t ∧ ¬ Sub t s

theorem ssub_irrefl {α : Type u} (s : α → Prop) : ¬ SSub s s := fun h => h.2 h.1

theorem ssub_trans {α : Type u} {a b c : α → Prop} (hab : SSub a b) (hbc : SSub b c) : SSub a c :=
  ⟨fun x hx => hbc.1 x (hab.1 x hx), fun hca => hab.2 (fun x hbx => hca x (hbc.1 x hbx))⟩

/-- An act `a` (the set it keeps) is restrainable from the agent's own feasible acts `A` when some own
alternative keeps everything `a` keeps and also something `a` ends. No protector option is consulted. -/
def Restrainable {α : Type u} (A : (α → Prop) → Prop) (a : α → Prop) : Prop :=
  ∃ b, A b ∧ SSub a b

/-- **D1.** Restraining by an own strictly larger alternative keeps the restrained agent whenever its
act kept it, keeps everything the act kept, and keeps something the act ended. -/
theorem restraint_keeps {α : Type u} (A : (α → Prop) → Prop) (a b : α → Prop) (y : α)
    (hb : A b ∧ SSub a b) : (a y → b y) ∧ Sub a b ∧ ∃ x, b x ∧ ¬ a x := by
  obtain ⟨_, hsub, hns⟩ := hb
  refine ⟨hsub y, hsub, ?_⟩
  apply Classical.byContradiction
  intro h
  apply hns
  intro x hbx
  apply Classical.byContradiction
  intro hax
  exact h ⟨x, hbx, hax⟩

/-- Helper: in a finite list, any strict superset `b` of `a` can be climbed to an element that is still a
strict superset of `a` and has no strict superset among the list's elements. -/
theorem climb {α : Type u} (a : α → Prop) :
    ∀ (L : List (α → Prop)) (b : α → Prop), SSub a b →
      ∃ m, (m = b ∨ m ∈ L) ∧ SSub a m ∧ ∀ c, c ∈ L → ¬ SSub m c := by
  intro L
  induction L with
  | nil => intro b hab; exact ⟨b, Or.inl rfl, hab, fun c hc => nomatch hc⟩
  | cons x L ih =>
    intro b hab
    obtain ⟨m, hmem, ham, hmax⟩ := ih b hab
    by_cases hmx : SSub m x
    · refine ⟨x, Or.inr List.mem_cons_self, ssub_trans ham hmx, ?_⟩
      intro c hc hxc
      cases hc with
      | head => exact ssub_irrefl x hxc
      | tail _ hcL => exact hmax c hcL (ssub_trans hmx hxc)
    · refine ⟨m, ?_, ham, ?_⟩
      · cases hmem with
        | inl h => exact Or.inl h
        | inr h => exact Or.inr (List.mem_cons_of_mem x h)
      · intro c hc hmc
        cases hc with
        | head => exact hmx hmc
        | tail _ hcL => exact hmax c hcL hmc

/-- **A maximal restraint exists.** With finitely many own acts (a list), a restrainable act has a
least-restrictive restraint: an own act strictly above it that no own act strictly exceeds. -/
theorem maximal_restraint_exists {α : Type u} (L : List (α → Prop)) (a : α → Prop)
    (h : ∃ b, b ∈ L ∧ SSub a b) : ∃ m, m ∈ L ∧ SSub a m ∧ ∀ c, c ∈ L → ¬ SSub m c := by
  obtain ⟨b, hbL, hab⟩ := h
  obtain ⟨m, hmem, ham, hmax⟩ := climb a L b hab
  refine ⟨m, ?_, ham, hmax⟩
  cases hmem with
  | inl h => exact h ▸ hbL
  | inr h => exact h

/-- **D3 (predators).** If the act keeps `y`, and every own alternative that keeps `z` ends `y`, then no
own alternative that keeps everything the act keeps can keep `z`: restraint cannot save `z`. -/
theorem predator_tragic {α : Type u} (A : (α → Prop) → Prop) (a : α → Prop) (y z : α)
    (hay : a y) (hpred : ∀ b, A b → b z → ¬ b y) : ∀ b, A b → Sub a b → ¬ b z :=
  fun b hb hsub hbz => hpred b hb hbz (hsub y hay)

inductive P | y | z

def hunt : P → Prop := fun p => p = P.y
def starve : P → Prop := fun p => p = P.z

/-- **D3, the canonical pair.** With only hunt (keeps the predator) and starve (keeps the prey),
hunting is not restrainable: predator and prey form a tragic pair. -/
theorem hunting_not_restrainable : ¬ Restrainable (fun b => b = hunt ∨ b = starve) hunt := by
  intro ⟨b, hb, hsub⟩
  cases hb with
  | inl h => exact ssub_irrefl hunt (h ▸ hsub)
  | inr h =>
    subst h
    have : starve P.y := hsub.1 P.y rfl
    exact P.noConfusion this

/-- **D4 (minds).** An act that ends someone is restrainable whenever the agent has an own alternative
that ends no one. -/
theorem harmless_alternative_restrains {α : Type u} (A : (α → Prop) → Prop) (a : α → Prop)
    (hall : ∃ b, A b ∧ ∀ x, b x) (hends : ∃ x, ¬ a x) : Restrainable A a := by
  obtain ⟨b, hb, hball⟩ := hall
  obtain ⟨x, hx⟩ := hends
  exact ⟨b, hb, fun y _ => hball y, fun hba => hx (hba x (hball x))⟩

end Snuffy.Book.UPTRestraint
