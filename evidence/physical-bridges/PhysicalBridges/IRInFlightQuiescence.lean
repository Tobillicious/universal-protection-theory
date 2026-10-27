/-
IR-32: a physical actuator protocol has TWO effect backlogs:
in-flight commands and accepted-but-undelivered actuator work.
Closing new admission and seeing an empty actuator queue is insufficient
if effects already in flight can arrive and then be delivered.
This model is discrete and assumes every physical effect is represented.
-/
import PhysicalBridges.IRAtomicQuiescence

namespace PhysicalBridges.IRInFlightQuiescence

structure Pipeline where
  gate : UPTFence.St
  closed : Bool
  inFlight : List Nat
  pending : List Nat
  landed : Nat

def close (s : Pipeline) (g : Nat) : Pipeline :=
  { s with closed := true, gate := UPTFence.apply s.gate (.raise (g + 1)) }

def send (s : Pipeline) (impact : Nat) : Pipeline :=
  if s.closed then s else { s with inFlight := s.inFlight ++ [impact] }

def arrive (s : Pipeline) : Pipeline :=
  match s.inFlight with
  | [] => s
  | impact :: rest =>
    { s with inFlight := rest, pending := impact :: s.pending }

def deliver (s : Pipeline) : Pipeline :=
  match s.pending with
  | [] => s
  | impact :: rest =>
    { s with pending := rest, landed := s.landed + impact }

inductive Cmd
  | close (generation : Nat)
  | send (impact : Nat)
  | arrive
  | deliver

def step (s : Pipeline) : Cmd → Pipeline
  | .close g => close s g
  | .send impact => send s impact
  | .arrive => arrive s
  | .deliver => deliver s

def run (s : Pipeline) (cmds : List Cmd) : Pipeline :=
  cmds.foldl step s

/-- The complete modeled barrier requires admissions to be closed and
both in-flight and accepted-but-undelivered work to be absent. -/
def Quiescent (s : Pipeline) : Prop :=
  s.closed = true ∧ s.inFlight = [] ∧ s.pending = []

/-- One arbitrary modeled command preserves full quiescence and cannot
cause a physical effect after the complete barrier has been certified. -/
theorem quiescent_step (s : Pipeline) (c : Cmd) (h : Quiescent s) :
    Quiescent (step s c) ∧ (step s c).landed = s.landed := by
  obtain ⟨hClosed, hInFlight, hPending⟩ := h
  cases c with
  | close g =>
      exact ⟨⟨rfl, by simpa [step, close] using hInFlight,
        by simpa [step, close] using hPending⟩, rfl⟩
  | send e =>
      have hs : send s e = s := by simp [send, hClosed]
      simp only [step, hs]
      exact ⟨⟨hClosed, hInFlight, hPending⟩, trivial⟩
  | arrive =>
      have hs : arrive s = s := by simp [arrive, hInFlight]
      simp only [step, hs]
      exact ⟨⟨hClosed, hInFlight, hPending⟩, trivial⟩
  | deliver =>
      have hs : deliver s = s := by simp [deliver, hPending]
      simp only [step, hs]
      exact ⟨⟨hClosed, hInFlight, hPending⟩, trivial⟩

/-- The property holds under arbitrary finite interleavings of dispatch,
transport, delivery and further close commands. -/
theorem barrier_holds_under_any_finite_interleaving :
    ∀ cmds (s : Pipeline), Quiescent s →
      Quiescent (run s cmds) ∧ (run s cmds).landed = s.landed := by
  intro cmds
  induction cmds with
  | nil =>
      intro s hs
      exact ⟨hs, rfl⟩
  | cons op rest ih =>
      intro s hs
      obtain ⟨hNext, hStill⟩ := quiescent_step s op hs
      obtain ⟨hEnd, hLanded⟩ := ih (step s op) hNext
      refine ⟨hEnd, ?_⟩
      calc
        (run s (op :: rest)).landed = (run (step s op) rest).landed := rfl
        _ = (step s op).landed := hLanded
        _ = s.landed := hStill

theorem close_fully_drained_is_quiescent (s : Pipeline) (g : Nat)
    (hFlight : s.inFlight = []) (hPending : s.pending = []) :
    Quiescent (close s g) := by
  exact ⟨rfl, by simpa [close] using hFlight,
    by simpa [close] using hPending⟩

/-- Source log finality and all modeled physical-delivery finality now
include the new in-flight-drain precondition. -/
theorem source_certified_finality_with_inflight_barrier
    (s : Pipeline) (g : Nat) (journal : List UPTFence.Ev)
    (effects : List Cmd)
    (oldTokens : ∀ token, token ∈ s.gate.minted → token ≤ g)
    (newTokens : ∀ token, UPTFence.Ev.mint token ∈ journal → token ≤ g)
    (hFlight : s.inFlight = [])
    (hPending : s.pending = []) :
    (UPTFence.run (close s g).gate journal).log = s.gate.log ∧
      (run (close s g) effects).landed = s.landed := by
  constructor
  · exact UPTFence.raise_then_nothing_lands
      s.gate g journal oldTokens newTokens
  · exact (barrier_holds_under_any_finite_interleaving
      effects (close s g)
      (close_fully_drained_is_quiescent s g hFlight hPending)).2

/-- Queue-only acknowledgement is unsound: a previously sent effect can
arrive and land after admission has closed and pending is empty. -/
theorem in_flight_defeats_queue_only_ack :
    ∃ s : Pipeline, (close s 0).closed = true ∧
      (close s 0).pending = [] ∧
      s.landed < (run (close s 0) [.arrive, .deliver]).landed := by
  refine ⟨⟨⟨0, [], []⟩, false, [1], [], 0⟩, rfl, rfl, ?_⟩
  change 0 < 1
  exact Nat.zero_lt_one

/-- Even both empty queues are insufficient if new dispatch remains open. -/
theorem open_admission_defeats_empty_backlogs :
    ∃ s : Pipeline, s.inFlight = [] ∧ s.pending = [] ∧
      s.landed < (run s [.send 1, .arrive, .deliver]).landed := by
  refine ⟨⟨⟨0, [], []⟩, false, [], [], 0⟩, rfl, rfl, ?_⟩
  change 0 < 1
  exact Nat.zero_lt_one

#print axioms quiescent_step
#print axioms barrier_holds_under_any_finite_interleaving
#print axioms source_certified_finality_with_inflight_barrier
#print axioms in_flight_defeats_queue_only_ack
#print axioms open_admission_defeats_empty_backlogs
end PhysicalBridges.IRInFlightQuiescence
