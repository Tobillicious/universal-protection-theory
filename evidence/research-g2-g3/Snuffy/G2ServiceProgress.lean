import Snuffy.G2ServiceRun

/-!
# G2 eventual service: explicit progress certificate

A precise finite-horizon liveness interface for the actual faithful
service run. The certificate is an independently supplied statement
that a named authorized effect appears in the applied trace by a
specific service step. It is not derived from fairness or resource
availability here, and must never be represented as unconditional
service. This module makes the remaining obligation explicit.
-/

namespace Snuffy.G2ServiceProgress

/-- Concrete, observable service success, not a Boolean permission flag. -/
def DeliveredBy (registry : UPTR17A.Registry)
    (s : UPTR17A.Machine) (ticket : Nat) (eff : UPTR12A.Effect)
    (horizon : Nat) : Prop :=
  (ticket, eff) ∈ (Snuffy.G2ServiceRun.serviceRun registry s horizon).applied

/-- A service certificate gives delivery by its exact certified
horizon. The certificate is deliberately exposed as a hypothesis. -/
theorem certified_delivery
    (registry : UPTR17A.Registry) (s : UPTR17A.Machine)
    (ticket : Nat) (eff : UPTR12A.Effect) (horizon : Nat)
    (hcertificate : DeliveredBy registry s ticket eff horizon) :
    (ticket, eff) ∈
      (Snuffy.G2ServiceRun.serviceRun registry s horizon).applied :=
  hcertificate

/-- No claim of progress is possible from a hold-or-drain invariant
alone: the unchanged-machine case remains a valid transition. -/
theorem service_transition_allows_hold
    (registry : UPTR17A.Registry) (s : UPTR17A.Machine) :
    s = s ∨ s = UPTR17A.drainOne registry s :=
  Or.inl rfl

end Snuffy.G2ServiceProgress
