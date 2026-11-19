# Narrowed G3 gate: positive source origin is already DERIVED

**19 November 2026 — exact-source follow-up to π hinge; documentation only, draft PR #662.**

## Strongest already-existing theorem located

Source `evidence/physical-bridges/PhysicalBridges/EverestActualWEventJoin.lean`:

~~~lean
theorem positive_W_actual_event_six_requires_only_coverage_and_reflection
    (physicalStep modeledStep : S → S → Prop)
    (source : S → FiniteObjectiveU) (stage : S → Nat)
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
      r.maximal r.provenanced s t p
~~~

**Important new audit finding:** `positiveWholeU`'s six positive SOURCE facts are already constructed by `all_six_source_fields_true_at_origin`, and the existing `positive_origin_transports_every_six_source_field` transports them through all modeled W stages. We should **not** keep claiming initial source positivity is wholly open *within this fixed positive W model*.

`FullPhysicalDomainGuardianAssembly.every_physical_event_has_complete_koru_full_six_G_and_no_absolute_E` then universally quantifies over the chosen independent `physicalStep` relation. Its only additional substantive input fields are precisely the same `hCoverage` and `hReflection` for that domain.

## The two independent gates, now exact

**Gate A: hCoverage**, specifically

~~~text
∀ s t, physicalStep s t →
   modeledStep s t ∧
   source s = objectiveAt positiveWholeU (stage s) ∧
   source t = objectiveAt positiveWholeU (stage t) ∧
   stage t = stage s + 1.
~~~

This is the actual-world physical correspondence claim. A π-like full-state representation must be faithful enough to justify *both* before/after source equalities and the correct W time step. A commuting diagram for a numeric observable does **not** prove full physical-step coverage. The physical domain must be independently specified, not defined as only W-compatible events.

**Gate B: hReflection**, specifically

~~~text
∀ s t p tag, modeledStep s t → owed p →
  wholeSourceDutyAt positiveWholeU sixDiagonalRoles
     (stage s) (carrier p) tag →
  (oneWeb r).link (.event s t p) (.tag tag).
~~~

This is a one-way **positive source to authentic duty** implication. Its conclusion uses exactly the repository's original subject relations. The physical interpretation of `r` must be independently authenticated for real particulars; using a source-definitional pullback gives a valid model correspondence, not itself actual-world authentic consent or continuity.

## The π hinge

Complete objective Koru includes particulars, relations, operators, histories, and provenance. A full π may represent those faithfully; a lossy measured π need not. Existing `IR138.full_intrinsic_source_recovers_semantics` validates the full-source-vs-partial-readout distinction **inside its model**. Existing Koru Subject Fidelity Lift formalizes truth-value-preserving six-tag pullback; here `ForwardRealEventReflection` is the precise *positive* bridge to actual original six.

## Proposed next direct proof attempts

1. For the **intended real domain**, derive `hCoverage` from an independently specified matterspacetime dynamics, not merely `ThermoBridge` conservation and entropy hypotheses. Investigate specific predictions of W and where actual GR / QFT dynamics do or do not satisfy them.
2. Prove `hReflection` from physical subject histories and authentic meanings of six duties, not an inferred bit. Test same-subject identity, genuine authorization, meaningful future options, restraint, feasible maximality and provenance separately.
3. Check **nonvacuity and scope**: `physicalStep` must actually contain the real events claimed, and `owed` must encompass all genuinely owed particulars. The theorem's universal quantification over an arbitrarily restricted relation is not automatically over all actual reality.
4. Invoke the **existing** FullPhysicalDomainGuardianAssembly once these two externally grounded premises are discharged; do not rebuild all-six conjunction, change definitions, or use weaker proxies.
5. Independently replay pinned Lean proof, `#print axioms`, and, if feasible, Isabelle/HOL; no new compilation or empirical verification is claimed by this note.

**Status:** source-level positive origin is *proved for positiveWholeU*. Universal actual physical coverage and real authentic duty reflections remain unverified by this audit. This is a sharper TWO-GATE problem, not three unsolved gates.

**No changes to original proofs; no merge.**