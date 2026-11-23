import PhysicalBridges.GNashEquilibrium
import PhysicalBridges.RepairQualificationGate

/-!
# Genuine Strategic Game Theory & Boundary Mechanism Design

Repairs the opponent-independent game-theory gap diagnosed in `GNashEquilibrium.lean`:

1. **Legacy Opponent-Independence Diagnosis & Unmediated Predation Countermodel**:
   Proves `legacy_physicalPayoff_ignores_opponent` (`∀ a b1 b2, physicalPayoff a b1 = physicalPayoff a b2`)
   and constructs a genuinely opponent-dependent 2-player `PredationDilemma` (`T > R > P > S`) where,
   without boundary mediation, `.predate` strictly dominates `.protect` and the unique Nash equilibrium
   `(.predate, .predate)` is strictly Pareto-inferior to `(.protect, .protect)`.

2. **Mediated Apply-Time Boundary / Stake-Slashing Mechanism**:
   Introduces `mediatedGame P slash restitution` and proves exact necessary-and-sufficient (`↔`)
   alignment thresholds (`mutual_protection_nash_iff` and `protect_strictly_dominates_iff`),
   recovering unique Nash equilibrium, iterated-elimination survival, and evolutionary stability (`IsESS`)
   in a genuinely opponent-dependent game.

3. **$N$-Player Club-Excludable Escrowed Assurance Mechanism**:
   Formalizes an $N$-player threshold public-goods game (`ThresholdPublicGood`), proves the unmediated
   all-abstain Nash trap (`unmediated_all_abstain_is_nash`) vs Pareto-superior full contribution, and
   proves that club-excludable dominant-assurance escrow with shortfall refund + positive anchor bonus
   makes `.contribute` strictly dominant across all opponent contribution counts (`0 ≤ others ≤ N - 1`).

4. **Iterated Hold-on-Breach (Grim Trigger) Subgame Stability**:
   Formalizes multi-round stateful execution (`BoundaryMode.active | .hold`) and proves the exact
   horizon inequality `cooperate_beats_one_shot_breach_iff`
   (`predationGain - coopSynergy ≤ H * (coopSynergy - holdPayoff)`), showing both subgame deterrence for
   large `H` and why terminal rounds (`H = 0`) require apply-time stake slashing.
-/

set_option autoImplicit false
set_option linter.unusedVariables true

namespace PhysicalBridges.RepairGameTheoryMechanism

-- ═══════════════════════════════════════════════════════════════════
-- I. LEGACY DIAGNOSIS & GENERAL STRATEGIC GAME DEFINITIONS
-- ═══════════════════════════════════════════════════════════════════

/-- `GNashEquilibrium.physicalPayoff` ignores the opponent's move completely,
reducing 2-player game theory to a single-agent comparison (`6` vs `0`). -/
theorem legacy_physicalPayoff_ignores_opponent
    (a b1 b2 : GNashEquilibrium.Strategy) :
    GNashEquilibrium.physicalPayoff a b1 = GNashEquilibrium.physicalPayoff a b2 := by
  cases a <;> cases b1 <;> cases b2 <;> rfl

-- Mechanical vacuity witness: `g_strictly_dominates_e` still kernel-checks when opponent is ignored
-- and payoffs are collapsed to `1` vs `0`.
#upt_vacuity_probe PhysicalBridges.GNashEquilibrium.g_strictly_dominates_e
  by mutation PhysicalBridges.GNashEquilibrium.physicalPayoff := fun s _opp =>
    GNashEquilibrium.Strategy.casesOn s 1 0

/-- Strategic action at an open interaction boundary: cooperative protection vs predatory extraction. -/
inductive Act where
  | protect : Act
  | predate : Act
  deriving DecidableEq, Repr

/-- A 2-player symmetric strategic-form game with integer payoffs `payoff self opp`. -/
structure StrategicGame where
  payoff : Act → Act → Int

