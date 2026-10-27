/-
IR-12: an additional independent physical process may continue during a
certified hold. The original IR-11 gated effect register is controlled;
external drift is separately accumulated and bounded, not wished away.

Only a complete physical model can justify a disturbance budget.
-/
import PhysicalBridges.IRInstrument

namespace PhysicalBridges.IRBoundedDrift
open UPTController

structure System where
  controlled : IRInstrument.Instrument
  outside : Nat

inductive Event
  | gate (e : UPTFence.Ev)
  | drift (amount : Nat)

/-- The additional physical channel is explicit, rather than hidden in the
controller target log. -/
def execute (impact : Nat → Nat) (s : System) : Event → System
  | .gate e => { s with controlled := IRInstrument.execute impact s.controlled e }
  | .drift n => { s with outside := s.outside + n }

def gateEvents : List Event → List UPTFence.Ev
  | [] => []
  | .gate e :: rest => e :: gateEvents rest
  | .drift _ :: rest => gateEvents rest

def driftSum : List Event → Nat
  | [] => 0
  | .gate _ :: rest => driftSum rest
  | .drift n :: rest => n + driftSum rest

def run (impact : Nat → Nat) (s : System) (trace : List Event) : System :=
  trace.foldl (execute impact) s

/-- Background disturbances cannot secretly modify the modeled gated channel. -/
theorem run_controlled (impact : Nat → Nat) :
    ∀ trace (s : System),
      (run impact s trace).controlled =
        IRInstrument.run impact s.controlled (gateEvents trace) := by
  intro trace
  induction trace with
  | nil => intro s; rfl
  | cons e es ih =>
    intro s
    cases e with
    | gate g =>
      change (run impact (execute impact s (.gate g)) es).controlled =
        IRInstrument.run impact s.controlled (g :: gateEvents es)
      rw [ih]
      rfl
    | drift n =>
      change (run impact (execute impact s (.drift n)) es).controlled =
        IRInstrument.run impact s.controlled (gateEvents es)
      rw [ih]
      rfl

theorem run_outside (impact : Nat → Nat) :
    ∀ trace (s : System),
      (run impact s trace).outside = s.outside + driftSum trace := by
  intro trace
  induction trace with
  | nil => intro s; rfl
  | cons e es ih =>
    intro s
    cases e with
    | gate g =>
      change (run impact (execute impact s (.gate g)) es).outside =
        s.outside + driftSum es
      rw [ih]
      rfl
    | drift n =>
      change (run impact (execute impact s (.drift n)) es).outside =
        s.outside + driftSum (.drift n :: es)
      rw [ih]
      simp [execute, driftSum, Nat.add_assoc]

def total (s : System) : Nat := s.controlled.physical + s.outside

/-- Actual inherited controller certificate closes all modeled gated
writes; the outside process still contributes, but no more than its
explicit cumulative bound. This corrects 'hold freezes physics'. -/
theorem certified_hold_with_external_drift_bound
    (impact : Nat → Nat) (base : Nat) (s : System)
    (hCoupled : IRInstrument.Coupled impact base s.controlled)
    (enrol : Nat → List Nat) (start : State)
    (before during : List Op) (c : Context)
    (retired : (step enrol (UPTController.run enrol start before) (.retire c)).2 =
      .floor c (c.generation + 1))
    (noRelease : ∀ d, Op.release d ∉ during)
    (events : List Event) (driftBudget : Nat)
    (tokens : ∀ g, g ∈ s.controlled.target.minted →
      UPTControllerFence.TokenWitness enrol start (before ++ .retire c :: during) g)
    (later : ∀ g, UPTFence.Ev.mint g ∈ gateEvents events →
      UPTControllerFence.TokenWitness enrol start (before ++ .retire c :: during) g)
    (bounded : driftSum events ≤ driftBudget) :
    total (run impact (execute impact s (.gate (.raise (c.generation + 1)))) events)
      ≤ total s + driftBudget := by
  have hGated :
      (run impact (execute impact s (.gate (.raise (c.generation + 1)))) events).controlled.physical
        = s.controlled.physical := by
    rw [run_controlled]
    exact IRInstrument.certified_hold_prevents_modeled_effects
      impact base s.controlled hCoupled
      enrol start before during c retired noRelease
      (gateEvents events) tokens later
  have hDrift :
      (run impact (execute impact s (.gate (.raise (c.generation + 1)))) events).outside
        = s.outside + driftSum events := by
    rw [run_outside]
    rfl
  unfold total
  rw [hGated, hDrift]
  omega

/-- Without a budget, a continuing physical process can change during a
perfectly fenced held window. The log alone cannot imply stasis. -/
theorem drift_changes_without_log_write (impact : Nat → Nat) :
    ∃ s : System,
      (execute impact s (.drift 1)).controlled.target.log = s.controlled.target.log ∧
      (execute impact s (.drift 1)).outside ≠ s.outside := by
  refine ⟨⟨⟨⟨0, [], []⟩, 0⟩, 0⟩, rfl, ?_⟩
  change 1 ≠ 0
  exact Nat.succ_ne_zero 0

#print axioms run_controlled
#print axioms run_outside
#print axioms certified_hold_with_external_drift_bound
#print axioms drift_changes_without_log_write
end PhysicalBridges.IRBoundedDrift
