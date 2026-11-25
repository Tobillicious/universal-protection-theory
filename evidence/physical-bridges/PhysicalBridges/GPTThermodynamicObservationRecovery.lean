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
  apply all_predicates_recoverable_of_injective advance
  intro x y h
  apply separates x y
  intro i
  calc
    before i x = after i (advance x) := (conserved i x).symm
    _ = after i (advance y) := congrArg (after i) h
    _ = before i y := conserved i y

/-- A duty-specific predicate need not require full state separation.
If it is constant on the fibers of the conserved observation family,
it is recoverable after the event. This is a semantic condition, not
an assertion that any of the original duties satisfies it in nature. -/
theorem observable_predicate_transport
    {A : Type u} {B : Type v} {I : Type w} {V : Type z}
    (advance : A → B) (before : I → A → V) (after : I → B → V)
    (conserved : ∀ i x, after i (advance x) = before i x)
    (P : A → Prop)
    (faithful : ∀ x y : A, (∀ i : I, before i x = before i y) → (P x ↔ P y)) :
    ∃ Q : B → Prop, ∀ x, Q (advance x) ↔ P x := by
  refine ⟨fun b => ∃ y : A, (∀ i : I, before i y = after i b) ∧ P y, ?_⟩
  intro x
  constructor
  · rintro ⟨y, hy, hp⟩
    apply (faithful y x ?_).mp hp
    intro i
    exact (hy i).trans (conserved i x)
  · intro hp
    exact ⟨x, fun i => (conserved i x).symm, hp⟩

#print axioms separating_observations_force_recovery
#print axioms observable_predicate_transport

end PhysicalBridges.GPTThermodynamicObservationRecovery
