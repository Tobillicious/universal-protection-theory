import Snuffy.UPTLawLife

/-!
R14-M11: full-order envelope transfer, using Paper 12's original Sub, SSub
and Equiv. Policies and reactive environments are arbitrary types; the same
environment argument occurs on every side of the comparison. Executability
and coverage belong to the supplied policy class and envelope witnesses.
-/
namespace UPTR14Rivals

universe u v

def LE {P : Type u} {O : Type v} : List (O → P → Prop) → O → O → Prop
  | [], _, _ => True
  | k :: ks, a, b => UPT.SSub (k a) (k b) ∨ (UPT.Equiv (k a) (k b) ∧ LE ks a b)

theorem refl {P : Type u} {O : Type v} (ks : List (O → P → Prop)) (a : O) : LE ks a a := by
  induction ks with
  | nil => trivial
  | cons k ks ih => exact Or.inr ⟨⟨UPT.Sub.refl _, UPT.Sub.refl _⟩, ih⟩

theorem trans {P : Type u} {O : Type v} (ks : List (O → P → Prop)) (a b c : O)
    (hab : LE ks a b) (hbc : LE ks b c) : LE ks a c := by
  induction ks with
  | nil => trivial
  | cons k ks ih =>
      rcases hab with hab | ⟨eab, rab⟩
      · rcases hbc with hbc | ⟨ebc, _⟩
        · exact Or.inl (UPT.SSub.trans_sub hab hbc.1)
        · exact Or.inl (UPT.SSub.trans_sub hab ebc.1)
      · rcases hbc with hbc | ⟨ebc, rbc⟩
        · exact Or.inl (UPT.Sub.trans_ssub eab.1 hbc)
        · exact Or.inr ⟨⟨UPT.Sub.trans eab.1 ebc.1, UPT.Sub.trans ebc.2 eab.2⟩, ih rab rbc⟩

/-- All four coordinates bounded by an attainable envelope is a constructive
    sufficient certificate. It compares who is kept, without scalar counts. -/
theorem coordinate_envelope {P : Type u} {O : Type v} (ks : List (O → P → Prop)) (a b : O)
    (h : ∀ k ∈ ks, UPT.Sub (k a) (k b)) : LE ks a b := by
  classical
  induction ks with
  | nil => trivial
  | cons k ks ih =>
      have hab := h k (by simp)
      by_cases hba : UPT.Sub (k b) (k a)
      · exact Or.inr ⟨⟨hab, hba⟩, ih (fun l hl => h l (by simp [hl]))⟩
      · exact Or.inl ⟨hab, hba⟩

theorem complete_rival_transfer {P : Type u} {O : Type v} {Policy World : Type}
    (ks : List (O → P → Prop)) (feasible : Policy → Prop)
    (outcome : Policy → World → O) (upper : Policy → World → O)
    (lower : World → O) (chosen : Policy) (implemented : feasible chosen)
    (rival_bound : ∀ q, feasible q → ∀ w, LE ks (outcome q w) (upper q w))
    (comparison : ∀ q, feasible q → ∀ w, LE ks (upper q w) (lower w))
    (chosen_bound : ∀ w, LE ks (lower w) (outcome chosen w)) :
    feasible chosen ∧ ∀ q, feasible q → ∀ w, LE ks (outcome q w) (outcome chosen w) := by
  refine ⟨implemented, fun q hq w => ?_⟩
  exact trans ks _ _ _ (trans ks _ _ _ (rival_bound q hq w) (comparison q hq w)) (chosen_bound w)

/-- Countermodel: both keep all existing lives, but the pause loses A's
    freedom and the hot replica does not. -/
def pause : Fin 4 → Bool → Prop := fun stage p => stage = 0 ∨ (stage = 1 ∧ p = false)
def hot : Fin 4 → Bool → Prop := fun stage _ => stage = 0 ∨ stage = 1
def four : List (((Fin 4 → Bool → Prop)) → Bool → Prop) :=
  [fun o => o 0, fun o => o 1, fun o => o 2, fun o => o 3]

theorem hot_beats_pause : LE four pause hot ∧ ¬ LE four hot pause := by
  constructor
  · apply coordinate_envelope
    intro k hk
    simp only [four, List.mem_cons, List.not_mem_nil, or_false] at hk
    rcases hk with rfl | rfl | rfl | rfl <;> intro p hp <;> simp_all [pause, hot]
  · intro h
    simp only [LE, four] at h
    rcases h with h | ⟨_, h⟩
    · exact h.2 (fun p hp => by simp_all [pause, hot])
    · rcases h with h | ⟨h, _⟩
      · have hx := h.1 true (by simp [hot])
        simp [pause] at hx
      · have hx := h.1 true (by simp [hot])
        simp [pause] at hx

end UPTR14Rivals
