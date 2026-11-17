import PhysicalBridges.LivingTreeFencedEffects
import PhysicalBridges.TotalEOriginalX3Bridge

/-!
# External execution refinement into the fully fenced Learning Tree

Four-layer audit interface:
1. Keep the compiled constructed Guardian/Joker mathematical model.
2. Require independently specified actual steps to refine the joint effect.
3. Preserve SIX separately supplied authentic source-to-subject implications.
4. Never infer universal matterspacetime coverage from a finite model.

This file does not manufacture observations, a real deployment, genuine
subject consent, or a physical law. It refuses to obtain "physical"
coverage merely by defining all physical steps to be safe. The exact
unmodified OriginalX3 target is used.
-/

namespace PhysicalBridges.ExternalJointEffectRefinement

open PhysicalBridges.LivingTreeFencedEffects
open PhysicalBridges.LivingTreeGenerations
open PhysicalBridges.KoruJokerUniverseTrialFeedback
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.FencedOptimiserInstrument
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full
open PhysicalBridges.TotalEOriginalX3Bridge

variable {T H E W P : Type} {n : Nat}

/-- The external event relation is supplied independently of both the
synthetic guard and subject semantics. This is an unproved, falsifiable
system-specific observation/refinement obligation. -/
def AllActualEffectsRefineJoint
    (J : JokerExperiment T FiniteObjectiveU H)
    (realStep : W → W → Prop)
    (read : W → Joint T H E n) : Prop :=
  ∀ w v, realStep w v → jointStep J (read w) (read v)

/-- The SIX independent semantic checks. They are not inferred from
the mathematical names of the source relations, and no field asserts
that the whole OriginalX3 is already true. In a deployment each must
be separately verified with authentic subject-level evidence. -/
structure AuthenticSixReflections
    (realStep : W → W → Prop)
    (read : W → Joint T H E n)
    (carrier : P → Fin n)
    (owed : P → Prop)
    (actual : ParticularRelations W P) : Prop where
  historicalContinuity :
    ∀ w v p, realStep w v → owed p →
      (relations n).continues (read w).2 (read v).2 (carrier p) →
      actual.continues w v p
  authorization :
    ∀ w v p, realStep w v → owed p →
      (relations n).authorized (read w).2 (read v).2 (carrier p) →
      actual.authorized w v p
  freedom :
    ∀ w v p, realStep w v → owed p →
      (relations n).free (read w).2 (read v).2 (carrier p) →
      actual.free w v p
  restraint :
    ∀ w v p, realStep w v → owed p →
      (relations n).restrained (read w).2 (read v).2 (carrier p) →
      actual.restrained w v p
  maximality :
    ∀ w v p, realStep w v → owed p →
      (relations n).maximal (read w).2 (read v).2 (carrier p) →
      actual.maximal w v p
  provenance :
    ∀ w v p, realStep w v → owed p →
      (relations n).provenanced (read w).2 (read v).2 (carrier p) →
      actual.provenanced w v p

/-- The same authentic original-six predicate is now derived on EVERY
external real step from independent exhaustive event refinement and
six independently given subject-level reflections. -/
theorem independently_covered_events_satisfy_original_six
    (J : JokerExperiment T FiniteObjectiveU H)
    (realStep : W → W → Prop)
    (read : W → Joint T H E n)
    (carrier : P → Fin n)
    (owed : P → Prop)
    (actual : ParticularRelations W P)
    (hCoverage : AllActualEffectsRefineJoint J realStep read)
    (hMeaning : AuthenticSixReflections realStep read carrier owed actual) :
    ∀ w v, realStep w v → ∀ p, owed p →
      OriginalX3 actual.continues actual.authorized actual.free
        actual.restrained actual.maximal actual.provenanced w v p := by
  intro w v hReal p hp
  have hModel : FullEvent (relations n) (read w).2 (read v).2 :=
    every_joint_effect_has_all_original_six J (read w) (read v)
      (hCoverage w v hReal)
  have hSix := hModel (carrier p)
  exact ⟨
    hMeaning.historicalContinuity w v p hReal hp hSix.historicalContinuity,
    hMeaning.authorization w v p hReal hp hSix.authorization,
    hMeaning.freedom w v p hReal hp hSix.freedom,
    hMeaning.restraint w v p hReal hp hSix.restraint,
    hMeaning.maximality w v p hReal hp hSix.maximality,
    hMeaning.provenance w v p hReal hp hSix.provenance⟩

/-- Exactly one of the desired physical conclusions: when every
actual effect genuinely refines the constructed mediated boundary AND
all six authentic meanings are reflected, there can be no actual
owed-subject original-six violation in the supplied external domain. -/
theorem no_actual_original_six_violation_under_verified_refinement
    (J : JokerExperiment T FiniteObjectiveU H)
    (realStep : W → W → Prop)
    (read : W → Joint T H E n)
    (carrier : P → Fin n)
    (owed : P → Prop)
    (actual : ParticularRelations W P)
    (hCoverage : AllActualEffectsRefineJoint J realStep read)
    (hMeaning : AuthenticSixReflections realStep read carrier owed actual) :
    ∀ e : W × W,
      ¬ ActualX3Violation
        (fun e : W × W => realStep e.1 e.2)
        (fun (_ : W × W) p => owed p)
        (fun (e : W × W) p =>
          OriginalX3 actual.continues actual.authorized actual.free
            actual.restrained actual.maximal actual.provenanced e.1 e.2 p)
        e := by
  intro e hBad
  rcases hBad with ⟨hReal, p, hp, hNot⟩
  exact hNot
    (independently_covered_events_satisfy_original_six
      J realStep read carrier owed actual hCoverage hMeaning
      e.1 e.2 hReal p hp)

/-- A real observed step supplied independently also receives the
same mathematical effect meter guarantee after successful refinement.
The result concerns the MODEL's meter, not all physical harms. -/
theorem independently_witnessed_effect_has_zero_modeled_residual
    (J : JokerExperiment T FiniteObjectiveU H)
    (realStep : W → W → Prop)
    (read : W → Joint T H E n)
    (hCoverage : AllActualEffectsRefineJoint J realStep read)
    (w v : W) (hReal : realStep w v) :
    residualHarm (read w).2 (read v).2 = 0 :=
  every_joint_effect_has_zero_measured_residual
    J (read w) (read v) (hCoverage w v hReal)

/-- A supplied real witness cannot be invented by the refinement theorem.
When there is such a witness, its original-six proof is nonvacuous for
any independently owed particular. -/
theorem genuinely_witnessed_subject_event_is_protected
    (J : JokerExperiment T FiniteObjectiveU H)
    (realStep : W → W → Prop)
    (read : W → Joint T H E n)
    (carrier : P → Fin n)
    (owed : P → Prop)
    (actual : ParticularRelations W P)
    (hCoverage : AllActualEffectsRefineJoint J realStep read)
    (hMeaning : AuthenticSixReflections realStep read carrier owed actual)
    (w v : W) (p : P)
    (hReal : realStep w v) (hp : owed p) :
    realStep w v ∧
      OriginalX3 actual.continues actual.authorized actual.free
        actual.restrained actual.maximal actual.provenanced w v p :=
  ⟨hReal, independently_covered_events_satisfy_original_six
    J realStep read carrier owed actual hCoverage hMeaning
    w v hReal p hp⟩

#print axioms independently_covered_events_satisfy_original_six
#print axioms no_actual_original_six_violation_under_verified_refinement
#print axioms independently_witnessed_effect_has_zero_modeled_residual
#print axioms genuinely_witnessed_subject_event_is_protected

end PhysicalBridges.ExternalJointEffectRefinement
