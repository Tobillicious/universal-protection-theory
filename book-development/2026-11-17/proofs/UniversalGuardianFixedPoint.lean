import CapstoneCompatibility

/-!
# The exact all-agent protective fixed-point operator

This extends the reviewed kernel route with UNIVERSAL quantification over
every admitted agent/effect choice and an explicit unbounded finite-history
construction. IRKernelConstruction uses existential controlled actions and
requires a certified stabilizing iterate; this is a different operator.

The event certificate is a parameter to be instantiated with ALL SIX
unchanged OriginalX3 duties for the independently owed domain. No proxy
six-duty definition is introduced. Complete Koru is not redefined here.

The greatest fixed domain always exists as a predicate, but may be empty.
Nonemptiness and actual-world event/subject correspondence require their own
proofs. No universal actual-world fact is inferred from this construction.
-/

namespace Snuffy.BookWork.UniversalGuardianFixedPoint

open Snuffy.BookWork.CapstoneCompatibility

universe u v

variable {Agent : Type u} {S : Type v}

/-- Every represented state and full event certificate along a finite
    word of arbitrary agent/effect choices. Empty history still requires
    the independently specified state condition. -/
def CertifiedRun (update : Agent → S → S) (safe : S → Prop)
    (certificate : S → S → Prop) : S → List Agent → Prop
  | s, [] => safe s
  | s, a :: rest =>
      safe s ∧ certificate s (update a s) ∧
      CertifiedRun update safe certificate (update a s) rest

/-- The exact finite-history construction, with no finite-state or
    stabilization premise. This is not an assertion that any state has
    been independently shown to belong to the domain. -/
def UniversalG (update : Agent → S → S) (safe : S → Prop)
    (certificate : S → S → Prop) (s : S) : Prop :=
  ∀ word : List Agent, CertifiedRun update safe certificate s word

def GuardianOperator (update : Agent → S → S) (safe : S → Prop)
    (certificate : S → S → Prop) (X : S → Prop) (s : S) : Prop :=
  safe s ∧ ∀ a, certificate s (update a s) ∧ X (update a s)

def Inside (X Y : S → Prop) : Prop := ∀ s, X s → Y s

/-- The operator is monotone in the candidate continuation domain.
    Neither the state condition nor event certificate is altered. -/
theorem guardian_operator_is_monotone
    (update : Agent → S → S) (safe : S → Prop)
    (certificate : S → S → Prop)
    (X Y : S → Prop) (hXY : Inside X Y) :
    Inside (GuardianOperator update safe certificate X)
      (GuardianOperator update safe certificate Y) := by
  intro s hs
  exact ⟨hs.1, fun a => ⟨(hs.2 a).1, hXY _ (hs.2 a).2⟩⟩

/-- Fixed-point equality is PROVED by decomposing finite words. -/
theorem universal_G_is_a_fixed_point
    (update : Agent → S → S) (safe : S → Prop)
    (certificate : S → S → Prop) :
    ∀ s, UniversalG update safe certificate s ↔
      GuardianOperator update safe certificate
        (UniversalG update safe certificate) s := by
  intro s
  constructor
  · intro h
    refine ⟨h [], ?_⟩
    intro a
    exact ⟨(h [a]).2.1, fun rest => (h (a :: rest)).2.2⟩
  · intro h word
    cases word with
    | nil => exact h.1
    | cons a rest =>
      exact ⟨h.1, (h.2 a).1, (h.2 a).2 rest⟩

/-- Any independently certified post-fixed domain is included in G.
    This proves greatestness, without assuming an algorithm has stopped. -/
theorem every_certified_domain_is_inside_G
    (update : Agent → S → S) (safe : S → Prop)
    (certificate : S → S → Prop)
    (X : S → Prop)
    (hClosed : Inside X (GuardianOperator update safe certificate X)) :
    Inside X (UniversalG update safe certificate) := by
  have hWords : ∀ word : List Agent, ∀ s,
      X s → CertifiedRun update safe certificate s word := by
    intro word
    induction word with
    | nil =>
      intro s hs
      exact (hClosed s hs).1
    | cons a rest ih =>
      intro s hs
      have h := hClosed s hs
      exact ⟨h.1, (h.2 a).1, ih _ (h.2 a).2⟩
  exact fun s hs word => hWords word s hs

/-- G is the greatest fixed point (indeed the greatest post-fixed domain)
    under pointwise inclusion. No uniqueness of a whole-world state is
    asserted. -/
theorem universal_G_is_the_greatest_fixed_point
    (update : Agent → S → S) (safe : S → Prop)
    (certificate : S → S → Prop) :
    (∀ s, UniversalG update safe certificate s ↔
      GuardianOperator update safe certificate
        (UniversalG update safe certificate) s) ∧
    (∀ X : S → Prop,
      Inside X (GuardianOperator update safe certificate X) →
      Inside X (UniversalG update safe certificate)) :=
  ⟨universal_G_is_a_fixed_point update safe certificate,
    every_certified_domain_is_inside_G update safe certificate⟩

/-- Uniqueness is uniqueness of the GREATEST domain, not a claim that all
    states, agents, histories or particulars become identical. -/
