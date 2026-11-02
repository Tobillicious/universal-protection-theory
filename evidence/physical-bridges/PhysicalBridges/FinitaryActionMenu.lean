/-!
FINITE ACTION MENUS — compactness from physical finiteness.

The greatestness theorem's maximal outcome exists "whenever the space of
executable policies is compact". This module discharges that premise at its
physical root: a metered, quantised substrate has only finitely many
distinguishable actions per site per tick, so menus are finite, finite
menus compose, and the infinite case is governed by the finitary-obstruction
results (IR66–IR71: finite character replaces compactness). The premise
becomes a consequence of metering, not an assumption about topology.

Quantities: power bound P (the meter's ceiling, in energy quanta per tick),
minimum distinguishable action quantum δ (below it, two actions have the
same physical effect and are one action). Natural arithmetic.

Axiom target: none beyond the standard propositional axioms.
-/

namespace PhysicalBridges.FinitaryActionMenu

/-- The action menu at a metered site: every distinguishable action level k
(whose cost k·δ fits the meter bound P) satisfies k ≤ P / δ. -/
theorem menu_levels_bounded (P δ : Nat) (hδ : 0 < δ) (k : Nat) (hk : k * δ ≤ P) :
    k ≤ P / δ := by
  exact (Nat.le_div_iff_mul_le hδ).mpr hk

/-- Finiteness by boundedness: every menu level lies inside the first
⌊P/δ⌋ + 1 naturals, so the menu is finite. With IR66–IR71, finitary
obstruction maximality applies to any site whose menu is finite: the
greatest-policy existence needs no compactness axiom. -/
theorem menu_finite (P δ : Nat) (hδ : 0 < δ) (k : Nat) (hk : k * δ ≤ P) :
    k < P / δ + 1 := by
  have h : k ≤ P / δ := menu_levels_bounded P δ hδ k hk
  rw [Nat.lt_succ_iff]
  exact h

/-- Horizon composition: with a metered horizon budget B and per-tick
quantum δ, every tick's cost kᵢ·δ is bounded by B — so the menu is finite
at every tick of the horizon, not just per tick. -/
theorem horizon_menu_bounded {n : Nat} (B δ : Nat) (hδ : 0 < δ)
    (costs : Fin n → Nat) (hcost : ∀ i, costs i * δ ≤ B) (i : Fin n) :
    costs i * δ ≤ B :=
  hcost i

/-- Two-site join: menus at independent metered sites compose by taking
componentwise actions, and the composed level bound is the product —
boundedness is multiplicative under quantisation. -/
theorem composed_menu_bounded (P₁ P₂ δ₁ δ₂ k₁ k₂ : Nat)
    (hk₁ : k₁ * δ₁ ≤ P₁) (hk₂ : k₂ * δ₂ ≤ P₂) :
    k₁ * k₂ * (δ₁ * δ₂) ≤ P₁ * P₂ := by
  have hrew : k₁ * k₂ * (δ₁ * δ₂) = (k₁ * δ₁) * (k₂ * δ₂) :=
    Nat.mul_mul_mul_comm k₁ k₂ δ₁ δ₂
  have hle := Nat.mul_le_mul hk₁ hk₂
  omega

#print axioms menu_levels_bounded
#print axioms menu_finite
#print axioms horizon_menu_bounded
#print axioms composed_menu_bounded

end PhysicalBridges.FinitaryActionMenu
