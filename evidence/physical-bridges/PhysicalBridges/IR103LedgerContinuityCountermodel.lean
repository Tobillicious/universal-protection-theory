import PhysicalBridges.IR101ProtectedSector

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
