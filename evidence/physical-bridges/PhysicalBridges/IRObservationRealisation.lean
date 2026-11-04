/-
Observation-based implementation of original UPT retention outcomes.

The selected outcome, full-feasible predicate, original priority keys and
protected particular type are unchanged. An action contract names the actual
source transition, admissibility, invariant, source-outcome feasibility and
the exact retention facts at EVERY original stage. A common action in each
observation fibre constructs a fixed observation policy satisfying that
contract. This is an exact implementation criterion, rather than an opaque
assumed `realises` relation or a consequence of maximality alone.

The source outcome can carry the complete historical/continuation/freedom
semantics supplied by an application. The theorem does not infer those
semantics from a log or from a replacement's observations. Its delivery
contract is deliberately explicit: one completed transition delivers the
selected retention profile and every later completed transition retains it.
It makes no claim that physical events complete or that an installation
satisfies the contract.

`Obs` may contain the entire observation history and controller memory. The
criterion concerns the specified information map and deterministic policy
class of the existing IR-20 interface; it does not infer that this class
exhausts every physically feasible policy. That full-class correspondence
remains explicit in an application of the original feasibility predicate.
-/
import PhysicalBridges.IRObservedViability
import PhysicalBridges.IRSelectedMaximality

namespace PhysicalBridges.IRObservationRealisation

universe u v w x y z
variable {S : Type u} {Obs : Type v} {Act : Type w} {Dist : Type x}
variable {Outcome : Type y} {Part : Type z}

/-- Equality of the original retention sets at every original priority stage.
No protected particular or priority coordinate is discarded. -/
def SameRetention (keys : List (Outcome → Part → Prop))
    (actual selected : Outcome) : Prop :=
  ∀ key, key ∈ keys → ∀ p, key actual p ↔ key selected p

theorem sameRetention_refl (keys : List (Outcome → Part → Prop)) (o : Outcome) :
    SameRetention keys o o := fun _ _ _ => Iff.rfl

theorem sameRetention_symm (keys : List (Outcome → Part → Prop))
    (a b : Outcome) (h : SameRetention keys a b) : SameRetention keys b a :=
  fun key hk p => (h key hk p).symm

theorem sameRetention_trans (keys : List (Outcome → Part → Prop))
    (a b c : Outcome) (hab : SameRetention keys a b) (hbc : SameRetention keys b c) :
    SameRetention keys a c :=
  fun key hk p => (hab key hk p).trans (hbc key hk p)

/-- Equivalent ORIGINAL retention profiles have identical original strict
improvers. This does not establish feasibility of either physical outcome. -/
theorem sameRetention_lex_iff :
    ∀ (keys : List (Outcome → Part → Prop)) (a b other : Outcome),
      SameRetention keys a b →
      (UPTExist.LexBetter keys a other ↔
        UPTExist.LexBetter keys b other) := by
  intro keys
  induction keys with
  | nil => intro a b other _; rfl
  | cons key keys ih =>
      intro a b other h
      have hHead : key a = key b := by
        funext p
        exact propext (h key (by simp) p)
      have hTail : SameRetention keys a b := by
        intro k hk p
        exact h k (by simp [hk]) p
      change (UPTExist.SSub (key a) (key other) ∨
        (UPTExist.Equiv (key a) (key other) ∧
          UPTExist.LexBetter keys a other)) ↔
        (UPTExist.SSub (key b) (key other) ∨
        (UPTExist.Equiv (key b) (key other) ∧
          UPTExist.LexBetter keys b other))
      rw [hHead, ih a b other hTail]

/-- Original full feasibility is essential. Retention equality transports the
no-improver clause; the separately supplied source feasibility supplies the
membership clause of the original `LexAlignedL`. -/
theorem aligned_of_same_retention
    (keys : List (Outcome → Part → Prop)) (full : Outcome → Prop)
    (actual selected : Outcome)
    (hActual : full actual)
    (hSelected : UPTExist.LexAlignedL full keys selected)
    (hSame : SameRetention keys actual selected) :
    UPTExist.LexAlignedL full keys actual := by
  refine ⟨hActual, ?_⟩
  intro other hOther hBetter
  exact hSelected.2 other hOther
    ((sameRetention_lex_iff keys actual selected other hSame).1 hBetter)

