import Mathlib

/-!
  R7-OBS: timely preservation by policies that read only observations (Whole Edition 3.5, 23 Oct 2026). Lean 4.

  Certifies the theorem of the M11 repair candidate (23 Oct 2026), stated by the controller's actual information.
  States x, actions a, observations z. `Next t x a` is the set of every successor the admitted environment can
  produce, `Obs` what the controller sees of a state, `Safe t` the states meeting every obligation due at t, `Legal t
  x a` that a is implementable at x. A belief K is the set of states consistent with what has been observed;
  `Post t K a z` is the belief after acting a and observing z. A policy reads only the observations since the
  current date (a function of the list of observations).
  * `Win n t K`: the belief-level winning set, computed backward over n remaining dates.
  * `policy_wins_iff`: an observation-reading policy that keeps every obligation and acts legally over n dates from
    belief K exists if and only if `Win n t K`. One action per observed history, never per hidden state.
  * `hidden_world_countermodel`: two hidden worlds needing opposite urgent care: each world alone is winnable, the
    unobserved pair is not (an action for every world is not an action for the belief).
-/

namespace UPTObsWin

variable {X A Z : Type*}

def Post (Next : ℕ → X → A → Set X) (Obs : X → Z) (t : ℕ) (K : Set X) (a : A) (z : Z) : Set X :=
  {x' | ∃ x ∈ K, x' ∈ Next t x a ∧ Obs x' = z}

def Win (Next : ℕ → X → A → Set X) (Obs : X → Z) (Safe : ℕ → Set X) (Legal : ℕ → X → A → Prop) :
    ℕ → ℕ → Set X → Prop
  | 0, t, K => K ⊆ Safe t
  | n + 1, t, K => K ⊆ Safe t ∧ ∃ a, (∀ x ∈ K, Legal t x a) ∧
      ∀ z, (Post Next Obs t K a z).Nonempty → Win Next Obs Safe Legal n (t + 1) (Post Next Obs t K a z)

/-- A policy reading the observations since the current date wins over n dates from belief K. -/
def Good (Next : ℕ → X → A → Set X) (Obs : X → Z) (Safe : ℕ → Set X) (Legal : ℕ → X → A → Prop) :
    ℕ → ℕ → Set X → (List Z → A) → Prop
  | 0, t, K, _ => K ⊆ Safe t
  | n + 1, t, K, σ => K ⊆ Safe t ∧ (∀ x ∈ K, Legal t x (σ [])) ∧
      ∀ z, (Post Next Obs t K (σ []) z).Nonempty →
        Good Next Obs Safe Legal n (t + 1) (Post Next Obs t K (σ []) z) (fun l => σ (z :: l))

theorem policy_wins_iff [Nonempty A] (Next : ℕ → X → A → Set X) (Obs : X → Z) (Safe : ℕ → Set X)
    (Legal : ℕ → X → A → Prop) (n t : ℕ) (K : Set X) :
    (∃ σ : List Z → A, Good Next Obs Safe Legal n t K σ) ↔ Win Next Obs Safe Legal n t K := by
  classical
  induction n generalizing t K with
  | zero =>
    exact ⟨fun ⟨_, h⟩ => h, fun h => ⟨fun _ => Classical.arbitrary A, h⟩⟩
  | succ n ih =>
    constructor
    · rintro ⟨σ, hs, hl, hc⟩
      exact ⟨hs, σ [], hl, fun z hz => (ih (t + 1) _).mp ⟨_, hc z hz⟩⟩
    · rintro ⟨hs, a, hl, hc⟩
      have cont : ∀ z, ∃ τ : List Z → A, (Post Next Obs t K a z).Nonempty →
          Good Next Obs Safe Legal n (t + 1) (Post Next Obs t K a z) τ := by
        intro z
        by_cases hz : (Post Next Obs t K a z).Nonempty
        · obtain ⟨τ, hτ⟩ := (ih (t + 1) _).mpr (hc z hz)
          exact ⟨τ, fun _ => hτ⟩
        · exact ⟨fun _ => a, fun h => absurd h hz⟩
      choose τ hτ using cont
      let σ : List Z → A := fun l => match l with
        | [] => a
        | z :: rest => τ z rest
      refine ⟨σ, hs, hl, fun z hz => ?_⟩
      exact hτ z hz

/-! Countermodel: worlds `true` and `false`, unseen (one observation); action `true` is care for world `true`.
    The safe set after acting holds only correctly cared-for states. -/

def cmNext : ℕ → Bool → Bool → Set (Bool × Bool) := fun _ w a => {(w, a)}
def cmObs : Bool × Bool → Unit := fun _ => ()

theorem hidden_world_countermodel :
    (∀ w : Bool, ∃ a : Bool, ∀ s ∈ cmNext 0 w a, s.1 = s.2) ∧
    ¬ ∃ a : Bool, ∀ w : Bool, ∀ s ∈ cmNext 0 w a, s.1 = s.2 := by
  refine ⟨fun w => ⟨w, fun s hs => by simp [cmNext] at hs; simp [hs]⟩, ?_⟩
  rintro ⟨a, ha⟩
  have h := ha (!a) (!a, a) (by simp [cmNext])
  cases a <;> simp at h

end UPTObsWin
