import PhysicalBridges.IR132ExactBoundaryReconstruction
import PhysicalBridges.IR105AuthorizationIndependence

/-!
# IR-138 — first-event per-particular semantic readout obstruction

A matched source generator, before/after state readout, numerical
effect charge and causal participation do not alone decide whether
an independently described PARTICULAR retains continuity or provided
valid authorization during that very event.

This is a minimal source-correspondence diagnostic. It tests ONE
conservative IR105-style per-particular screen
    continues or genuinely authorized
instead of silently identifying this screen with the *full* original
X3 (which also has history, reference, consent and maximality duties).

Two synthetic physical histories have identical source-facing
readouts and a nontrivial state transition, while the protected
particular's event-level semantic condition differs. No deterministic
decoder of that SOURCE READOUT can be exact. For an exact readout one
must provide independent subject-level semantic evidence, rather than
relying on log completeness, parity, reversible source transitions or
physical charge alone.

A contrasting ideal semantic packet IS sufficient to decode each
named particular's event-level screen, but its actual external
instrumentation, authenticity and source/physical semantics are OPEN.
Nothing here proves a physically realizable all-events instrument,
absence of first X3 harm, the complete original X3 order, or UPT.
-/

namespace PhysicalBridges.IR138
open PhysicalBridges

/-- In this finite countermodel, two Bool labels stand for distinct
particulars; these are not asserted to capture the ontology or
recognition of actual minds. Each real event includes both nominal
physical/source descriptors and independently supplied event-level
continuation/authorization facts. -/
structure ParticularEvent where
  before : Bool
  after : Bool
  sourceGenerator : Bool
  chargedWork : Nat
  continues : Bool → Bool
  authorized : Bool → Bool

/-- What an instrument limited to state endpoints, source generator
and charged work observes. These fields are independent of our
statement of the target's semantic history, not silently identified
with those histories. -/
def sourceReadout (e : ParticularEvent) :
    Bool × Bool × Bool × Nat :=
  (e.before, e.after, e.sourceGenerator, e.chargedWork)

/-- A *bounded per-event semantic screen* explicitly descended from
IR105. It is NOT the total original-X3 objective, and the Boolean
flags here are formal independent variables, not actual subjective
measurements. -/
def eventScreen (e : ParticularEvent) (m : Bool) : Bool :=
  e.continues m || e.authorized m

def allParticularsPass (e : ParticularEvent) : Prop :=
  ∀ m : Bool, eventScreen e m = true

/-- The source account is identical in the two histories. The
first particular changes its actual event authorization, while
the second particular demonstrably continues in both histories. -/
def consentedEvent : ParticularEvent where
  before := false
  after := true
  sourceGenerator := true
  chargedWork := 1
  continues := fun m => m
  authorized := fun m => !m

def coercedEvent : ParticularEvent where
  before := false
  after := true
  sourceGenerator := true
  chargedWork := 1
  continues := fun m => m
  authorized := fun _ => false

/-- Both histories have the same nonidentity source change and
identical work charge. This is a genuine first-event ambiguity,
not a vacuous identity transition or a differing log entry. -/
theorem same_source_event_different_particular_semantics :
    sourceReadout consentedEvent = sourceReadout coercedEvent ∧
    consentedEvent.before ≠ consentedEvent.after ∧
    coercedEvent.before ≠ coercedEvent.after ∧
    consentedEvent.chargedWork = coercedEvent.chargedWork ∧
    eventScreen consentedEvent false = true ∧
    eventScreen coercedEvent false = false := by
  decide

/-- The recognized source/codebook accounts for both events,
and every particular passes the conservative event screen ONLY
in the genuinely consented history. -/
theorem one_covered_event_passes_other_fails :
    allParticularsPass consentedEvent ∧
    ¬ allParticularsPass coercedEvent := by
  constructor
  · intro m
    cases m <;> decide
  · intro h
    have hFirst := h false
    have hBad : eventScreen coercedEvent false = false := by decide
    rw [hBad] at hFirst
    cases hFirst

/-- IR105's existing independently modeled transition screen is
strictly separated from causal participation and accounting here.
The same source readout cannot choose the correct IR105 judgment. -/
def ir105View (e : ParticularEvent) (m : Bool) : IR105.Transition where
  accounted := true
  subjectParticipated := true
  authorized := e.authorized m
  subjectContinues := e.continues m

theorem accounted_subject_participation_cannot_decide_consent :
    IR105.BoundaryComplete (ir105View coercedEvent false) ∧
    IR105.HasSubjectCausalInput (ir105View coercedEvent false) ∧
    ¬ IR105.X3Transition (ir105View coercedEvent false) := by
  constructor
  · rfl
  constructor
  · rfl
  · intro h
    cases h with
    | inl h => cases h
    | inr h => cases h

