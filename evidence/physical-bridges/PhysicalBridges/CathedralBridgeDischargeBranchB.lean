import PhysicalBridges.IRWatchdogLatencyEffects
import PhysicalBridges.CathedralFirstEventForcing

/-!
# Bridge discharge, increment 2 — Branch B (detection latency) from the source

**4 November 2026 · noncanonical · reuse/wiring only · no canon edit.**

The forcing certificate's `intercepted` branch carries two obligations:

* `detectionBeforeDeadline` : `detectionLatency < irreversibleDeadline`;
* `timelyInterlockStable`   : an intercepted step, detected in time, is physically stable.

This increment discharges BOTH from the **already-formalised** Branch-B machinery
in `IRWatchdogLatencyEffects` — the first-harm audit's Branch B ("a nonzero syndrome
fires within the detection latency; the accepted latency budget contains the effect
before `r_critical`"). It does not re-derive anything: it reuses
`guarded_reaction_window_remains_below_threshold`.

**Circularity guard (first-harm audit §).** The latency budget itself — the
`TimingContract` delays and the safety-margin inequality — is a set of MEASURED
instrument facts (the #227/#229 ledger rows: sensor error, detect/fence/drain
delays, rise rate, threshold). Per the guard these stay *measured*, never
stipulated. So `detectionBeforeDeadline` is carried as the measured budget fact
`budgetMet`, exactly as the audit requires; the SUBSTANTIVE, derived result is
`timelyInterlockStable` — stability across the whole window — proved from the
measured budget by the existing guarded-window theorem.
-/

namespace PhysicalBridges.CathedralBridgeDischargeBranchB

open PhysicalBridges.IRWatchdogLatencyEffects

/-- A measured Branch-B instrument witness for one intercepted step: an episode
with its latency budget, the sensor-at-fault reading, the physical rise envelope,
the safety-margin inequality, and the measured budget-vs-irreversible-window fact.
Every field is an independently measured instrument fact, not a definition of
admissibility. -/
structure BranchBWitness where
  e : Episode
  detectDelay : Nat
  fenceDelay : Nat
  drainDelay : Nat
  readout : Nat
  sensorError : Nat
  risePerTick : Nat
  residualEffect : Nat
  threshold : Nat
  physical : Nat → Nat
  irreversibleWindow : Nat
  timing : TimingContract e detectDelay fenceDelay drainDelay
  sensorAtFault : physical e.faultTick ≤ readout + sensorError
  envelope : ∀ t, e.faultTick ≤ t → t ≤ e.quiescentTick →
    physical t ≤ physical e.faultTick + (t - e.faultTick) * risePerTick + residualEffect
  safetyMargin :
    readout + sensorError +
      (detectDelay + fenceDelay + drainDelay) * risePerTick + residualEffect ≤ threshold
  budgetMet : detectDelay + fenceDelay + drainDelay < irreversibleWindow

/-- **`detectionBeforeDeadline` discharged (as a measured fact).** The total certified
response latency is strictly below the irreversible window. Per the circularity guard
this budget is a measured input, not a derived one. -/
theorem branchB_detection_before_deadline (w : BranchBWitness) :
    w.detectDelay + w.fenceDelay + w.drainDelay < w.irreversibleWindow :=
  w.budgetMet

/-- **`timelyInterlockStable` discharged (derived).** Throughout the entire reaction
window the physical effect stays below the irreversible threshold — physical
stability of the intercepted step — by the existing guarded-window theorem. This is
the substantive content of Branch B. -/
theorem branchB_timely_interlock_stable (w : BranchBWitness) :
    ∀ t, w.e.faultTick ≤ t → t ≤ w.e.quiescentTick → w.physical t ≤ w.threshold :=
  guarded_reaction_window_remains_below_threshold
    w.e w.detectDelay w.fenceDelay w.drainDelay
    w.readout w.sensorError w.risePerTick w.residualEffect w.threshold
    w.physical w.timing w.sensorAtFault w.envelope w.safetyMargin

/-- Positive witness that Branch B is instantiable (the budget can be met and the
window genuinely covered): a concrete episode whose effect provably stays bounded. -/
theorem branchB_is_instantiable :
    ∃ w : BranchBWitness, w.detectDelay + w.fenceDelay + w.drainDelay < w.irreversibleWindow := by
  refine ⟨{
    e := { faultTick := 0, detectedTick := 1, fencedTick := 2, quiescentTick := 3 }
    detectDelay := 1, fenceDelay := 1, drainDelay := 1
    readout := 0, sensorError := 0, risePerTick := 0, residualEffect := 0
    threshold := 0, physical := fun _ => 0, irreversibleWindow := 10
    timing := by unfold TimingContract; decide
    sensorAtFault := by decide
    envelope := by intro t _ _; simp
    safetyMargin := by decide
    budgetMet := by decide }, ?_⟩
  decide

#print axioms branchB_detection_before_deadline
#print axioms branchB_timely_interlock_stable
#print axioms branchB_is_instantiable

end PhysicalBridges.CathedralBridgeDischargeBranchB