/-- One actual source action is permitted, keeps the physical invariant
against every admitted disturbance, and delivers a full-feasible outcome
with exactly the selected original retention sets. The source outcome is
read from the successor physical state, rather than inferred from a log. -/
def ActionRealises
    (next : S → Act → Dist → S) (K : S → Prop)
    (allowed : S → Act → Prop) (sourceOutcome : S → Outcome)
    (full : Outcome → Prop) (keys : List (Outcome → Part → Prop))
    (selected : Outcome) (s : S) (a : Act) : Prop :=
  allowed s a ∧ ∀ d,
    K (next s a d) ∧ full (sourceOutcome (next s a d)) ∧
      SameRetention keys (sourceOutcome (next s a d)) selected

/-- A single action works for ALL invariant states compatible with the
observation. The hidden state need not be determined by that observation. -/
def FibreAction
    (observe : S → Obs) (next : S → Act → Dist → S) (K : S → Prop)
    (allowed : S → Act → Prop) (sourceOutcome : S → Outcome)
    (full : Outcome → Prop) (keys : List (Outcome → Part → Prop))
    (selected : Outcome) (o : Obs) (a : Act) : Prop :=
  ∀ s, K s → observe s = o →
    ActionRealises next K allowed sourceOutcome full keys selected s a

/-- This fixed observation-only policy realizes the selected ORIGINAL
retention profile through the actual specified source transitions. -/
def RealisesSelected
    (observe : S → Obs) (next : S → Act → Dist → S) (K : S → Prop)
    (allowed : S → Act → Prop) (sourceOutcome : S → Outcome)
    (full : Outcome → Prop) (keys : List (Outcome → Part → Prop))
    (policy : Obs → Act) (selected : Outcome) : Prop :=
  ∀ s, K s → ActionRealises next K allowed sourceOutcome full keys
    selected s (policy (observe s))

/-- Changing a target only by exact original retention equivalence preserves
the same policy's entire source action contract. Actual source feasibility,
the source transition and all policy choices stay fixed. -/
theorem realisesSelected_target_iff
    (observe : S → Obs) (next : S → Act → Dist → S) (K : S → Prop)
    (allowed : S → Act → Prop) (sourceOutcome : S → Outcome)
    (full : Outcome → Prop) (keys : List (Outcome → Part → Prop))
    (policy : Obs → Act) (a b : Outcome) (hSame : SameRetention keys a b) :
    RealisesSelected observe next K allowed sourceOutcome full keys policy a ↔
      RealisesSelected observe next K allowed sourceOutcome full keys policy b := by
  have transfer : ∀ target other : Outcome, SameRetention keys target other →
      RealisesSelected observe next K allowed sourceOutcome full keys policy target →
      RealisesSelected observe next K allowed sourceOutcome full keys policy other := by
    intro target other hTarget hPolicy s hs
    obtain ⟨hAllowed, hStep⟩ := hPolicy s hs
    refine ⟨hAllowed, ?_⟩
    intro d
    obtain ⟨hK, hFull, hRetention⟩ := hStep d
    exact ⟨hK, hFull,
      sameRetention_trans keys _ target other hRetention hTarget⟩
  exact ⟨transfer a b hSame,
    transfer b a (sameRetention_symm keys a b hSame)⟩

/-- Implementability is invariant under exact original retention profiles.
This supplies the profile-search interface without assuming every feasible
representative is implementable. Each direction retains its policy witness. -/
theorem exists_realising_policy_same_target_iff
    (observe : S → Obs) (next : S → Act → Dist → S) (K : S → Prop)
    (allowed : S → Act → Prop) (sourceOutcome : S → Outcome)
    (full : Outcome → Prop) (keys : List (Outcome → Part → Prop))
    (a b : Outcome) (hSame : SameRetention keys a b) :
    (∃ policy : Obs → Act,
      RealisesSelected observe next K allowed sourceOutcome full keys policy a) ↔
    (∃ policy : Obs → Act,
      RealisesSelected observe next K allowed sourceOutcome full keys policy b) := by
  constructor
  · intro ⟨policy, hPolicy⟩
    exact ⟨policy, (realisesSelected_target_iff observe next K allowed
      sourceOutcome full keys policy a b hSame).1 hPolicy⟩
  · intro ⟨policy, hPolicy⟩
    exact ⟨policy, (realisesSelected_target_iff observe next K allowed
      sourceOutcome full keys policy a b hSame).2 hPolicy⟩

