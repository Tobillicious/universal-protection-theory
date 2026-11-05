import PhysicalBridges.KoruWholeUDirectedAgency
import PhysicalBridges.CathedralSymmetryForcing

/-!
# Koru whole-U actual W action-fixed symmetry: positive and hostile control

6 November 2026. Additive, draft, stacked on #346.

Connect the actual independently specified frozen W operator evolution on
the WHOLE six-position source U to the original
CathedralSymmetryForcing.ActionFixedSymmetry and CutIsActionFixedOrbit.

The critical distinction is between:
  (i) preserving ALL physically represented operator expressions, the
      original Koru and their tracked internal positions;
  (ii) leaving an ACTION LABEL fixed under a physical symmetry.
These are not logically equivalent.

POSITIVE: for a defined two-label source menu {identity, actual frozen W},
both operations commute with W. The FULL source-state W is involutive;
the two-label process and an independently SOURCE-defined property
"there exists a genuine intrinsic Koru distinction" are W-equivariant.
Define an exact W-orbit observation cut; prove its fibres are precisely
the source W-orbits and reuse CathedralSymmetryForcing to derive the
fibre-common guardian for that narrow source predicate. The positive
witness has a nonempty Koru relation and the physical W action is
nontrivial for a second explicit source context.

HOSTILE: source positions themselves may LABEL an action. A permission
predicate calculated from the actual internal operator relation at a
specified source slot is W-covariant when its label moves but is NOT
W-invariant at the fixed action label. A concrete exact matrix unit
shows the failure. This is a SOURCE-LEVEL obstruction to promoting
whole-U covariance automatically into action-fixed symmetry.

Neither menu is a claim of available independent real-world actuators.
The exact W-orbit cut is a mathematically defined information-rich
observation, NOT a deployed sensor. The protected predicate is only
"contains a Koru distinction," NOT the six original X3 duties,
actual experiencing subjects, free choice or authentic authorization.
No ontological/physical completeness or all-actions forcing is claimed;
the historical summit and original definitions remain untouched.
-/

namespace PhysicalBridges.KoruWActionFixedSymmetry

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDOperatorAlgebra
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.KoruCompositionalExpression
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.CathedralCutGuardianCriterion
open PhysicalBridges.CathedralSymmetryForcing
open PhysicalBridges.Koru

/-- The whole objective source is genuinely returned to itself after
two actual W pulses, including ALL nested operator expressions,
not merely its reindexed relation or one selected event. -/
theorem objective_W_is_an_involution
    (U : FiniteObjectiveU) :
    objectiveStep (objectiveStep U) = U := by
  funext i
  change
    mapAtoms evolve
      (mapAtoms evolve
        (U (sourceTransport (sourceTransport i)))) = U i
  rw [source_transport_is_involution]
  rw [mapAtoms_comp]
  have hId :
      (fun A : Matrix6 => evolve (evolve A)) =
        (fun A : Matrix6 => A) := by
    funext A
    exact evolve_involutive A
  rw [hId, mapAtoms_id]

theorem objective_W_is_injective :
    Function.Injective objectiveStep := by
  intro U V h
  have h2 := congrArg objectiveStep h
  simpa only [objective_W_is_an_involution] using h2

/-- A nontrivial intrinsic Koru exists SOMEWHERE in the complete
source context. This is not a local cut, consent or OriginalX3. -/
def WholeHasIntrinsicKoru (U : FiniteObjectiveU) : Prop :=
  ∃ i j : Index, koru (sourceWholeWeb U) i j

/-- Existing #344 Koru transport gives existence preservation. This
uses the actual tracked positions, not a fixed-point substitution. -/
theorem whole_Koru_exists_after_W
    (U : FiniteObjectiveU)
    (hKoru : WholeHasIntrinsicKoru U) :
    WholeHasIntrinsicKoru (objectiveStep U) := by
  obtain ⟨i, j, h⟩ := hKoru
  refine ⟨sourceTransport i, sourceTransport j, ?_⟩
  have hTransport :=
    (objective_Koru_is_exact_under_W U i j 1).mpr h
  simpa only [objectiveAt, trackedPosition] using hTransport

