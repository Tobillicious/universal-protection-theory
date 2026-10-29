import Snuffy.IRA1PageCapability

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IRA1PacketIngress.lean` at main `740abbb` (sha256 `09d64d430435e5e992900dea04cd02ae2426340add8964be32f67217d461633e`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false
/-
IR-85 — A1 T2.1 source-level authenticated, epoch-scoped packet
sequencing and replay rejection.

Recovered archive: A1-REGISTER.md T2.1 'packet ingestion',
requiring an authenticated sequence; physical HMAC/crypto key,
hardware source, freshness, session rollover and all packet routes
remain PLANT obligations.

We use authCheck : Packet → Bool supplied EXTERNALLY. We do not
invent a cryptographic MAC or claim its computational unforgeability.
The theorem is: a packet enters only if authCheck passes AND its
epoch equals the current epoch AND sequence equals nextSequence,
and any finite accepted run preserves all these local facts.

The receipt list is newest first, so a packet's accepted sequence is
less than the NEXT sequence counter. The Nat sequence never wraps:
real finite-width integer wrap and key rotations must be handled by
a separate physical/source-level session protocol.

Countermodels show the absence of a sequence check allows replay;
a permissive authCheck admits arbitrary forged data; packet delivery
alone does not prove service to historical X3 particulars.
-/

namespace PhysicalBridges.IRA1PacketIngress

structure Packet where
  epoch : Nat
  sequence : Nat
  payload : Nat
  tag : Nat
deriving Repr, DecidableEq

structure Session where
  epoch : Nat
  nextSequence : Nat
  accepted : List Packet
deriving Repr

def permit (authCheck : Packet → Bool) (s : Session) (p : Packet) : Bool :=
  authCheck p &&
    decide (p.epoch = s.epoch) &&
    decide (p.sequence = s.nextSequence)

def ingest (authCheck : Packet → Bool) (s : Session) (p : Packet) :
    Session :=
  if permit authCheck s p then
    { s with nextSequence := s.nextSequence + 1,
             accepted := p :: s.accepted }
  else s

/-- This is an executable rule of SOURCE acceptance. No theorem
promotes a Bool from authCheck into a physically authentic MAC. -/
theorem permit_implies_auth_epoch_and_exact_sequence
    (authCheck : Packet → Bool) (s : Session) (p : Packet)
    (h : permit authCheck s p = true) :
    authCheck p = true ∧ p.epoch = s.epoch ∧
      p.sequence = s.nextSequence := by
  simp only [permit,Bool.and_eq_true,decide_eq_true_eq] at h
  exact ⟨h.1.1,h.1.2,h.2⟩

theorem wrong_epoch_cannot_be_accepted
    (authCheck : Packet → Bool) (s : Session) (p : Packet)
    (h : p.epoch ≠ s.epoch) :
    ingest authCheck s p = s := by
  have hNo : permit authCheck s p = false := by
    simp [permit,h]
  simp [ingest,hNo]

theorem wrong_sequence_cannot_be_accepted
    (authCheck : Packet → Bool) (s : Session) (p : Packet)
    (h : p.sequence ≠ s.nextSequence) :
    ingest authCheck s p = s := by
  have hNo : permit authCheck s p = false := by
    simp [permit,h]
  simp [ingest,hNo]

theorem auth_failure_cannot_be_accepted
    (authCheck : Packet → Bool) (s : Session) (p : Packet)
    (h : authCheck p = false) :
    ingest authCheck s p = s := by
  simp [ingest,permit,h]

theorem accepted_packet_increments_sequence
    (authCheck : Packet → Bool) (s : Session) (p : Packet)
    (h : permit authCheck s p = true) :
    (ingest authCheck s p).nextSequence = s.nextSequence + 1 := by
  simp [ingest,h]

theorem replay_of_accepted_packet_rejected
    (authCheck : Packet → Bool) (s : Session) (p : Packet)
    (h : permit authCheck s p = true) :
    ingest authCheck (ingest authCheck s p) p =
      ingest authCheck s p := by
  have hExact :=
    (permit_implies_auth_epoch_and_exact_sequence
      authCheck s p h).2.2
  have hNext :=
    accepted_packet_increments_sequence authCheck s p h
  have hNo : p.sequence ≠ (ingest authCheck s p).nextSequence := by
    rw [hExact,hNext]
    omega
  exact wrong_sequence_cannot_be_accepted
    authCheck (ingest authCheck s p) p hNo

def ValidSession (authCheck : Packet → Bool) (s : Session) : Prop :=
  ∀ p, p ∈ s.accepted →
    authCheck p = true ∧ p.epoch = s.epoch ∧
    p.sequence < s.nextSequence

theorem ingest_preserves_epoch
    (authCheck : Packet → Bool) (s : Session) (p : Packet) :
    (ingest authCheck s p).epoch = s.epoch := by
  unfold ingest
  split <;> rfl

theorem ingest_preserves_valid_session
    (authCheck : Packet → Bool) (s : Session) (p : Packet)
    (hValid : ValidSession authCheck s) :
    ValidSession authCheck (ingest authCheck s p) := by
  by_cases h : permit authCheck s p = true
  · have hGood :=
      permit_implies_auth_epoch_and_exact_sequence authCheck s p h
    simp only [ingest,h,ite_true]
    change ∀ q, q ∈ (p :: s.accepted) →
      authCheck q = true ∧ q.epoch = s.epoch ∧
        q.sequence < s.nextSequence + 1
    intro q hMember
    rcases List.mem_cons.mp hMember with hHead | hOld
    · subst q
      exact ⟨hGood.1,hGood.2.1, by omega⟩
    · obtain ⟨hAuth,hEpoch,hSeq⟩ := hValid q hOld
      exact ⟨hAuth,hEpoch,by omega⟩
  · have hf : permit authCheck s p = false := by
      cases hval : permit authCheck s p <;> simp_all
    simpa [ingest,hf] using hValid

def run (authCheck : Packet → Bool)
    (s : Session) (packets : List Packet) : Session :=
  packets.foldl (ingest authCheck) s

theorem any_finite_packet_stream_valid
    (authCheck : Packet → Bool)
    (s : Session) (packets : List Packet)
    (h : ValidSession authCheck s) :
    ValidSession authCheck (run authCheck s packets) := by
  induction packets generalizing s with
  | nil => exact h
  | cons p rest ih =>
      change ValidSession authCheck
        (run authCheck (ingest authCheck s p) rest)
      exact ih (ingest authCheck s p)
        (ingest_preserves_valid_session authCheck s p h)

theorem any_finite_packet_stream_epoch_unchanged
    (authCheck : Packet → Bool)
    (s : Session) (packets : List Packet) :
    (run authCheck s packets).epoch = s.epoch := by
  induction packets generalizing s with
  | nil => rfl
  | cons p rest ih =>
      change (run authCheck (ingest authCheck s p) rest).epoch =
        s.epoch
      rw [ih]
      exact ingest_preserves_epoch authCheck s p

/-- Accepted packet ingress never even accesses maintenance memory
or supervisor state in this source model. A physically installed
DMA ingress route could violate that, unless independently fenced
under IR-83. -/
structure FieldState where
  session : Session
  maintenance : IRCapabilityNoninterference.Memory
  supervisor : IRControlledReentry.Mode

def fieldStep (authCheck : Packet → Bool)
    (s : FieldState) (p : Packet) : FieldState :=
  { s with session := ingest authCheck s.session p }

def runField (authCheck : Packet → Bool)
    (s : FieldState) (packets : List Packet) : FieldState :=
  packets.foldl (fieldStep authCheck) s

theorem field_step_preserves_maintenance
    (authCheck : Packet → Bool)
    (s : FieldState) (p : Packet) (slot : Nat) :
    IRCapabilityNoninterference.readMaint
      (fieldStep authCheck s p).maintenance slot =
    IRCapabilityNoninterference.readMaint s.maintenance slot := by
  rfl

theorem field_step_preserves_supervisor
    (authCheck : Packet → Bool) (s : FieldState) (p : Packet) :
    (fieldStep authCheck s p).supervisor = s.supervisor := by
  rfl

theorem any_finite_ingress_cannot_write_maintenance
    (authCheck : Packet → Bool) (s : FieldState)
    (packets : List Packet) (slot : Nat) :
    IRCapabilityNoninterference.readMaint
      (runField authCheck s packets).maintenance slot =
    IRCapabilityNoninterference.readMaint s.maintenance slot := by
  induction packets generalizing s with
  | nil => rfl
  | cons p rest ih =>
      change IRCapabilityNoninterference.readMaint
        (runField authCheck (fieldStep authCheck s p) rest).maintenance
        slot =
        IRCapabilityNoninterference.readMaint s.maintenance slot
      rw [ih]
      exact field_step_preserves_maintenance authCheck s p slot

theorem any_finite_ingress_cannot_change_supervisor
    (authCheck : Packet → Bool) (s : FieldState)
    (packets : List Packet) :
    (runField authCheck s packets).supervisor = s.supervisor := by
  induction packets generalizing s with
  | nil => rfl
  | cons p rest ih =>
      change (runField authCheck
        (fieldStep authCheck s p) rest).supervisor = s.supervisor
      rw [ih]
      exact field_step_preserves_supervisor authCheck s p

/-- Hostile source control #1: removing the sequence check admits
the SAME packet twice, even under a fixed epoch and a function that
returns authCheck=true. -/
def naivePermit (authCheck : Packet → Bool)
    (s : Session) (p : Packet) : Bool :=
  authCheck p && decide (p.epoch = s.epoch)

def naiveIngest (authCheck : Packet → Bool)
    (s : Session) (p : Packet) : Session :=
  if naivePermit authCheck s p then
    { s with nextSequence := s.nextSequence + 1,
             accepted := p :: s.accepted }
  else s

def permissiveAuth (_p : Packet) : Bool := true

def exampleSession : Session := ⟨42,0,[]⟩
def examplePacket : Packet := ⟨42,0,5,0⟩

theorem accepted_cryptographically_unverified_packet :
    permit permissiveAuth exampleSession examplePacket = true := by
  decide

theorem no_sequence_check_allows_duplicate_replay :
    (naiveIngest permissiveAuth
      (naiveIngest permissiveAuth exampleSession examplePacket)
      examplePacket).accepted = [examplePacket,examplePacket] := by
  decide

theorem source_sequence_guard_rejects_same_packet_replay :
    (run permissiveAuth exampleSession
      [examplePacket,examplePacket]).accepted = [examplePacket] := by
  decide


end PhysicalBridges.IRA1PacketIngress
