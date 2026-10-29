/-
Snuffy — Canon Edition v4.1: reactive refinement and Theorem 8, composition on
the good event with a joint risk account, machine-checked (working argument
§§5, 14; Chapter 5).

  * run, reactive_lockstep — Proposition 5: if the source transition commutes
    with the abstract one through the projection and observations agree, the
    source and abstract executions stay in lockstep against every controller
    and every reactive environment strategy (no fixed transcript is assumed).
  * run₂, reactive_lockstep₂ — the two-phase form, where the environment sees the
    actual post-command result before responding.
  * invariant_transfer — an abstract invariant preserved by every admitted
    abstract transition holds along the source execution.
  * theorem8_composition — Theorem 8: on the certified good event the source
    execution keeps the protection invariant at every step through the
    horizon, and the probability that it fails anywhere is at most
    P(Gᶜ) ≤ Σ δ, with no independence assumed.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.ThermoLedger

open MeasureTheory Finset

namespace Snuffy.Composition

variable {S A C Ev O : Type*}

/-! ## Reactive lockstep (Proposition 5) -/

/-- A reactive execution: the controller chooses from the observable history;
the environment responds to the history and the command. Returns the state
and the observable history. -/
def run (T : S → C → Ev → S) (obs : S → O) (ctrl : List O → C)
    (env : List O → C → Ev) (s₀ : S) : ℕ → S × List O
  | 0 => (s₀, [obs s₀])
  | k + 1 =>
    let x := run T obs ctrl env s₀ k
    let c := ctrl x.2
    let s' := T x.1 c (env x.2 c)
    (s', x.2 ++ [obs s'])

/-- **Proposition 5 (reactive lockstep).** -/
theorem reactive_lockstep (p : S → A) (T : S → C → Ev → S) (U : A → C → Ev → A)
    (hcomm : ∀ s c e, p (T s c e) = U (p s) c e)
    (obsS : S → O) (obsA : A → O) (hobs : ∀ s, obsS s = obsA (p s))
    (ctrl : List O → C) (env : List O → C → Ev) (s₀ : S) :
    ∀ k, p (run T obsS ctrl env s₀ k).1 = (run U obsA ctrl env (p s₀) k).1 ∧
      (run T obsS ctrl env s₀ k).2 = (run U obsA ctrl env (p s₀) k).2 := by
  intro k
  induction k with
  | zero => exact ⟨rfl, by simp [run, hobs]⟩
  | succ k ih =>
    obtain ⟨h1, h2⟩ := ih
    have hstate : p (T (run T obsS ctrl env s₀ k).1 (ctrl (run T obsS ctrl env s₀ k).2)
          (env (run T obsS ctrl env s₀ k).2 (ctrl (run T obsS ctrl env s₀ k).2)))
        = U (run U obsA ctrl env (p s₀) k).1 (ctrl (run U obsA ctrl env (p s₀) k).2)
          (env (run U obsA ctrl env (p s₀) k).2 (ctrl (run U obsA ctrl env (p s₀) k).2)) := by
      rw [hcomm, h1, h2]
    refine ⟨hstate, ?_⟩
    show (run T obsS ctrl env s₀ k).2 ++ [obsS _] = (run U obsA ctrl env (p s₀) k).2 ++ [obsA _]
    exact congrArg₂ HAppend.hAppend h2 (by rw [hobs, hstate])

/-- Two-phase reactive execution: the command phase produces an intermediate
state whose observation the environment sees before the response phase. -/
def run₂ (T₁ : S → C → S) (T₂ : S → Ev → S) (obs : S → O) (ctrl : List O → C)
    (env : List O → C → O → Ev) (s₀ : S) : ℕ → S × List O
  | 0 => (s₀, [obs s₀])
  | k + 1 =>
    let x := run₂ T₁ T₂ obs ctrl env s₀ k
    let c := ctrl x.2
    let m := T₁ x.1 c
    let s' := T₂ m (env x.2 c (obs m))
    (s', x.2 ++ [obs m, obs s'])

