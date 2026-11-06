import PhysicalBridges.OriginalKeystoneForwardSemanticReflection

/-!
# Everest: from one positive objective W whole to independently enacted physical events

7 November 2026. Additive, research-only proof. Original Koru and ALL SIX
original-X3 duties are unchanged. This composes the positive source test
(#386) with the minimal one-way semantic reflection theorem.

Three INDEPENDENT inputs are kept separate:
  (1) FULL physical coverage: every actual event is a modeled event, with
      complete before/after operator-U representations and consecutive W stages;
  (2) POSITIVE source origin: all six intrinsic source relations hold for owed
      particulars at stage zero;
  (3) FORWARD authentic reflection: when a source duty is true, the SAME actual
      event satisfies that independently interpreted subject duty.

The source dynamics is the already-defined W operator, not a safety-filtered
transition. A separate real physical step relation is NEVER defined by X3.
The result applies only to the specified W-refinement, NOT to all real physics.
The failure theorem identifies which of the three independent joins would have
to fail if an actual original-six violation occurred.

No additional axioms or proof placeholders, no new physical correspondences, no publication edit.
-/

namespace PhysicalBridges.EverestActualWEventJoin

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruWholeUSixDutyWebJoin
open PhysicalBridges.KoruSixOriginalRelationsOneWeb
open PhysicalBridges.OriginalKeystoneForwardSemanticReflection
open PhysicalBridges.OriginalKeystonePositiveWholeTest
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full

variable {S P : Type}

/-- Actual physical events and the modeled W-source event relation are
independent. Coverage requires full before/after source representations
AND correct next-stage timing, not only a timestamp or logged label. -/
def CompleteWEventCoverage
    (physicalStep modeledStep : S → S → Prop)
    (source : S → FiniteObjectiveU)
    (stage : S → Nat) (U : FiniteObjectiveU) : Prop :=
  ∀ s t, physicalStep s t →
    modeledStep s t ∧
    source s = objectiveAt U (stage s) ∧
    source t = objectiveAt U (stage t) ∧
    stage t = stage s + 1

/-- Forward source -> independently interpreted physical-subject reflection.
The source link is NOT defined to equal the subject duty. Only its
independently established truth can be used to imply the subject fact. -/
def ForwardRealEventReflection
    (modeledStep : S → S → Prop)
    (stage : S → Nat)
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (carrier : P → Index) (r : ParticularRelations S P)
    (owed : P → Prop) : Prop :=
  ∀ s t p (tag : DutyTag), modeledStep s t → owed p →
    wholeSourceDutyAt U roles (stage s) (carrier p) tag →
      (oneWeb r).link (.event s t p) (.tag tag)

/-- An actual physical event is W-generated and preserves ALL six ORIGINAL
subject duties under the separately stated coverage, origin and forward
reflection premises. This is a physical-event conditional, not an
unconditional assertion that the universe satisfies the premises. -/
theorem actual_event_has_exact_W_and_six_original_duties
    (physicalStep modeledStep : S → S → Prop)
    (source : S → FiniteObjectiveU)
    (stage : S → Nat)
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (carrier : P → Index) (r : ParticularRelations S P)
    (owed : P → Prop)
    (hCoverage : CompleteWEventCoverage physicalStep modeledStep source stage U)
    (hOrigin : PositiveSourceOrigin U roles carrier owed)
    (hReflection : ForwardRealEventReflection
      modeledStep stage U roles carrier r owed)
    (s t : S) (hPhysical : physicalStep s t)
    (p : P) (hOwed : owed p) :
    source t = objectiveStep (source s) ∧
    OriginalX3 r.continues r.authorized r.free r.restrained
      r.maximal r.provenanced s t p := by
  obtain ⟨hModeled, hBefore, hAfter, hNext⟩ :=
    hCoverage s t hPhysical
  constructor
  · calc
      source t = objectiveAt U (stage t) := hAfter
      _ = objectiveStep (objectiveAt U (stage s)) := by rw [hNext]; rfl
      _ = objectiveStep (source s) := by rw [hBefore]
  · apply (complete_profile_iff_original_x3 r s t p).mp
    intro tag
    exact hReflection s t p tag hModeled hOwed
      (positive_origin_transports_every_six_source_field
        U roles carrier owed hOrigin (stage s) p hOwed tag)

/-- Exact contrapositive audit: a genuine original-six physical-event
violation refutes at least one independently stated source obligation.
This is a proof-dependency localization, not an assertion that violations
actually occur. The three alternatives are never silently strengthened. -/
theorem physical_violation_refutes_a_named_join
    (physicalStep modeledStep : S → S → Prop)
    (source : S → FiniteObjectiveU)
    (stage : S → Nat)
    (U : FiniteObjectiveU) (roles : SourceDutyRoles)
    (carrier : P → Index) (r : ParticularRelations S P)
    (owed : P → Prop)
    (s t : S) (hPhysical : physicalStep s t)
    (p : P) (hOwed : owed p)
    (hViolation : ¬ OriginalX3 r.continues r.authorized r.free
      r.restrained r.maximal r.provenanced s t p) :
    ¬ CompleteWEventCoverage physicalStep modeledStep source stage U ∨
    ¬ PositiveSourceOrigin U roles carrier owed ∨
    ¬ ForwardRealEventReflection modeledStep stage U roles carrier r owed := by
  classical
  by_cases hCoverage :
      CompleteWEventCoverage physicalStep modeledStep source stage U
  · by_cases hOrigin : PositiveSourceOrigin U roles carrier owed
    · right
      right
      intro hReflection
      exact hViolation
        (actual_event_has_exact_W_and_six_original_duties
          physicalStep modeledStep source stage U roles carrier r owed
          hCoverage hOrigin hReflection s t hPhysical p hOwed).2
    · exact Or.inr (Or.inl hOrigin)
  · exact Or.inl hCoverage

/-- In the existing concrete positive-U instance, origin positivity
is DERIVED from the operator entries, not another premise. Only actual
coverage and authentic one-way subject reflection remain. -/
theorem positive_W_actual_event_six_requires_only_coverage_and_reflection
    (physicalStep modeledStep : S → S → Prop)
    (source : S → FiniteObjectiveU)
    (stage : S → Nat)
    (carrier : P → Index) (r : ParticularRelations S P)
    (owed : P → Prop)
    (hCoverage : CompleteWEventCoverage physicalStep modeledStep
      source stage positiveWholeU)
    (hReflection : ForwardRealEventReflection
      modeledStep stage positiveWholeU sixDiagonalRoles carrier r owed)
    (s t : S) (hPhysical : physicalStep s t)
    (p : P) (hOwed : owed p) :
    source t = objectiveStep (source s) ∧
    OriginalX3 r.continues r.authorized r.free r.restrained
      r.maximal r.provenanced s t p := by
  exact actual_event_has_exact_W_and_six_original_duties
    physicalStep modeledStep source stage positiveWholeU
    sixDiagonalRoles carrier r owed
    hCoverage
    (fun p _ => all_six_source_fields_true_at_origin (carrier p))
    hReflection s t hPhysical p hOwed

#print axioms actual_event_has_exact_W_and_six_original_duties
#print axioms physical_violation_refutes_a_named_join
#print axioms positive_W_actual_event_six_requires_only_coverage_and_reflection

end PhysicalBridges.EverestActualWEventJoin
