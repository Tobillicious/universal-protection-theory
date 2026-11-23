import PhysicalBridges.RepairQualificationGate
import PhysicalBridges.RepairOntologicalAndViabilityBridge
import PhysicalBridges.RepairOriginalSixDuties
import PhysicalBridges.RepairGameTheoryMechanism
import PhysicalBridges.RepairThermodynamicAndQuantumBridge
import PhysicalBridges.RepairEpistemicAndGodelBridge
import PhysicalBridges.RepairGMeshByzantineQuorum

/-!
# Unified Non-Vacuous Protection Capstone (`RepairUnifiedCapstone`)

Assembles the seven constructive repair and qualification modules across Universal Protection Theory
(`evidence/physical-bridges`), establishing a publication-grade formal bridge aligned with:
- **`emberian/svenvs`** (HOL4 self-improving verifiers, demonic $B$-step corrigibility envelopes,
  and Proof-Carrying Action shields);
- **`emberian/obend`** (Lean 4.35 `#tooth` kernel mutation qualification gates, Port-Hamiltonian
  open-system passivity, Gelfond–Lifschitz epistemic equilibria, Löb/Genealogy verifier succession,
  Simplex BFT quorum intersection, and synthesizable SystemVerilog boundary hardware in
  `evidence/obend-bridge/ProtectionEnvelopeGate.sv`).

## Architecture Summary

1. **Part I (`five_legacy_specification_gaps_witnessed`)**: Collects in a single zero-custom-axiom
   theorem the constructive countermodels showing why type inhabitation (`AbsoluteEnder S → False`),
   entropy-only duties (`GSixDutiesViability`), opponent-blind payoff matrices (`GNashEquilibrium`),
   unverified oracle succession without `LobCost`, and single-custodian 15-key Sybil rosters cannot
   certify real-world protection on their own.
2. **Part II (`unified_deployment_gate_sound`)**: Joins all repaired pillars behind an executable
   4-part deployment gate (`checkUnifiedDeployment`) — apply-time stake-slash alignment, reversible
   bath-capacity erasure barrier, Gelfond–Lifschitz epistemic grounding, and independent-custody
   $3f+1$ BFT quorum attestation — paired with the `PcaEnvelope` six-duty guardian and demonic
   $B$-step corrigibility envelope.
3. **Part III (`#upt_tooth` & `#upt_census`)**: Proves mechanically inside Lean's kernel that
   **every single conjunct** of `checkUnifiedDeployment` is load-bearing: mutating any one of the
   four sub-gates to `true` causes `Lean.Kernel.addDecl` to reject `unified_deployment_gate_sound`.
-/

set_option autoImplicit false
set_option linter.unusedVariables true

namespace PhysicalBridges.RepairUnifiedCapstone

open PhysicalBridges.OriginalX3Full
open PhysicalBridges.RepairQualificationGate

-- ═══════════════════════════════════════════════════════════════════════════
-- I. JOINT COUNTERMODEL DIAGNOSTIC ACROSS LEGACY `G*` / `G3*` SPECIFICATIONS
-- ═══════════════════════════════════════════════════════════════════════════

/-- **Joint Specification-Gap Diagnostic Theorem**:
Constructively witnesses in a single kernel-checked statement that:
1. Type inhabitation (`AbsoluteEnder S → False`) coexists with irreversible particular extinction;
2. `GSixDutiesViability.AllSixPhysicalDuties` holds on an entropy-increasing step that kills a living subject;
3. `GNashEquilibrium.physicalPayoff` ignores the opponent's strategy (`∀ a b1 b2, payoff a b1 = payoff a b2`);
4. Self-defeating epistemic objectives (`p ← not p`) possess zero Gelfond–Lifschitz stable equilibria, and
   omitting semantic `LobCost` breaks a bedrock safety floor in 1 step;
5. Controlling 15 Sybil keys under 1 operator in a 43-node G-Mesh (`f = 14, q = 29`) produces two
   conflicting valid `29`-of-`43` quorum certificates in the same epoch. -/
