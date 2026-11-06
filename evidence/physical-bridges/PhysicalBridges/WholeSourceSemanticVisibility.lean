import PhysicalBridges.KoruWholeUSixDutyWebJoin
import PhysicalBridges.KoruCompleteEquationObstruction

/-!
# Exact source / semantic visibility: the objective whole versus its readouts

7 November 2026. Additive, theorem-level criterion for a real source-to-
subject correspondence program. The type of a fact, its physical truth,
and whether some observation can *represent* that fact are distinct.

The positive theorem says precisely when a subject-level proposition can
be recovered from an observation of an objective whole:
  FACTORABLE iff CONSTANT ON THE FIBRES of that observation.

It is a necessary-and-sufficient characterization with no notion of
guardian/safe, no physical admissibility filter and no original-six X3
premise. It applies to every semantic proposition, not only favourable
ones.

For the actual finite frozen-W model:
* the transported three-role local view cannot decide even whether the
  true originating complete source was a specified whole;
* the complete evolved W source can faithfully represent ANY originating
  source proposition, because its evolution is proved injective;
* complete representation does not imply the represented proposition is
  always true;
* a uniform observation-only protection policy exists iff each
  observation fibre admits ONE action safe for all states in that fibre.
  This is exactly the boundary-action criterion, but here proved directly
  from the independently supplied observable and safe-action relation.

These are mathematical criteria, not a claim that a readout of genuine
consent, freedom, continuation or provenance is available in the actual
universe. In particular, a complete physical description does not turn
false authorization into true authorization. Original X3 is unchanged.
-/

namespace PhysicalBridges.WholeSourceSemanticVisibility

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruWholeEventEnactment
open PhysicalBridges.KoruWholeUSixDutyWebJoin

/-- A semantic fact can be expressed using ONLY the observation iff it
    is constant over all observationally indistinguishable full states.
    The reverse direction is constructive: existentially quantify over
    the fibre of the observation. -/
theorem semantic_factors_through_observation_iff_fibre_constant
    {Whole Observation : Type}
    (observe : Whole → Observation) (meaning : Whole → Prop) :
    (∃ readout : Observation → Prop,
      ∀ w : Whole, readout (observe w) ↔ meaning w) ↔
    (∀ x y : Whole, observe x = observe y →
      (meaning x ↔ meaning y)) := by
  constructor
  · rintro ⟨readout, hRead⟩ x y hEq
    calc
      meaning x ↔ readout (observe x) := (hRead x).symm
      _ ↔ readout (observe y) := by rw [hEq]
      _ ↔ meaning y := hRead y
  · intro hFibre
    refine ⟨fun o => ∃ w, observe w = o ∧ meaning w, ?_⟩
    intro w
    constructor
    · rintro ⟨x, hx, hMeaning⟩
      exact (hFibre x w hx).mp hMeaning
    · intro hMeaning
      exact ⟨w, rfl, hMeaning⟩

/-- Actual W preserves one FULL operator-source object. This
    specific observer reads only three of its six operator positions. -/
def threeRoleReadout (n : Nat) (U : FiniteObjectiveU) :
    WholeOperatorEvent :=
  eventViewedInObjective
    (objectiveAt U n)
    (trackedPosition 0 n)
    (trackedPosition 1 n)
    (trackedPosition 2 n)

/-- The pre-existing two-whole witness has identical exactly
    transported three-role observations at EVERY finite W stage. -/
theorem transported_three_role_readouts_agree (n : Nat) :
    threeRoleReadout n uniformObjective =
      threeRoleReadout n changedElsewhereObjective :=
  (local_event_projection_gap_persists_at_every_W_stage n).1

/-- A globally meaningful objective-source predicate cannot be
    reconstructed from this lossy view, even if we know every event's
    correct finite W stage. The failed factorization is mathematical,
    not a claim of any real-life false semantic proposition. -/
theorem global_origin_fact_not_visible_in_any_three_role_readout
    (n : Nat) :
    ¬ ∃ readout : WholeOperatorEvent → Prop,
      ∀ U : FiniteObjectiveU,
        readout (threeRoleReadout n U) ↔ U = uniformObjective := by
  intro hFactor
  have hFibre := (semantic_factors_through_observation_iff_fibre_constant
    (threeRoleReadout n) (fun U : FiniteObjectiveU => U = uniformObjective)).mp
      hFactor
  have hWrong : changedElsewhereObjective = uniformObjective :=
    (hFibre uniformObjective changedElsewhereObjective
      (transported_three_role_readouts_agree n)).mp rfl
  exact local_event_cannot_be_identified_with_objective_U.2 hWrong.symm

