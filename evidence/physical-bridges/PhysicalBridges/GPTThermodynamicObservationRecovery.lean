import PhysicalBridges.KoruConservation
import PhysicalBridges.G3KoruVsEnergyConservation

/-!
# Thermodynamic observation separation and Complete Koru recovery

A candidate additive lemma: a jointly separating family of derived
observations, preserved by a complete event, forces injectivity.
Individual scalar conservation does not suffice. No actual-world
coverage, authorization, or agency claim is made by this lemma.
-/
namespace PhysicalBridges.GPTThermodynamicObservationRecovery

open PhysicalBridges.KoruConservation

universe u v w z

theorem separating_observations_force_recovery
    {A : Type u} {B : Type v} {I : Type w} {V : Type z}
    (advance : A → B)
    (before : I → A → V)
    (after : I → B → V)
    (separates : ∀ x y : A, (∀ i : I, before i x = before i y) → x = y)
    (conserved : ∀ i x, after i (advance x) = before i x) :
    AllPredicatesRecoverable advance := by
  apply all_predicates_recoverable_of_injective
  intro x y h
  apply separates x y
  intro i
  calc
    before i x = after i (advance x) := (conserved i x).symm
    _ = after i (advance y) := congrArg (after i) h
    _ = before i y := conserved i y

#print axioms separating_observations_force_recovery

end PhysicalBridges.GPTThermodynamicObservationRecovery
