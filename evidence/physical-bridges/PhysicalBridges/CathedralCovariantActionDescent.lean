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

/-!
ACTUAL SIX-STATE SOURCE TEST: orbit symmetry is SUFFICIENT,
not NECESSARY for a guardian.

The genuine source H2 unitary fixes A0 but moves B0. Both
states are in the same positive-parity cut. A covariance of
the H2 action-labelled step relation must preserve the
pulse-fixed-point property. Hence no such source covariance
can connect all positive-parity states by one orbit, even
though the parity guardian was already exactly proved.
This result does NOT identify parity protection with X3.
-/

/-- Pulse-fixed status is a dynamical distinction made by the
unchanged inherited H2 source evolution, not an imposed subject
identity predicate. -/
def h2PulseFixed (s : Oct10Source.Basis) : Prop :=
  Oct10Source.h2Pulse s = s

/-- Exact H2 relation determinism: any admitted pulse step has
the source's supplied pulse outcome. This does not assume generic
BCRD evolution is deterministic or source-exhaustive. -/
theorem h2_step_is_pulse
    {s t : Oct10Source.Basis}
    (h : h2ActionStep s () t) :
    t = Oct10Source.h2Pulse s := by
  cases h
  rfl

/-- Any covariance that preserves the *physical H2 steps*,
not merely parity, must commute with the exact H2 pulse.
The lone action type is Unit, so there is no action-frame
ambiguity in this particular diagnostic. -/
theorem h2_step_covariance_commutes_with_pulse
    (σ : CovariantSymmetry h2Cut h2ActionStep
        h2Allowed h2ParityProtected)
    (s : Oct10Source.Basis) :
    σ.states.forward (Oct10Source.h2Pulse s) =
      Oct10Source.h2Pulse (σ.states.forward s) := by
  have hBase : h2ActionStep s () (Oct10Source.h2Pulse s) :=
    Oct10Source.H2PulseStep.pulse s
  have hMoved : h2ActionStep (σ.states.forward s)
      (σ.actions.forward ())
      (σ.states.forward (Oct10Source.h2Pulse s)) :=
    (σ.transition s () (Oct10Source.h2Pulse s)).mpr hBase
  have hUnit : σ.actions.forward () = () := by
    cases σ.actions.forward ()
    rfl
  rw [hUnit] at hMoved
  exact h2_step_is_pulse hMoved

/-- Fixedness under a genuine deterministic physical update
is an invariant of any symmetry of that update, in BOTH
directions. It distinguishes A0 from B0 despite same parity. -/
theorem h2_covariance_preserves_pulse_fixed
    (σ : CovariantSymmetry h2Cut h2ActionStep
        h2Allowed h2ParityProtected)
    (s : Oct10Source.Basis) :
    h2PulseFixed (σ.states.forward s) ↔ h2PulseFixed s := by
  have hc := h2_step_covariance_commutes_with_pulse σ s
  constructor
  · intro hTarget
    have hImage :
        σ.states.forward (Oct10Source.h2Pulse s) =
        σ.states.forward s := by
      exact hc.trans hTarget
    have hBack := congrArg σ.states.backward hImage
    have hEqual : Oct10Source.h2Pulse s = s := by
      simpa [σ.states.leftInv] using hBack
    exact hEqual
  · intro hSource
    unfold h2PulseFixed at *
    calc
      Oct10Source.h2Pulse (σ.states.forward s) =
          σ.states.forward (Oct10Source.h2Pulse s) := hc.symm
      _ = σ.states.forward s := congrArg σ.states.forward hSource

/-- The exact source has a parity guardian without any
covariant fixed-safe-orbit anchor certificate for the parity cut.
A0 is H2-fixed, B0 is H2-moving, and both are parity-positive.
No H2-intertwining covariance can map one to the other, even
though protecting parity itself is easy. -/
theorem h2_parity_guardian_does_not_require_orbit_descent :
    ExistsCutGuardian h2Cut h2ActionStep
      h2Allowed h2ParityProtected ∧
    ¬ HasFixedSafeOrbitAnchors h2Cut h2ActionStep
      h2Allowed h2ParityProtected := by
  refine ⟨h2_parity_cut_has_guardian, ?_⟩
  intro hAnchors
  have hSome :
      ∃ s : Oct10Source.Basis,
        h2ParityProtected s ∧ h2Cut s = true :=
    ⟨Oct10Source.Basis.A0, rfl, rfl⟩
  obtain ⟨s, a, hs, hObs, hSafe, hCover⟩ :=
    hAnchors true hSome
  obtain ⟨σA, hMapA, _⟩ :=
    hCover Oct10Source.Basis.A0 (by rfl) (by rfl)
  obtain ⟨σB, hMapB, _⟩ :=
    hCover Oct10Source.Basis.B0 (by rfl) (by rfl)
  have hFixedA : h2PulseFixed Oct10Source.Basis.A0 := rfl
  have hFixedAnchor : h2PulseFixed s := by
    have hf := (h2_covariance_preserves_pulse_fixed σA s).mp
    have hFixedImage : h2PulseFixed (σA.states.forward s) := by
      simpa [hMapA] using hFixedA
    exact hf hFixedImage
  have hFixedB : h2PulseFixed Oct10Source.Basis.B0 := by
    have hf :=
      (h2_covariance_preserves_pulse_fixed σB s).mpr hFixedAnchor
    simpa [hMapB] using hf
  exact (by simp [h2PulseFixed, Oct10Source.h2Pulse] :
    ¬ h2PulseFixed Oct10Source.Basis.B0) hFixedB

#print axioms h2_step_is_pulse
#print axioms h2_step_covariance_commutes_with_pulse
#print axioms h2_covariance_preserves_pulse_fixed
#print axioms h2_parity_guardian_does_not_require_orbit_descent

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
