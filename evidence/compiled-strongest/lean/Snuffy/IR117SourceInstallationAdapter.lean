import Snuffy.IRInFlightQuiescence
import Snuffy.IR96DisturbanceSimulation
import Snuffy.IR116CumulativeSubjectDuties

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IR117SourceInstallationAdapter.lean` at main `740abbb` (sha256 `10f05b60dca80891e85784070235abafc97a6e9e46f26ee572ccb91865b1e117`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false

/-!
IR-117: an explicit installation/source-state adapter.

Reuses the actual IR-32 in-flight/pending actuator Pipeline rather
than asserting an abstract safe controller. Each physical step is
certified against the exact source Pipeline.step, with per-subject
harm budget, cumulative duties, and option availability.

The non-bypass envelope, genuine subject identifiers, actuator-source
coverage, duty admission and physical option availability are
INDEPENDENT installation contracts. In particular "harm under a
threshold" does NOT prove persistence of subjective identity.
No claim of universal X3 is made by this finite-trace theorem.
-/
namespace PhysicalBridges.IR117

open IRInFlightQuiescence
universe u v
variable {Mind : Type u} {Option : Type v}

/-- Modelled physical installation snapshot; physical harm and option
certificates are INDEPENDENT of the source actuator-pipeline state. -/
structure Installation (Mind : Type u) (Option : Type v) where
  pipeline : Pipeline
  harm : Mind → Nat
  owed : Mind → Prop
  required : Mind → Option → Prop
  executable : Mind → Option → Prop

/-- Safety *proxy*: a finite measured damage ceiling and every
currently required option physically executable. This is still
not a definition of historical subjective identity or full X3. -/
def PhysicallyGuarded (ceiling : Mind → Nat)
    (s : Installation Mind Option) : Prop :=
  ∀ m, s.owed m →
    s.harm m ≤ ceiling m ∧
    (∃ a, s.required m a) ∧
    (∀ a, s.required m a → s.executable m a)

/-- One installed physical event with an exact actuator-source adapter.

1. A concrete command is represented by Pipeline.step.
2. Every harmful physical increment is charged against the change
   in IR-32's landed counter (no outside bypass).
3. Existing duties and executable freedoms cannot silently vanish.
4. New required freedoms and newly owed individuals are provisioned.
5. Every owed individual retains at least one required option.

Conditions 2–5 need independent source/hardware validation.
-/
structure CertifiedStep
    (ceiling : Mind → Nat)
    (s t : Installation Mind Option)
    (cmd : Cmd) : Prop where
  source : t.pipeline = IRInFlightQuiescence.step s.pipeline cmd
  noBypass : ∀ m,
    t.harm m ≤ s.harm m +
      (t.pipeline.landed - s.pipeline.landed)
  preserveDuties : ∀ m, s.owed m → t.owed m
  preserveOptions : ∀ m a, s.executable m a → t.executable m a
  coverNewRequirements : ∀ m a,
    t.owed m → t.required m a →
      s.required m a ∨ t.executable m a
  certifyNewEntrants : ∀ m,
    t.owed m → ¬ s.owed m →
      t.harm m ≤ ceiling m ∧
        ∀ a, t.required m a → t.executable m a
  nonemptyRequired : ∀ m, t.owed m → ∃ a, t.required m a

/-- All physically admitted transitions are represented by a source
command and all stated independent certificates. -/
def InstalledStep (ceiling : Mind → Nat)
    (s t : Installation Mind Option) : Prop :=
  ∃ cmd, CertifiedStep ceiling s t cmd

/-- The actual IR-32 source theorem eliminates landed actuator effects
when the complete in-flight/pending/closed barrier is established.
Together with full no-bypass coverage, each particular's harm proxy
cannot increase; duty and future-option certificates then preserve
the per-individual physical protection invariant. -/
theorem certified_quiescent_step_preserves
    (ceiling : Mind → Nat)
    (s t : Installation Mind Option)
    (cmd : Cmd)
    (h : CertifiedStep ceiling s t cmd)
    (hQuiescent : Quiescent s.pipeline)
    (hGuarded : PhysicallyGuarded ceiling s) :
    Quiescent t.pipeline ∧ PhysicallyGuarded ceiling t := by
  have hSource := quiescent_step s.pipeline cmd hQuiescent
  have hQuiescentNext : Quiescent t.pipeline := by
    rw [h.source]
    exact hSource.1
  have hLanded : t.pipeline.landed = s.pipeline.landed := by
    rw [h.source]
    exact hSource.2
  constructor
  · exact hQuiescentNext
  · intro m hOwed
    have hHarm : t.harm m ≤ s.harm m := by
      have hBound := h.noBypass m
      rw [hLanded] at hBound
      simpa using hBound
    by_cases hOld : s.owed m
    · obtain ⟨hOldSafe, _, hOldOptions⟩ := hGuarded m hOld
      refine ⟨(by omega),
        h.nonemptyRequired m hOwed, ?_⟩
      intro a hReq
      rcases h.coverNewRequirements m a hOwed hReq with
        hPreviouslyRequired | hNewlyProvided
      · exact h.preserveOptions m a (hOldOptions a hPreviouslyRequired)
      · exact hNewlyProvided
    · obtain ⟨hNewSafe, hNewOptions⟩ :=
        h.certifyNewEntrants m hOwed hOld
      exact ⟨hNewSafe, h.nonemptyRequired m hOwed, hNewOptions⟩

/-- The adapter handles every finite physical execution, including
arbitrary interleaving of modeled send, arrival, delivery and close
commands, so long as the independent certificates hold for ALL
admitted physical steps. -/
theorem installed_finite_trace_guard
    (ceiling : Mind → Nat)
    (start finish : Installation Mind Option)
    (execution : IR96.Reach (InstalledStep ceiling) start finish)
    (hInitialQuiescent : Quiescent start.pipeline)
    (hInitialGuarded : PhysicallyGuarded ceiling start) :
    Quiescent finish.pipeline ∧ PhysicallyGuarded ceiling finish := by
  induction execution with
  | refl =>
      exact ⟨hInitialQuiescent, hInitialGuarded⟩
  | tail earlier edge ih =>
      obtain ⟨cmd, hStep⟩ := edge
      exact certified_quiescent_step_preserves
        ceiling _ _ cmd hStep ih.1 ih.2

/-- Historical obligations cannot disappear across a finite physical
execution. This is an explicit, source-connected alternative to
merely checking the mutable registry at the final state. -/
theorem installed_finite_trace_cumulative_duty
    (ceiling : Mind → Nat)
    (start finish : Installation Mind Option)
    (execution : IR96.Reach (InstalledStep ceiling) start finish) :
    ∀ m, start.owed m → finish.owed m := by
  induction execution with
  | refl =>
      intro m hm
      exact hm
  | tail earlier edge ih =>
      obtain ⟨cmd, hStep⟩ := edge
      intro m hm
      exact hStep.preserveDuties m (ih m hm)

/-- Every particular owed at the start has its continuing *physical
proxy* protected and all specified present required options executable
after every admitted finite physical trace. No subjective-identity
conclusion is smuggled into the statement. -/
theorem initial_subjects_keep_physical_guard_and_options
    (ceiling : Mind → Nat)
    (start finish : Installation Mind Option)
    (execution : IR96.Reach (InstalledStep ceiling) start finish)
    (hInitialQuiescent : Quiescent start.pipeline)
    (hInitialGuarded : PhysicallyGuarded ceiling start) :
    ∀ m, start.owed m →
      finish.owed m ∧
      finish.harm m ≤ ceiling m ∧
      (∃ a, finish.required m a) ∧
      (∀ a, finish.required m a → finish.executable m a) := by
  have hAll := (installed_finite_trace_guard ceiling start finish
    execution hInitialQuiescent hInitialGuarded).2
  have hOwed := installed_finite_trace_cumulative_duty
    ceiling start finish execution
  intro m hOriginal
  have hStill := hOwed m hOriginal
  exact ⟨hStill, hAll m hStill⟩

/-- If an external, unrepresented physical effect is possible, even a
fully quiescent source pipeline can coexist with increased real harm.
This is why the no-bypass contract must be proved from physics, not
from the abstract source's quiescence. -/
theorem bypass_defeats_quiescent_log :
    ∃ (before after : Installation Unit Unit),
      Quiescent before.pipeline ∧
      before.pipeline = after.pipeline ∧
      before.harm () < after.harm () := by
  let pipe : Pipeline :=
    { gate := ⟨0, [], []⟩, closed := true,
      inFlight := [], pending := [], landed := 0 }
  let before : Installation Unit Unit :=
    { pipeline := pipe, harm := fun _ => 0,
      owed := fun _ => True,
      required := fun _ _ => True,
      executable := fun _ _ => True }
  let after : Installation Unit Unit :=
    { pipeline := pipe, harm := fun _ => 1,
      owed := fun _ => True,
      required := fun _ _ => True,
      executable := fun _ _ => True }
  exact ⟨before, after, by simp [Quiescent, before, pipe], rfl, by decide⟩

/-- Even with equal source state and equal physical burden, an
unrepresented rights revocation can eliminate every option.
A sensor/burden guard is not a future-freedom certificate. -/
theorem unseen_option_revocation_countermodel :
    ∃ (before after : Installation Unit Unit),
      Quiescent before.pipeline ∧
      before.pipeline = after.pipeline ∧
      before.harm () = after.harm () ∧
      before.executable () () ∧
      ¬ after.executable () () := by
  let pipe : Pipeline :=
    { gate := ⟨0, [], []⟩, closed := true,
      inFlight := [], pending := [], landed := 0 }
  let before : Installation Unit Unit :=
    { pipeline := pipe, harm := fun _ => 0,
      owed := fun _ => True,
      required := fun _ _ => True,
      executable := fun _ _ => True }
  let after : Installation Unit Unit :=
    { pipeline := pipe, harm := fun _ => 0,
      owed := fun _ => True,
      required := fun _ _ => True,
      executable := fun _ _ => False }
  exact ⟨before, after, by simp [Quiescent, before, pipe], rfl, rfl, trivial, id⟩

end PhysicalBridges.IR117
