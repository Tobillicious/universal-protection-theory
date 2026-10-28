/-
IR-134: The selected retention outcome must come from an actually
constructed source execution, not an arbitrary caller-provided
'policy realises outcome' predicate. Historical UPT priority order,
full feasible outcome domain and subject duties remain unchanged.

Scope: exact conditional mathematics for a supplied transition system.
No real-world BCRD, semantic physical identity, authentic permission,
universal reach, or physical installation is inferred.
-/
import PhysicalBridges.IRProfileAudit
import PhysicalBridges.IR116CumulativeSubjectDuties

namespace PhysicalBridges.IR134
open PhysicalBridges.IRProfileAudit

universe u v w x y
variable {S : Type u} {O : Type v} {A : Type w}
variable {D : Type x} {P : Type y}

/-- Entire state-bearing physical history, including the initial state
and every intermediate successor; a final-state label would forget
intermediate deletions or irreversible injuries. -/
def runHistory (next : S → A → D → S)
    (observe : S → O) (policy : O → A) :
    S → List D → List S
  | s, [] => [s]
  | s, d :: ds =>
      s :: runHistory next observe policy
        (next s (policy (observe s)) d) ds

/-- The ACTUAL source-reachable outcome family for this transition
model: all policies, all admitted disturbance histories. No independent
or arbitrary 'realises' predicate is allowed. -/
def ExecutedHistory (next : S → A → D → S)
    (observe : S → O) (initial : S) (h : List S) : Prop :=
  ∃ (policy : O → A) (disturbances : List D),
    runHistory next observe policy initial disturbances = h

/-- The author's ORIGINAL four priority stages, in unchanged order.
Every argument is a complete physical history. The four supplied
predicates still require faithful original-particular semantics. -/
def fourOriginalKeys
    (existingLife existingFreedom newLife newFreedom :
      List S → P → Prop) : List (List S → P → Prop) :=
  [existingLife, existingFreedom, newLife, newFreedom]

/-- A concrete policy and disturbance history provide their actual
source outcome constructively. There is no 'realises' hypothesis. -/
theorem executed_selected_is_reachable
    (next : S → A → D → S) (observe : S → O)
    (initial : S) (policy : O → A) (disturbances : List D) :
    ExecutedHistory next observe initial
      (runHistory next observe policy initial disturbances) := by
  exact ⟨policy, disturbances, rfl⟩

/-- Strongest source-defined finite-profile composition: conditional
maximality over ALL actual reachable histories (NOT a filtered menu),
not merely a stipulated relation to a fictional selected outcome.
No theorem here asserts that finite faithful profiles always exist:
IR-56 proves they can fail on an unbounded full-feasible family. -/
theorem original_order_maximality_of_executed_audit
    (next : S → A → D → S) (observe : S → O)
    (initial : S) (policy : O → A) (disturbances : List D)
    (existingLife existingFreedom newLife newFreedom :
      List S → P → Prop)
    (code : List S → Nat) (representative : Nat → List S)
    (profiles : List Nat)
    (hCoverage : ∀ h,
      ExecutedHistory next observe initial h →
      code h ∈ profiles)
    (hFaithful : ∀ h,
      ExecutedHistory next observe initial h →
      ∀ k, k ∈ fourOriginalKeys existingLife existingFreedom
          newLife newFreedom →
        ∀ p, k h p ↔ k (representative (code h)) p)
    (hObstructions : ∀ c, c ∈ profiles →
      Obstructs (fourOriginalKeys existingLife existingFreedom
        newLife newFreedom)
        (runHistory next observe policy initial disturbances)
        (representative c)) :
    ExecutedHistory next observe initial
      (runHistory next observe policy initial disturbances) ∧
    UPTExist.LexAlignedL
      (ExecutedHistory next observe initial)
      (fourOriginalKeys existingLife existingFreedom
        newLife newFreedom)
      (runHistory next observe policy initial disturbances) := by
  let keys := fourOriginalKeys existingLife existingFreedom
    newLife newFreedom
  let chosen := runHistory next observe policy initial disturbances
  have hActual : ExecutedHistory next observe initial chosen :=
    ⟨policy, disturbances, rfl⟩
  constructor
  · exact hActual
  · constructor
    · exact hActual
    · intro other hOther hBetter
      have hc := hCoverage other hOther
      have hf := hFaithful other hOther
      have hProxyBetter :=
        improvement_transfers_to_faithful_profile
          keys chosen other (representative (code other)) hf hBetter
      exact
        (obstruction_blocks_improvement keys chosen
          (representative (code other))
          (hObstructions (code other) hc)) hProxyBetter

