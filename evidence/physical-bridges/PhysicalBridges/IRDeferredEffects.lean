/-
IR-29: receiving a durable fence does not necessarily cancel physical
effects authorised before the fence and already awaiting delivery.
The original UPTFence.check_at_apply_refuses addresses pending LOG writes;
this module exhibits a distinct later actuator effect after an ALREADY
logged, physically deferred operation.

No hardware cancellation, effect-pipeline atomicity, or real queue
drain behaviour is established by these abstract transitions.
-/
import ControllerFence

namespace PhysicalBridges.IRDeferredEffects

/-- Controller's source gate and an independently owned effect pipeline. -/
structure Deferred where
  gate : UPTFence.St
  pending : List Nat
  landed : Nat

def hold (s : Deferred) (g : Nat) : Deferred :=
  { s with gate := UPTFence.apply s.gate (.raise (g + 1)) }

/-- This already-authenticated effect is waiting AFTER log acceptance.
A new floor cannot retroactively undo it under the given physics. -/
def deliver (s : Deferred) : Deferred :=
  match s.pending with
  | [] => s
  | effect :: rest =>
    { s with pending := rest, landed := s.landed + effect }

/-- Even under a held controller log, a preexisting queued physical effect
may arrive. This is distinct from UPTFence's admission-only log countermodel. -/
theorem held_gate_can_still_deliver_old_physical_effect :
    ∃ s : Deferred,
      (hold s 1).gate.log = s.gate.log ∧
      (deliver (hold s 1)).gate.log = s.gate.log ∧
      s.landed < (deliver (hold s 1)).landed := by
  refine ⟨⟨⟨0, [], []⟩, [1], 0⟩, ?_, ?_, ?_⟩ <;> decide

/-- Clearing pending work in the model removes its possibility of landing.
This is only a mathematical cancellation operation, not proof that an
actual external actuator can be safely cancelled. -/
def cancelPending (s : Deferred) : Deferred :=
  { s with pending := [] }

theorem cleared_pending_has_no_delivery
    (s : Deferred) (g : Nat) :
    (deliver (hold (cancelPending s) g)).landed = s.landed := by
  rfl

theorem quiescent_hold_has_no_delivery
    (s : Deferred) (g : Nat) (hEmpty : s.pending = []) :
    (deliver (hold s g)).landed = s.landed := by
  simp [deliver, hold, hEmpty]

/-- A durable log can be unmodified by certified control events, while a
separate delayed physical channel consumes pending effects afterwards.
Imports the ORIGINAL UPTFence hold theorem and states its receipt/mint
premises without modifying them. -/
theorem certified_hold_does_not_clear_existing_queue
    (s : Deferred) (g : Nat) (events : List UPTFence.Ev)
    (hOldTokens : ∀ h, h ∈ s.gate.minted → h ≤ g)
    (hNewTokens : ∀ h, UPTFence.Ev.mint h ∈ events → h ≤ g) :
    (UPTFence.run (hold s g).gate events).log = s.gate.log ∧
    (deliver (hold s g)).landed =
      (match s.pending with
      | [] => s.landed
      | effect :: _ => s.landed + effect) := by
  constructor
  · exact UPTFence.raise_then_nothing_lands
      s.gate g events hOldTokens hNewTokens
  · cases hp : s.pending with
    | nil => simp [deliver, hold, hp]
    | cons e rest => simp [deliver, hold, hp]

/-- Final delivery has no effect when a nonempty backlog is required to be
both emptied AND unchanged: the original queued work cannot disappear
unless a separate drain, cancellation or compensation action is performed. -/
theorem no_landing_of_empty_backlog
    (s : Deferred) (hEmpty : s.pending = []) :
    (deliver s).landed = s.landed ∧
    (deliver s).pending = [] := by
  simp [deliver, hEmpty]

#print axioms held_gate_can_still_deliver_old_physical_effect
#print axioms cleared_pending_has_no_delivery
#print axioms quiescent_hold_has_no_delivery
#print axioms certified_hold_does_not_clear_existing_queue
#print axioms no_landing_of_empty_backlog
end PhysicalBridges.IRDeferredEffects
