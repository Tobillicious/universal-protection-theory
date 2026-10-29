import Snuffy.R17AQueueFinality

/-! Consequences of the actual imported R17-A transition. An immutable registry
gives an exact price ledger. Check-and-spend, target nonce consumption and both
logs occur in the same reference transition. This is application funding, not
an admission-time reservation or a proof of actual authority/physical atomicity.
-/
namespace UPTR17AFunding
open UPTR17A

def ticketCost (registry : Registry) (ticket : Nat) : Nat :=
  match registry ticket with
  | none => 0
  | some p => p.cost

def charged (registry : Registry) : List (Nat × UPTR12A.Effect) → Nat
  | [] => 0
  | (ticket, _) :: tail => ticketCost registry ticket + charged registry tail

def Reserved (registry : Registry) (s : Machine) : Prop :=
  charged registry s.pending ≤ s.credits

theorem charged_append (registry : Registry) (first tail : List (Nat × UPTR12A.Effect)) :
    charged registry (first ++ tail) = charged registry first + charged registry tail := by
  induction first with
  | nil => simp [charged]
  | cons item rest ih => cases item; simp [charged, ih, Nat.add_assoc]

theorem atomic_target_append (registry : Registry) (s : Machine)
    (ticket : Nat) (e : UPTR12A.Effect) (p : Contract)
    (registered : registry ticket = some p) (ready : Ready s ticket e p) :
    (applyOne registry s ticket e).target.committed = s.target.committed ++ [e] ∧
    (applyOne registry s ticket e).applied = s.applied ++ [(ticket,e)] := by
  classical
  simp [applyOne, registered, ready, UPTR12A.applyEffect, ready.sourceAccepts]

theorem application_conserves_funding (registry : Registry) (s : Machine)
    (ticket : Nat) (e : UPTR12A.Effect) :
    (applyOne registry s ticket e).credits + charged registry (applyOne registry s ticket e).applied =
      s.credits + charged registry s.applied := by
  classical
  cases registered : registry ticket with
  | none => simp [applyOne, registered]
  | some p =>
      by_cases ready : Ready s ticket e p
      · have funded := ready.enoughCredit
        simp only [applyOne, registered, ready, ↓reduceIte]
        simp only [charged_append, charged, ticketCost, registered]
        omega
      · simp [applyOne, registered, ready]

noncomputable def applyTrace (registry : Registry) : Machine → List (Nat × UPTR12A.Effect) → Machine
  | s, [] => s
  | s, (ticket,e) :: rest => applyTrace registry (applyOne registry s ticket e) rest

theorem trace_conserves_funding (registry : Registry) (s : Machine)
    (requests : List (Nat × UPTR12A.Effect)) :
    (applyTrace registry s requests).credits + charged registry (applyTrace registry s requests).applied =
      s.credits + charged registry s.applied := by
  induction requests generalizing s with
  | nil => rfl
  | cons request rest ih =>
      obtain ⟨ticket,e⟩ := request
      rw [applyTrace, ih, application_conserves_funding]

theorem cumulative_charge_is_funded (registry : Registry) (s : Machine)
    (requests : List (Nat × UPTR12A.Effect)) :
    charged registry (applyTrace registry s requests).applied ≤
      s.credits + charged registry s.applied := by
  have conservation := trace_conserves_funding registry s requests
  omega

theorem used_ticket_refuses (registry : Registry) (s : Machine)
    (ticket : Nat) (e : UPTR12A.Effect) (used : ticket ∈ s.target.usedNonces) :
    (applyOne registry s ticket e).applied = s.applied := by
  classical
  apply Classical.byContradiction
  intro changed
  obtain ⟨p, _, ready⟩ := new_effect_has_current_permit registry s ticket e changed
  apply ready.sourceAccepts.2.2.2.2.2
  simpa [ready.nonceBinds] using used

theorem accepted_ticket_is_consumed (registry : Registry) (s : Machine)
    (ticket : Nat) (e : UPTR12A.Effect) (p : Contract)
    (registered : registry ticket = some p) (ready : Ready s ticket e p) :
    ticket ∈ (applyOne registry s ticket e).target.usedNonces := by
  classical
  simp [applyOne, registered, ready, UPTR12A.applyEffect, ready.sourceAccepts, ready.nonceBinds]

theorem replay_cannot_append (registry : Registry) (s : Machine)
    (ticket : Nat) (e : UPTR12A.Effect) (p : Contract)
    (registered : registry ticket = some p) (ready : Ready s ticket e p) :
    (applyOne registry (applyOne registry s ticket e) ticket e).applied =
      (applyOne registry s ticket e).applied :=
  used_ticket_refuses registry _ ticket e
    (accepted_ticket_is_consumed registry s ticket e p registered ready)

/-- A new financial admission gate. It reserves the immutable registry price
against all outstanding requests. It does not assume a future permit stays live.
Unchanged R17-A still rechecks Ready at application, and may refuse the effect. -/
def fundedEnqueue (registry : Registry) (s : Machine)
    (ticket : Nat) (e : UPTR12A.Effect) : Machine :=
  match registry ticket with
  | none => s
  | some p =>
      if p.effect = e ∧ p.ticket = ticket ∧
          charged registry s.pending + p.cost ≤ s.credits then
        {s with pending := s.pending ++ [(ticket,e)]}
      else s

theorem funded_admission_preserves (registry : Registry) (s : Machine)
    (ticket : Nat) (e : UPTR12A.Effect) (reserved : Reserved registry s) :
    Reserved registry (fundedEnqueue registry s ticket e) := by
  cases registered : registry ticket with
  | none => simpa [fundedEnqueue, registered] using reserved
  | some p =>
      by_cases accepts : p.effect = e ∧ p.ticket = ticket ∧
          charged registry s.pending + p.cost ≤ s.credits
      · simp [fundedEnqueue, registered, accepts, Reserved, charged_append,
          charged, ticketCost]
      · simpa [fundedEnqueue, registered, accepts] using reserved

/-- The actual source dequeue removes its request before check-and-spend.
Whether application succeeds or is refused, remaining reservations fit credit. -/
theorem source_drain_preserves_reservation (registry : Registry) (s : Machine)
    (reserved : Reserved registry s) : Reserved registry (drainOne registry s) := by
  classical
  cases queue : s.pending with
  | nil => simpa [drainOne, queue] using reserved
  | cons request rest =>
      obtain ⟨ticket,e⟩ := request
      cases registered : registry ticket with
      | none =>
          simpa [Reserved, drainOne, queue, applyOne, registered, charged, ticketCost]
            using reserved
      | some p =>
          have budget : p.cost + charged registry rest ≤ s.credits := by
            simpa [Reserved, queue, charged, ticketCost, registered] using reserved
          by_cases ready : Ready {s with pending := rest} ticket e p
          · simp only [Reserved, drainOne, queue, applyOne, registered, ready, ↓reduceIte]
            omega
          · simp only [Reserved, drainOne, queue, applyOne, registered, ready, ↓reduceIte]
            omega

end UPTR17AFunding

