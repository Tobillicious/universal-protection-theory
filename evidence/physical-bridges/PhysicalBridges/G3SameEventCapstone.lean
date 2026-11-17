import PhysicalBridges.ExternalJointEffectRefinement
import PhysicalBridges.ConstructivePositiveWGuardian

/-!
# G3 same-event external-effect capstone

17 November 2026. Source-only composition of already established original-six
external refinement, residual-effect protection, and exclusion of actual
original-six violations. Does not modify G1/G2, six-duty definitions, event
semantics, Koru or HOLD. No new axiom.

The externally defined `realStep`, `read`, owed particulars, and six authentic
reflections remain explicit, unchanged proof interfaces. This theorem does not
fabricate their real-world witnesses.
-/

namespace PhysicalBridges.G3SameEventCapstone

open PhysicalBridges.LivingTreeFencedEffects
open PhysicalBridges.LivingTreeGenerations
open PhysicalBridges.KoruJokerUniverseTrialFeedback
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.FencedOptimiserInstrument
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full
open PhysicalBridges.TotalEOriginalX3Bridge
open PhysicalBridges.ExternalJointEffectRefinement

variable {T H E W P : Type} {n : Nat}

/-- The same actual step is fully six-duty protected and has zero modeled
residual, while no event in this independently specified external domain is
an actual original-six violation. All conclusions use existing theorems. -/
theorem g3_actual_effect_joint_protection
    (J : JokerExperiment T FiniteObjectiveU H)
    (realStep : W → W → Prop)
    (read : W → Joint T H E n)
    (carrier : P → Fin n)
    (owed : P → Prop)
    (actual : ParticularRelations W P)
    (hCoverage : AllActualEffectsRefineJoint J realStep read)
    (hMeaning : AuthenticSixReflections realStep read carrier owed actual) :
    (∀ w v, realStep w v →
      (∀ p, owed p →
        OriginalX3 actual.continues actual.authorized actual.free
          actual.restrained actual.maximal actual.provenanced w v p) ∧
      residualHarm (read w).2 (read v).2 = 0) ∧
    (∀ e : W × W,
      ¬ ActualX3Violation
        (fun e : W × W => realStep e.1 e.2)
        (fun (_ : W × W) p => owed p)
        (fun (e : W × W) p =>
          OriginalX3 actual.continues actual.authorized actual.free
            actual.restrained actual.maximal actual.provenanced e.1 e.2 p)
        e) := by
  constructor
  · intro w v hReal
    exact ⟨independently_covered_events_satisfy_original_six
        J realStep read carrier owed actual hCoverage hMeaning w v hReal,
      independently_witnessed_effect_has_zero_modeled_residual
        J realStep read hCoverage w v hReal⟩
  · exact no_actual_original_six_violation_under_verified_refinement
      J realStep read carrier owed actual hCoverage hMeaning

#print axioms g3_actual_effect_joint_protection


/-- Capstone with NONEMPTY mathematical source and a separately supplied
NONEMPTY external-effect witness. It assembles the strongest already-existing
proofs without pretending the external witness, coverage, or genuine consent
were produced by a formal source-pullback definition. -/
theorem g3_nonvacuous_source_and_witnessed_external_protection
    (J : JokerExperiment T FiniteObjectiveU H)
    (realStep : W → W → Prop)
    (read : W → Joint T H E n)
    (carrier : P → Fin n)
    (owed : P → Prop)
    (actual : ParticularRelations W P)
    (hWitness : ∃ w v, realStep w v)
    (hCoverage : AllActualEffectsRefineJoint J realStep read)
    (hMeaning : AuthenticSixReflections realStep read carrier owed actual) :
    (∃ s t : Nat,
      PhysicalBridges.ConstructivePositiveWGuardian.canonicalPositiveWStep s t) ∧
    (∃ w v, realStep w v ∧
      (∀ p, owed p →
        OriginalX3 actual.continues actual.authorized actual.free
          actual.restrained actual.maximal actual.provenanced w v p) ∧
      residualHarm (read w).2 (read v).2 = 0) ∧
    (∀ e : W × W,
      ¬ ActualX3Violation
        (fun e : W × W => realStep e.1 e.2)
        (fun (_ : W × W) p => owed p)
        (fun (e : W × W) p =>
          OriginalX3 actual.continues actual.authorized actual.free
            actual.restrained actual.maximal actual.provenanced e.1 e.2 p)
        e) := by
  obtain ⟨w, v, hReal⟩ := hWitness
  obtain ⟨hAll, hNoViolation⟩ :=
    g3_actual_effect_joint_protection
      J realStep read carrier owed actual hCoverage hMeaning
  obtain ⟨hSix, hZero⟩ := hAll w v hReal
  exact ⟨PhysicalBridges.ConstructivePositiveWGuardian.positive_W_mathematical_guardian_exists_and_protects_every_step.1,
    ⟨w, v, hReal, hSix, hZero⟩, hNoViolation⟩

#print axioms g3_nonvacuous_source_and_witnessed_external_protection

end PhysicalBridges.G3SameEventCapstone