theorem realises_iff_fibre_actions
    (observe : S → Obs) (next : S → Act → Dist → S) (K : S → Prop)
    (allowed : S → Act → Prop) (sourceOutcome : S → Outcome)
    (full : Outcome → Prop) (keys : List (Outcome → Part → Prop))
    (policy : Obs → Act) (selected : Outcome) :
    RealisesSelected observe next K allowed sourceOutcome full keys policy selected ↔
      ∀ o, FibreAction observe next K allowed sourceOutcome full keys
        selected o (policy o) := by
  constructor
  · intro h o s hs ho
    simpa only [ho] using h s hs
  · intro h s hs
    exact h (observe s) s hs rfl

/-- Exact existence criterion, including empty observation fibres/types.
No separate nonempty-action assumption is needed: the right side is exactly
what a total observation policy requires. Classical choice constructs the
policy; an application may instead supply the explicit selectors below. -/
theorem exists_policy_iff_common_fibre_actions
    (observe : S → Obs) (next : S → Act → Dist → S) (K : S → Prop)
    (allowed : S → Act → Prop) (sourceOutcome : S → Outcome)
    (full : Outcome → Prop) (keys : List (Outcome → Part → Prop))
    (selected : Outcome) :
    (∃ policy : Obs → Act,
      RealisesSelected observe next K allowed sourceOutcome full keys policy selected) ↔
    ∀ o, ∃ a, FibreAction observe next K allowed sourceOutcome full keys
      selected o a := by
  constructor
  · intro ⟨policy, hPolicy⟩ o
    exact ⟨policy o,
      (realises_iff_fibre_actions observe next K allowed sourceOutcome
        full keys policy selected).1 hPolicy o⟩
  · intro h
    classical
    refine ⟨fun o => Classical.choose (h o), ?_⟩
    apply (realises_iff_fibre_actions observe next K allowed sourceOutcome
      full keys _ selected).2
    exact fun o => Classical.choose_spec (h o)

theorem exists_realising_policy_of_fibres
    (observe : S → Obs) (next : S → Act → Dist → S) (K : S → Prop)
    (allowed : S → Act → Prop) (sourceOutcome : S → Outcome)
    (full : Outcome → Prop) (keys : List (Outcome → Part → Prop))
    (selected : Outcome)
    (hFibre : ∀ o, ∃ a, FibreAction observe next K allowed sourceOutcome
      full keys selected o a) :
    ∃ policy : Obs → Act,
      RealisesSelected observe next K allowed sourceOutcome full keys policy selected :=
  (exists_policy_iff_common_fibre_actions observe next K allowed sourceOutcome
    full keys selected).2 hFibre

/-- A supplied certified selector is an executable policy definition. This
construction uses no choice axiom and does not choose a different policy
when the result is composed with a controller or refinement certificate. -/
def policyOfSelectors
    (observe : S → Obs) (next : S → Act → Dist → S) (K : S → Prop)
    (allowed : S → Act → Prop) (sourceOutcome : S → Outcome)
    (full : Outcome → Prop) (keys : List (Outcome → Part → Prop))
    (selected : Outcome)
    (selectors : ∀ o, {a // FibreAction observe next K allowed sourceOutcome
      full keys selected o a}) : Obs → Act :=
  fun o => (selectors o).val

