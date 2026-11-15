# Correction: event-sensitive original six already banked (16 November 2026)

This is an explicit correction to the earlier PR #509 research notes, preserving existing proofs and original six unchanged.

## Recovered existing exact theorem

`PhysicalBridges.HillaryTotalEExactCrosswalk.every_original_six_iff_no_actual_violation` already uses `owed : ActualState → ActualState → P → Prop` and establishes equivalence of all-six protection at each actual owed event with absence of an actual owed original-six violation. Its `hillary_semantics_iff_total_E_bridge` establishes, under stated source assumptions, the equivalence of the Hillary semantic reflection and violation-to-AbsoluteE bridge. **Equivalence is not discharge**: proving one by restating the other is circular.

`PhysicalBridges.GuardianCreatorConditionalJoin.conditional_guardian_creator_at_each_genesis` already uses the same event-dependent owedness and proves an authored, protected modeled Genesis boundary under physical source refinement, nonterminality, three authentic reflection hypotheses, and independent authorship. Its `no_unconditional_genesis_from_source_only` establishes a concrete negative control.

## Consequence for this PR

The added `EventSensitiveOwedGuardian.lean` is an optional interface lift of the positive-W theorem using an **all-subject reflection** premise (`owed := fun _ => True`). It is *not* the first or weakest event-sensitive result, and it should not be represented as independently discharging subject-level semantics. The existing Route-A/Route-B event-dependent result is the more precise theorem to use for the universal target.

## Exact next work

1. Identify an independent physical law that yields `RespectsCanonicalSource` for actual events without defining actual steps as protected steps.
2. Establish the authentic three reflection predicates independently of the conclusion `OriginalSixAt`; check identity, consent, freedom, restraint, feasible maximality, provenance.
3. Prove nonterminal Genesis and actual authorship only if independently physically justified; avoid deriving these from modeled integer succession alone.
4. Require non-vacuity and actual physical interpretation of every quantified event/particular.
5. Preserve the negative controls: source preservation without Genesis; full intrinsic representation with a false subject screen; non-erasure without local X3.

The physical bridge CI pass for the earlier PR commit is a kernel-check milestone, not a real-world universal certificate.
