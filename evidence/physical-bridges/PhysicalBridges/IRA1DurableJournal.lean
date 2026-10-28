/-
IR-87 — original A1 T2.3 durable journal: accepted acknowledgements
must follow committed records, not merely queued/attempted writes.

Source anchor: recovered A1-REGISTER.md T2.3 "storage sync /
hash/Merkle durable journal", with actual media durability and
authentic digest collision resistance remaining physical/crypto
implementation obligations.

This small executable source state machine separates:
  queue: volatile pending submission only;
  flush: modeled durable commit before acknowledging;
  reboot: volatile pending data lost, durable and already issued
          acknowledgement records retained.
A1 source-level source DOES NOT prove that a real flash/disk/
distributed quorum survives hardware power loss, torn writes, media
failure, hostile rollback, correlated crashes or censorship.

We prove acknowledgement⇒committed and append-only durable suffix
preservation for ALL finite event streams and after reboot. A weak
ACK-ON-QUEUE negative control breaks the invariant. An abstract
hash-equality checker has a constant-hash collision countermodel,
so it is not a Merkle proof nor cryptographically secure persistence.
-/
import PhysicalBridges.IRA1CausalField

namespace PhysicalBridges.IRA1DurableJournal

structure Journal where
  pending : List Nat
  durable : List Nat
  acknowledged : List Nat
deriving Repr

inductive Event
  | queue (entry : Nat)
  | flush
  | reboot

def step (s : Journal) : Event → Journal
  | .queue entry =>
      { s with pending := entry :: s.pending }
  | .flush =>
      match s.pending with
      | [] => s
      | entry :: rest =>
          { s with pending := rest,
                   durable := entry :: s.durable,
                   acknowledged := entry :: s.acknowledged }
  | .reboot =>
      { s with pending := [] }

/-- Acknowledged entries are actually represented in the modeled
durable journal. This makes NO claim about real-world atomicity or
true device persistence; those semantics are the model definition. -/
def AckSound (s : Journal) : Prop :=
  ∀ entry, entry ∈ s.acknowledged → entry ∈ s.durable

theorem queue_never_acknowledges
    (s : Journal) (entry : Nat) :
    (step s (.queue entry)).acknowledged = s.acknowledged := by
  rfl

theorem queue_never_changes_durable
    (s : Journal) (entry : Nat) :
    (step s (.queue entry)).durable = s.durable := by
  rfl

theorem reboot_preserves_committed_journal
    (s : Journal) :
    (step s .reboot).durable = s.durable := by
  rfl

theorem reboot_preserves_previously_issued_acks
    (s : Journal) :
    (step s .reboot).acknowledged = s.acknowledged := by
  rfl

theorem step_preserves_ack_soundness
    (s : Journal) (e : Event)
    (h : AckSound s) :
    AckSound (step s e) := by
  cases e with
  | queue entry =>
      simpa [step,AckSound] using h
  | reboot =>
      simpa [step,AckSound] using h
  | flush =>
      cases hPending : s.pending with
      | nil =>
          simpa [step,hPending] using h
      | cons entry rest =>
          change ∀ x, x ∈
            (entry :: s.acknowledged) →
              x ∈ (entry :: s.durable)
          intro x hx
          rcases List.mem_cons.mp hx with hHead | hOld
          · subst x
            simp
          · have hCommitted : x ∈ s.durable := h x hOld
            exact List.mem_cons_of_mem entry hCommitted

/-- Newest-first durable logs grow by PREPENDING records. Extends
means that the old durable history remains a complete unchanged
SUFFIX of the current modeled durable log. -/
def DurableExtends (s t : Journal) : Prop :=
  ∃ prefix : List Nat, t.durable = prefix ++ s.durable

theorem one_step_preserves_durable_suffix
    (s : Journal) (e : Event) :
    DurableExtends s (step s e) := by
  cases e with
  | queue entry =>
      exact ⟨[],by simp [step]⟩
  | reboot =>
      exact ⟨[],by simp [step]⟩
  | flush =>
      cases hPending : s.pending with
      | nil =>
          exact ⟨[],by simp [step,hPending]⟩
      | cons entry rest =>
          refine ⟨[entry],?_⟩
          simp [step,hPending]

