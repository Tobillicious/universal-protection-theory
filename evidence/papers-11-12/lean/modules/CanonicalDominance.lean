import UPTLawLife

namespace CodexCanonical
open UPT
universe u v w

/-- Non-strict canonical comparison, including equality of every stage key. -/
def LexLE {α : Type u} {O : Type v} : List (O → α → Prop) → O → O → Prop
  | [], _, _ => True
  | k :: ks, o, p => SSub (k o) (k p) ∨ (Equiv (k o) (k p) ∧ LexLE ks o p)

def AllKeysEq {α : Type u} {O : Type v} : List (O → α → Prop) → O → O → Prop
  | [], _, _ => True
  | k :: ks, o, p => Equiv (k o) (k p) ∧ AllKeysEq ks o p

theorem le_refl {α : Type u} {O : Type v} :
    ∀ (ks : List (O → α → Prop)) (o : O), LexLE ks o o
  | [], _ => trivial
  | _ :: ks, o => Or.inr ⟨⟨Sub.refl _, Sub.refl _⟩, le_refl ks o⟩

theorem le_trans {α : Type u} {O : Type v} :
    ∀ (ks : List (O → α → Prop)) (o p q : O), LexLE ks o p → LexLE ks p q → LexLE ks o q
  | [], _, _, _, _, _ => trivial
  | _ :: ks, o, p, q, h1, h2 => by
    cases h1 with
    | inl s1 =>
      cases h2 with
      | inl s2 => exact Or.inl (SSub.trans_sub s1 s2.1)
      | inr e2 => exact Or.inl (SSub.trans_sub s1 e2.1.1)
    | inr e1 =>
      cases h2 with
      | inl s2 => exact Or.inl (Sub.trans_ssub e1.1.1 s2)
      | inr e2 =>
        exact Or.inr ⟨⟨Sub.trans e1.1.1 e2.1.1, Sub.trans e2.1.2 e1.1.2⟩,
          le_trans ks o p q e1.2 e2.2⟩

theorem le_iff_eq_or_better {α : Type u} {O : Type v} :
    ∀ (ks : List (O → α → Prop)) (o p : O),
      LexLE ks o p ↔ AllKeysEq ks o p ∨ LexBetter ks o p
  | [], _, _ => ⟨fun _ => Or.inl trivial, fun _ => trivial⟩
  | _ :: ks, o, p => by
    constructor
    · intro h
      cases h with
      | inl hs => exact Or.inr (Or.inl hs)
      | inr he =>
        cases (le_iff_eq_or_better ks o p).mp he.2 with
        | inl ht => exact Or.inl ⟨he.1, ht⟩
        | inr ht => exact Or.inr (Or.inr ⟨he.1, ht⟩)
    · intro h
      cases h with
      | inl he => exact Or.inr ⟨he.1, (le_iff_eq_or_better ks o p).mpr (Or.inl he.2)⟩
      | inr hb =>
        cases hb with
        | inl hs => exact Or.inl hs
        | inr he => exact Or.inr ⟨he.1, (le_iff_eq_or_better ks o p).mpr (Or.inr he.2)⟩

def Upward {α : Type u} {O : Type v} (ks : List (O → α → Prop)) (U : O → Prop) : Prop :=
  ∀ o p, LexLE ks o p → U o → U p

/-- Exact measure-free boundary. All upward events preserve state membership iff the statewise comparison
    holds. The reverse direction uses principal upsets, not an assumption about a particular probability. -/
theorem all_events_iff_statewise {α : Type u} {O : Type v} {Ω : Type w}
    (ks : List (O → α → Prop)) (a b : Ω → O) :
    (∀ U, Upward ks U → ∀ ω, U (a ω) → U (b ω)) ↔ ∀ ω, LexLE ks (a ω) (b ω) := by
  constructor
  · intro h ω
    exact h (fun z => LexLE ks (a ω) z)
      (fun o p hop hao => le_trans ks (a ω) o p hao hop) ω (le_refl ks (a ω))
  · intro h U hU ω ha
    exact hU (a ω) (b ω) (h ω) ha

/-- A sufficient full-canonical statewise top premise for every feasible action. -/
theorem full_canonical_top {α : Type u} {O : Type v} {Ω A : Type w}
    (ks : List (O → α → Prop)) (Feas : A → Prop) (out : A → Ω → O) (hold : A)
    (htop : ∀ a, Feas a → ∀ ω, LexLE ks (out a ω) (out hold ω)) :
    ∀ a, Feas a → ∀ U, Upward ks U → ∀ ω, U (out a ω) → U (out hold ω) := by
  intro a ha
  exact (all_events_iff_statewise ks (out a) (out hold)).mpr (htop a ha)

/-- Boolean event mass of a finite atomic measure with natural weights. Normalising by total weight
    transports this order to the corresponding rational probability. -/
def mass {Ω O : Type} (a : Ω → O) (U : O → Bool) : List (Ω × Nat) → Nat
  | [] => 0
  | (ω, n) :: ws => (if U (a ω) then n else 0) + mass a U ws

theorem mass_mono {Ω O : Type} (a b : Ω → O) (U : O → Bool)
    (h : ∀ ω, U (a ω) = true → U (b ω) = true) :
    ∀ ws, mass a U ws ≤ mass b U ws
  | [] => Nat.le_refl _
  | (ω,n) :: ws => by
    have hs : (if U (a ω) then n else 0) ≤ (if U (b ω) then n else 0) := by
      cases ha : U (a ω) with
      | false => simp
      | true => simp [h ω ha]
    exact Nat.add_le_add hs (mass_mono a b U h ws)

#print axioms le_refl
#print axioms le_trans
#print axioms le_iff_eq_or_better
#print axioms all_events_iff_statewise
#print axioms full_canonical_top
#print axioms mass_mono
end CodexCanonical