theorem the_greatest_guardian_domain_is_unique
    (update : Agent → S → S) (safe : S → Prop)
    (certificate : S → S → Prop)
    (Y : S → Prop)
    (hYClosed : Inside Y (GuardianOperator update safe certificate Y))
    (hYGreatest : ∀ X : S → Prop,
      Inside X (GuardianOperator update safe certificate X) → Inside X Y) :
    ∀ s, Y s ↔ UniversalG update safe certificate s := by
  have hYG := every_certified_domain_is_inside_G
    update safe certificate Y hYClosed
  have hGClosed : Inside (UniversalG update safe certificate)
      (GuardianOperator update safe certificate
        (UniversalG update safe certificate)) :=
    fun s hs => (universal_G_is_a_fixed_point
      update safe certificate s).mp hs
  have hGY := hYGreatest _ hGClosed
  exact fun s => ⟨hYG s, hGY s⟩

theorem G_supplies_safe_state_and_every_full_event
    (update : Agent → S → S) (safe : S → Prop)
    (certificate : S → S → Prop)
    {s : S} (hG : UniversalG update safe certificate s) :
    safe s ∧ ∀ a, certificate s (update a s) :=
  ⟨hG [], fun a => (hG [a]).2.1⟩

theorem every_agent_update_preserves_G
    (update : Agent → S → S) (safe : S → Prop)
    (certificate : S → S → Prop)
    {s : S} (hG : UniversalG update safe certificate s) (a : Agent) :
    UniversalG update safe certificate (update a s) :=
  fun word => (hG (a :: word)).2.2

/-- State-aware and adaptive policies need no alignment or benevolence
    premise. They choose arbitrary members of the specified update family. -/
theorem every_adaptive_agent_policy_stays_in_G
    (update : Agent → S → S) (safe : S → Prop)
    (certificate : S → S → Prop)
    (policy : Nat → S → Agent) (initial : S)
    (hInitial : UniversalG update safe certificate initial) :
    ∀ n, UniversalG update safe certificate
      (policyRun update policy initial n) :=
  every_agent_policy_preserves_the_same_invariant update
    (UniversalG update safe certificate)
    (fun a _ hG => every_agent_update_preserves_G
      update safe certificate hG a)
    policy initial hInitial

/-- The exact full certificate holds on EVERY enacted policy step,
    not only a sampled final state or selected cooperative action. -/
theorem every_adaptive_agent_step_has_the_full_certificate
    (update : Agent → S → S) (safe : S → Prop)
    (certificate : S → S → Prop)
    (policy : Nat → S → Agent) (initial : S)
    (hInitial : UniversalG update safe certificate initial) :
    ∀ n, certificate (policyRun update policy initial n)
      (policyRun update policy initial (n + 1)) := by
  intro n
  have hG := every_adaptive_agent_policy_stays_in_G
    update safe certificate policy initial hInitial n
  exact (G_supplies_safe_state_and_every_full_event
    update safe certificate hG).2
      (policy n (policyRun update policy initial n))

/-- Nonemptiness can be derived from a separately constructed certified
    domain and its actual witness. It is not produced from fixed-point
    existence alone. -/
theorem independent_witness_and_closure_give_nonempty_G
    (update : Agent → S → S) (safe : S → Prop)
    (certificate : S → S → Prop)
    (X : S → Prop)
    (hClosed : Inside X (GuardianOperator update safe certificate X))
    (hWitness : ∃ s, X s) :
    ∃ s, UniversalG update safe certificate s := by
  obtain ⟨s, hs⟩ := hWitness
  exact ⟨s, every_certified_domain_is_inside_G
    update safe certificate X hClosed s hs⟩

/-- A single admitted action failing the full certificate excludes a
    claimed initial G state. Omitted bypasses cannot be wished away. -/
theorem one_failing_admitted_action_refutes_G_membership
    (update : Agent → S → S) (safe : S → Prop)
    (certificate : S → S → Prop) (s : S) (a : Agent)
    (hFails : ¬ certificate s (update a s)) :
    ¬ UniversalG update safe certificate s :=
  fun hG => hFails (hG [a]).2.1

/-- When a concrete construction independently proves the state condition
    and full certificate for EVERY update, membership in G is DERIVED for
    every initial model state. The complete guarded Living Tree is an
    example with safe := True and the separately proved six-field event
    certificate. This is not a claim that actual unmediated physics has
    those construction proofs. -/
theorem total_constructed_certificate_derives_G_for_every_state
    (update : Agent → S → S) (safe : S → Prop)
    (certificate : S → S → Prop)
    (hStates : ∀ s, safe s)
    (hEvents : ∀ a s, certificate s (update a s)) :
    ∀ s, UniversalG update safe certificate s := by
  have hClosed : Inside (fun _ : S => True)
      (GuardianOperator update safe certificate (fun _ => True)) :=
    fun s _ => ⟨hStates s, fun a => ⟨hEvents a s, trivial⟩⟩
  exact fun s => every_certified_domain_is_inside_G
    update safe certificate (fun _ => True) hClosed s trivial


#print axioms guardian_operator_is_monotone
#print axioms universal_G_is_a_fixed_point
#print axioms every_certified_domain_is_inside_G
#print axioms universal_G_is_the_greatest_fixed_point
#print axioms the_greatest_guardian_domain_is_unique
#print axioms G_supplies_safe_state_and_every_full_event
#print axioms every_agent_update_preserves_G
#print axioms every_adaptive_agent_policy_stays_in_G
#print axioms every_adaptive_agent_step_has_the_full_certificate
#print axioms independent_witness_and_closure_give_nonempty_G
#print axioms one_failing_admitted_action_refutes_G_membership
#print axioms total_constructed_certificate_derives_G_for_every_state

end Snuffy.BookWork.UniversalGuardianFixedPoint

