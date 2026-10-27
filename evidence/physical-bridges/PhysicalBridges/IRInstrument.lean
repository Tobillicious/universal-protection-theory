/-
IR-11: an idealized instrument with an independently updated physical-effect
register. This proves the log/physical-register relation for all modeled
transitions rather than assuming endpoint correspondence as in IR-5.
It does NOT prove complete mediation or correct hardware implementation.
-/
import ControllerFence

namespace PhysicalBridges.IRInstrument
open UPTController

structure Instrument where
  target : UPTFence.St
  physical : Nat

def execute (impact : Nat → Nat) (s : Instrument) : UPTFence.Ev → Instrument
  | .raise g => { s with target := UPTFence.apply s.target (.raise g) }
  | .mint g => { s with target := UPTFence.apply s.target (.mint g) }
  | .write g =>
    if s.target.floor ≤ g ∧ g ∈ s.target.minted then
      { target := UPTFence.apply s.target (.write g),
        physical := s.physical + impact g }
    else s

/-- Every concrete gate step implements the unchanged source-level gate. -/
theorem execute_target (impact : Nat → Nat) (s : Instrument) (e : UPTFence.Ev) :
    (execute impact s e).target = UPTFence.apply s.target e := by
  cases e with
  | raise g => rfl
  | mint g => rfl
  | write g =>
    by_cases h : s.target.floor ≤ g ∧ g ∈ s.target.minted
    · simp [execute, UPTFence.apply, h]
    · simp [execute, UPTFence.apply, h]

def Coupled (impact : Nat → Nat) (base : Nat) (s : Instrument) : Prop :=
  s.physical = base + (s.target.log.map impact).sum

/-- Coupling is preserved by each modeled event, including rejected writes. -/
theorem execute_coupled
    (impact : Nat → Nat) (base : Nat) (s : Instrument) (e : UPTFence.Ev)
    (h : Coupled impact base s) :
    Coupled impact base (execute impact s e) := by
  cases e with
  | raise g => simpa [Coupled, execute, UPTFence.apply] using h
  | mint g => simpa [Coupled, execute, UPTFence.apply] using h
  | write g =>
    by_cases ha : s.target.floor ≤ g ∧ g ∈ s.target.minted
    · have hh := congrArg (fun n => n + impact g) h
      simpa [Coupled, execute, UPTFence.apply, ha,
        List.map_append, List.sum_append,
        Nat.add_assoc, Nat.add_comm, Nat.add_left_comm] using hh
    · simpa [Coupled, execute, UPTFence.apply, ha] using h

def run (impact : Nat → Nat) (s : Instrument) (trace : List UPTFence.Ev) :
    Instrument := trace.foldl (execute impact) s

theorem run_target (impact : Nat → Nat) :
    ∀ trace (s : Instrument),
      (run impact s trace).target = UPTFence.run s.target trace := by
  intro trace
  induction trace with
  | nil => intro s; rfl
  | cons e es ih =>
    intro s
    calc
      (run impact s (e :: es)).target =
        (run impact (execute impact s e) es).target := rfl
      _ = UPTFence.run (execute impact s e).target es := ih _
      _ = UPTFence.run (UPTFence.apply s.target e) es := by rw [execute_target]
      _ = UPTFence.run s.target (e :: es) := rfl

theorem run_coupled (impact : Nat → Nat) (base : Nat) :
    ∀ trace s, Coupled impact base s →
      Coupled impact base (run impact s trace) := by
  intro trace
  induction trace with
  | nil => intro s h; exact h
  | cons e es ih =>
    intro s h
    exact ih (execute impact s e) (execute_coupled impact base s e h)

/-- The actual certified-hold theorem prevents modeled physical effects,
using the proved coupled-register invariant rather than IR-5's endpoint
physical/log equality premises. -/
theorem certified_hold_prevents_modeled_effects
    (impact : Nat → Nat) (base : Nat) (s : Instrument)
    (hCoupled : Coupled impact base s)
    (enrol : Nat → List Nat) (start : State)
    (before during : List Op) (c : Context)
    (retired : (step enrol (UPTController.run enrol start before) (.retire c)).2 =
      .floor c (c.generation + 1))
    (noRelease : ∀ d, Op.release d ∉ during)
    (events : List UPTFence.Ev)
    (tokens : ∀ g, g ∈ s.target.minted →
      UPTControllerFence.TokenWitness enrol start (before ++ .retire c :: during) g)
    (later : ∀ g, UPTFence.Ev.mint g ∈ events →
      UPTControllerFence.TokenWitness enrol start (before ++ .retire c :: during) g) :
    (run impact (execute impact s (.raise (c.generation + 1))) events).physical =
      s.physical := by
  have hSource :
      (UPTFence.run
        (UPTFence.apply s.target (.raise (c.generation + 1))) events).log =
      s.target.log :=
    UPTControllerFence.certified_hold_nothing_lands
      enrol start before during c retired noRelease
      s.target events tokens later
  have hLog :
      (run impact (execute impact s (.raise (c.generation + 1))) events).target.log =
      s.target.log := by
    rw [run_target, execute_target]
    exact hSource
  have hPost : Coupled impact base
      (run impact (execute impact s (.raise (c.generation + 1))) events) :=
    run_coupled impact base events _
      (execute_coupled impact base s _ hCoupled)
  calc
    (run impact (execute impact s (.raise (c.generation + 1))) events).physical
      = base + ((run impact (execute impact s (.raise (c.generation + 1))) events).target.log.map impact).sum := hPost
    _ = base + (s.target.log.map impact).sum := by rw [hLog]
    _ = s.physical := hCoupled.symm

/-- A bypass transition defeats the implication if mediation is incomplete. -/
theorem bypass_counterexample :
    ∃ (s t : Instrument), s.target = t.target ∧
      s.physical ≠ t.physical := by
  let gate : UPTFence.St := ⟨0, [], []⟩
  refine ⟨⟨gate, 0⟩, ⟨gate, 1⟩, rfl, ?_⟩
  decide

#print axioms execute_target
#print axioms execute_coupled
#print axioms run_target
#print axioms run_coupled
#print axioms certified_hold_prevents_modeled_effects
#print axioms bypass_counterexample
end PhysicalBridges.IRInstrument
