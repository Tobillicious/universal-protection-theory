/-! Ported from Paper 12 `evidence/papers-11-12/lean/modules/DeliveryGap.lean` (source sha256 `b62bf20d840e975f4a99c8ac0b3df76344e012286b878c46d3690a9d04e8e3a6`).
Namespace renamed to `Snuffy.Book.DeliveryGap`; dependency imports and namespace references redirected to the canon. Inline `#print axioms` commands are removed here and every public theorem is audited by SummitsAudit. Statements and proofs unchanged. -/

namespace Snuffy.Book.DeliveryGap

/-- A crash can leave the same local pending record in two worlds: the non-idempotent external effect
    occurred before the crash, or it did not. Recovery has no query/receipt distinguishing the worlds. -/
def totalEffects (priorDelivered resend : Bool) : Nat :=
  (if priorDelivered then 1 else 0) + (if resend then 1 else 0)

theorem no_local_choice_succeeds_in_both_worlds (resend : Bool) :
    ∃ priorDelivered, totalEffects priorDelivered resend ≠ 1 := by
  cases resend with
  | false => exact ⟨false,by decide⟩
  | true => exact ⟨true,by decide⟩

theorem indistinguishable_local_recovery (recover : Unit → Bool) :
    ∃ priorDelivered, totalEffects priorDelivered (recover ()) ≠ 1 :=
  no_local_choice_succeeds_in_both_worlds (recover ())

/-- A durable sink-side ID changes the interface: resend applies the effect only if absent. This abstract
    primitive succeeds; the theorem does not implement its durability or external-effect transaction. -/
def idempotentTotal (priorDelivered : Bool) : Nat :=
  if priorDelivered then 1 else 0 + 1

theorem sink_side_identity_resolves_this_gap (priorDelivered : Bool) : idempotentTotal priorDelivered = 1 := by
  cases priorDelivered <;> rfl

/-- A trusted distinguishing query is another sufficient interface in this model; a sink ID is not
    asserted necessary for every possible architecture. -/
theorem distinguishing_query_resolves_this_gap (priorDelivered : Bool) :
    totalEffects priorDelivered (!priorDelivered) = 1 := by
  cases priorDelivered <;> rfl

end Snuffy.Book.DeliveryGap
