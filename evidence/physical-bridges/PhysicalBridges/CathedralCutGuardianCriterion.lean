import PhysicalBridges.IR109RobustObservationViability
import PhysicalBridges.IR132ExactBoundaryReconstruction
import PhysicalBridges.IR96DisturbanceSimulation

/-!
CATHEDRAL CUT-GUARD-IFF: exact boundary-fibre action certificate.
Source mathematics, not original-X3 physical certification.
No Hamiltonians, Hilbert spaces or new physics.
Kernel-checked with Lean 4.35.0; original UPT remains unchanged.
-/
namespace PhysicalBridges.CathedralCutGuardianCriterion

universe u v w z
variable {S : Type u} {A : Type v} {O : Type w}

/-- Allowed and safe against ALL modeled successors. Allowed must
be externally sourced, not chosen to encode the desired UPT result. -/
def GuardAction (step : S → A → S → Prop)
    (allowed : S → A → Prop) («protected» : S → Prop)
    (s : S) (a : A) : Prop :=
  allowed s a ∧ ∀ t, step s a t → «protected» t

/-- A common physically allowed protective action per cut fibre. -/
def FibreHasGuard (observe : S → O)
    (step : S → A → S → Prop)
    (allowed : S → A → Prop) («protected» : S → Prop) : Prop :=
  ∀ o : O, ∃ a : A, ∀ s : S,
    observe s = o → «protected» s →
      GuardAction step allowed «protected» s a

/-- Existence only: a guardian may still be uncomputable or unenforced. -/
def ExistsCutGuardian (observe : S → O)
    (step : S → A → S → Prop)
    (allowed : S → A → Prop) («protected» : S → Prop) : Prop :=
  ∃ policy : O → A, ∀ s : S, «protected» s →
    GuardAction step allowed «protected» s (policy (observe s))

/-- Necessary and sufficient CUT-ACTION certificate.
Choice is a mathematical existence proof, not hardware enforcement. -/
theorem guardian_exists_iff_fibre_has_common_action
    (observe : S → O) (step : S → A → S → Prop)
    (allowed : S → A → Prop) («protected» : S → Prop) :
    ExistsCutGuardian observe step allowed «protected» ↔
      FibreHasGuard observe step allowed «protected» := by
  constructor
  · rintro ⟨policy, hpolicy⟩ o
    refine ⟨policy o, ?_⟩
    intro s hs hp
    simpa [hs] using hpolicy s hp
  · intro hfibre
    classical
    let policy : O → A := fun o => Classical.choose (hfibre o)
    refine ⟨policy, ?_⟩
    intro s hp
    exact (Classical.choose_spec (hfibre (observe s))) s rfl hp

/-- Additional genuinely separating cut information cannot DESTROY
an already available guarded policy, when its source factorization
is certified. It does not certify a physical extra sensor. -/
theorem cut_refinement_preserves_guardian
    {Fine : Type z} (coarse : S → O) (fine : S → Fine)
    (forget : Fine → O)
    (hFactor : ∀ s, coarse s = forget (fine s))
    (step : S → A → S → Prop)
    (allowed : S → A → Prop) («protected» : S → Prop)
    (hCoarse : ExistsCutGuardian coarse step allowed «protected») :
    ExistsCutGuardian fine step allowed «protected» := by
  obtain ⟨policy, hpolicy⟩ := hCoarse
  refine ⟨fun b => policy (forget b), ?_⟩
  intro s hp
  change GuardAction step allowed «protected» s (policy (forget (fine s)))
  rw [← hFactor s]
  exact hpolicy s hp

/-- Two protected states with incompatible allowed safe-action sets
MUST have different cut observations for a guardian to exist. -/
theorem guard_conflict_forces_distinguishing_cut
    (observe : S → O) (step : S → A → S → Prop)
    (allowed : S → A → Prop) («protected» : S → Prop)
    (s t : S) (hs : «protected» s) (ht : «protected» t)
    (hConflict : ∀ a : A,
      ¬ (GuardAction step allowed «protected» s a ∧
         GuardAction step allowed «protected» t a))
    (hGuardian : ExistsCutGuardian observe step allowed «protected») :
    observe s ≠ observe t := by
  intro hSame
  obtain ⟨policy, hpolicy⟩ := hGuardian
  have hSecond : GuardAction step allowed «protected» t
      (policy (observe s)) := by
    simpa [← hSame] using hpolicy t ht
  exact hConflict (policy (observe s)) ⟨hpolicy s hs, hSecond⟩

