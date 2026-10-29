import Snuffy.IRWatchdogLatencyEffects
import Snuffy.IRInterSampleEnvelope

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IRStoredEnergyCommonMode.lean` at main `740abbb` (sha256 `c24b8bb393124e39bb72096fb04ec2406601e724cdb96cbacf8b8802397daa9e`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false
/-
IR-80 — stored physical energy, kickback, and correlated sensor faults.

Responds directly to the X3 watchdog hostile review. The previous
IR-79 model covers response latencies and a supplied TOTAL physical
effect envelope, but cannot derive that envelope just from a gate.

We distinguish:
1. Magnetic energy L*I²/2 and a complete doubled-energy
   accounting ledger, including other kinetic/thermal stored energy.
2. A necessary clamp-capacity inequality under no-release/no-remnant.
3. A proved countermodel that an energy capacity alone cannot
   impose a peak voltage/effect constraint.
4. Two agreeing sensors can share a common error. A physical reserve
   margin follows from at least ONE truly calibrated channel only
   when its soundness is warranted independently.
5. A fail-closed modeled dual-permit gate, and an explicit failure
   to infer *physical* no-bypass from a digital signal.
6. The already source-checked IR-52 inter-sample pulse control.

All ledger variables are Nat conservative units. In any actual
energy interpretation, expressions ending 'Twice' must be measured
consistently in twice-energy units; an actual inductance-current
relation and COMPLETE channel balance remain physical premises.
No numerical electric/magnetic calibration or entire physical
X3 protection is claimed.
-/

namespace PhysicalBridges.IRStoredEnergyCommonMode

/-- Exactly twice the ideal energy stored in an inductor:
2E_L = L * I². Units: two joules when L is henry and I ampere
in a consistent physical scaling. No integration of current alone:
integral(I dt) has units of charge, NOT energy. -/
def twiceInductiveEnergy (inductance current : Nat) : Nat :=
  inductance * current * current

/-- Include independently bounded nonmagnetic energy, such as
kinetic inertia, thermal latent stores, or capacitor banks.
The latter are themselves already scaled as 2E. -/
def totalStoredTwice
    (inductance current kineticTwice otherTwice : Nat) : Nat :=
  twiceInductiveEnergy inductance current +
    kineticTwice + otherTwice

structure DischargeLedger where
  inductance : Nat
  current : Nat
  kineticTwice : Nat
  otherTwice : Nat
  absorbedTwice : Nat
  escapedTwice : Nat
  remainingTwice : Nat
  clampCapacityTwice : Nat
deriving Repr, DecidableEq

/-- The signed physical energy ledger must cover ALL relevant
stored stores and downstream channels. The model expresses a
conservative conservation/flow inequality; its physical truth
cannot be derived from the watchdog firmware. -/
def ConservativeAccounting (s : DischargeLedger) : Prop :=
  totalStoredTwice s.inductance s.current
    s.kineticTwice s.otherTwice ≤
      s.absorbedTwice + s.escapedTwice + s.remainingTwice

def ClampCapacity (s : DischargeLedger) : Prop :=
  s.absorbedTwice ≤ s.clampCapacityTwice

/-- Necessary clamp capacity: if energy is fully absorbed with
NO escape and NO continuing stored energy, the clamp must be
sized for the TOTAL initial energy, not just the magnetic field.
This is not sufficient for peak voltage or safe physical settling. -/
theorem zero_escape_zero_remnant_requires_full_capacity
    (s : DischargeLedger)
    (hBalance : ConservativeAccounting s)
    (hClamp : ClampCapacity s)
    (hNoEscape : s.escapedTwice = 0)
    (hSettled : s.remainingTwice = 0) :
    totalStoredTwice s.inductance s.current
      s.kineticTwice s.otherTwice ≤
        s.clampCapacityTwice := by
  unfold ConservativeAccounting at hBalance
  unfold ClampCapacity at hClamp
  omega

/-- If the clamp's true rated energy capacity is BELOW the total
stored energy, the conservation ledger forces either an escaped
channel OR nonzero energy remaining. It does not tell which one
is harmless; both require distinct physical effect checks. -/
theorem undersized_clamp_forces_escape_or_remaining
    (s : DischargeLedger)
    (hBalance : ConservativeAccounting s)
    (hClamp : ClampCapacity s)
    (hSmall : s.clampCapacityTwice <
      totalStoredTwice s.inductance s.current
        s.kineticTwice s.otherTwice) :
    0 < s.escapedTwice ∨ 0 < s.remainingTwice := by
  by_cases hEsc : 0 < s.escapedTwice
  · exact Or.inl hEsc
  · by_cases hRem : 0 < s.remainingTwice
    · exact Or.inr hRem
    · have hEscZero : s.escapedTwice = 0 := by omega
      have hRemZero : s.remainingTwice = 0 := by omega
      have hBound :=
        zero_escape_zero_remnant_requires_full_capacity
          s hBalance hClamp hEscZero hRemZero
      omega

/-- The archived flyback calculation must use stored magnetic energy,
not integral I dt. This synthetic example shows stored energy can
exceed a nominal clamp rating in the correct doubled units. -/
theorem synthetic_magnetic_store_exceeds_capacity :
    20 < twiceInductiveEnergy 4 3 := by decide

/-- Bounded aggregate energy is NOT a voltage or stress bound.
The peak voltage is an independent component of a physical plant.
To derive a bound, supply the current-decay path, capacitance,
voltage clamp, response speed and thermal/mechanical tolerances. -/
theorem energy_capacity_does_not_bound_peak_voltage :
    ∃ ledger : DischargeLedger, ∃ peakVoltage safeVoltage : Nat,
      ConservativeAccounting ledger ∧
      ClampCapacity ledger ∧
      ledger.escapedTwice = 0 ∧
      ledger.remainingTwice = 0 ∧
      safeVoltage < peakVoltage := by
  refine ⟨{
    inductance := 2, current := 2, kineticTwice := 0,
    otherTwice := 0, absorbedTwice := 8,
    escapedTwice := 0, remainingTwice := 0,
    clampCapacityTwice := 8
  }, 100, 20, ?_, ?_, rfl, rfl, ?_⟩
  · change 8 ≤ 8
    decide
  · change 8 ≤ 8
    decide
  · decide

/-- Two nominal sensors may agree perfectly while both share the
same unobserved reference/brownout bias. Agreement alone cannot
certify even an ordinary reserve predicate. -/
theorem two_agreeing_untrusted_sensors_can_both_be_wrong :
    ∃ actual readingA readingB reserve : Nat,
      readingA = readingB ∧
      reserve ≤ readingA ∧
      reserve ≤ readingB ∧
      ¬ reserve ≤ actual := by
  refine ⟨0, 10, 10, 5, rfl, ?_, ?_, ?_⟩ <;> decide

/-- Honest redundancy theorem: if at least ONE channel really
satisfies a one-sided physical sensor error envelope, and BOTH
readings exceed the appropriately padded reserve, then the
actual plant reserve follows. This explicitly REQUIRES soundness
of at least one channel; agreement does not supply it. -/
theorem one_physically_sound_channel_with_margin
    (actual readingA readingB errorA errorB reserve : Nat)
    (hAtLeastOneSound :
      readingA ≤ actual + errorA ∨
      readingB ≤ actual + errorB)
    (hPaddedA : reserve + errorA ≤ readingA)
    (hPaddedB : reserve + errorB ≤ readingB) :
    reserve ≤ actual := by
  rcases hAtLeastOneSound with hA | hB
  · omega
  · omega

/-- A completely modeled dual-domain command gate can drop its
authorization if ANY independently monitored prerequisite fails.
This Boolean result does not establish hardware implementation
or independent common-mode coverage. -/
def dualDomainPermit
    (telemetryPass analogWatchdogOK physicalFenceOK : Bool) : Bool :=
  telemetryPass && analogWatchdogOK && physicalFenceOK

theorem failed_analog_domain_denies_modeled_command
    (telemetryPass physicalFenceOK : Bool) :
    dualDomainPermit telemetryPass false physicalFenceOK = false := by
  simp [dualDomainPermit]

theorem failed_physical_fence_denies_modeled_command
    (telemetryPass analogWatchdogOK : Bool) :
    dualDomainPermit telemetryPass analogWatchdogOK false = false := by
  simp [dualDomainPermit]

/-- All logical enables may be true in the face of an independent
physical bypass, so 'verified watchdog firmware' alone cannot
establish actual isolation or zero physical effects. -/
theorem all_enables_pass_but_independent_bypass_lands :
    dualDomainPermit true true true = true ∧
      IRWatchdogLatencyEffects.actualEffect true 0 1 = 1 := by
  decide

/-- Reuse the source-level hidden pulse obstruction: even completely
correct every-second samples do not prove safety between samples,
absent the IR-52 actual physical interpolation/rate envelope. -/
theorem intersample_endpoint_acceptance_does_not_ensure_safety :
    (∀ k : Nat, IRInterSampleEnvelope.hiddenPulse (k*2) ≤ 1) ∧
    ¬ (∀ t : Nat, IRInterSampleEnvelope.hiddenPulse t ≤ 1) :=
  IRInterSampleEnvelope.every_second_sample_safe_but_interior_unsafe


end PhysicalBridges.IRStoredEnergyCommonMode
