/-
IR-52: bound UNSAMPLED physical values from a sampled trajectory only
with a correctly established within-interval rate envelope. A sensor
sample schedule alone cannot rule out transient dangerous excursions.
Nat time and slope are exact abstract quantities; real hardware
calibration and continuous-time correspondence remain open.
-/
import PhysicalBridges.IRMicrostepInvariant

namespace PhysicalBridges.IRInterSampleEnvelope

/-- Bounded physical rise within each fixed sampling interval.
This is a strong PHYSICAL correspondence premise; it cannot be
derived merely by collecting an endpoint sample. -/
def WithinSampleRate (physical : Nat → Nat)
    (period maxRisePerTick : Nat) : Prop :=
  ∀ k offset, offset < period →
    physical (k * period + offset) ≤
      physical (k * period) + offset * maxRisePerTick

/-- A conservative sampling guard that reserves an entire interval's
worst-case upward excursion. -/
def EverySampleGuarded (physical : Nat → Nat)
    (period maxRisePerTick threshold : Nat) : Prop :=
  ∀ k, physical (k * period) + period * maxRisePerTick ≤ threshold

/-- Uniform safety for EVERY Nat-valued instant, including times that
were never sampled, conditional on an actual verified rise bound.
This is the discrete-time analog of a physical interpolation certificate. -/
theorem every_unsampled_instant_safe
    (physical : Nat → Nat)
    (period maxRisePerTick threshold : Nat)
    (hPeriod : 0 < period)
    (hRate : WithinSampleRate physical period maxRisePerTick)
    (hGuard : EverySampleGuarded physical period
      maxRisePerTick threshold) :
    ∀ t : Nat, physical t ≤ threshold := by
  intro t
  have hOffset : t % period < period := Nat.mod_lt t hPeriod
  have hDecomp : (t / period) * period + (t % period) = t := by
    simpa [Nat.mul_comm, Nat.add_comm] using (Nat.mod_add_div t period)
  have hBound := hRate (t / period) (t % period) hOffset
  have hSample := hGuard (t / period)
  have hIncrease :
      (t % period) * maxRisePerTick ≤ period * maxRisePerTick :=
    Nat.mul_le_mul_right maxRisePerTick (Nat.le_of_lt hOffset)
  rw [← hDecomp]
  omega

/-- Instantaneous high pulse between even-time samples. This breaks a
sample-only safety claim even though every sampled reading is safe. -/
def hiddenPulse (t : Nat) : Nat := if t = 1 then 3 else 0

theorem every_second_sample_safe_but_interior_unsafe :
    (∀ k : Nat, hiddenPulse (k * 2) ≤ 1) ∧
    ¬ (∀ t : Nat, hiddenPulse t ≤ 1) := by
  constructor
  · intro k
    have hNotPulse : k * 2 ≠ 1 := by omega
    simp [hiddenPulse, hNotPulse]
  · intro hAll
    have bad := hAll 1
    simp [hiddenPulse] at bad

/-- In the pulse example an overly optimistic zero-rise bound fails
the actual within-sample contract. This prevents evading the
counterexample by declaring the physical rate to be zero. -/
theorem hidden_pulse_breaks_zero_rate :
    ¬ WithinSampleRate hiddenPulse 2 0 := by
  intro h
  have hViolation := h 0 1 (by omega)
  simp [WithinSampleRate, hiddenPulse] at hViolation

#print axioms every_unsampled_instant_safe
#print axioms every_second_sample_safe_but_interior_unsafe
#print axioms hidden_pulse_breaks_zero_rate
end PhysicalBridges.IRInterSampleEnvelope
