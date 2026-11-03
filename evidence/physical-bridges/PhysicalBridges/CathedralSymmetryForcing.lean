import PhysicalBridges.CathedralCutGuardianCriterion
import PhysicalBridges.Oct10SourceHamiltonianProtection

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

/-!
ACTUAL FROZEN SIX-STATE SOURCE DIAGNOSTIC.

The inherited BCRD H2 source pulse is reversible and parity-preserving,
yet sends local B-site occupation B0 to C1. In this bounded source
model, with the pulse as the ONLY available Unit action:
- a guardian for positive parity DOES exist;
- a guardian for local B-site occupation DOES NOT exist;
- the pulse cannot be an action-fixed symmetry for B-site protection.

This establishes a sharp *source-relative* forcing distinction.
Crucially B-site occupancy is NOT a validated actual subject or the
original X3 protected predicate. This is not a physical X3 refutation.
-/

def h2Cut (s : Oct10Source.Basis) : Bool :=
  Oct10Source.positiveParity s

def h2Allowed (_s : Oct10Source.Basis) (_a : Unit) : Prop := True

def h2ActionStep (s : Oct10Source.Basis) (_a : Unit)
    (t : Oct10Source.Basis) : Prop :=
  Oct10Source.H2PulseStep s t

def h2SiteProtected (s : Oct10Source.Basis) : Prop :=
  Oct10Source.bSiteOccupied s = true

def h2ParityProtected (s : Oct10Source.Basis) : Prop :=
  Oct10Source.positiveParity s = true

/-- A source-supported reversible frame, independent of any
subject interpretation or assertion that it preserves X3. -/
def h2SourceReversible : ReversibleState Oct10Source.Basis where
  forward := Oct10Source.h2Pulse
  backward := Oct10Source.h2Pulse
  leftInv := Oct10Source.h2_pulse_is_involution
  rightInv := Oct10Source.h2_pulse_is_involution

/-- This source symmetry preserves the actual modeled parity readout. -/
theorem h2_reversible_source_preserves_parity_cut :
    ∀ s : Oct10Source.Basis,
      h2Cut (h2SourceReversible.forward s) = h2Cut s :=
  Oct10Source.source_h2_preserves_parity

/-- Source-relative POSITIVE proof: the real modeled H2 pulse
preserves positive parity, so a policy exists for that weaker,
separately declared parity predicate. -/
theorem h2_parity_cut_has_guardian :
    ExistsCutGuardian h2Cut h2ActionStep
      h2Allowed h2ParityProtected := by
  refine ⟨fun _ => (), ?_⟩
  intro s hs
  constructor
  · trivial
  · intro t hStep
    change Oct10Source.H2PulseStep s t at hStep
    cases hStep with
    | pulse state =>
        exact (Oct10Source.source_h2_preserves_parity state).trans hs

/-- Source-relative NEGATIVE proof: the same permitted pulse has
a protected B0 to unprotected C1 successor. Pointwise robust
viability already fails for the local-site predicate. -/
theorem h2_site_robust_viability_fails :
    ¬ (∀ s : Oct10Source.Basis, h2SiteProtected s →
      ∃ a : Unit,
        GuardAction h2ActionStep h2Allowed h2SiteProtected s a) := by
  intro hViable
  obtain ⟨a, hSafe⟩ :=
    hViable Oct10Source.Basis.B0 (by decide)
  have hPulse : h2ActionStep .B0 a .C1 :=
    Oct10Source.H2PulseStep.pulse .B0
  have hUnsafe : h2SiteProtected .C1 := hSafe.2 .C1 hPulse
  exact (by decide : ¬ h2SiteProtected .C1) hUnsafe

/-- Thus a local-site guardian does not exist on the parity cut.
This does not treat site occupancy as a conscious identity. -/
theorem h2_site_cut_has_no_guardian :
    ¬ ExistsCutGuardian h2Cut h2ActionStep
        h2Allowed h2SiteProtected := by
  rintro ⟨policy, hPolicy⟩
  have hSafe := hPolicy Oct10Source.Basis.B0 (by decide)
  have hPulse : h2ActionStep .B0 (policy (h2Cut .B0)) .C1 :=
    Oct10Source.H2PulseStep.pulse .B0
  have hUnsafe : h2SiteProtected .C1 := hSafe.2 .C1 hPulse
  exact (by decide : ¬ h2SiteProtected .C1) hUnsafe

/-- The reversible, cut-preserving pulse is NOT a symmetry
preserving this local-site protected predicate. It cannot be
quietly substituted into the physical premises of the
positive source-symmetry forcing theorem. -/
theorem h2_pulse_is_not_site_action_fixed_symmetry :
    ¬ ∃ σ : ActionFixedSymmetry h2Cut h2ActionStep
        h2Allowed h2SiteProtected,
      σ.move.forward Oct10Source.Basis.B0 =
        Oct10Source.h2Pulse Oct10Source.Basis.B0 := by
  rintro ⟨σ, hMove⟩
  have hSource : h2SiteProtected Oct10Source.Basis.B0 := by decide
  have hImage : h2SiteProtected
      (σ.move.forward Oct10Source.Basis.B0) :=
    (σ.sector Oct10Source.Basis.B0).mpr hSource
  rw [hMove] at hImage
  exact (by decide :
    ¬ h2SiteProtected (Oct10Source.h2Pulse Oct10Source.Basis.B0)) hImage

#print axioms h2_reversible_source_preserves_parity_cut
#print axioms h2_parity_cut_has_guardian
#print axioms h2_site_robust_viability_fails
#print axioms h2_site_cut_has_no_guardian
#print axioms h2_pulse_is_not_site_action_fixed_symmetry

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
