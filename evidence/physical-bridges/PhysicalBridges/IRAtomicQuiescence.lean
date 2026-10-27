/-
IR-31: a race-free idealized actuator hold must CLOSE ADMISSIONS and
DRAIN all prior physical effects. An empty queue alone is insufficient.
A separately modeled external bypass or faulty atomicity remains open.
-/
import PhysicalBridges.IRQuiescenceAck

namespace PhysicalBridges.IRAtomicQuiescence

/-- Controller record and distinct actuator state. The gate is the source
UPTFence.St, while "closed" belongs to the physical actuator interface. -/
structure Plant where
  gate : UPTFence.St
  closed : Bool
  pending : List Nat
  landed : Nat

def close (s : Plant) (g : Nat) : Plant :=
  { s with gate := UPTFence.apply s.gate (.raise (g + 1)), closed := true }

def dispatch (s : Plant) (effect : Nat) : Plant :=
  if s.closed then s else { s with pending := s.pending ++ [effect] }

def deliver (s : Plant) : Plant :=
  match s.pending with
  | [] => s
  | effect :: remaining =>
    { s with pending := remaining, landed := s.landed + effect }

inductive Cmd
  | close (generation : Nat)
  | dispatch (effect : Nat)
  | deliver

def step (s : Plant) : Cmd → Plant
  | .close g => close s g
  | .dispatch e => dispatch s e
  | .deliver => deliver s

def run (s : Plant) (history : List Cmd) : Plant :=
  history.foldl step s

/-- The complete modeled quiescence certificate needs BOTH facts. -/
def Quiescent (s : Plant) : Prop :=
  s.closed = true ∧ s.pending = []

theorem closed_dispatch_is_noop (s : Plant) (e : Nat)
    (hClosed : s.closed = true) : dispatch s e = s := by
  simp [dispatch, hClosed]

theorem quiescent_step (s : Plant) (op : Cmd)
    (h : Quiescent s) :
    Quiescent (step s op) ∧ (step s op).landed = s.landed := by
  obtain ⟨hClosed, hEmpty⟩ := h
  cases op with
  | close g =>
      constructor
      · constructor
        · rfl
        · simpa [step, close] using hEmpty
      · rfl
  | dispatch e =>
      have hn := closed_dispatch_is_noop s e hClosed
      simp only [step, hn]
      exact ⟨⟨hClosed, hEmpty⟩, rfl⟩
  | deliver =>
      have hn : deliver s = s := by simp [deliver, hEmpty]
      simp only [step, hn]
      exact ⟨⟨hClosed, hEmpty⟩, rfl⟩

/-- When admission is closed AND the entire physical queue is drained,
every finite future sequence of modeled closes, dispatches and deliveries
preserves the complete quiescence certificate and the landed counter. -/
theorem quiescent_under_arbitrary_finite_commands :
    ∀ (history : List Cmd) (s : Plant),
      Quiescent s →
      Quiescent (run s history) ∧ (run s history).landed = s.landed := by
  intro history
  induction history with
  | nil =>
      intro s hs
      exact ⟨hs, rfl⟩
  | cons op rest ih =>
      intro s hs
      obtain ⟨nextQ, noEffect⟩ := quiescent_step s op hs
      have hRest := ih (step s op) nextQ
      constructor
      · exact hRest.1
      · calc
          (run s (op :: rest)).landed =
            (run (step s op) rest).landed := rfl
          _ = (step s op).landed := hRest.2
          _ = s.landed := noEffect

/-- The closure operation does not pretend to erase a physical backlog.
An empty pre-closure queue is an EXPLICIT premise. -/
theorem close_empty_queue_is_quiescent (s : Plant) (g : Nat)
    (hEmpty : s.pending = []) : Quiescent (close s g) := by
  exact ⟨rfl, by simpa [close] using hEmpty⟩

theorem close_then_no_modeled_landing
    (s : Plant) (g : Nat) (history : List Cmd)
    (hEmpty : s.pending = []) :
    (run (close s g) history).landed = s.landed := by
  have h := quiescent_under_arbitrary_finite_commands
    history (close s g) (close_empty_queue_is_quiescent s g hEmpty)
  exact h.2

/-- The original UPTFence theorem and the new physical actuator invariant
join at a common certified hold, under separate, explicit hypotheses. -/
theorem source_certified_log_and_quiescent_actuator
    (s : Plant) (g : Nat)
    (journal : List UPTFence.Ev) (physicalHistory : List Cmd)
    (oldTokens : ∀ token, token ∈ s.gate.minted → token ≤ g)
    (newTokens : ∀ token, UPTFence.Ev.mint token ∈ journal → token ≤ g)
    (hEmpty : s.pending = []) :
    (UPTFence.run (close s g).gate journal).log = s.gate.log ∧
      (run (close s g) physicalHistory).landed = s.landed := by
  constructor
  · exact UPTFence.raise_then_nothing_lands
      s.gate g journal oldTokens newTokens
  · exact close_then_no_modeled_landing s g physicalHistory hEmpty

/-- A queue-empty acknowledgement without a closed admission gate fails:
one new dispatch followed by one delivery produces physical effect. -/
theorem empty_unclosed_queue_counterexample :
    ∃ s : Plant, s.pending = [] ∧
      s.landed < (run s [.dispatch 1, .deliver]).landed := by
  refine ⟨⟨⟨0, [], []⟩, false, [], 0⟩, rfl, ?_⟩
  change 0 < 1
  exact Nat.zero_lt_one

/-- Closing admissions alone does not cancel previously accepted effects. -/
theorem closed_but_not_drained_counterexample :
    ∃ s : Plant, (close s 0).closed = true ∧
      s.landed < (run (close s 0) [.deliver]).landed := by
  refine ⟨⟨⟨0, [], []⟩, false, [1], 0⟩, rfl, ?_⟩
  change 0 < 1
  exact Nat.zero_lt_one

#print axioms quiescent_step
#print axioms quiescent_under_arbitrary_finite_commands
#print axioms close_then_no_modeled_landing
#print axioms source_certified_log_and_quiescent_actuator
#print axioms empty_unclosed_queue_counterexample
#print axioms closed_but_not_drained_counterexample
end PhysicalBridges.IRAtomicQuiescence