/-- Any exact semantic decoder MUST distinguish the two individual
event histories, even though source states, generator, accounting
and charges are identical. This is an information requirement, not
a claim that any particular sensor or machine can satisfy it. -/
theorem any_exact_particular_report_must_separate
    {Readout : Type}
    (instrument : ParticularEvent → Readout)
    (decode : Readout → Bool)
    (hExact : ∀ e : ParticularEvent,
      decode (instrument e) = eventScreen e false) :
    instrument consentedEvent ≠ instrument coercedEvent := by
  intro hSame
  have hEqual :
      eventScreen consentedEvent false =
        eventScreen coercedEvent false := by
    calc
      eventScreen consentedEvent false =
          decode (instrument consentedEvent) := (hExact _).symm
      _ = decode (instrument coercedEvent) := congrArg decode hSame
      _ = eventScreen coercedEvent false := hExact _
  have hDifferent :
      eventScreen consentedEvent false ≠
        eventScreen coercedEvent false := by decide
  exact hDifferent hEqual

/-- The exact decoding obstruction is the already established
IR132 fibrewise-information theorem, now instantiated with an
independently labelled, per-event particular's semantic condition. -/
theorem no_endpoint_source_charge_decoder_for_first_particular :
    ¬ IR132.ExactDecoder sourceReadout
        (fun e : ParticularEvent => eventScreen e false) := by
  intro hDecoder
  obtain ⟨decode, hExact⟩ := hDecoder
  have hSeparation :=
    any_exact_particular_report_must_separate
      sourceReadout decode hExact
  exact hSeparation rfl

/-- An aggregate "at least one constituent is okay" flag can hide
one individual's violated screen. The real universal quantifier is
per particular, not per source sector or per total-population flag. -/
def someonePasses (e : ParticularEvent) : Bool :=
  eventScreen e false || eventScreen e true

theorem aggregate_good_flag_hides_bad_particular :
    someonePasses coercedEvent = true ∧
    ¬ allParticularsPass coercedEvent := by
  exact ⟨by decide, one_covered_event_passes_other_fails.2⟩

/-- POSITIVE CONTROL: the *ideal* complete packet contains the
continuation and authorization bits for EACH named particular,
not merely a sector charge, mutable registry, or overall flag.
It is a mathematical source obligation, NOT a claim that the
bits can actually be measured faithfully in the physical world. -/
def idealParticularPacket (e : ParticularEvent) :
    (Bool × Bool) × (Bool × Bool) :=
  ((e.continues false, e.authorized false),
   (e.continues true, e.authorized true))

def decodeIdealPacket
    (packet : (Bool × Bool) × (Bool × Bool))
    (m : Bool) : Bool :=
  if m then packet.2.1 || packet.2.2
  else packet.1.1 || packet.1.2

theorem ideal_packet_exact_for_each_particular
    (e : ParticularEvent) (m : Bool) :
    decodeIdealPacket (idealParticularPacket e) m =
      eventScreen e m := by
  cases m <;>
    rfl

/-- A code is an original-X3 screening witness only if its
subject-semantic fidelity is justified independently for every
real event. This generic interface makes the precise needed
witness explicit; there is no claim that source-readout data
provides it. -/
structure WitnessedParticularReadout
    (Readout : Type)
    (instrument : ParticularEvent → Readout) where
  decoder : Readout → Bool → Bool
  independentlyValidated : ∀ e m,
    decoder (instrument e) m = eventScreen e m

/-- Separately validated per-particular evidence and passing
decoded values ensure that the bounded event-level obligations
really hold. The physically consequential premise is the witness
fidelity, which is NOT inferred from a source log. -/
theorem validated_witness_supports_per_particular_event_screen
    {Readout : Type}
    (instrument : ParticularEvent → Readout)
    (w : WitnessedParticularReadout Readout instrument)
    (e : ParticularEvent)
    (hAllPass : ∀ m : Bool,
      w.decoder (instrument e) m = true) :
    allParticularsPass e := by
  intro m
  rw [← w.independentlyValidated e m]
  exact hAllPass m

/-- The ideal packet witnesses the formal interface for the
finite toy, while remaining UNVALIDATED as a real instrument. -/
def idealPacketWitness :
    WitnessedParticularReadout
      ((Bool × Bool) × (Bool × Bool)) idealParticularPacket where
  decoder := decodeIdealPacket
  independentlyValidated := ideal_packet_exact_for_each_particular

#print axioms same_source_event_different_particular_semantics
#print axioms one_covered_event_passes_other_fails
#print axioms accounted_subject_participation_cannot_decide_consent
#print axioms any_exact_particular_report_must_separate
#print axioms no_endpoint_source_charge_decoder_for_first_particular
#print axioms aggregate_good_flag_hides_bad_particular
#print axioms ideal_packet_exact_for_each_particular
#print axioms validated_witness_supports_per_particular_event_screen
#print axioms idealPacketWitness

end PhysicalBridges.IR138
