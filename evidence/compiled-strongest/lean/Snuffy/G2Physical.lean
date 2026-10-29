/-
Snuffy — Canon Edition 4.2 working: the continuation stages of the whole top
are realised by the physical installation (G2; review objection 3).

The installation of `G1Refinement` is a physical policy: every particular's
readout is corrected each step, and the world — the environment, every agent,
and the crosstalk between particulars — moves each readout by at most `ρ` per
step on the good event. Its run keeps every particular, existing and newly
generated, at every step through the horizon (`physical_protection`). No
product structure of policies and no closed-block hypothesis is used:
crosstalk is part of the drift that each particular's correction absorbs.

  * kept_set — the particulars kept through the horizon by a physical run.
  * held_installation_keeps_all — on the good event the held installation's
    kept set is every particular, so its continuation stages are the whole
    existing and new categories: the continuation top is realised by a
    physical policy.
  * top_dominates_continuation — every realised continuation outcome lies
    below it, so greatestness at the continuation stages needs no union
    closure.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.G1Refinement

open MeasureTheory

namespace Snuffy.G2Physical

open Snuffy.Bridge Snuffy.G1Held Snuffy.G1Refinement

variable {X Part S Ω ι C Ev O : Type*} [MetricSpace X] [MeasurableSpace Ω]

/-- The particulars a physical run keeps at every step through the horizon. -/
def keptSet (read : S → Part → X) (rec : Part → X) (ε : ℝ) (T : S → C → Ev → S)
    (obs : S → O) (ctrl : List O → C) (env : List O → C → Ev) (s₀ : S) (horizon : ℕ) :
    Set Part :=
  {x | ∀ k ≤ horizon, Continues rec ε (read (Snuffy.Composition.run T obs ctrl env s₀ k).1) x}

/-- **The continuation top is realised by the physical held installation.** -/
theorem held_installation_keeps_all (μ : Measure Ω) (accounts : Finset ι) (Ev' : ι → Set Ω)
    (δ : ι → ENNReal) (hδ : ∀ i ∈ accounts, μ (Ev' i) ≤ δ i)
    {rec : Part → X} {ε ρ t dmin : ℝ} {Code : Set X} (hrec : ∀ x, rec x ∈ Code)
    (hsep : ∀ c ∈ Code, ∀ c' ∈ Code, c ≠ c' → dmin ≤ dist c c') (ht : 2 * t < dmin)
    {dec : X → X} (hdecC : ∀ y, dec y ∈ Code)
    (hnear : ∀ y, ∀ c ∈ Code, dist y (dec y) ≤ dist y c) (hε : 0 ≤ ε)
    (read : S → Part → X) (correct : S → S)
    (hcorr : ∀ s x, read (correct s) x = dec (read s x))
    (perturb : Ω → S → C → Ev → S)
    (hdrift : ∀ ω ∈ goodEvent accounts Ev', ∀ s c e x,
      dist (read (perturb ω s c e) x) (rec x) ≤ dist (read s x) (rec x) + ρ)
    (hbudget : ε + ρ ≤ t)
    (obs : S → O) (ctrl : Ω → List O → C) (env : Ω → List O → C → Ev)
    (s₀ : Ω → S) (hinit : ∀ ω x, read (s₀ ω) x = rec x) (horizon : ℕ)
    (Exist New : Set Part) :
    ∀ ω ∈ goodEvent accounts Ev',
      keptSet read rec ε (guardedStep correct perturb ω) obs (ctrl ω) (env ω) (s₀ ω) horizon
        = Set.univ ∧
      Exist ⊆ keptSet read rec ε (guardedStep correct perturb ω) obs (ctrl ω) (env ω) (s₀ ω)
        horizon ∧
      New ⊆ keptSet read rec ε (guardedStep correct perturb ω) obs (ctrl ω) (env ω) (s₀ ω)
        horizon := by
  intro ω hω
  have hall : ∀ x, x ∈ keptSet read rec ε (guardedStep correct perturb ω) obs (ctrl ω) (env ω)
      (s₀ ω) horizon := fun x k hk =>
    (physical_protection μ accounts Ev' δ hδ hrec hsep ht hdecC hnear hε read correct hcorr
      perturb hdrift hbudget obs ctrl env s₀ hinit horizon).1 ω hω k hk x
  exact ⟨Set.eq_univ_of_forall hall, fun x _ => hall x, fun x _ => hall x⟩

omit [MetricSpace X] [MeasurableSpace Ω] in
/-- **The realised top dominates every realised continuation outcome.** Any
family of realised kept sets that contains the whole set has it as greatest
element; no union closure is needed. -/
theorem top_dominates_continuation (R : Set (Set Part)) (htop : Set.univ ∈ R) :
    Set.univ ∈ R ∧ ∀ o ∈ R, o ⊆ Set.univ :=
  ⟨htop, fun _ _ => Set.subset_univ _⟩

end Snuffy.G2Physical
