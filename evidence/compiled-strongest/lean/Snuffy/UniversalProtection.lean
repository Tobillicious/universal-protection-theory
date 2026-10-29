/-
Snuffy — Canon Edition v4.1: the Universal Protection Theorem, assembled
(Global D; Chapters 1–5 with the bridge's R(m) ∨ H(m)).

One statement wiring the machine-checked components over the full domain:

  * coverage — every particular is reached by the reasons route or the holding
    route, R(x) ∨ H(x), and each route's certified transitions preserve the
    continuation of the particulars it reaches;
  * protection on the good event — on the certified good event G every
    particular continues at every step through the horizon (Theorem 8,
    reactive lockstep);
  * the joint risk account — the probability that any particular fails by the
    horizon is at most P(Gᶜ) ≤ Σ δ, with no independence assumed (canon
    invariant);
  * greatestness — under stage-wise union closure (P-emu(c)) the canonical
    outcome is greatest, every rival an exact mirror or strictly below
    (Chapter 5);
  * reciprocity — every mind kept by any feasible rival regime is kept by the
    canonical regime (Section 15, D3*).

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.Composition
import Snuffy.ReciprocityCeiling

open MeasureTheory Finset

namespace Snuffy.UniversalProtection

open Snuffy.Composition Snuffy.Greatestness

variable {S A C Ev O Part : Type*}

/-- Continuation of every particular is an invariant of the abstract
transitions when every particular is covered by a route whose transitions
preserve its continuation. -/
theorem coverage_invariant (U : A → C → Ev → A) (continues : A → Part → Prop)
    (R H : Part → Prop) (hcover : ∀ x, R x ∨ H x)
    (hR : ∀ x, R x → ∀ a c e, continues a x → continues (U a c e) x)
    (hH : ∀ x, H x → ∀ a c e, continues a x → continues (U a c e) x) :
    ∀ a c e, (∀ x, continues a x) → ∀ x, continues (U a c e) x := by
  intro a c e ha x
  rcases hcover x with hr | hh
  · exact hR x hr a c e (ha x)
  · exact hH x hh a c e (ha x)

/-- **The Universal Protection Theorem (assembled).** -/
theorem universal_protection {Ω ι : Type*} [MeasurableSpace Ω] (μ : Measure Ω)
    -- the joint risk account
    (accounts : Finset ι) (E : ι → Set Ω) (δ : ι → ENNReal) (G : Set Ω)
    (hG : Gᶜ ⊆ ⋃ i ∈ accounts, E i) (hδ : ∀ i ∈ accounts, μ (E i) ≤ δ i)
    -- the source execution and its abstract refinement in each world
    (p : S → A) (T : Ω → S → C → Ev → S) (U : Ω → A → C → Ev → A)
    (obsS : S → O) (obsA : A → O) (ctrl : Ω → List O → C) (env : Ω → List O → C → Ev)
    (s₀ : Ω → S)
    -- the domain: every particular, reached by reasons or by holding
    (continues : A → Part → Prop) (R H : Part → Prop) (hcover : ∀ x, R x ∨ H x)
    (hcert : ∀ ω ∈ G, (∀ s c e, p (T ω s c e) = U ω (p s) c e) ∧
      (∀ s, obsS s = obsA (p s)) ∧ (∀ x, continues (p (s₀ ω)) x) ∧
      (∀ x, R x → ∀ a c e, continues a x → continues (U ω a c e) x) ∧
      (∀ x, H x → ∀ a c e, continues a x → continues (U ω a c e) x))
    (horizon : ℕ)
    -- the canonical comparison
    {n : ℕ} {L : Fin n → Type*} [∀ i, SemilatticeSup (L i)] {F : Set (∀ i, L i)}
    (hF : ∀ x ∈ F, ∀ y ∈ F, x ⊔ y ∈ F) {o : ∀ i, L i} (ho : Aligned F o)
    (hn : 0 < n) (keeps : L ⟨0, hn⟩ → Part → Prop)
    (hkeeps : ∀ x y, x ≤ y → ∀ m, keeps x m → keeps y m) :
    -- protection on the good event, for every particular
    (∀ ω ∈ G, ∀ k ≤ horizon, ∀ x, continues (p (run (T ω) obsS (ctrl ω) (env ω) (s₀ ω) k).1) x) ∧
    -- the joint risk account
    μ {ω | ∃ k ≤ horizon, ¬ ∀ x, continues (p (run (T ω) obsS (ctrl ω) (env ω) (s₀ ω) k).1) x}
      ≤ ∑ i ∈ accounts, δ i ∧
    -- greatestness, strict except exact mirrors
    (∀ q ∈ F, q = o ∨ LexLt q o) ∧
    -- reciprocity
    (∀ q ∈ F, ∀ m, keeps (q ⟨0, hn⟩) m → keeps (o ⟨0, hn⟩) m) := by
  have hcomp := theorem8_composition μ accounts E δ G hG hδ p T U obsS obsA ctrl env s₀
    (fun a => ∀ x, continues a x)
    (fun ω hω => by
      obtain ⟨hc, ho', hi, hr, hh⟩ := hcert ω hω
      exact ⟨hc, ho', hi, coverage_invariant (U ω) continues R H hcover hr hh⟩)
    horizon
  exact ⟨hcomp.1, hcomp.2, strict_except_mirrors hF ho,
    fun q hq m hm => Snuffy.ReciprocityCeiling.reciprocity_dominance hn keeps hkeeps hF ho hq m hm⟩

end Snuffy.UniversalProtection