theorem policyOfSelectors_realises
    (observe : S → Obs) (next : S → Act → Dist → S) (K : S → Prop)
    (allowed : S → Act → Prop) (sourceOutcome : S → Outcome)
    (full : Outcome → Prop) (keys : List (Outcome → Part → Prop))
    (selected : Outcome)
    (selectors : ∀ o, {a // FibreAction observe next K allowed sourceOutcome
      full keys selected o a}) :
    RealisesSelected observe next K allowed sourceOutcome full keys
      (policyOfSelectors observe next K allowed sourceOutcome full keys selected selectors)
      selected := by
  apply (realises_iff_fibre_actions observe next K allowed sourceOutcome
    full keys _ selected).2
  exact fun o => (selectors o).property

/-- Derive the original IR-6/IR-20 uniform-keeper condition for the SAME
constructed policy. No source physical state is reconstructed from a log. -/
theorem realises_uniform_keeper
    (observe : S → Obs) (next : S → Act → Dist → S) (K : S → Prop)
    (allowed : S → Act → Prop) (sourceOutcome : S → Outcome)
    (full : Outcome → Prop) (keys : List (Outcome → Part → Prop))
    (policy : Obs → Act) (selected : Outcome)
    (hPolicy : RealisesSelected observe next K allowed sourceOutcome full keys policy selected) :
    ∀ o, IRObservedViability.UniformKeeper observe next K o (policy o) := by
  intro o s hs ho d
  have hAction := (realises_iff_fibre_actions observe next K allowed sourceOutcome
    full keys policy selected).1 hPolicy o s hs ho
  exact (hAction.2 d).1

/-- Every nonempty completed source trace reaches the exact original
retention profile under this fixed policy, while keeping the source outcome
inside the original full-feasible family. This is not merely equal observed
labels and does not infer a physical event-completion deadline. -/
theorem realises_every_nonempty_trace
    (observe : S → Obs) (next : S → Act → Dist → S) (K : S → Prop)
    (allowed : S → Act → Prop) (sourceOutcome : S → Outcome)
    (full : Outcome → Prop) (keys : List (Outcome → Part → Prop))
    (policy : Obs → Act) (selected : Outcome)
    (hPolicy : RealisesSelected observe next K allowed sourceOutcome full keys policy selected) :
    ∀ trace : List Dist, trace ≠ [] → ∀ s, K s →
      let finalState := IRViability.run next (fun t => policy (observe t)) s trace
      K finalState ∧ full (sourceOutcome finalState) ∧
        SameRetention keys (sourceOutcome finalState) selected := by
  let Good : S → Prop := fun s =>
    K s ∧ full (sourceOutcome s) ∧ SameRetention keys (sourceOutcome s) selected
  have hGood : ∀ s, Good s → ∀ d,
      Good (next s (policy (observe s)) d) := by
    intro s hs d
    exact (hPolicy s hs.1).2 d
  intro trace hNonempty s hs
  cases trace with
  | nil => exact False.elim (hNonempty rfl)
  | cons d ds =>
      exact IRViability.robust_policy_preserves_every_finite_trace
        Good next (fun t => policy (observe t)) hGood ds
        (next s (policy (observe s)) d) ((hPolicy s hs).2 d)

/-- Exact source-level bridge: original global maximality of the selected
outcome transfers to every nonempty completed source execution of this
specific realizing policy. Both original full feasibility and every original
stagewise retention fact are supplied by the checked source action contract. -/
theorem realised_trace_is_originally_globally_maximal
    (observe : S → Obs) (next : S → Act → Dist → S) (K : S → Prop)
    (allowed : S → Act → Prop) (sourceOutcome : S → Outcome)
    (full : Outcome → Prop) (keys : List (Outcome → Part → Prop))
    (policy : Obs → Act) (selected : Outcome)
    (hSelected : UPTExist.LexAlignedL full keys selected)
    (hPolicy : RealisesSelected observe next K allowed sourceOutcome full keys policy selected) :
    ∀ trace : List Dist, trace ≠ [] → ∀ s, K s →
      UPTExist.LexAlignedL full keys
        (sourceOutcome (IRViability.run next (fun t => policy (observe t)) s trace)) := by
  intro trace hTrace s hs
  obtain ⟨_, hFull, hSame⟩ := realises_every_nonempty_trace observe next K
    allowed sourceOutcome full keys policy selected hPolicy trace hTrace s hs
  exact aligned_of_same_retention keys full _ selected hFull hSelected hSame