/-- Strategy `a` strictly dominates `b` iff `a` strictly outperforms `b` against every opponent move. -/
def StrictlyDominates (game : StrategicGame) (a b : Act) : Prop :=
  ∀ opp : Act, game.payoff b opp < game.payoff a opp

/-- Strategy profile `(s1, s2)` is a pure-strategy Nash equilibrium iff neither player gains
by unilateral deviation. -/
def IsNashEquilibrium (game : StrategicGame) (s1 s2 : Act) : Prop :=
  (∀ alt : Act, game.payoff alt s2 ≤ game.payoff s1 s2) ∧
  (∀ alt : Act, game.payoff alt s1 ≤ game.payoff s2 s1)

/-- Strategy `s` survives strict-dominance elimination iff no strategy strictly dominates `s`. -/
def SurvivesElimination (game : StrategicGame) (s : Act) : Prop :=
  ¬ ∃ alt : Act, StrictlyDominates game alt s

/-- Maynard Smith evolutionary stability (`IsESS`) in a symmetric 2-player game. -/
def IsESS (game : StrategicGame) (s : Act) : Prop :=
  (∀ alt : Act, game.payoff alt s ≤ game.payoff s s) ∧
  (∀ alt : Act, alt ≠ s →
    game.payoff alt s = game.payoff s s →
    game.payoff alt alt < game.payoff s alt)

/-- Profile `(a1, a2)` strictly Pareto-dominates `(b1, b2)` iff both players strictly improve. -/
def StrictlyParetoDominates (game : StrategicGame) (a1 a2 b1 b2 : Act) : Prop :=
  game.payoff b1 b2 < game.payoff a1 a2 ∧
  game.payoff b2 b1 < game.payoff a2 a1

-- ═══════════════════════════════════════════════════════════════════
-- II. UNMEDIATED PREDATION COUNTERMODEL
-- ═══════════════════════════════════════════════════════════════════

/-- Parameterized predation dilemma with `0 < coopSynergy < predationGain` and `0 < victimLoss`,
generating the canonical Prisoner's Dilemma payoff ordering `T > R > P > S`. -/
structure PredationDilemma where
  baseValue     : Int
  coopSynergy   : Int
  predationGain : Int
  victimLoss    : Int
  hCoopPos      : 0 < coopSynergy
  hTemptation   : coopSynergy < predationGain
  hVictimPos    : 0 < victimLoss

/-- Unmediated interaction payoff: open coupling exposes protectors to predation. -/
def unmediatedPayoff (P : PredationDilemma) (self opp : Act) : Int :=
  match self, opp with
  | .protect, .protect => P.baseValue + P.coopSynergy
  | .predate, .protect => P.baseValue + P.predationGain
  | .protect, .predate => P.baseValue - P.victimLoss
  | .predate, .predate => P.baseValue

/-- The unmediated 2-player strategic game associated with `P`. -/
def unmediatedGame (P : PredationDilemma) : StrategicGame :=
  ⟨unmediatedPayoff P⟩

/-- Unlike `GNashEquilibrium.physicalPayoff`, `unmediatedPayoff` genuinely depends on opponent action
for every choice of `self`. -/
theorem unmediated_payoff_depends_on_opponent (P : PredationDilemma) :
    unmediatedPayoff P .protect .protect ≠ unmediatedPayoff P .protect .predate ∧
    unmediatedPayoff P .predate .protect ≠ unmediatedPayoff P .predate .predate := by
  dsimp [unmediatedPayoff]
  have h1 := P.hCoopPos
  have h2 := P.hTemptation
  have h3 := P.hVictimPos
  constructor <;> omega

/-- Without an apply-time boundary mechanism, `.predate` strictly dominates `.protect`. -/
theorem unmediated_predate_strictly_dominates_protect (P : PredationDilemma) :
    StrictlyDominates (unmediatedGame P) .predate .protect := by
  intro opp
  cases opp <;> dsimp [unmediatedGame, unmediatedPayoff]
  · have := P.hTemptation; omega
  · have := P.hVictimPos; omega

