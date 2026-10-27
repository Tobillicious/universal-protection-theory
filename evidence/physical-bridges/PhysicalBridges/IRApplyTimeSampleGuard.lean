/-
IR-54: couple stale-sensor physical age with the ACTUAL final effect
boundary. The elapsed interval from trusted sample to actuation must
be accounted for in the post-effect guard; check-time freshness alone
does not establish application-time safety.
-/
import PhysicalBridges.IRStaleReadingAge
import PhysicalBridges.IRPhysicalGuard

namespace PhysicalBridges.IRApplyTimeSampleGuard

/-- The physical state at time of application remains within the
sensor readout's uncertainty plus the worst allowed time since the
last actually authenticated reading. -/
theorem apply_time_physical_state_bound
    (physical : Nat → Nat)
    (taken : Nat → Prop) (lastSample : Nat → Nat)
    (maxAge maxRisePerTick epsilon : Nat)
    (readout : Nat → Nat)
    (hRecent : IRStaleReadingAge.RecentReading
      taken lastSample maxAge)
    (hRise : IRStaleReadingAge.SinceLastSampleRise
      physical lastSample maxRisePerTick)
    (hSensor : ∀ s, taken s →
      physical s ≤ readout s + epsilon) :
    ∀ applyTime, physical applyTime ≤
      readout (lastSample applyTime) +
      epsilon + maxAge * maxRisePerTick := by
  intro applyTime
  obtain ⟨hTaken, _, hAge⟩ := hRecent applyTime
  have hPhysical := hRise applyTime
  have hReading := hSensor (lastSample applyTime) hTaken
  have hBound :
      (applyTime - lastSample applyTime) * maxRisePerTick ≤
      maxAge * maxRisePerTick :=
    Nat.mul_le_mul_right maxRisePerTick hAge
  omega

/-- Actual post-effect safety at the final physically consequential
operation. In this theorem maxAge covers the *application time*, not
merely the earlier permission decision. -/
theorem last_moment_guard_includes_sensor_age_and_effect
    (physical : Nat → Nat) (readout : Nat → Nat)
    (taken : Nat → Prop) (lastSample : Nat → Nat)
    (applyTime postEffect : Nat)
    (maxAge maxRisePerTick epsilon maxEffect threshold : Nat)
    (hRecent : IRStaleReadingAge.RecentReading
      taken lastSample maxAge)
    (hRise : IRStaleReadingAge.SinceLastSampleRise
      physical lastSample maxRisePerTick)
    (hSensor : ∀ s, taken s →
      physical s ≤ readout s + epsilon)
    (hActualEffect : postEffect ≤ physical applyTime + maxEffect)
    (hGate : readout (lastSample applyTime) +
      epsilon + maxAge * maxRisePerTick + maxEffect ≤ threshold) :
    postEffect ≤ threshold := by
  have hCurrent := apply_time_physical_state_bound
    physical taken lastSample maxAge maxRisePerTick epsilon
    readout hRecent hRise hSensor applyTime
  have hSample := hSensor (lastSample applyTime) (hRecent applyTime).1
  have hRawRise := hRise applyTime
  have hAge := (hRecent applyTime).2.2
  have hBoundRise :
      (applyTime - lastSample applyTime) * maxRisePerTick ≤
        maxAge * maxRisePerTick :=
    Nat.mul_le_mul_right maxRisePerTick hAge
  have hEvolution : postEffect ≤
      physical (lastSample applyTime) +
        maxAge * maxRisePerTick + maxEffect := by omega
  exact IRPhysicalGuard.post_effect_guard_sound
    (readout (lastSample applyTime)) epsilon
    (maxAge * maxRisePerTick) maxEffect threshold
    (physical (lastSample applyTime)) postEffect
    hSample hEvolution hGate

/-- The guard may have been correct at the old sample time, but an
unaccounted physical delay permits an unsafe later effect. -/
theorem decision_time_only_check_can_land_unsafe_effect :
    ∃ decisionRead effect threshold currentAtApply after : Nat,
      decisionRead + effect ≤ threshold ∧
      currentAtApply ≤ after ∧
      after ≤ currentAtApply + effect ∧
      ¬ after ≤ threshold := by
  refine ⟨0, 1, 1, 2, 3, ?_, ?_, ?_, ?_⟩ <;> decide

/-- If the physical upper bound is never measured for the interval
after the last observation, the post-effect theorem is not justified
by sensor agreement at the earlier timestamp. -/
theorem stale_observation_and_late_effect_counterexample :
    ∃ physical : Nat → Nat,
      physical 0 = 0 ∧ physical 2 = 2 ∧
      ¬ (physical 2 + 1 ≤ 1) := by
  refine ⟨fun t => t, rfl, rfl, ?_⟩
  decide

#print axioms apply_time_physical_state_bound
#print axioms last_moment_guard_includes_sensor_age_and_effect
#print axioms decision_time_only_check_can_land_unsafe_effect
#print axioms stale_observation_and_late_effect_counterexample
end PhysicalBridges.IRApplyTimeSampleGuard
