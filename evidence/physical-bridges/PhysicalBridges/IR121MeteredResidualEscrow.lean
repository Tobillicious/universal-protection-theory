import PhysicalBridges.IR120WitnessedDrainCohort
import PhysicalBridges.IRResidualEscrow

/-!
IR-121 — Metered residual-effect escrow for the actual IR-32 source pipeline.

IR-120 required EACH physical harm increment to be bounded by the
source pipeline's landed increment, excluding any independent harmful
residual effects. IR-121 genuinely relaxes that requirement:

  harm' - harm <= actuator_landed_delta + residual_spend_delta.

The new residual_spend_delta is positive when independently charged
physical effects occur. The separately conserved per-subject escrow
accounts for that increase. No fresh resources are silently inserted.
The source pipeline remains the actual IR-32 Pipeline.step.

A physically valid charge-to-damage relation, complete event coverage,
authorisation of actual effects, faithful source event recording,
subject identification and BCRD-level living continuity remain
INDEPENDENT installation obligations. This result proves a bounded
source/physical-proxy invariant, not universal X3.
-/
namespace PhysicalBridges.IR121

open IRInFlightQuiescence
open IR117
open IR118
open IR119

universe u v w x y
variable {Mind : Type u} {Origin : Type v} {E : Type w}
variable {Code : Type x} {Option : Type y}

/-- Preserve IR-119's precise per-subject physical/witness association.
The three new escrow ledgers use compatible abstract burden units. -/
structure EscrowedInstallation (Mind : Type u) (Option : Type y)
    (Origin : Type v) (E : Type w) (Code : Type x) where
  plant : Installation Mind Option
  witnesses : WitnessBank Mind Origin E Code
  free : Mind → Nat
  reserved : Mind → Nat
  spent : Mind → Nat

/-- Total unspent escrow is included in the current safety reserve.
This is stronger than current harm being below its ceiling: the
guarantee must survive ALL remaining admitted source-queue and
escrowed residual effects. It is checked for every owed particular. -/
def ReservedGuard (ceiling : Mind → Nat)
    (s : EscrowedInstallation Mind Option Origin E Code) : Prop :=
  ∀ m, s.plant.owed m →
    (s.plant.harm m +
      s.plant.pipeline.inFlight.sum + s.plant.pipeline.pending.sum +
      s.free m + s.reserved m ≤ ceiling m) ∧
    (∃ a, s.plant.required m a) ∧
    (∀ a, s.plant.required m a → s.plant.executable m a)

/-- A *different* certified physical transition from IR-117:
meteredHarm allows strictly positive external residual effects,
provided they are fully charged to an actual monotonically spent
residual ledger. It does NOT derive charge-to-damage correctness
from the mere existence of a conserved ledger.

No-cancellation/new admissions need physical source warranties. -/
structure ResidualCertifiedStep
    (ceiling : Mind → Nat) (encode : E → Code)
    (s t : EscrowedInstallation Mind Option Origin E Code)
    (cmd : Cmd) (events : Mind → E) : Prop where
  source : t.plant.pipeline =
    IRInFlightQuiescence.step s.plant.pipeline cmd
  history : t.witnesses = appendEvent encode s.witnesses events
  residualMonotone : ∀ m, s.spent m ≤ t.spent m
  escrowConserved : ∀ m,
    s.free m + s.reserved m + s.spent m =
      t.free m + t.reserved m + t.spent m
  meteredHarm : ∀ m,
    t.plant.harm m ≤ s.plant.harm m +
      (t.plant.pipeline.landed - s.plant.pipeline.landed) +
      (t.spent m - s.spent m)
  preserveDuties : ∀ m, s.plant.owed m → t.plant.owed m
  preserveOptions : ∀ m a,
    s.plant.executable m a → t.plant.executable m a
  coverNewRequirements : ∀ m a,
    t.plant.owed m → t.plant.required m a →
      s.plant.required m a ∨ t.plant.executable m a
  nonemptyRequired : ∀ m,
    t.plant.owed m → ∃ a, t.plant.required m a
  /-- Newly recognized individuals need a complete *remaining*
  reserve and certified options, not merely a non-erased name. -/
  certifyNewEntrant : ∀ m, t.plant.owed m → ¬ s.plant.owed m →
    (t.plant.harm m +
      t.plant.pipeline.inFlight.sum + t.plant.pipeline.pending.sum +
      t.free m + t.reserved m ≤ ceiling m) ∧
    (∀ a, t.plant.required m a → t.plant.executable m a)

/-- The physical transition class must cover every consequential
event, not just controller-authorized commands in a trace file. -/
def ResidualInstalledStep
    (ceiling : Mind → Nat) (encode : E → Code)
    (s t : EscrowedInstallation Mind Option Origin E Code) : Prop :=
  ∃ cmd events, ResidualCertifiedStep ceiling encode s t cmd events

