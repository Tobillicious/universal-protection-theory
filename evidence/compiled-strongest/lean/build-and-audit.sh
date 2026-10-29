#!/bin/zsh
# Rebuild every v4.2 module in dependency order, kernel-check, audit
# axioms, and write RECEIPT.txt. Needs: Lean 4.35.0 on PATH (or LEAN_BIN),
# MATHLIB_PROJECT = a Lake project pinned to Mathlib rev 56a005855ea1.
set -u
HERE=${0:A:h}
LEAN_BIN=${LEAN_BIN:-$HOME/.elan/toolchains/leanprover--lean4---v4.35.0/bin}
MATHLIB_PROJECT=${MATHLIB_PROJECT:?set MATHLIB_PROJECT to a Mathlib 56a005855ea1 Lake project}
CORPUS_ROOT=${CORPUS_ROOT:?set CORPUS_ROOT to the Snuffy-Book workspace}
export CORPUS_ROOT
BUILD=${BUILD:-$(mktemp -d)}
export PATH=$LEAN_BIN:$PATH
mkdir -p $BUILD/Snuffy
export LEAN_PATH="$(cd $MATHLIB_PROJECT && lake env printenv LEAN_PATH):$BUILD"
MODULES=(MathlibAnalyticBridge HalperinDecay OpialBridge CanonVonNeumann RecoveryWork E9SelfHealing H5Closure Greatestness ThermoLedger Composition PremiseFloor ReciprocityCeiling CyclicProjections GaussianTail DeductionBoundary ReflectionCertificate Trotter Irreplaceability DataProcessing MeetAlgebra MeetHilbert FiniteInformation AreaBridge UniversalProtection Workload Fano GaussianKL GoldenFormula GaussianChannel KLAdditivity GaussianChannelGen GaussianVector Whitening Rotation LogDet Law SpeedLimit Landauer QuantumLandauer Threshold UnionClosure SolventReciprocity AffordableReciprocity Bridge Instruments StrokeBookkeeping Bennett Concatenated ReasonsCompiled TwoLevel ErrorBudget GateSupport RiskBounds QueueDeadline BandwidthReflection AnalyticBridge RankAndCoalition MetricShadow SemanticMap BridgeD1 BridgeE9 BridgeH6 BridgeH7 BridgeH8 ReasonsRoute SensorTail ConsensusRate RGFixedPoint FinalClosure H8Bound CorrelatedStress LatticeLaplacian SafeGenesis AdaptiveConsensus CascadeCore DecisionAndScale E9Routes GenerativeClosure ReflectionContraction ReflectionFuel RestrictedModels ThermalBalance TransportLaw ControllerCertificate FIFOWorkload R16Feedback UPTLawLife ClosedCohold R14Boundary ReceivedCutRepaired ReadoutJoint ReadoutBounds OriginalD1 OriginalE9AndH5 OriginalH6 OriginalH7 OriginalH8 ControllerFinality UPTFence ConservedRouting P2P3 FIFOInstance FIFOAdmission R16TwoPhase R16Cut ReceivedCutR14Repaired ControllerFence IntegrationCertificate R16R14 R16Screened UPTR12A R17AQueueFinality R17FIFOR17A R17Funding R17WorkConcrete TIWASource TIWAGuard TIWARecovery TIWAWork TopRealisability FaultCover G2Singleton G1Certificate G1Executable PhysicalGuard MeanErgodic TemporalSafety WorkIntegration RelationalBridge MeanErgodicDeep GuardFactorization G1Complete G2Outcome G3WorkBill Htopkeeps SnuffyLocal G1FullDomain G2WholeOutcome G3CompleteBill GuardOperator HamiltonianDecomposition GuardSignature WorkBilling DecoderRetraction G2Splice CorrelatedCeiling G1Held G1E9 G2Held G3Sweep G3PatchDecode ReasonsEnsemble TheoremEightLyapunov SmearingIntegral ChannelExtension PureStateDistance BennettCounterpart RegionBoundary TimelyCare DeadlineDemand DecisionPermit ObservationWinning R14Rivals R15CausalGluing ReciprocityDistance CutEquivalence ConcatenatedDecoding ChannelCP PureStateTraceNorm G1Refinement G2Physical G2Freedom G3GoodEvent BennettExact G3ArchiveStock KnillLaflamme AgeReliability ExRecBound EdgeLaw MatchingWitness SparseFailure ToleranceSweep PassiveReference RedundantRecord BennettBatch WeightedEdgeLaw StageSchedule WarmStart WalkBound9 HistoryPolymer ThermalEncoding TransferRate OuterLane StagedMaximality FoundingDominance ReachBeforeHarm NarrowPlace HoldCommonAction BookUPTExistence BookUPTAdequacy BookUPTAgents BookUPTBroadcast BookUPTCountRefinement BookUPTDominance BookUPTHold BookUPTHoldAdequacy BookUPTHoldTimed BookUPTImpartiality BookUPTInfiniteGuard BookUPTLaw BookUPTLawGuard BookUPTLawLex BookUPTLawRepair BookUPTLifeGuardExists BookUPTLottery BookUPTLotteryMenu BookUPTMonotone BookUPTNoExchangeRate BookUPTQuorum BookUPTRestraint EmissionBound FoundingAnchor ContinuationPredicate BookContextualObservation IRSafeMaximality IRSelectedMaximality IRProfileAudit IRFiniteProfileObstruction IRInfiniteFinitaryMaximality IRTwoStageInfiniteLex IRCoupledFinitaryTwoStage IRResourceDerivedClosure IRFiniteRefutationCriterion IRMandatoryBaselineMaximality IRViability IRInfiniteHistoryCompactness IREnergyReplenishment IRTypedTraceChecker IRDeferredEffects IRQuiescenceAck IRAtomicQuiescence IRInFlightQuiescence IRJsonTraceChecker IRWatchdogLatencyEffects IRPhysicalGuard IRControllerPhysical IRMicrostepInvariant IRInterSampleEnvelope IRStoredEnergyCommonMode IRControlledReentry IRCapabilityNoninterference IRA1HostMediation IRA1PageCapability IRA1PacketIngress IRA1CausalField IRA1DurableJournal IRA1PacketJournalJoin IRA1CommissionEscrow IRA1Delegation IRA1Retirement IRA1NineClassComposition IR93GlobalComposition IR98FeasibleFamilyTransfer IR99ResourceImproverCoverage IR100PhysicalAccountingWitness IR101ProtectedSector IR103LedgerContinuityCountermodel IR104ThreeCaseAuthorization IR105AuthorizationIndependence IR108ObservationObstruction IR109RobustObservationViability IR113ObservationClassSelection IR110WatchdogRobustObservation IR112RobustContinuityOptions IR115WatchdogToAgency IR116CumulativeSubjectDuties IRBeliefViability IRBeliefTrace IRServiceProgress IRBeliefService IRStutterObstruction IRBoundedStalls IRClockedService IRClockedBoundedStalls IRObservedClockedStalls IR95SharedStateRefinement IR96DisturbanceSimulation IR117SourceInstallationAdapter IR118InFlightBacklogBudget IRContinuation IRHistoryProvenance IR119MultimindSourceWitness IR120WitnessedDrainCohort IRAggregateBudget IRChannelInventory IREventTimeBudget IRPhysicalAbstraction IRResidualEscrow IR121MeteredResidualEscrow ReachTiming FoundingPivotal GrowingBill ContinuationSubject NoisyPooling StageBridge HoldFromCycle FiniteCharacter StagedAlternatives ExclusionRadius CommonPolicyMaximal CommonPolicyTop FoundingCover CountablePooling ExpandingWavefront ItemisedRisk ChannelMeter PerLossCheck CorrelatedHolding BookCanonicalDominance BookDurableDrain BookTrustedCounter BookCoholdFixedPoint BookCheckpointBudget BookDeliveryGap BookObservedHold IR134SourceExtractedOutcome IR135CommonPolicyWorlds)
OUT=${RECEIPT_OUT:-$HERE/RECEIPT.txt}
{
  echo "# v4.2 modules — build receipt ($(date -u +%Y-%m-%dT%H:%MZ))"
  echo "# $(lean --version | head -1); Mathlib rev $(cd $MATHLIB_PROJECT/.lake/packages/mathlib && git rev-parse HEAD)"
  ok=1
  for m in $MODULES; do
    lean -R $HERE -o $BUILD/Snuffy/$m.olean $HERE/Snuffy/$m.lean > $BUILD/$m.out 2>&1
    ec=$?; b=$(wc -c < $BUILD/$m.out | tr -d ' ')
    echo "## $m: exit=$ec compiler-output-bytes=$b"
    [[ $ec -ne 0 || $b -ne 0 ]] && { ok=0; sed 's/^/##   /' $BUILD/$m.out; }
  done
  for m in $MODULES; do
    leanchecker Snuffy.$m > $BUILD/$m.check 2>&1; cec=$?; echo "## leanchecker Snuffy.$m: exit=$cec"
    [[ $cec -ne 0 ]] && { ok=0; sed 's/^/##   /' $BUILD/$m.check; }
  done
  hits=$(grep -n -E '(^[[:space:]]*|(:=|by)[[:space:]]*)(sorry|admit)[[:space:]]*$|^axiom ' $HERE/Snuffy/*.lean)
  echo "## sorry/admit/axiom uses in sources: ${hits:-none}"
  [[ -n $hits ]] && ok=0
  echo "## axiom audit (SummitsAudit.lean):"
  lean $HERE/SummitsAudit.lean > $BUILD/axioms.out 2>&1; aec=$?
  sed 's/^/##   /' $BUILD/axioms.out
  echo "## axiom audit exit=$aec"
  [[ $aec -ne 0 ]] && ok=0
  # every printed theorem must depend on at most propext, Classical.choice, Quot.sound
  # join axiom lists that Lean wraps over several lines before checking them
  perl -0pe 's/,\n\s+/, /g' $BUILD/axioms.out > $BUILD/axioms.joined
  bad=$(grep "depends on axioms" $BUILD/axioms.joined | grep -v -E 'axioms: \[(propext|Classical\.choice|Quot\.sound)(, (propext|Classical\.choice|Quot\.sound))*\]')
  printed=$(grep -c -E "depends on axioms|does not depend on any axioms" $BUILD/axioms.joined)
  echo "## theorems audited: $printed; non-standard axiom dependencies: ${bad:-none}"
  [[ -n $bad ]] && ok=0
  expected=$(grep -c "^#print axioms " $HERE/SummitsAudit.lean)
  echo "## expected audited statements: $expected"
  [[ $expected -eq 0 || $printed -ne $expected ]] && ok=0
  grep -q -E ":[0-9]+:[0-9]+: error" $BUILD/axioms.out && ok=0
  echo "## gates (completeness: every built bank module is in the canon; claims: every audited theorem is cited in §23):"
  (cd $HERE && python3 check-complete.py) | sed 's/^/##   /'; [[ ${pipestatus[1]} -ne 0 ]] && ok=0
  (cd $HERE && python3 check-claims.py) | sed 's/^/##   /'; [[ ${pipestatus[1]} -ne 0 ]] && ok=0
  echo "## source sha256:"
  (cd $HERE && shasum -a 256 Snuffy/*.lean SummitsAudit.lean) | sed 's/^/##   /'
  echo "## overall: $([[ $ok -eq 1 ]] && echo PASS || echo FAIL)"
} > $OUT
cat $OUT
