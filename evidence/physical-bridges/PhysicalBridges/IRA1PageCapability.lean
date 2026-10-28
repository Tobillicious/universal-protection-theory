/-
IR-84 — recovered original A1 T1.1 page-grant capability-mask closure.

Source anchor:
2026-10-24-glm-phase-a/A1-REGISTER.md
  T1.1 page mapping: newly granted capabilities subset permitted_mask.
The original A1 register leaves actual MMU, page aliases, revocations,
hardware address translation and mask integrity as plant obligations.

We prove the exact inductive source-level result, NOT merely a per-step
Boolean observation: arbitrary FINITE mixed host/DMA/context and
guarded page-grant executions preserve a fixed permitted mask, keep
all granted capabilities within it, maintain source-level privilege
ceiling and leave all maintenance registers intact, hence cannot
self-authorize an IR-81 locked supervisory re-entry.

An unguarded grant counterexample is included. The source uses a List
of abstract capabilities, not physical MMU page tables or a verified
specification of the unreduced original X3 feasible history universe.
-/
import PhysicalBridges.IRA1HostMediation

namespace PhysicalBridges.IRA1PageCapability
open IRCapabilityNoninterference
open IRA1HostMediation

structure PageState where
  host : HostState
  permittedMask : Nat → Bool
  installed : List Nat

inductive PageEvent
  | host (event : HostEvent)
  | grant (capability : Nat)

/-- A positive permission must be present in the CURRENT immutable
source-level mask at grant time. -/
def execute (window ceiling : Nat) (s : PageState) : PageEvent → PageState
  | .host event =>
      { s with host := hostStep window ceiling s.host event }
  | .grant cap =>
      if s.permittedMask cap then
        { s with installed := cap :: s.installed }
      else s

def permitted (s : PageState) : Prop :=
  ∀ cap, cap ∈ s.installed → s.permittedMask cap = true

def safe (ceiling : Nat) (s : PageState) : Prop :=
  permitted s ∧ hostPrivilegeSafe ceiling s.host

theorem execute_preserves_mask
    (window ceiling : Nat) (s : PageState) (event : PageEvent) :
    (execute window ceiling s event).permittedMask = s.permittedMask := by
  cases event with
  | host event =>
      rfl
  | grant cap =>
      simp only [execute]
      split <;> rfl

theorem rejected_grant_does_not_change_state
    (window ceiling : Nat) (s : PageState) (cap : Nat)
    (hForbidden : s.permittedMask cap = false) :
    execute window ceiling s (.grant cap) = s := by
  simp [execute, hForbidden]

theorem admitted_grant_is_permitted
    (window ceiling : Nat) (s : PageState) (cap : Nat)
    (hAllowed : s.permittedMask cap = true) :
    cap ∈ (execute window ceiling s (.grant cap)).installed := by
  simp [execute,hAllowed]

theorem execute_preserves_capability_invariant
    (window ceiling : Nat) (s : PageState) (event : PageEvent)
    (hPermitted : permitted s) :
    permitted (execute window ceiling s event) := by
  cases event with
  | host ev =>
      simpa [execute,permitted] using hPermitted
  | grant cap =>
      by_cases h : s.permittedMask cap = true
      · intro other hMember
        have hMem : other = cap ∨ other ∈ s.installed := by
          simpa [execute,h] using hMember
        cases hMem with
        | inl heq =>
            subst other
            simpa [execute,h] using h
        | inr hOld =>
            simpa [execute,h] using hPermitted other hOld
      · have hf : s.permittedMask cap = false := by
          cases hval : s.permittedMask cap <;> simp_all
        simpa [execute,hf] using hPermitted

theorem execute_preserves_maintenance
    (window ceiling : Nat) (s : PageState)
    (event : PageEvent) (maintSlot : Nat) :
    readMaint (execute window ceiling s event).host.memory maintSlot =
      readMaint s.host.memory maintSlot := by
  cases event with
  | host ev =>
      exact host_step_maintenance_invariant window ceiling
        s.host ev maintSlot
  | grant cap =>
      simp only [execute]
      split <;> rfl

theorem execute_preserves_privilege
    (window ceiling : Nat) (s : PageState)
    (event : PageEvent)
    (hInitial : hostPrivilegeSafe ceiling s.host) :
    hostPrivilegeSafe ceiling (execute window ceiling s event).host := by
  cases event with
  | host ev =>
      exact host_step_preserves_privilege_ceiling
        window ceiling s.host ev hInitial
  | grant cap =>
      simp only [execute]
      split <;> exact hInitial

