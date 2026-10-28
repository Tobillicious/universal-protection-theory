import PhysicalBridges.IR116CumulativeSubjectDuties
import PhysicalBridges.IR96DisturbanceSimulation

/-!
IR-127 — Repair the proposed X3 graph-grammar operational semantics.

CRITICAL: A rejected rewrite is NOT a transition to the empty graph.
Rejection is `none` (an outcome, not a physical successor), and the
induced small-step relation contains accepted successors only.

Parent closure is weaker than preservation of any terminal subject
node. A generator-hook flag is not consent. A fourfold causal-graph
grammar does not become a universal physics law by being well typed.

The positive theorem uses explicit local subject/duty/requirements/
authorization contracts to preserve the intended protected predicate
over arbitrary FINITE ACCEPTED execution traces. The actual physical
system must be shown to refine this closed accepted-step relation:
the kernel's proof cannot prevent bypasses on its own.

X3 maximal freedom, subjective identity, physical applicability and
progress/nonblocking remain independent proof obligations.
-/
namespace PhysicalBridges.IR127

universe u v w x
variable {Node : Type u} {Mind : Type v}
variable {Action : Type w}

/-- Typed causal graph; no assumption that this exhausts real physics. -/
structure Graph (Node : Type u) where
  live : Node → Prop
  root : Node → Prop
  parent : Node → Node → Prop

/-- The user's proposed immediate-parent condition. Notice that it
does NOT by itself imply rooted ancestry, acyclicity, or protection
of individual terminal nodes. -/
def ParentClosed (g : Graph Node) : Prop :=
  ∀ v, g.live v → ¬ g.root v →
    ∃ p, g.live p ∧ g.parent p v

/-- The subject ledger and physical-meaning predicates are separate
from a graph's mere syntactic well-formedness. -/
structure State (Node : Type u) (Mind : Type v)
    (Action : Type w) where
  graph : Graph Node
  owed : Mind → Prop
  continues : Mind → Prop
  required : Mind → Action → Prop
  executable : Mind → Action → Prop

def Protected (s : State Node Mind Action) : Prop :=
  ParentClosed s.graph ∧
    ∀ m, s.owed m →
      s.continues m ∧
      (∃ a, s.required m a) ∧
      (∀ a, s.required m a → s.executable m a)

/-- Raw grammar rule: matching/rewriting is defined separately from
the generator hook, its coverage, and real authorization. -/
structure Rule (Node : Type u) (Mind : Type v)
    (Action : Type w) where
  matchRule : State Node Mind Action → Prop
  propose : State Node Mind Action → State Node Mind Action
  affects : State Node Mind Action → Mind → Prop
  hook : State Node Mind Action → Mind → Prop
  authorized : State Node Mind Action → Mind → Prop

/-- Explicit source-level certificate to accompany every ACCEPTED
rewrite. Rather than declaring a hook to imply X3 by definition, it
requires separate subject continuity and required-option transfer.
These are premises to discharge from source, physical and semantic
evidence, NOT derived from parent closure. -/
structure Certified
    (r : Rule Node Mind Action)
    (s : State Node Mind Action) : Prop where
  matching : r.matchRule s
  parentClosed : ParentClosed (r.propose s).graph
  dutyMonotone : ∀ m, s.owed m → (r.propose s).owed m
  continuation : ∀ m, s.owed m →
    s.continues m → (r.propose s).continues m
  requiredMonotone : ∀ m a, s.owed m →
    s.required m a → (r.propose s).required m a
  executableMonotone : ∀ m a, s.owed m →
    s.executable m a → (r.propose s).executable m a
  newlyRequiredProvisioned : ∀ m a,
    (r.propose s).owed m → (r.propose s).required m a →
      (s.owed m ∧ s.required m a) ∨
        (r.propose s).executable m a
  requiredNonempty : ∀ m, (r.propose s).owed m →
    ∃ a, (r.propose s).required m a
  newSubjectsCertified : ∀ m, (r.propose s).owed m →
    ¬ s.owed m → (r.propose s).continues m ∧
      ∀ a, (r.propose s).required m a →
        (r.propose s).executable m a
  generatorHook : ∀ m, s.owed m → r.affects s m → r.hook s m
  authorization : ∀ m, s.owed m →
    r.affects s m → r.authorized s m

