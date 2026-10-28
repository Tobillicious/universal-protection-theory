import PhysicalBridges.IR109RobustObservationViability
import PhysicalBridges.IRWatchdogLatencyEffects

/-!
IR-111: precise semantic contract needed to move from a bounded
watchdog physical threshold to a viable continuing subject.
The semantic implication is explicit and NOT derived from threshold
arithmetic. This prevents conflating physical guard with X3.
-/
namespace PhysicalBridges.IR111

open IRWatchdogLatencyEffects

universe u
variable {S : Type u}

theorem guarded_window_preserves_semantically_certified_viability
    (e : Episode)
    (detectDelay fenceDelay drainDelay : Nat)
    (readout sensorError risePerTick residualEffect threshold : Nat)
    (physical : Nat → Nat)
    (continuing : Nat → Prop)
    (hTiming : TimingContract e detectDelay fenceDelay drainDelay)
    (hSensor : physical e.faultTick ≤ readout + sensorError)
    (hEnvelope : ∀ t, e.faultTick ≤ t → t ≤ e.quiescentTick →
      physical t ≤ physical e.faultTick +
        (t - e.faultTick) * risePerTick + residualEffect)
    (hMargin : readout + sensorError +
      (detectDelay + fenceDelay + drainDelay) * risePerTick +
      residualEffect ≤ threshold)
    (hSemantic : ∀ t, e.faultTick ≤ t → t ≤ e.quiescentTick →
      physical t ≤ threshold → continuing t) :
    ∀ t, e.faultTick ≤ t → t ≤ e.quiescentTick → continuing t := by
  intro t hAfter hBefore
  have hBound := guarded_reaction_window_remains_below_threshold
    e detectDelay fenceDelay drainDelay readout sensorError
    risePerTick residualEffect threshold physical
    hTiming hSensor hEnvelope hMargin t hAfter hBefore
  exact hSemantic t hAfter hBefore hBound

/-- A scalar threshold, by itself, says nothing about subject
continuation. A model can satisfy the guard while the subject ends. -/
theorem threshold_alone_does_not_entail_continuation :
    ∃ physical : Nat, ∃ continuing : Prop,
      physical ≤ 1 ∧ ¬ continuing := by
  exact ⟨0, False, by decide, id⟩

end PhysicalBridges.IR111