/-- The same deterministic physical transition gives the relational
step predicate used by IR-116. Any environmental branch is included
only if it belongs to D; D's completeness remains external. -/
def PhysicalStep (next : S → A → D → S)
    (s : S) (a : A) (t : S) : Prop :=
  ∃ d : D, next s a d = t

/-- A reachability proof can be concatenated without an assumed
'realises' relation. -/
theorem policy_reach_trans
    (step : S → A → S → Prop) (policy : O → A)
    (observe : S → O)
    {a b c : S}
    (hab : IR109.PolicyReach step policy observe a b)
    (hbc : IR109.PolicyReach step policy observe b c) :
    IR109.PolicyReach step policy observe a c := by
  induction hbc with
  | refl => exact hab
  | tail earlier edge ih =>
      exact IR109.PolicyReach.tail ih edge

/-- Every execution produced by the deterministic source is a
genuine trace in the IR-116 physical-step relation. -/
theorem source_run_is_policy_reachable
    (next : S → A → D → S) (observe : S → O)
    (policy : O → A) (initial : S)
    (disturbances : List D) :
    IR109.PolicyReach (PhysicalStep next) policy observe initial
      (IRViability.run next (fun s => policy (observe s))
        initial disturbances) := by
  induction disturbances generalizing initial with
  | nil =>
      exact IR109.PolicyReach.refl initial
  | cons d ds ih =>
      change IR109.PolicyReach (PhysicalStep next) policy observe initial
        (IRViability.run next (fun s => policy (observe s))
          (next initial (policy (observe initial)) d) ds)
      have first :
        IR109.PolicyReach (PhysicalStep next) policy observe initial
          (next initial (policy (observe initial)) d) :=
        IR109.PolicyReach.tail (IR109.PolicyReach.refl initial)
          ⟨d, rfl⟩
      exact policy_reach_trans (PhysicalStep next) policy observe
        first (ih (next initial (policy (observe initial)) d))

/-- Carry the old IR-116 *cumulative* physical subject duties across an
ACTUALLY constructed source run. The initial cohort cannot be hidden by
deleting its registry, and EVERY independently required action remains
executable in the final state. The continuing/owed/required/executable
predicates and the two local physical laws still need independent
physical-semantic validation. -/
theorem source_run_retains_original_cohort_and_required_options
    (next : S → A → D → S) (observe : S → O)
    (policy : O → A)
    (owed : S → P → Prop) (continues : S → P → Prop)
    (required executable : S → P → A → Prop)
    (hMonotone : ∀ s d m,
      owed s m → owed (next s (policy (observe s)) d) m)
    (hRobust : ∀ s d,
      IR116.EveryOwedSubjectProtected owed continues required executable s →
      IR116.EveryOwedSubjectProtected owed continues required executable
        (next s (policy (observe s)) d))
    (initial : S)
    (hInitial :
      IR116.EveryOwedSubjectProtected owed continues required executable initial)
    (disturbances : List D) :
    ∀ m, owed initial m →
      let final := IRViability.run next
        (fun s => policy (observe s)) initial disturbances
      continues final m ∧
        (∃ a, required final m a) ∧
        (∀ a, required final m a → executable final m a) := by
  have hTrace :=
    source_run_is_policy_reachable next observe policy initial disturbances
  exact IR116.initial_cohort_retains_continuity_and_every_required_option
    observe (PhysicalStep next) policy owed continues required executable
    (by
      intro s t ht m hm
      rcases ht with ⟨d, hd⟩
      subst t
      exact hMonotone s d m hm)
    (by
      intro o s ho hs t ht
      rcases ht with ⟨d, hd⟩
      subst t
      have heq : policy o = policy (observe s) :=
        congrArg policy ho.symm
      -- The policy observation and physical source successor match.
      simpa [heq] using hRobust s d hs)
    hTrace hInitial

