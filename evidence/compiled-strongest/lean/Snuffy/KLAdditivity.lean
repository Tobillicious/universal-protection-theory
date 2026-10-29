/-
Snuffy — Canon Edition v4.1: additivity of conditional KL over conditionally
independent outputs — block 4a of the Gaussian maximum-entropy bound (§11).

  * prod_eq_compProd — κ₁ ×ₖ κ₂ = κ₁ ⊗ₖ (κ₂ ignoring the first output).
  * klDiv_map_equiv — KL is invariant under measurable equivalences.
  * klDiv_prod_kernel — for Markov kernels κ₁, κ₂ (the channel) and c₁, c₂ (the
    reference), with outputs conditionally independent given the input,
      KL(P ⊗ (κ₁ ×ₖ κ₂) ‖ P ⊗ (c₁ ×ₖ c₂))
        = KL(P ⊗ κ₁ ‖ P ⊗ c₁) + KL(P ⊗ κ₂ ‖ P ⊗ c₂).

Built on Mathlib's chain rule (`klDiv_compProd_eq_add`, `klDiv_compProd_left`)
and composition-product associativity.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.InformationTheory.KullbackLeibler.ChainRule
import Mathlib.InformationTheory.KullbackLeibler.DataProcessing
import Mathlib.Probability.Kernel.Composition.Lemmas

open MeasureTheory ProbabilityTheory InformationTheory

namespace Snuffy.KLAdditivity

variable {α β γ : Type*} [MeasurableSpace α] [MeasurableSpace β] [MeasurableSpace γ]

/-- A product kernel is a composition-product with a kernel that ignores the
first output. -/
theorem prod_eq_compProd (κ : Kernel α β) [IsSFiniteKernel κ] (η : Kernel α γ)
    [IsSFiniteKernel η] : κ ×ₖ η = κ ⊗ₖ Kernel.prodMkRight β η := by
  ext a s hs
  rw [Kernel.prod_apply, Kernel.compProd_apply hs, Measure.prod_apply hs]
  rfl

/-- KL divergence is invariant under measurable equivalences. -/
theorem klDiv_map_equiv {δ : Type*} [MeasurableSpace δ] (e : α ≃ᵐ δ) (μ ν : Measure α)
    [IsFiniteMeasure μ] [IsFiniteMeasure ν] :
    klDiv (μ.map e) (ν.map e) = klDiv μ ν := by
  apply le_antisymm (klDiv_map_le μ ν e.measurable)
  have h := klDiv_map_le (μ.map e) (ν.map e) e.symm.measurable
  rwa [Measure.map_map e.symm.measurable e.measurable, Measure.map_map e.symm.measurable
    e.measurable, e.symm_comp_self, Measure.map_id, Measure.map_id] at h

variable {β₁ β₂ : Type*} [MeasurableSpace β₁] [MeasurableSpace β₂]

/-- Reassociating `P ⊗ (κ₁ ×ₖ κ₂)` gives `(P ⊗ κ₁) ⊗ (κ₂ ignoring y₁)`. -/
theorem compProd_prod_assoc (P : Measure α) [SFinite P] (κ₁ : Kernel α β₁) [IsSFiniteKernel κ₁]
    (κ₂ : Kernel α β₂) [IsSFiniteKernel κ₂] :
    (P ⊗ₘ (κ₁ ×ₖ κ₂)).map MeasurableEquiv.prodAssoc.symm
      = P ⊗ₘ κ₁ ⊗ₘ Kernel.prodMkRight β₁ κ₂ := by
  rw [prod_eq_compProd, Measure.compProd_assoc]

/-- Exchanging the two conditionally independent outputs. -/
theorem compProd_prod_swap (P : Measure α) [SFinite P] (κ₁ : Kernel α β₁) [IsSFiniteKernel κ₁]
    (κ₂ : Kernel α β₂) [IsSFiniteKernel κ₂] :
    (P ⊗ₘ (κ₁ ×ₖ κ₂)).map (Prod.map id Prod.swap) = P ⊗ₘ (κ₂ ×ₖ κ₁) := by
  rw [← Measure.compProd_map measurable_swap, Kernel.map_prod_swap]

/-- **Additivity of conditional KL over conditionally independent outputs.** -/
theorem klDiv_prod_kernel (P : Measure α) [IsFiniteMeasure P]
    (κ₁ c₁ : Kernel α β₁) [IsMarkovKernel κ₁] [IsMarkovKernel c₁]
    (κ₂ c₂ : Kernel α β₂) [IsMarkovKernel κ₂] [IsMarkovKernel c₂] :
    klDiv (P ⊗ₘ (κ₁ ×ₖ κ₂)) (P ⊗ₘ (c₁ ×ₖ c₂))
      = klDiv (P ⊗ₘ κ₁) (P ⊗ₘ c₁) + klDiv (P ⊗ₘ κ₂) (P ⊗ₘ c₂) := by
  -- reassociate and apply the chain rule
  have h1 := klDiv_map_equiv (MeasurableEquiv.prodAssoc (α := α) (β := β₁) (γ := β₂)).symm
    (P ⊗ₘ (κ₁ ×ₖ κ₂)) (P ⊗ₘ (c₁ ×ₖ c₂))
  rw [compProd_prod_assoc, compProd_prod_assoc] at h1
  rw [← h1, klDiv_compProd_eq_add]
  congr 1
  -- the second term: undo the association, swap the outputs, reassociate
  have h2 := klDiv_map_equiv (MeasurableEquiv.prodAssoc (α := α) (β := β₁) (γ := β₂)).symm
    (P ⊗ₘ (κ₁ ×ₖ κ₂)) (P ⊗ₘ (κ₁ ×ₖ c₂))
  rw [compProd_prod_assoc, compProd_prod_assoc] at h2
  rw [h2]
  have h3 := klDiv_map_equiv (MeasurableEquiv.prodCongr (MeasurableEquiv.refl α)
    (MeasurableEquiv.prodComm (α := β₁) (β := β₂))) (P ⊗ₘ (κ₁ ×ₖ κ₂)) (P ⊗ₘ (κ₁ ×ₖ c₂))
  have hcoe : ⇑(MeasurableEquiv.prodCongr (MeasurableEquiv.refl α)
      (MeasurableEquiv.prodComm (α := β₁) (β := β₂))) = Prod.map id Prod.swap := rfl
  rw [hcoe, compProd_prod_swap, compProd_prod_swap] at h3
  rw [← h3]
  have h4 := klDiv_map_equiv (MeasurableEquiv.prodAssoc (α := α) (β := β₂) (γ := β₁)).symm
    (P ⊗ₘ (κ₂ ×ₖ κ₁)) (P ⊗ₘ (c₂ ×ₖ κ₁))
  rw [compProd_prod_assoc, compProd_prod_assoc] at h4
  rw [← h4, klDiv_compProd_left]

end Snuffy.KLAdditivity
