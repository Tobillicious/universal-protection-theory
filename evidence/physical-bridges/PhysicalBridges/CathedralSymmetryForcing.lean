import PhysicalBridges.CathedralCutGuardianCriterion

/-!
CATHEDRAL: physically meaningful, action-FIXED source symmetries
can force a common guardian on each observational cut fibre.

This is a NEW conditional route to the already-proved cut-guardian
criterion; it does NOT assume the guardian as a premise and it does
NOT define "Allowed" in terms of safety. It proves common safe actions
from: independently supplied action-labelled source transitions,
independently supplied permission and protected-sector predicates,
pointwise viability, and a strong physical cut-orbit symmetry
whose state transformation LEAVES THE ACTION LABEL UNCHANGED.

Crucial distinction: covariance where an action label MOVES under
the symmetry does NOT imply a single cut-observation-only action.
The Bool countermodel at the end has transitive state symmetry,
covariant permissions/transitions, pointwise viability, and
no common guardian.

It does not establish that actual BCRD has the stated action-fixed
symmetry, that its cuts coincide with symmetry orbits, that original
X3 protections coincide with "protected", or that physical mediation
is enforced. No universal UPT proof or new physics claimed.
-/

namespace PhysicalBridges.CathedralSymmetryForcing

open CathedralCutGuardianCriterion
universe u v w
variable {S : Type u} {A : Type v} {O : Type w}

/-- A reversible transformation of states. No action or observation
semantics are smuggled into this bare reversible map. -/
structure ReversibleState (S : Type u) where
  forward : S → S
  backward : S → S
  leftInv : ∀ s : S, backward (forward s) = s
  rightInv : ∀ s : S, forward (backward s) = s

/-- Source symmetry with action labels FIXED:
physical permission, all action-labelled successors, the
protected predicate and the actual observation cut are preserved.

These are independently verifiable SOURCE obligations, not laws of
logic and not definitions of original X3. Especially important:
step covariance is over ALL modeled successors, not just those
already known to satisfy "protected". -/
structure ActionFixedSymmetry
    (observe : S → O)
    (step : S → A → S → Prop)
    (allowed : S → A → Prop)
    («protected» : S → Prop) where
  move : ReversibleState S
  cut : ∀ s, observe (move.forward s) = observe s
  sector : ∀ s, «protected» (move.forward s) ↔ «protected» s
  permission : ∀ s a,
    allowed (move.forward s) a ↔ allowed s a
  transition : ∀ s a t,
    step (move.forward s) a (move.forward t) ↔ step s a t

/-- Transport a concrete action's safety via the actual
action-indexed transition and source-sector invariance.
The very same action label survives the physical symmetry. -/
theorem action_fixed_symmetry_transports_guard
    (observe : S → O)
    (step : S → A → S → Prop)
    (allowed : S → A → Prop)
    («protected» : S → Prop)
    (σ : ActionFixedSymmetry observe step allowed «protected»)
    (s : S) (a : A)
    (hSafe : GuardAction step allowed «protected» s a) :
    GuardAction step allowed «protected» (σ.move.forward s) a := by
  constructor
  · exact (σ.permission s a).mpr hSafe.1
  · intro target hTarget
    let prior : S := σ.move.backward target
    have hImage : σ.move.forward prior = target := σ.move.rightInv target
    have hMoved : step (σ.move.forward s) a
        (σ.move.forward prior) := by
      rw [hImage]
      exact hTarget
    have hPrior : step s a prior :=
      (σ.transition s a prior).mp hMoved
    have hProtected : «protected» (σ.move.forward prior) :=
      (σ.sector prior).mpr (hSafe.2 prior hPrior)
    rw [hImage] at hProtected
    exact hProtected

/-- The source CUT fibres are transitive under genuine action-fixed
physical symmetries, rather than assuming response equality at cuts.
No chosen guardian is included in this premise. -/
def CutIsActionFixedOrbit
    (observe : S → O)
    (step : S → A → S → Prop)
    (allowed : S → A → Prop)
    («protected» : S → Prop) : Prop :=
  ∀ s t, «protected» s → «protected» t →
    observe s = observe t →
    ∃ σ : ActionFixedSymmetry observe step allowed «protected»,
      σ.move.forward s = t

/-- The physically meaningful forcing theorem:
(1) robustly viable action at each protected state, and
(2) an action-FIXED source symmetry taking any protected
cut-compatible state to any other, jointly imply the
existing fibre-common-action certificate and hence guardian existence.
Safety is not built into the meaning of allowed or symmetry. -/
theorem source_symmetry_orbits_force_fibre_guard
    [Inhabited A]
    (observe : S → O)
    (step : S → A → S → Prop)
    (allowed : S → A → Prop)
    («protected» : S → Prop)
    (hOrbit : CutIsActionFixedOrbit observe step allowed «protected»)
    (hViable : ∀ s, «protected» s →
      ∃ a, GuardAction step allowed «protected» s a) :
    FibreHasGuard observe step allowed «protected» := by
  intro o
  classical
  by_cases hSome : ∃ s, «protected» s ∧ observe s = o
  · obtain ⟨s, hsProtected, hsObserve⟩ := hSome
    obtain ⟨a, hSafe⟩ := hViable s hsProtected
    refine ⟨a, ?_⟩
    intro t htObserve htProtected
    obtain ⟨σ, hTo⟩ :=
      hOrbit s t hsProtected htProtected (hsObserve.trans htObserve.symm)
    have hTransport :=
      action_fixed_symmetry_transports_guard
        observe step allowed «protected» σ s a hSafe
    rw [hTo] at hTransport
    exact hTransport
  · refine ⟨default, ?_⟩
    intro t htObserve htProtected
    exact False.elim (hSome ⟨t, htProtected, htObserve⟩)