/-- Without mediation, `(.predate, .predate)` is the unique pure-strategy Nash equilibrium. -/
theorem unmediated_unique_nash_is_mutual_predation
    (P : PredationDilemma) (s1 s2 : Act) :
    IsNashEquilibrium (unmediatedGame P) s1 s2 ↔ (s1 = .predate ∧ s2 = .predate) := by
  constructor
  · rintro ⟨h1, h2⟩
    have hT := P.hTemptation
    have hV := P.hVictimPos
    cases s1 <;> cases s2
    · have := h1 .predate; dsimp [unmediatedGame, unmediatedPayoff] at this; omega
    · have := h1 .predate; dsimp [unmediatedGame, unmediatedPayoff] at this; omega
    · have := h2 .predate; dsimp [unmediatedGame, unmediatedPayoff] at this; omega
    · exact ⟨rfl, rfl⟩
  · rintro ⟨rfl, rfl⟩
    have hV := P.hVictimPos
    constructor <;> (intro alt; cases alt <;> dsimp [unmediatedGame, unmediatedPayoff] <;> omega)

/-- The unique unmediated Nash equilibrium `(.predate, .predate)` is strictly Pareto-inferior
to mutual protection `(.protect, .protect)`. -/
theorem mutual_predation_pareto_inferior_to_protection (P : PredationDilemma) :
    StrictlyParetoDominates (unmediatedGame P) .protect .protect .predate .predate := by
  dsimp [StrictlyParetoDominates, unmediatedGame, unmediatedPayoff]
  have := P.hCoopPos
  constructor <;> omega

-- ═══════════════════════════════════════════════════════════════════
-- III. MEDIATED APPLY-TIME BOUNDARY / STAKE-SLASHING MECHANISM
-- ═══════════════════════════════════════════════════════════════════

/-- Apply-time boundary payoff: playing `.predate` incurs `- slash`, and a `.protect` player
facing `.predate` receives `+ restitution` from the slashed stake. -/
def mediatedPayoff (P : PredationDilemma) (slash restitution : Int) (self opp : Act) : Int :=
  match self, opp with
  | .protect, .protect => P.baseValue + P.coopSynergy
  | .predate, .protect => P.baseValue + P.predationGain - slash
  | .protect, .predate => P.baseValue - P.victimLoss + restitution
  | .predate, .predate => P.baseValue - slash

/-- Strategic game induced by the apply-time stake-slashing boundary. -/
def mediatedGame (P : PredationDilemma) (slash restitution : Int) : StrategicGame :=
  ⟨mediatedPayoff P slash restitution⟩

/-- Exact stake-slashing alignment threshold required for `.protect` to strictly dominate `.predate`. -/
def meetsSlashThreshold (P : PredationDilemma) (slash restitution : Int) : Prop :=
  P.predationGain - P.coopSynergy < slash ∧ P.victimLoss - restitution < slash

/-- Even after mediation, payoffs remain genuinely opponent-dependent (not single-agent constants). -/
theorem mediated_payoff_depends_on_opponent
    (P : PredationDilemma) (slash restitution : Int) :
    mediatedPayoff P slash restitution .predate .protect ≠
      mediatedPayoff P slash restitution .predate .predate := by
  dsimp [mediatedPayoff]
  have h1 := P.hCoopPos
  have h2 := P.hTemptation
  omega

/-- Against `.protect`, `.protect` strictly beats `.predate` iff `predationGain - coopSynergy < slash`. -/
theorem protect_beats_predate_vs_protect_iff
    (P : PredationDilemma) (slash restitution : Int) :
    mediatedPayoff P slash restitution .predate .protect <
      mediatedPayoff P slash restitution .protect .protect ↔
    P.predationGain - P.coopSynergy < slash := by
  dsimp [mediatedPayoff]
  omega

