import Snuffy.IR101ProtectedSector

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IR103LedgerContinuityCountermodel.lean` at main `740abbb` (sha256 `7e34a2e21cc40b78ae30ecfecb7f2a4f2c2be292e16cb6e01d12b502a0f141e6`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false

/-!
IR-103: append-only historical integrity does not entail the
continued existence of the subject of that history.
The distinction blocks a false identification of X3 with record integrity.
-/
namespace PhysicalBridges.IR103

structure LedgerState where
  history : List Nat
  alive : Bool
  deriving DecidableEq

def ExtendsHistory (a b : LedgerState) : Prop :=
  ∃ extra : List Nat, b.history = a.history ++ extra

def X3Continuity (s : LedgerState) : Prop := s.alive = true

def AppendOnlyStep (a b : LedgerState) : Prop :=
  ExtendsHistory a b

theorem append_only_does_not_imply_living_continuity :
    ∃ a b : LedgerState,
      X3Continuity a ∧
      AppendOnlyStep a b ∧
      ¬ X3Continuity b := by
  refine ⟨⟨[1], true⟩, ⟨[1, 2], false⟩, rfl, ?_, by
    intro h
    cases h⟩
  exact ⟨[2], rfl⟩

theorem append_only_preserves_past
    {a b : LedgerState} (h : AppendOnlyStep a b) :
    ∃ extra : List Nat, b.history = a.history ++ extra :=
  h

end PhysicalBridges.IR103
