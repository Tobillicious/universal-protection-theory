import PhysicalBridges.KoruWActionFixedSymmetry
import PhysicalBridges.KoruWholeUDirectedAgency

/-!
# Director-source cut: exact criterion for a whole-U action label

6 November 2026. A small Cathedral ladder join stacked on #347.

The historical subject/author/director distinction is carried by
the entire frozen six-position operator context, NOT assigned to an
isolated subject or authorization bit. For an internal source edge
director 5 -> subject 0, choose a two-label source *test menu*:
  label true  = W (the actual independently specified source update)
  label false = identity/no-op.
Permission to choose a label is a separately evaluated OPERATOR SOURCE
relation, not protection itself: true is allowed iff that edge is
present, false iff it is absent. Both source actions preserve this
particular operator-derived relation because the source positions
5 and 0 are fixed by W.

Main theorem:
  a cut-only guard exists on this source test iff the cut admits
  an exact decoder for this specific intrinsic relation iff the
  relation is constant on every cut fibre.
This composes the old CathedralCutGuardianCriterion and IR132 theorem
with the whole-U physically sourced relational facts.

A direct hostile example from #346 gives two objective source worlds
with the SAME local event view, but opposite source director links.
Consequently no guard depending only on that local projection can
choose the correct label for both; the independently read whole-U
director bit *can* choose the label.

The property to preserve here is deliberately True, to isolate
source *action eligibility* and cut information from unproven safety
claims. This is NOT a universal safety guardian or OriginalX3,
a physically implemented selector, a consent measurement, an
authenticated conscious subject, or the complete objective cosmos.
The two-label source test is not a claim of actual freedom/actuation.

The Koru, full objective U distinction, Cathedral, frozen summit
and six historical original X3 meanings are unchanged.
-/

namespace PhysicalBridges.KoruDirectorCutCriterion

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruWholeUDirectedAgency
open PhysicalBridges.KoruWholeEventEnactment
open PhysicalBridges.KoruWActionFixedSymmetry
open PhysicalBridges.CathedralCutGuardianCriterion
open PhysicalBridges.CathedralSymmetryForcing

/-- Intrinsic source edge fixed at physical source positions 5 and 0.
These are algebraic source positions, not authenticated people. -/
def sourceDirectorFact (U : FiniteObjectiveU) : Prop :=
  IntrinsicDirectorLink (directedRoleEvent U)

/-- The full objective source W preserves AND reflects the selected
intrinsic director edge. This follows from actual WHOLE-W carriage,
not a postulated permission/consent bit. -/
theorem director_fact_is_exact_under_W
    (U : FiniteObjectiveU) :
    sourceDirectorFact (objectiveStep U) ↔ sourceDirectorFact U := by
  have h := complete_objective_link_carriage U 5 0 1
  have h5 : trackedPosition (5 : Index) 1 = 5 := by decide
  have h0 : trackedPosition (0 : Index) 1 = 0 := by decide
  change (sourceWholeWeb (objectiveStep U)).link (5 : Index) 0 ↔
    (sourceWholeWeb U).link (5 : Index) 0
  simpa only [objectiveAt, h5, h0] using h

/-- A tiny ACTION MENU whose eligibility comes from the whole
source operator relation, not from an original-X3 predicate:
true = W, permitted iff source edge exists;
false = identity, permitted iff source edge does not exist.
No independent actuator or moral authorization is claimed. -/
def directorLabelAllowed (U : FiniteObjectiveU) : Bool → Prop
  | true => sourceDirectorFact U
  | false => ¬ sourceDirectorFact U

/-- For these TWO specifically sourced action labels, W leaves
eligibility fixed. This is more specific than #347's all-allowed
menu and contrasts with its moving-position-label countermodel. -/
theorem director_source_permission_is_action_fixed
    (U : FiniteObjectiveU) (a : Bool) :
    directorLabelAllowed (objectiveStep U) a ↔
      directorLabelAllowed U a := by
  cases a with
  | false => exact not_congr (director_fact_is_exact_under_W U)
  | true => exact director_fact_is_exact_under_W U

/-- A mathematically exact intrinsic-source cut. It is a readout
of the whole, not a permission oracle or an installed sensor. -/
noncomputable def directorExactCut (U : FiniteObjectiveU) : Bool :=
  sourceDirectorReport (directedRoleEvent U)

/-- The report truth value has NO independently assigned bits.
It exactly reads the whole's own internal director edge. -/
theorem director_cut_true_iff_source_fact
    (U : FiniteObjectiveU) :
    directorExactCut U = true ↔ sourceDirectorFact U := by
  classical
  unfold directorExactCut sourceDirectorReport sourceDirectorFact
  by_cases h : IntrinsicDirectorLink (directedRoleEvent U) <;> simp [h]