/-- The forcing result composes with the established exact criterion.
It is still mathematical existence, not an enacted/implemented policy. -/
theorem source_symmetry_orbits_force_guardian
    [Inhabited A]
    (observe : S → O)
    (step : S → A → S → Prop)
    (allowed : S → A → Prop)
    («protected» : S → Prop)
    (hOrbit : CutIsActionFixedOrbit observe step allowed «protected»)
    (hViable : ∀ s, «protected» s →
      ∃ a, GuardAction step allowed «protected» s a) :
    ExistsCutGuardian observe step allowed «protected» :=
  (guardian_exists_iff_fibre_has_common_action
      observe step allowed «protected»).mpr
    (source_symmetry_orbits_force_fibre_guard
      observe step allowed «protected» hOrbit hViable)

/-!
HOSTILE CONTROL: action covariance, without a FIXED action label,
is too weak. Both states share a cut; the state-flip symmetry swaps
which action is permitted. Every state has a locally safe action,
but no action can protect the entire cut.

This is a purely mathematical countermodel, NOT a claim that
real BCRD behaves this way or violates original X3.
-/

def binaryObservation (_ : Bool) : Bool := true
def binaryAllowed (s a : Bool) : Prop := s = a
def binaryStep (s _a t : Bool) : Prop := t = s
def binaryProtected (_ : Bool) : Prop := True

/-- Source availability is supplied independently of
"protected", which is identically True here. -/
theorem binary_pointwise_viability :
    ∀ s : Bool, binaryProtected s →
      ∃ a : Bool,
        GuardAction binaryStep binaryAllowed binaryProtected s a := by
  intro s _
  refine ⟨s, ?_⟩
  constructor
  · rfl
  · intro t _
    trivial

/-- The state fibre is exactly the orbit of state-flip; the
symmetry is transitive, and the cut cannot distinguish the states. -/
theorem binary_flip_orbit_transitive :
    ∀ s t : Bool, s = t ∨ (!s) = t := by
  intro s t
  cases s <;> cases t <;> decide

/-- Covariance of the permission relation when BOTH the state
and action transform together. This is not action-fixed symmetry. -/
theorem binary_allowed_covariant
    (s a : Bool) :
    binaryAllowed (!s) (!a) ↔ binaryAllowed s a := by
  cases s <;> cases a <;> simp [binaryAllowed]

theorem binary_step_covariant
    (s a t : Bool) :
    binaryStep (!s) (!a) (!t) ↔ binaryStep s a t := by
  cases s <;> cases a <;> cases t <;> simp [binaryStep]

/-- Despite pointwise viability, strong state-transitivity and full
simultaneous state/action covariance, there is no observation-only
guardian; the safe action must change with the hidden state. -/
theorem action_covariant_symmetry_cannot_force_common_guard :
    ¬ ExistsCutGuardian binaryObservation binaryStep
        binaryAllowed binaryProtected := by
  rintro ⟨policy, hGuard⟩
  have hFalse := (hGuard false trivial).1
  have hTrue := (hGuard true trivial).1
  have hf : false = policy true := hFalse
  have ht : true = policy true := hTrue
  have hContradiction : false = true := hf.trans ht.symm
  cases hContradiction

/-- The state-flip is NOT a physical action-fixed symmetry of
this permission relation. The exact missing premise is visible. -/
theorem state_flip_does_not_preserve_fixed_action :
    ¬ (∀ s a : Bool,
      binaryAllowed (!s) a ↔ binaryAllowed s a) := by
  intro h
  have hc := h false false
  have hTrue : binaryAllowed false false := rfl
  have hFalse : binaryAllowed (!false) false := hc.mpr hTrue
  exact (by simp [binaryAllowed] : ¬ binaryAllowed (!false) false) hFalse

#print axioms action_fixed_symmetry_transports_guard
#print axioms source_symmetry_orbits_force_fibre_guard
#print axioms source_symmetry_orbits_force_guardian
#print axioms binary_pointwise_viability
#print axioms binary_flip_orbit_transitive
#print axioms binary_allowed_covariant
#print axioms binary_step_covariant
#print axioms action_covariant_symmetry_cannot_force_common_guard
#print axioms state_flip_does_not_preserve_fixed_action

end PhysicalBridges.CathedralSymmetryForcing
