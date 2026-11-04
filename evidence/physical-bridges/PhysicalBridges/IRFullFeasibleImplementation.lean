/-
Major-result join: select and implement an outcome in the ORIGINAL full
feasible order. Complete faithful profiles reduce only the candidate audit;
neither original outcomes nor protected particulars are removed.

The implementation predicate is defined by actual source transitions and
every original retention key, rather than supplied as an arbitrary relation.
Only the selected candidate needs a common realising action on each
observation fibre. No all-menu implementation or greatest/top premise is used.

Physical event completion, historical semantics of sourceOutcome, resource
and timing correspondence remain application obligations. The nonempty-source
theorem requires an initial invariant state and a nonempty disturbance type.
-/
import PhysicalBridges.IRImplementableProfileSelection
import PhysicalBridges.IRObservationRealisation
import PhysicalBridges.IRFixedPolicyEndToEnd

namespace PhysicalBridges.IRFullFeasibleImplementation

universe u v w x y z
variable {S : Type u} {Obs : Type v} {Act : Type w} {Dist : Type x}
variable {Outcome : Type y} {Part : Type z}

/-- A finite audit of original retention profiles plus the precise common
source-action condition for ONE candidate. The states and observations in a
fibre can still be infinite; effectiveness requires a justified decision
procedure or an independently checked finite model for that obligation. -/
def ProfileActionAudit
    (observe : S → Obs) (next : S → Act → Dist → S) (K : S → Prop)
    (allowed : S → Act → Prop) (sourceOutcome : S → Outcome)
    (full : Outcome → Prop) (keys : List (Outcome → Part → Prop))
    (representatives : List Outcome) : Prop :=
  ∃ selected, selected ∈ representatives ∧
    (∀ other, other ∈ representatives →
      ¬ UPTExist.LexBetter keys selected other) ∧
    ∀ o, ∃ a, IRObservationRealisation.FibreAction observe next K allowed
      sourceOutcome full keys selected o a

/-- Exact original-full-feasible selection AND observation-based source
implementation criterion. Global maximality and the policy are outputs;
no no-excluded-improver, obstruction, or opaque realisation premise enters.
The proof retains the same policy while transferring target profiles. -/
theorem original_maximal_implementation_iff_profile_action_audit
    (observe : S → Obs) (next : S → Act → Dist → S) (K : S → Prop)
    (allowed : S → Act → Prop) (sourceOutcome : S → Outcome)
    (full : Outcome → Prop) (keys : List (Outcome → Part → Prop))
    (representatives : List Outcome)
    (hFeasible : ∀ r, r ∈ representatives → full r)
    (hCover : ∀ actual, full actual → ∃ r, r ∈ representatives ∧
      IRMaximalProfileSelection.SameRetentions keys actual r) :
    (∃ selected, UPTExist.LexAlignedL full keys selected ∧
      ∃ policy : Obs → Act,
        IRObservationRealisation.RealisesSelected observe next K allowed
          sourceOutcome full keys policy selected) ↔
    ProfileActionAudit observe next K allowed sourceOutcome full keys
      representatives := by
  let Implements : Outcome → Prop := fun selected => ∃ policy : Obs → Act,
    IRObservationRealisation.RealisesSelected observe next K allowed
      sourceOutcome full keys policy selected
  have hInvariant : ∀ a b, full a → full b →
      IRMaximalProfileSelection.SameRetentions keys a b →
      (Implements a ↔ Implements b) := by
    intro a b _ _ hSame
    exact IRObservationRealisation.exists_realising_policy_same_target_iff
      observe next K allowed sourceOutcome full keys a b hSame
  have hSelection :=
    IRImplementableProfileSelection.implementable_global_maximal_iff_finite_audit
      keys full representatives Implements hFeasible hCover hInvariant
  constructor
  · intro h
    obtain ⟨selected, hListed, hMax, hPolicy⟩ := hSelection.1 h
    exact ⟨selected, hListed, hMax,
      (IRObservationRealisation.exists_policy_iff_common_fibre_actions
        observe next K allowed sourceOutcome full keys selected).1 hPolicy⟩
  · intro ⟨selected, hListed, hMax, hFibres⟩
    exact hSelection.2 ⟨selected, hListed, hMax,
      IRObservationRealisation.exists_realising_policy_of_fibres observe next
        K allowed sourceOutcome full keys selected hFibres⟩

