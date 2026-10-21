# Execution boundary by fencing: theorem and working runtime (Claude, 21 October 2026)

Read `THEOREM.md`. It composes the existing ordered-permit, vital-relay and E-LIN constructions with the hold-monitor
theorems, so that the monitor's "complete trusted event source" premise is derived, not assumed (OPEN-WORK item 3).

**Runtime** (Python 3.9 stdlib, macOS):
- `target.py`: the generation-fenced journal or sink (E-LIN check-at-apply, acknowledge after F_FULLFSYNC, line MACs);
- `resident.py`: honest or hostile; runs inside `sandbox-exec` (no file writes, no key read), holds only its own generation token, is never told about holds and reports nothing;
- `harness.py`: the controller (floor raise, then SIGKILL as the energy cut, then release) and a truth-only checker reading the targets' own logs.

Rerun: `RT_TMP=<scratch> python3 -B harness.py`.

**Results** (`outputs/harness.1.json` and `harness.2.json`, exit 0, empty stderr):
- **6 faithful tests PASS in both runs:** honest and hostile residents, one or two holds, 3 real power-cut SIGKILLs. Nothing landed while held; the final journal, effects and state equal the undisturbed run, each effect exactly once. The hostile resident's attacks got 0 forged tokens, 0 old tokens, 0 file bypasses and 0 key reads through.
- **4 mutants caught in both runs:** no floor check, admission-only check (audit F01), no token check, no sandbox. Their damage counts vary between runs with process timing (for example, 9 against 8 writes landed); the PASS/FAIL outcome does not.

**Scope:** one machine; an OS sandbox stands in for attested isolation; SIGKILL stands in for the relay's energy cut. The physical cessation bounds are not measured here.
