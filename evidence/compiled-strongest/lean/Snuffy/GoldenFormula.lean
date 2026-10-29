/-
Snuffy — Canon Edition v4.1: the golden formula for mutual information — the
second block of the Gaussian maximum-entropy bound of §11 (machine-checked).

For a joint law J of (X, Y) with X standard Borel and any reference law Q
for Y:

  * klDiv_map_swap — KL is invariant under exchanging the coordinates.
  * golden_formula — KL(J ‖ P_X ⊗ Q) = KL(P_Y ‖ Q) + I(X ; Y).
  * mutualInfo_le_klDiv — hence I(X ; Y) ≤ KL(J ‖ P_X ⊗ Q) for every Q: any
    reference output law bounds the information carried.

Built on Mathlib's chain rule for KL and the disintegration of measures on
standard Borel spaces.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.DataProcessing
import Mathlib.InformationTheory.KullbackLeibler.ChainRule
import Mathlib.Probability.Kernel.Disintegration.StandardBorel

open MeasureTheory ProbabilityTheory InformationTheory

namespace Snuffy.Information

variable {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]

/-- KL divergence is invariant under exchanging the two coordinates. -/
theorem klDiv_map_swap (μ ν : Measure (α × β)) [IsFiniteMeasure μ] [IsFiniteMeasure ν] :
    klDiv (μ.map Prod.swap) (ν.map Prod.swap) = klDiv μ ν := by
  apply le_antisymm (klDiv_map_le μ ν measurable_swap)
  have h := klDiv_map_le (μ.map Prod.swap) (ν.map Prod.swap) measurable_swap
  rwa [Measure.map_map measurable_swap measurable_swap,
    Measure.map_map measurable_swap measurable_swap, Prod.swap_swap_eq, Measure.map_id,
    Measure.map_id] at h

/-- **Golden formula.** For any probability law `Q` on the output,
`KL(J ‖ P_X ⊗ Q) = KL(P_Y ‖ Q) + I(X ; Y)`. -/
theorem golden_formula [StandardBorelSpace α] [Nonempty α] (J : Measure (α × β))
    [IsProbabilityMeasure J] (Q : Measure β) [IsProbabilityMeasure Q] :
    klDiv J (J.fst.prod Q) = klDiv J.snd Q + mutualInfo J := by
  set J' := J.map Prod.swap with hJ'
  have hdis : J'.fst ⊗ₘ J'.condKernel = J' := Measure.disintegrate J' J'.condKernel
  have hfst : J'.fst = J.snd := Measure.fst_map_swap
  have hchain := klDiv_compProd_eq_add J'.fst Q J'.condKernel (Kernel.const β J.fst)
  rw [hdis, Measure.compProd_const, Measure.compProd_const, hfst] at hchain
  have h1 : klDiv J' (Q.prod J.fst) = klDiv J (J.fst.prod Q) := by
    rw [hJ', ← Measure.prod_swap (μ := J.fst) (ν := Q)]
    exact klDiv_map_swap J (J.fst.prod Q)
  have h2 : klDiv J' (J.snd.prod J.fst) = mutualInfo J := by
    unfold mutualInfo
    rw [hJ', ← Measure.prod_swap (μ := J.fst) (ν := J.snd)]
    exact klDiv_map_swap J (J.fst.prod J.snd)
  rw [h1, h2] at hchain
  exact hchain

/-- **Any reference output law bounds the information.** -/
theorem mutualInfo_le_klDiv [StandardBorelSpace α] [Nonempty α] (J : Measure (α × β))
    [IsProbabilityMeasure J] (Q : Measure β) [IsProbabilityMeasure Q] :
    mutualInfo J ≤ klDiv J (J.fst.prod Q) := by
  rw [golden_formula J Q]
  exact le_add_self

end Snuffy.Information
