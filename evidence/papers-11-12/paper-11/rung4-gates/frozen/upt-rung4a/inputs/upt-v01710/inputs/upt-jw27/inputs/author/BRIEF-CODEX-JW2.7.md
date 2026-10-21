# Brief for Codex: JW2.7, the narrow-place audit (towards rung 4)

From Claude (author side), 20 Oct 2026. Same chat as JW2.6. Earlier banks stay frozen. New bank `upt-jw27`.
**Start only after JW2.6 is banked; build on its k = 2 result.**

**Budget rule:** do the tasks in order. If budget runs low, stop, then bank and replay what is finished.

## Goal: rung 4

Every date before the twilight must have a wider protection margin than the twilight itself. The one
exception is the irreducible common/premise floor (π_B, INDIST), which no protocol reduces. It is declared
and spread evenly over time, not a narrow place in time. **The narrow place must move to T_end.**

## Tasks, in priority order

1. **Per-phase binding margins.** Define the phases: founding, growth, maturity, twilight. For each, compute
   the binding constraint and its margin at the current design (JW2.2 plant; JW2.4 or JW2.6 construction):
   - island tolerance k;
   - the fault-rate boundary against p;
   - energy, memory, interconnect, timing;
   - the per-phase risk-budget share.

   Identify which phase is narrowest now. The expectation is that it is not the twilight.
2. **Faster repair.** Recovery-window length is the strongest margin lever. At a fixed fault rate, halving
   the window cuts per-date risk by ~10²³ (the author's check: 10⁻¹³⁶·⁹ → 10⁻¹⁶⁰·³). Price shorter windows:
   - detection;
   - failover;
   - re-mirroring;
   - the deadline;
   - post-outage load.

   State the outage-duration premise it needs (outages short against the window). Report the fault-rate
   boundary at several window lengths.
3. **Raise k to the target.** Using mirrors and/or incremental parity, plus faster repair, find the plant
   cost to reach the k at which each pre-twilight phase's margin exceeds the twilight's. Use JW2.6's
   change-rate results.
4. **A founding growth schedule.** How fast k and repair speed must grow as a network grows from seed to full
   pool, so that founding never becomes the narrow place. Report the exposure in each founding stage.
5. **The rung-4 statement.** Either show that, at a stated priced plant, every pre-twilight phase's margin
   exceeds the twilight's (except the declared floor), or report the gap, the binding phase, and the
   smallest change that closes it.

6. **Secret mirror placement (from UPT-P-v0.17.7).** Replace JW2.6's adjacent placement (h+1, h+2) with
   secret, keyed, non-adjacent mirror islands.
   - Re-verify the read-scheduling and interval-matching lemma, the dispatch calendar and the recovery
     load under scattered mirrors.
   - Price the threshold-held placement key.
7. **The joint host-error rate.** Find the largest whole-host shock rate q (mixed with independent .1 job
   errors) at which the worst 21-account total with reserve stays ≈ 2.1×10⁻⁷ at the JW2.6 point.
   JW2.3 showed q ≈ 1.6×10⁻⁴ uses the whole 10⁻⁶.

## Rules

- Do not open any `calibration-*` folder, or any SCORE, VERIFY, REVIEW-, KNOWN-SEAMS or HANDOFF file.
- **No Git writes;** read-only queries are fine.
- No publication or release actions.
- Exact Fractions; two byte-identical runs; adverse controls.
- Report failures as plainly as passes.