/-- The complete-source Koru-existence statement is not CREATED
by W either: truth and falsity are both transported exactly. -/
theorem whole_Koru_existence_is_exact
    (U : FiniteObjectiveU) :
    WholeHasIntrinsicKoru (objectiveStep U) ↔
      WholeHasIntrinsicKoru U := by
  constructor
  · intro h
    have hBack := whole_Koru_exists_after_W (objectiveStep U) h
    simpa only [objective_W_is_an_involution] using hBack
  · exact whole_Koru_exists_after_W U

/-- This is NOT an empty source sector. The existing nontrivial
whole-context Koru witness from #344 inhabits it. -/
theorem real_source_Koru_witness_is_in_the_sector :
    WholeHasIntrinsicKoru KoruWitnessObjective :=
  ⟨2, 3, genuine_objective_koru_distinction⟩

/-- The two proposed SOURCE action labels. true = the actual
independently specified frozen W pulse; false = identity/no-op.
Neither is a physical actuator installation or authentic free option. -/
def sourceLabelledStep
    (U : FiniteObjectiveU) (a : Bool) (V : FiniteObjectiveU) : Prop :=
  V = if a then objectiveStep U else U

/-- The modeled menu, independent of whether a source world has
Koru distinctions. No protection predicate is hidden in permission. -/
def sourceMenuAllowed (_ : FiniteObjectiveU) (_ : Bool) : Prop :=
  True

/-- The exact W source orbit, not a claimed physical observation
instrument. Its values are entire predicates on possible worlds. -/
def exactSourceOrbitCut
    (U : FiniteObjectiveU) : FiniteObjectiveU → Prop :=
  fun V => V = U ∨ V = objectiveStep U

/-- Observing the exact mathematical orbit is W invariant because
the actual source W is involutive. -/
theorem exact_orbit_cut_is_W_invariant
    (U : FiniteObjectiveU) :
    exactSourceOrbitCut (objectiveStep U) =
      exactSourceOrbitCut U := by
  funext V
  apply propext
  change
    (V = objectiveStep U ∨
      V = objectiveStep (objectiveStep U)) ↔
    (V = U ∨ V = objectiveStep U)
  rw [objective_W_is_an_involution]
  exact or_comm

/-- The same source W COMMUTES with both distinct modeled action
labels (identity and W); this is source-level action-FIXED covariance,
not a deduction from bare Koru equivalence. -/
theorem two_label_source_step_is_action_fixed
    (U V : FiniteObjectiveU) (a : Bool) :
    sourceLabelledStep (objectiveStep U) a (objectiveStep V) ↔
      sourceLabelledStep U a V := by
  cases a with
  | false =>
      change
        (objectiveStep V = objectiveStep U) ↔ (V = U)
      constructor
      · intro h
        exact objective_W_is_injective h
      · intro h
        rw [h]
  | true =>
      change
        (objectiveStep V = objectiveStep (objectiveStep U)) ↔
          (V = objectiveStep U)
      constructor
      · exact objective_W_is_injective
      · intro h
        rw [h]

/-- An ACTUAL construction of the Cathedral's action-fixed source
symmetry from independently specified whole-U W, rather than
assuming ActionFixedSymmetry as an opaque physical hypothesis.
Only the selected 2-label toy menu and the Koru-existence source
predicate are certified. -/
def real_W_is_action_fixed_for_two_source_labels :
    ActionFixedSymmetry exactSourceOrbitCut sourceLabelledStep
      sourceMenuAllowed WholeHasIntrinsicKoru where
  move := {
    forward := objectiveStep
    backward := objectiveStep
    leftInv := objective_W_is_an_involution
    rightInv := objective_W_is_an_involution
  }
  cut := exact_orbit_cut_is_W_invariant
  sector := whole_Koru_existence_is_exact
  permission := by
    intro _ _
    exact Iff.rfl
  transition := by
    intro s a t
    exact two_label_source_step_is_action_fixed s t a

