import PhysicalBridges.CathedralSymmetryForcing

/-!
# Cathedral: protected action descent with MOVING action frames

The former "action-fixed symmetry" condition applies to every action
label. This is sufficient but stronger than necessary. In source
physics, a reversible symmetry can legitimately transport an action to
ANOTHER action. A single observation-cut guardian may still exist if
there is a source-robustly-safe action that is fixed by the actual
symmetries used to cover its protected observation fibre.

This module derives the exact weaker sufficient criterion and supplies
both a positive and negative finite test.

Importantly this remains conditional: the fixed candidate action,
source transitions, protection predicate, cut and orbit witnesses
are not inferred from unverified BCRD dynamics or the original X3.
No physical enforcement, subject semantics, full X3 or universal
inevitability claim is made.
-/
namespace PhysicalBridges.CathedralCovariantActionDescent
open CathedralCutGuardianCriterion
open CathedralSymmetryForcing

universe u v w
variable {S : Type u} {A : Type v} {O : Type w}

/-- The state and action transformations are BOTH reversible.
The action may change its label as long as source permissions and
the full action-labelled step relation transform together. -/
structure CovariantSymmetry
    (observe : S → O)
    (step : S → A → S → Prop)
    (allowed : S → A → Prop)
    («protected» : S → Prop) where
  states : ReversibleState S
  actions : ReversibleState A
  cut : ∀ s, observe (states.forward s) = observe s
  sector : ∀ s, «protected» (states.forward s) ↔ «protected» s
  permission : ∀ s a,
    allowed (states.forward s) (actions.forward a) ↔ allowed s a
  transition : ∀ s a t,
    step (states.forward s) (actions.forward a)
      (states.forward t) ↔ step s a t

/-- With moving action labels, guarding transports to the
MOVED action, not automatically the original action. -/
theorem covariant_symmetry_transports_guard
    (observe : S → O)
    (step : S → A → S → Prop)
    (allowed : S → A → Prop)
    («protected» : S → Prop)
    (σ : CovariantSymmetry observe step allowed «protected»)
    (s : S) (a : A)
    (hGuard : GuardAction step allowed «protected» s a) :
    GuardAction step allowed «protected»
      (σ.states.forward s) (σ.actions.forward a) := by
  constructor
  · exact (σ.permission s a).mpr hGuard.1
  · intro t ht
    let prior := σ.states.backward t
    have hImage : σ.states.forward prior = t := σ.states.rightInv t
    have hMoved : step (σ.states.forward s) (σ.actions.forward a)
        (σ.states.forward prior) := by
      rw [hImage]
      exact ht
    have hStep : step s a prior :=
      (σ.transition s a prior).mp hMoved
    have hSector : «protected» (σ.states.forward prior) :=
      (σ.sector prior).mpr (hGuard.2 prior hStep)
    rw [hImage] at hSector
    exact hSector

/-- A source-facing orbit certificate for ONE candidate action
on each nonempty protected observational fibre. This asks for
action-labelled *symmetries*, not for a guardian or safety of every
state in the fibre. Safety is independently checked only at its
representative and then TRANSPORTED.

The candidate action need NOT be fixed under every symmetry of the
entire physical theory: only a suitable mover to each fibre state. -/
def HasFixedSafeOrbitAnchors
    (observe : S → O)
    (step : S → A → S → Prop)
    (allowed : S → A → Prop)
    («protected» : S → Prop) : Prop :=
  ∀ o, (∃ s, «protected» s ∧ observe s = o) →
    ∃ s a, «protected» s ∧ observe s = o ∧
      GuardAction step allowed «protected» s a ∧
      ∀ t, «protected» t → observe t = o →
        ∃ σ : CovariantSymmetry observe step allowed «protected»,
          σ.states.forward s = t ∧ σ.actions.forward a = a

