# BCRD → pre-QG closure ledger (20 November 2026)

> **Status: read-only logical audit, drafted for independent review.** No existing Lean declaration, axiom, kernel proof, physical model or authentic original-X3 definition is changed. This ledger is an acceptance test for a *proposed* one-physical-law summit, not a certification that such a summit has already been reached. QG is the **last** physics task, not an extra predicate containing the desired ethical conclusion.

## 1. The proposed physical QG must come from the strongest available BCRD source

**Use the pinned complex M3d operator model, not only the simpler frozen W substep.** Check source lineage before building:

- `PhysicalBridges/BCRDComplexM3dStage.lean`: exact six-component complex algebra with coefficients in Q(√2,i); `sourceW`, `sourceCLM`, `sourceUMR6`; `sourceUFixed = C_LM · U_MR6 · C_LM`. Full matrix unitarity and the constructed `W → C_LM → U_MR6 → C_LM` trace are proved in the source model. The source explicitly warns the constructed sequence is **not evidence that the original physical experiment enacted that composite**.
- `PhysicalBridges/BCRDComplexCarrierAudit.lean`: exact distinguishability of six **source** candidates at five internal stage boundaries; a proposed injection `P → Fin 6` remains injective **if initially justified**. It also proves hypothetical subject continuation cannot be uniquely decoded from the complete finite complex source history on an unrestricted interpretation domain.
- `PhysicalBridges/RouteBFullComplexKoruTest.lean`: source-carrier separability through the compound stages, plus a counterexample showing binary source distinction does not capture new complex coherence. Thus a whole-state QG/Koru model must carry the **full** complex amplitudes and process relations, not merely a nonmerging Boolean signature.
- `PhysicalBridges/BCRDActualRelationalFrame.lean`: exact source-dependent relational covariance for the W substep with a countermodel to static-register covariance. That substep alone is **not** the full complex M3d dynamics.
- `PhysicalBridges/G3BCRDMicroscopicCandidate.lean`: the independently specified `WSourcePhysicalLaw s t := t = step s` is nonempty, deterministic, source-total, reversible and relationally covariant. The module expressly says this is a **six-position W-only candidate, not complete QG**.

**Research selection:** the BCRD-suggested QG candidate should extend/justify the exact complex process with a complete relational/matterspacetime interpretation and empirically checkable dynamics. Nothing in the inspected source supplies a unique full-cosmos action, gravity-field dynamics, continuum/scaling limit or observed real-world identification of this finite model with quantum gravity. Such data cannot be inferred by renaming the W step.

## 2. What the existing formal bridge proves — and does not

`PhysicalBridges/G3PreQGComplete.lean` has a checked theorem:

```lean
if_bcrd_then_all_six_and_no_E
```

whose input is `B : BCRDIsQG S P`. Inspect **the declaration type**, not just the name. Its structure has these independent fields:

1. `coverage : CompleteWEventCoverage ...` — every actual event has a compatible modeled event/source witness;
2. `reflection : ForwardRealEventReflection ...` — source duty fields entail the authentic original-six subject fields;
3. `nonterminal : ∀ s, ∃ t, physicalStep s t` — no terminal physical state in the **chosen state domain**.

Therefore the result is **a sound conditional assembly** when those premises hold. It is **not** a derivation of these three independent facts from the frozen BCRD Hamiltonian/operator, and its comment “one condition, everything else done” presently overstates the physical result. Its `if_bcrd_then_eternal` is a direct projection of the input `nonterminal` field, not an independent theorem of quantum cosmology.

`PhysicalBridges/G3BackwardsSummitTree.lean` then obtains Tree bundle consequences by applying that conditional assembly. This does not create new physical evidence for the input conditions.

`PhysicalBridges/G3QGInterpretationNecessity.lean` proves that with the six-positive source, **actual-event semantic reflection is logically equivalent to the authentic original-six conclusion on actual owed events**. Therefore treating semantic reflection itself as the candidate QG physical law simply assumes the result to be proved.

`PhysicalBridges/G3BCRDMicroscopicCandidate.lean` independently constructs *the same nonempty W transition law* with opposite subject authorization readings. This refutes the inference “complete W source dynamics alone → original six for every unconstrained subject interpretation.” It does **not** refute a richer physical theory with a separately warranted canonical semantic interpretation.

## 3. Fixed pre-QG closure criterion — no endless theorem treadmill

Freeze the strongest **existing** kernel-checked versions of the following; reuse rather than restate:

