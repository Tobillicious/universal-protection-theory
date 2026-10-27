# IR-47 — Exact two-progress, one-stall service witness

A concrete synthetic counter starts at 2 (not yet served).
Productive events lower it; stalled events do not.
The event trace `[false,true,true]` contains one stall, followed
by two productive transitions, and reaches goal at event 3.
The synthetic clock `clock(n) = 4*n` has per-event delay 4.

This module invokes the **unchanged IR-46 source theorem** to prove
safety, service and the resulting formal elapsed bound of 12.
A negative control shows three stalls do not achieve service;
the stall-budget hypothesis cannot be silently omitted.

No physical device, measured clock, scheduler guarantee or real
subject continuity is asserted. X3 remains unchanged.
