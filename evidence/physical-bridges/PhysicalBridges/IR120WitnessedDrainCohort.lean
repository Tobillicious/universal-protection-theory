import PhysicalBridges.IR119MultimindSourceWitness

/-!
IR-120: finite-trace subject-cohort guard DURING in-flight effect drain.

Unlike IR-117/IR-119's fully quiescent starting point, this theorem
requires only CLOSED admission. IR-118's exact committed-effect
conservation yields a bound on remaining effects even when the
in-flight and pending actuator queues are NONEMPTY.

For each *initially owed* subject we derive: continued duty in the
register, a conservative physical harm threshold, a nonempty required
future-option set, every current required option executable, and
faithful recorded provenance, along ANY finite admitted trace.

All relevant harmful physical increments must be fully covered
by the IR-117 source landing ledger. Nonzero unmodeled residual effects
are not admitted by this version of the contract; they would require
a separately metered residual escrow in an extended physical model.
The theorem does
not infer BCRD-complete subjecthood, physical identity or maximal X3.
-/
namespace PhysicalBridges.IR120

open IRInFlightQuiescence
open IR117
open IR118
open IR119
universe u v w x y
variable {Mind : Type u} {Origin : Type v} {E : Type w}
variable {Code : Type x} {Option : Type y}

/-- Every IR-32 source command is monotone in the already landed
physical-effect counter, even if admissions are open. -/
theorem source_step_landed_monotone
    (s : Pipeline) (cmd : Cmd) :
    s.landed ≤ (step s cmd).landed := by
  cases cmd with
  | close generation =>
      simp [step, close]
  | send impact =>
      cases hs : s.closed <;> simp [step, send, hs]
  | arrive =>
      cases hf : s.inFlight with
      | nil => simp [step, arrive, hf]
      | cons effect rest => simp [step, arrive, hf]
  | deliver =>
      cases hp : s.pending with
      | nil => simp [step, deliver, hp]
      | cons effect rest =>
          simp [step, deliver, hp]

/-- A certified physical step inherits the actual source
IR-32 landed counter's monotonicity. -/
theorem certified_step_landed_monotone
    (ceiling : Mind → Nat)
    (s t : Installation Mind Option) (cmd : Cmd)
    (h : CertifiedStep ceiling s t cmd) :
    s.pipeline.landed ≤ t.pipeline.landed := by
  rw [h.source]
  exact source_step_landed_monotone s.pipeline cmd

