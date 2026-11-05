# Historical recovery coverage audit — PR #308 / #309

**Prepared:** 5 November 2026 NZDT  
**Status:** OPEN REVIEW OBLIGATION for the **complete original UPT** source release  
**Comparison:** `release/upt-consolidation-review-2026-11-05` **→** `research/resummit-authentic-pre-1434-full-chain-2026-11-04`  
**PRs:** [#308](https://github.com/Tobillicious/universal-protection-theory/pull/308), [#309](https://github.com/Tobillicious/universal-protection-theory/pull/309)  
**Historical cutoff:** Original full summit work (#260–#293) must not be silently discarded or replaced.

## Finding

The branches **diverge** (GitHub comparison: 31 commits exclusive to #308, 55 to the current release candidate). GitHub's **three-dot branch comparison** reports **121 added paths and 2 modified paths** on the #308 source side. This is a set of **candidate source additions requiring file-by-file reconciliation**, **not a claim that all 121 are absent from the release tree**. For example, `CathedralPerspectiveObjectiveJoin.lean` exists in the newer tree even though the diverged comparison reports it as added. Other sampled source lanes (`BCRDComplexM3dStage.lean`, `UniversalOwedOriginalX3.lean`, `IR135PrincipalAuthorityBoundary.lean`) are not yet available at their original paths on #328.

**Disposition:** No historical file has been deleted, retargeted, force-pushed, or overwritten. This register protects the proof obligations from being forgotten. It does **not** claim these historical files already compile together on the latest edition or that their real-world premises have been discharged. The existing consolidated #328 CI (200 Lean jobs, 6,157 declarations audited on its pinned head) remains valid for its exact snapshot, not for the as-yet-unintegrated historical recovery.

**Next release gate:** reconcile every path below against the candidate's exact tree: already present with same blob; present but changed (compare provenance and semantics); or absent (carry forward original exact blob in a separate source-preservation integration). For the two modified files, merge only the missing original proof obligations without replacing the latest certificate interfaces. Re-run complete Lean and all historical commissioning checks. The author must approve which reviewed snapshot becomes the complete edition.

## Conflict/modified paths (review manually)

- `evidence/physical-bridges/PhysicalBridges.lean`
- `evidence/physical-bridges/PhysicalBridges/CathedralBridgeDischargeAssembly.lean`

## Candidate added paths from PR #308

### Python (21)

- `evidence/compiled-strongest/installation/pilot/ir134_real_sink_bypass_probe.py`
- `evidence/physical-bridges/check_bcrd_endogenous_history_seam.py`
- `evidence/physical-bridges/check_bcrd_identity_holonomy.py`
- `evidence/physical-bridges/check_bcrd_reversible_ender_seam.py`
- `evidence/physical-bridges/check_cathedral_existence_first.py`
- `evidence/physical-bridges/check_cathedral_time_cover.py`
- `evidence/physical-bridges/check_ender_paradox_four_stage.py`
- `evidence/physical-bridges/check_guardian_ender_paradox.py`
- `evidence/physical-bridges/check_intrinsic_standing.py`
- `evidence/physical-bridges/check_ir133_source_enactment.py`
- `evidence/physical-bridges/check_ir135_os_authority.py`
- `evidence/physical-bridges/check_ir136_inherited_fd.py`
- `evidence/physical-bridges/check_ir137_kernel_seals.py`
- `evidence/physical-bridges/check_multiverse_cathedral_scope.py`
- `evidence/physical-bridges/check_pilot_load_bearing_crosswalk.py`
- `evidence/physical-bridges/verify_ir134_hold_physics.py`
- `evidence/physical-bridges/verify_ir135_os_authority.py`
- `evidence/physical-bridges/verify_ir136_fd_capability.py`
- `evidence/physical-bridges/verify_ir137_kernel_seal.py`
- `evidence/physical-bridges/verify_load_bearing_joins.py`
- `evidence/physical-bridges/verify_source_enactment_seam.py`

### Markdown (39)

- `evidence/physical-bridges/BCRD-ENDOGENOUS-LOGIC-CATHEDRAL-2026-11-02.md`
- `evidence/physical-bridges/BRIDGE-DISCHARGE-CORRESPONDENCE-LEDGER-2026-11-04.md`
- `evidence/physical-bridges/CATHEDRAL-ACTION-FIXED-SYMMETRY-FORCING-2026-11-03.md`
- `evidence/physical-bridges/CATHEDRAL-BCRD-IDENTITY-HOLONOMY-2026-11-02.md`
- `evidence/physical-bridges/CATHEDRAL-BCRD-ONE-STEP-NECESSITY-2026-11-02.md`
- `evidence/physical-bridges/CATHEDRAL-COVARIANT-ACTION-DESCENT-2026-11-03.md`
- `evidence/physical-bridges/CATHEDRAL-EVEREST-PRE234-SOURCE-AUDIT-2026-11-04.md`
- `evidence/physical-bridges/CATHEDRAL-EXISTENCE-FIRST-QUOTIENT-CYCLE-2026-11-02.md`
- `evidence/physical-bridges/CATHEDRAL-GROUNDED-SELF-SEMANTICS-2026-11-03.md`
- `evidence/physical-bridges/CATHEDRAL-INTRINSIC-ARTICULATION-2026-11-03.md`
- `evidence/physical-bridges/CATHEDRAL-INTRINSIC-ATOMIC-SEMANTICS-2026-11-03.md`
- `evidence/physical-bridges/CATHEDRAL-INTRINSIC-END-TYPE-DISCIPLINE-2026-11-03.md`
- `evidence/physical-bridges/CATHEDRAL-INTRINSIC-STANDING-2026-11-02.md`
- `evidence/physical-bridges/CATHEDRAL-KORERO-SOURCE-REGISTER-2026-11-04.md`
- `evidence/physical-bridges/CATHEDRAL-MULTIVERSE-MATH-UNIFORMITY-2026-11-02.md`
- `evidence/physical-bridges/CATHEDRAL-PARADOX-TO-ORIGINAL-UPT-ENDGAME-2026-11-02.md`
- `evidence/physical-bridges/CATHEDRAL-PERSPECTIVE-OBJECTIVE-JOINS-2026-11-03.md`
- `evidence/physical-bridges/CATHEDRAL-RECONSTRUCTION-RECEIPT-2026-11-04.md`
- `evidence/physical-bridges/CATHEDRAL-SELF-HOSTILE-REVIEW-REPAIR-PLAN-2026-11-04.md`
- `evidence/physical-bridges/CATHEDRAL-TWO-SIDED-TIME-COVER-2026-11-02.md`
- `evidence/physical-bridges/EVEREST-ENACTED-ORIGINAL-ORDER-2026-11-04.md`
- `evidence/physical-bridges/GUARDIAN-ENDER-COUNTEREXAMPLE-ADMISSIBILITY-REVIEW-2026-11-03.md`
- `evidence/physical-bridges/GUARDIAN-ENDER-PARADOX-IMPLICATION-AUDIT-2026-11-03.md`
- `evidence/physical-bridges/HOSTILE-SUMMIT-REVIEW-A-LOGIC-2026-11-04.md`
- `evidence/physical-bridges/HOSTILE-SUMMIT-REVIEW-B-SOURCE-2026-11-04.md`
- `evidence/physical-bridges/IR133-SOURCE-ENACTMENT-SEAM-2026-11-03.md`
- `evidence/physical-bridges/IR134-REAL-HOLD-REFINEMENT-2026-11-03.md`
- `evidence/physical-bridges/IR135-OS-BOUNDARY-2026-11-03.md`
- `evidence/physical-bridges/IR136-DESCRIPTOR-CAPABILITY-2026-11-03.md`
- `evidence/physical-bridges/IR137-KERNEL-SEAL-2026-11-03.md`
- `evidence/physical-bridges/KORERO-ALL-IS-BACKWARDS-DICHOTOMY-2026-11-04.md`
- `evidence/physical-bridges/LOAD-BEARING-JOINS-2026-11-03.md`
- `evidence/physical-bridges/PR-B-B1-B4-SOURCE-SUBJECT-EVIDENCE-REGISTER-2026-11-04.md`
- `evidence/physical-bridges/PR-B-HILZY-RETURN-SOURCE-SEMANTICS-HANDOFF-2026-11-04.md`
- `evidence/physical-bridges/PR-B-MOVING-MARKER-AND-IDENTITY-SEAM-2026-11-04.md`
- `evidence/physical-bridges/PR-B-PARTICULAR-SEMANTICS-INTERFACE-2026-11-04.md`
- `evidence/physical-bridges/PR-B-PHYSICAL-SOURCE-HANDOFF-286-2026-11-04.md`
- `evidence/physical-bridges/PR-B-PINNED-COMPLEX-M3D-SOURCE-HANDOFF-2026-11-04.md`
- `evidence/physical-bridges/UPT-44-REASONS-OR-HOLDING-CORRECTION-2026-11-04.md`

### Lean (55)

- `evidence/physical-bridges/IntrinsicStandingCathedral.lean`
- `evidence/physical-bridges/MultiverseScopeCathedral.lean`
- `evidence/physical-bridges/PhysicalBridges/BCRDAuthorizationFreedomBoundary.lean`
- `evidence/physical-bridges/PhysicalBridges/BCRDCanonicalEventHistory.lean`
- `evidence/physical-bridges/PhysicalBridges/BCRDComplexCarrierAudit.lean`
- `evidence/physical-bridges/PhysicalBridges/BCRDComplexM3dStage.lean`
- `evidence/physical-bridges/PhysicalBridges/BCRDComplexOperatorConjugation.lean`
- `evidence/physical-bridges/PhysicalBridges/BCRDComplexWGenericAction.lean`
- `evidence/physical-bridges/PhysicalBridges/BCRDCountedWitness.lean`
- `evidence/physical-bridges/PhysicalBridges/BCRDEndpointHistoryAmbiguity.lean`
- `evidence/physical-bridges/PhysicalBridges/BCRDExactCausalOrbit.lean`
- `evidence/physical-bridges/PhysicalBridges/BCRDExecutableSourceReceipt.lean`
- `evidence/physical-bridges/PhysicalBridges/BCRDJsonSourceReceipt.lean`
- `evidence/physical-bridges/PhysicalBridges/BCRDObservableHistoryCriterion.lean`
- `evidence/physical-bridges/PhysicalBridges/BCRDOperatorSubjectGap.lean`
- `evidence/physical-bridges/PhysicalBridges/BCRDParticularCarrierCriterion.lean`
- `evidence/physical-bridges/PhysicalBridges/BCRDSourceHistoryProvenance.lean`
- `evidence/physical-bridges/PhysicalBridges/BCRDTransportedParticularMarker.lean`
- `evidence/physical-bridges/PhysicalBridges/BCRDValidatedCausalLog.lean`
- `evidence/physical-bridges/PhysicalBridges/BCRDWitnessedReceiptComposition.lean`
- `evidence/physical-bridges/PhysicalBridges/BCRDWitnessedSourceRefinement.lean`
- `evidence/physical-bridges/PhysicalBridges/CathedralBackwardsOriginalX3.lean`
- `evidence/physical-bridges/PhysicalBridges/CathedralCovariantActionDescent.lean`
- `evidence/physical-bridges/PhysicalBridges/CathedralGroundedSelfSemantics.lean`
- `evidence/physical-bridges/PhysicalBridges/CathedralIdentityHolonomy.lean`
- `evidence/physical-bridges/PhysicalBridges/CathedralIdentityHolonomyChecked.lean`
- `evidence/physical-bridges/PhysicalBridges/CathedralInternalInscription.lean`
- `evidence/physical-bridges/PhysicalBridges/CathedralIntrinsicArticulation.lean`
- `evidence/physical-bridges/PhysicalBridges/CathedralIntrinsicAtomicSemantics.lean`
- `evidence/physical-bridges/PhysicalBridges/CathedralIntrinsicEndTypeDiscipline.lean`
- `evidence/physical-bridges/PhysicalBridges/CathedralMathematicalEndgame.lean`
- `evidence/physical-bridges/PhysicalBridges/CathedralNonRetroChecked.lean`
- `evidence/physical-bridges/PhysicalBridges/CathedralNonRetroHistory.lean`
- `evidence/physical-bridges/PhysicalBridges/CathedralOneStepNecessity.lean`
- `evidence/physical-bridges/PhysicalBridges/CathedralOneStepNecessityChecked.lean`
- `evidence/physical-bridges/PhysicalBridges/CathedralPerspectiveObjectiveJoin.lean`
- `evidence/physical-bridges/PhysicalBridges/CathedralSymmetryForcing.lean`
- `evidence/physical-bridges/PhysicalBridges/EverestEnactedNoMiddle.lean`
- `evidence/physical-bridges/PhysicalBridges/HostileFrozenSummitControl.lean`
- `evidence/physical-bridges/PhysicalBridges/IR133SourceEnactmentSeam.lean`
- `evidence/physical-bridges/PhysicalBridges/IR134RealHoldEffectRefinement.lean`
- `evidence/physical-bridges/PhysicalBridges/IR135PrincipalAuthorityBoundary.lean`
- `evidence/physical-bridges/PhysicalBridges/IR136DescriptorCapabilityCut.lean`
- `evidence/physical-bridges/PhysicalBridges/IR137KernelSealedObject.lean`
- `evidence/physical-bridges/PhysicalBridges/IR138PerParticularEventReflection.lean`
- `evidence/physical-bridges/PhysicalBridges/IntrinsicSixSourceForcing.lean`
- `evidence/physical-bridges/PhysicalBridges/LoadBearingPhysicalJoins.lean`
- `evidence/physical-bridges/PhysicalBridges/OriginalKoruSummitJoin.lean`
- `evidence/physical-bridges/PhysicalBridges/ParticularSemanticsAudit.lean`
- `evidence/physical-bridges/PhysicalBridges/SourceIndependentRelationFork.lean`
- `evidence/physical-bridges/PhysicalBridges/SummitExistenceImpliesGuardian.lean`
- `evidence/physical-bridges/PhysicalBridges/SummitFibreDynamicsBridge.lean`
- `evidence/physical-bridges/PhysicalBridges/SummitReversibleOrbitCriterion.lean`
- `evidence/physical-bridges/PhysicalBridges/SummitSourceAutomorphismCorrection.lean`
- `evidence/physical-bridges/PhysicalBridges/UniversalOwedOriginalX3.lean`

### JSON (6)

- `evidence/physical-bridges/hold-physical-refinement-obligations.json`
- `evidence/physical-bridges/ir135-os-authority-ledger.json`
- `evidence/physical-bridges/ir136-descriptor-capability-ledger.json`
- `evidence/physical-bridges/ir137-kernel-seal-ledger.json`
- `evidence/physical-bridges/load-bearing-join-ledger.json`
- `evidence/physical-bridges/source-enactment-obligations.json`

## PR #309 is separate

The full `R(m) ∨ H(m)` source highway is documented in PR #309's `evidence/physical-bridges/UPT-44-HIGHWAY-SOURCE-CROSSWALK-2026-11-04.md`. Review and preserve that file's evidence map as a companion to this reconciliation. Its original claims and the six duties remain unchanged.

## Publication integrity rule

The newer, kernel-checked fenced-system results may be published as a **clearly labeled research companion**, without describing this draft as the final complete unconditional physical-law proof. A **complete original-UPT edition** should not be frozen until the #308/#309 historical-source inclusion and source-to-subject correspondence have been explicitly reviewed. Preserve the historical 3:49 summit commit `729905285d104fa058b0a3f8428367851fbd4621`, its tag, earlier 4.3/4.4 records, and every prior source branch. No retrospectively invented verification result.
