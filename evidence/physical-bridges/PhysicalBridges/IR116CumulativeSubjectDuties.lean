import PhysicalBridges.IR115WatchdogToAgency

/-!
IR-116: irreversible-register erasure loophole and cumulative duties.

"Every currently listed mind is protected" can become vacuously true
when an adversary deletes the list. The account of owed subjects must
be monotone along permitted physical transitions, with new admissions
added rather than replacing earlier protected individuals.

This explicitly retains *each* original particular and its certified
required option set. It does NOT supply the physical membership oracle,
a universal mind-definition, or the original maximal X3 freedom law.
-/
namespace PhysicalBridges.IR116

open IR109
universe u v w z
variable {S : Type u} {A : Type v} {O : Type w} {Mind : Type z}

/-- For each owed particular, retain historical continuity and every
specified required feasible freedom, with at least one requirement
rather than a vacuous empty option set. -/
def EveryOwedSubjectProtected
    (owed : S → Mind → Prop)
    (continues : S → Mind → Prop)
    (required : S → Mind → A → Prop)
    (executable : S → Mind → A → Prop)
    (s : S) : Prop :=
  ∀ m, owed s m →
    continues s m ∧
    (∃ a, required s m a) ∧
    (∀ a, required s m a → executable s m a)

/-- Cumulative duty cannot disappear from the account along an
arbitrarily long finite controlled physical trace. -/
theorem cumulative_duties_preserved
    (observe : S → O) (step : S → A → S → Prop)
    (policy : O → A) (owed : S → Mind → Prop)
    (hMonotone : ∀ s t,
      step s (policy (observe s)) t →
      ∀ m, owed s m → owed t m)
    {initial final : S}
    (hTrace : PolicyReach step policy observe initial final) :
    ∀ m, owed initial m → owed final m := by
  induction hTrace with
  | refl =>
      intro m hm
      exact hm
  | tail earlier edge ih =>
      intro m hm
      exact hMonotone _ _ edge m (ih m hm)

/-- Under physical source-level duty monotonicity plus robust
subject-level preservation, every original protected individual
remains protected with the COMPLETE specified required option set.
The required set itself can evolve with the state. -/
theorem initial_cohort_retains_continuity_and_every_required_option
    (observe : S → O) (step : S → A → S → Prop)
    (policy : O → A)
    (owed : S → Mind → Prop)
    (continues : S → Mind → Prop)
    (required : S → Mind → A → Prop)
    (executable : S → Mind → A → Prop)
    (hMonotone : ∀ s t,
      step s (policy (observe s)) t →
      ∀ m, owed s m → owed t m)
    (hRobust : ∀ o s, observe s = o →
      EveryOwedSubjectProtected owed continues required executable s →
      ∀ t, step s (policy o) t →
        EveryOwedSubjectProtected owed continues required executable t)
    {initial final : S}
    (hTrace : PolicyReach step policy observe initial final)
    (hInitial :
      EveryOwedSubjectProtected owed continues required executable initial) :
    ∀ m, owed initial m →
      continues final m ∧
      (∃ a, required final m a) ∧
      (∀ a, required final m a → executable final m a) := by
  have hRetained := cumulative_duties_preserved
    observe step policy owed hMonotone hTrace
  have hAll := robust_viability_all_finite_traces
    observe step
    (EveryOwedSubjectProtected owed continues required executable)
    policy hRobust hTrace hInitial
  intro m hOriginal
  exact hAll m (hRetained m hOriginal)

/-- New entrants must be appended to previously owed subjects.
Showing the admission contract is still a physical and semantic
obligation; it is NOT inferred from existing-identifier counts. -/
theorem old_or_new_remains_owed
    (observe : S → O) (step : S → A → S → Prop)
    (policy : O → A) (owed : S → Mind → Prop)
    (newlyRecognized : S → Mind → Prop)
    (hMonotone : ∀ s t,
      step s (policy (observe s)) t →
      ∀ m, owed s m → owed t m)
    (hAdmit : ∀ s t,
      step s (policy (observe s)) t →
      ∀ m, newlyRecognized t m → owed t m) :
    ∀ s t, step s (policy (observe s)) t →
      ∀ m, owed s m ∨ newlyRecognized t m → owed t m := by
  intro s t hStep m hCase
  rcases hCase with hPrior | hNew
  · exact hMonotone s t hStep m hPrior
  · exact hAdmit s t hStep m hNew

/-- A controller may claim that every *current* registry entry is
protected simply by deleting ALL entries. This is a logical
countermodel to using a mutable registry as universal X3 scope. -/
theorem empty_registry_vacuity_countermodel :
    ∃ original current : Bool → Prop,
      (∀ m, current m → False) ∧
      (∃ m, original m) ∧
      ¬ (∀ m, original m → False) := by
  refine ⟨(fun m => m = true), (fun _ => False), ?_, ?_, ?_⟩
  · intro m hm
    exact hm
  · exact ⟨true, rfl⟩
  · intro h
    exact h true rfl

end PhysicalBridges.IR116
