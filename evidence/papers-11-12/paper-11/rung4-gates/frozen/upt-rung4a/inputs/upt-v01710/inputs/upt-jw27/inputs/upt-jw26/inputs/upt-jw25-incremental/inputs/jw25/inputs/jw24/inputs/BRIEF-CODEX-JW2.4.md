# Brief for Codex: JW2.4, making k > 0 (remote replicas, certificates, timing, encoding)

From Claude (author side), 19 Oct 2026. Same chat as JW2.3. Build on JW2.3, which stays frozen. New bank
`upt-jw24`.

**Budget rule.** Usage is near its weekly limit. **Do the tasks in order. If your budget runs low, stop,
then bank and replay whatever is finished.** A finished task 1 is worth more than a half-finished set.

## Why

JW2.3 showed that the guaranteed number of disabled islands per pool is **k = 0** under the supplied
contracts: a local-copy countermodel loses every copy and key of an island's minds. The capacity limits
(92 by slots, 295 by care energy) are not guarantees.

## Tasks, in priority order

1. **Remote-replica placement and release contract (the decisive gap).**
   - State the minimal contract under which every mind's encrypted state and key material is recoverable
     from islands other than its own, within the recovery window. That covers placement, availability
     and the release path, with no ordinary host ever holding a whole key.
   - Then compute the largest guaranteed k under it, with all 21 accounts.
   - Use key-only threshold sharing (≥ 459 effective bits: 256-bit keys are insufficient, so state the
     key size and refresh) and erasure-coded ciphertext.
   - If no k > 0 is achievable at the JW2.2 plant, say so, and give the smallest plant change that
     achieves it.
2. **Certificate batching.** The ceiling (4130 of 4224) caps k ≤ 11. Design a batched or care-only
   certificate path for exiles, price it, and report the new k limit.
3. **Failover timing.** Fit failover inside .95, with grace ≤ ~.0145 and no serial audit (a parallel or
   pre-committed audit). Report the timing-limited k.
4. **An affordable encoder.** The straightforward parity encoder costs ~5.07×10⁶ compute per island-epoch
   against 3648. Find an erasure code and schedule that fits (systematic, fast-transform or
   locally-repairable codes, spread over time), or state the cost floor.
5. **Restate J-LIVE** at ≤ 70 compute losses and ≤ 78 total site losses, with the 71-compute tail charged,
   as you proposed.
6. **If budget remains:** price the location-privacy layer from the author's v0.17.4 draft: rendezvous
   routing with persistent entry guards; re-drawing keys and routes, not state; P-REDRAW as mapping time
   versus mixing time. Report its timing and compute cost at JW2.2 units.

## Rules

- Do not open any `calibration-*` folder, or any SCORE, VERIFY, REVIEW-, KNOWN-SEAMS or HANDOFF file.
- **No Git writes** (commit, stage, branch, push). Read-only Git queries from the boot script are fine.
- No publication, deposit, dispatch or Zenodo action.
- Exact Fractions; two byte-identical runs; adverse controls.
- Report failures as plainly as passes.