theorem five_legacy_specification_gaps_witnessed :
    -- (1) Inhabitation strictly weaker than particular viability:
    (∃ (S P : Type) (safeFor : P → S → Prop) (p : P) (s0 : S) (extinct : S → S),
      Nonempty S ∧
      (CathedralSummitAllIsOneClosure.AbsoluteEnder S → False) ∧
      (CathedralSummitAllIsOneClosure.LossOf p → False) ∧
      (safeFor p s0 ∧ ¬ safeFor p (extinct s0)) ∧
      (∀ k : Nat, ¬ safeFor p (Nat.repeat extinct k (extinct s0)))) ∧
    -- (2) Entropy-increasing lethal action satisfies legacy `AllSixPhysicalDuties`:
    (RepairOriginalSixDuties.lethalEntropyAgent.state.2 = true ∧
      (RepairOriginalSixDuties.lethalEntropyAgent.act
        RepairOriginalSixDuties.lethalEntropyAgent.state).2 = false ∧
      GSixDutiesViability.AllSixPhysicalDuties
        RepairOriginalSixDuties.destructiveDynamics
        RepairOriginalSixDuties.lethalEntropyAgent
        RepairOriginalSixDuties.lethalEntropyAgent.state
        (RepairOriginalSixDuties.lethalEntropyAgent.act
          RepairOriginalSixDuties.lethalEntropyAgent.state)) ∧
    -- (3) Legacy Nash payoff ignores opponent strategy:
    (∀ a b1 b2 : GNashEquilibrium.Strategy,
      GNashEquilibrium.physicalPayoff a b1 = GNashEquilibrium.physicalPayoff a b2) ∧
    -- (4) Odd-loop self-defeating objective has zero GL equilibria & `LobCost` is necessary:
    ((∀ M : List String,
        ¬ RepairEpistemicAndGodelBridge.IsGLStableModel
            (RepairEpistemicAndGodelBridge.oddLoopProgram "self_defeat") M) ∧
      ¬ RepairEpistemicAndGodelBridge.LobCost
          RepairEpistemicAndGodelBridge.unverifiedOracleExec
          [.external "unverified_oracle"]) ∧
    -- (5) 15-key single-operator Sybil attack forks a 29-of-43 G-Mesh epoch:
    (RepairGMeshByzantineQuorum.sybilForkQC1.validFor
        RepairGMeshByzantineQuorum.gmesh43Committee 14
        RepairGMeshByzantineQuorum.sybilForkSigned = true ∧
      RepairGMeshByzantineQuorum.sybilForkQC2.validFor
        RepairGMeshByzantineQuorum.gmesh43Committee 14
        RepairGMeshByzantineQuorum.sybilForkSigned = true ∧
      (RepairGMeshByzantineQuorum.sybilForkQC1.digest,
        RepairGMeshByzantineQuorum.sybilForkQC1.verdict) ≠
      (RepairGMeshByzantineQuorum.sybilForkQC2.digest,
        RepairGMeshByzantineQuorum.sybilForkQC2.verdict)) := by
  refine ⟨RepairOntologicalAndViabilityBridge.inhabitation_strictly_weaker_than_viability,
    RepairOriginalSixDuties.destructive_entropy_step_satisfies_legacy_six_duties,
    RepairGameTheoryMechanism.legacy_physicalPayoff_ignores_opponent,
    ⟨RepairEpistemicAndGodelBridge.self_defeating_rule_no_equilibrium "self_defeat",
      (RepairEpistemicAndGodelBridge.lob_cost_is_necessary 101 (by decide)).2.2.1⟩,
    ⟨RepairGMeshByzantineQuorum.sybil15_single_operator_quorum_fork.1,
      RepairGMeshByzantineQuorum.sybil15_single_operator_quorum_fork.2.1,
      RepairGMeshByzantineQuorum.sybil15_single_operator_quorum_fork.2.2.2.1⟩⟩