/-- A reject is NOT an empty graph or an admitted state transition.
This is a logical specification; Decidable certificates require a
separate actual implementation and trusted checker. -/
noncomputable def eval
    (r : Rule Node Mind Action)
    (s : State Node Mind Action) :
    Option (State Node Mind Action) := by
  classical
  exact if Certified r s then some (r.propose s) else none

theorem rejected_rule_has_no_successor
    (r : Rule Node Mind Action)
    (s : State Node Mind Action)
    (hReject : ¬ Certified r s) :
    eval r s = none ∧
      ¬ ∃ t, eval r s = some t := by
  have hNone : eval r s = none := by
    simp [eval, hReject]
  refine ⟨hNone, ?_⟩
  rintro ⟨t, ht⟩
  rw [hNone] at ht
  cases ht

theorem successful_eval_is_certified
    (r : Rule Node Mind Action)
    (s t : State Node Mind Action)
    (h : eval r s = some t) :
    Certified r s ∧ t = r.propose s := by
  classical
  by_cases hc : Certified r s
  · have heq : r.propose s = t :=
      Option.some.inj (by simpa [eval, hc] using h)
    exact ⟨hc, heq.symm⟩
  · have : False := by
      simp [eval, hc] at h
    exact False.elim this

/-- Strongest locally justified source-level property: every old
subject remains owed, continues, and keeps all currently required
executable options; new subjects require their own certificate. -/
theorem certified_rewrite_preserves_protection
    (r : Rule Node Mind Action)
    (s : State Node Mind Action)
    (hCert : Certified r s)
    (hSafe : Protected s) :
    Protected (r.propose s) := by
  refine ⟨hCert.parentClosed, ?_⟩
  intro m hOwed
  by_cases hOld : s.owed m
  · obtain ⟨hContinuing, _, hOptions⟩ := hSafe.2 m hOld
    refine ⟨hCert.continuation m hOld hContinuing,
      hCert.requiredNonempty m hOwed, ?_⟩
    intro a hRequired
    rcases hCert.newlyRequiredProvisioned m a hOwed hRequired with
      ⟨_, hOldReq⟩ | hNewExecutable
    · exact hCert.executableMonotone m a hOld
        (hOptions a hOldReq)
    · exact hNewExecutable
  · obtain ⟨hContinuous, hAllOptions⟩ :=
      hCert.newSubjectsCertified m hOwed hOld
    exact ⟨hContinuous, hCert.requiredNonempty m hOwed,
      hAllOptions⟩

/-- Only accepted outcomes induce a small-step graph transition. -/
def AcceptedStep
    (s t : State Node Mind Action) : Prop :=
  ∃ r : Rule Node Mind Action, eval r s = some t

theorem accepted_step_preserves_protection
    (s t : State Node Mind Action)
    (h : AcceptedStep s t)
    (hSafe : Protected s) : Protected t := by
  obtain ⟨r, hEval⟩ := h
  obtain ⟨hCert, hEq⟩ :=
    successful_eval_is_certified r s t hEval
  rw [hEq]
  exact certified_rewrite_preserves_protection r s hCert hSafe

theorem accepted_finite_trace_preserves_protection
    {start finish : State Node Mind Action}
    (hTrace : IR96.Reach
      (AcceptedStep (Node := Node) (Mind := Mind)
        (Action := Action)) start finish)
    (hInitial : Protected start) :
    Protected finish := by
  induction hTrace with
  | refl => exact hInitial
  | tail earlier edge ih =>
      exact accepted_step_preserves_protection _ _ edge ih

/-- The original individual stays owed in every accepted finite
trace; it cannot disappear merely by deleting a mutable registry
entry, provided the certified transition relation mediates ALL
actual physical changes. -/
theorem accepted_finite_trace_keeps_original_duties
    {start finish : State Node Mind Action}
    (hTrace : IR96.Reach
      (AcceptedStep (Node := Node) (Mind := Mind)
        (Action := Action)) start finish) :
    ∀ m, start.owed m → finish.owed m := by
  induction hTrace with
  | refl =>
      intro m hm
      exact hm
  | tail earlier edge ih =>
      obtain ⟨r, hEval⟩ := edge
      obtain ⟨hCert, hEq⟩ :=
        successful_eval_is_certified r _ _ hEval
      intro m hm
      rw [hEq]
      exact hCert.dutyMonotone m (ih m hm)

