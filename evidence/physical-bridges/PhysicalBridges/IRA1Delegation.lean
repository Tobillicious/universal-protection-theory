/-
IR-90 — original A1 T3.2 descendant authority non-escalation.

Recovered A1 T3.2: a generated child/delegated component must
receive no capability absent from its parent scope. The source
checks a finite list-of-natural-capabilities subset relation by a
genuinely executable Bool, with a structural soundness proof.

The parent authority is immutable in this model. Physical rights,
implicit privileges, memory-map aliases, key transmission, dynamic
revocation, delegation cycles, and actual living-mind autonomy are
NOT derived. Tie to IR-84's permittedMask via a separate theorem:
non-escalating child grants stay in the global mask when the
parent authority itself is within that mask.

A deliberately unguarded delegation produces a forbidden right.
-/
import PhysicalBridges.IRA1PageCapability

namespace PhysicalBridges.IRA1Delegation

def subsetCheck (parent : List Nat) : List Nat → Bool
  | [] => true
  | cap :: tail =>
      decide (cap ∈ parent) && subsetCheck parent tail

theorem subset_checker_sound (parent : List Nat) :
    ∀ child, subsetCheck parent child = true →
      ∀ cap, cap ∈ child → cap ∈ parent := by
  intro child
  induction child with
  | nil =>
      intro _ cap hMem
      cases hMem
  | cons current tail ih =>
      intro hCheck cap hMem
      have hParts :
          decide (current ∈ parent) = true ∧
          subsetCheck parent tail = true := by
        simpa only [subsetCheck,Bool.and_eq_true] using hCheck
      rcases List.mem_cons.mp hMem with hHead | hTail
      · subst cap
        exact decide_eq_true_eq.mp hParts.1
      · exact ih hParts.2 cap hTail

def SubsetAuthority (parent child : List Nat) : Prop :=
  ∀ cap, cap ∈ child → cap ∈ parent

theorem permitted_subset_is_not_merely_named
    (parent child : List Nat)
    (h : subsetCheck parent child = true) :
    SubsetAuthority parent child :=
  subset_checker_sound parent child h

structure DelegationState where
  authority : List Nat
  descendants : List (List Nat)
deriving Repr

def ValidDelegations (s : DelegationState) : Prop :=
  ∀ child, child ∈ s.descendants →
    SubsetAuthority s.authority child

/-- Actual source permission gate checks EACH proposed child
capability against the unmodified authority list. -/
def delegate (s : DelegationState) (child : List Nat) : DelegationState :=
  if subsetCheck s.authority child then
    { s with descendants := child :: s.descendants }
  else s

theorem rejected_delegation_does_not_change_state
    (s : DelegationState) (child : List Nat)
    (h : subsetCheck s.authority child = false) :
    delegate s child = s := by
  simp [delegate,h]

theorem delegation_preserves_parent_authority
    (s : DelegationState) (child : List Nat) :
    (delegate s child).authority = s.authority := by
  unfold delegate
  split <;> rfl

theorem delegate_preserves_nonescalation
    (s : DelegationState) (child : List Nat)
    (h : ValidDelegations s) :
    ValidDelegations (delegate s child) := by
  by_cases hGate : subsetCheck s.authority child = true
  · have hChild : SubsetAuthority s.authority child :=
      permitted_subset_is_not_merely_named s.authority child hGate
    simp only [delegate,hGate,ite_true]
    change ∀ candidate, candidate ∈ (child :: s.descendants) →
      SubsetAuthority s.authority candidate
    intro candidate hMem
    rcases List.mem_cons.mp hMem with hHead | hTail
    · subst candidate
      exact hChild
    · exact h candidate hTail
  · have hf : subsetCheck s.authority child = false := by
      cases hbool : subsetCheck s.authority child <;> simp_all
    simpa [delegate,hf] using h

def run (s : DelegationState) (children : List (List Nat)) :
    DelegationState :=
  children.foldl delegate s

theorem arbitrary_finite_delegation_chain_never_escalates
    (s : DelegationState) (children : List (List Nat))
    (h : ValidDelegations s) :
    ValidDelegations (run s children) := by
  induction children generalizing s with
  | nil => exact h
  | cons child tail ih =>
      change ValidDelegations (run (delegate s child) tail)
      exact ih (delegate s child)
        (delegate_preserves_nonescalation s child h)

theorem finite_delegation_chain_preserves_root_authority
    (s : DelegationState) (children : List (List Nat)) :
    (run s children).authority = s.authority := by
  induction children generalizing s with
  | nil => rfl
  | cons child tail ih =>
      change (run (delegate s child) tail).authority = s.authority
      rw [ih]
      exact delegation_preserves_parent_authority s child

/-- Connection to original T1.1. If ROOT scope is globally
permitted, all admitted delegated child capabilities remain inside
that SAME global mask. No theorem asserts the actual physical MMU
implements these abstract rights. -/
theorem delegated_child_stays_within_t11_global_mask
    (mask : Nat → Bool)
    (parent child : List Nat)
    (hRootAllowed : ∀ cap, cap ∈ parent → mask cap = true)
    (hDelegated : subsetCheck parent child = true) :
    ∀ cap, cap ∈ child → mask cap = true := by
  intro cap hCap
  apply hRootAllowed cap
  exact subset_checker_sound parent child hDelegated cap hCap

theorem all_descendants_stay_within_t11_global_mask
    (mask : Nat → Bool) (s : DelegationState)
    (hValid : ValidDelegations s)
    (hRootAllowed :
      ∀ cap, cap ∈ s.authority → mask cap = true) :
    ∀ child, child ∈ s.descendants →
      ∀ cap, cap ∈ child → mask cap = true := by
  intro child hChild cap hCap
  exact hRootAllowed cap (hValid child hChild cap hCap)

def unguardedDelegate (s : DelegationState) (child : List Nat) :
    DelegationState :=
  { s with descendants := child :: s.descendants }

theorem unchecked_child_grant_can_escalate_authority :
    ∃ s : DelegationState, ValidDelegations s ∧
      ¬ ValidDelegations (unguardedDelegate s [7]) := by
  let s : DelegationState := ⟨[1],[]⟩
  refine ⟨s, ?_, ?_⟩
  · intro child hMem
    cases hMem
  · intro h
    have h7 : 7 ∈ s.authority :=
      h [7] (by simp [unguardedDelegate]) 7 (by simp)
    simp [s] at h7

/-- A concrete abstract authority can delegate 1, but cannot
delegate 7; it does not matter how persuasive the descendant is. -/
theorem example_delegation_rejects_escalation :
    subsetCheck [1,2,3] [2,3] = true ∧
    subsetCheck [1,2,3] [2,7] = false := by
  decide

#print axioms subset_checker_sound
#print axioms delegation_preserves_parent_authority
#print axioms delegate_preserves_nonescalation
#print axioms arbitrary_finite_delegation_chain_never_escalates
#print axioms finite_delegation_chain_preserves_root_authority
#print axioms delegated_child_stays_within_t11_global_mask
#print axioms all_descendants_stay_within_t11_global_mask
#print axioms unchecked_child_grant_can_escalate_authority
#print axioms example_delegation_rejects_escalation

end PhysicalBridges.IRA1Delegation