/-- One impossible common-action fibre rules out EVERY observation policy.
Individual statewise realizability does not discharge this obstruction. -/
theorem incompatible_fibre_blocks_realisation
    (observe : S → Obs) (next : S → Act → Dist → S) (K : S → Prop)
    (allowed : S → Act → Prop) (sourceOutcome : S → Outcome)
    (full : Outcome → Prop) (keys : List (Outcome → Part → Prop))
    (selected : Outcome) (s t : S) (hs : K s) (ht : K t)
    (hObserve : observe s = observe t)
    (hConflict : ∀ a, ¬ (ActionRealises next K allowed sourceOutcome full keys selected s a ∧
      ActionRealises next K allowed sourceOutcome full keys selected t a)) :
    ¬ ∃ policy : Obs → Act,
      RealisesSelected observe next K allowed sourceOutcome full keys policy selected := by
  intro ⟨policy, hPolicy⟩
  apply hConflict (policy (observe s))
  refine ⟨hPolicy s hs, ?_⟩
  simpa only [hObserve] using hPolicy t ht

/-- A model may derive common actions without revealing the whole state:
transport of the action contract across observationally equivalent invariant
states plus statewise realizability suffices. Off-kernel observations require
only a default action for the total policy. -/
theorem common_fibre_actions_of_statewise_and_transport [Nonempty Act]
    (observe : S → Obs) (next : S → Act → Dist → S) (K : S → Prop)
    (allowed : S → Act → Prop) (sourceOutcome : S → Outcome)
    (full : Outcome → Prop) (keys : List (Outcome → Part → Prop))
    (selected : Outcome)
    (hStatewise : ∀ s, K s → ∃ a,
      ActionRealises next K allowed sourceOutcome full keys selected s a)
    (hTransport : ∀ s t, K s → K t → observe s = observe t → ∀ a,
      ActionRealises next K allowed sourceOutcome full keys selected s a →
      ActionRealises next K allowed sourceOutcome full keys selected t a) :
    ∀ o, ∃ a, FibreAction observe next K allowed sourceOutcome full keys selected o a := by
  classical
  intro o
  by_cases hOccupied : ∃ s, K s ∧ observe s = o
  · obtain ⟨s, hs, ho⟩ := hOccupied
    obtain ⟨a, ha⟩ := hStatewise s hs
    refine ⟨a, ?_⟩
    intro t ht hto
    exact hTransport s t hs ht (ho.trans hto.symm) a ha
  · refine ⟨Classical.choice inferInstance, ?_⟩
    intro s hs ho
    exact False.elim (hOccupied ⟨s, hs, ho⟩)

namespace HiddenService

/-- A hidden actuator mode and an independently specified delivered-service
bit. Both modes remain safe under every action. -/
structure State where
  mode : Bool
  served : Bool

def observe (_ : State) : Unit := ()
def safe (_ : State) : Prop := True
def allowed (_ : State) (_ : Bool) : Prop := True
def next (s : State) (a : Bool) (_ : Unit) : State :=
  ⟨s.mode, if a = s.mode then true else false⟩
def outcome (s : State) : Bool := s.served
def full (_ : Bool) : Prop := True
def service (o : Bool) (_ : Unit) : Prop := o = true

/-- Each hidden mode admits an action delivering exactly the selected
retention fact. This is deliberately weaker than uniform implementation. -/
theorem each_state_can_deliver : ∀ s : State, ∃ a,
    ActionRealises next safe allowed outcome full [service] true s a := by
  intro s
  refine ⟨s.mode, trivial, ?_⟩
  intro d
  refine ⟨trivial, trivial, ?_⟩
  intro key hk p
  have hKey : key = service := by simpa using hk
  subst key
  simp [service, outcome, next]

/-- Every observation policy preserves physical safety in this model.
Safety therefore supplies no hidden missing service certificate. -/
theorem every_policy_is_safe (policy : Unit → Bool) :
    ∀ o, IRObservedViability.UniformKeeper observe next safe o (policy o) := by
  intro o s hs ho d
  trivial

