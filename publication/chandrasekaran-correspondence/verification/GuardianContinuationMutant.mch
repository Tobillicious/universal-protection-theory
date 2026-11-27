MACHINE GuardianContinuationMutant
VARIABLES history, initial, phase, policy
INVARIANT
  history : 0..1 & initial : 0..1 & history = initial &
  phase : 0..2 & policy : 0..1
INITIALISATION
  ANY h WHERE h : 0..1 THEN history,initial,phase,policy := h,h,0,0 END
OPERATIONS
  Align = BEGIN policy := 1 END;
  Advance = PRE phase < 2 THEN phase := phase + 1 END;
  Genesis = PRE phase = 2 THEN phase,history := 0,0 END
END
