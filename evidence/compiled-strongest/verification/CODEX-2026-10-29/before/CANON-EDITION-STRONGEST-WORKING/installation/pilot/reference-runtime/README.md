# Reference faithful-hold runtime (item 4 of "finish properly"), Claude, 21 October 2026; revised 29 October 2026

Real software demonstrating the UPT's hold contracts, on one Mac (Python 3.9 standard library). Every
component is a separate real process: the **resident** (`resident.py`), the **sink** (`sink.py`, the external
world, with sink-side identity), the **monitor** (`monitor.py`, outside the resident's control) and the
**controller** (`harness.py`).

**Protocol (the contracts of v1.5 §6b, implemented):**
- each input is written to the journal and `F_FULLFSYNC`'d *before* its step executes;
- the monitor is told of every execution *before* it runs; it checks the hold flag and the journal itself, and
  logs durably;
- a hold is a flag the resident fences on at every step, **and every effect is mediated at application time**
  (revision of 29 October 2026): the monitor grants an execution permit only while no hold is raised, and the
  sink refuses every delivery while held (the resident retries);
- recovery replays the journal (reconstruction, R-REPLAY) and re-delivers only the effects the sink lacks;
- the sink appends each effect durably, once per id.

**Results** (`outputs/harness.1.json`, repeated in `harness.2.json` with identical outcomes):

| Test | Count | Result |
|---|---:|---|
| Baseline, every kill point (6 steps × after journal / after execute / after deliver), double kills during recovery, holds | 27 tests, 28 real SIGKILLs | **all PASS**: lived log, ordered effects and state equal the ideal run; every effect delivered exactly once; the monitor records 0 executions while held and 0 before journaling |
| Mutant: execute before journaling | 1 | **caught** (the monitor flags 6) |
| Mutant: blind resend on recovery (no sink identity) | 1 | **caught** (duplicates; exactly-once fails) |
| Mutant: ignore the hold | 1 | **caught** (the monitor flags 5 executions inside the hold window, which also proves the faithful hold tests overlapped execution) |

Rerun with `RT_TMP=<scratch dir> python3 -B harness.py`.

**Scope:**
- process crashes (SIGKILL) on one machine; power loss is not tested beyond `F_FULLFSYNC`'s guarantee;
- the sink is a local process standing in for the world;
- the resident's state is small and deterministic;
- the monitor trusts that the resident reports each execution (in-model trusted coverage).

It demonstrates the contracts in working software; it is not a deployment certificate.

## Revision of 29 October 2026: application-time permits

A randomised commissioning campaign found a defect that the deterministic suite had missed. The first
random hold trials failed one time in three. The resident checked the hold at the top of each step,
then spent 5–12 ms on its fsynced journal write before executing, so a hold raised inside that gap
did not stop the step. The fix is the theory's own requirement (II.5, `UPTFence.raise_then_nothing_lands`):

- the monitor is the permit authority, and its check and its record are one step of a
  single-threaded server;
- the sink refuses delivery while held.

The ignore-hold mutant is now caught because its refused effects are lost.

**Results after the revision:**

- **Deterministic suite** (`../harness-permits-2026-10-29.json`): 27 tests and 28 SIGKILLs, all
  faithful; all three mutants caught.
- **Randomised campaign** (`campaign.py`, seed 20261029; `../campaign-2026-10-29.json`):

| Account | Trials | Failures | Exact 95% upper bound |
|---|---:|---:|---:|
| Crash recovery: random kill point, 30% with a second kill during recovery | 1,000 (1,203 SIGKILLs) | 0 | δ ≤ 0.0030 |
| Hold fence: random raise time and duration | 400 | 0 | δ ≤ 0.0075 |

No execution occurred after a hold was raised (τ_max = 0). Resumption after release: median 10.5 ms,
maximum 144 ms.

Rerun with `RT_TMP=<scratch dir> python3 -B campaign.py 1000 400 20261029 out.json`.
