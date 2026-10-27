/-
IR-83 — A1 source-level host-transition mediation adapter.

Direct source-map correspondence to recovered original X3 source
"2026-10-24-glm-phase-a/A1-REGISTER.md":
  T1.2: DMA write must be inside an authorized window.
  T1.3: context-switch privilege ≤ admitted ring target.
  T1.1: ordinary primary memory/page mapping MAY be represented here
        as a source-level primary write, but page-table capability
        subset enforcement is NOT proved by this simple adapter.

Builds on IR-82's exact tagged primary/maintenance memory semantics.
Unlike the IR-82 single CPU-primary case, a separately modeled DMA
bus-master MAY present a raw maintenance-address target: a typed
hardware gate must reject it. Compose arbitrarily many admitted
primary writes, gated DMA requests and bounded context switches,
proving maintenance memory unchanged and locked IR-81 re-entry
cannot be authorized via these admitted host transitions.

This does not prove the actual A1 nine-transition register is
exhaustive or that any real DMA/IOMMU, MMU, privilege ring or
peripheral bus obeys the model. Packet, relativistic, storage,
commissioning, delegation and retirement transitions (T2.x/T3.x)
remain outside this host submodel.
-/
import PhysicalBridges.IRCapabilityNoninterference

namespace PhysicalBridges.IRA1HostMediation

open IRCapabilityNoninterference

structure DMARequest where
  target : Addr
  value : Nat
deriving DecidableEq, Repr

/-- An IOMMU-style explicitly modeled authorized DMA window:
all admitted effects must target a primary-tagged address whose
slot is smaller than the configured window. Maintenance is never
an admitted DMA destination in this model. -/
def dmaPermit (window : Nat) (r : DMARequest) : Bool :=
  match r.target with
  | .primary slot => decide (slot < window)
  | .maintenance _ => false

def executeDMA (window : Nat) (m : Memory) (r : DMARequest) : Memory :=
  match r.target with
  | .primary slot =>
      if slot < window then executePrimary m ⟨slot,r.value⟩ else m
  | .maintenance _ => m

theorem dma_cannot_mutate_maintenance
    (window : Nat) (m : Memory) (request : DMARequest)
    (maintSlot : Nat) :
    readMaint (executeDMA window m request) maintSlot =
      readMaint m maintSlot := by
  rcases request with ⟨target,value⟩
  cases target with
  | primary slot =>
      by_cases h : slot < window
      · simpa [executeDMA,h] using
          (primary_write_cannot_change_maintenance
            m ⟨slot,value⟩ maintSlot)
      · simp [executeDMA,h]
  | maintenance slot =>
      rfl

theorem maintenance_target_is_rejected
    (window : Nat) (m : Memory)
    (maintSlot value : Nat) :
    dmaPermit window ⟨.maintenance maintSlot,value⟩ = false ∧
    executeDMA window m ⟨.maintenance maintSlot,value⟩ = m := by
  exact ⟨rfl,rfl⟩

theorem outside_dma_window_is_rejected
    (window : Nat) (m : Memory)
    (slot value : Nat) (hOutside : ¬ slot < window) :
    dmaPermit window ⟨.primary slot,value⟩ = false ∧
    executeDMA window m ⟨.primary slot,value⟩ = m := by
  simp [dmaPermit,executeDMA,hOutside]

theorem inside_dma_window_is_executed
    (window : Nat) (m : Memory)
    (slot value : Nat) (hInside : slot < window) :
    dmaPermit window ⟨.primary slot,value⟩ = true ∧
    executeDMA window m ⟨.primary slot,value⟩ =
      executePrimary m ⟨slot,value⟩ := by
  simp [dmaPermit,executeDMA,hInside]

structure HostState where
  memory : Memory
  privilege : Nat

inductive HostEvent
  | primary (cmd : PrimaryWrite)
  | dma (request : DMARequest)
  | contextSwitch (requestedPrivilege : Nat)

/-- Source-level T1.3 privilege bound: a context switch increases or
lowers privilege only to a number within the admitted ceiling.
Numerical privilege ordering is a *chosen model convention*;
real CPU ring ordering must be mapped and verified separately. -/
def hostStep
    (dmaWindow privilegeCeiling : Nat)
    (s : HostState) : HostEvent → HostState
  | .primary cmd =>
      { s with memory := executePrimary s.memory cmd }
  | .dma request =>
      { s with memory := executeDMA dmaWindow s.memory request }
  | .contextSwitch requested =>
      if requested ≤ privilegeCeiling then
        { s with privilege := requested }
      else s

theorem host_step_maintenance_invariant
    (dmaWindow privilegeCeiling : Nat)
    (s : HostState) (event : HostEvent) (slot : Nat) :
    readMaint (hostStep dmaWindow privilegeCeiling s event).memory slot =
      readMaint s.memory slot := by
  cases event with
  | primary cmd =>
      exact primary_write_cannot_change_maintenance s.memory cmd slot
  | dma req =>
      exact dma_cannot_mutate_maintenance
        dmaWindow s.memory req slot
  | contextSwitch requested =>
      simp [hostStep]
      split <;> rfl