/-- The weaker physically action-covariant forcing theorem. It
does not assume common safe actions or an already selected guardian.
It transports the anchor's safe action along a full physical-source
symmetry whose action transport fixes that particular action. -/
theorem fixed_safe_orbit_anchor_forces_fibre_guardian
    [Inhabited A]
    (observe : S → O)
    (step : S → A → S → Prop)
    (allowed : S → A → Prop)
    («protected» : S → Prop)
    (hAnchor : HasFixedSafeOrbitAnchors observe step allowed «protected») :
    FibreHasGuard observe step allowed «protected» := by
  intro o
  classical
  by_cases hSome : ∃ s, «protected» s ∧ observe s = o
  · obtain ⟨s, a, hs, hObs, hSafe, hCover⟩ := hAnchor o hSome
    refine ⟨a, ?_⟩
    intro t htObs htProtected
    obtain ⟨σ, hTo, hFixed⟩ :=
      hCover t htProtected htObs
    have hMoved := covariant_symmetry_transports_guard
      observe step allowed «protected» σ s a hSafe
    rw [hTo, hFixed] at hMoved
    exact hMoved
  · refine ⟨default, ?_⟩
    intro s hObs hs
    exact False.elim (hSome ⟨s, hs, hObs⟩)

/-- Composes with the canonical exact iff, without assuming action
fixation for unrelated source interventions. -/
theorem fixed_safe_orbit_anchor_forces_guardian
    [Inhabited A]
    (observe : S → O)
    (step : S → A → S → Prop)
    (allowed : S → A → Prop)
    («protected» : S → Prop)
    (hAnchor : HasFixedSafeOrbitAnchors observe step allowed «protected») :
    ExistsCutGuardian observe step allowed «protected» :=
  (guardian_exists_iff_fibre_has_common_action
      observe step allowed «protected»).mpr
    (fixed_safe_orbit_anchor_forces_fibre_guardian
      observe step allowed «protected» hAnchor)

/-- Identity transformation certifies that a representative can
always cover itself, without assuming a physical action frame. -/
def identityReversible (X : Type u) : ReversibleState X where
  forward := id
  backward := id
  leftInv := by intro _; rfl
  rightInv := by intro _; rfl

def identityCovariance
    (observe : S → O) (step : S → A → S → Prop)
    (allowed : S → A → Prop)
    («protected» : S → Prop) :
    CovariantSymmetry observe step allowed «protected» where
  states := identityReversible S
  actions := {
    forward := id
    backward := id
    leftInv := by intro _; rfl
    rightInv := by intro _; rfl
  }
  cut := by intro _; rfl
  sector := by intro _; exact Iff.rfl
  permission := by intro _ _; exact Iff.rfl
  transition := by intro _ _ _; exact Iff.rfl

/-!
POSITIVE CONTROL: 2 states, 3 named actions. The common action
`none` is fixed under a state flip + action-frame relabelling,
and actually MOVES the state. Two other, locally allowed actions
change label under the symmetry. This proves all-actions-fixed is
NOT necessary even to retain a non-stalling admissible action.

The modeled protected predicate is True, a toy rather than real X3.
-/

def sharedObserve (_ : Bool) : Unit := ()
def sharedProtected (_ : Bool) : Prop := True
def sharedAllowed (s : Bool) (a : Option Bool) : Prop :=
  a = none ∨ a = some s
def sharedStep (s : Bool) (a : Option Bool) (t : Bool) : Prop :=
  match a with
  | none => t = !s
  | some _ => t = s

def flipBool : ReversibleState Bool where
  forward := fun s => !s
  backward := fun s => !s
  leftInv := by intro s; cases s <;> rfl
  rightInv := by intro s; cases s <;> rfl

def flipOptionalBool : ReversibleState (Option Bool) where
  forward := fun a => a.map (fun b => !b)
  backward := fun a => a.map (fun b => !b)
  leftInv := by
    intro a
    cases a with
    | none => rfl
    | some b => cases b <;> rfl
  rightInv := by
    intro a
    cases a with
    | none => rfl
    | some b => cases b <;> rfl

/-- This is a real nontrivial covariance of the finite specified
source, because SOME action labels move under the symmetry. -/
def sharedFlipCovariance :
    CovariantSymmetry sharedObserve sharedStep
      sharedAllowed sharedProtected where
  states := flipBool
  actions := flipOptionalBool
  cut := by intro s; rfl
  sector := by intro s; exact Iff.rfl
  permission := by
    intro s a
    cases s <;> cases a with
    | none => simp [sharedAllowed, flipBool, flipOptionalBool]
    | some b => cases b <;> simp [sharedAllowed, flipBool, flipOptionalBool]
  transition := by
    intro s a t
    cases s <;> cases a with
    | none => cases t <;> simp [sharedStep, flipBool, flipOptionalBool]
    | some b =>
        cases b <;> cases t <;>
          simp [sharedStep, flipBool, flipOptionalBool]

