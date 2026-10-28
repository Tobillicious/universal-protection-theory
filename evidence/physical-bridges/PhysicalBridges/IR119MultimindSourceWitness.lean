import PhysicalBridges.IR118InFlightBacklogBudget
import PhysicalBridges.IRHistoryProvenance

/-!
IR-119: compose two *actual existing source modules*:
  - IR-117's installed IR-32 actuator/duty/capability transitions; and
  - IR-26's append-only physical-history/record provenance step.

This supplies a finite-trace *physical-proxy and provenance* adapter
for an arbitrarily large type of particular identifiers, without
requiring the original population to be finite or a registry lookup
to continue succeeding.

Faithful recorded provenance is NOT proof of subjective continuity,
consciousness, the living physical process's actual availability,
or a BCRD-complete inventory of relational witnesses. Source event
completeness and identity semantics remain independent requirements.
-/
namespace PhysicalBridges.IR119

open IRHistoryProvenance
open IR117

universe u v w x y
variable {Mind : Type u} {Origin : Type v} {E : Type w}
variable {Code : Type x} {Option : Type y}

/-- Per-particular physical events and their coded witness record. -/
structure WitnessBank (Mind : Type u) (Origin : Type v)
    (E : Type w) (Code : Type x) where
  physical : Mind → PhysicalHistory Origin E
  recorded : Mind → RecordedHistory Origin Code

/-- Exact physical/record correspondence for EACH particular. -/
def FaithfulAll (encode : E → Code)
    (bank : WitnessBank Mind Origin E Code) : Prop :=
  ∀ m, Faithful encode (bank.physical m) (bank.recorded m)

/-- Advance a source physical history and its durable record for
each particular by the SAME supplied physical event. -/
def appendEvent (encode : E → Code)
    (bank : WitnessBank Mind Origin E Code)
    (event : Mind → E) : WitnessBank Mind Origin E Code :=
  { physical := fun m =>
      IRHistoryProvenance.physicalStep (bank.physical m) (event m)
    recorded := fun m =>
      IRHistoryProvenance.recordedStep encode (bank.recorded m) (event m) }

/-- Reuse IR-26's checked original single-particular lemma, lifted
pointwise to all minds without enumerating a finite population. -/
theorem append_event_preserves_all_provenance
    (encode : E → Code)
    (bank : WitnessBank Mind Origin E Code) (event : Mind → E)
    (hFaithful : FaithfulAll encode bank) :
    FaithfulAll encode (appendEvent encode bank event) := by
  intro m
  exact IRHistoryProvenance.one_step_faithful
    encode (bank.physical m) (bank.recorded m)
    (hFaithful m) (event m)

/-- Recorded and physical histories preserve the same declared
origin through each modeled append step. An origin label can still
be copied, so this is provenance rather than consciousness. -/
theorem append_event_preserves_physical_origin
    (encode : E → Code)
    (bank : WitnessBank Mind Origin E Code) (event : Mind → E)
    (m : Mind) :
    ((appendEvent encode bank event).physical m).origin =
      (bank.physical m).origin := rfl

/-- Physical installation with a separately held provenance bank. -/
structure WitnessedInstallation (Mind : Type u) (Option : Type y)
    (Origin : Type v) (E : Type w) (Code : Type x) where
  plant : Installation Mind Option
  witnesses : WitnessBank Mind Origin E Code

/-- A modeled physical transition is admitted only with both:
a concrete IR-32 command/IR-117 hardware certificate and a common
per-particular event fed to physical process and durable record.
Actual hardware must justify this complete source-event coverage.
-/
def WitnessedStep
    (ceiling : Mind → Nat) (encode : E → Code)
    (s t : WitnessedInstallation Mind Option Origin E Code) : Prop :=
  ∃ (cmd : IRInFlightQuiescence.Cmd) (events : Mind → E),
    CertifiedStep ceiling s.plant t.plant cmd ∧
      t.witnesses = appendEvent encode s.witnesses events