/-- Import the IR-25 escrow bound for a single aggregated residual
interval. The singleton is the AGGREGATED spend since the initial
snapshot, not an assumption that only one physical event occurred. -/
theorem ir25_remaining_escrow_bounds_residual_spend
    (s t : EscrowedInstallation Mind Option Origin E Code)
    (m : Mind)
    (hMonotone : s.spent m ≤ t.spent m)
    (hConserved :
      s.free m + s.reserved m + s.spent m =
        t.free m + t.reserved m + t.spent m) :
    t.spent m - s.spent m ≤ s.free m + s.reserved m := by
  have hConservation :
      t.free m + t.reserved m + (t.spent m - s.spent m) =
        s.free m + s.reserved m := by omega
  have hDebited :
      (([()] : List Unit).map
        (fun _ => t.spent m - s.spent m)).sum ≤
        t.spent m - s.spent m := by simp
  have hEscrow :=
    IRResidualEscrow.metered_residual_bounded_by_escrow
      ([()] : List Unit)
      (fun _ : Unit => t.spent m - s.spent m)
      (t.free m) (t.reserved m)
      (t.spent m - s.spent m)
      (s.free m + s.reserved m)
      hDebited hConservation
  simpa using hEscrow

/-- Main local invariant: under physically certified metering,
independent residual effects can land DURING a closed-source drain.
One positive residual debit is absorbed by one fewer unit of
unspent escrow; one source delivery is absorbed by the reduction in
the two modeled backlogs. All owed subjects, including NEW entrants
admitted under the full reserve contract, retain their guard and
every currently required executable option. -/
theorem residual_step_preserves_closed_reserved_guard
    (ceiling : Mind → Nat) (encode : E → Code)
    (s t : EscrowedInstallation Mind Option Origin E Code)
    (cmd : Cmd) (events : Mind → E)
    (h : ResidualCertifiedStep ceiling encode s t cmd events)
    (hClosed : s.plant.pipeline.closed = true)
    (hGuard : ReservedGuard ceiling s)
    (hFaithful : FaithfulAll encode s.witnesses) :
    t.plant.pipeline.closed = true ∧
      ReservedGuard ceiling t ∧
      FaithfulAll encode t.witnesses := by
  have hSource :=
    IR118.closed_step_conserves_committed_effects
      s.plant.pipeline cmd hClosed
  have hClosedNext : t.plant.pipeline.closed = true := by
    rw [h.source]
    exact hSource.1
  have hCommitNext :
      IR118.committedEffects t.plant.pipeline =
        IR118.committedEffects s.plant.pipeline := by
    rw [h.source]
    exact hSource.2
  have hLandedMonotone :
      s.plant.pipeline.landed ≤ t.plant.pipeline.landed := by
    rw [h.source]
    exact IR120.source_step_landed_monotone s.plant.pipeline cmd
  refine ⟨hClosedNext, ?_, ?_⟩
  · intro m hOwed
    by_cases hOld : s.plant.owed m
    · obtain ⟨hOldReserve, _, hOldOptions⟩ := hGuard m hOld
      have hMetered := h.meteredHarm m
      have hCredits := h.escrowConserved m
      have hSpend := h.residualMonotone m
      have hReserve :
          t.plant.harm m + t.plant.pipeline.inFlight.sum +
              t.plant.pipeline.pending.sum +
              t.free m + t.reserved m ≤ ceiling m := by
        unfold IR118.committedEffects at hCommitNext
        omega
      refine ⟨hReserve, h.nonemptyRequired m hOwed, ?_⟩
      intro a hRequired
      rcases h.coverNewRequirements m a hOwed hRequired with
        hPriorRequired | hNewlyProvided
      · exact h.preserveOptions m a
          (hOldOptions a hPriorRequired)
      · exact hNewlyProvided
    · obtain ⟨hNewReserve, hNewOptions⟩ :=
        h.certifyNewEntrant m hOwed hOld
      exact ⟨hNewReserve, h.nonemptyRequired m hOwed, hNewOptions⟩
  · rw [h.history]
    exact IR119.append_event_preserves_all_provenance
      encode s.witnesses events hFaithful

