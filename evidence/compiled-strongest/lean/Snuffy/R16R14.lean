import Snuffy.R14Boundary
import Snuffy.R16TwoPhase

/-! The abstract product is specified using R14's three pre-existing local
transitions and a separately specified breach latch. The actual source transition
is imported unchanged. This proves a source reference, not a physical installation.
-/
namespace UPTR16R14
open UPTR14Boundary
open UPTR16

structure PortState where
  journal : J
  sink : J
  outside : Outside
  compromised : Bool
  deriving DecidableEq, Repr

def project (s : St) : PortState :=
  ⟨projectJ s, projectK s, projectOutside s, s.compromised⟩

def breachFlag : Ev → Bool
  | .breach => true
  | _ => false

def portStep (a : PortState) (e : Ev) : PortState :=
  ⟨jStep a.journal e, kStep a.sink e, outsideStep a.outside e,
    a.compromised || breachFlag e⟩

theorem compromise_commutes (s : St) (e : Ev) :
    (step s e).compromised = (s.compromised || breachFlag e) := by
  cases e with
  | journal g n payload =>
      by_cases h : s.floor ≤ g ∧ n ∉ s.usedJ <;> simp [step, breachFlag, h]
  | effect g n payload harmful =>
      by_cases h : s.floor ≤ g ∧ n ∉ s.usedK ∧ harmful = false <;>
        simp [step, breachFlag, h]
  | raise g => simp [step, breachFlag]
  | weather d => simp [step, breachFlag]
  | recruit i b => simp [step, breachFlag]
  | breach => simp [step, breachFlag]

theorem project_step (s : St) (e : Ev) :
    project (step s e) = portStep (project s) e := by
  simp only [project, portStep, journal_commutes, sink_commutes,
    outside_commutes, compromise_commutes]

theorem reference_two_phase_lockstep {O : Type} (observe : PortState → O)
    (controller : History O (Ev × O × O) → Ev)
    (environment : History O (Ev × O × O) → Ev → O → Ev)
    (n : Nat) (s : St) :
    mapState project (iterate (phaseTick step step (fun s => observe (project s))
      controller environment) n ⟨s, ⟨observe (project s), []⟩⟩) =
    iterate (phaseTick portStep portStep observe controller environment) n
      ⟨project s, ⟨observe (project s), []⟩⟩ :=
  two_phase_lockstep step portStep step portStep project _ observe
    project_step project_step (fun _ => rfl) controller environment n s

end UPTR16R14

