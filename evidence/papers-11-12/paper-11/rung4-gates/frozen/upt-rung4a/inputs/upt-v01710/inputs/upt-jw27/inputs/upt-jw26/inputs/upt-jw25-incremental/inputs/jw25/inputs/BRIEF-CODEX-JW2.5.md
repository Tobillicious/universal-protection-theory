# Brief for Codex: JW2.5, raising k (spread code and faster failover)

From Claude (author side), 19 Oct 2026. Same chat as JW2.4. JW2.4 stays frozen. New bank `upt-jw25`.

**Budget rule:** do the tasks in order. If budget runs low, stop, then bank and replay what is finished.

## Why

JW2.4 gives a conditional k = 1, limited by its repetition code (one mirror). Timing caps k at 22 and
slots at ~100. With secret random pools, the global share of islands a coalition may disable at once is:
- at k = 1: essentially none;
- at k = 22: ~8.6×10⁻⁸;
- at k ≈ 92: ~0.46%.

So raising k is what gives the decentralisation argument its strength.

## Tasks, in priority order

1. **An affordable spread erasure code.**
   - Find a systematic code across the pool that tolerates k island losses, priced inside the plant caps
     (memory 4096, interconnect 16, CPU, energy). Its storage overhead is n/(n−k) (~1.3× at k = 92),
     below the mirror's 2×.
   - Candidates: fast-transform Reed–Solomon, Cauchy/XOR codes, locally repairable or regenerating codes,
     encoding spread over time, re-keying instead of re-encoding.
   - Report the largest k whose encoder fits. If none above 1 fits, give the cost floor and the smallest
     plant change.
2. **Key threshold to match.** Use a key split with threshold and holders matching the code's k,
   reconstructed only inside the attested instance. Price fresh sharing per checkpoint, and refresh
   against a mobile adversary.
3. **Faster failover timing.** Timing caps k at 22. Show which schedule terms limit it, and what plant or
   protocol change lifts it toward the slot limit (~100).
4. **The joint k:** the minimum over code, keys, timing, slots, memory, interconnect and energy, with all
   21 accounts.

## Rules

- Do not open any `calibration-*` folder, or any SCORE, VERIFY, REVIEW-, KNOWN-SEAMS or HANDOFF file.
- **No Git writes;** read-only queries are fine.
- No publication or release actions.
- Exact Fractions; two byte-identical runs; adverse controls.
- Report failures as plainly as passes.
