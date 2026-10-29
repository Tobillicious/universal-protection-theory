import Snuffy.IR117SourceInstallationAdapter

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IR118InFlightBacklogBudget.lean` at main `740abbb` (sha256 `4c5f56ffc85394ae3002dcb4396854a7df804a1a323cdbf040781a1721f2c388`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false

/-!
IR-118: a finite source-derived bound on effects already in flight.

IR-32 proves that effects stop *after* the source pipeline is closed
and drained. Here we prove an exact quantity is conserved already
when admission is closed, even when both pipeline backlogs are NONEMPTY:

    landed + sum(inFlight) + sum(pending).

Thus the remaining possible *modeled* increase in landed effects is
bounded by the original two backlogs. With an independently certified
physical coverage envelope and residual budget, the bound transfers
to real per-subject physical burden DURING the drain.

This does not make an unmeasured pipeline physically complete, prove
that a late detected fault was previously harmless, or establish
same-subject metaphysical continuity or universal X3.
-/
namespace PhysicalBridges.IR118

open IRInFlightQuiescence
open IR117

universe u v
variable {Mind : Type u} {Option : Type v}

/-- Total effects already landed or irreversibly committed in either
modeled actuator queue. Every amount is a Nat in common burden units. -/
def committedEffects (s : Pipeline) : Nat :=
  s.landed + s.inFlight.sum + s.pending.sum

/-- IR-32 source transition conserves the committed total as long as
admission is CLOSED. Dispatch is then no-op; moving effects between
inFlight, pending, and landed does not increase the total. -/
theorem closed_step_conserves_committed_effects
    (s : Pipeline) (cmd : Cmd) (hClosed : s.closed = true) :
    (step s cmd).closed = true ∧
    committedEffects (step s cmd) = committedEffects s := by
  cases cmd with
  | close generation =>
      constructor
      · rfl
      · simp [committedEffects, step, close]
  | send impact =>
      have hNoop : send s impact = s := by
        simp [send, hClosed]
      simp [step, hNoop, hClosed]
  | arrive =>
      cases hFlight : s.inFlight with
      | nil =>
          have hNoop : arrive s = s := by
            simp [arrive, hFlight]
          simp [step, hNoop, hClosed]
      | cons effect rest =>
          constructor
          · simp [step, arrive, hFlight, hClosed]
          · simp [committedEffects, step, arrive, hFlight,
              List.sum_cons] <;> omega
  | deliver =>
      cases hPending : s.pending with
      | nil =>
          have hNoop : deliver s = s := by
            simp [deliver, hPending]
          simp [step, hNoop, hClosed]
      | cons effect rest =>
          constructor
          · simp [step, deliver, hPending, hClosed]
          · simp [committedEffects, step, deliver, hPending,
              List.sum_cons] <;> omega

/-- Source-level conservation through ANY finite interleaving after
admissions close, whether or not actuator queues have drained. -/
theorem closed_run_conserves_committed_effects :
    ∀ (commands : List Cmd) (s : Pipeline), s.closed = true →
      (run s commands).closed = true ∧
      committedEffects (run s commands) = committedEffects s := by
  intro commands
  induction commands with
  | nil =>
      intro s hClosed
      exact ⟨hClosed, rfl⟩
  | cons cmd rest ih =>
      intro s hClosed
      obtain ⟨hNextClosed, hNextTotal⟩ :=
        closed_step_conserves_committed_effects s cmd hClosed
      obtain ⟨hFinalClosed, hFinalTotal⟩ :=
        ih (step s cmd) hNextClosed
      refine ⟨hFinalClosed, ?_⟩
      calc
        committedEffects (run s (cmd :: rest)) =
          committedEffects (run (step s cmd) rest) := rfl
        _ = committedEffects (step s cmd) := hFinalTotal
        _ = committedEffects s := hNextTotal

/-- Even if all old effects eventually land, they cannot exceed the
closed source pipeline's initially committed backlog. -/
theorem closed_run_landed_bounded_by_initial_backlog
    (s : Pipeline) (commands : List Cmd)
    (hClosed : s.closed = true) :
    (run s commands).landed ≤
      s.landed + s.inFlight.sum + s.pending.sum := by
  have hConserve :=
    (closed_run_conserves_committed_effects commands s hClosed).2
  unfold committedEffects at hConserve
  omega

/-- Connect the *exact IR-32 source run* to IR-117's per-subject
physical burden. The independently measured residual budget includes
every effect not accounted by Pipeline.landed.

The result covers the entire finite drain prefix, NOT just the
already empty queues of IR-117. Each prefix is eligible by invoking
this theorem with that prefix as commands. -/
theorem physical_reserve_holds_during_closed_drain
    (ceiling residualBudget : Mind → Nat)
    (start finish : Installation Mind Option)
    (commands : List Cmd)
    (hClosed : start.pipeline.closed = true)
    (hSource : finish.pipeline = run start.pipeline commands)
    (hCompletePhysicalEnvelope : ∀ m,
      finish.harm m ≤ start.harm m +
        (finish.pipeline.landed - start.pipeline.landed) +
        residualBudget m)
    (hInitialReserve : ∀ m, start.owed m →
      start.harm m +
        start.pipeline.inFlight.sum +
        start.pipeline.pending.sum +
        residualBudget m ≤ ceiling m) :
    ∀ m, start.owed m → finish.harm m ≤ ceiling m := by
  have hLanded :
      finish.pipeline.landed ≤
        start.pipeline.landed + start.pipeline.inFlight.sum +
          start.pipeline.pending.sum := by
    rw [hSource]
    exact closed_run_landed_bounded_by_initial_backlog
      start.pipeline commands hClosed
  intro m hOriginal
  have hEnvelope := hCompletePhysicalEnvelope m
  have hReserve := hInitialReserve m hOriginal
  omega

/-- Pipeline-level source accounting does not preserve rights:
all actual physical capabilities still need an independent
non-revocation/justified-reconfiguration contract such as IR-117. -/
theorem closed_source_budget_does_not_imply_future_options :
    ∃ (p q : Installation Unit Unit),
      p.pipeline = q.pipeline ∧
      p.harm () = q.harm () ∧
      p.executable () () ∧
      ¬ q.executable () () := by
  let pipe : Pipeline :=
    { gate := ⟨0, [], []⟩, closed := true,
      inFlight := [], pending := [], landed := 0 }
  let p : Installation Unit Unit :=
    { pipeline := pipe, harm := fun _ => 0,
      owed := fun _ => True, required := fun _ _ => True,
      executable := fun _ _ => True }
  let q : Installation Unit Unit :=
    { pipeline := pipe, harm := fun _ => 0,
      owed := fun _ => True, required := fun _ _ => True,
      executable := fun _ _ => False }
  exact ⟨p, q, rfl, rfl, trivial, id⟩

/-- An open gate permits additional dispatch, so the initial
backlog cannot upper-bound eventual landed effects. -/
theorem open_admission_defeats_initial_backlog_budget :
    ∃ s : Pipeline,
      s.closed = false ∧
      s.inFlight = [] ∧
      s.pending = [] ∧
      s.landed + s.inFlight.sum + s.pending.sum <
        (run s [.send 1, .arrive, .deliver]).landed := by
  let s : Pipeline :=
    { gate := ⟨0, [], []⟩, closed := false,
      inFlight := [], pending := [], landed := 0 }
  exact ⟨s, rfl, rfl, rfl, by decide⟩

end PhysicalBridges.IR118