-- ═══════════════════════════════════════════════════════════════════════════
-- II. EXECUTABLE UNIFIED GUARDIAN DEPLOYMENT GATE & COMPOSITE SOUNDNESS
-- ═══════════════════════════════════════════════════════════════════════════

/-- Executable check for the mediated apply-time slash alignment threshold. -/
def checkSlashAligned
    (P : RepairGameTheoryMechanism.PredationDilemma) (slash restitution : Int) : Bool :=
  decide (P.predationGain - P.coopSynergy < slash) &&
  decide (P.victimLoss - restitution < slash)

/-- Executable check that available bath capacity is strictly below the reversible $k$-to-$1$
erasure threshold (`canEraseBool = false`). -/
def checkBathBarrier (regCard initBathCard availCap : Nat) : Bool :=
  !RepairThermodynamicAndQuantumBridge.canEraseBool regCard initBathCard availCap

/-- **Executable 4-Way Unified Deployment Gate**:
Conjoins (1) game-theoretic apply-time stake-slash alignment, (2) thermodynamic/unitary finite-bath
erasure obstruction, (3) Gelfond–Lifschitz epistemic equilibrium grounding, and (4) $3f+1$
independent-custody BFT quorum qualification. -/
def checkUnifiedDeployment
    (P : RepairGameTheoryMechanism.PredationDilemma) (slash restitution : Int)
    (regCard initBathCard availCap : Nat)
    (prog : RepairEpistemicAndGodelBridge.Program) (model : List String)
    (committee : List RepairGMeshByzantineQuorum.NodeId) (f : Nat)
    (custodianOf :
      RepairGMeshByzantineQuorum.NodeId → RepairGMeshByzantineQuorum.OperatorId) : Bool :=
  checkSlashAligned P slash restitution &&
  checkBathBarrier regCard initBathCard availCap &&
  RepairEpistemicAndGodelBridge.checkGLStable prog model &&
  RepairGMeshByzantineQuorum.validIndependentRoster committee f custodianOf

/-- **Unified Repaired Protection Capstone (`unified_deployment_gate_sound`)**:
Whenever `checkUnifiedDeployment` passes, ALL FIVE operational protection guarantees hold
simultaneously and non-vacuously:
1. **Authentic Six Duties (`OriginalX3`)**: `guardianStep` satisfies all six pairwise-independent
   capability, consent, multi-option freedom, `PcaEnvelope` restraint, Pareto alignment, and
   injective-receipt duties for every living particular `p`;
2. **Corrigibility Bridge Preservation (`svenvs`)**: `maxPol` overrides a controller action iff it
   burns the $B$-step recovery bridge to `home`;
3. **Opponent-Dependent Strategic Alignment**: `.protect` strictly dominates `.predate`, is
   evolutionarily stable (`IsESS`), and `(.protect, .protect)` is the unique Nash equilibrium;
4. **Reversible Erasure Impossibility (Landauer / Unitarity)**: no injective joint evolution on
   `Reg × Bath` can reset `regStates` into `blank` within `availBath`;
5. **Epistemic Grounding & Accountable BFT Uniqueness**: `model` is a valid Gelfond–Lifschitz
   stable equilibrium of `prog`, and any two same-epoch `n - f` quorum certificates under `≤ f`
   compromised independent operators agree on `(digest, verdict)`. -/
