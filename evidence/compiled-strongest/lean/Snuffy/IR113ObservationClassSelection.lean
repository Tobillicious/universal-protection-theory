import Snuffy.IR109RobustObservationViability

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IR113ObservationClassSelection.lean` at main `740abbb` (sha256 `8e6097041588d1834589172551d478cb0ecb3de8684bd27365371f3fca466d4c`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false

/-!
IR-113: exact observation-class controller-selection criterion.

A robust viable policy exists exactly when every observation class has
a common action that keeps all currently viable compatible states
inside the viability set after every admitted physical transition.

Classical choice here certifies mathematical existence, not an
effective/physically implementable controller. The action intersection
condition and the physical model must still be established.
-/
namespace PhysicalBridges.IR113

open IR109
universe u v w
variable {S : Type u} {A : Type v} {O : Type w}

/-- Robust successor safety over the entire observation class. -/
def ClassViableAction
    (observe : S → O) (step : S → A → S → Prop)
    (viable : S → Prop) (o : O) (a : A) : Prop :=
  ∀ s, observe s = o → viable s →
    ∀ t, step s a t → viable t

/-- Exact necessary and sufficient criterion for an observation-only
robust viability policy. Neither direction presupposes a sensor's
physical completeness. -/
theorem observation_policy_exists_iff_common_viable_action
    (observe : S → O) (step : S → A → S → Prop)
    (viable : S → Prop) :
    (∃ policy : O → A,
      ∀ o, ClassViableAction observe step viable o (policy o)) ↔
    (∀ o, ∃ a, ClassViableAction observe step viable o a) := by
  constructor
  · rintro ⟨policy, hPolicy⟩ o
    exact ⟨policy o, hPolicy o⟩
  · intro h
    classical
    refine ⟨(fun o => Classical.choose (h o)), ?_⟩
    intro o
    exact Classical.choose_spec (h o)

/-- Under the common-action premise, one observation-based policy
keeps viability along *all* finite traces of the admitted transition
relation. Choice of the policy is not asserted computable. -/
theorem common_actions_give_finite_trace_viability
    (observe : S → O) (step : S → A → S → Prop)
    (viable : S → Prop)
    (hCommon : ∀ o, ∃ a,
      ClassViableAction observe step viable o a) :
    ∃ policy : O → A,
      ∀ {initial final : S},
        PolicyReach step policy observe initial final →
        viable initial → viable final := by
  obtain ⟨policy, hPolicy⟩ :=
    (observation_policy_exists_iff_common_viable_action
      observe step viable).mpr hCommon
  refine ⟨policy, ?_⟩
  intro initial final hTrace hInitial
  exact robust_viability_all_finite_traces
    observe step viable policy
    (by
      intro o s hObs hs t hStep
      exact hPolicy o s hObs hs t hStep)
    hTrace hInitial

/-- The IR-108 indistinguishable-state counterexample has no common
safe action for its (shared) observation. -/
theorem ir108_blocks_common_safe_action :
    ¬ ∀ o : Bool, ∃ a : IR108.Action,
      RobustAt IR108.observation IR108.Safe o a := by
  intro h
  obtain ⟨a, ha⟩ := h true
  apply IR108.no_common_safe_action
  exact ⟨a, ha .left rfl, ha .right rfl⟩

end PhysicalBridges.IR113