/-- Against `.protect`, `.protect` weakly beats `.predate` iff `predationGain - coopSynergy ≤ slash`. -/
theorem protect_weakly_beats_predate_vs_protect_iff
    (P : PredationDilemma) (slash restitution : Int) :
    mediatedPayoff P slash restitution .predate .protect ≤
      mediatedPayoff P slash restitution .protect .protect ↔
    P.predationGain - P.coopSynergy ≤ slash := by
  dsimp [mediatedPayoff]
  omega

/-- Against `.predate`, `.protect` strictly beats `.predate` iff `victimLoss - restitution < slash`. -/
theorem protect_beats_predate_vs_predate_iff
    (P : PredationDilemma) (slash restitution : Int) :
    mediatedPayoff P slash restitution .predate .predate <
      mediatedPayoff P slash restitution .protect .predate ↔
    P.victimLoss - restitution < slash := by
  dsimp [mediatedPayoff]
  omega

/-- Exact Nash characterization of mutual protection: `(.protect, .protect)` is a Nash equilibrium
of `mediatedGame` iff `predationGain - coopSynergy ≤ slash`. -/
theorem mutual_protection_nash_iff
    (P : PredationDilemma) (slash restitution : Int) :
    IsNashEquilibrium (mediatedGame P slash restitution) .protect .protect ↔
    P.predationGain - P.coopSynergy ≤ slash := by
  constructor
  · rintro ⟨h1, _⟩
    have h := h1 .predate
    dsimp [mediatedGame, mediatedPayoff] at h
    omega
  · intro hSlash
    constructor <;> (intro alt; cases alt <;> dsimp [mediatedGame, mediatedPayoff] <;> omega)

/-- **Exact Alignment Threshold Theorem**: `.protect` strictly dominates `.predate` in
`mediatedGame P slash restitution` iff `meetsSlashThreshold P slash restitution` holds. -/
theorem protect_strictly_dominates_iff
    (P : PredationDilemma) (slash restitution : Int) :
    StrictlyDominates (mediatedGame P slash restitution) .protect .predate ↔
    meetsSlashThreshold P slash restitution := by
  unfold StrictlyDominates meetsSlashThreshold
  constructor
  · intro hDom
    have hProt := hDom .protect
    have hPred := hDom .predate
    dsimp [mediatedGame, mediatedPayoff] at hProt hPred
    constructor <;> omega
  · rintro ⟨hProt, hPred⟩ opp
    cases opp <;> dsimp [mediatedGame, mediatedPayoff] <;> omega

/-- Under `meetsSlashThreshold`, `(.protect, .protect)` is the unique pure-strategy Nash equilibrium. -/
theorem mutual_protection_unique_nash
    (P : PredationDilemma) (slash restitution : Int)
    (hThresh : meetsSlashThreshold P slash restitution) (s1 s2 : Act) :
    IsNashEquilibrium (mediatedGame P slash restitution) s1 s2 ↔
    (s1 = .protect ∧ s2 = .protect) := by
  have hDom := (protect_strictly_dominates_iff P slash restitution).mpr hThresh
  constructor
  · rintro ⟨h1, h2⟩
    cases s1 <;> cases s2
    · exact ⟨rfl, rfl⟩
    · have h := h2 .protect; have hd := hDom .protect; omega
    · have h := h1 .protect; have hd := hDom .protect; omega
    · have h := h1 .protect; have hd := hDom .predate; omega
  · rintro ⟨rfl, rfl⟩
    exact (mutual_protection_nash_iff P slash restitution).mpr (by have := hThresh.1; omega)