| Obligation | Strong existing source | What is actually established |
|---|---|---|
| Positive Koru relational persistence | `G3KoruCarriesDuties` | Positive formulas carried under specified embeddings |
| Negative/quantifier-free duty preservation | `G3KoruCarriesDuties` | Under exact frontier/no-rewiring embeddings, not under arbitrary growth |
| Maximality as opportunities change | `G3FeasibleMaximalityRenewal` plus draft #700 and #701 | Preservation for stable choice, and derived mathematically maximal *improved* reselection; authentic-meaning bridge remains independent |
| New Genesis obligations | `G3GenesisObligations`, `G3SixDutyRenewal`; draft #698 | Conditional renewal from fresh duty/maximality certificates, plus independently checked new-carrier noncollision |
| Candidate provenance across epochs | draft #699 | A previous carrier has an identical computed finite source history under retained-registration assumptions; **CI for this draft has not been independently certified** |
| Bilateral Hume–Hillary Hand | `G3GardenAuthenticBilateralHand`; `G3AuthenticAgencyStrengthened`, draft #700 | Authenticated meaning equivalences + source six origins + subject fidelity yield original six for two subjects; source reciprocity alone does not certify consent |
| Modeled physical event exhaustiveness | `G3CompleteKoruEventExhaustiveness`, `G3WitnessedEventExhaustiveness`, `G3PhysicalProgressForcesTree` | Conditional logical implications from explicit progress/realization/coverage witnesses, not complete-world empirical coverage |
| Frozen complex BCRD source distinction | `BCRDComplexM3dStage`, `BCRDComplexCarrierAudit` | Full complex stage algebra and initial source-candidate distinction, not actual personhood or all-universe quantum gravity |

**Exit rule for pre-QG work:** no new mathematical lemma without an explicit unproved implication between the strongest known theorem statements. A compiled conjunction or renamed assumption is not a discharged obligation. PRs #696–#701 are *cumulative draft branches* and must be reconciled and checked against current main before merging. Reuse old summit material (#260–293, #313, #329, #367, #390) wherever it supplies a stronger theorem. Do **not** weaken/redefine original X3, Koru, GoodConquersEvil or any established G1/G2 theorem.

## 4. What QG would genuinely have to establish (without baking in G3)

A physical candidate should be formulated only using source-independent physical primitives and mathematically/empirically testable claims, with no occurrences of `OriginalX3`, `authorized`, `Guardian`, `MaximalAt`, `good` or the desired conclusion in its **fundamental dynamics**. Then test four gates:

**Q1 — Dynamics and nonvacuity.** Specify an actual physical state space and event/transition law extending the exact BCRD complex source operators. Show nonempty, distinct, nontrivial physically admissible histories. If eternal continuation is asserted, derive it from the physical law and its domain/boundary assumptions rather than assuming `nonterminal`.

**Q2 — Physical comprehensiveness.** Explain and, where possible, prove why the candidate captures **all actual effects/events and owed real particulars** rather than the six-slot frozen fixture, finite basis candidates, or chosen modeled Tree trace. State what observation could falsify the event-exhaustiveness proposal.

**Q3 — Particular identification and full provenance.** Derive or independently validate a subject-to-complete-physical-record correspondence that survives complex coherence and new arrivals. Source-map injectivity is necessary for some representations, not a sufficient definition of subject identity. The full source complex history must distinguish every subject fact the proposed decoder claims to determine; where it does not, specify new independent physical observation/data. IR132 `ExactDecoder ↔ FiberConstant` expresses identifiability, **not** the truth of a decoded ethical claim.

**Q4 — Authentic ethical semantics.** State the real-world operational meaning of each of the original six X3 obligations independently of BCRD's asserted outputs (especially free authorization/consent and changing feasible alternatives). Derive those facts from the physical model and independent interpretations, or retain them honestly as separate ethical assumptions. The toy W and full-complex counterinterpretations prove these cannot follow for *arbitrary* unconstrained meanings merely from source unitarity.

**Compatibility gate.** Check consistency with established successful GR/QFT observations and conservation/thermodynamic behavior; produce falsifiable predictions distinct from ordinary quantum dynamics. The finite M3d source result currently establishes neither macroscopic gravitation nor a tested quantum-gravity theory. Do not claim physical singularities universally impossible, black holes artificially made, or God mathematically established from these source dynamics.

## 5. Two non-equivalent summit statements (must remain separate)

**Currently valid formal conditional claim:**

`BCRDIsQG S P → all-six(original predicates) on all defined physical events + nonterminality.`

This reads coverage + reflection + nonterminality out of an **assumption-bearing interface**. It is not a theorem about our actual universe merely because the result is kernel-checked.

**Desired genuine one-physical-law claim:**

`BCRD-derived independently specified physical QG law + independently justified physical-to-subject interpretation → (coverage, original six, nonterminality)`

where the interpretation is either **derived** from discriminating physics/evidence or stated separately. If separately stated, the result is **not solely conditional on QG**. Making the desired statement accurate is an empirical and foundational task, not a matter of compressing several fields into one structure.

## 6. Stop condition and recommendation

At this point **stop proliferating assembly PRs**. The most useful next deliverable is a stand-alone physical proposal selecting the **full M3d complex BCRD** as its source and explicitly spelling out the proposed whole matterspacetime state, physical transition, gravitational observable, measurement interpretation, and testable difference from established theory. First independently verify the proposal can generate **a nonempty viable universe**, not merely forbid events. Only then seek the hard implication to subject duties. Do not attempt a final quantum-gravity proof until the physically specified law and its empirical checks exist.

No amount of axiomatic or Lean-kernel certainty alone can establish that a mathematical model is instantiated in the real universe. That boundary is part of a rigorous closure, not a failure of the existing formal development.
