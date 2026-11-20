import PhysicalBridges.PureG

/-!
# PureG: exact fixed-point uniqueness under separation

The original `ContractionPillar` intentionally has a Nat-valued `dist`
without a separation law. Its current six-X3 theorems prove
`C.dist C.G G' = 0` for a second fixed point. That does NOT prove
`C.G = G'` unless zero distance implies equality.

This additive module supplies precisely that missing premise, deriving
an actual equality theorem from the existing PureG proof. No original
structure, Koru correspondence, or X3 field is changed.

The negative control demonstrates why the premise is necessary.
This is mathematical uniqueness only; physical/ethical realization remains
an independent question.
-/

/-- Separation: zero distance distinguishes identical complete model states. -/
def PureGDistanceSeparates {M : Type} (C : ContractionPillar M) : Prop :=
  ∀ x y, C.dist x y = 0 → x = y

/-- The existing PureG original-six proof provides zero distance.
    Separation supplies the *additional* equality step. -/
theorem pure_g_exact_fixed_point_uniqueness
    {S M : Type} (P : ProcessPillar S) (C : ContractionPillar M)
    (hinge : StrictHinge P C)
    (hSep : PureGDistanceSeparates C)
    (G' : M) (hFixed' : C.phi G' = G') :
    C.G = G' := by
  have hSix : OriginalSixX3 P C hinge := assemble_six_x3 P C hinge
  exact hSep C.G G' (hSix.x3_2_unique G' hFixed')

/-- The same exact-equality repair applies to the existing quasi-Koru
    six-X3 theorem, without identifying the Koru with a distance function. -/
theorem pure_g_quasi_exact_fixed_point_uniqueness
    {S M : Type} (P : ProcessPillar S) (C : ContractionPillar M)
    (hinge : KoruHinge P C)
    (hSep : PureGDistanceSeparates C)
    (G' : M) (hFixed' : C.phi G' = G') :
    C.G = G' := by
  have hSix : KoruQuasiSixX3 P C hinge := koru_quasi_six_x3 P C hinge
  exact hSep C.G G' (hSix.kq_x3_2_unique G' hFixed')

/-- Explicit nonseparated contraction: both distinct Bool values are
    fixed, and every pair has zero distance. Strict contraction of this
    pseudodistance does not imply unique states. -/
def pureGCollapsedPseudodistance : ContractionPillar Bool where
  phi := id
  dist := fun _ _ => 0
  kNum := 0
  kDen := 1
  kLt := by decide
  contracts := by intro x y; decide
  G := false
  hFixed := rfl

/-- Negative control: two distinct fixed points both satisfy the
    contraction hypotheses when the distance is nonseparating. -/
theorem pure_g_nonseparated_fixed_point_countermodel :
    pureGCollapsedPseudodistance.phi false = false ∧
    pureGCollapsedPseudodistance.phi true = true ∧
    false ≠ true ∧
    pureGCollapsedPseudodistance.dist false true = 0 := by
  decide

/-- The countermodel cannot possibly satisfy separation. -/
theorem pure_g_countermodel_fails_separation :
    ¬ PureGDistanceSeparates pureGCollapsedPseudodistance := by
  intro hSep
  have hEq : (false : Bool) = true :=
    hSep false true (by decide)
  cases hEq

#print axioms pure_g_exact_fixed_point_uniqueness
#print axioms pure_g_quasi_exact_fixed_point_uniqueness
#print axioms pure_g_nonseparated_fixed_point_countermodel
#print axioms pure_g_countermodel_fails_separation