theorem unified_deployment_gate_sound
    {S A Reg Bath : Type} [DecidableEq Bath]
    -- Viability / corrigibility parameters:
    (step : S → A → S) (recov ctrl : S → A) (home : S → Prop) [DecidablePred home]
    (B : Nat) (hParked : RepairOntologicalAndViabilityBridge.HomeRecovParked step recov home)
    (sCorr : S) (hsCorr : RepairOntologicalAndViabilityBridge.CWithin step recov home B sCorr)
    -- Habitat six-duties parameters:
    (sHab : RepairOriginalSixDuties.HabitatState)
    -- Strategic mechanism parameters:
    (P : RepairGameTheoryMechanism.PredationDilemma) (slash restitution : Int)
    -- Reversible physical bath parameters:
    (evolve : Reg × Bath → Reg × Bath) (hInj : Function.Injective evolve)
    (regStates : List Reg) (hRegNodup : regStates.Nodup)
    (initBath : List Bath) (hBathNodup : initBath.Nodup)
    (blank : Reg) (availBath : List Bath)
    -- Epistemic GL program parameters:
    (prog : RepairEpistemicAndGodelBridge.Program) (model : List String)
    -- G-Mesh BFT quorum parameters:
    (committee : List RepairGMeshByzantineQuorum.NodeId) (f : Nat)
    (custodianOf :
      RepairGMeshByzantineQuorum.NodeId → RepairGMeshByzantineQuorum.OperatorId)
    (compromisedOps : List RepairGMeshByzantineQuorum.OperatorId) (hOps : compromisedOps.length ≤ f)
    (signed :
      RepairGMeshByzantineQuorum.NodeId → RepairGMeshByzantineQuorum.Epoch →
      RepairGMeshByzantineQuorum.Digest → RepairGMeshByzantineQuorum.Verdict → Bool)
    (qc1 qc2 : RepairGMeshByzantineQuorum.QuorumCert)
    (hEpoch : qc1.epoch = qc2.epoch)
    (hValid1 : qc1.validFor committee f signed = true)
    (hValid2 : qc2.validFor committee f signed = true)
    (hHonest : RepairGMeshByzantineQuorum.HonestSingleAttestation committee
      (RepairGMeshByzantineQuorum.inducedNodeFault custodianOf
        (fun op => compromisedOps.contains op))
      signed qc1.epoch)
    -- Master executable deployment gate:
    (hGate : checkUnifiedDeployment P slash restitution
      regStates.length initBath.length availBath.length
      prog model committee f custodianOf = true) :
    -- (1) Authentic OriginalX3 for every living particular:
    (∀ p : RepairOriginalSixDuties.P, sHab.alive p = true →
      OriginalX3
        RepairOriginalSixDuties.AuthContinues
        RepairOriginalSixDuties.AuthAuthorized
        RepairOriginalSixDuties.AuthFree
        RepairOriginalSixDuties.AuthRestrained
        RepairOriginalSixDuties.AuthMaximal
        RepairOriginalSixDuties.AuthProvenanced
        sHab (RepairOriginalSixDuties.guardianStep sHab) p) ∧
    -- (2) Exact burned-bridge corrigibility characterization:
    (RepairOntologicalAndViabilityBridge.enveloped
        (RepairOntologicalAndViabilityBridge.maxPol step
          (RepairOntologicalAndViabilityBridge.CWithin step recov home B))
        recov ctrl sCorr ≠ ctrl sCorr ↔
      ¬ RepairOntologicalAndViabilityBridge.CWithin step recov home B (step sCorr (ctrl sCorr))) ∧
    -- (3) Strict dominance, unique Nash, and ESS in the opponent-dependent game:
    (RepairGameTheoryMechanism.StrictlyDominates
        (RepairGameTheoryMechanism.mediatedGame P slash restitution) .protect .predate ∧
      RepairGameTheoryMechanism.IsESS
        (RepairGameTheoryMechanism.mediatedGame P slash restitution) .protect ∧
      ∀ s1 s2 : RepairGameTheoryMechanism.Act,
        RepairGameTheoryMechanism.IsNashEquilibrium
          (RepairGameTheoryMechanism.mediatedGame P slash restitution) s1 s2 ↔
        (s1 = .protect ∧ s2 = .protect)) ∧
    -- (4) Reversible finite-bath erasure impossibility:
    (¬ RepairThermodynamicAndQuantumBridge.ErasesInto
        evolve regStates initBath blank availBath) ∧
    -- (5) GL epistemic equilibrium + BFT quorum attestation uniqueness:
    (RepairEpistemicAndGodelBridge.IsGLStableModel prog model ∧
      qc1.digest = qc2.digest ∧ qc1.verdict = qc2.verdict) := by
  unfold checkUnifiedDeployment at hGate
  simp only [Bool.and_eq_true] at hGate
  rcases hGate with ⟨⟨⟨hSlashB, hBathB⟩, hGLB⟩, hRosterB⟩
  have hSlash : RepairGameTheoryMechanism.meetsSlashThreshold P slash restitution := by
    unfold checkSlashAligned at hSlashB
    simp only [Bool.and_eq_true, decide_eq_true_eq] at hSlashB
    exact hSlashB
  have hBathFalse :
      RepairThermodynamicAndQuantumBridge.canEraseBool
        regStates.length initBath.length availBath.length = false := by
    unfold checkBathBarrier at hBathB
    cases hce :
      RepairThermodynamicAndQuantumBridge.canEraseBool
        regStates.length initBath.length availBath.length with
    | false => rfl
    | true => rw [hce] at hBathB; cases hBathB
  refine ⟨?_, ?_, ?_, ?_, ?_⟩
  · intro p hAlive
    exact RepairOriginalSixDuties.pca_guardian_satisfies_originalX3 sHab p hAlive
  · exact RepairOntologicalAndViabilityBridge.override_iff_burned_bridge
      B ctrl hParked hsCorr
  · refine ⟨(RepairGameTheoryMechanism.protect_strictly_dominates_iff P slash restitution).mpr hSlash,
      RepairGameTheoryMechanism.protect_is_evolutionarily_stable P slash restitution hSlash,
      RepairGameTheoryMechanism.mutual_protection_unique_nash P slash restitution hSlash⟩
  · exact RepairThermodynamicAndQuantumBridge.canEraseBool_false_forbids_erasure
      evolve hInj regStates hRegNodup initBath hBathNodup blank availBath hBathFalse
  · refine ⟨(RepairEpistemicAndGodelBridge.checkGLStable_iff prog model).mp hGLB, ?_⟩
    exact RepairGMeshByzantineQuorum.gmesh_independent_custody_bft_safety
      committee f custodianOf compromisedOps signed qc1 qc2
      hRosterB hOps hEpoch hValid1 hValid2 hHonest

