MACHINE GuardianRecord
VARIABLES protected, initial, work, record, used
INVARIANT
  protected : 0..1 & initial : 0..1 & work : 0..1 & record : 0..1 & used : 0..1 &
  (used = 0 => record = 0 & work = initial) &
  (used = 1 => work = 0 & record = initial)
INITIALISATION
  ANY p,w WHERE p : 0..1 & w : 0..1 THEN
    protected,initial,work,record,used := p,w,w,0,0
  END
OPERATIONS
  Turn = PRE used = 0 THEN work,record,used := record,work,1 END;
  Hold = PRE used = 1 THEN skip END
END
