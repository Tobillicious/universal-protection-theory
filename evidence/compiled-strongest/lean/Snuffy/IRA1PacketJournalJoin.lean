import Snuffy.IRA1DurableJournal

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IRA1PacketJournalJoin.lean` at main `740abbb` (sha256 `845c50f155eb552e9bc4a44c1cef31828626c50fcf668ddf6a5db66767d6e919`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false
/-
IR-88 — A1 T2.1/T2.2 packet ingress ↔ T2.3 durable journal join.

Source-level conjunction of separately valid packet and journal
invariants is INSUFFICIENT to preserve particular accepted events:
a packet may be counted as 'accepted' and queued, then a crash
drops the volatile payload before any durable commit.

Repaired source transition: only after a matching authenticated
epoch/sequence and causal field envelope, perform a single modeled
commit transaction (queue→flush durable) and only then add the
packet to the accepted session. Prove for all finite packet/reboot
streams:
  • accepted packet payload has a durable record;
  • accepted packet local seq/epoch/auth contract remains valid;
  • every journal acknowledgement corresponds to a durable entry.

This is an ACTUAL cross-module theorem, but the queue→flush operation
is atomic only in the modeled source code. Hardware all-or-nothing
crash semantics, duplicate payload identity, real cryptographic
provenance, and all original X3 historical-subject service remain
unverified physical/design obligations.

The proof also includes an explicit non-atomic crash countermodel.
-/

namespace PhysicalBridges.IRA1PacketJournalJoin
open IRA1PacketIngress
open IRA1CausalField

structure JointState where
  session : Session
  journal : IRA1DurableJournal.Journal

/-- Historical receipt correspondence within this SOURCE model.
Payload values are not unique identities; an actual original X3
particular needs a richer identity and immutable provenance key. -/
def ReceiptPersistent (s : JointState) : Prop :=
  ∀ p, p ∈ s.session.accepted → p.payload ∈ s.journal.durable

def JointSafe (authCheck : Packet → Bool) (s : JointState) : Prop :=
  ValidSession authCheck s.session ∧
    IRA1DurableJournal.AckSound s.journal ∧
    ReceiptPersistent s

/-- From one authorized field message, add payload to the source
durable journal and acknowledgment records BEFORE adding an accepted
packet receipt; an accepted packet is therefore not merely pending.
This is an explicitly atomic SOURCE transition, not physical atomic
sector/quorum persistence. -/
def commitIngress
    (authCheck : Packet → Bool) (env : LinkBounds)
    (s : JointState) (p : Packet) (t : Transit) : JointState :=
  if fieldPermit authCheck env s.session p t then
    { session := ingest authCheck s.session p,
      journal := IRA1DurableJournal.step
        (IRA1DurableJournal.step s.journal (.queue p.payload))
        .flush }
  else s

/-- Negative alternative: a packet enters the accepted list when it
is only queued. This is the exact unsafe seam between IR-85/86 and
IR-87 absent an atomic source or physical transaction. -/
def unsafeQueuedIngress
    (authCheck : Packet → Bool) (env : LinkBounds)
    (s : JointState) (p : Packet) (t : Transit) : JointState :=
  if fieldPermit authCheck env s.session p t then
    { session := ingest authCheck s.session p,
      journal := IRA1DurableJournal.step s.journal (.queue p.payload) }
  else s

theorem committed_payload_is_durable
    (j : IRA1DurableJournal.Journal) (value : Nat) :
    (IRA1DurableJournal.step
      (IRA1DurableJournal.step j (.queue value))
      .flush).durable = value :: j.durable := by
  rfl

theorem committed_payload_is_acknowledged
    (j : IRA1DurableJournal.Journal) (value : Nat) :
    (IRA1DurableJournal.step
      (IRA1DurableJournal.step j (.queue value))
      .flush).acknowledged = value :: j.acknowledged := by
  rfl

theorem commit_ingress_preserves_packet_session
    (authCheck : Packet → Bool) (env : LinkBounds)
    (s : JointState) (p : Packet) (t : Transit)
    (hValid : ValidSession authCheck s.session) :
    ValidSession authCheck (commitIngress authCheck env s p t).session := by
  by_cases h : fieldPermit authCheck env s.session p t = true
  · simpa [commitIngress,h] using
      (ingest_preserves_valid_session authCheck s.session p hValid)
  · have hf : fieldPermit authCheck env s.session p t = false := by
      cases heq : fieldPermit authCheck env s.session p t <;> simp_all
    simpa [commitIngress,hf] using hValid

theorem commit_ingress_preserves_ack_soundness
    (authCheck : Packet → Bool) (env : LinkBounds)
    (s : JointState) (p : Packet) (t : Transit)
    (hAck : IRA1DurableJournal.AckSound s.journal) :
    IRA1DurableJournal.AckSound
      (commitIngress authCheck env s p t).journal := by
  by_cases h : fieldPermit authCheck env s.session p t = true
  · have hQueue :=
      IRA1DurableJournal.step_preserves_ack_soundness
        s.journal (.queue p.payload) hAck
    have hFlush :=
      IRA1DurableJournal.step_preserves_ack_soundness
        (IRA1DurableJournal.step s.journal (.queue p.payload))
        .flush hQueue
    simpa [commitIngress,h] using hFlush
  · have hf : fieldPermit authCheck env s.session p t = false := by
      cases heq : fieldPermit authCheck env s.session p t <;> simp_all
    simpa [commitIngress,hf] using hAck

theorem commit_ingress_preserves_receipt_persistence
    (authCheck : Packet → Bool) (env : LinkBounds)
    (s : JointState) (p : Packet) (t : Transit)
    (hPersist : ReceiptPersistent s) :
    ReceiptPersistent (commitIngress authCheck env s p t) := by
  by_cases h : fieldPermit authCheck env s.session p t = true
  · have hGate : permit authCheck s.session p = true := by
      have hBoth :
          permit authCheck s.session p = true ∧
          decide (CausallyAdmitted env p t) = true := by
        simpa only [fieldPermit,Bool.and_eq_true] using h
      exact hBoth.1
    have hSession :
        (commitIngress authCheck env s p t).session.accepted =
          p :: s.session.accepted := by
      simp [commitIngress,h,ingest,hGate]
    have hStorage :
        (commitIngress authCheck env s p t).journal.durable =
          p.payload :: s.journal.durable := by
      simp [commitIngress,h,committed_payload_is_durable]
    intro q hMember
    rw [hSession] at hMember
    rw [hStorage]
    rcases List.mem_cons.mp hMember with hHead | hOld
    · subst q
      simp
    · exact List.mem_cons_of_mem p.payload (hPersist q hOld)
  · have hf : fieldPermit authCheck env s.session p t = false := by
      cases heq : fieldPermit authCheck env s.session p t <;> simp_all
    simpa [commitIngress,hf] using hPersist

theorem commit_ingress_preserves_joint_safety
    (authCheck : Packet → Bool) (env : LinkBounds)
    (s : JointState) (p : Packet) (t : Transit)
    (h : JointSafe authCheck s) :
    JointSafe authCheck (commitIngress authCheck env s p t) := by
  exact ⟨commit_ingress_preserves_packet_session
    authCheck env s p t h.1,
    commit_ingress_preserves_ack_soundness
      authCheck env s p t h.2.1,
    commit_ingress_preserves_receipt_persistence
      authCheck env s p t h.2.2⟩

def reboot (s : JointState) : JointState :=
  { s with journal := IRA1DurableJournal.step s.journal .reboot }

theorem reboot_preserves_joint_safety
    (authCheck : Packet → Bool) (s : JointState)
    (h : JointSafe authCheck s) :
    JointSafe authCheck (reboot s) := by
  have hAck : IRA1DurableJournal.AckSound
      (IRA1DurableJournal.step s.journal .reboot) :=
    IRA1DurableJournal.step_preserves_ack_soundness
      s.journal .reboot h.2.1
  refine ⟨?_,hAck,?_⟩
  · exact h.1
  · intro p hp
    change p.payload ∈ s.journal.durable
    exact h.2.2 p hp

inductive JointEvent
  | packet (p : Packet) (transit : Transit)
  | reboot

def jointStep
    (authCheck : Packet → Bool) (env : LinkBounds)
    (s : JointState) : JointEvent → JointState
  | .packet p transit =>
      commitIngress authCheck env s p transit
  | .reboot => reboot s

def run
    (authCheck : Packet → Bool) (env : LinkBounds)
    (s : JointState) (events : List JointEvent) : JointState :=
  events.foldl (jointStep authCheck env) s

theorem all_finite_packet_and_reboot_events_preserve_joint_safety
    (authCheck : Packet → Bool) (env : LinkBounds)
    (s : JointState) (events : List JointEvent)
    (h : JointSafe authCheck s) :
    JointSafe authCheck (run authCheck env s events) := by
  induction events generalizing s with
  | nil => exact h
  | cons ev rest ih =>
      change JointSafe authCheck
        (run authCheck env
          (jointStep authCheck env s ev) rest)
      apply ih
      cases ev with
      | packet p transit =>
          exact commit_ingress_preserves_joint_safety
            authCheck env s p transit h
      | reboot =>
          exact reboot_preserves_joint_safety authCheck s h

def emptyJoint : JointState :=
  ⟨IRA1CausalField.exampleSession, IRA1DurableJournal.emptyJournal⟩

/-- The previous T2.1/T2.2 and T2.3 local invariants do not
themselves prevent loss of an accepted event when crash clears the
queued-but-uncommitted payload. -/
theorem non_atomic_packet_crash_loses_accepted_history :
    let after := reboot
      (unsafeQueuedIngress permissiveAuth
        IRA1CausalField.exampleBounds
        emptyJoint
        IRA1CausalField.examplePacket
        IRA1CausalField.nominalTransit)
    ¬ ReceiptPersistent after := by
  dsimp
  intro h
  have hAccepted :
      IRA1CausalField.examplePacket ∈
        (reboot (unsafeQueuedIngress permissiveAuth
          IRA1CausalField.exampleBounds emptyJoint
          IRA1CausalField.examplePacket
          IRA1CausalField.nominalTransit)).session.accepted := by
    decide
  have hNotCommitted :
      IRA1CausalField.examplePacket.payload ∉
        (reboot (unsafeQueuedIngress permissiveAuth
          IRA1CausalField.exampleBounds emptyJoint
          IRA1CausalField.examplePacket
          IRA1CausalField.nominalTransit)).journal.durable := by
    decide
  exact hNotCommitted (h _ hAccepted)

/-- The repaired source transaction can survive a modeled reboot,
because it advances the acceptance session ONLY with a durable
record. This does not prove a real device's power-fail atomicity. -/
theorem atomic_source_ingress_reboot_retains_accepted_payload :
    JointSafe permissiveAuth
      (reboot (commitIngress permissiveAuth
        IRA1CausalField.exampleBounds
        emptyJoint
        IRA1CausalField.examplePacket
        IRA1CausalField.nominalTransit)) := by
  have hInitial : JointSafe permissiveAuth emptyJoint := by
    constructor
    · intro p hp
      cases hp
    constructor
    · intro v hv
      cases hv
    · intro p hp
      cases hp
  exact reboot_preserves_joint_safety permissiveAuth _
    (commit_ingress_preserves_joint_safety
      permissiveAuth IRA1CausalField.exampleBounds
      emptyJoint IRA1CausalField.examplePacket
      IRA1CausalField.nominalTransit hInitial)


end PhysicalBridges.IRA1PacketJournalJoin