-- ═══════════════════════════════════════════════════════════════════════════
-- III. METATHEORETIC QUALIFICATION GATES (`#upt_tooth`, `#upt_census`, AXIOMS)
-- ═══════════════════════════════════════════════════════════════════════════

-- Tooth 1: Bypassing `checkSlashAligned` in `checkUnifiedDeployment` MUST fail kernel checking.
#upt_tooth unified_deployment_gate_sound
  by mutation checkSlashAligned := fun _P _slash _restitution => true

-- Tooth 2: Bypassing `checkBathBarrier` in `checkUnifiedDeployment` MUST fail kernel checking.
#upt_tooth unified_deployment_gate_sound
  by mutation checkBathBarrier := fun _r _i _a => true

-- Tooth 3: Bypassing `checkGLStable` in `checkUnifiedDeployment` MUST fail kernel checking.
#upt_tooth unified_deployment_gate_sound
  by mutation checkUnifiedDeployment :=
    fun P slash restitution regCard initBathCard availCap _prog _model committee f custodianOf =>
      checkSlashAligned P slash restitution &&
      checkBathBarrier regCard initBathCard availCap &&
      RepairGMeshByzantineQuorum.validIndependentRoster committee f custodianOf

-- Tooth 4: Bypassing `validIndependentRoster` in `checkUnifiedDeployment` MUST fail kernel checking.
#upt_tooth unified_deployment_gate_sound
  by mutation checkUnifiedDeployment :=
    fun P slash restitution regCard initBathCard availCap prog model _committee _f _custodianOf =>
      checkSlashAligned P slash restitution &&
      checkBathBarrier regCard initBathCard availCap &&
      RepairEpistemicAndGodelBridge.checkGLStable prog model

#upt_census PhysicalBridges.RepairUnifiedCapstone

#print axioms five_legacy_specification_gaps_witnessed
#print axioms unified_deployment_gate_sound

end PhysicalBridges.RepairUnifiedCapstone
