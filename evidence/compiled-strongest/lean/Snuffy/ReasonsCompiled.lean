/-
Snuffy — Canon Edition v4.1: the reasons route in its decision form (§15.2
reciprocity in expectation; §16.4 the power-seeker, the diffusive-control
capture of GAP3-AUDIT §3).

  * reciprocity_expectation — for any probability law on the reactive worlds
    and any rival regime: if on the certified good event `G` the canonical
    outcome contains the rival's outcome stage by stage (as
    `greatest_of_solvent` gives), then for every event `U` that is upward
    closed — "m continues" is one — the rival realises `U` with probability at
    most the canonical regime's plus `P(Gᶜ)`.
  * reciprocity_canonical_floor — if keeping everything realises `U` (m is a
    particular, so keeping every particular keeps m), the canonical regime
    realises it with probability at least `1 − P(Gᶜ)`.
  * reciprocity_strict — so the canonical regime is strictly better for m
    whenever the rival misses `U` with probability above `P(Gᶜ)`.
  * reciprocity_from_solvency — the containment hypothesis discharged world by
    world from `UnionClosure.greatest_of_solvent`.
  * controller_pays_floor, controller_floor_diverges — the diffusive-control
    capture: any protocol that keeps a diffusive particular recoverable at the
    radius its drift has reached pays the recovery-work floor
    `p'/(v d) (R^d − r₀^d)`, which diverges with the particular's age. A
    controller of the diffusive is a protector in the cost structure.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.UnionClosure
import Snuffy.RecoveryWork

open MeasureTheory Set Filter

namespace Snuffy.ReasonsCompiled

open Snuffy.Greatestness

variable {n : ℕ} {L : Fin n → Type*} [∀ i, SemilatticeSup (L i)]

section Reciprocity

variable {Ω : Type*} [MeasurableSpace Ω] (μ : Measure Ω) [IsProbabilityMeasure μ]

/-- An event of outcome tuples that is upward closed in the stage-wise order. -/
def UpClosed (U : Set (∀ i, L i)) : Prop := ∀ a b, a ≤ b → a ∈ U → b ∈ U

/-- **Reciprocity in expectation.** If on `G` the canonical outcome contains the
rival's outcome, the rival realises any upward-closed event `U` with
probability at most the canonical regime's plus `P(Gᶜ)`. -/
theorem reciprocity_expectation (oL oQ : Ω → ∀ i, L i) (G : Set Ω)
    (hdom : ∀ w ∈ G, oQ w ≤ oL w) (U : Set (∀ i, L i)) (hU : UpClosed U) :
    μ.real (oQ ⁻¹' U) ≤ μ.real (oL ⁻¹' U) + μ.real Gᶜ := by
  have hsub : oQ ⁻¹' U ⊆ oL ⁻¹' U ∪ Gᶜ := by
    intro w hw
    by_cases hG : w ∈ G
    · exact Or.inl (hU _ _ (hdom w hG) hw)
    · exact Or.inr hG
  exact (measureReal_mono hsub).trans (measureReal_union_le _ _)