/-- Identity is also a valid source symmetry, with the two action
labels untouched. This will handle the trivial orbit member. -/
def identity_is_action_fixed_for_two_source_labels :
    ActionFixedSymmetry exactSourceOrbitCut sourceLabelledStep
      sourceMenuAllowed WholeHasIntrinsicKoru where
  move := {
    forward := id
    backward := id
    leftInv := by intro _; rfl
    rightInv := by intro _; rfl
  }
  cut := by intro _; rfl
  sector := by intro _; exact Iff.rfl
  permission := by intro _ _; exact Iff.rfl
  transition := by intro _ _ _; exact Iff.rfl

/-- Same exact W orbit cut implies the two whole source states are
either identical or related by the ACTUAL W pulse. Thus the
Cathedral action-fixed orbit obligation is derived, not posited.
This is an engineered mathematical orbit cut, not a sensor. -/
theorem exact_W_orbit_cut_has_action_fixed_orbits :
    CutIsActionFixedOrbit exactSourceOrbitCut sourceLabelledStep
      sourceMenuAllowed WholeHasIntrinsicKoru := by
  intro U V _ _ hCut
  have hSelf : exactSourceOrbitCut U U :=
    Or.inl rfl
  rw [hCut] at hSelf
  change U = V ∨ U = objectiveStep V at hSelf
  rcases hSelf with hSame | hSwap
  · exact ⟨identity_is_action_fixed_for_two_source_labels,
      hSame⟩
  · refine ⟨real_W_is_action_fixed_for_two_source_labels, ?_⟩
    have h := congrArg objectiveStep hSwap
    change objectiveStep U = V
    simpa only [objective_W_is_an_involution] using h

/-- Pointwise physical-SOURCE viability uses a concrete actual W
pulse rather than assuming a safe action exists. The permitted
source step is chosen independently of Koru's truth. -/
theorem frozen_W_source_pulse_preserves_Koru_sector :
    ∀ U : FiniteObjectiveU, WholeHasIntrinsicKoru U →
      ∃ a : Bool,
        GuardAction sourceLabelledStep sourceMenuAllowed
          WholeHasIntrinsicKoru U a := by
  intro U hU
  refine ⟨true, ?_, ?_⟩
  · trivial
  · intro V hStep
    change V = objectiveStep U at hStep
    rw [hStep]
    exact (whole_Koru_existence_is_exact U).mpr hU

/-- The actual, independently specified W symmetry plus the
specified action menu discharges the ORIGINAL CATHEDRAL action-fixed
forcing theorem for the bounded source Koru predicate. This is
not the original six-X3 protection law and not an implemented guard. -/
theorem exact_W_orbit_guardian_for_intrinsic_Koru_sector :
    ExistsCutGuardian exactSourceOrbitCut sourceLabelledStep
      sourceMenuAllowed WholeHasIntrinsicKoru :=
  source_symmetry_orbits_force_guardian
    exactSourceOrbitCut sourceLabelledStep
    sourceMenuAllowed WholeHasIntrinsicKoru
    exact_W_orbit_cut_has_action_fixed_orbits
    frozen_W_source_pulse_preserves_Koru_sector

/-! ## Hostile source control: action covariance ≠ action fixed

The same actual W that preserves every source operator and Koru
does NOT fix arbitrary physically indexed action-permission labels.
An operator-derived relation is an excellent test, because the
permission rule itself uses NO externally stipulated consent Boolean.
-/

/-- A proposed action label IS a basis position. Permission is a
source-derived link from that labeled position to the fixed 0 slot.
This is a model test, NOT a physically commissioned menu. -/
def positionIndexedPermission
    (U : FiniteObjectiveU) (a : Index) : Prop :=
  (sourceWholeWeb U).link a 0