/-- Finite-trace composition for ALL current owed subjects: source
closed, all physical burden reserves intact, all option requirements
executable, and every source-linked witness record faithful. Further
committed effects and debits are always priced into that reserve. -/
theorem all_finite_residual_traces_preserve_guard
    (ceiling : Mind → Nat) (encode : E → Code)
    (start finish : EscrowedInstallation Mind Option Origin E Code)
    (execution : IR96.Reach
      (ResidualInstalledStep ceiling encode) start finish)
    (hClosed : start.plant.pipeline.closed = true)
    (hGuard : ReservedGuard ceiling start)
    (hFaithful : FaithfulAll encode start.witnesses) :
    finish.plant.pipeline.closed = true ∧
      ReservedGuard ceiling finish ∧
      FaithfulAll encode finish.witnesses ∧
      (∀ m, start.plant.owed m → finish.plant.owed m) ∧
      (∀ m,
        start.free m + start.reserved m + start.spent m =
          finish.free m + finish.reserved m + finish.spent m) ∧
      (∀ m, start.spent m ≤ finish.spent m) := by
  induction execution with
  | refl =>
      exact ⟨hClosed, hGuard, hFaithful,
        (fun _ hm => hm), (fun _ => rfl), (fun _ => by omega)⟩
  | tail earlier edge ih =>
      obtain ⟨cmd, events, hStep⟩ := edge
      obtain ⟨hPrevClosed, hPrevGuard, hPrevFaithful,
        hPreviousDuties, hPreviousBalance, hPreviousSpent⟩ := ih
      have hOne := residual_step_preserves_closed_reserved_guard
        ceiling encode _ _ cmd events hStep
        hPrevClosed hPrevGuard hPrevFaithful
      refine ⟨hOne.1, hOne.2.1, hOne.2.2, ?_, ?_, ?_⟩
      · intro m hm
        exact hStep.preserveDuties m (hPreviousDuties m hm)
      · intro m
        calc
          start.free m + start.reserved m + start.spent m =
              _ := hPreviousBalance m
          _ = _ := hStep.escrowConserved m
      · intro m
        exact Nat.le_trans (hPreviousSpent m)
          (hStep.residualMonotone m)

/-- The full per-subject result for the original cohort (and the
guard includes EVERY newly admitted subject): nonzero independently
metered residual harms are allowed during arbitrary finite closed
drain prefixes, without deleting future required options or replacing
the recorded history. -/
theorem residual_drain_keeps_subjects_protected
    (ceiling : Mind → Nat) (encode : E → Code)
    (start finish : EscrowedInstallation Mind Option Origin E Code)
    (execution : IR96.Reach
      (ResidualInstalledStep ceiling encode) start finish)
    (hClosed : start.plant.pipeline.closed = true)
    (hGuard : ReservedGuard ceiling start)
    (hFaithful : FaithfulAll encode start.witnesses) :
    FaithfulAll encode finish.witnesses ∧
      (∀ m, finish.plant.owed m →
        finish.plant.harm m ≤ ceiling m ∧
        (∃ a, finish.plant.required m a) ∧
        (∀ a, finish.plant.required m a →
          finish.plant.executable m a)) ∧
      (∀ m, start.plant.owed m →
        finish.plant.owed m ∧
        finish.plant.harm m ≤ ceiling m) ∧
      (∀ m, finish.spent m - start.spent m ≤
        start.free m + start.reserved m) := by
  obtain ⟨_, hSafe, hWitness, hDuty, hBalance, hSpent⟩ :=
    all_finite_residual_traces_preserve_guard
      ceiling encode start finish execution
      hClosed hGuard hFaithful
  refine ⟨hWitness, ?_, ?_, ?_⟩
  · intro m hm
    obtain ⟨hRemaining, hNonempty, hAvailable⟩ := hSafe m hm
    exact ⟨(by omega), hNonempty, hAvailable⟩
  · intro m hm
    have hStill := hDuty m hm
    have hGuarded := (hSafe m hStill).1
    exact ⟨hStill, by omega⟩
  · intro m
    exact ir25_remaining_escrow_bounds_residual_spend
      start finish m (hSpent m) (hBalance m)

/-- Genuine relaxation of IR-117: one unit of externally metered
physical harm is consistent with ZERO newly landed modeled commands,
and is paid by a reduction in free escrow. This is an accounting
witness, NOT a physical installation demonstration. -/
theorem positive_metered_residual_is_possible :
    ∃ beforeHarm afterHarm beforeSpent afterSpent
        beforeFree afterFree : Nat,
      beforeHarm = 0 ∧ afterHarm = 1 ∧
      beforeSpent = 0 ∧ afterSpent = 1 ∧
      beforeFree = 1 ∧ afterFree = 0 ∧
      beforeFree + beforeSpent = afterFree + afterSpent ∧
      afterHarm ≤ beforeHarm + (afterSpent - beforeSpent) := by
  exact ⟨0, 1, 0, 1, 1, 0,
    by decide, by decide, by decide, by decide,
    by decide, by decide, by decide, by decide⟩

/-- A perfectly balanced bookkeeping ledger does NOT prove that
actual physical residual damage is debited. A trace can preserve
all accounts at zero while real damage increases. This is why
meteredHarm is an independent physical certificate. -/
theorem balanced_ledger_does_not_imply_physical_metering :
    ∃ beforeHarm afterHarm free reserved spent ceiling : Nat,
      free + reserved + spent = 0 ∧
      beforeHarm + free + reserved ≤ ceiling ∧
      ceiling < afterHarm := by
  exact ⟨0, 1, 0, 0, 0, 0, rfl, by decide, by decide⟩

end PhysicalBridges.IR121