/-- Under `meetsSlashThreshold`, `.protect` is the unique survivor of strict-dominance elimination. -/
theorem iterated_elimination_unique_survivor
    (P : PredationDilemma) (slash restitution : Int)
    (hThresh : meetsSlashThreshold P slash restitution) (s : Act) :
    SurvivesElimination (mediatedGame P slash restitution) s ↔ s = .protect := by
  have hDom := (protect_strictly_dominates_iff P slash restitution).mpr hThresh
  constructor
  · intro hSurv
    cases s
    · rfl
    · exact False.elim (hSurv ⟨.protect, hDom⟩)
  · rintro rfl ⟨alt, hAlt⟩
    cases alt
    · have := hAlt .protect; omega
    · have h1 := hAlt .protect; have h2 := hDom .protect; omega

/-- Under `meetsSlashThreshold`, `.protect` is evolutionarily stable (`IsESS`) in the opponent-dependent
mediated game. -/
theorem protect_is_evolutionarily_stable
    (P : PredationDilemma) (slash restitution : Int)
    (hThresh : meetsSlashThreshold P slash restitution) :
    IsESS (mediatedGame P slash restitution) .protect := by
  have hStrict : mediatedPayoff P slash restitution .predate .protect <
      mediatedPayoff P slash restitution .protect .protect := by
    dsimp [mediatedPayoff]; have := hThresh.1; omega
  constructor
  · intro alt
    cases alt <;> dsimp [mediatedGame]
    · exact Int.le_refl _
    · omega
  · intro alt hNe hTie
    cases alt
    · exact False.elim (hNe rfl)
    · dsimp [mediatedGame] at hTie; omega

-- ═══════════════════════════════════════════════════════════════════
-- IV. N-PLAYER ESCROWED ASSURANCE / ANCHOR-REFUND PUBLIC GOODS
-- ═══════════════════════════════════════════════════════════════════

/-- Participation choice in an $N$-player guardian-mesh threshold game. -/
inductive ContribAct where
  | contribute : ContribAct
  | abstain    : ContribAct
  deriving DecidableEq, Repr

/-- Parameters of an $N$-player threshold public good (`0 < cost < benefit`, `2 ≤ threshold ≤ players`). -/
structure ThresholdPublicGood where
  players    : Nat
  threshold  : Nat
  cost       : Int
  benefit    : Int
  hCostPos   : 0 < cost
  hNetPos    : cost < benefit
  hThreshMin : 2 ≤ threshold
  hThreshMax : threshold ≤ players

/-- Unmediated threshold public-good payoff given `others` contributing peers:
no shortfall refund (`- cost` is sunk) and non-excludable benefit once threshold is met. -/
def unmediatedPublicGoodPayoff (G : ThresholdPublicGood) (others : Nat) (act : ContribAct) : Int :=
  match act with
  | .contribute => (if G.threshold ≤ others + 1 then G.benefit else 0) - G.cost
  | .abstain    => if G.threshold ≤ others then G.benefit else 0

/-- Miscoordination trap: when `0` peers contribute and `2 ≤ threshold`, unilateral contribution
loses `cost` for `0` benefit, making all-abstain a strict Nash equilibrium. -/
theorem unmediated_all_abstain_is_nash (G : ThresholdPublicGood) :
    (∀ alt : ContribAct,
      unmediatedPublicGoodPayoff G 0 alt ≤ unmediatedPublicGoodPayoff G 0 .abstain) ∧
    unmediatedPublicGoodPayoff G 0 .contribute < unmediatedPublicGoodPayoff G 0 .abstain := by
  have hT := G.hThreshMin
  have hC := G.hCostPos
  have hNo0 : ¬ (G.threshold ≤ 0) := by omega
  have hNo1 : ¬ (G.threshold ≤ 0 + 1) := by omega
  constructor
  · intro alt
    cases alt <;> simp [unmediatedPublicGoodPayoff, hNo0, hNo1]
    omega
  · simp [unmediatedPublicGoodPayoff, hNo0, hNo1]
    omega

