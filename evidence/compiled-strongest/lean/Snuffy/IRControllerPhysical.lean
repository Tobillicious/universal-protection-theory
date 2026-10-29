import Snuffy.ControllerFence
import Snuffy.IRPhysicalGuard

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IRControllerPhysical.lean` at main `740abbb` (sha256 `a1b47fa4b79ae2c201d9df0c3985fd6308e4c66caccaa7af7470195a781ac56f`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false
/-
IR-5: source-level join to the *actual unchanged* Snuffy controller/fence sources.
The inherited ControllerFence/ControllerFinality/UPTFence sources are copied
byte-for-byte from evidence/papers-11-12/lean/modules by GitHub Actions.
No physical state conclusion follows without the explicit log-to-physics
correspondence parameter, and the counterexample proves its necessity.
-/

namespace PhysicalBridges.IRControllerPhysical
open UPTController

/-- A certified held controller maintains the same log, and thus the same
*log-derived physical projection*. Physical correspondence remains a premise. -/
theorem certified_hold_preserves_log_derived_physics
    {P : Type}
    (enrol : Nat → List Nat) (start : State)
    (before during : List Op) (c : Context)
    (retired : (step enrol (run enrol start before) (.retire c)).2 =
      .floor c (c.generation + 1))
    (noRelease : ∀ d, Op.release d ∉ during)
    (target : UPTFence.St) (attempts : List UPTFence.Ev)
    (tokens : ∀ g, g ∈ target.minted →
      UPTControllerFence.TokenWitness enrol start (before ++ .retire c :: during) g)
    (later : ∀ g, UPTFence.Ev.mint g ∈ attempts →
      UPTControllerFence.TokenWitness enrol start (before ++ .retire c :: during) g)
    (physicalOfLog : List Nat → P) :
    physicalOfLog (UPTFence.run
      (UPTFence.apply target (.raise (c.generation + 1))) attempts).log =
    physicalOfLog target.log := by
  exact congrArg physicalOfLog
    (UPTControllerFence.certified_hold_nothing_lands
      enrol start before during c retired noRelease target attempts tokens later)

/-- A complete physical correspondence on both endpoints composes with
controller safety. This is a refinement obligation, NOT a derived fact
about the actual hardware. -/
theorem certified_hold_physical_refinement
    {P : Type}
    (enrol : Nat → List Nat) (start : State)
    (before during : List Op) (c : Context)
    (retired : (step enrol (run enrol start before) (.retire c)).2 =
      .floor c (c.generation + 1))
    (noRelease : ∀ d, Op.release d ∉ during)
    (target : UPTFence.St) (attempts : List UPTFence.Ev)
    (tokens : ∀ g, g ∈ target.minted →
      UPTControllerFence.TokenWitness enrol start (before ++ .retire c :: during) g)
    (later : ∀ g, UPTFence.Ev.mint g ∈ attempts →
      UPTControllerFence.TokenWitness enrol start (before ++ .retire c :: during) g)
    (physicalOfLog : List Nat → P) (beforePhysical afterPhysical : P)
    (hBefore : beforePhysical = physicalOfLog target.log)
    (hAfter : afterPhysical = physicalOfLog
      (UPTFence.run (UPTFence.apply target (.raise (c.generation + 1))) attempts).log) :
    afterPhysical = beforePhysical := by
  rw [hAfter, hBefore]
  exact certified_hold_preserves_log_derived_physics
    enrol start before during c retired noRelease target attempts
    tokens later physicalOfLog

/-- In a held interval a physical channel omitted from target logs may still
change. A no-write theorem cannot eliminate such a channel by itself. -/
theorem unchanged_log_insufficient_without_coverage :
    ∃ (beforeLog afterLog : List Nat) (beforePhysical afterPhysical : Nat),
      beforeLog = afterLog ∧ beforePhysical ≠ afterPhysical := by
  exact ⟨[], [], 0, 1, rfl, by decide⟩

/-- A later, separately authorised effect is safe if it satisfies IR-1R.
The hold theorem alone does not authorize or constrain that new effect. -/
theorem later_bounded_effect_safe
    (observed epsilon drift jump threshold sample actualAfter : Nat)
    (hObs : sample ≤ observed + epsilon)
    (hEffect : actualAfter ≤ sample + drift + jump)
    (hGate : observed + epsilon + drift + jump ≤ threshold) :
    actualAfter ≤ threshold :=
  IRPhysicalGuard.post_effect_guard_sound
    observed epsilon drift jump threshold sample actualAfter hObs hEffect hGate

end PhysicalBridges.IRControllerPhysical
