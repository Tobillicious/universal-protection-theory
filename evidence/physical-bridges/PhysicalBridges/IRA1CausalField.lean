/-
IR-86 — original A1 T2.2 field-message clock and causal feasibility.

Recovered A1-REGISTER names packet 'relativistic bus message' with
clock/spacetime feasibility as plant obligation.

We explicitly separate:
  * an IR-85 authenticated/epoch/next-sequence source-level gate;
  * a reported distance and timestamp envelope;
  * the actual physical distance, time-base and propagation physics,
    which are NOT inferred from reported numbers or this proof.

These natural-number inequalities model a finite-speed causal upper
bound and maximum delivery deadline in CONSISTENT chosen discrete
time/distance units. They are not GR, an experimental value for c,
an authenticated timestamp or a model of all original X3 spacetime.
-/
import PhysicalBridges.IRA1PacketIngress

namespace PhysicalBridges.IRA1CausalField

open IRA1PacketIngress

structure Transit where
  sendTick : Nat
  receiveTick : Nat
  distance : Nat
  epoch : Nat
deriving Repr, DecidableEq

structure LinkBounds where
  maxSpeedPerTick : Nat
  maxDelayTicks : Nat
deriving Repr, DecidableEq

def CausallyAdmitted (env : LinkBounds)
    (packet : Packet) (t : Transit) : Prop :=
  t.sendTick ≤ t.receiveTick ∧
  t.distance ≤ env.maxSpeedPerTick * (t.receiveTick - t.sendTick) ∧
  t.receiveTick ≤ t.sendTick + env.maxDelayTicks ∧
  t.epoch = packet.epoch

instance (env : LinkBounds) (p : Packet) (t : Transit) :
    Decidable (CausallyAdmitted env p t) := by
  unfold CausallyAdmitted
  infer_instance

def fieldPermit (authCheck : Packet → Bool)
    (env : LinkBounds) (session : Session)
    (packet : Packet) (t : Transit) : Bool :=
  permit authCheck session packet && decide (CausallyAdmitted env packet t)

theorem field_permit_sound
    (authCheck : Packet → Bool) (env : LinkBounds)
    (session : Session) (packet : Packet) (t : Transit)
    (h : fieldPermit authCheck env session packet t = true) :
    (authCheck packet = true ∧
      packet.epoch = session.epoch ∧
      packet.sequence = session.nextSequence) ∧
    CausallyAdmitted env packet t := by
  have hBoth : permit authCheck session packet = true ∧
      decide (CausallyAdmitted env packet t) = true := by
    simpa only [fieldPermit,Bool.and_eq_true] using h
  exact ⟨permit_implies_auth_epoch_and_exact_sequence
    authCheck session packet hBoth.1, decide_eq_true_eq.mp hBoth.2⟩

theorem impossible_distance_in_deadline_is_rejected
    (authCheck : Packet → Bool) (env : LinkBounds)
    (session : Session) (packet : Packet) (t : Transit)
    (hImpossible :
      env.maxSpeedPerTick * env.maxDelayTicks < t.distance) :
    fieldPermit authCheck env session packet t = false := by
  by_cases hc : CausallyAdmitted env packet t
  · rcases hc with ⟨hAfter,hDist,hDue,_⟩
    have hElapsed : t.receiveTick - t.sendTick ≤ env.maxDelayTicks := by
      omega
    have hProd := Nat.mul_le_mul_left env.maxSpeedPerTick hElapsed
    omega
  · simp [fieldPermit,hc]

def ingestField (authCheck : Packet → Bool)
    (env : LinkBounds) (session : Session)
    (packet : Packet) (transit : Transit) : Session :=
  if fieldPermit authCheck env session packet transit then
    ingest authCheck session packet
  else session

theorem accepted_field_uses_ir85_ingress
    (authCheck : Packet → Bool)
    (env : LinkBounds) (session : Session)
    (packet : Packet) (transit : Transit)
    (h : fieldPermit authCheck env session packet transit = true) :
    ingestField authCheck env session packet transit =
      ingest authCheck session packet := by
  simp [ingestField,h]

theorem field_ingress_preserves_ir85_session
    (authCheck : Packet → Bool) (env : LinkBounds)
    (session : Session) (packet : Packet) (transit : Transit)
    (hValid : ValidSession authCheck session) :
    ValidSession authCheck
      (ingestField authCheck env session packet transit) := by
  by_cases h : fieldPermit authCheck env session packet transit = true
  · rw [accepted_field_uses_ir85_ingress authCheck env session packet
      transit h]
    exact ingest_preserves_valid_session authCheck session packet hValid
  · have hf : fieldPermit authCheck env session packet transit = false := by
      cases heq : fieldPermit authCheck env session packet transit <;> simp_all
    simpa [ingestField,hf] using hValid

structure FieldEvent where
  packet : Packet
  transit : Transit

def runField (authCheck : Packet → Bool) (env : LinkBounds)
    (s : Session) (events : List FieldEvent) : Session :=
  events.foldl
    (fun s ev => ingestField authCheck env s ev.packet ev.transit) s

theorem all_finite_causal_field_events_preserve_source_session
    (authCheck : Packet → Bool) (env : LinkBounds)
    (s : Session) (events : List FieldEvent)
    (h : ValidSession authCheck s) :
    ValidSession authCheck (runField authCheck env s events) := by
  induction events generalizing s with
  | nil => exact h
  | cons ev rest ih =>
      change ValidSession authCheck
        (runField authCheck env
          (ingestField authCheck env s ev.packet ev.transit) rest)
      exact ih (ingestField authCheck env s ev.packet ev.transit)
        (field_ingress_preserves_ir85_session
          authCheck env s ev.packet ev.transit h)

/-- A declared feasible message can be paired with a different
actual transit that is physically impossible within its actual
reported time. No source-level certificate can prove the physical
observations coincide without independent clock/distance refinement.
-/
def exampleBounds : LinkBounds := ⟨3,5⟩
def examplePacket : Packet := ⟨42,0,5,9⟩
def exampleSession : Session := ⟨42,0,[]⟩
def nominalTransit : Transit := ⟨10,12,5,42⟩
def actualUnmodeledTransit : Transit := ⟨10,10,5,42⟩

theorem nominal_report_accepted_without_crypto_security :
    fieldPermit permissiveAuth exampleBounds
      exampleSession examplePacket nominalTransit = true := by
  decide

theorem accepted_report_cannot_prove_real_causal_transport :
    fieldPermit permissiveAuth exampleBounds
      exampleSession examplePacket nominalTransit = true ∧
    ¬ CausallyAdmitted exampleBounds
      examplePacket actualUnmodeledTransit := by
  constructor
  · exact nominal_report_accepted_without_crypto_security
  · decide

/-- If a link claims a distance larger than the fastest possible
distance within its maximum admitted deadline, it cannot pass even
if the source-level packet authentication function accepts it. -/
theorem impossible_nominal_distance_rejected :
    fieldPermit permissiveAuth ⟨3,2⟩
      exampleSession examplePacket ⟨10,12,7,42⟩ = false := by
  decide

#print axioms field_permit_sound
#print axioms impossible_distance_in_deadline_is_rejected
#print axioms accepted_field_uses_ir85_ingress
#print axioms field_ingress_preserves_ir85_session
#print axioms all_finite_causal_field_events_preserve_source_session
#print axioms nominal_report_accepted_without_crypto_security
#print axioms accepted_report_cannot_prove_real_causal_transport
#print axioms impossible_nominal_distance_rejected

end PhysicalBridges.IRA1CausalField