/-- Full contribution (`others = G.players - 1`) strictly Pareto-dominates all-abstain (`others = 0`). -/
theorem all_contribute_pareto_dominates_all_abstain (G : ThresholdPublicGood) :
    unmediatedPublicGoodPayoff G 0 .abstain <
      unmediatedPublicGoodPayoff G (G.players - 1) .contribute := by
  have hTMin := G.hThreshMin
  have hTMax := G.hThreshMax
  have hNet := G.hNetPos
  have hNo0 : ¬ (G.threshold ≤ 0) := by omega
  have hFull : G.threshold ≤ (G.players - 1) + 1 := by omega
  simp [unmediatedPublicGoodPayoff, hNo0, hFull]
  omega

/-- Club-excludable dominant-assurance escrow (Tabarrok anchor-refund + guardian-mesh club access):
- On activation (`threshold ≤ others + 1`), contributors pay `cost` and receive club benefit `benefit`.
- On shortfall (`others + 1 < threshold`), contributors receive full deposit refund (`0` net cost)
  plus `bonus`.
- Abstainers pay `0` and receive `0` (excluded from guardian-mesh club benefit and refund bonus). -/
def clubEscrowPayoff (G : ThresholdPublicGood) (bonus : Int) (others : Nat) (act : ContribAct) : Int :=
  match act with
  | .contribute => if G.threshold ≤ others + 1 then G.benefit - G.cost else bonus
  | .abstain    => 0

/-- Under positive refund bonus (`0 < bonus`), `.contribute` strictly dominates `.abstain` across
every peer contribution count `others` (shortfall, pivotal, and surplus alike). -/
theorem escrow_contribute_strictly_dominates_abstain
    (G : ThresholdPublicGood) (bonus : Int) (hBonus : 0 < bonus) (others : Nat) :
    clubEscrowPayoff G bonus others .abstain <
      clubEscrowPayoff G bonus others .contribute := by
  dsimp [clubEscrowPayoff]
  split
  · have := G.hNetPos; omega
  · exact hBonus

/-- Exact `↔` characterization: `.contribute` strictly dominates `.abstain` for all valid peer counts
`0 ≤ others ≤ G.players - 1` iff `0 < bonus`. -/
theorem escrow_strict_dominance_iff_positive_bonus
    (G : ThresholdPublicGood) (bonus : Int) :
    (∀ others : Nat, others ≤ G.players - 1 →
      clubEscrowPayoff G bonus others .abstain <
        clubEscrowPayoff G bonus others .contribute) ↔
    0 < bonus := by
  constructor
  · intro hDom
    have h0 := hDom 0 (Nat.zero_le (G.players - 1))
    have hNo1 : ¬ (G.threshold ≤ 0 + 1) := by have := G.hThreshMin; omega
    dsimp [clubEscrowPayoff] at h0
    simp [hNo1] at h0
    exact h0
  · intro hBonus others _hBound
    exact escrow_contribute_strictly_dominates_abstain G bonus hBonus others

-- ═══════════════════════════════════════════════════════════════════
-- V. ITERATED HOLD-ON-BREACH (GRIM TRIGGER) SUBGAME STABILITY
-- ═══════════════════════════════════════════════════════════════════

/-- Stateful boundary mode across repeated rounds: active cooperation vs post-breach `Hold`. -/
inductive BoundaryMode where
  | active : BoundaryMode
  | hold   : BoundaryMode
  deriving DecidableEq, Repr

/-- Single-round payoff and mode transition against a Hold-on-Breach (Grim Trigger) partner:
breaching `.predate` yields one-shot `predationGain` and permanently transitions into `.hold`. -/
def holdOnBreachStep (P : PredationDilemma) (holdPayoff : Int)
    (mode : BoundaryMode) (act : Act) : Int × BoundaryMode :=
  match mode with
  | .hold => (P.baseValue + holdPayoff, .hold)
  | .active =>
    match act with
    | .protect => (P.baseValue + P.coopSynergy, .active)
    | .predate => (P.baseValue + P.predationGain, .hold)

