import PhysicalBridges.IR132ExactBoundaryReconstruction

/-!
BDL-M3 relative cycle floor trap — an abstract exact algebraic obstruction.

Let b : C₂ → C₁ be the original additive chain boundary and
q : C₁ → R ANY additive projection (including non-coordinate quotients).
Suppose a short rail u is made q-relative closed, while u+e is
already an ABSOLUTE closed membrane, and e is a distinct one-cell
chain. Then e is itself q-relative closed. Thus the full nonzero
q-relative kernel cannot have minimum support ≥ 4.

This theorem applies to any additive projection of the SAME source
boundary. It does not rule out a different 3D cell structure, a
nonlinear change of incidence, or a restricted partially invariant
W_i sector that excludes e. All physical/gauge identifications remain
separate source claims.

No BDL 3D M3, M5, physical X3, or all-scale theorem is asserted.
-/

namespace PhysicalBridges.BDLRelativeFloorTrap

universe u v w
variable {Chains : Type u} {Checks : Type v} {Relative : Type w}
variable [AddMonoid Chains] [AddMonoid Checks] [AddMonoid Relative]

/-- If the old short vector closes after a linear relative projection,
and adding the omitted cell repairs it to a full absolute cycle,
then that omitted cell necessarily closes after the SAME projection.
No choice of linear target quotient removes this implication. -/
theorem omitted_cell_is_relative_cycle
    (boundary : Chains → Checks)
    (project : Checks → Relative)
    (hBoundaryAdd : ∀ x y, boundary (x + y) = boundary x + boundary y)
    (hProjectAdd : ∀ x y, project (x + y) = project x + project y)
    (hProjectZero : project 0 = 0)
    (short omitted : Chains)
    (hFullClosed : boundary (short + omitted) = 0)
    (hShortRelative : project (boundary short) = 0) :
    project (boundary omitted) = 0 := by
  have h := congrArg project hFullClosed
  rw [hBoundaryAdd short omitted,
      hProjectAdd (boundary short) (boundary omitted),
      hShortRelative, hProjectZero, zero_add] at h
  exact h

/-- A weight-one NONZERO omitted cell is a counterexample to any
assertion that every nonzero q-relative cycle has weight at least 4.

The conclusion concerns the full relative KERNEL only. In particular,
it does not imply this singleton belongs to the multi-level partially
gauge invariant set W_i = K_i \\ K_1 used by the M3 Lemma-8 argument. -/
theorem no_full_relative_kernel_floor_four
    (boundary : Chains → Checks)
    (project : Checks → Relative)
    (hBoundaryAdd : ∀ x y, boundary (x + y) = boundary x + boundary y)
    (hProjectAdd : ∀ x y, project (x + y) = project x + project y)
    (hProjectZero : project 0 = 0)
    (short omitted : Chains)
    (hFullClosed : boundary (short + omitted) = 0)
    (hShortRelative : project (boundary short) = 0)
    (weight : Chains → Nat)
    (hOmittedNonzero : omitted ≠ 0)
    (hOmittedWeight : weight omitted = 1)
    (hFloor : ∀ chain, chain ≠ 0 →
      project (boundary chain) = 0 → 4 ≤ weight chain) :
    False := by
  have hSingleton :=
    omitted_cell_is_relative_cycle boundary project
      hBoundaryAdd hProjectAdd hProjectZero
      short omitted hFullClosed hShortRelative
  have hBound := hFloor omitted hOmittedNonzero hSingleton
  rw [hOmittedWeight] at hBound
  omega

#print axioms omitted_cell_is_relative_cycle
#print axioms no_full_relative_kernel_floor_four

end PhysicalBridges.BDLRelativeFloorTrap
