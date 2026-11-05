import PhysicalBridges.KoruDirectorCutCriterion

/-!
# Whole-U director cut with a genuinely nontrivial Koru protection sector

6 November 2026. Additive research-only stone stacked on #348.

#348 deliberately set protected := True to isolate action eligibility.
This module strengthens it: source actions preserve an INDEPENDENTLY
defined, nontrivial original-Koru relational property. Both whole
source worlds in the indistinguishable local-view counterexample are
proved to possess an actual Koru distinction, so a lossy boundary
still fails even when there is something genuine to preserve.

The complete source action is identity or actual frozen-W evolution.
The label is permitted according to the internal director->subject
operator edge from the whole U, NOT by defining allowed := safe.
Every modeled successor of either action retains the original Koru
distinction, and the original Cathedral guard/finitary-reach bank
supplies robust path-level results.

The original Koru is not equated with any original-X3 duty.
Here the word "protected" means ONLY "there exists a Koru-articulated
pair in the finite source context." The director edge is NOT
authenticated consent, and the modeled action labels are not real
commissioned actuators. No universal objective physical U,
actual subject history, X3 or cosmic protection claim is made.
Frozen summit and historical definitions remain untouched.
-/

namespace PhysicalBridges.KoruDirectorNontrivialSector

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDOperatorAlgebra
open PhysicalBridges.Koru
open PhysicalBridges.KoruWActionFixedSymmetry
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruWholeUDirectedAgency
open PhysicalBridges.KoruDirectorCutCriterion
open PhysicalBridges.CathedralCutGuardianCriterion

/-- The ordinary source whole has a genuinely articulated Koru
between source positions 2 and 3, witnessed by their DIFFERENT
identity-matrix relational profiles at column 2. -/
theorem ordinary_source_world_has_nontrivial_Koru :
    WholeHasIntrinsicKoru ordinaryObjective := by
  refine ⟨2, 3, ⟨by decide, 2, ?_⟩⟩
  change
    ((identityMatrix (2 : Index) 2 ≠ 0) : Prop) ≠
      ((identityMatrix (3 : Index) 2 ≠ 0) : Prop)
  decide

/-- The director-edge variant has that same independent Koru
distinction. Its changed slot 5 does not delete relational
differences at the other physically represented positions. -/
theorem director_edge_source_world_has_nontrivial_Koru :
    WholeHasIntrinsicKoru directorEdgeObjective := by
  refine ⟨2, 3, ⟨by decide, 2, ?_⟩⟩
  change
    ((identityMatrix (2 : Index) 2 ≠ 0) : Prop) ≠
      ((identityMatrix (3 : Index) 2 ≠ 0) : Prop)
  decide

/-- The independent physical SOURCE generator retains a genuine
Koru property for EVERY action in the two-label menu. No X3 or
guardian condition appears in the definition of this transition. -/
theorem either_source_action_preserves_intrinsic_Koru
    (U V : FiniteObjectiveU) (a : Bool)
    (hK : WholeHasIntrinsicKoru U)
    (hStep : sourceLabelledStep U a V) :
    WholeHasIntrinsicKoru V := by
  cases a with
  | false =>
      change V = U at hStep
      rw [hStep]
      exact hK
  | true =>
      change V = objectiveStep U at hStep
      rw [hStep]
      exact (whole_Koru_existence_is_exact U).mpr hK

/-- Independent source permission and actual source effects jointly
produce robust preservation of the nontrivial Koru sector.
Permission was derived from the whole operator edge in #348,
not defined as the desired preservation outcome. -/
theorem every_allowed_source_action_preserves_intrinsic_Koru
    (U : FiniteObjectiveU) (a : Bool)
    (hK : WholeHasIntrinsicKoru U)
    (hAllowed : directorLabelAllowed U a) :
    GuardAction sourceLabelledStep directorLabelAllowed
      WholeHasIntrinsicKoru U a := by
  constructor
  · exact hAllowed
  · intro V hStep
    exact either_source_action_preserves_intrinsic_Koru U V a hK hStep

/-- The EXACT whole-U direction readout lets a source action be
selected that is permitted and has ALL successors retaining the
nontrivial Koru relational property. No physical consent is claimed. -/
theorem whole_director_cut_guards_intrinsic_Koru :
    ExistsCutGuardian directorExactCut sourceLabelledStep
      directorLabelAllowed WholeHasIntrinsicKoru := by
  obtain ⟨policy, hPolicy⟩ := exact_source_direction_selector_is_guard
  refine ⟨policy, ?_⟩
  intro U hK
  exact every_allowed_source_action_preserves_intrinsic_Koru U
    (policy (directorExactCut U)) hK (hPolicy U trivial).1

