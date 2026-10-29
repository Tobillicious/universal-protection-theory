import Snuffy.UPTR12A

/-!
R17-A -- queued-effect finality, review candidate (2026-10-23).
Requires the unchanged source modules UPTLawLife, UPTFence,
ControllerFinality, ControllerFence, UPTR12A, under Lean 4.35.

The registry is immutable for an execution, and each entry contains an actual
UPTR12A.FinalizedGrant, not a Boolean "certified" flag. The target checks
revocation, time, semantics, generation, replay and credits when APPLYING a
queued effect. The source-to-hardware implementation of the registry, clock,
atomicity and data plane is NOT proved by this module.
-/
namespace UPTR17A

structure Contract where
  grant : UPTR12A.FinalizedGrant
  effect : UPTR12A.Effect
  ticket : Nat
  notBefore : Nat
  expires : Nat
  epoch : Nat
  cost : Nat

structure Machine where
  target : UPTR12A.Target
  now : Nat
  activeGeneration : Nat
  epoch : Nat
  activeMeaning : UPTR12A.Meaning
  credits : Nat
  revoked : List Nat
  pending : List (Nat × UPTR12A.Effect)
  applied : List (Nat × UPTR12A.Effect)

/-- Immutable, independently authorized registry keyed by ticket. The registry
must be populated only from verified R12-A permits and agreed signed terms. -/
abbrev Registry := Nat → Option Contract

/-- The extra guards missing from R12-A's original target: expiry, revocation,
semantic epoch and indivisible resource spending. R12-A supplies the inherited
full Meaning/payload, floor and one-time nonce checks. -/
structure Ready (s : Machine) (ticket : Nat) (e : UPTR12A.Effect)
    (p : Contract) : Prop where
  ticketBinds : p.ticket = ticket
  nonceBinds : p.grant.bound.context.nonce = ticket
  payloadBinds : e = p.effect
  sourceAccepts : UPTR12A.Accepts s.target p.grant e
  activeGenerationBinds : p.grant.bound.context.generation = s.activeGeneration
  activeMeaningBinds : e.meaning = s.activeMeaning
  epochBinds : p.epoch = s.epoch
  notEarly : p.notBefore ≤ s.now
  notExpired : s.now ≤ p.expires
  notRevoked : ticket ∉ s.revoked
  enoughCredit : p.cost ≤ s.credits

/-- Atomic application. Merely enqueuing has no physical effect. The actual
execution step re-reads every target-side and contract field. -/
noncomputable def applyOne (registry : Registry) (s : Machine)
    (ticket : Nat) (e : UPTR12A.Effect) : Machine := by
  classical
  exact match registry ticket with
  | none => s
  | some p =>
      if Ready s ticket e p then
        {s with
          target := UPTR12A.applyEffect s.target p.grant e
          credits := s.credits - p.cost
          applied := s.applied ++ [(ticket,e)]}
      else s

/-- Application is not allowed to append a trace event without a genuine
source grant and *all* current application-time guards. -/
theorem new_effect_has_current_permit
    (registry : Registry) (s : Machine) (ticket : Nat) (e : UPTR12A.Effect)
    (changed : (applyOne registry s ticket e).applied ≠ s.applied) :
    ∃ p, registry ticket = some p ∧ Ready s ticket e p := by
  classical
  cases hi : registry ticket with
  | none =>
    have heq : (applyOne registry s ticket e).applied = s.applied := by
      simp [applyOne, hi]
    exact False.elim (changed heq)
  | some p =>
    by_cases h : Ready s ticket e p
    · exact ⟨p, rfl, h⟩
    · have heq : (applyOne registry s ticket e).applied = s.applied := by
        simp [applyOne, hi, h]
      exact False.elim (changed heq)

/-- A queued effect is evaluated against the machine state *at dequeue time*,
not against the state at which it entered the queue. -/
noncomputable def drainOne (registry : Registry) (s : Machine) : Machine :=
  match s.pending with
  | [] => s
  | (ticket,e) :: rest =>
    applyOne registry {s with pending := rest} ticket e

