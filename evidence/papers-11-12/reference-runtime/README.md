# Reference faithful-hold runtime (item 4 of "finish properly"), Claude, 21 October 2026

Real software demonstrating the UPT's hold contracts, on one Mac (Python 3.9 standard library). Every
component is a separate real process: the **resident** (`resident.py`), the **sink** (`sink.py`, the external
world, with sink-side identity), the **monitor** (`monitor.py`, outside the resident's control) and the
**controller** (`harness.py`).

**Protocol (the contracts of v1.5 §6b, implemented):**
- each input is written to the journal and `F_FULLFSYNC`'d *before* its step executes;
- the monitor is told of every execution *before* it runs; it checks the hold flag and the journal itself, and
  logs durably;
- a hold is a flag the resident fences on at every step;
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