theorem execute_preserves_safe
    (window ceiling : Nat) (s : PageState) (event : PageEvent)
    (h : safe ceiling s) :
    safe ceiling (execute window ceiling s event) := by
  exact ⟨execute_preserves_capability_invariant window ceiling s event h.1,
    execute_preserves_privilege window ceiling s event h.2⟩

def run (window ceiling : Nat)
    (s : PageState) (events : List PageEvent) : PageState :=
  events.foldl (execute window ceiling) s

/-- The full source-level mixed T1.1/T1.2/T1.3 induction:
every finite combination of all three modeled host classes
preserves the full page capability invariant and ring ceiling. -/
theorem all_finite_host_and_page_grants_remain_safe
    (window ceiling : Nat) (s : PageState)
    (events : List PageEvent)
    (h : safe ceiling s) :
    safe ceiling (run window ceiling s events) := by
  induction events generalizing s with
  | nil => exact h
  | cons ev rest ih =>
      change safe ceiling
        (run window ceiling (execute window ceiling s ev) rest)
      exact ih (execute_preserves_safe window ceiling s ev h)

/-- Preservation of the ENTIRE original capability permission
mask, not merely that the CURRENT installed list is admitted. -/
theorem all_finite_host_and_page_grants_preserve_mask
    (window ceiling : Nat) (s : PageState)
    (events : List PageEvent) :
    (run window ceiling s events).permittedMask = s.permittedMask := by
  induction events generalizing s with
  | nil => rfl
  | cons ev rest ih =>
      change (run window ceiling
        (execute window ceiling s ev) rest).permittedMask =
          s.permittedMask
      rw [ih]
      exact execute_preserves_mask window ceiling s ev

theorem all_finite_host_and_page_grants_preserve_maintenance
    (window ceiling : Nat) (s : PageState)
    (events : List PageEvent) (maintSlot : Nat) :
    readMaint (run window ceiling s events).host.memory maintSlot =
      readMaint s.host.memory maintSlot := by
  induction events generalizing s with
  | nil => rfl
  | cons ev rest ih =>
      change readMaint
        (run window ceiling (execute window ceiling s ev) rest).host.memory
          maintSlot = readMaint s.host.memory maintSlot
      rw [ih]
      exact execute_preserves_maintenance
        window ceiling s ev maintSlot

theorem t11_t12_t13_host_traces_cannot_forge_reentry
    (window ceiling token epoch : Nat)
    (s : PageState) (events : List PageEvent)
    (x : IRControlledReentry.Inputs)
    (hInitiallyDenied :
      maintenanceAuth s.host.memory token epoch = false) :
    IRControlledReentry.step .hold
      (recoveryInputsFromMaintenance x
        (run window ceiling s events).host.memory
        token epoch) = .hold := by
  have hAuth :
      maintenanceAuth
        (run window ceiling s events).host.memory
        token epoch = maintenanceAuth s.host.memory token epoch := by
    unfold maintenanceAuth
    rw [all_finite_host_and_page_grants_preserve_maintenance
      window ceiling s events 0]
    rw [all_finite_host_and_page_grants_preserve_maintenance
      window ceiling s events 1]
  apply IRControlledReentry.primary_alone_cannot_start
  change maintenanceAuth
      (run window ceiling s events).host.memory token epoch = false
  rw [hAuth]
  exact hInitiallyDenied

/-- Explicit failure if the capability-mask check is omitted.
A newly installed capability that is false in permittedMask defeats
the closure, even with no DMA and no privilege escalation. -/
def unsafeGrant (s : PageState) (cap : Nat) : PageState :=
  { s with installed := cap :: s.installed }

theorem unguarded_page_grant_breaks_capability_invariant :
    ∃ s : PageState, permitted s ∧
      ¬ permitted (unsafeGrant s 7) := by
  let s : PageState := {
    host := { memory := fun _ => 0, privilege := 0 },
    permittedMask := fun _ => false,
    installed := [] }
  refine ⟨s, ?_, ?_⟩
  · intro cap hMem
    cases hMem
  · intro h
    have h7 := h 7 (by simp [unsafeGrant])
    simp [s, unsafeGrant] at h7

#print axioms execute_preserves_mask
#print axioms rejected_grant_does_not_change_state
#print axioms admitted_grant_is_permitted
#print axioms execute_preserves_capability_invariant
#print axioms execute_preserves_maintenance
#print axioms execute_preserves_privilege
#print axioms all_finite_host_and_page_grants_remain_safe
#print axioms all_finite_host_and_page_grants_preserve_mask
#print axioms all_finite_host_and_page_grants_preserve_maintenance
#print axioms t11_t12_t13_host_traces_cannot_forge_reentry
#print axioms unguarded_page_grant_breaks_capability_invariant

end PhysicalBridges.IRA1PageCapability
