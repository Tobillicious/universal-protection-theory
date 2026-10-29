import Snuffy.IRTypedTraceChecker
import Snuffy.IRStoredEnergyCommonMode

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IRControlledReentry.lean` at main `740abbb` (sha256 `34704222ce1eaeb7e77c161c2986a65666b6a4925403b5558c3dd3162ae1b4ca`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false
/-
IR-81: executable supervisor-only re-entry state machine.

A service-restoring HOLD cannot also be an absorbing state under the
FULL transition relation. We model a latched operational hold with
a separately authorized supervisory exit:
  HOLD -> DIAGNOSTIC -> RAMP -> ACTIVE
and fail closed on any failed prerequisite in the currently modeled
stage. Primary requests are DATA and do not authorize any transition.

The guards are true only when individually observed/supplied Booleans
are true. Constructing their conjunction does not establish the
existence, physical truth or independence of those inputs.

A source-level diagnostic can call the existing IR-77 executable
typed trace checker. This proves the recorded-data contract only.
No external hardware, cryptographic authentication, real metastability,
physical re-entry, historical identity or X3 continuous service is
verified by this state-machine construction.
-/

namespace PhysicalBridges.IRControlledReentry

inductive Mode
  | hold
  | diagnostic
  | ramp
  | active
deriving Repr, DecidableEq

structure Inputs where
  primaryRequest : Bool
  sidebandAuth : Bool
  epochFresh : Bool
  watchdogOK : Bool
  physicalFenceOK : Bool
  tracePass : Bool
  physicalReady : Bool
  slewReady : Bool
deriving Repr, DecidableEq

/-- Requires an independently warranted out-of-band authority AND
a fresh epoch; asserting true does not authenticate itself. -/
def startGuard (x : Inputs) : Bool :=
  x.sidebandAuth && x.epochFresh &&
    x.watchdogOK && x.physicalFenceOK

/-- Here physicalReady is an external plant correspondence contract.
IR-80 does NOT prove it just from a voltage-reference ratio or an
inductor's capacity rating. -/
def diagnosticGuard (x : Inputs) : Bool :=
  x.tracePass && x.physicalReady &&
    x.epochFresh && x.watchdogOK && x.physicalFenceOK

def rampGuard (x : Inputs) : Bool :=
  x.slewReady && x.epochFresh &&
    x.watchdogOK && x.physicalFenceOK

def activeGuard (x : Inputs) : Bool :=
  x.epochFresh && x.watchdogOK && x.physicalFenceOK

/-- Atomic in the MODEL'S transition semantics, not an assertion
of physical analog metastability exclusion. -/
def step (m : Mode) (x : Inputs) : Mode :=
  match m with
  | .hold =>
      if startGuard x then .diagnostic else .hold
  | .diagnostic =>
      if diagnosticGuard x then .ramp else .hold
  | .ramp =>
      if rampGuard x then .active else .hold
  | .active =>
      if activeGuard x then .active else .hold

def run (m : Mode) (xs : List Inputs) : Mode :=
  xs.foldl step m

theorem primary_alone_cannot_start
    (x : Inputs) (hNoAuth : x.sidebandAuth = false) :
    step .hold x = .hold := by
  simp [step, startGuard, hNoAuth]

theorem no_direct_hold_to_active (x : Inputs) :
    step .hold x ≠ .active := by
  simp [step]
  split <;> decide

theorem bad_diagnostic_returns_to_hold
    (x : Inputs) (h : x.tracePass = false) :
    step .diagnostic x = .hold := by
  simp [step, diagnosticGuard, h]

theorem physical_unready_returns_to_hold
    (x : Inputs) (h : x.physicalReady = false) :
    step .diagnostic x = .hold := by
  simp [step, diagnosticGuard, h]

theorem failed_slew_returns_to_hold
    (x : Inputs) (h : x.slewReady = false) :
    step .ramp x = .hold := by
  simp [step, rampGuard, h]

theorem stale_epoch_relocks_active
    (x : Inputs) (h : x.epochFresh = false) :
    step .active x = .hold := by
  simp [step, activeGuard, h]

theorem failed_fence_relocks_active
    (x : Inputs) (h : x.physicalFenceOK = false) :
    step .active x = .hold := by
  simp [step, activeGuard, h]

theorem failed_watchdog_relocks_active
    (x : Inputs) (h : x.watchdogOK = false) :
    step .active x = .hold := by
  simp [step, activeGuard, h]

/-- A full conditional route exists IN THE SUPERVISOR MODEL.
The good inputs must ACTUALLY be supplied as a separate liveness
obligation; this statement never invents them. -/
theorem three_authorized_phases_reach_active
    (a b c : Inputs)
    (ha : startGuard a = true)
    (hb : diagnosticGuard b = true)
    (hc : rampGuard c = true) :
    run .hold [a,b,c] = .active := by
  simp [run, List.foldl, step, ha, hb, hc]

def commandPermitted (m : Mode) (x : Inputs) : Bool :=
  decide (m = .active) &&
    IRStoredEnergyCommonMode.dualDomainPermit
      x.tracePass x.watchdogOK x.physicalFenceOK &&
    x.epochFresh

theorem non_active_mode_rejects_command
    (m : Mode) (x : Inputs) (h : m ≠ .active) :
    commandPermitted m x = false := by
  cases m <;> simp_all [commandPermitted]

theorem failed_watchdog_rejects_command
    (m : Mode) (x : Inputs) (h : x.watchdogOK = false) :
    commandPermitted m x = false := by
  simp [commandPermitted,
    IRStoredEnergyCommonMode.dualDomainPermit, h]

theorem failed_fence_rejects_command
    (m : Mode) (x : Inputs) (h : x.physicalFenceOK = false) :
    commandPermitted m x = false := by
  simp [commandPermitted,
    IRStoredEnergyCommonMode.dualDomainPermit, h]

/-- The diagnostic guard really calls the existing kernel-sound
trace checker, rather than trusting a free 'tracePass' Boolean. -/
def checkedDiagnostics
    (x : Inputs) (cfg : IRTypedTraceChecker.CheckConfig)
    (records : List IRTypedTraceChecker.TelemetryRecord) : Inputs :=
  { x with
      tracePass := IRTypedTraceChecker.verifyTraceData cfg records }

/-- A passing modeled diagnostics guard PROVES the exact RECORDED
source-level IR-77 TraceValid contract. PhysicalReady is still a
separate input, and may have a wrong truth value physically. -/
theorem accepted_diagnostics_imply_recorded_trace_valid
    (x : Inputs) (cfg : IRTypedTraceChecker.CheckConfig)
    (records : List IRTypedTraceChecker.TelemetryRecord)
    (h : diagnosticGuard (checkedDiagnostics x cfg records) = true) :
    IRTypedTraceChecker.TraceValid cfg records := by
  have ht : IRTypedTraceChecker.verifyTraceData cfg records = true := by
    cases hv : IRTypedTraceChecker.verifyTraceData cfg records with
    | false =>
        simp [diagnosticGuard, checkedDiagnostics, hv] at h
    | true => rfl
  exact IRTypedTraceChecker.verifyTraceData_sound cfg records ht

/-- Formal conjunction introduction is sound; it is NOT a theorem
that any actual sideband authorizer, sensor or physical plant
supplies the antecedents. -/
theorem start_guard_constructed_from_verified_inputs
    (x : Inputs)
    (hAuth : x.sidebandAuth = true)
    (hEpoch : x.epochFresh = true)
    (hWatch : x.watchdogOK = true)
    (hFence : x.physicalFenceOK = true) :
    startGuard x = true := by
  simp [startGuard, hAuth, hEpoch, hWatch, hFence]

theorem diagnostic_guard_constructed_from_verified_inputs
    (x : Inputs)
    (hTrace : x.tracePass = true)
    (hPhysical : x.physicalReady = true)
    (hEpoch : x.epochFresh = true)
    (hWatch : x.watchdogOK = true)
    (hFence : x.physicalFenceOK = true) :
    diagnosticGuard x = true := by
  simp [diagnosticGuard, hTrace, hPhysical, hEpoch, hWatch, hFence]

theorem ramp_guard_constructed_from_verified_inputs
    (x : Inputs)
    (hSlew : x.slewReady = true)
    (hEpoch : x.epochFresh = true)
    (hWatch : x.watchdogOK = true)
    (hFence : x.physicalFenceOK = true) :
    rampGuard x = true := by
  simp [rampGuard, hSlew, hEpoch, hWatch, hFence]

/-- A witness exists when ALL separately validated input phases
are supplied. A Bool-valued model does not certify these inputs are
physically truthful, independent or guaranteed to arrive. -/
theorem source_level_composition
    (a b c : Inputs)
    (ha : a.sidebandAuth = true)
    (hae : a.epochFresh = true)
    (haw : a.watchdogOK = true)
    (haf : a.physicalFenceOK = true)
    (hbt : b.tracePass = true)
    (hbp : b.physicalReady = true)
    (hbe : b.epochFresh = true)
    (hbw : b.watchdogOK = true)
    (hbf : b.physicalFenceOK = true)
    (hcs : c.slewReady = true)
    (hce : c.epochFresh = true)
    (hcw : c.watchdogOK = true)
    (hcf : c.physicalFenceOK = true) :
    run .hold [a,b,c] = .active := by
  apply three_authorized_phases_reach_active
  · exact start_guard_constructed_from_verified_inputs a
      ha hae haw haf
  · exact diagnostic_guard_constructed_from_verified_inputs b
      hbt hbp hbe hbw hbf
  · exact ramp_guard_constructed_from_verified_inputs c
      hcs hce hcw hcf

/-- Authenticated recovery cannot be guaranteed from 'finite-time
logic' alone; without externally authenticated authorization a
locked model stays locked through any finite input stream. -/
theorem no_external_auth_stays_in_hold
    (xs : List Inputs)
    (h : ∀ x, x ∈ xs → x.sidebandAuth = false) :
    run .hold xs = .hold := by
  induction xs with
  | nil => rfl
  | cons a rest ih =>
      have hA : a.sidebandAuth = false := h a (by simp)
      have hRest : ∀ x, x ∈ rest → x.sidebandAuth = false := by
        intro x hx
        exact h x (by simp [hx])
      change run (step .hold a) rest = .hold
      rw [primary_alone_cannot_start a hA]
      exact ih hRest

def exampleGood : Inputs :=
  ⟨false,true,true,true,true,true,true,true⟩

theorem example_reentry :
    run .hold [exampleGood,exampleGood,exampleGood] = .active := by
  decide

/-- Boolean operational-mode recovery is not positive service.
A model can allow the recovery path but define NO delivered service. -/
def actuallyDelivered (_m : Mode) : Bool := false

theorem reentry_is_not_itself_a_service_proof :
    run .hold [exampleGood,exampleGood,exampleGood] = .active ∧
      actuallyDelivered
        (run .hold [exampleGood,exampleGood,exampleGood]) = false := by
  decide

/-- A passing modeled 'physicalReady' input can conceal an actually
unready plant if the external physical correspondence is absent. -/
theorem model_accepted_physical_flag_without_real_plant_refinement :
    ∃ realPhysicalReady : Bool,
      diagnosticGuard exampleGood = true ∧
      realPhysicalReady = false := by
  exact ⟨false, by decide, rfl⟩


end PhysicalBridges.IRControlledReentry
