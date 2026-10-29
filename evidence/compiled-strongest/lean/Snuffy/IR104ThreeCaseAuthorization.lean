import Snuffy.IR103LedgerContinuityCountermodel

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IR104ThreeCaseAuthorization.lean` at main `740abbb` (sha256 `b4bf8e96918cda0b147080f6358ee7684931b1e0328d4ade2586daae0bbc080b`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false

/-!
IR-104: three-case continuation model.
Balanced accounting alone allows unauthorized termination;
a separately specified authorization rule excludes it.
No claim is made that physics independently enforces that rule.
-/
namespace PhysicalBridges.IR104

inductive TransitionKind where
  | continue
  | consentedEnd
  | unconsentedEnd
  deriving DecidableEq

def Accounted (_ : TransitionKind) : Prop := True

def SubjectAuthorized : TransitionKind → Prop
  | .continue => True
  | .consentedEnd => True
  | .unconsentedEnd => False

def Admissible (t : TransitionKind) : Prop :=
  Accounted t ∧ SubjectAuthorized t

theorem all_three_cases_accounted (t : TransitionKind) : Accounted t :=
  trivial

theorem accounting_allows_unconsented :
    Accounted .unconsentedEnd :=
  trivial

theorem authorized_continuation :
    Admissible .continue :=
  ⟨trivial, trivial⟩

theorem authorized_consented_end :
    Admissible .consentedEnd :=
  ⟨trivial, trivial⟩

theorem authorization_excludes_unconsented :
    ¬ Admissible .unconsentedEnd := by
  intro h
  exact h.2

end PhysicalBridges.IR104