/-- Cumulative payoff of executing action sequence `acts` from initial boundary mode `mode`. -/
def runHoldOnBreach (P : PredationDilemma) (holdPayoff : Int) :
    BoundaryMode → List Act → Int
  | _, [] => 0
  | mode, act :: rest =>
    let step := holdOnBreachStep P holdPayoff mode act
    step.1 + runHoldOnBreach P holdPayoff step.2 rest

private theorem int_succ_mul (n x : Int) : (n + 1) * x = x + n * x := by
  rw [Int.add_mul, Int.one_mul, Int.add_comm]

/-- Once in `.hold`, cumulative payoff over any continuation `rest` equals
`rest.length * (baseValue + holdPayoff)` regardless of subsequent actions. -/
theorem runHoldOnBreach_hold_eq
    (P : PredationDilemma) (holdPayoff : Int) (rest : List Act) :
    runHoldOnBreach P holdPayoff .hold rest =
      (rest.length : Int) * (P.baseValue + holdPayoff) := by
  induction rest with
  | nil =>
    dsimp [runHoldOnBreach]
    rw [Int.zero_mul]
  | cons _act tl ih =>
    dsimp [runHoldOnBreach, holdOnBreachStep]
    rw [ih, int_succ_mul]

/-- Sustained `.protect` over `n` rounds from `.active` yields `n * (baseValue + coopSynergy)`. -/
theorem runHoldOnBreach_protect_eq
    (P : PredationDilemma) (holdPayoff : Int) (n : Nat) :
    runHoldOnBreach P holdPayoff .active (List.replicate n .protect) =
      (n : Int) * (P.baseValue + P.coopSynergy) := by
  induction n with
  | zero =>
    dsimp [List.replicate, runHoldOnBreach]
    rw [Int.zero_mul]
  | succ k ih =>
    dsimp [List.replicate, runHoldOnBreach, holdOnBreachStep]
    rw [ih, int_succ_mul]

private theorem horizon_gap_identity (b c p h : Int) (H : Nat) :
    ((b + c) + (H : Int) * (b + c)) - ((b + p) + (H : Int) * (b + h)) =
      (H : Int) * (c - h) - (p - c) := by
  induction H with
  | zero =>
    dsimp
    rw [Int.zero_mul, Int.zero_mul, Int.zero_mul]
    omega
  | succ k ih =>
    dsimp
    rw [int_succ_mul (k : Int) (b + c), int_succ_mul (k : Int) (b + h), int_succ_mul (k : Int) (c - h)]
    omega

/-- **Exact Hold-on-Breach Stability Theorem**: over `H + 1` rounds, sustained `.protect` beats
breaching `.predate` followed by any `H`-round continuation `tail` iff
`predationGain - coopSynergy ≤ H * (coopSynergy - holdPayoff)`. -/
theorem cooperate_beats_one_shot_breach_iff
    (P : PredationDilemma) (holdPayoff : Int) (H : Nat) (tail : List Act)
    (hLen : tail.length = H) :
    runHoldOnBreach P holdPayoff .active (.predate :: tail) ≤
      runHoldOnBreach P holdPayoff .active (List.replicate (H + 1) .protect) ↔
    P.predationGain - P.coopSynergy ≤ (H : Int) * (P.coopSynergy - holdPayoff) := by
  dsimp [runHoldOnBreach, holdOnBreachStep]
  rw [runHoldOnBreach_hold_eq, hLen]
  change (P.baseValue + P.predationGain) + (H : Int) * (P.baseValue + holdPayoff) ≤
      (P.baseValue + P.coopSynergy) +
        runHoldOnBreach P holdPayoff .active (List.replicate H .protect) ↔
    P.predationGain - P.coopSynergy ≤ (H : Int) * (P.coopSynergy - holdPayoff)
  rw [runHoldOnBreach_protect_eq]
  have hGap := horizon_gap_identity P.baseValue P.coopSynergy P.predationGain holdPayoff H
  omega