theorem selected_is_originally_maximal :
    UPTExist.LexAlignedL full ([service] : List (Bool → Unit → Prop)) true := by
  refine ⟨trivial, ?_⟩
  intro other _ hBetter
  cases hBetter with
  | inl hStrict => exact hStrict.2 (fun _ _ => rfl)
  | inr hLater => exact hLater.2

/-- Both hidden modes have the same observation and need opposite actions.
Thus a declaratively maximal selected outcome and statewise delivery do not
construct an observation-only implementation. A real application must prove
that its ORIGINAL full-feasible predicate matches its information limits. -/
theorem no_observation_policy_delivers :
    ¬ ∃ policy : Unit → Bool,
      RealisesSelected observe next safe allowed outcome full [service] policy true := by
  intro ⟨policy, hPolicy⟩
  cases hAction : policy () with
  | false =>
      have hSame := ((hPolicy ⟨true, false⟩ trivial).2 ()).2.2
      have hDelivered := (hSame service (by simp) ()).2 rfl
      change outcome (next ⟨true, false⟩ (policy ()) ()) = true at hDelivered
      rw [hAction] at hDelivered
      cases hDelivered
  | true =>
      have hSame := ((hPolicy ⟨false, false⟩ trivial).2 ()).2.2
      have hDelivered := (hSame service (by simp) ()).2 rfl
      change outcome (next ⟨false, false⟩ (policy ()) ()) = true at hDelivered
      rw [hAction] at hDelivered
      cases hDelivered

theorem maximality_and_statewise_service_do_not_give_implementation :
    UPTExist.LexAlignedL full ([service] : List (Bool → Unit → Prop)) true ∧
      (∀ s : State, ∃ a,
        ActionRealises next safe allowed outcome full [service] true s a) ∧
      ¬ ∃ policy : Unit → Bool,
        RealisesSelected observe next safe allowed outcome full [service] policy true :=
  ⟨selected_is_originally_maximal, each_state_can_deliver,
    no_observation_policy_delivers⟩

end HiddenService

namespace ArbitraryRealisesCountermodel

/- A negative control for the ORIGINAL arbitrary-predicate implementation
interface. The full feasible predicate and strict UPT comparator are used
unchanged. A real, nonempty source event executes, but its delivered-service
fact is false. Calling an arbitrary always-true predicate `realises` cannot
connect that physical source fact to the selected true retention fact. -/

def observe (_ : Unit) : Unit := ()
def safe (_ : Unit) : Prop := True
def allowed (_ : Unit) (_ : Unit) : Prop := True
def next (_ : Unit) (_ : Unit) (_ : Unit) : Unit := ()
def sourceOutcome (_ : Unit) : Bool := false
def full (_ : Bool) : Prop := True
def key (o : Bool) (_ : Unit) : Prop := o = true
def policy (_ : Unit) : Unit := ()
def fakeRealises (_ : Unit → Unit) (_ : Bool) : Prop := True

theorem selected_is_originally_maximal :
    UPTExist.LexAlignedL full ([key] : List (Bool → Unit → Prop)) true := by
  refine ⟨trivial, ?_⟩
  intro other _ hBetter
  cases hBetter with
  | inl hStrict => exact hStrict.2 (fun _ _ => rfl)
  | inr hLater => exact hLater.2

/-- Invoke the actual inherited `selected_realisation_suffices` theorem.
Its opaque predicate input accepts the fake relation and returns both its
formal realization claim and the genuine original-order maximality claim. -/
theorem old_interface_accepts_fake_realisation :
    fakeRealises policy true ∧
      UPTExist.LexAlignedL full ([key] : List (Bool → Unit → Prop)) true := by
  have hLocal : UPTExist.LexAlignedL
      (fun o : Bool => o ∈ [true]) ([key] : List (Bool → Unit → Prop)) true := by
    refine ⟨by simp, ?_⟩
    intro other _ hBetter
    exact selected_is_originally_maximal.2 other trivial hBetter
  have hOutside : IRSelectedMaximality.NoExcludedImprover
      ([key] : List (Bool → Unit → Prop)) full [true] true := by
    intro other hFull _ hBetter
    exact selected_is_originally_maximal.2 other hFull hBetter
  exact IRSelectedMaximality.selected_realisation_suffices
    ([key] : List (Bool → Unit → Prop)) full [true]
    (fun _ _ => trivial) true policy fakeRealises hLocal hOutside trivial