/-- By contrast, every predicate of the originating full source
    (including a *false* one) can be faithfully read from the COMPLETE
    physically evolved W source. This is about representation/visibility,
    not the claim that each proposition is positively satisfied. -/
theorem every_origin_fact_visible_from_complete_W_source
    (n : Nat) (meaning : FiniteObjectiveU → Prop) :
    ∃ readout : FiniteObjectiveU → Prop,
      ∀ U : FiniteObjectiveU,
        readout (objectiveAt U n) ↔ meaning U := by
  apply (semantic_factors_through_observation_iff_fibre_constant
    (fun U : FiniteObjectiveU => objectiveAt U n) meaning).mpr
  intro U V hSame
  have hUV : U = V := objective_wholes_do_not_merge n hSame
  subst V
  exact Iff.rfl

/-- All six ORIGINAL-X3-SHAPED internal source predicates, when
    independently asked of the same whole's operator-derived source web,
    have a faithful full-W representation for every finite stage.
    The 'source' qualifier is essential: we do not authenticate the
    real subjective meanings of the six predicates here. -/
theorem six_source_profile_visible_from_complete_W_source
    (roles : SourceDutyRoles) (n : Nat) (p : Index) :
    ∃ readout : FiniteObjectiveU → Prop,
      ∀ U : FiniteObjectiveU,
        readout (objectiveAt U n) ↔
          wholeSourceSixAt U roles 0 p := by
  exact every_origin_fact_visible_from_complete_W_source n
    (fun U => wholeSourceSixAt U roles 0 p)

/-- A complete description can reveal a genuinely FALSE fact. The
    positive full-source visibility theorem alone cannot imply that
    every represented authorization, continuity or duty holds. -/
theorem complete_visibility_does_not_make_all_facts_true :
    ∃ meaning : FiniteObjectiveU → Prop,
      (∃ readout : FiniteObjectiveU → Prop,
        ∀ U, readout (objectiveAt U 0) ↔ meaning U) ∧
      ¬ (∀ U, meaning U) := by
  refine ⟨fun U => U = uniformObjective,
    every_origin_fact_visible_from_complete_W_source 0
      (fun U => U = uniformObjective), ?_⟩
  intro hAlways
  exact local_event_cannot_be_identified_with_objective_U.2
    (hAlways changedElsewhereObjective).symm

/-- Exact boundary-action theorem. An observation-only policy works
    for ALL full states iff EVERY observational equivalence class has
    at least ONE common action that is safe for all its members.
    'Safe' is independently supplied: we have not smuggled it into the
    observation or the physical admission relation. -/
theorem observation_policy_exists_iff_common_safe_action_on_each_fibre
    {Whole Observation Action : Type}
    (observe : Whole → Observation) (safe : Whole → Action → Prop) :
    (∃ policy : Observation → Action,
      ∀ w : Whole, safe w (policy (observe w))) ↔
    (∀ o : Observation,
      ∃ a : Action, ∀ w : Whole, observe w = o → safe w a) := by
  constructor
  · rintro ⟨policy, hSafe⟩ o
    refine ⟨policy o, ?_⟩
    intro w hObs
    simpa only [hObs] using hSafe w
  · intro hCommon
    classical
    let policy : Observation → Action :=
      fun o => Classical.choose (hCommon o)
    refine ⟨policy, ?_⟩
    intro w
    exact (Classical.choose_spec (hCommon (observe w))) w rfl

#print axioms semantic_factors_through_observation_iff_fibre_constant
#print axioms transported_three_role_readouts_agree
#print axioms global_origin_fact_not_visible_in_any_three_role_readout
#print axioms every_origin_fact_visible_from_complete_W_source
#print axioms six_source_profile_visible_from_complete_W_source
#print axioms complete_visibility_does_not_make_all_facts_true
#print axioms observation_policy_exists_iff_common_safe_action_on_each_fibre

end PhysicalBridges.WholeSourceSemanticVisibility