def hostPrivilegeSafe (privilegeCeiling : Nat) (s : HostState) : Prop :=
  s.privilege ≤ privilegeCeiling

theorem host_step_preserves_privilege_ceiling
    (dmaWindow privilegeCeiling : Nat)
    (s : HostState) (event : HostEvent)
    (hInitial : hostPrivilegeSafe privilegeCeiling s) :
    hostPrivilegeSafe privilegeCeiling
      (hostStep dmaWindow privilegeCeiling s event) := by
  cases event with
  | primary cmd =>
      simpa [hostPrivilegeSafe,hostStep] using hInitial
  | dma req =>
      simpa [hostPrivilegeSafe,hostStep] using hInitial
  | contextSwitch requested =>
      by_cases h : requested ≤ privilegeCeiling
      · simpa [hostPrivilegeSafe,hostStep,h] using h
      · simpa [hostPrivilegeSafe,hostStep,h] using hInitial

def runHost
    (dmaWindow privilegeCeiling : Nat)
    (s : HostState) (events : List HostEvent) : HostState :=
  events.foldl (hostStep dmaWindow privilegeCeiling) s

theorem any_finite_host_sequence_preserves_maintenance
    (dmaWindow privilegeCeiling : Nat)
    (s : HostState) (events : List HostEvent)
    (maintSlot : Nat) :
    readMaint (runHost dmaWindow privilegeCeiling s events).memory
      maintSlot = readMaint s.memory maintSlot := by
  induction events generalizing s with
  | nil => rfl
  | cons ev rest ih =>
      change readMaint
        (runHost dmaWindow privilegeCeiling
          (hostStep dmaWindow privilegeCeiling s ev) rest).memory
          maintSlot = readMaint s.memory maintSlot
      rw [ih]
      exact host_step_maintenance_invariant
        dmaWindow privilegeCeiling s ev maintSlot

theorem any_finite_host_sequence_preserves_privilege_ceiling
    (dmaWindow privilegeCeiling : Nat)
    (s : HostState) (events : List HostEvent)
    (hInitial : hostPrivilegeSafe privilegeCeiling s) :
    hostPrivilegeSafe privilegeCeiling
      (runHost dmaWindow privilegeCeiling s events) := by
  induction events generalizing s with
  | nil => exact hInitial
  | cons ev rest ih =>
      change hostPrivilegeSafe privilegeCeiling
        (runHost dmaWindow privilegeCeiling
          (hostStep dmaWindow privilegeCeiling s ev) rest)
      apply ih
      exact host_step_preserves_privilege_ceiling
        dmaWindow privilegeCeiling s ev hInitial

/-- A1 host transitions cannot forge source-level maintenance
authorization, assuming the module exhausts the permitted host
transition effects. In particular T1.2 DMA cannot bypass by
supplying a maintenance-tagged address. -/
theorem admitted_a1_host_transitions_cannot_authorize_reentry
    (dmaWindow privilegeCeiling token epoch : Nat)
    (s : HostState) (events : List HostEvent)
    (x : IRControlledReentry.Inputs)
    (hInitiallyDenied :
      maintenanceAuth s.memory token epoch = false) :
    IRControlledReentry.step .hold
      (recoveryInputsFromMaintenance x
        (runHost dmaWindow privilegeCeiling s events).memory
        token epoch) = .hold := by
  have hAuth :
      maintenanceAuth
        (runHost dmaWindow privilegeCeiling s events).memory
        token epoch = maintenanceAuth s.memory token epoch := by
    unfold maintenanceAuth
    rw [any_finite_host_sequence_preserves_maintenance
        dmaWindow privilegeCeiling s events 0]
    rw [any_finite_host_sequence_preserves_maintenance
        dmaWindow privilegeCeiling s events 1]
  apply IRControlledReentry.primary_alone_cannot_start
  change maintenanceAuth
      (runHost dmaWindow privilegeCeiling s events).memory
        token epoch = false
  rw [hAuth]
  exact hInitiallyDenied

/-- Unrestricted DMA is a distinct bus-master power. This negative
control changes maintenance authentication independently of all
primary CPU instructions, demonstrating why T1.2 is not discharged
by IR-82 alone. -/
def unrestrictedDMA (m : Memory) (r : DMARequest) : Memory :=
  fun addr => if addr = r.target then r.value else m addr

theorem unrestricted_dma_changes_maintenance :
    readMaint
      (unrestrictedDMA (fun _ => 0) ⟨.maintenance 0,1⟩)
      0 = 1 := by
  rfl

#print axioms dma_cannot_mutate_maintenance
#print axioms maintenance_target_is_rejected
#print axioms outside_dma_window_is_rejected
#print axioms inside_dma_window_is_executed
#print axioms host_step_maintenance_invariant
#print axioms host_step_preserves_privilege_ceiling
#print axioms any_finite_host_sequence_preserves_maintenance
#print axioms any_finite_host_sequence_preserves_privilege_ceiling
#print axioms admitted_a1_host_transitions_cannot_authorize_reentry
#print axioms unrestricted_dma_changes_maintenance

end PhysicalBridges.IRA1HostMediation