/-- The front of the queue can only produce an appended effect after the
application-time guard on that exact dequeue state succeeds. -/
theorem drain_currently_authorized (registry : Registry) (s : Machine)
    (changed : (drainOne registry s).applied ≠ s.applied) :
    ∃ ticket e rest p,
      s.pending = (ticket,e) :: rest ∧
      registry ticket = some p ∧
      Ready {s with pending := rest} ticket e p := by
  classical
  cases hq : s.pending with
  | nil =>
    have heq : (drainOne registry s).applied = s.applied := by
      simp [drainOne, hq]
    exact False.elim (changed heq)
  | cons request rest =>
    rcases request with ⟨ticket,e⟩
    have hchanged :
        (applyOne registry {s with pending := rest} ticket e).applied ≠
          ({s with pending := rest} : Machine).applied := by
      simpa [drainOne, hq] using changed
    obtain ⟨p,hreg,hready⟩ :=
      new_effect_has_current_permit registry {s with pending := rest} ticket e hchanged
    exact ⟨ticket,e,rest,p,rfl,hreg,hready⟩

/-- A revoked ticket is refused even if its (formerly final) R12-A grant
and queued payload are otherwise valid. -/
theorem revoked_refuses (registry : Registry) (s : Machine)
    (ticket : Nat) (e : UPTR12A.Effect)
    (revoked : ticket ∈ s.revoked) :
    (applyOne registry s ticket e).applied = s.applied := by
  classical
  apply Classical.byContradiction
  intro changed
  obtain ⟨p,_,ready⟩ :=
    new_effect_has_current_permit registry s ticket e changed
  exact ready.notRevoked revoked

/-- No grant may be executed after its certified deadline. -/
theorem expired_refuses (registry : Registry) (s : Machine)
    (ticket : Nat) (e : UPTR12A.Effect)
    (expired : ∀ p, registry ticket = some p → p.expires < s.now) :
    (applyOne registry s ticket e).applied = s.applied := by
  classical
  apply Classical.byContradiction
  intro changed
  obtain ⟨p,hreg,ready⟩ :=
    new_effect_has_current_permit registry s ticket e changed
  exact Nat.not_le_of_gt (expired p hreg) ready.notExpired

/-- A physical target which has actually installed a newer generation floor
refuses a queued older generation regardless of its earlier admission. -/
theorem installed_floor_refuses (registry : Registry) (s : Machine)
    (ticket : Nat) (e : UPTR12A.Effect)
    (stale : ∀ p, registry ticket = some p →
      p.grant.bound.context.generation < s.target.floor) :
    (applyOne registry s ticket e).applied = s.applied := by
  classical
  apply Classical.byContradiction
  intro changed
  obtain ⟨p,hreg,ready⟩ :=
    new_effect_has_current_permit registry s ticket e changed
  exact Nat.not_le_of_gt (stale p hreg) ready.sourceAccepts.2.1

/-- A valid application can never overdraw its synchronized current credit.
This is a local safety condition, not an endowment/liveness theorem. -/
theorem spend_is_funded (s : Machine) (ticket : Nat)
    (e : UPTR12A.Effect) (p : Contract)
    (h : Ready s ticket e p) : p.cost ≤ s.credits := h.enoughCredit

/-- R12-A exact semantic payload and nonce proofs remain available through the
Ready witness; this theorem preserves the full named decision binding. -/
theorem application_has_source_binding (s : Machine) (ticket : Nat)
    (e : UPTR12A.Effect) (p : Contract)
    (h : Ready s ticket e p) :
    e.meaning = p.grant.bound.cert.meaning ∧
    e.generation = p.grant.bound.context.generation ∧
    e.nonce = p.grant.bound.context.nonce := by
  rcases h.sourceAccepts with ⟨_,_,hgen,hnonce,hmeaning,_⟩
  exact ⟨hmeaning,hgen,hnonce⟩

end UPTR17A