/-- The protected set is inhabited and the fixed fake-realizing policy
really preserves safety for every admitted modeled disturbance. -/
theorem inhabited_safe_source_and_uniform_policy :
    (∃ s : Unit, safe s) ∧
      ∀ o, IRObservedViability.UniformKeeper observe next safe o (policy o) := by
  refine ⟨⟨(), trivial⟩, ?_⟩
  intro o s hs ho d
  trivial

/-- A genuine completed one-event source trace contradicts the selected
retention fact at the original key and original particular. The problem is
not an empty invariant, empty disturbance type or unexecuted source. -/
theorem completed_event_has_original_retention_mismatch :
    ([()] : List Unit) ≠ [] ∧ key true () ∧
      ¬ key (sourceOutcome
        (IRViability.run next (fun s => policy (observe s)) () [()])) () := by
  refine ⟨by simp, rfl, ?_⟩
  intro h
  exact Bool.noConfusion h

/-- The explicit source-level realization contract rejects the same policy
that the arbitrary predicate accepted. It demands actual original facts. -/
theorem new_source_contract_rejects_fake_realisation :
    ¬ RealisesSelected observe next safe allowed sourceOutcome full [key] policy true := by
  intro hPolicy
  have hSame := ((hPolicy () trivial).2 ()).2.2
  have hDelivered := (hSame key (by simp) ()).2 rfl
  exact Bool.noConfusion hDelivered

/-- Complete requested hostile control for an arbitrary `realises` input:
old imported theorem + genuine selected maximality + safe uniform policy
coexist with actual source-retention failure and rejection by the repaired
source semantics. -/
theorem arbitrary_realises_does_not_certify_source_delivery :
    (fakeRealises policy true ∧
      UPTExist.LexAlignedL full ([key] : List (Bool → Unit → Prop)) true) ∧
    ((∃ s : Unit, safe s) ∧
      ∀ o, IRObservedViability.UniformKeeper observe next safe o (policy o)) ∧
    (([()] : List Unit) ≠ [] ∧ key true () ∧
      ¬ key (sourceOutcome
        (IRViability.run next (fun s => policy (observe s)) () [()])) ()) ∧
    ¬ RealisesSelected observe next safe allowed sourceOutcome full [key] policy true :=
  ⟨old_interface_accepts_fake_realisation, inhabited_safe_source_and_uniform_policy,
    completed_event_has_original_retention_mismatch,
    new_source_contract_rejects_fake_realisation⟩

end ArbitraryRealisesCountermodel

namespace ConflictingFreedoms

/-- One shared actuator can deliver either original particular's freedom.
The outcomes are incomparable in the original inclusion order. -/
def retained (a p : Bool) : Prop := a = p
def full (_ : Bool) : Prop := True

theorem every_freedom_individually_deliverable :
    ∀ p : Bool, ∃ a : Bool, retained a p := fun p => ⟨p, rfl⟩

/-- Per-particular existential actions cannot be exchanged for one action
delivering all originally specified freedoms. No population is removed. -/
theorem joint_delivery_impossible :
    ¬ ∃ a : Bool, ∀ p : Bool, retained a p := by
  intro ⟨a, h⟩
  have hFalse : a = false := h false
  have hTrue : a = true := h true
  exact Bool.noConfusion (hFalse.symm.trans hTrue)

theorem each_outcome_is_originally_maximal (a : Bool) :
    UPTExist.LexAlignedL full ([retained] : List (Bool → Bool → Prop)) a := by
  refine ⟨trivial, ?_⟩
  intro other _ hBetter
  cases hBetter with
  | inl hStrict =>
      have hSame : other = a := hStrict.1 a rfl
      subst other
      exact hStrict.2 (UPTExist.Sub.refl _)
  | inr hLater => exact hLater.2

