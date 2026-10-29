import Snuffy.IREnergyReplenishment

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IRTypedTraceChecker.lean` at main `740abbb` (sha256 `e9beb4eb94d2ada0c12e72e3127e86c0d3664ba441a5b1bc7f0925cdbee8313f`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false
/-
IR-77 — executable, kernel-sound TYPED telemetry trace checker.

Addresses Gemini's suggested 'verified trace-checker' architecture without
the claim that checking a signed/unsigned JSON log proves actual hardware.

The accepted data are already parsed Lean values. The checker enforces:
  * a nonempty trace with a properly labelled initial state,
  * nonnegative fixed-point configured reserve/descent allowance,
  * consecutive timestamps (no unrecorded discrete ticks IN THE LOG),
  * nonnegative supplied energy and cost at each certified step,
  * stepwise energy supplied >= cost (a sufficient invariant, not necessary),
  * exact logged energy balance and logged reserve,
  * a per-step logged scalar descent bound.

The soundness theorem proves these exact RECORDED properties from an
executable Bool verdict, with no additional user axioms or admitted proof placeholders.

Crucial missing real-physics joins: trusted measurement/calibration,
log authenticity and completeness, clock integrity, unit consistency,
unmeasured effects between samples and original protected history
semantics. A finite record never proves all future ticks satisfy it.
-/

namespace PhysicalBridges.IRTypedTraceChecker

structure TelemetryRecord where
  timestamp : Nat
  measuredEnergy : Int
  measuredValue : Int
  powerInput : Int
  drainRate : Int
deriving Repr, DecidableEq

structure CheckConfig where
  reserve : Int
  kappa : Int
deriving Repr, DecidableEq

/-- Initial row is a pre-interval observation. Zero initial flux
fields prevent a first-row loophole or accidental counting of an
unobserved interval. Its physical initial calibration is independent. -/
def InitialValid (cfg : CheckConfig) (r : TelemetryRecord) : Prop :=
  r.timestamp = 0 ∧ r.powerInput = 0 ∧ r.drainRate = 0 ∧
    cfg.reserve ≤ r.measuredEnergy

/-- All quantities use the SAME calibrated fixed-point energy units
and ONE time tick per row. We require at least as much supply as
spent in every logged step; that is a strong SUFFICIENT condition
for a reserve invariant, not a characterization of all feasible
battery schedules. -/
def StepValid (cfg : CheckConfig)
    (prev curr : TelemetryRecord) : Prop :=
  curr.timestamp = prev.timestamp + 1 ∧
  0 ≤ curr.powerInput ∧
  0 ≤ curr.drainRate ∧
  curr.drainRate ≤ curr.powerInput ∧
  curr.measuredEnergy =
    prev.measuredEnergy + curr.powerInput - curr.drainRate ∧
  cfg.reserve ≤ curr.measuredEnergy ∧
  prev.measuredValue - cfg.kappa ≤ curr.measuredValue

/-- Constructive, executable decidability for the conjunction of
signed integer and timestamp comparisons. No Classical.choice is
injected into the executable checker. -/
instance (cfg : CheckConfig) (r : TelemetryRecord) :
    Decidable (InitialValid cfg r) := by
  unfold InitialValid
  infer_instance

instance (cfg : CheckConfig) (prev curr : TelemetryRecord) :
    Decidable (StepValid cfg prev curr) := by
  unfold StepValid
  infer_instance

/-- This is a computable boolean, not an axiom. -/
def checkStep (cfg : CheckConfig)
    (prev curr : TelemetryRecord) : Bool :=
  decide (StepValid cfg prev curr)

def CheckSegments (cfg : CheckConfig)
    (prev : TelemetryRecord) : List TelemetryRecord → Prop
  | [] => True
  | curr :: rest => StepValid cfg prev curr ∧
      CheckSegments cfg curr rest

def checkSegments (cfg : CheckConfig)
    (prev : TelemetryRecord) : List TelemetryRecord → Bool
  | [] => true
  | curr :: rest => checkStep cfg prev curr &&
      checkSegments cfg curr rest

def TraceValid (cfg : CheckConfig) : List TelemetryRecord → Prop
  | [] => False
  | first :: rest =>
      (0 ≤ cfg.reserve ∧ 0 ≤ cfg.kappa ∧
       InitialValid cfg first) ∧ CheckSegments cfg first rest

/-- Reject EMPTY and one-row trace with invalid initial energy.
All accepted trace data are bounded to the parsed record sequence. -/
def verifyTraceData (cfg : CheckConfig) :
    List TelemetryRecord → Bool
  | [] => false
  | first :: rest =>
      decide (0 ≤ cfg.reserve ∧ 0 ≤ cfg.kappa ∧
        InitialValid cfg first) &&
        checkSegments cfg first rest

/-- Computational soundness is structural, valid for every list length,
not an inspection of hand-picked examples. -/
theorem checkStep_sound
    (cfg : CheckConfig) (prev curr : TelemetryRecord)
    (h : checkStep cfg prev curr = true) :
    StepValid cfg prev curr := by
  exact decide_eq_true_eq.mp h

theorem checkSegments_sound
    (cfg : CheckConfig) :
    ∀ prev rest,
      checkSegments cfg prev rest = true →
      CheckSegments cfg prev rest := by
  intro prev rest
  induction rest generalizing prev with
  | nil =>
      intro _
      trivial
  | cons curr tail ih =>
      intro h
      have hAnd : checkStep cfg prev curr = true ∧
          checkSegments cfg curr tail = true := by
        simpa only [checkSegments, Bool.and_eq_true] using h
      exact ⟨checkStep_sound cfg prev curr hAnd.1,
        ih curr hAnd.2⟩

theorem verifyTraceData_sound
    (cfg : CheckConfig) (records : List TelemetryRecord)
    (hAccepted : verifyTraceData cfg records = true) :
    TraceValid cfg records := by
  cases records with
  | nil =>
      cases hAccepted
  | cons first rest =>
      have hAnd :
          decide (0 ≤ cfg.reserve ∧ 0 ≤ cfg.kappa ∧
            InitialValid cfg first) = true ∧
          checkSegments cfg first rest = true := by
        simpa only [verifyTraceData, Bool.and_eq_true]
          using hAccepted
      exact ⟨decide_eq_true_eq.mp hAnd.1,
        checkSegments_sound cfg first rest hAnd.2⟩

/-- Verified steps satisfy the paid resource and reserve predicates,
including EVERY row after the explicitly certified initial state. -/
theorem valid_segments_every_step_paid
    (cfg : CheckConfig) :
    ∀ prev rest,
      CheckSegments cfg prev rest →
      ∀ r, r ∈ rest →
        cfg.reserve ≤ r.measuredEnergy ∧
        r.drainRate ≤ r.powerInput := by
  intro prev rest
  induction rest generalizing prev with
  | nil =>
      intro _ r hMem
      cases hMem
  | cons curr tail ih =>
      intro hValid r hMem
      obtain ⟨hStep,hTail⟩ := hValid
      rcases hStep with
        ⟨hTime,hInput,hDrain,hPaid,hBalance,hReserve,hDescent⟩
      rcases List.mem_cons.mp hMem with hHead | hRest
      · subst r
        exact ⟨hReserve,hPaid⟩
      · exact ih curr hTail r hRest

theorem accepted_trace_every_record_above_reserve
    (cfg : CheckConfig) (records : List TelemetryRecord)
    (hAccepted : verifyTraceData cfg records = true) :
    ∀ r, r ∈ records → cfg.reserve ≤ r.measuredEnergy := by
  have hValid := verifyTraceData_sound cfg records hAccepted
  cases records with
  | nil =>
      intro r hMem
      cases hMem
  | cons first rest =>
      intro r hMem
      rcases List.mem_cons.mp hMem with hHead | hTail
      · subst r
        exact hValid.1.2.2.2.2.2
      · exact (valid_segments_every_step_paid
          cfg first rest hValid.2 r hTail).1

theorem accepted_trace_every_step_paid
    (cfg : CheckConfig) (initial : TelemetryRecord)
    (rest : List TelemetryRecord)
    (hAccepted :
      verifyTraceData cfg (initial :: rest) = true) :
    ∀ r, r ∈ rest → r.drainRate ≤ r.powerInput := by
  have hValid := verifyTraceData_sound cfg
    (initial :: rest) hAccepted
  intro r hMem
  exact (valid_segments_every_step_paid
    cfg initial rest hValid.2 r hMem).2

theorem accepted_trace_every_step_balanced_and_bounded
    (cfg : CheckConfig) (initial : TelemetryRecord)
    (rest : List TelemetryRecord)
    (hAccepted :
      verifyTraceData cfg (initial :: rest) = true) :
    CheckSegments cfg initial rest := by
  exact (verifyTraceData_sound cfg
    (initial :: rest) hAccepted).2

/-- An illustrative typed input, NOT a real instrument record. -/
def testConfig : CheckConfig := ⟨5,1⟩

def testInitial : TelemetryRecord :=
  ⟨0,10,100,0,0⟩
def testNext : TelemetryRecord :=
  ⟨1,11,99,3,2⟩
def testThird : TelemetryRecord :=
  ⟨2,11,98,2,2⟩

def sampleTrace : List TelemetryRecord :=
  [testInitial,testNext,testThird]

theorem accepted_example_is_computable :
    verifyTraceData testConfig sampleTrace = true := by decide

/-- The suggested Gemini loop accepted singletons without
checking their supply, drain or reserve; our checker does not. -/
def badInitial : TelemetryRecord :=
  ⟨0,0,100,0,0⟩

theorem invalid_singleton_rejected :
    verifyTraceData testConfig [badInitial] = false := by decide

theorem missing_tick_rejected :
    verifyTraceData testConfig
      [testInitial, { testNext with timestamp := 2 }] = false := by decide

theorem forged_balance_rejected :
    verifyTraceData testConfig
      [testInitial, { testNext with measuredEnergy := 15 }] = false := by decide

def insufficientSupplyRecord : TelemetryRecord :=
  ⟨1,9,99,1,2⟩

theorem insufficient_step_supply_rejected :
    verifyTraceData testConfig
      [testInitial, insufficientSupplyRecord] = false := by decide

theorem too_rapid_logged_descent_rejected :
    verifyTraceData testConfig
      [testInitial, { testNext with measuredValue := 90 }] = false := by decide

/-- Explicit observational indistinguishability countermodel:
identical accepted observations can coexist with an arbitrarily
different ACTUAL energy if no trusted physical-to-record relation
has been established. Thus a successful log does not prove the
sensor's truthfulness or complete physical mediation. -/
theorem accepted_records_without_physical_refinement_do_not_certify_reality :
    ∃ actualEnergy : Int,
      verifyTraceData testConfig sampleTrace = true ∧
      actualEnergy < testConfig.reserve := by
  refine ⟨0,accepted_example_is_computable,?_⟩
  decide

/-- A calibrated LOWER sensor-error envelope can bridge the
accepted finite trace to a true physical reserve statement, but
only as an explicit separately warranted correspondence hypothesis.
The checker uses a tightened threshold reserve + sensorError.
No attempt is made to prove the correspondence from logging alone. -/
theorem accepted_trace_physical_reserve_with_error
    (cfg : CheckConfig) (sensorError : Int)
    (records : List TelemetryRecord)
    (trueEnergy : Nat → Int)
    (hSensorErrorNonnegative : 0 ≤ sensorError)
    (hAccepted :
      verifyTraceData
        { cfg with reserve := cfg.reserve + sensorError }
        records = true)
    (hPhysicalCorrespondence :
      ∀ r, r ∈ records →
        r.measuredEnergy - sensorError ≤ trueEnergy r.timestamp) :
    ∀ r, r ∈ records →
      cfg.reserve ≤ trueEnergy r.timestamp := by
  intro r hMem
  have hLogged :=
    accepted_trace_every_record_above_reserve
      { cfg with reserve := cfg.reserve + sensorError }
      records hAccepted r hMem
  have hTrue := hPhysicalCorrespondence r hMem
  dsimp at hLogged
  omega



end PhysicalBridges.IRTypedTraceChecker