/-- **The canonical floor.** If keeping everything realises `U` and on `G` the
canonical outcome keeps everything, the canonical regime realises `U` with
probability at least `1 − P(Gᶜ)`. -/
theorem reciprocity_canonical_floor [∀ i, OrderTop (L i)] (oL : Ω → ∀ i, L i) (G : Set Ω)
    (hG : MeasurableSet G) (htop : ∀ w ∈ G, oL w = ⊤) (U : Set (∀ i, L i)) (hU : ⊤ ∈ U) :
    1 - μ.real Gᶜ ≤ μ.real (oL ⁻¹' U) := by
  have hsub : G ⊆ oL ⁻¹' U := fun w hw => by
    simp only [mem_preimage, htop w hw]
    exact hU
  rw [measureReal_compl hG, probReal_univ]
  linarith [measureReal_mono (μ := μ) hsub]

/-- **Strict reciprocity.** The canonical regime realises `U` with strictly
higher probability than any rival that misses `U` with probability above
`P(Gᶜ)`. -/
theorem reciprocity_strict [∀ i, OrderTop (L i)] (oL oQ : Ω → ∀ i, L i) (G : Set Ω)
    (hG : MeasurableSet G) (htop : ∀ w ∈ G, oL w = ⊤) (U : Set (∀ i, L i)) (hU : ⊤ ∈ U)
    (hmeas : MeasurableSet (oQ ⁻¹' U)) (hmiss : μ.real Gᶜ < μ.real (oQ ⁻¹' U)ᶜ) :
    μ.real (oQ ⁻¹' U) < μ.real (oL ⁻¹' U) := by
  have hfloor := reciprocity_canonical_floor μ oL G hG htop U hU
  rw [measureReal_compl hmeas, probReal_univ] at hmiss
  linarith

/-- **Reciprocity from solvency.** If in every world of `G` the canonical
option is aligned in its budget family and keeping everything is realisable
and funded, then on `G` the canonical outcome is `⊤` and contains every rival
outcome; so the expectation form holds for every rival and every law. -/
theorem reciprocity_from_solvency [∀ i, OrderTop (L i)] (oL oQ : Ω → ∀ i, L i) (G : Set Ω)
    (R : Ω → Set (∀ i, L i)) (c : Ω → (∀ i, L i) → ℝ) (B : Ω → ℝ)
    (htopR : ∀ w ∈ G, (⊤ : ∀ i, L i) ∈ R w) (hsolv : ∀ w ∈ G, c w ⊤ ≤ B w)
    (haligned : ∀ w ∈ G, Aligned (Snuffy.UnionClosure.budgetFamily (R w) (c w) (B w)) (oL w))
    (U : Set (∀ i, L i)) (hU : UpClosed U) :
    (∀ w ∈ G, oL w = ⊤) ∧ μ.real (oQ ⁻¹' U) ≤ μ.real (oL ⁻¹' U) + μ.real Gᶜ := by
  have hgreat := fun w hw =>
    Snuffy.UnionClosure.greatest_of_solvent (htopR w hw) (hsolv w hw) (haligned w hw)
  exact ⟨fun w hw => (hgreat w hw).1,
    reciprocity_expectation μ oL oQ G (fun w hw => (hgreat w hw).2 (oQ w)) U hU⟩

end Reciprocity

/-! ## The power-seeker: the diffusive-control capture -/

/-- **The controller pays the floor.** Any protocol that keeps a diffusive
particular recoverable — its frontier reaching the radius `R` the particular's
drift has reached — pays at least `p'/(v d) (R^d − r₀^d)`, the same floor the
protector pays. -/
theorem controller_pays_floor {r0 v p' d : ℝ} (hd : 1 ≤ d) (hv : 0 < v) (hp : 0 < p')
    {R : ℝ} (hR0 : 0 ≤ R) (π : Snuffy.RecoveryWork.RecoveryProtocol r0 v p' d)
    (hsucc : π.Succeeds R) : p' / (v * d) * (R ^ d - r0 ^ d) ≤ π.work :=
  Snuffy.RecoveryWork.Wmin_lower_bound hd hv hp hR0 π hsucc

/-- **The floor diverges with age.** For a particular whose information has
drifted to radius `w(t − t_c)` at age `t`, the floor any controller pays grows
without bound: control of the diffusive is never free. -/
theorem controller_floor_diverges {r0 v p' d w tc : ℝ} (hd : 1 ≤ d) (hv : 0 < v) (hp : 0 < p')
    (hw : 0 < w) :
    Tendsto (fun t => p' / (v * d) * ((w * (t - tc)) ^ d - r0 ^ d)) atTop atTop :=
  Snuffy.RecoveryWork.delayed_work_diverges hd hv hp hw

end Snuffy.ReasonsCompiled