/-- Strong stepwise invariant joining IR-118's conserved backlog,
IR-117's per-subject no-bypass effect envelope and future options,
and IR-119's faithful historical witness. -/
theorem witnessed_closed_drain_invariant
    (ceiling : Mind → Nat) (encode : E → Code)
    (start finish : WitnessedInstallation Mind Option Origin E Code)
    (execution : IR96.Reach (WitnessedStep ceiling encode) start finish)
    (hInitiallyClosed : start.plant.pipeline.closed = true)
    (hInitiallyGuarded : PhysicallyGuarded ceiling start.plant)
    (hInitiallyFaithful : FaithfulAll encode start.witnesses) :
    finish.plant.pipeline.closed = true ∧
    committedEffects finish.plant.pipeline =
      committedEffects start.plant.pipeline ∧
    start.plant.pipeline.landed ≤ finish.plant.pipeline.landed ∧
    (∀ m, finish.plant.harm m ≤ start.plant.harm m +
      (finish.plant.pipeline.landed -
        start.plant.pipeline.landed)) ∧
    FaithfulAll encode finish.witnesses ∧
    (∀ m, start.plant.owed m →
      finish.plant.owed m ∧
      (∃ a, finish.plant.required m a) ∧
      (∀ a, finish.plant.required m a →
        finish.plant.executable m a)) := by
  induction execution with
  | refl =>
      refine ⟨hInitiallyClosed, rfl, by omega, ?_,
        hInitiallyFaithful, ?_⟩
      · intro m
        omega
      · intro m hOriginal
        obtain ⟨_, hNonempty, hOptions⟩ :=
          hInitiallyGuarded m hOriginal
        exact ⟨hOriginal, hNonempty, hOptions⟩
  | tail earlier edge ih =>
      obtain ⟨cmd, events, hPlant, hRecord⟩ := edge
      obtain ⟨hClosed, hCommitted, hLanded,
        hDamage, hFaithful, hCohort⟩ := ih
      have hSource := closed_step_conserves_committed_effects
        _ cmd hClosed
      have hOneLanded :=
        certified_step_landed_monotone ceiling _ _ cmd hPlant
      refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩
      · rw [hPlant.source]
        exact hSource.1
      · rw [hPlant.source]
        exact Eq.trans hSource.2 hCommitted
      · omega
      · intro m
        have hPerStep := hPlant.noBypass m
        have hPrior := hDamage m
        omega
      · rw [hRecord]
        exact append_event_preserves_all_provenance
          encode _ events hFaithful
      · intro m hOriginal
        obtain ⟨hOwed, _, hPriorOptions⟩ :=
          hCohort m hOriginal
        have hOwedNext := hPlant.preserveDuties m hOwed
        refine ⟨hOwedNext, hPlant.nonemptyRequired m hOwedNext, ?_⟩
        intro a hRequired
        rcases hPlant.coverNewRequirements m a
          hOwedNext hRequired with hWasRequired | hProvisioned
        · exact hPlant.preserveOptions m a
            (hPriorOptions a hWasRequired)
        · exact hProvisioned

/-- Under a TRUE aggregate effect-to-physical-harm correspondence
and the initially reserved entire IR-32 source backlog, each
originally owed particular remains below the specified physical
threshold THROUGH every finite drain prefix, with its requirements
executable and provenance faithful.

No independently unmetered residual channel is admitted by the
IR-117 CertifiedStep premise; a separate physical effect ledger
would be required to incorporate one. -/
theorem witnessed_drain_retains_cohort_and_safety
    (ceiling : Mind → Nat)
    (encode : E → Code)
    (start finish : WitnessedInstallation Mind Option Origin E Code)
    (execution : IR96.Reach (WitnessedStep ceiling encode) start finish)
    (hInitiallyClosed : start.plant.pipeline.closed = true)
    (hInitiallyGuarded : PhysicallyGuarded ceiling start.plant)
    (hInitiallyFaithful : FaithfulAll encode start.witnesses)
    (hInitialReserve : ∀ m, start.plant.owed m →
      start.plant.harm m + start.plant.pipeline.inFlight.sum +
        start.plant.pipeline.pending.sum ≤ ceiling m) :
    FaithfulAll encode finish.witnesses ∧
      ∀ m, start.plant.owed m →
        finish.plant.owed m ∧
        finish.plant.harm m ≤ ceiling m ∧
        (∃ a, finish.plant.required m a) ∧
        (∀ a, finish.plant.required m a →
          finish.plant.executable m a) := by
  obtain ⟨_, hCommitted, _, hDamage, hFaithful, hCohort⟩ :=
    witnessed_closed_drain_invariant
      ceiling encode start finish execution hInitiallyClosed
      hInitiallyGuarded hInitiallyFaithful
  constructor
  · exact hFaithful
  · intro m hOriginal
    obtain ⟨hStill, hNonempty, hOptions⟩ :=
      hCohort m hOriginal
    have hReserve := hInitialReserve m hOriginal
    have hPhysical := hDamage m
    have hLanded :
        finish.plant.pipeline.landed ≤
          start.plant.pipeline.landed +
            start.plant.pipeline.inFlight.sum +
            start.plant.pipeline.pending.sum := by
      unfold committedEffects at hCommitted
      omega
    exact ⟨hStill, by omega, hNonempty, hOptions⟩

end PhysicalBridges.IR120
