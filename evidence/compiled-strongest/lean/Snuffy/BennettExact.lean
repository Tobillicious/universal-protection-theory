/-
Snuffy — Canon Edition 4.2 working: premise 5 with the implemented Bennett
program and its complete cost (review objection 6).

An option is a policy together with its administration. Irreversible
administration exports heat `Q` (at least the Landauer heat of its merging
overwrite, `Bennett.heat_irreversible`). Reversible administration runs the
implemented program `BennettCounterpart.implementedProgram g h`, which writes
the administration result `h (g s)` with a clean workspace and retains the
input as history (`implemented_program_computes`), at a switching time `τ`.
Its complete non-heat lifecycle cost is `A/τ + H`: `H` carries provisioning,
archive writes and holding, routing, reset, guard, controller, verification and
endpoints. The deadline allows `0 < τ ≤ τ_max`.

  * premise5_exact — whenever the window `0 < Q − H` and `A/(Q − H) < τ_max`
    holds, no aligned option administers irreversibly: the implemented
    counterpart computes the same administration, meets the deadline, keeps
    every earlier outcome and costs strictly less.
  * window_exact — when the window fails, every admissible reversible
    counterpart costs at least `Q`. The window is exactly the condition.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.BennettCounterpart
import Snuffy.Greatestness

namespace Snuffy.BennettExact

open Snuffy.Greatestness Snuffy.BennettCounterpart

/-- How an option administers: irreversibly, or by the implemented Bennett
program at a switching time. -/
inductive Admin
  | irreversible
  | reversible (switchTime : ℝ)

/-- Complete administration cost beyond the policy's base cost. -/
noncomputable def adminCost (Q A H : ℝ) : Admin → ℝ
  | .irreversible => Q
  | .reversible τ => A / τ + H

/-- The deadline admits switching times in `(0, τ_max]`. -/
def admissible (τmax : ℝ) : Admin → Prop
  | .irreversible => True
  | .reversible τ => 0 < τ ∧ τ ≤ τmax

variable {Pol : Type*} {n : ℕ} {L : Fin n → Type*} [∀ i, SemilatticeSup (L i)]

/-- The outcome tuple: the policy's outcomes, with the resource stage `j`
reading the residual slack. -/
noncomputable def tuple (out : Pol → ∀ i, L i) (j : Fin n) (stage : ℝ → L j)
    (base : Pol → ℝ) (B Q A H : ℝ) (x : Pol × Admin) : ∀ i, L i :=
  Function.update (out x.1) j (stage (B - (base x.1 + adminCost Q A H x.2)))

/-- The feasible family: realisable policies, admissible administration, complete
cost within budget. -/
def feasible (Rpol : Set Pol) (out : Pol → ∀ i, L i) (j : Fin n) (stage : ℝ → L j)
    (base : Pol → ℝ) (B Q A H τmax : ℝ) : Set (∀ i, L i) :=
  {t | ∃ x : Pol × Admin, x.1 ∈ Rpol ∧ admissible τmax x.2 ∧
    base x.1 + adminCost Q A H x.2 ≤ B ∧ tuple out j stage base B Q A H x = t}

/-- **Premise 5 with the implemented program and complete cost.** -/
theorem premise5_exact (Rpol : Set Pol) (out : Pol → ∀ i, L i) (j : Fin n)
    (stage : ℝ → L j) (hstage : StrictMono stage) (base : Pol → ℝ) {B Q A H τmax : ℝ}
    (hA : 0 ≤ A) (hτ : 0 < τmax) (hgap : 0 < Q - H) (hwin : A / (Q - H) < τmax)
    (pol : Pol) (hpol : pol ∈ Rpol) (hB : base pol + Q ≤ B)
    (ho : Aligned (feasible Rpol out j stage base B Q A H τmax)
      (tuple out j stage base B Q A H (pol, .irreversible))) : False := by
  obtain ⟨τ, hτ0, hτle, hcost⟩ :=
    (adiabatic_feasible_iff (archive := H) (heat := Q) hA hτ).mpr ⟨hgap, hwin⟩
  refine ho.2 (tuple out j stage base B Q A H (pol, .reversible τ))
    ⟨(pol, .reversible τ), hpol, ⟨hτ0, hτle⟩, ?_, rfl⟩ ⟨j, fun i hi => ?_, ?_⟩
  · show base pol + (A / τ + H) ≤ B
    linarith
  · simp [tuple, Function.update_of_ne (ne_of_lt hi)]
  · simp only [tuple, Function.update_self]
    apply hstage
    show B - (base pol + Q) < B - (base pol + (A / τ + H))
    linarith

/-- **The window is exactly the condition.** -/
theorem window_exact {Q A H τmax : ℝ} (hA : 0 ≤ A) (hτ : 0 < τmax)
    (hno : ¬ (0 < Q - H ∧ A / (Q - H) < τmax)) :
    ∀ τ, 0 < τ → τ ≤ τmax → Q ≤ A / τ + H := by
  intro τ hτ0 hτle
  by_contra hlt
  push Not at hlt
  exact hno ((adiabatic_feasible_iff (archive := H) (heat := Q) hA hτ).mp ⟨τ, hτ0, hτle, hlt⟩)

/-- The reversible administration is the implemented program: it computes the
administration result with a clean workspace and keeps the input. -/
theorem reversible_admin_computes {State Work : Type*} [AddGroup State] [AddGroup Work]
    (g : State → Work) (h : Work → State) (s : State) :
    implementedProgram g h (s, 0, 0) = (h (g s), 0, s) :=
  implemented_program_computes g h s

end Snuffy.BennettExact