theorem durable_extension_transitive
    (a b c : Journal)
    (hab : DurableExtends a b)
    (hbc : DurableExtends b c) :
    DurableExtends a c := by
  obtain ⟨p,hp⟩ := hab
  obtain ⟨q,hq⟩ := hbc
  refine ⟨q ++ p,?_⟩
  rw [hq,hp]
  simp [List.append_assoc]

def run (s : Journal) (events : List Event) : Journal :=
  events.foldl step s

theorem any_finite_journal_stream_preserves_ack_soundness
    (s : Journal) (events : List Event)
    (h : AckSound s) :
    AckSound (run s events) := by
  induction events generalizing s with
  | nil => exact h
  | cons ev rest ih =>
      change AckSound (run (step s ev) rest)
      exact ih (step s ev)
        (step_preserves_ack_soundness s ev h)

theorem any_finite_journal_stream_is_append_only
    (s : Journal) (events : List Event) :
    DurableExtends s (run s events) := by
  induction events generalizing s with
  | nil =>
      exact ⟨[],by simp [run]⟩
  | cons ev rest ih =>
      change DurableExtends s (run (step s ev) rest)
      exact durable_extension_transitive
        s (step s ev) (run (step s ev) rest)
        (one_step_preserves_durable_suffix s ev)
        (ih (step s ev))

/-- A server can ACK prematurely at the moment of queueing, before
durable commit. This breaks the actual invariant; it cannot be
hidden behind a logically true "request received" receipt. -/
def naiveQueueAndAck (s : Journal) (entry : Nat) : Journal :=
  { s with pending := entry :: s.pending,
           acknowledged := entry :: s.acknowledged }

theorem premature_ack_without_commit_breaks_soundness :
    ∃ s : Journal, AckSound s ∧
      ¬ AckSound (naiveQueueAndAck s 7) := by
  let s : Journal := ⟨[],[],[]⟩
  refine ⟨s, ?_, ?_⟩
  · intro x hx
    cases hx
  · intro h
    have h7 : 7 ∈
      (naiveQueueAndAck s 7).durable :=
      h 7 (by simp [naiveQueueAndAck])
    simp [naiveQueueAndAck,s] at h7

/-- The most a generic digest checker can prove is EQUALITY of
the two computed digest values. That is not equality of journal
contents without collision resistance, authenticated root, and
snapshot consistency. -/
def digestCheck
    (digest : List Nat → Nat)
    (claimedRoot : Nat) (entries : List Nat) : Bool :=
  decide (digest entries = claimedRoot)

theorem digest_check_sound_as_equality_only
    (digest : List Nat → Nat)
    (claimedRoot : Nat) (entries : List Nat)
    (h : digestCheck digest claimedRoot entries = true) :
    digest entries = claimedRoot := by
  exact decide_eq_true_eq.mp (by simpa [digestCheck] using h)

def collidingDigest (_entries : List Nat) : Nat := 0

theorem untrusted_hash_equality_does_not_prove_journal_equality :
    [1] ≠ [2] ∧
      digestCheck collidingDigest 0 [1] = true ∧
      digestCheck collidingDigest 0 [2] = true := by
  decide

/-- A concrete source-level log accepts a queued record but does not
ACK until the modeled flush commits it. A modeled reboot retains
that durable acknowledged entry. -/
def emptyJournal : Journal := ⟨[],[],[]⟩

theorem synthetic_flush_then_reboot_preserves_receipt :
    let final := run emptyJournal
      [.queue 7,.flush,.reboot]
    7 ∈ final.durable ∧ 7 ∈ final.acknowledged := by
  decide

#print axioms step_preserves_ack_soundness
#print axioms one_step_preserves_durable_suffix
#print axioms durable_extension_transitive
#print axioms any_finite_journal_stream_preserves_ack_soundness
#print axioms any_finite_journal_stream_is_append_only
#print axioms premature_ack_without_commit_breaks_soundness
#print axioms digest_check_sound_as_equality_only
#print axioms untrusted_hash_equality_does_not_prove_journal_equality
#print axioms synthetic_flush_then_reboot_preserves_receipt

end PhysicalBridges.IRA1DurableJournal
