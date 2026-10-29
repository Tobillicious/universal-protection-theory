/-
Snuffy — Canon Edition v4.1: data processing invariance for mutual
information, machine-checked (Sections 12, 16.1, 21.1).

Mutual information of a joint law `J` on `α × β` is the Kullback–Leibler
divergence of `J` from the product of its marginals. A recovery channel acting
on the accessible input independently of the historical reference is a Markov
kernel `κ : β → γ` applied to the second coordinate.

  * fst_process, snd_process — processing keeps the reference marginal and
    pushes the input marginal through the channel.
  * data_processing — I(H : 𝓡(S)) ≤ I(H : S): no decoder manufactures
    information about the history from what it is given (any probability
    spaces, any Markov channel, deterministic maps included).
  * data_processing_map — the deterministic-recovery form.

Built on Mathlib's data processing inequality for the Kullback–Leibler
divergence (`klDiv_comp_right_le`).

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.InformationTheory.KullbackLeibler.DataProcessing
import Mathlib.Probability.Kernel.Composition.Lemmas

open MeasureTheory ProbabilityTheory
open scoped ENNReal

namespace Snuffy.Information

variable {α β γ : Type*} [MeasurableSpace α] [MeasurableSpace β] [MeasurableSpace γ]

/-- Mutual information of a joint law: its KL divergence from the product of
its marginals. -/
noncomputable def mutualInfo (J : Measure (α × β)) : ℝ≥0∞ := InformationTheory.klDiv J (J.fst.prod J.snd)

/-- Processing the second coordinate by a channel `κ`, independently of the
first. -/
noncomputable def process (κ : Kernel β γ) (J : Measure (α × β)) : Measure (α × γ) :=
  (Kernel.id ∥ₖ κ) ∘ₘ J

/-- Processing keeps the reference marginal. -/
theorem fst_process (κ : Kernel β γ) [IsMarkovKernel κ] (J : Measure (α × β)) :
    (process κ J).fst = J.fst := by
  ext s hs
  rw [Measure.fst_apply hs, Measure.fst_apply hs, process,
    Measure.bind_apply (measurable_fst hs) (Kernel.aemeasurable _)]
  have hpre : Prod.fst ⁻¹' s = s ×ˢ (Set.univ : Set γ) := by ext; simp
  have hpt : ∀ p : α × β, (Kernel.id ∥ₖ κ : Kernel (α × β) (α × γ)) p (Prod.fst ⁻¹' s)
      = (Prod.fst ⁻¹' s).indicator 1 p := by
    intro p
    rw [hpre, Kernel.parallelComp_apply_prod, Kernel.id_apply, measure_univ, mul_one,
      Measure.dirac_apply' _ hs]
    by_cases h : p.1 ∈ s <;> simp [Set.indicator, h]
  simp_rw [hpt]
  rw [lintegral_indicator_one (measurable_fst hs)]

/-- Processing pushes the input marginal through the channel. -/
theorem snd_process (κ : Kernel β γ) [IsMarkovKernel κ] (J : Measure (α × β)) :
    (process κ J).snd = κ ∘ₘ J.snd := by
  ext t ht
  rw [Measure.snd_apply ht, process,
    Measure.bind_apply (measurable_snd ht) (Kernel.aemeasurable _),
    Measure.bind_apply ht (Kernel.aemeasurable _), Measure.snd,
    lintegral_map (Kernel.measurable_coe _ ht) measurable_snd]
  congr with p
  have hpre : Prod.snd ⁻¹' t = (Set.univ : Set α) ×ˢ t := by ext; simp
  rw [hpre, Kernel.parallelComp_apply_prod, Kernel.id_apply, measure_univ, one_mul]

/-- **Data processing invariance.** A recovery channel acting on the accessible
input independently of the historical reference cannot increase the mutual
information: `I(H : 𝓡(S)) ≤ I(H : S)`. -/
theorem data_processing (κ : Kernel β γ) [IsMarkovKernel κ] (J : Measure (α × β))
    [IsFiniteMeasure J] : mutualInfo (process κ J) ≤ mutualInfo J := by
  unfold mutualInfo
  rw [fst_process, snd_process, Measure.prod_comp_right]
  exact InformationTheory.klDiv_comp_right_le J (J.fst.prod J.snd) (Kernel.id ∥ₖ κ)

/-- **Deterministic recovery.** A measurable recovery map `g` applied to the
accessible input cannot increase the mutual information. -/
theorem data_processing_map {g : β → γ} (hg : Measurable g) (J : Measure (α × β))
    [IsFiniteMeasure J] : mutualInfo (process (Kernel.deterministic g hg) J) ≤ mutualInfo J :=
  data_processing _ J

end Snuffy.Information