theorem director_cut_false_iff_no_source_fact
    (U : FiniteObjectiveU) :
    directorExactCut U = false ↔ ¬ sourceDirectorFact U := by
  classical
  by_cases h : sourceDirectorFact U
  · have ht := (director_cut_true_iff_source_fact U).mpr h
    simp [ht, h]
  · have hf : directorExactCut U = false := by
      cases hx : directorExactCut U with
      | false => rfl
      | true =>
          exact False.elim (h
            ((director_cut_true_iff_source_fact U).mp hx))
    simp [hf, h]

/-- The source-derived director cut, including its false case,
is stable under the WHOLE source-W evolution. -/
theorem director_exact_cut_is_W_invariant
    (U : FiniteObjectiveU) :
    directorExactCut (objectiveStep U) = directorExactCut U := by
  classical
  have hRel := director_fact_is_exact_under_W U
  by_cases h : sourceDirectorFact U
  · have hw : sourceDirectorFact (objectiveStep U) := hRel.mpr h
    exact ((director_cut_true_iff_source_fact _).mpr hw).trans
      ((director_cut_true_iff_source_fact _).mpr h).symm
  · have hw : ¬ sourceDirectorFact (objectiveStep U) := fun x =>
      h (hRel.mp x)
    exact ((director_cut_false_iff_no_source_fact _).mpr hw).trans
      ((director_cut_false_iff_no_source_fact _).mpr h).symm

/-- W acts as an action-FIXED source symmetry for the bounded
two-label process with WHOLE-source direction eligibility.
This source-level theorem has no original-X3 protected assumption:
the protected predicate is True solely to isolate eligibility. -/
def director_source_W_is_action_fixed :
    ActionFixedSymmetry directorExactCut sourceLabelledStep
      directorLabelAllowed (fun _ : FiniteObjectiveU => True) where
  move := {
    forward := objectiveStep
    backward := objectiveStep
    leftInv := objective_W_is_an_involution
    rightInv := objective_W_is_an_involution
  }
  cut := director_exact_cut_is_W_invariant
  sector := by intro _; exact Iff.rfl
  permission := by
    intro s a
    exact director_source_permission_is_action_fixed s a
  transition := by
    intro s a t
    exact two_label_source_step_is_action_fixed s t a

/-- In this mathematical cut, the action label equals the complete
whole-U source-direction bit. The downstream 'protected' condition
here is only True: this proves a permitted source selector, not X3. -/
theorem exact_source_direction_selector_is_guard :
    ExistsCutGuardian directorExactCut sourceLabelledStep
      directorLabelAllowed (fun _ : FiniteObjectiveU => True) := by
  refine ⟨id, ?_⟩
  intro U _
  constructor
  · change directorLabelAllowed U (directorExactCut U)
    cases hCut : directorExactCut U with
    | false =>
        exact (director_cut_false_iff_no_source_fact U).mp hCut
    | true =>
        exact (director_cut_true_iff_source_fact U).mp hCut
  · intro _ _
    trivial

/-- A 'guardian' on this source-only eligibility test necessarily
decodes the WHOLE director edge from its observation. No universal
source state reconstruction is needed, ONLY this relevant bit. -/
theorem any_valid_source_direction_selector_decodes_the_cut
    {O : Type} (observe : FiniteObjectiveU → O)
    (hGuard :
      ExistsCutGuardian observe sourceLabelledStep
        directorLabelAllowed (fun _ : FiniteObjectiveU => True)) :
    PhysicalBridges.IR132.ExactDecoder observe directorExactCut := by
  obtain ⟨policy, hPolicy⟩ := hGuard
  refine ⟨policy, ?_⟩
  intro U
  have hAllowed := (hPolicy U trivial).1
  by_cases h : sourceDirectorFact U
  · have hTrue := (director_cut_true_iff_source_fact U).mpr h
    cases hp : policy (observe U) with
    | false =>
        have hNot : ¬ sourceDirectorFact U := by
          simpa only [hp, directorLabelAllowed] using hAllowed
        exact False.elim (hNot h)
    | true =>
        exact hTrue.symm
  · have hFalse := (director_cut_false_iff_no_source_fact U).mpr h
    cases hp : policy (observe U) with
    | false =>
        exact hFalse.symm
    | true =>
        have hYes : sourceDirectorFact U := by
          simpa only [hp, directorLabelAllowed] using hAllowed
        exact False.elim (h hYes)

