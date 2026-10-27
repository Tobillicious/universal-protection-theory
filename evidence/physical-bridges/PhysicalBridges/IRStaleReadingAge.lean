/-
IR-53: guard an actual physical trajectory under irregular sampling.
The last authenticated sample must be recent enough; a missing or
delayed reading may invalidate the earlier fixed-period promise.
-/
import PhysicalBridges.IRInterSampleEnvelope

namespace PhysicalBridges.IRStaleReadingAge

/-- The physical reading was actually observed at this time.
The sensor's integrity and physical units remain external premises. -/
def RecentReading
    (taken : Nat → Prop) (lastSample : Nat → Nat) (maxAge : Nat) : Prop :=
  ∀ t, taken (lastSample t) ∧
    lastSample t ≤ t ∧ t - lastSample t ≤ maxAge

/-- A complete physical rise envelope relative to the last
authenticated, actually taken reading. -/
def SinceLastSampleRise
    (physical : Nat → Nat) (lastSample : Nat → Nat)
    (maxRisePerTick : Nat) : Prop :=
  ∀ t, physical t ≤
    physical (lastSample t) +
      (t - lastSample t) * maxRisePerTick

/-- All irregularly sampled instants are safe if:
(1) the chosen historical reading really exists and is authentic;
(2) its age is always at most maxAge;
(3) the physical rise envelope is valid for every time; and
(4) every authenticated sample has adequate upper-rise margin.
This allows jitter and missed nominal sampling times only when the
maximum physically certified age remains respected. -/
theorem bounded_reading_age_prevents_unsampled_excursion
    (physical : Nat → Nat)
    (taken : Nat → Prop) (lastSample : Nat → Nat)
    (maxAge maxRisePerTick threshold : Nat)
    (hRecent : RecentReading taken lastSample maxAge)
    (hRise : SinceLastSampleRise physical lastSample maxRisePerTick)
    (hGuard : ∀ s, taken s →
      physical s + maxAge * maxRisePerTick ≤ threshold) :
    ∀ t, physical t ≤ threshold := by
  intro t
  obtain ⟨hTaken, _, hAge⟩ := hRecent t
  have hPhysical := hRise t
  have hSample := hGuard (lastSample t) hTaken
  have hRiseLimit :
      (t - lastSample t) * maxRisePerTick ≤
        maxAge * maxRisePerTick :=
    Nat.mul_le_mul_right maxRisePerTick hAge
  omega

/-- Perfect integrity of an old reading is irrelevant after an
unbounded delay: physical values can grow without limit. -/
def steadilyRising (t : Nat) : Nat := t

theorem authenticated_but_stale_reading_can_be_unsafe :
    (steadilyRising 0 ≤ 1) ∧
      ¬ (∀ t, steadilyRising t ≤ 1) := by
  constructor
  · decide
  · intro h
    have bad := h 2
    simp [steadilyRising] at bad

/-- A fixed initial sample is not a valid certificate for a claimed
age limit of 1: at time 2 its age exceeds the promised bound. -/
theorem fixed_last_sample_breaks_freshness :
    ¬ RecentReading (fun s => s = 0) (fun _ => 0) 1 := by
  intro h
  obtain ⟨_, _, hAge⟩ := h 2
  change 2 ≤ 1 at hAge
  omega

/-- A historical sample can be below threshold with zero apparent
drift at the observation point, while a later unobserved effect
violates the safety threshold. -/
theorem omitted_age_check_is_unsound :
    ∃ physical : Nat → Nat,
      physical 0 = 0 ∧ physical 2 > 1 := by
  exact ⟨steadilyRising, rfl, by decide⟩

#print axioms bounded_reading_age_prevents_unsampled_excursion
#print axioms authenticated_but_stale_reading_can_be_unsafe
#print axioms fixed_last_sample_breaks_freshness
#print axioms omitted_age_check_is_unsound
end PhysicalBridges.IRStaleReadingAge