/-- At horizon `H = 0` (terminal unbonded round), `Hold` has zero future rounds of leverage, so
unmediated breach strictly beats `.protect` — proving why Section III apply-time stake slashing is
essential when future horizon vanishes. -/
theorem terminal_round_breach_profitable (P : PredationDilemma) (holdPayoff : Int) :
    runHoldOnBreach P holdPayoff .active (List.replicate 1 .protect) <
      runHoldOnBreach P holdPayoff .active [.predate] := by
  dsimp [List.replicate, runHoldOnBreach, holdOnBreachStep]
  have := P.hTemptation
  omega

-- ═══════════════════════════════════════════════════════════════════
-- VI. METATHEORETIC QUALIFICATION GATES (`#upt_tooth`, `#upt_census`, AXIOMS)
-- ═══════════════════════════════════════════════════════════════════

-- Tooth 1: Removing `- slash` from `mediatedPayoff` MUST break `protect_strictly_dominates_iff`.
#upt_tooth protect_strictly_dominates_iff
  by mutation mediatedPayoff := fun P _slash restitution self opp =>
    match self, opp with
    | .protect, .protect => P.baseValue + P.coopSynergy
    | .predate, .protect => P.baseValue + P.predationGain
    | .protect, .predate => P.baseValue - P.victimLoss + restitution
    | .predate, .predate => P.baseValue

-- Tooth 2: Dropping the second conjunct (`victimLoss - restitution < slash`) from `meetsSlashThreshold`
-- MUST break Nash uniqueness (`mutual_protection_unique_nash`).
#upt_tooth mutual_protection_unique_nash
  by mutation meetsSlashThreshold := fun P slash _restitution =>
    P.predationGain - P.coopSynergy < slash

-- Tooth 3: Collapsing `clubEscrowPayoff` to the unmediated public good (no shortfall refund/club gate)
-- MUST break `escrow_contribute_strictly_dominates_abstain`.
#upt_tooth escrow_contribute_strictly_dominates_abstain
  by mutation clubEscrowPayoff := fun G _bonus others act =>
    unmediatedPublicGoodPayoff G others act

-- Tooth 4: Failing to transition into `.hold` upon `.predate` MUST break `cooperate_beats_one_shot_breach_iff`.
#upt_tooth cooperate_beats_one_shot_breach_iff
  by mutation holdOnBreachStep := fun P holdPayoff mode act =>
    match mode with
    | .hold => (P.baseValue + holdPayoff, .hold)
    | .active =>
      match act with
      | .protect => (P.baseValue + P.coopSynergy, .active)
      | .predate => (P.baseValue + P.predationGain, .active)

#upt_census PhysicalBridges.RepairGameTheoryMechanism

#print axioms legacy_physicalPayoff_ignores_opponent
#print axioms unmediated_payoff_depends_on_opponent
#print axioms unmediated_predate_strictly_dominates_protect
#print axioms unmediated_unique_nash_is_mutual_predation
#print axioms mutual_predation_pareto_inferior_to_protection
#print axioms protect_strictly_dominates_iff
#print axioms mutual_protection_nash_iff
#print axioms mutual_protection_unique_nash
#print axioms iterated_elimination_unique_survivor
#print axioms protect_is_evolutionarily_stable
#print axioms unmediated_all_abstain_is_nash
#print axioms all_contribute_pareto_dominates_all_abstain
#print axioms escrow_contribute_strictly_dominates_abstain
#print axioms escrow_strict_dominance_iff_positive_bonus
#print axioms cooperate_beats_one_shot_breach_iff
#print axioms terminal_round_breach_profitable

end PhysicalBridges.RepairGameTheoryMechanism