/-- Historical Cathedral + IR132 exact characterization:
source eligible cut-only action selection iff this cut can
reconstruct the relevant WHOLE-derived director bit.
This is a source eligibility certificate, NOT full X3 safety. -/
theorem source_direction_guardian_iff_exact_decoder
    {O : Type} (observe : FiniteObjectiveU → O) :
    ExistsCutGuardian observe sourceLabelledStep directorLabelAllowed
      (fun _ : FiniteObjectiveU => True) ↔
    PhysicalBridges.IR132.ExactDecoder observe directorExactCut := by
  constructor
  · exact any_valid_source_direction_selector_decodes_the_cut observe
  · intro hDecoder
    obtain ⟨policy, hPolicy⟩ := exact_source_direction_selector_is_guard
    exact history_decoder_can_supply_cut_guardian
      observe directorExactCut sourceLabelledStep
      directorLabelAllowed (fun _ : FiniteObjectiveU => True)
      hDecoder policy hPolicy

/-- Reuse IR132's exact iff: reconstructing only the relevant
WHOLE relation, rather than the complete source U, is enough.
This is the minimal INFORMATION property for this test menu. -/
theorem source_direction_guardian_iff_fiber_constant
    {O : Type} (observe : FiniteObjectiveU → O) :
    ExistsCutGuardian observe sourceLabelledStep directorLabelAllowed
      (fun _ : FiniteObjectiveU => True) ↔
    PhysicalBridges.IR132.FiberConstant observe directorExactCut := by
  exact (source_direction_guardian_iff_exact_decoder observe).trans
    (PhysicalBridges.IR132.exact_decoder_iff_fiber_constant
      observe directorExactCut)

/-- The #346 objectively different worlds agree on the complete
subject/action/effect readout yet disagree on the internal source
director bit. This is a precise MODEL of local-data insufficiency. -/
def tripleOnlyCut (U : FiniteObjectiveU) :
    WholeOperatorEvent :=
  localEnactment (directedRoleEvent U)

theorem two_wholes_require_different_direction_labels :
    ∀ a : Bool,
      ¬ (GuardAction sourceLabelledStep directorLabelAllowed
            (fun _ : FiniteObjectiveU => True) ordinaryObjective a ∧
          GuardAction sourceLabelledStep directorLabelAllowed
            (fun _ : FiniteObjectiveU => True) directorEdgeObjective a) := by
  intro a h
  obtain ⟨hOrd, hEdge⟩ := opposite_intrinsic_director_links_in_two_wholes
  cases a with
  | false =>
      have hFalse : ¬ sourceDirectorFact directorEdgeObjective := h.2.1
      exact hFalse hEdge
  | true =>
      have hTrue : sourceDirectorFact ordinaryObjective := h.1.1
      exact hOrd hTrue

/-- DIRECT bank application: a guardian whose cut observes only
the local three-role event cannot choose valid source action
labels in both objectively different worlds. This is not a
claim that both are possible living-human subject worlds. -/
theorem no_local_event_only_source_direction_guardian :
    ¬ ExistsCutGuardian tripleOnlyCut sourceLabelledStep
        directorLabelAllowed (fun _ : FiniteObjectiveU => True) := by
  intro hGuardian
  have hDist :=
    guard_conflict_forces_distinguishing_cut
      tripleOnlyCut sourceLabelledStep directorLabelAllowed
      (fun _ : FiniteObjectiveU => True)
      ordinaryObjective directorEdgeObjective
      trivial trivial
      two_wholes_require_different_direction_labels hGuardian
  exact hDist identical_local_events_hide_different_whole_direction

/-- The exact bit from WHOLE U is sufficient, while its projection
to the local triple is insufficient. Together these bound the
required source observation without equating it with consent. -/
theorem whole_source_direction_has_guard_but_local_cut_does_not :
    ExistsCutGuardian directorExactCut sourceLabelledStep
      directorLabelAllowed (fun _ : FiniteObjectiveU => True) ∧
    ¬ ExistsCutGuardian tripleOnlyCut sourceLabelledStep
      directorLabelAllowed (fun _ : FiniteObjectiveU => True) :=
  ⟨exact_source_direction_selector_is_guard,
    no_local_event_only_source_direction_guardian⟩

#print axioms director_fact_is_exact_under_W
#print axioms director_source_permission_is_action_fixed
#print axioms director_exact_cut_is_W_invariant
#print axioms director_source_W_is_action_fixed
#print axioms exact_source_direction_selector_is_guard
#print axioms any_valid_source_direction_selector_decodes_the_cut
#print axioms source_direction_guardian_iff_exact_decoder
#print axioms source_direction_guardian_iff_fiber_constant
#print axioms two_wholes_require_different_direction_labels
#print axioms no_local_event_only_source_direction_guardian
#print axioms whole_source_direction_has_guard_but_local_cut_does_not

end PhysicalBridges.KoruDirectorCutCriterion
