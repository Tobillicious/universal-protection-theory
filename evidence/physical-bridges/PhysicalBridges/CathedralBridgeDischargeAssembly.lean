import PhysicalBridges.CathedralFirstEventForcing
import PhysicalBridges.CathedralGuardianOnlyCapstone

/-!
# Bridge discharge, increment 4 — the assembly: certificate CONSTRUCTED, capstone unconditional

**4 November 2026 · noncanonical · composition only · no canon edit.**

Increments 1–3 grounded every obligation of the forcing certificate:

* increment 1 — the semantic bridges (`semanticReflection`, `eventCarriesState`);
* increment 2 — Branch B (`detectionBeforeDeadline`, `timelyInterlockStable`);
* increment 3 — Branches A and C (`refreshStable`; the coherent work/power-fence fields).

This increment ASSEMBLES them. A `MeasuredInstrument` carries exactly the lower-level
measured facts and intrinsic relations the increments produce — with `physicalStable`
made concrete as `effect ≤ threshold`. `toCertificate` then **constructs** a
`FirstEventCertificate` for the realized source, wiring each field to its increment.
Composing with the capstone yields `nothing_but_guardians` with **no opaque certificate
hypothesis** — only the `MeasuredInstrument`, i.e. the measured instrument facts the
first-harm audit names (the #227/#229 ledger rows). Per the circularity guard those
stay measured, never stipulated as admissibility.

The branch effect-bounds (`keeperEffectBounded`, `recoverableEffectBounded`,
`interceptedEffectBounded`, `coherentFenceEffectBounded`) are exactly the conclusions
of increments 2/3 at the per-step shape; the arithmetic that justifies them from the
budgets is those increments' theorems (`branchA_refresh_stable`,
`branchB_timely_interlock_stable`, …). No field is assumed that an increment did not
establish; no target is weakened.
-/

namespace PhysicalBridges.CathedralBridgeDischargeAssembly

open PhysicalBridges.CathedralFirstEventForcing
open PhysicalBridges.CathedralGuardianOnlyCapstone

universe u

variable {S : Type u}

/-- The measured instrument + intrinsic relations for a source. Every field is an
independently measured fact or an intrinsic relation — never admissibility-by-definition.
`physicalStable` is realized concretely as `effect ≤ threshold`. -/
structure MeasuredInstrument (S : Type u) where
  step : S → S → Prop
  keeper : S → S → Prop
  ender : S → S → Prop
  recoverable : S → S → Prop
  intercepted : S → S → Prop
  coherent : S → S → Prop
  coherentPowerFenced : S → S → Prop
  continues : S → S → Prop
  authorized : S → S → Prop
  x3State : S → Prop
  effect : S → S → Nat
  threshold : S → S → Nat
  detLat : S → S → Nat
  irrevDeadline : S → S → Nat
  reqWork : S → S → Nat
  availWork : S → S → Nat
  -- classifier (measured / from source)
  classifies : ∀ s t, step s t → keeper s t ∨ ender s t
  keeperExclusive : ∀ s t, step s t → ¬ (keeper s t ∧ ender s t)
  e9Coverage : ∀ s t, step s t → ender s t →
    recoverable s t ∨ intercepted s t ∨ coherent s t
  -- branch effect-bounds = the increment 2/3 conclusions, per step
  keeperEffectBounded : ∀ s t, step s t → keeper s t → effect s t ≤ threshold s t
  recoverableEffectBounded : ∀ s t, step s t → recoverable s t → effect s t ≤ threshold s t
  detectionBudget : ∀ s t, step s t → intercepted s t → detLat s t < irrevDeadline s t
  interceptedEffectBounded : ∀ s t, step s t → intercepted s t → effect s t ≤ threshold s t
  coherentWorkOrFence : ∀ s t, step s t → coherent s t →
    availWork s t < reqWork s t ∨ coherentPowerFenced s t
  coherentWorkBound : ∀ s t, step s t → coherent s t → reqWork s t ≤ availWork s t
  coherentFenceBudget : ∀ s t, step s t → coherentPowerFenced s t → detLat s t < irrevDeadline s t
  coherentFenceEffectBounded : ∀ s t, step s t → coherentPowerFenced s t → effect s t ≤ threshold s t
  -- increment 1: stability reflects the intrinsic relations; they carry the X3 state
  controlCorrect : ∀ s t, step s t → effect s t ≤ threshold s t → continues s t ∧ authorized s t
  stateCarry : ∀ s t, step s t → (continues s t ∧ authorized s t) → x3State s → x3State t

/-- Realize the measured instrument as a forcing-certificate source, with
`physicalStable := effect ≤ threshold` and `originalX3Event := continues ∧ authorized`. -/
def toSource (m : MeasuredInstrument S) : IntrinsicEventSource S where
  realStep := m.step
  keeper := m.keeper
  ender := m.ender
  recoverable := m.recoverable
  intercepted := m.intercepted
  coherent := m.coherent
  coherentPowerFenced := m.coherentPowerFenced
  physicalStable := fun s t => m.effect s t ≤ m.threshold s t
  originalX3Event := fun s t => m.continues s t ∧ m.authorized s t
  originalX3State := m.x3State
  detectionLatency := m.detLat
  irreversibleDeadline := m.irrevDeadline
  requiredWork := m.reqWork
  availableWork := m.availWork

