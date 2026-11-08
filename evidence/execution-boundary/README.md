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


## Koru shadow verifier — synthetic, **not** an execution gate

The new adjacent `koru_shadow.py` is deliberately **read-only**. It does not import or modify `target.py`, `resident.py`, `harness.py`, or their trusted state and it never writes target journal/sink logs. Its `inspect(event, now=...)` result is **not** permission to enact an event. See [`KORU-ENACTMENT-GATE-ADR.md`](KORU-ENACTMENT-GATE-ADR.md) for the staged integration boundary.

Rerun the standalone synthetic negative controls on any platform with Python 3.9+:

```sh
python3 -B -m unittest discover -s evidence/execution-boundary -p 'test_koru_shadow.py' -v
```

The fixture uses a **toy** six-position integer context with explicit n-ary operators (`anchor_one`, `identity`, `add`, `multiply`); operator arity/order and exact expression trees remain part of the witness binding even when numerical evaluations coincide. It checks event schema, finite context version and full-context fingerprint (including positions *outside* the local event), lineage, signature digest, subject/action roles, a toy effect-coherence equation, independent fixture registries for authority/provenance/witness bindings, generation and idempotency. Results contain only the verdict and reason code; full event contents are not emitted as logs.

The check **does not** validate Lean theorem proof terms, establish correspondence to BCRD W dynamics, provide cryptographic attestation, create authenticated real-world cultural permissions, or atomically enforce application-time invariants. The test-only trusted fixture registries are supplied separately from the proposed event; in real software they would require secure independent provenance, trusted signatures, revocation and atomic state checking. The only supported pilot `transition_kind` is `synthetic_refinement`; a claimed `automorphism` is explicitly rejected until a genuine same-signature verifier exists.

Before enforcement, review the validator's semantics and tests, implement reliable independent evidence sources, bind the exact whole-context version to the **actual** application state, integrate under the existing lock without breaking the fence, and test crash/replay/outbox paths. No claim of global agent alignment or deployment is made.
