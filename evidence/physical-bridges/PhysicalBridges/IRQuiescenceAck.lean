/-
IR-30: a FRESH, SOUND quiescence acknowledgment constrains ALL future
modeled deliveries, not merely the first. A stale acknowledgment is unsafe.
No physical network timing, cancellation endowment, or future dispatch
exclusion is inferred from a Boolean flag in a synthetic state.
-/
import PhysicalBridges.IRDeferredEffects

namespace PhysicalBridges.IRQuiescenceAck

/-- A physical queue-empty acknowledgement is true exactly when there is
no pending physical work in this idealized queue state. -/
def ack (s : IRDeferredEffects.Deferred) : Bool :=
  match s.pending with
  | [] => true
  | _ :: _ => false

theorem ack_sound (s : IRDeferredEffects.Deferred)
    (h : ack s = true) : s.pending = [] := by
  cases hp : s.pending with
  | nil => rfl
  | cons e rest =>
      simp [ack, hp] at h

def deliverMany : Nat → IRDeferredEffects.Deferred →
    IRDeferredEffects.Deferred
  | 0, s => s
  | n + 1, s => deliverMany n (IRDeferredEffects.deliver s)

/-- A currently valid quiescence certificate prevents ANY number of
modeled deliveries from increasing the physical landed-effect counter. -/
theorem no_landing_after_fresh_ack :
    ∀ n (s : IRDeferredEffects.Deferred), ack s = true →
      (deliverMany n s).landed = s.landed ∧
      (deliverMany n s).pending = [] := by
  intro n
  induction n with
  | zero =>
      intro s h
      exact ⟨rfl, ack_sound s h⟩
  | succ n ih =>
      intro s h
      have empty := ack_sound s h
      have hOne : (IRDeferredEffects.deliver s).landed = s.landed ∧
          (IRDeferredEffects.deliver s).pending = [] :=
        IRDeferredEffects.no_landing_of_empty_backlog s empty
      have hAck : ack (IRDeferredEffects.deliver s) = true := by
        simp [ack, hOne.2]
      have hRest := ih (IRDeferredEffects.deliver s) hAck
      constructor
      · calc
          (deliverMany (n + 1) s).landed =
            (deliverMany n (IRDeferredEffects.deliver s)).landed := rfl
          _ = (IRDeferredEffects.deliver s).landed := hRest.1
          _ = s.landed := hOne.1
      · exact hRest.2

/-- Controller hold + physically current queue-empty acknowledgement:
as long as NO NEW DISPATCH occurs, arbitrary repeated deliveries cannot
land anything. Separately derive original UPTFence log safety. -/
theorem certified_quiescent_hold
    (s : IRDeferredEffects.Deferred) (g n : Nat)
    (events : List UPTFence.Ev)
    (oldTokens : ∀ h, h ∈ s.gate.minted → h ≤ g)
    (laterTokens : ∀ h, UPTFence.Ev.mint h ∈ events → h ≤ g)
    (freshAck : ack s = true) :
    (UPTFence.run (IRDeferredEffects.hold s g).gate events).log = s.gate.log ∧
    (deliverMany n (IRDeferredEffects.hold s g)).landed = s.landed := by
  constructor
  · exact UPTFence.raise_then_nothing_lands
      s.gate g events oldTokens laterTokens
  · have h : ack (IRDeferredEffects.hold s g) = true := by
      simpa [ack, IRDeferredEffects.hold] using freshAck
    exact (no_landing_after_fresh_ack n
      (IRDeferredEffects.hold s g) h).1

/-- A stale receipt from a BEFORE state cannot prove a later queue is empty.
Same controller gate, same origin, different pending physical work. -/
theorem stale_ack_does_not_protect :
    ∃ old now : IRDeferredEffects.Deferred,
      ack old = true ∧ old.gate = now.gate ∧
      ack now = false ∧
      now.landed < (IRDeferredEffects.deliver now).landed := by
  refine ⟨⟨⟨0, [], []⟩, [], 0⟩,
    ⟨⟨0, [], []⟩, [1], 0⟩, ?_, ?_, ?_, ?_⟩
  · rfl
  · rfl
  · rfl
  · change 0 < 1
    exact Nat.zero_lt_one

#print axioms ack_sound
#print axioms no_landing_after_fresh_ack
#print axioms certified_quiescent_hold
#print axioms stale_ack_does_not_protect
end PhysicalBridges.IRQuiescenceAck