/-- Every initially owed subject is still continuing and has the
complete CURRENT required option set executable after every finite
accepted trace, using IR-116's cumulative-duty principle. -/
theorem original_cohort_retains_protection
    {start finish : State Node Mind Action}
    (hTrace : IR96.Reach
      (AcceptedStep (Node := Node) (Mind := Mind)
        (Action := Action)) start finish)
    (hInitial : Protected start) :
    ∀ m, start.owed m →
      finish.owed m ∧ finish.continues m ∧
      (∃ a, finish.required m a) ∧
      (∀ a, finish.required m a → finish.executable m a) := by
  have hFinal :=
    accepted_finite_trace_preserves_protection hTrace hInitial
  have hCohort :=
    accepted_finite_trace_keeps_original_duties hTrace
  intro m hm
  have hStill := hCohort m hm
  exact ⟨hStill, hFinal.2 m hStill⟩

/-- A physical execution inherits this theorem ONLY when each
physical transition has a matching accepted source rewrite AND the
independent meaning of source protection reflects back to physical
protection. Those are precisely the remaining source/physics joins. -/
theorem physical_refinement_requires_complete_mediation
    {Physical : Type x}
    (relate : State Node Mind Action → Physical → Prop)
    (physicalStep : Physical → Physical → Prop)
    (physicalProtected : Physical → Prop)
    (hMediation : ∀ s p q,
      relate s p → physicalStep p q →
      ∃ t, AcceptedStep s t ∧ relate t q)
    (hReflect : ∀ s p, relate s p →
      Protected s → physicalProtected p)
    (s : State Node Mind Action)
    (p q : Physical)
    (hRelated : relate s p)
    (hInitial : Protected s)
    (hPhysicalExecution : IR96.Reach physicalStep p q) :
    physicalProtected q := by
  obtain ⟨_, _, _, hPhys⟩ :=
    IR96.robust_reach
      relate (AcceptedStep (Node := Node) (Mind := Mind)
        (Action := Action)) physicalStep
      hMediation Protected physicalProtected
      (by
        intro a b hab ha
        exact accepted_step_preserves_protection a b hab ha)
      hReflect s p q hRelated hInitial hPhysicalExecution
  exact hPhys

/-! Two exact hostile controls. -/

def originalGraph : Graph Bool :=
  { live := fun _ => True
    root := fun n => n = true
    parent := fun p n => p = true ∧ n = false }

def deletedTerminalGraph : Graph Bool :=
  { live := fun n => n = true
    root := fun n => n = true
    parent := fun _ _ => False }

/-- Deleting a terminal subject node leaves BOTH graphs satisfying
the user's immediate-parent closure rule. Parent closure alone is
therefore not a subject-preservation invariant. -/
theorem parent_closure_allows_terminal_subject_deletion :
    ParentClosed originalGraph ∧
    ParentClosed deletedTerminalGraph ∧
    originalGraph.live false ∧
    ¬ deletedTerminalGraph.live false := by
  refine ⟨?_, ?_, trivial, ?_⟩
  · intro v hv hNotRoot
    cases v with
    | false =>
        exact ⟨true, trivial, ⟨rfl, rfl⟩⟩
    | true =>
        exact False.elim (hNotRoot rfl)
  · intro v hv hNotRoot
    exact False.elim (hNotRoot hv)
  · change ¬ ((false : Bool) = true)
    decide

/-- A present generator hook is a mere Boolean witness that a
hook exists; it does not imply genuine authorization or preserve
the living generator's continuation. -/
theorem generator_hook_alone_cannot_preserve_continuation :
    ∃ hook oldAlive newAlive : Bool,
      hook = true ∧ oldAlive = true ∧ newAlive = false := by
  exact ⟨true, true, false, rfl, rfl, rfl⟩

end PhysicalBridges.IR127