/-- Actual source history contains no unaccounted intermediate
continuation or required-option failure for the ORIGINAL owed cohort:
the property holds at every intermediate physical state, not just the
end. This follows from IR-116's same local duty premises but is a
stronger path-level extraction for an actual source model. -/
theorem every_source_prefix_retains_owed_cohort
    (next : S → A → D → S) (observe : S → O)
    (policy : O → A)
    (owed : S → P → Prop) (continues : S → P → Prop)
    (required executable : S → P → A → Prop)
    (hMonotone : ∀ s d m,
      owed s m → owed (next s (policy (observe s)) d) m)
    (hRobust : ∀ s d,
      IR116.EveryOwedSubjectProtected owed continues required executable s →
      IR116.EveryOwedSubjectProtected owed continues required executable
        (next s (policy (observe s)) d))
    (initial : S) (disturbances : List D) :
    IR116.EveryOwedSubjectProtected owed continues required executable
      initial →
    ∀ state, state ∈ runHistory next observe policy initial disturbances →
      IR116.EveryOwedSubjectProtected owed continues required executable
        state ∧
      (∀ m, owed initial m → owed state m) := by
  induction disturbances generalizing initial with
  | nil =>
      intro hInitial state hMember
      have hEq : state = initial := by
        simpa [runHistory] using hMember
      subst state
      exact ⟨hInitial, fun _ hm => hm⟩
  | cons d ds ih =>
      intro hInitial state hMember
      change state ∈ initial :: runHistory next observe policy
        (next initial (policy (observe initial)) d) ds at hMember
      rcases List.mem_cons.mp hMember with hHere | hLater
      · subst state
        exact ⟨hInitial, fun _ hm => hm⟩
      · have hNext : IR116.EveryOwedSubjectProtected
          owed continues required executable
          (next initial (policy (observe initial)) d) :=
          hRobust initial d hInitial
        have hTail := ih
          (next initial (policy (observe initial)) d)
          hNext state hLater
        constructor
        · exact hTail.1
        · intro m hm
          exact hTail.2 m (hMonotone initial d m hm)

/-- No original owed particular may be dropped at ANY intermediate
state of the source-executed history; every stated required option must
remain executable at that state. This is a conservative source trace
certificate, NOT an objective physical original-vs-copy criterion. -/
theorem original_cohort_continues_with_options_at_every_source_state
    (next : S → A → D → S) (observe : S → O)
    (policy : O → A)
    (owed : S → P → Prop) (continues : S → P → Prop)
    (required executable : S → P → A → Prop)
    (hMonotone : ∀ s d m,
      owed s m → owed (next s (policy (observe s)) d) m)
    (hRobust : ∀ s d,
      IR116.EveryOwedSubjectProtected owed continues required executable s →
      IR116.EveryOwedSubjectProtected owed continues required executable
        (next s (policy (observe s)) d))
    (initial : S) (disturbances : List D)
    (hInitial : IR116.EveryOwedSubjectProtected
      owed continues required executable initial) :
    ∀ m, owed initial m →
      ∀ state, state ∈ runHistory next observe policy initial disturbances →
        continues state m ∧
        (∃ a, required state m a) ∧
        (∀ a, required state m a → executable state m a) := by
  intro m hm state hMember
  have hEach := every_source_prefix_retains_owed_cohort
    next observe policy owed continues required executable
    hMonotone hRobust initial disturbances hInitial state hMember
  exact hEach.1 m (hEach.2 m hm)

/-- A stationary reactive physical environment sees the actual state
AND the controller's just-chosen action. To model more general history-
dependent environmental strategies, include the necessary memory in S
and prove that augmentation source-faithful. This is NOT a fixed
per-policy prerecorded disturbance transcript. -/
def runReactiveHistory (next : S → A → D → S)
    (observe : S → O) (world : S → A → D)
    (policy : O → A) : S → Nat → List S
  | s, 0 => [s]
  | s, n + 1 =>
      let a := policy (observe s)
      s :: runReactiveHistory next observe world policy
        (next s a (world s a)) n

/-- Feasible outcomes under this ONE physically specified reactive
world, not outcomes freely combined from unrelated adversarial worlds.
The world strategy responds to the action in the same source state. -/
def ExecutedInWorld (next : S → A → D → S)
    (observe : S → O) (world : S → A → D)
    (initial : S) (horizon : Nat)
    (history : List S) : Prop :=
  ∃ policy : O → A,
    runReactiveHistory next observe world policy initial horizon = history

