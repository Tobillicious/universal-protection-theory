import PhysicalBridges.KoruConservation
import PhysicalBridges.AllIsWithinEventHistory
import PhysicalBridges.KoruSubjectFidelityLift

/-!
# Koru conservation: cross-module preservation bridge

This module joins independently established results, without weakening
or changing the existing original-six-X3 definitions.

(1) Any existing genuinely relational microhistory has injective
    carried positions, so every property of an initial position is
    recoverable on its image at every finite represented stage.
(2) The frozen W model's independent carrier plus exact source/subject
    fidelity and positive source origin jointly give BOTH recoverable
    initial distinctions and all six original subject-level X3 fields.

The latter is a conditional source-to-subject theorem; it does NOT
prove that actual experiencing subjects meet the fidelity, source-origin,
or world-coverage hypotheses. Predicate recovery is NOT a claim that
all named physical objects survive as the same objects.
-/

namespace PhysicalBridges.KoruConservationPhysicalBridge

open PhysicalBridges.KoruConservation
open PhysicalBridges.AllIsWithinEventHistory
open PhysicalBridges.KoruSubjectFidelityLift
open PhysicalBridges.BCRDParticularCarrierCriterion
open PhysicalBridges.KoruOperatorIndexedSubjectSemantics
open PhysicalBridges.KoruSixOriginalRelationsOneWeb
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full
open PhysicalBridges.FrozenBCRDEvents

universe u

/-- Existing source-level relational evolution is sufficient to
recover EVERY initial predicate from the carried state. The bridge
uses the independently proved injectivity of the microhistory carry,
not an additional assumption that all predicates are protected. -/
theorem relational_history_recovers_all_origin_predicates
    (H : RelationalMicrohistory) (n : Nat) :
    AllPredicatesRecoverable (AllIsWithinEventHistory.carry H n) := by
  exact all_predicates_recoverable_of_injective
    (AllIsWithinEventHistory.carry H n) (carry_remains_injective H n)

/-- Expanded recoverability statement, useful for source/whole joins. -/
theorem relational_history_recovers_each_origin_predicate
    (H : RelationalMicrohistory) (n : Nat)
    (P : H.Position 0 → Prop) :
    ∃ Q : H.Position n → Prop,
      ∀ x : H.Position 0,
        Q (AllIsWithinEventHistory.carry H n x) ↔ P x := by
  exact relational_history_recovers_all_origin_predicates H n P

/-- The exact frozen-W source/subject bridge: every initial
particular distinction is recoverable, and ALL SIX original-X3
fields hold at each modeled stage, provided the independently
stated carrier, origin, and subject-semantic fidelity inputs hold.
The X3 predicates are unchanged from the imported source. -/
theorem W_carrier_recoverability_and_original_six
    {P : Type}
    (r : ParticularRelations Nat P)
    (d : SixOperatorSourceDuties)
    (roles : Index → Fin 4 → Index)
    (carrier : P → Index)
    (hCarrier : Function.Injective carrier)
    (hOrigin : ∀ p : P, SixSourceTruth 0 d (roles (carrier p)))
    (hFidelity : WholeSourceFidelity r d roles carrier) :
    ∀ n : Nat,
      AllPredicatesRecoverable (CarrierAt carrier n) ∧
      (∀ p : P,
        OriginalX3 r.continues r.authorized r.free
          r.restrained r.maximal r.provenanced n (n + 1) p) := by
  intro n
  obtain ⟨hInj, hSix⟩ :=
    independent_carrier_and_semantics_jointly_lift
      r d roles carrier hCarrier hOrigin hFidelity n
  exact ⟨all_predicates_recoverable_of_injective _ hInj, hSix⟩

#print axioms relational_history_recovers_all_origin_predicates
#print axioms relational_history_recovers_each_origin_predicate
#print axioms W_carrier_recoverability_and_original_six

end PhysicalBridges.KoruConservationPhysicalBridge
