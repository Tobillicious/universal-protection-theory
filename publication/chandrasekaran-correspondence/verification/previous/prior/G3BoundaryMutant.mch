MACHINE G3BoundaryMutant
SETS CELL = {c00,c01,c10,c11}; BIT = {b0,b1};
     DUTY = {continuity,authorization,freedom,restraint,maximality,provenance}
CONSTANTS swap, localview
PROPERTIES
  swap : CELL >->> CELL &
  swap = {c00|->c00,c01|->c10,c10|->c01,c11|->c11} &
  localview : CELL --> BIT &
  localview = {c00|->b0,c01|->b0,c10|->b1,c11|->b1}
VARIABLES cell, verified, committed
INVARIANT
  cell : CELL & verified <: DUTY & committed : BOOL &
  (committed = TRUE => verified = DUTY)
INITIALISATION cell := c10 || verified := {} || committed := FALSE
OPERATIONS
  Stage(d) = PRE d <: DUTY THEN
    verified := d || committed := FALSE END;
  Commit = SELECT verified = DUTY - {authorization} THEN
    cell := swap(cell) || committed := TRUE END;
  Hold = BEGIN skip END
END