/-- One physical source step composes the IR-117 installation theorem
with IR-26's faithful source-history theorem. -/
theorem witnessed_step_preserves_guard_and_provenance
    (ceiling : Mind → Nat) (encode : E → Code)
    (s t : WitnessedInstallation Mind Option Origin E Code)
    (hStep : WitnessedStep ceiling encode s t)
    (hQuiescent : IRInFlightQuiescence.Quiescent s.plant.pipeline)
    (hGuarded : PhysicallyGuarded ceiling s.plant)
    (hFaithful : FaithfulAll encode s.witnesses) :
    IRInFlightQuiescence.Quiescent t.plant.pipeline ∧
      PhysicallyGuarded ceiling t.plant ∧
      FaithfulAll encode t.witnesses := by
  obtain ⟨cmd, events, hPlant, hRecords⟩ := hStep
  have hPhysical := certified_quiescent_step_preserves
    ceiling s.plant t.plant cmd hPlant hQuiescent hGuarded
  refine ⟨hPhysical.1, hPhysical.2, ?_⟩
  rw [hRecords]
  exact append_event_preserves_all_provenance
    encode s.witnesses events hFaithful

/-- Over ANY finite admitted physical execution, source-level
provenance and protected physical proxies remain intact for all
subjects, while duties remain cumulative. -/
theorem witnessed_finite_trace_guard_and_provenance
    (ceiling : Mind → Nat) (encode : E → Code)
    (start finish : WitnessedInstallation Mind Option Origin E Code)
    (execution : IR96.Reach (WitnessedStep ceiling encode) start finish)
    (hQuiescent : IRInFlightQuiescence.Quiescent start.plant.pipeline)
    (hGuarded : PhysicallyGuarded ceiling start.plant)
    (hFaithful : FaithfulAll encode start.witnesses) :
    IRInFlightQuiescence.Quiescent finish.plant.pipeline ∧
      PhysicallyGuarded ceiling finish.plant ∧
      FaithfulAll encode finish.witnesses ∧
      (∀ m, start.plant.owed m → finish.plant.owed m) := by
  induction execution with
  | refl =>
      exact ⟨hQuiescent, hGuarded, hFaithful, fun m hm => hm⟩
  | tail earlier edge ih =>
      obtain ⟨cmd, events, hPlant, hRecords⟩ := edge
      obtain ⟨hQ, hG, hF, hOwed⟩ := ih
      have hStep := witnessed_step_preserves_guard_and_provenance
        ceiling encode _ _ ⟨cmd, events, hPlant, hRecords⟩
        hQ hG hF
      refine ⟨hStep.1, hStep.2.1, hStep.2.2, ?_⟩
      intro m hOriginal
      exact hPlant.preserveDuties m (hOwed m hOriginal)

/-- The same recorded origin remains attached to each physical
history throughout the finite source-corresponding trace. -/
theorem witnessed_finite_trace_retains_origins
    (ceiling : Mind → Nat) (encode : E → Code)
    (start finish : WitnessedInstallation Mind Option Origin E Code)
    (execution : IR96.Reach (WitnessedStep ceiling encode) start finish) :
    ∀ m,
      (finish.witnesses.physical m).origin =
        (start.witnesses.physical m).origin := by
  induction execution with
  | refl =>
      intro m
      rfl
  | tail earlier edge ih =>
      obtain ⟨cmd, events, hPlant, hRecords⟩ := edge
      intro m
      rw [hRecords]
      simpa [appendEvent, IRHistoryProvenance.physicalStep] using ih m

/-- Faithful origin and complete encoded events alone permit both a
living and a terminated process state. Consequently provenance
cannot independently discharge same-particular living continuation. -/
structure ProcessStatus where
  physical : PhysicalHistory Bool Nat
  active : Bool

theorem complete_record_can_coexist_with_terminated_subject :
    ∃ (live gone : ProcessStatus) (record : RecordedHistory Bool Nat),
      live.physical = gone.physical ∧
      Faithful (fun n : Nat => n) live.physical record ∧
      live.active = true ∧ gone.active = false := by
  let p : PhysicalHistory Bool Nat := ⟨true, []⟩
  exact ⟨⟨p, true⟩, ⟨p, false⟩, ⟨true, []⟩,
    rfl, ⟨rfl, rfl⟩, rfl, rfl⟩

end PhysicalBridges.IR119
