import Snuffy.IRInFlightQuiescence
import Snuffy.IRJsonTraceChecker

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IRWatchdogLatencyEffects.lean` at main `740abbb` (sha256 `c08f46736e66366a211f7b33454ddc1bd048c6417d9a689a7f941e406c2fcad2`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false
/-
IR-79 — Source-level watchdog timing, effect backlog, and X3 limits.

Not an 'axiom of instant safe hold'. We separate detection, fenced
actuation and residual quiescence latencies and PROVE an additive
total bound. We additionally prove a threshold invariant over the
entire bounded response window from independent sensor, plant-rate,
residual-effect and guard-margin hypotheses.

Under complete no-bypass mediation, an explicitly gated command
cannot apply when disabled; a single bypass defeats that claim.
Physical complete mediation itself is NOT proved by the algebra.

A quiescence certificate from the preexisting IR-32 source yields
physical modeled effect finality even after in-flight backlog drain.
An abstract permanently absorbing hold cannot satisfy a positive
service request, countering the idea that permanent shutdown alone
establishes original X3 continuing autonomy.

Physical faults might themselves already violate the safety threshold;
IR-79 does NOT retroactively prevent the originating fault. Nor does
correct finite telemetry prove hardware watchdog reaction timing.
-/

namespace PhysicalBridges.IRWatchdogLatencyEffects

/-- Four actual semantic phases; each adjacent bound must be supported
by a separate real implementation proof or measurement. -/
structure Episode where
  faultTick : Nat
  detectedTick : Nat
  fencedTick : Nat
  quiescentTick : Nat
deriving Repr, DecidableEq

/-- Detection bound, actual final-effect fence bound, and complete
physical quiescence bound are deliberately separate warranties.
The order of events is part of the contract. -/
def TimingContract (e : Episode)
    (detectDelay fenceDelay drainDelay : Nat) : Prop :=
  e.faultTick ≤ e.detectedTick ∧
  e.detectedTick ≤ e.faultTick + detectDelay ∧
  e.detectedTick ≤ e.fencedTick ∧
  e.fencedTick ≤ e.detectedTick + fenceDelay ∧
  e.fencedTick ≤ e.quiescentTick ∧
  e.quiescentTick ≤ e.fencedTick + drainDelay

/-- The first noncircular arithmetic join: combine THREE source
latency bounds into a bound on total response. The latency premises
do not claim physical zero loss or a safe state before the end. -/
theorem additive_fault_to_quiescence_bound
    (e : Episode) (detectDelay fenceDelay drainDelay : Nat)
    (h : TimingContract e detectDelay fenceDelay drainDelay) :
    e.quiescentTick ≤
      e.faultTick + detectDelay + fenceDelay + drainDelay := by
  rcases h with ⟨_, hDetected, _, hFenced, _, hQuiescent⟩
  omega

/-- Every discrete timestamp in the reaction window has age at most
the total certified delay. -/
theorem window_age_bounded
    (e : Episode) (detectDelay fenceDelay drainDelay t : Nat)
    (h : TimingContract e detectDelay fenceDelay drainDelay)
    (hAfter : e.faultTick ≤ t)
    (hBefore : t ≤ e.quiescentTick) :
    t - e.faultTick ≤ detectDelay + fenceDelay + drainDelay := by
  have hFinal :=
    additive_fault_to_quiescence_bound e
      detectDelay fenceDelay drainDelay h
  omega

/-- This is the substantial effect-bound join. The physical
envelope must include all admitted external disturbances, effects
in flight, passive energy release and latent stored energy.
'residualEffect' is a bound on TOTAL unmodeled-or-pending increase,
not just instantaneous new command output.

Proof conclusion applies to the threshold named here; if the
initial fault ALREADY violates it, its hypotheses cannot be met.
-/
theorem guarded_reaction_window_remains_below_threshold
    (e : Episode) (detectDelay fenceDelay drainDelay : Nat)
    (readout sensorError risePerTick residualEffect threshold : Nat)
    (physical : Nat → Nat)
    (hTiming : TimingContract e detectDelay fenceDelay drainDelay)
    (hSensorAtFault :
      physical e.faultTick ≤ readout + sensorError)
    (hCompletePhysicalEnvelope :
      ∀ t, e.faultTick ≤ t → t ≤ e.quiescentTick →
        physical t ≤ physical e.faultTick +
          (t - e.faultTick) * risePerTick + residualEffect)
    (hSafetyMargin :
      readout + sensorError +
        (detectDelay + fenceDelay + drainDelay) * risePerTick +
        residualEffect ≤ threshold) :
    ∀ t, e.faultTick ≤ t → t ≤ e.quiescentTick →
      physical t ≤ threshold := by
  intro t hAfter hBefore
  have hAge :=
    window_age_bounded e detectDelay fenceDelay drainDelay t
      hTiming hAfter hBefore
  have hSlope :=
    Nat.mul_le_mul_right risePerTick hAge
  have hPlant :=
    hCompletePhysicalEnvelope t hAfter hBefore
  omega

/-- To certify the exact physical state at quiescence, instantiate
the stronger window theorem at its endpoint. -/
theorem guarded_quiescence_endpoint_safe
    (e : Episode) (detectDelay fenceDelay drainDelay : Nat)
    (readout sensorError risePerTick residualEffect threshold : Nat)
    (physical : Nat → Nat)
    (hTiming : TimingContract e detectDelay fenceDelay drainDelay)
    (hSensorAtFault :
      physical e.faultTick ≤ readout + sensorError)
    (hCompletePhysicalEnvelope :
      ∀ t, e.faultTick ≤ t → t ≤ e.quiescentTick →
        physical t ≤ physical e.faultTick +
          (t - e.faultTick) * risePerTick + residualEffect)
    (hSafetyMargin :
      readout + sensorError +
        (detectDelay + fenceDelay + drainDelay) * risePerTick +
        residualEffect ≤ threshold) :
    physical e.quiescentTick ≤ threshold := by
  have hWindow :=
    guarded_reaction_window_remains_below_threshold e
      detectDelay fenceDelay drainDelay readout sensorError
      risePerTick residualEffect threshold physical
      hTiming hSensorAtFault hCompletePhysicalEnvelope hSafetyMargin
  have hStart : e.faultTick ≤ e.quiescentTick := by
    rcases hTiming with ⟨hFaultDetect, _, hDetectFence, _, hFenceQuiet, _⟩
    omega
  exact hWindow e.quiescentTick hStart (Nat.le_refl _)

/-- Gated command is a property of a CONCRETE modeled effect path,
not of all physical actions. A physically independent bypass adds
its effect even if the logical command gate rejects. -/
def actualEffect (enabled : Bool) (requested bypass : Nat) : Nat :=
  (if enabled then requested else 0) + bypass

theorem disabled_complete_mediation_blocks_modeled_effect
    (requested bypass : Nat) (hNoBypass : bypass = 0) :
    actualEffect false requested bypass = 0 := by
  simp [actualEffect, hNoBypass]

theorem independent_bypass_defeats_disabled_gate :
    actualEffect false 7 1 = 1 := by
  decide

/-- A complete IR-32 quiescence certificate shows that no modeled
backlogged effects land under ANY finite subsequent interleaving.
It cannot be invoked merely from a signal that the gate disabled. -/
theorem fenced_and_drained_pipeline_stops_modeled_effects
    (s : IRInFlightQuiescence.Pipeline)
    (generation : Nat) (ops : List IRInFlightQuiescence.Cmd)
    (hInFlight : s.inFlight = [])
    (hPending : s.pending = []) :
    (IRInFlightQuiescence.run
      (IRInFlightQuiescence.close s generation) ops).landed =
      s.landed := by
  exact (IRInFlightQuiescence.barrier_holds_under_any_finite_interleaving
    ops (IRInFlightQuiescence.close s generation)
    (IRInFlightQuiescence.close_fully_drained_is_quiescent
      s generation hInFlight hPending)).2

/-- Fast shutdown can follow an ALREADY VIOLATED physical threshold;
a bound on RESPONSE DELAY alone cannot make the preceding fault
unhappen. -/
def transient (t : Nat) : Nat := if t = 1 then 3 else 0

theorem fast_shutdown_does_not_erase_prior_breach :
    transient 2 = 0 ∧ ¬ (∀ t, t ≤ 2 → transient t ≤ 1) := by
  constructor
  · decide
  · intro h
    have hBad := h 1 (by omega)
    simp [transient] at hBad

/-- An 'absorbing hold' with no service effect may be formally safe
yet unable to meet the mandatory positive service obligation in X3.
Here true means frozen in hold and cannot generate any service.
This is a structural counterexample, not a conclusion about all
possible protection architectures. -/
def absorbingHold (_action : Bool) (_disturbance : Bool) : Bool := true

def afterHold (_stream : Nat → Bool) : Nat → Bool :=
  fun _ => true

def deliversService (held : Bool) : Bool := !held

theorem absorbing_no_service_counterexample :
    (∀ action disturbance, absorbingHold action disturbance = true) ∧
    ¬ (∃ t, deliversService (afterHold (fun _ => false) t) = true) := by
  constructor
  · intro action disturbance
    rfl
  · intro h
    obtain ⟨t,ht⟩ := h
    have hNo : deliversService (afterHold (fun _ => false) t) = false := by
      rfl
    rw [hNo] at ht
    cases ht

/-- A HOLD command that actually installs all the above conditions
is a separate external proof obligation. No finite log pass can
establish an arbitrary future physical disturbance-free hold. -/
theorem valid_logged_trace_can_coexist_with_unmodeled_physical_breach :
    ∃ actualImpact : Nat,
      IRTypedTraceChecker.verifyTraceData
        IRTypedTraceChecker.testConfig
        IRTypedTraceChecker.sampleTrace = true ∧
      1 < actualImpact := by
  refine ⟨2, IRTypedTraceChecker.accepted_example_is_computable, ?_⟩
  decide


end PhysicalBridges.IRWatchdogLatencyEffects