end ConflictingFreedoms

namespace HiddenStateWitness

/-- Unbounded hidden environmental data and an immutable origin are retained
in the source state. Observation alone does not determine that state. -/
structure State where
  hidden : Nat
  served : Bool
  origin : Nat

def observe (_ : State) : Unit := ()
def safe (_ : State) : Prop := True
def allowed (_ : State) (_ : Bool) : Prop := True
def next (s : State) (a : Bool) (disturbance : Nat) : State :=
  ⟨s.hidden + disturbance, a, s.origin⟩
def outcome (s : State) : Bool × Nat := (s.served, s.origin)
def full (_ : Bool × Nat) : Prop := True

/-- Four original priority coordinates, over an arbitrary protected type:
existing life is retained, delivered existing freedom is the service bit,
and the example creates no new particular. -/
def existingLife {P : Type z} (_ : Bool × Nat) (_ : P) : Prop := True
def existingFreedom {P : Type z} (o : Bool × Nat) (_ : P) : Prop := o.1 = true
def newLife {P : Type z} (_ : Bool × Nat) (_ : P) : Prop := False
def newFreedom {P : Type z} (_ : Bool × Nat) (_ : P) : Prop := False
def keys (P : Type z) : List ((Bool × Nat) → P → Prop) :=
  [existingLife, existingFreedom, newLife, newFreedom]

/-- A completely specified fixed policy supplies service against every
modeled disturbance, preserves the immutable origin and tolerates hidden
state. It supplies all four retention coordinates for every original P. -/
theorem fixed_service_policy_realises (P : Type z) :
    RealisesSelected observe next safe allowed outcome full (keys P)
      (fun _ : Unit => true) (true, 0) := by
  intro s _
  refine ⟨trivial, ?_⟩
  intro d
  refine ⟨trivial, trivial, ?_⟩
  intro key hk p
  simp only [keys, List.mem_cons, List.not_mem_nil, or_false] at hk
  rcases hk with h | h | h | h
  · subst key; rfl
  · subst key; rfl
  · subst key; rfl
  · subst key; rfl

theorem source_state_not_determined_by_observation :
    ∃ s t : State, observe s = observe t ∧ s ≠ t := by
  refine ⟨⟨0, false, 0⟩, ⟨1, false, 0⟩, rfl, ?_⟩
  intro h
  have impossible : (0 : Nat) = 1 := congrArg State.hidden h
  exact Nat.noConfusion impossible

theorem immutable_origin_preserved (s : State) (a : Bool) (d : Nat) :
    (next s a d).origin = s.origin := rfl

/-- Infinite outcomes in the original feasible type remain in the model.
The construction does not enumerate a finite outcome domain. -/
theorem full_outcomes_all_origins (n : Nat) :
    full (true, n) ∧ full (false, n) := ⟨trivial, trivial⟩

end HiddenStateWitness

#print axioms sameRetention_lex_iff
#print axioms aligned_of_same_retention
#print axioms realisesSelected_target_iff
#print axioms exists_realising_policy_same_target_iff
#print axioms exists_policy_iff_common_fibre_actions
#print axioms exists_realising_policy_of_fibres
#print axioms policyOfSelectors_realises
#print axioms realises_uniform_keeper
#print axioms realises_every_nonempty_trace
#print axioms realised_trace_is_originally_globally_maximal
#print axioms incompatible_fibre_blocks_realisation
#print axioms common_fibre_actions_of_statewise_and_transport
#print axioms HiddenService.maximality_and_statewise_service_do_not_give_implementation
#print axioms ArbitraryRealisesCountermodel.arbitrary_realises_does_not_certify_source_delivery
#print axioms ConflictingFreedoms.every_freedom_individually_deliverable
#print axioms ConflictingFreedoms.joint_delivery_impossible
#print axioms HiddenStateWitness.fixed_service_policy_realises
#print axioms HiddenStateWitness.source_state_not_determined_by_observation

end PhysicalBridges.IRObservationRealisation