/-- The audit constructs one particular policy. Every nonempty completed
source execution of THAT policy stays invariant, has an original full-feasible
outcome with all selected retention facts, and is globally maximal in the
original order. An actual initial state and event witness prevent an empty
state/event interpretation from passing as delivered service. -/
theorem audited_policy_realises_original_maximal_executions [Nonempty Dist]
    (observe : S → Obs) (next : S → Act → Dist → S) (K : S → Prop)
    (allowed : S → Act → Prop) (sourceOutcome : S → Outcome)
    (full : Outcome → Prop) (keys : List (Outcome → Part → Prop))
    (representatives : List Outcome)
    (hFeasible : ∀ r, r ∈ representatives → full r)
    (hCover : ∀ actual, full actual → ∃ r, r ∈ representatives ∧
      IRMaximalProfileSelection.SameRetentions keys actual r)
    (initial : S) (hInitial : K initial)
    (hAudit : ProfileActionAudit observe next K allowed sourceOutcome full
      keys representatives) :
    ∃ selected, ∃ policy : Obs → Act,
      UPTExist.LexAlignedL full keys selected ∧
      IRObservationRealisation.RealisesSelected observe next K allowed
        sourceOutcome full keys policy selected ∧
      (∀ o, IRObservedViability.UniformKeeper observe next K o (policy o)) ∧
      (∃ d : Dist,
        K (next initial (policy (observe initial)) d) ∧
        UPTExist.LexAlignedL full keys
          (sourceOutcome (next initial (policy (observe initial)) d))) ∧
      (∀ trace : List Dist, trace ≠ [] → ∀ s, K s →
        let finalState := IRViability.run next (fun t => policy (observe t)) s trace
        K finalState ∧ full (sourceOutcome finalState) ∧
          IRObservationRealisation.SameRetention keys
            (sourceOutcome finalState) selected ∧
          UPTExist.LexAlignedL full keys (sourceOutcome finalState)) := by
  classical
  obtain ⟨selected, hAligned, policy, hPolicy⟩ :=
    (original_maximal_implementation_iff_profile_action_audit observe next K
      allowed sourceOutcome full keys representatives hFeasible hCover).2 hAudit
  have hUniform := IRObservationRealisation.realises_uniform_keeper observe
    next K allowed sourceOutcome full keys policy selected hPolicy
  have hTrace := IRObservationRealisation.realises_every_nonempty_trace observe
    next K allowed sourceOutcome full keys policy selected hPolicy
  have hTraceAligned :=
    IRObservationRealisation.realised_trace_is_originally_globally_maximal
      observe next K allowed sourceOutcome full keys policy selected hAligned hPolicy
  obtain ⟨d⟩ := (inferInstance : Nonempty Dist)
  have hFirst := (hPolicy initial hInitial).2 d
  have hFirstAligned := IRObservationRealisation.aligned_of_same_retention
    keys full _ selected hFirst.2.1 hAligned hFirst.2.2
  refine ⟨selected, policy, hAligned, hPolicy, hUniform,
    ⟨d, hFirst.1, hFirstAligned⟩, ?_⟩
  intro trace hNonempty s hs
  obtain ⟨hK, hFull, hSame⟩ := hTrace trace hNonempty s hs
  exact ⟨hK, hFull, hSame, hTraceAligned trace hNonempty s hs⟩

#print axioms original_maximal_implementation_iff_profile_action_audit
#print axioms audited_policy_realises_original_maximal_executions

end PhysicalBridges.IRFullFeasibleImplementation