/-- Exact historical identity reconstruction is one SUFFICIENT route
when an independently warranted historical safe policy is given.
Reconstructing complete identity is not NECESSARY for shared actions. -/
theorem history_decoder_can_supply_cut_guardian
    {History : Type z}
    (observe : S → O) (history : S → History)
    (step : S → A → S → Prop)
    (allowed : S → A → Prop) («protected» : S → Prop)
    (hDecoder : IR132.ExactDecoder observe history)
    (historyPolicy : History → A)
    (hPolicy : ∀ s, «protected» s →
      GuardAction step allowed «protected» s
        (historyPolicy (history s))) :
    ExistsCutGuardian observe step allowed «protected» := by
  rcases hDecoder with ⟨decode, hDecode⟩
  refine ⟨fun o => historyPolicy (decode o), ?_⟩
  intro s hs
  simpa [hDecode s] using hPolicy s hs

/-- Reuses IR109 rather than reproving protection for guarded traces. -/
theorem guardian_preserves_all_finite_source_paths
    (observe : S → O) (step : S → A → S → Prop)
    (allowed : S → A → Prop) («protected» : S → Prop)
    (policy : O → A)
    (hGuard : ∀ s, «protected» s →
      GuardAction step allowed «protected» s (policy (observe s)))
    {s t : S}
    (trace : IR109.PolicyReach step policy observe s t)
    (hs : «protected» s) : «protected» t := by
  apply IR109.robust_viability_all_finite_traces
    observe step «protected» policy ?_ trace hs
  intro o x hx hp y hStep
  rw [← hx] at hStep
  exact (hGuard x hp).2 y hStep

/-- Even a perfect guard needs mandatory mediation of actual effects.
This uses IR96's existing finite reach relation. -/
theorem guarded_real_effects_preserve_finite_histories
    (observe : S → O) (sourceStep : S → A → S → Prop)
    (physicalStep : S → S → Prop)
    (allowed : S → A → Prop) («protected» : S → Prop)
    (policy : O → A)
    (hGuard : ∀ s, «protected» s →
      GuardAction sourceStep allowed «protected» s (policy (observe s)))
    (hMediated : ∀ s t, physicalStep s t →
      sourceStep s (policy (observe s)) t)
    {initial final : S}
    (trace : IR96.Reach physicalStep initial final)
    (hInitial : «protected» initial) : «protected» final := by
  induction trace with
  | refl => exact hInitial
  | tail earlier edge ih =>
      exact (hGuard _ ih).2 _ (hMediated _ _ edge)

/-- Any finite actual failure has a first physically admitted
P-to-not-P step. The proof is generic, not real-X3 semantics. -/
theorem first_violating_edge_exists
    (physicalStep : S → S → Prop) («protected» : S → Prop)
    {initial final : S}
    (trace : IR96.Reach physicalStep initial final)
    (hInitial : «protected» initial)
    (hBad : ¬ «protected» final) :
    ∃ s t, physicalStep s t ∧ «protected» s ∧ ¬ «protected» t := by
  classical
  apply Classical.byContradiction
  intro hNone
  have hClosed : ∀ s t, physicalStep s t →
      «protected» s → «protected» t := by
    intro s t hStep hs
    apply Classical.byContradiction
    intro ht
    exact hNone ⟨s, t, hStep, hs, ht⟩
  have hStable : ∀ s t, IR96.Reach physicalStep s t →
      «protected» s → «protected» t := by
    intro s t path
    induction path with
    | refl =>
        intro h
        exact h
    | tail prev edge ih =>
        intro h
        exact hClosed _ _ edge (ih h)
  exact hBad (hStable initial final trace hInitial)

/-- Complete CAUSAL source witness coverage attaches an actual witness
to the first violating physical effect; captured logging and correct
subject semantics are additional physical obligations. -/
theorem first_violation_has_causal_witness
    {Event : Type z}
    (physicalStep : S → S → Prop) («protected» : S → Prop)
    (witness : S → Event → S → Prop)
    (hCoverage : ∀ s t, physicalStep s t →
      ∃ e, witness s e t)
    {initial final : S}
    (trace : IR96.Reach physicalStep initial final)
    (hInitial : «protected» initial)
    (hBad : ¬ «protected» final) :
    ∃ s t e, physicalStep s t ∧ «protected» s ∧
      ¬ «protected» t ∧ witness s e t := by
  obtain ⟨s, t, hStep, hs, ht⟩ :=
    first_violating_edge_exists physicalStep «protected»
      trace hInitial hBad
  obtain ⟨e, he⟩ := hCoverage s t hStep
  exact ⟨s, t, e, hStep, hs, ht, he⟩

end PhysicalBridges.CathedralCutGuardianCriterion