/-- The action-label itself MUST move along with physical source W
to preserve this intrinsic permission relation. -/
theorem indexed_permission_is_W_covariant
    (U : FiniteObjectiveU) (a : Index) :
    positionIndexedPermission (objectiveStep U) (sourceTransport a) ↔
      positionIndexedPermission U a := by
  have h := complete_objective_link_carriage U a (0 : Index) 1
  have h0 : sourceTransport (0 : Index) = 0 := by decide
  simpa only [positionIndexedPermission, objectiveAt,
    trackedPosition, h0] using h

/-- A whole source with a directional operator edge from slot 2
to slot 0; this permission is TRUE on one explicitly named label. -/
def labelMovingWitness : FiniteObjectiveU :=
  fun _ => .atom (matrixUnit 2 0)

theorem indexed_witness_allows_original_slot_two :
    positionIndexedPermission labelMovingWitness 2 := by
  change matrixUnit (2 : Index) 0 2 0 ≠ 0
  decide

/-- The SAME action label 2 is no longer permitted after W:
its TRUE permission has moved to label 3. No relation was lost
from the whole; fixed-label invariance fails. -/
theorem indexed_witness_disallows_fixed_slot_two_after_W :
    ¬ positionIndexedPermission
      (objectiveStep labelMovingWitness) 2 := by
  intro h
  have h32 : sourceTransport (3 : Index) = 2 := by decide
  have hMoved :
      positionIndexedPermission
        (objectiveStep labelMovingWitness) (sourceTransport 3) := by
    simpa only [h32] using h
  have hOld : positionIndexedPermission labelMovingWitness 3 :=
    (indexed_permission_is_W_covariant labelMovingWitness 3).mp hMoved
  have hNotOld : ¬ positionIndexedPermission labelMovingWitness 3 := by
    change ¬ (matrixUnit (2 : Index) 0 3 0 ≠ 0)
    decide
  exact hNotOld hOld

/-- Whole-source covariance, even with actual complete operators
and an actual W pulse, does NOT force action-FIXED permission for
arbitrary position-indexed action labels. The missing restriction
on physically meaningful action labels has to be earned. -/
theorem whole_Koru_covariance_does_not_fix_arbitrary_action_labels :
    ¬ (∀ U : FiniteObjectiveU, ∀ a : Index,
      positionIndexedPermission (objectiveStep U) a ↔
        positionIndexedPermission U a) := by
  intro h
  have hStillAllowed :=
    (h labelMovingWitness 2).mpr
      indexed_witness_allows_original_slot_two
  exact indexed_witness_disallows_fixed_slot_two_after_W
    hStillAllowed

/-- The positive source example is a genuinely MOVING W update;
it is not an identity disguised as a conservation law. -/
theorem indexed_witness_physical_W_is_not_identity :
    objectiveStep labelMovingWitness ≠ labelMovingWitness := by
  intro h
  apply indexed_witness_disallows_fixed_slot_two_after_W
  rw [h]
  exact indexed_witness_allows_original_slot_two

#print axioms objective_W_is_an_involution
#print axioms objective_W_is_injective
#print axioms whole_Koru_existence_is_exact
#print axioms real_source_Koru_witness_is_in_the_sector
#print axioms two_label_source_step_is_action_fixed
#print axioms real_W_is_action_fixed_for_two_source_labels
#print axioms exact_W_orbit_cut_has_action_fixed_orbits
#print axioms frozen_W_source_pulse_preserves_Koru_sector
#print axioms exact_W_orbit_guardian_for_intrinsic_Koru_sector
#print axioms indexed_permission_is_W_covariant
#print axioms indexed_witness_disallows_fixed_slot_two_after_W
#print axioms whole_Koru_covariance_does_not_fix_arbitrary_action_labels
#print axioms indexed_witness_physical_W_is_not_identity

end PhysicalBridges.KoruWActionFixedSymmetry
