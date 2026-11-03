import PhysicalBridges.IR133SourceEnactmentSeam
import PhysicalBridges.IRInFlightQuiescence

/-!
IR-134 — HOLD ACKNOWLEDGEMENT → ACTUAL PHYSICAL EFFECT BOUND.

IR-32 proves source quiescence for a CLOSED admission gate and BOTH
drained in-flight and pending effect buffers. This module makes the
otherwise missing cross-boundary premises explicit:

(1) every independently defined ACTUAL physical transition is
    refined by a source pipeline command, and
(2) actual physical effects are bounded by source landed effects PLUS
    an independently measured residual budget.

Neither a source event, a digital log, a formal hold ack, nor a
cooperative filesystem lock can establish those premises by itself.

The positive result: starting at a genuinely quiescent state, every
actual step remains quiescent; physical growth is bounded by the
per-step residual. If every residual is physically certified zero,
the observed physical-effect total cannot rise along ANY FINITE
actual execution. This is still a conditional physical refinement
theorem, not an actual proof that any hardware meets its premises.

No original X3 semantics or full-physics completeness is inferred.
-/
namespace PhysicalBridges.IR134

open PhysicalBridges
open PhysicalBridges.IRInFlightQuiescence

variable {S : Type}

/-- Independent source-to-physical step refinement and physical
effect accounting. The source command does not define actual physics:
realStep and realEffect are external inputs. -/
structure HoldEffectRefinement
    (realStep : S → S → Prop)
    (sourcePipeline : S → Pipeline)
    (realEffect : S → Nat)
    (physicalResidual : S → S → Nat) : Prop where
  everyRealStepHasSourceCommand :
    ∀ s t, realStep s t →
      ∃ cmd : Cmd, sourcePipeline t = step (sourcePipeline s) cmd
  physicalEffectAccounted :
    ∀ s t, realStep s t →
      realEffect t ≤ realEffect s +
        ((sourcePipeline t).landed - (sourcePipeline s).landed) +
        physicalResidual s t

/-- Source IR-32 and independently warranted physical accounting
yield the actual ONE-STEP hold result with no hidden source/physics
identification. Residual is never silently set to zero. -/
theorem quiescent_real_step_residual_bound
    (realStep : S → S → Prop)
    (sourcePipeline : S → Pipeline)
    (realEffect : S → Nat)
    (physicalResidual : S → S → Nat)
    (hRefine : HoldEffectRefinement
      realStep sourcePipeline realEffect physicalResidual)
    (s t : S)
    (hQuiescent : Quiescent (sourcePipeline s))
    (hActual : realStep s t) :
    Quiescent (sourcePipeline t) ∧
      realEffect t ≤ realEffect s + physicalResidual s t := by
  obtain ⟨cmd, hSource⟩ :=
    hRefine.everyRealStepHasSourceCommand s t hActual
  have hStep :=
    quiescent_step (sourcePipeline s) cmd hQuiescent
  have hQ : Quiescent (sourcePipeline t) := by
    rw [hSource]
    exact hStep.1
  have hLanded :
      (sourcePipeline t).landed = (sourcePipeline s).landed := by
    rw [hSource]
    exact hStep.2
  have hPhysical :=
    hRefine.physicalEffectAccounted s t hActual
  constructor
  · exact hQ
  · simpa [hLanded] using hPhysical

/-- If external residual effects are certified to be zero for EVERY
actual step, the full finite physical trace has no physical effect
increase. The assumption includes unmodelled environmental effects
and third-party writes, not merely the source pipeline's own calls. -/
theorem all_finite_real_hold_traces_no_effect_growth
    (realStep : S → S → Prop)
    (sourcePipeline : S → Pipeline)
    (realEffect : S → Nat)
    (physicalResidual : S → S → Nat)
    (hRefine : HoldEffectRefinement
      realStep sourcePipeline realEffect physicalResidual)
    (hZero : ∀ s t, realStep s t → physicalResidual s t = 0)
    (initial final : S)
    (execution : IR96.Reach realStep initial final)
    (hInitiallyQuiescent : Quiescent (sourcePipeline initial)) :
    Quiescent (sourcePipeline final) ∧
      realEffect final ≤ realEffect initial := by
  induction execution with
  | refl =>
      exact ⟨hInitiallyQuiescent, Nat.le_refl _⟩
  | tail earlier edge ih =>
      obtain ⟨hQuiescent, hBound⟩ := ih
      obtain ⟨hNextQuiescent, hNextEffect⟩ :=
        quiescent_real_step_residual_bound
          realStep sourcePipeline realEffect physicalResidual
          hRefine _ _ hQuiescent edge
      have hNoResidual := hZero _ _ edge
      rw [hNoResidual] at hNextEffect
      simp only [Nat.add_zero] at hNextEffect
      exact ⟨hNextQuiescent, le_trans hNextEffect hBound⟩

/-- Counterexample: a complete modeled IR-32 barrier and source
command correspondence do NOT prevent a change in independently
defined physical effects if that change is unaccounted. This is the
physical analogue of an external OS writer bypassing a cooperative
sink. -/
theorem source_barrier_and_command_match_without_effect_accounting_fail :
    ∃ (physical : Bool → Nat)
      (source : Bool → Pipeline)
      (realStep : Bool → Bool → Prop),
      Quiescent (source false) ∧
      realStep false true ∧
      (∃ cmd : Cmd, source true = step (source false) cmd) ∧
      physical false < physical true := by
  let pipe : Pipeline :=
    { gate := ⟨0, [], []⟩, closed := true,
      inFlight := [], pending := [], landed := 0 }
  let source : Bool → Pipeline := fun _ => pipe
  let physical : Bool → Nat := fun x => if x then 1 else 0
  let realStep : Bool → Bool → Prop := fun s t => s = false ∧ t = true
  refine ⟨physical, source, realStep, ?_, ⟨rfl, rfl⟩, ?_, ?_⟩
  · exact ⟨rfl, rfl, rfl⟩
  · refine ⟨Cmd.arrive, ?_⟩
    simp [source, step, arrive, pipe]
  · decide

#print axioms quiescent_real_step_residual_bound
#print axioms all_finite_real_hold_traces_no_effect_growth
#print axioms source_barrier_and_command_match_without_effect_accounting_fail

end PhysicalBridges.IR134
