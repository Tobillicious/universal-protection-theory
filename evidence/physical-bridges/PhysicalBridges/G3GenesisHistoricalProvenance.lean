import PhysicalBridges.G3GenesisCarrierEnrollment

/-!
# Pre-QG Koru–Genesis: retained identities carry unchanged source histories

Find-before-build: existing G3GenesisCarrierEnrollment proves stagewise
injectivity from independent registration conditions, while
G3IdentityPreservation proves model-source protection for a fixed carrier.
This file derives a new across-epoch historical statement: once
a particular is owed, the old registration remains owed and the exact
original source assignment persists through *any* number of later
Genesis stages. All finite W-track source histories therefore reconstruct
identically from either epoch.

The theorem does not presume that "recorded = genuine person". It
establishes one necessary consistency property of candidate carrier
provenance and gives a negative control: independently injective
snapshots can silently rewrite the identity assignment.

No QG law, protection criterion, OriginalX3, Complete Koru definition
or existing proof is modified. The source has only six finite slots.
-/

namespace PhysicalBridges.G3GenesisHistoricalProvenance

open PhysicalBridges.G3GenesisCarrierEnrollment
open PhysicalBridges.BCRDParticularCarrierCriterion
open PhysicalBridges.BCRDSourceHistoryProvenance
open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDTransportedParticularMarker

variable {P : Type}

/-- One historically owed candidate remains registered at all later
finite epochs and retains the *same original carrier*. This is
strictly stronger than stagewise injectivity, which alone permits
arbitrary reassignments between snapshots. -/
theorem old_carrier_survives_every_later_genesis
    (owed : Nat → P → Prop) (carrier : Nat → P → Index)
    (hRules : EnrollmentRules owed carrier)
    (n k : Nat) (p : P) (hOwed : owed n p) :
    owed (n + k) p ∧ carrier (n + k) p = carrier n p := by
  induction k with
  | zero =>
      simpa only [Nat.add_zero] using
        (And.intro hOwed (Eq.refl (carrier n p)))
  | succ k ih =>
      obtain ⟨hPresent, hOldCarrier⟩ := ih
      have hNext : owed (n + k + 1) p :=
        hRules.persists (n + k) p hPresent
      have hSame : carrier (n + k + 1) p = carrier (n + k) p :=
        hRules.retainedCarrier (n + k) p hPresent
      have hCarrier : carrier (n + k + 1) p = carrier n p :=
        hSame.trans hOldCarrier
      simpa only [Nat.add_succ] using
        (And.intro hNext hCarrier)

/-- Any future W trajectory of a retained particular is computed from
exactly the same original source position, even after other
particulars are added to the domain. -/
theorem retained_candidate_has_same_finite_W_position
    (owed : Nat → P → Prop) (carrier : Nat → P → Index)
    (hRules : EnrollmentRules owed carrier)
    (n k steps : Nat) (p : P) (hOwed : owed n p) :
    CarrierAt (carrier (n + k)) steps p =
      CarrierAt (carrier n) steps p := by
  have hStable :=
    (old_carrier_survives_every_later_genesis owed carrier
      hRules n k p hOwed).2
  exact congrArg (fun i : Index =>
    trackedPosition i steps) hStable

/-- Original finite source histories AND source records remain exactly
equal for the previously owed candidate across later Genesis stages.
This is stronger than merely having two separately valid records:
the record *content* is stable under the candidate's later
registration. These are generated modeled records, not externally
authenticated observations. -/
theorem retained_candidate_history_cannot_be_rewritten
    (owed : Nat → P → Prop) (carrier : Nat → P → Index)
    (hRules : EnrollmentRules owed carrier)
    (n k steps : Nat) (p : P) (hOwed : owed n p) :
    sourcePhysicalHistory (carrier (n + k) p) steps =
        sourcePhysicalHistory (carrier n p) steps ∧
    sourceRecordedHistory (carrier (n + k) p) steps =
        sourceRecordedHistory (carrier n p) steps := by
  have hStable :=
    (old_carrier_survives_every_later_genesis owed carrier
      hRules n k p hOwed).2
  rw [hStable]
  exact ⟨rfl, rfl⟩

/-- The history equality and local Genesis injectivity compose:
all newly owed candidates at each epoch are noncolliding, while
every previously owed candidate keeps its original finite trace. -/
theorem growing_identity_and_history_are_jointly_stable
    (owed : Nat → P → Prop) (carrier : Nat → P → Index)
    (hRules : EnrollmentRules owed carrier)
    (hInitial : RegisteredInjective owed carrier 0) :
    ∀ n k steps,
      RegisteredInjective owed carrier (n + k) ∧
      (∀ p, owed n p →
        owed (n + k) p ∧
        sourceRecordedHistory (carrier (n + k) p) steps =
          sourceRecordedHistory (carrier n p) steps) := by
  intro n k steps
  constructor
  · exact every_generated_registration_remains_injective
      owed carrier hRules hInitial (n + k)
  · intro p hp
    exact ⟨(old_carrier_survives_every_later_genesis
      owed carrier hRules n k p hp).1,
      (retained_candidate_history_cannot_be_rewritten
        owed carrier hRules n k steps p hp).2⟩

/-- Two individually injective Bool-carrier snapshots may switch the
actual source positions of old candidates without changing the
population. Snapshot injectivity is NOT historical provenance. -/
def firstSnapshot : Bool → Index :=
  fun p => if p then 1 else 0

def rewrittenSnapshot : Bool → Index :=
  fun p => if p then 0 else 1

theorem injective_snapshots_can_rewrite_a_particular :
    Function.Injective firstSnapshot ∧
    Function.Injective rewrittenSnapshot ∧
    firstSnapshot false ≠ rewrittenSnapshot false := by
  refine ⟨?_, ?_, ?_⟩
  · intro p q h
    cases p <;> cases q <;> decide
  · intro p q h
    cases p <;> cases q <;> decide
  · decide

/-- Thus preserving all snapshots' noncollision conditions alone
does not entail old-carrier stability; the historical enrollment
rule hRules.retainedCarrier is independently meaningful. -/
theorem local_injectivity_does_not_force_historical_fidelity :
    ¬ (∀ old new : Bool → Index,
      Function.Injective old →
      Function.Injective new →
      old false = new false) := by
  intro h
  have hContradiction :=
    h firstSnapshot rewrittenSnapshot
      injective_snapshots_can_rewrite_a_particular.1
      injective_snapshots_can_rewrite_a_particular.2.1
  exact injective_snapshots_can_rewrite_a_particular.2.2 hContradiction

#print axioms old_carrier_survives_every_later_genesis
#print axioms retained_candidate_has_same_finite_W_position
#print axioms retained_candidate_history_cannot_be_rewritten
#print axioms growing_identity_and_history_are_jointly_stable
#print axioms injective_snapshots_can_rewrite_a_particular
#print axioms local_injectivity_does_not_force_historical_fidelity

end PhysicalBridges.G3GenesisHistoricalProvenance
