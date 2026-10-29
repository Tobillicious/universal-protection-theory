namespace Snuffy.RelationalBridge

structure Module1_Input where
  stateHash : UInt64
  securityLatch : Bool
  workCost : Float
  deriving Repr, DecidableEq

structure RelationalEventState where
  idealClosed : Bool
  boundaryClean : Bool
  causalDepth : Nat
  merkleCommitment : UInt64
  deriving Repr, DecidableEq

def relationalAuth (s : RelationalEventState) : Bool :=
  s.idealClosed && s.boundaryClean

def bridgeToModule1 (s : RelationalEventState) : Module1_Input := {
  stateHash := s.merkleCommitment,
  securityLatch := relationalAuth s,
  workCost := s.causalDepth.toFloat * 1.38e-23
}

theorem bridge_preserves_safety (s : RelationalEventState)
    (h_closed : s.idealClosed = true) (h_clean : s.boundaryClean = true) :
    (bridgeToModule1 s).securityLatch = true := by
  dsimp [bridgeToModule1, relationalAuth]
  rw [h_closed, h_clean]
  rfl

end Snuffy.RelationalBridge