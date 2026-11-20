import PhysicalBridges.G3FeasibleMaximalityRenewal

/-!
# G3 Time Koru: exact feasible-maximality frontier gate

Additive theorem on top of the existing kernel-checked maximality-renewal
module. No change to the unchanged OriginalX3 structure or Koru.
This is a formal order-theoretic model of the feasible-maximality duty,
not an independent proof that actual physical subjects satisfy it.

If the selected option remains unchanged, feasible, and maximal at the old
stage, its maximality at the new stage is equivalent to the absence of a
newly feasible strictly superior alternative.

A positive frontier certificate still requires independent evidence about
what alternatives are genuinely feasible in the physical world.
-/

namespace PhysicalBridges.G3FeasibleMaximalityFrontierIff

open PhysicalBridges.G3FeasibleMaximalityRenewal

universe u v

theorem maximality_iff_no_new_superior_alternative
    {P : Type u} {A : Type v}
    (F : FeasibleOrder P A) (n : Nat) (p : P)
    (hOld : MaximalAt F n p)
    (hSame : F.selected (n + 1) p = F.selected n p)
    (hFeasible : F.feasible (n + 1) p (F.selected n p)) :
    MaximalAt F (n + 1) p ↔ NoNewSuperiorAlternative F n p := by
  constructor
  · intro hMax a ha hBetter
    have hNoBetter := hMax.2 a ha
    have hBetterNew : F.better p (F.selected (n + 1) p) a := by
      rw [hSame]
      exact hBetter
    exact False.elim (hNoBetter hBetterNew)
  · intro hFrontier
    exact maximality_renews_under_complete_frontier_check
      F n p hOld hSame hFeasible hFrontier

#print axioms maximality_iff_no_new_superior_alternative

end PhysicalBridges.G3FeasibleMaximalityFrontierIff