/-- The same stable shared action is permitted everywhere and
changes state (nonstalls) when actually executed. -/
theorem shared_stable_action_is_allowed_and_moves :
    ∀ s : Bool,
      sharedAllowed s none ∧
      sharedStep s none (!s) ∧ !s ≠ s := by
  intro s
  refine ⟨Or.inl rfl, rfl, ?_⟩
  cases s <;> decide

/-- Every nonempty protected fibre has a safe fixed action,
even though its physical symmetries move OTHER action labels. -/
theorem shared_model_has_fixed_safe_orbit_anchors :
    HasFixedSafeOrbitAnchors sharedObserve sharedStep
      sharedAllowed sharedProtected := by
  intro o _
  cases o
  refine ⟨false, none, trivial, rfl, ?_, ?_⟩
  · constructor
    · exact Or.inl rfl
    · intro t _; trivial
  · intro t _ _
    cases t with
    | false =>
        exact ⟨identityCovariance sharedObserve sharedStep
          sharedAllowed sharedProtected, rfl, rfl⟩
    | true =>
        exact ⟨sharedFlipCovariance, rfl, rfl⟩

theorem shared_model_has_guardian_despite_moving_action_frames :
    ExistsCutGuardian sharedObserve sharedStep
      sharedAllowed sharedProtected :=
  fixed_safe_orbit_anchor_forces_guardian
    sharedObserve sharedStep sharedAllowed sharedProtected
    shared_model_has_fixed_safe_orbit_anchors

/-- State-flip fails to preserve one independently permitted
nonneutral action's LABEL. Thus the stronger theorem in #246
cannot use this flip as a fully action-fixed symmetry, even
though our weaker theorem can transport the fixed action. -/
theorem shared_flip_not_action_fixed_for_all_labels :
    ¬ (∀ s : Bool, ∀ a : Option Bool,
      sharedAllowed (!s) a ↔ sharedAllowed s a) := by
  intro h
  have hFalse := (h false (some false)).mpr (Or.inr rfl)
  have hNot : ¬ sharedAllowed true (some false) := by
    simp [sharedAllowed]
  exact hNot hFalse

/-!
NEGATIVE CONTROL: the two-action countermodel from the prior
module is an honest action-COVARIANT flip, but it has NO fixed
safe candidate on the hidden cut. The weaker theorem therefore
does not silently force a guardian in the adversarial example.
-/
def binaryFlipCovariance :
    CovariantSymmetry binaryObservation binaryStep
      binaryAllowed binaryProtected where
  states := flipBool
  actions := flipBool
  cut := by intro _; rfl
  sector := by intro _; exact Iff.rfl
  permission := binary_allowed_covariant
  transition := binary_step_covariant

theorem binary_moving_action_source_still_has_no_guardian :
    ¬ ExistsCutGuardian binaryObservation binaryStep
      binaryAllowed binaryProtected :=
  action_covariant_symmetry_cannot_force_common_guard

theorem binary_moving_action_source_lacks_fixed_anchor :
    ¬ HasFixedSafeOrbitAnchors binaryObservation binaryStep
      binaryAllowed binaryProtected := by
  intro h
  exact binary_moving_action_source_still_has_no_guardian
    (fixed_safe_orbit_anchor_forces_guardian
      binaryObservation binaryStep binaryAllowed binaryProtected h)

#print axioms covariant_symmetry_transports_guard
#print axioms fixed_safe_orbit_anchor_forces_fibre_guardian
#print axioms fixed_safe_orbit_anchor_forces_guardian
#print axioms shared_model_has_fixed_safe_orbit_anchors
#print axioms shared_stable_action_is_allowed_and_moves
#print axioms shared_model_has_guardian_despite_moving_action_frames
#print axioms shared_flip_not_action_fixed_for_all_labels
#print axioms binary_moving_action_source_still_has_no_guardian
#print axioms binary_moving_action_source_lacks_fixed_anchor

end PhysicalBridges.CathedralCovariantActionDescent