/-- **Proposition 5, two-phase form.** If the command phase commutes and its
intermediate observations agree, the environment makes the same response, and
commuting of the response phase completes the induction. -/
theorem reactive_lockstep₂ (p : S → A) (T₁ : S → C → S) (T₂ : S → Ev → S)
    (U₁ : A → C → A) (U₂ : A → Ev → A)
    (hcomm₁ : ∀ s c, p (T₁ s c) = U₁ (p s) c) (hcomm₂ : ∀ m e, p (T₂ m e) = U₂ (p m) e)
    (obsS : S → O) (obsA : A → O) (hobs : ∀ s, obsS s = obsA (p s))
    (ctrl : List O → C) (env : List O → C → O → Ev) (s₀ : S) :
    ∀ k, p (run₂ T₁ T₂ obsS ctrl env s₀ k).1 = (run₂ U₁ U₂ obsA ctrl env (p s₀) k).1 ∧
      (run₂ T₁ T₂ obsS ctrl env s₀ k).2 = (run₂ U₁ U₂ obsA ctrl env (p s₀) k).2 := by
  intro k
  induction k with
  | zero => exact ⟨rfl, by simp [run₂, hobs]⟩
  | succ k ih =>
    obtain ⟨h1, h2⟩ := ih
    set xs := run₂ T₁ T₂ obsS ctrl env s₀ k
    set xa := run₂ U₁ U₂ obsA ctrl env (p s₀) k
    have hmid : p (T₁ xs.1 (ctrl xs.2)) = U₁ xa.1 (ctrl xa.2) := by rw [hcomm₁, h1, h2]
    have hobsmid : obsS (T₁ xs.1 (ctrl xs.2)) = obsA (U₁ xa.1 (ctrl xa.2)) := by
      rw [hobs, hmid]
    have hstate : p (T₂ (T₁ xs.1 (ctrl xs.2)) (env xs.2 (ctrl xs.2) (obsS (T₁ xs.1 (ctrl xs.2)))))
        = U₂ (U₁ xa.1 (ctrl xa.2)) (env xa.2 (ctrl xa.2) (obsA (U₁ xa.1 (ctrl xa.2)))) := by
      rw [hcomm₂, hmid, hobsmid, h2]
    refine ⟨hstate, ?_⟩
    have hobsend : obsS (T₂ (T₁ xs.1 (ctrl xs.2)) (env xs.2 (ctrl xs.2) (obsS (T₁ xs.1 (ctrl xs.2)))))
        = obsA (U₂ (U₁ xa.1 (ctrl xa.2)) (env xa.2 (ctrl xa.2) (obsA (U₁ xa.1 (ctrl xa.2))))) := by
      rw [hobs, hstate]
    show xs.2 ++ [obsS _, obsS _] = xa.2 ++ [obsA _, obsA _]
    exact congrArg₂ HAppend.hAppend h2 (by rw [hobsend, hobsmid])

/-- **Invariant transfer.** An abstract invariant that holds initially and is
preserved by every admitted abstract transition holds along the source
execution, through the projection. -/
theorem invariant_transfer (p : S → A) (T : S → C → Ev → S) (U : A → C → Ev → A)
    (hcomm : ∀ s c e, p (T s c e) = U (p s) c e)
    (obsS : S → O) (obsA : A → O) (hobs : ∀ s, obsS s = obsA (p s))
    (ctrl : List O → C) (env : List O → C → Ev) (s₀ : S)
    (Inv : A → Prop) (hinit : Inv (p s₀)) (hpres : ∀ a c e, Inv a → Inv (U a c e)) :
    ∀ k, Inv (p (run T obsS ctrl env s₀ k).1) := by
  intro k
  rw [(reactive_lockstep p T U hcomm obsS obsA hobs ctrl env s₀ k).1]
  induction k with
  | zero => exact hinit
  | succ k ih => exact hpres _ _ _ ih

/-! ## Theorem 8 -/

/-- **Theorem 8 (composition on the good event, with a joint risk account).**
In each world `ω` the instance supplies a source execution. On the certified
good event `G` the component certificates hold: the source refines the
abstract transition, observations agree, the initial witness establishes the
protection invariant, and every admitted abstract transition preserves it.
Then on `G` the invariant holds at every step through the horizon, for every
covered particular at once; and since `G` fails only through the charged
accounts, the probability that the invariant fails anywhere by the horizon is
at most `P(Gᶜ) ≤ Σ δ`. -/
theorem theorem8_composition {Ω ι : Type*} [MeasurableSpace Ω] (μ : Measure Ω)
    (accounts : Finset ι) (E : ι → Set Ω) (δ : ι → ENNReal) (G : Set Ω)
    (hG : Gᶜ ⊆ ⋃ i ∈ accounts, E i) (hδ : ∀ i ∈ accounts, μ (E i) ≤ δ i)
    (p : S → A) (T : Ω → S → C → Ev → S) (U : Ω → A → C → Ev → A)
    (obsS : S → O) (obsA : A → O) (ctrl : Ω → List O → C) (env : Ω → List O → C → Ev)
    (s₀ : Ω → S) (Inv : A → Prop)
    (hcert : ∀ ω ∈ G, (∀ s c e, p (T ω s c e) = U ω (p s) c e) ∧
      (∀ s, obsS s = obsA (p s)) ∧ Inv (p (s₀ ω)) ∧ (∀ a c e, Inv a → Inv (U ω a c e)))
    (horizon : ℕ) :
    (∀ ω ∈ G, ∀ k ≤ horizon, Inv (p (run (T ω) obsS (ctrl ω) (env ω) (s₀ ω) k).1)) ∧
    μ {ω | ∃ k ≤ horizon, ¬ Inv (p (run (T ω) obsS (ctrl ω) (env ω) (s₀ ω) k).1)}
      ≤ ∑ i ∈ accounts, δ i := by
  have hgood : ∀ ω ∈ G, ∀ k, Inv (p (run (T ω) obsS (ctrl ω) (env ω) (s₀ ω) k).1) := by
    intro ω hω k
    obtain ⟨hc, ho, hi, hp⟩ := hcert ω hω
    exact invariant_transfer p (T ω) (U ω) hc obsS obsA ho (ctrl ω) (env ω) (s₀ ω) Inv hi hp k
  refine ⟨fun ω hω k _ => hgood ω hω k, ?_⟩
  have hsub : {ω | ∃ k ≤ horizon, ¬ Inv (p (run (T ω) obsS (ctrl ω) (env ω) (s₀ ω) k).1)}
      ⊆ Gᶜ := by
    rintro ω ⟨k, -, hk⟩ hω
    exact hk (hgood ω hω k)
  obtain ⟨h1, h2⟩ := Snuffy.ThermoLedger.canon_invariant μ accounts E δ G _ hsub hG hδ
  exact h1.trans h2

end Snuffy.Composition