/-- Exact selected-policy realization and original four-stage
maximality, compared with all source-executable rival policies IN THE
SAME reactive world. Finite-profile completeness and actual physical
source/world/identity correspondence are not derived here. -/
theorem reactive_world_original_order_selected_maximal
    (next : S → A → D → S) (observe : S → O)
    (world : S → A → D) (initial : S) (horizon : Nat)
    (policy : O → A)
    (existingLife existingFreedom newLife newFreedom :
      List S → P → Prop)
    (code : List S → Nat) (representative : Nat → List S)
    (profiles : List Nat)
    (hCoverage : ∀ h,
      ExecutedInWorld next observe world initial horizon h →
      code h ∈ profiles)
    (hFaithful : ∀ h,
      ExecutedInWorld next observe world initial horizon h →
      ∀ k, k ∈ fourOriginalKeys existingLife existingFreedom
          newLife newFreedom →
        ∀ p, k h p ↔ k (representative (code h)) p)
    (hObstructions : ∀ c, c ∈ profiles →
      Obstructs (fourOriginalKeys existingLife existingFreedom
        newLife newFreedom)
        (runReactiveHistory next observe world policy initial horizon)
        (representative c)) :
    ExecutedInWorld next observe world initial horizon
      (runReactiveHistory next observe world policy initial horizon) ∧
    UPTExist.LexAlignedL
      (ExecutedInWorld next observe world initial horizon)
      (fourOriginalKeys existingLife existingFreedom
        newLife newFreedom)
      (runReactiveHistory next observe world policy initial horizon) := by
  let keys := fourOriginalKeys existingLife existingFreedom
    newLife newFreedom
  let chosen := runReactiveHistory next observe world policy initial horizon
  have hActual : ExecutedInWorld next observe world initial horizon chosen :=
    ⟨policy, rfl⟩
  constructor
  · exact hActual
  · constructor
    · exact hActual
    · intro other hOther hBetter
      have hc := hCoverage other hOther
      have hf := hFaithful other hOther
      have hProxyBetter :=
        improvement_transfers_to_faithful_profile
          keys chosen other (representative (code other)) hf hBetter
      exact
        (obstruction_blocks_improvement keys chosen
          (representative (code other))
          (hObstructions (code other) hc)) hProxyBetter

/-- Hostile control: a reactive world may respond differently to
different actions at the SAME observed state. Pretending a common
fixed exogenous response independent of policy can miscompare rivals. -/
def actionResponsiveWorld (_ : Bool) (a : Bool) : Bool := a
def actionReactiveStep (_ : Bool) (_ : Bool) (d : Bool) : Bool := d

theorem reactive_environment_is_not_a_fixed_disturbance_transcript :
    runReactiveHistory actionReactiveStep (fun _ : Bool => ())
      actionResponsiveWorld (fun _ => false) false 1 = [false, false] ∧
    runReactiveHistory actionReactiveStep (fun _ : Bool => ())
      actionResponsiveWorld (fun _ => true) false 1 = [false, true] := by
  constructor <;> decide

/-- Hostile control: a bare caller-defined 'realises' relation can
claim a never-reached source state. Our ExecutedHistory predicate
cannot make that claim for this explicit immutable source. -/
def inertStep (s : Bool) (_ : Bool) (_ : Unit) : Bool := s

theorem arbitrary_realisability_witness_can_be_false :
    (∃ fake : (Unit → Bool) → List Bool → Prop,
      fake (fun _ => false) [true]) ∧
    (∀ policy : Unit → Bool, ∀ ds : List Unit,
      runHistory inertStep (fun _ : Bool => ()) policy false ds ≠
        [true]) := by
  constructor
  · exact ⟨(fun _ _ => True), trivial⟩
  · intro policy ds h
    cases ds with
    | nil =>
        simp [runHistory] at h
    | cons d tail =>
        simp [runHistory] at h

/-- A physically executable service action does not imply the
controller ever selects that action. Even an arbitrarily long actual
source history can stutter with the service option still available.
This is the inherited IR-43 progress warning, NOT a refutation of
pathwise continuation under separately verified robust premises. -/
def serviceStep (count : Nat) (action : Bool) (_ : Unit) : Nat :=
  if action then count + 1 else count

theorem unexercised_freedom_under_permanent_stutter :
    (∀ disturbances : List Unit,
      IRViability.run serviceStep
        (fun _ : Nat => false) 0 disturbances = 0) ∧
    (∀ s : Nat, ∃ a : Bool,
      a = true ∧ serviceStep s a () = s + 1) := by
  constructor
  · intro disturbances
    induction disturbances with
    | nil => rfl
    | cons _ ds ih =>
        simpa [IRViability.run, serviceStep] using ih
  · intro s
    exact ⟨true, rfl, by simp [serviceStep]⟩

#print axioms executed_selected_is_reachable
#print axioms original_order_maximality_of_executed_audit
#print axioms source_run_is_policy_reachable
#print axioms source_run_retains_original_cohort_and_required_options
#print axioms every_source_prefix_retains_owed_cohort
#print axioms original_cohort_continues_with_options_at_every_source_state
#print axioms reactive_world_original_order_selected_maximal
#print axioms reactive_environment_is_not_a_fixed_disturbance_transcript
#print axioms unexercised_freedom_under_permanent_stutter
#print axioms arbitrary_realisability_witness_can_be_false
end PhysicalBridges.IR134