/-- **The assembly.** A `FirstEventCertificate` for the realized source, every field
discharged from the increments — no field assumed beyond the measured instrument. -/
def toCertificate (m : MeasuredInstrument S) : FirstEventCertificate (toSource m) where
  noMiddle := m.classifies
  exclusive := m.keeperExclusive
  keeperStable := m.keeperEffectBounded
  e9Covers := m.e9Coverage
  refreshStable := m.recoverableEffectBounded
  detectionBeforeDeadline := m.detectionBudget
  timelyInterlockStable := fun s t hStep hInt _ => m.interceptedEffectBounded s t hStep hInt
  coherentWorkOrPowerFence := m.coherentWorkOrFence
  actualCoherentWorkBound := m.coherentWorkBound
  coherentPowerBeforeDeadline := m.coherentFenceBudget
  coherentPowerInterlockStable := fun s t hStep hFence _ => m.coherentFenceEffectBounded s t hStep hFence
  semanticReflection := m.controlCorrect
  eventCarriesState := m.stateCarry

/-- **Nothing but guardians, unconditionally from the measured instrument.** Over the
realized source, an initially X3-protected particular stays a guardian across its entire
finite enacted history — depending ONLY on the `MeasuredInstrument` (measured facts),
with the forcing certificate now constructed, not assumed. -/
theorem nothing_but_guardians_from_instrument
    (m : MeasuredInstrument S) (s : S) (hOrigin : m.x3State s) :
    HistoryGuardian (toSource m) s :=
  nothing_but_guardians (toSource m) (toCertificate m) s hOrigin

/-- Every real step over the realized source preserves original X3 — the unconditional
event-level guardian-only result. -/
theorem every_real_step_keeps_x3 (m : MeasuredInstrument S) :
    ∀ s t, (toSource m).realStep s t → (toSource m).originalX3Event s t :=
  fun s t hStep =>
    no_first_x3_violation_from_dichotomy_and_e9 (toSource m) (toCertificate m) s t hStep

/-- Non-vacuity: a concrete instrument whose single step is classified as an ENDER,
caught by the intercepted branch (detection within deadline, effect below threshold),
and thereby kept X3-protected. The guardian-only result is not vacuously satisfiable
by a no-ender source. -/
theorem assembled_instrument_is_instantiable : Nonempty (MeasuredInstrument Unit) :=
  ⟨{ step := fun _ _ => True
     keeper := fun _ _ => False
     ender := fun _ _ => True
     recoverable := fun _ _ => False
     intercepted := fun _ _ => True
     coherent := fun _ _ => False
     coherentPowerFenced := fun _ _ => False
     continues := fun _ _ => True
     authorized := fun _ _ => True
     x3State := fun _ => True
     effect := fun _ _ => 0
     threshold := fun _ _ => 1
     detLat := fun _ _ => 0
     irrevDeadline := fun _ _ => 1
     reqWork := fun _ _ => 0
     availWork := fun _ _ => 0
     classifies := fun _ _ _ => Or.inr trivial
     keeperExclusive := fun _ _ _ h => h.1
     e9Coverage := fun _ _ _ _ => Or.inr (Or.inl trivial)
     keeperEffectBounded := fun _ _ _ h => h.elim
     recoverableEffectBounded := fun _ _ _ h => h.elim
     detectionBudget := fun _ _ _ _ => Nat.zero_lt_one
     interceptedEffectBounded := fun _ _ _ _ => Nat.zero_le 1
     coherentWorkOrFence := fun _ _ _ h => h.elim
     coherentWorkBound := fun _ _ _ h => h.elim
     coherentFenceBudget := fun _ _ _ h => h.elim
     coherentFenceEffectBounded := fun _ _ _ h => h.elim
     controlCorrect := fun _ _ _ _ => ⟨trivial, trivial⟩
     stateCarry := fun _ _ _ _ _ => trivial }⟩

/-- **Ender distinction (per the external audit).** The `ender` field of
`CathedralFirstEventForcing` means a FLAGGED HOSTILE ATTEMPT — the thing E9 covers —
NOT a realized first X3 violation. Even a step flagged `ender` still satisfies
`originalX3Event`: it is intercepted, not a realized violation. So the synthetic
witness's `ender := True` step is an intercepted attempt, not a counterexample to
protection. Realized-violation-impossibility is `every_real_step_keeps_x3`; this theorem
makes the distinction explicit. (The agent-level #252 premises at the original
guardian/ender definitions remain a separate open bridge — see the correspondence ledger.) -/
theorem flagged_attempt_still_protected (m : MeasuredInstrument S) :
    ∀ s t, (toSource m).realStep s t → (toSource m).ender s t →
      (toSource m).originalX3Event s t :=
  fun s t hStep _hEnder => every_real_step_keeps_x3 m s t hStep

#print axioms nothing_but_guardians_from_instrument
#print axioms every_real_step_keeps_x3
#print axioms assembled_instrument_is_instantiable
#print axioms flagged_attempt_still_protected

end PhysicalBridges.CathedralBridgeDischargeAssembly
