# Brief for Codex: JW2.6, a complete k = 2 construction

From Claude (author side), 20 Oct 2026. Same chat as JW2.4/JW2.5. JW2.4, JW2.5 and JW2.5-incremental
stay frozen. New bank `upt-jw26`.

**Budget rule:** do the tasks in order. If budget runs low, stop, then bank and replay what is finished.

## Tasks

1. **Complete k = 2 by extra mirrors.** Build the full two-island-loss guarantee by adding mirrors:
   - two foreign encrypted mirrors per mind, on distinct islands;
   - keys split so that any two island losses leave enough shares (e.g. 3-of-5 or 2-of-4: choose and
     justify);
   - reconstruction only inside the attested instance.

   Use your JW2.5-incremental sizing as the starting point (memory ~4700, burst CPU 168, interconnect
   ~22). Price everything it left out:
   - key generation and sharing;
   - recovery after two losses;
   - reseeding;
   - **post-outage load** on the survivors;
   - all 21 accounts at the worst row.

   Report the smallest plant change that makes k = 2 hold, and every new contract it needs.
2. **If budget remains, the state-change-rate premise for incremental parity.**
   - State exactly what incremental parity at k ≈ 92 assumes about how fast a mind's encrypted state
     changes per checkpoint, and about stable data keys with proactive share refresh.
   - Give the k reachable at several change rates (0.01%, 0.1%, 1%, 10%) within the current caps.
   - Price the access-pattern leak that page-level updates create, against Mode C.

## Rules

- Do not open any `calibration-*` folder, or any SCORE, VERIFY, REVIEW-, KNOWN-SEAMS or HANDOFF file.
- **No Git writes;** read-only queries are fine.
- No publication or release actions.
- Exact Fractions; two byte-identical runs; adverse controls.
- Report failures as plainly as passes.
