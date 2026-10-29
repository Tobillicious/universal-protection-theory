import Snuffy.IRWatchdogLatencyEffects
import Snuffy.IR108ObservationObstruction

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IR110WatchdogRobustObservation.lean` at main `740abbb` (sha256 `3507dc102cd4738104dc8e8f2664c3b9a6cc62d70a4a7c1c77259147b7d8905e`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false

/-!
IR-110: observation-class robust safety margin from IR-79's
bounded reaction-window theorem. A common observation must have
uniform sensor and plant-envelope certificates across its states.
This does not establish that a particular real sensor supplies them.
-/
namespace PhysicalBridges.IR110

open IRWatchdogLatencyEffects

universe u
variable {S : Type u}

theorem robust_window_from_shared_readout
    (observe : S → Nat)
    (episode : S → Episode)
    (physical : S → Nat → Nat)
    (detectDelay fenceDelay drainDelay sensorError risePerTick
      residualEffect threshold : Nat)
    (o : Nat)
    (hTiming : ∀ s, observe s = o →
      TimingContract (episode s) detectDelay fenceDelay drainDelay)
    (hSensor : ∀ s, observe s = o →
      physical s (episode s).faultTick ≤ o + sensorError)
    (hEnvelope : ∀ s, observe s = o →
      ∀ t, (episode s).faultTick ≤ t →
        t ≤ (episode s).quiescentTick →
        physical s t ≤ physical s (episode s).faultTick +
          (t - (episode s).faultTick) * risePerTick + residualEffect)
    (hMargin :
      o + sensorError +
        (detectDelay + fenceDelay + drainDelay) * risePerTick +
        residualEffect ≤ threshold) :
    ∀ s, observe s = o →
      ∀ t, (episode s).faultTick ≤ t →
        t ≤ (episode s).quiescentTick →
        physical s t ≤ threshold := by
  intro s hs t hAfter hBefore
  exact guarded_reaction_window_remains_below_threshold
    (episode s) detectDelay fenceDelay drainDelay
    o sensorError risePerTick residualEffect threshold
    (physical s)
    (hTiming s hs) (hSensor s hs) (hEnvelope s hs)
    hMargin t hAfter hBefore

end PhysicalBridges.IR110