/-- The two particular whole source contexts do not share ANY
permitted action, even though both carry nontrivial Koru. -/
theorem protected_wholes_require_distinct_allowed_actions :
    ∀ a : Bool,
      ¬ (GuardAction sourceLabelledStep directorLabelAllowed
            WholeHasIntrinsicKoru ordinaryObjective a ∧
          GuardAction sourceLabelledStep directorLabelAllowed
            WholeHasIntrinsicKoru directorEdgeObjective a) := by
  intro a h
  apply two_wholes_require_different_direction_labels a
  exact ⟨⟨h.1.1, fun _ _ => trivial⟩,
    ⟨h.2.1, fun _ _ => trivial⟩⟩

/-- The original Cathedral bank's cut-conflict theorem now proves
an impossibility for the NONTRIVIAL intrinsic Koru sector (not the
vacuously true predicate of #348). Both adversarial source worlds
really are protected at the origin, but the local view confuses them. -/
theorem local_event_cut_cannot_guard_nontrivial_Koru_sector :
    ¬ ExistsCutGuardian tripleOnlyCut sourceLabelledStep
        directorLabelAllowed WholeHasIntrinsicKoru := by
  intro hGuardian
  have hDistinct :=
    guard_conflict_forces_distinguishing_cut
      tripleOnlyCut sourceLabelledStep directorLabelAllowed
      WholeHasIntrinsicKoru
      ordinaryObjective directorEdgeObjective
      ordinary_source_world_has_nontrivial_Koru
      director_edge_source_world_has_nontrivial_Koru
      protected_wholes_require_distinct_allowed_actions
      hGuardian
  exact hDistinct identical_local_events_hide_different_whole_direction

/-- Whole-derived cut succeeds and a strictly local event view
fails over the SAME actually nontrivial Koru source property. -/
theorem whole_Koru_guard_exists_but_local_projection_fails :
    ExistsCutGuardian directorExactCut sourceLabelledStep
      directorLabelAllowed WholeHasIntrinsicKoru ∧
    ¬ ExistsCutGuardian tripleOnlyCut sourceLabelledStep
      directorLabelAllowed WholeHasIntrinsicKoru :=
  ⟨whole_director_cut_guards_intrinsic_Koru,
    local_event_cut_cannot_guard_nontrivial_Koru_sector⟩

/-- All permitted modeled source steps, even when executed in
arbitrary FINITE sequences, retain the same intrinsic Koru sector.
This composes actual source step semantics with the old IR96 reach. -/
def AnyDirectorPermittedStep (U V : FiniteObjectiveU) : Prop :=
  ∃ a : Bool, directorLabelAllowed U a ∧ sourceLabelledStep U a V

theorem any_finite_permitted_source_history_preserves_Koru
    {U V : FiniteObjectiveU}
    (hK : WholeHasIntrinsicKoru U)
    (hPath : PhysicalBridges.IR96.Reach AnyDirectorPermittedStep U V) :
    WholeHasIntrinsicKoru V := by
  induction hPath with
  | refl => exact hK
  | tail earlier edge ih =>
      obtain ⟨a, _hAllowed, hStep⟩ := edge
      exact either_source_action_preserves_intrinsic_Koru _ _ a ih hStep

/-- Same preservation with the exact full-director cut policy at
every stage, using the existing Cathedral finite-path theorem. -/
theorem all_finite_director_policy_paths_preserve_Koru
    {U V : FiniteObjectiveU}
    (hK : WholeHasIntrinsicKoru U)
    (hPath : PhysicalBridges.IR109.PolicyReach
      sourceLabelledStep (fun a : Bool => a) directorExactCut U V) :
    WholeHasIntrinsicKoru V := by
  apply guardian_preserves_all_finite_source_paths
    directorExactCut sourceLabelledStep
    directorLabelAllowed WholeHasIntrinsicKoru
    (fun a : Bool => a) ?_ hPath hK
  intro s hs
  have hAllowed : directorLabelAllowed s (directorExactCut s) := by
    cases hCut : directorExactCut s with
    | false => exact (director_cut_false_iff_no_source_fact s).mp hCut
    | true => exact (director_cut_true_iff_source_fact s).mp hCut
  exact every_allowed_source_action_preserves_intrinsic_Koru
    s (directorExactCut s) hs hAllowed

#print axioms ordinary_source_world_has_nontrivial_Koru
#print axioms director_edge_source_world_has_nontrivial_Koru
#print axioms either_source_action_preserves_intrinsic_Koru
#print axioms every_allowed_source_action_preserves_intrinsic_Koru
#print axioms whole_director_cut_guards_intrinsic_Koru
#print axioms protected_wholes_require_distinct_allowed_actions
#print axioms local_event_cut_cannot_guard_nontrivial_Koru_sector
#print axioms whole_Koru_guard_exists_but_local_projection_fails
#print axioms any_finite_permitted_source_history_preserves_Koru
#print axioms all_finite_director_policy_paths_preserve_Koru

end PhysicalBridges.KoruDirectorNontrivialSector
