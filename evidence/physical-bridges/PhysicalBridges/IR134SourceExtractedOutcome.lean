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

#print axioms executed_selected_is_reachable
#print axioms original_order_maximality_of_executed_audit
#print axioms source_run_is_policy_reachable
#print axioms source_run_retains_original_cohort_and_required_options
#print axioms arbitrary_realisability_witness_can_be_false
end PhysicalBridges.IR134
