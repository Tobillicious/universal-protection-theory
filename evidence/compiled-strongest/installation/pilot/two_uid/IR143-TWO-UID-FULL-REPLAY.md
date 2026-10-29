# IR-143 — Guardian-owned replay with two real OS principals

**29 October 2026; source-level research candidate; DRAFT.** Parent [IR-142 PR #182](https://github.com/Tobillicious/universal-protection-theory/pull/182) head 1ee7dbac67f77ed4c11c0d2a25dc42c2c7d5d993. Ancestors: IR-141 #181 and compiled strongest #178. Original X3, every particular, lawful directions and four stages remain unchanged. No canon, Lean source or publication was edited.

## What changes

IR-142 separated one existing sink endpoint from a different test client under Linux discretionary access control (DAC), but the inherited resident still wrote its own journal and took the guardian's lock. **IR-143 implements a separate-UID reconstruction of the complete six-step resident/journal/monitor/sink behaviour:**

- The new resident_client.py is a process at an untrusted UID/GID. It requests journal entries, authorization to compute, and effect delivery over public.sock. On SIGKILL, it reconstructs deterministic state from the guardian's journal snapshot and re-requests permits for missing effects. It never needs direct write access to journal, monitor log, sink log or HOLD.
- The new guardian_service.py is a **different, unprivileged** guardian UID/GID running a serial Unix socket service. It alone owns the 0600 journal, monitor-permit log, effect log and HOLD flag. The guardian process combines journal, monitor and sink as *three trusted logical functions*, rather than claiming they are separate OS processes. Client request socket mode 0666 and protected controller socket mode 0600 have intentionally different authority.
- Each journal step uses the original inherited six-step source S0=3; f(s,x)=(3s+x) mod 7; g(n)=n+1 from reference-runtime/common.py. Only the guardian creates the next input. It durably appends the journal before acknowledging; permits are available only for the next undelivered journal step. The guardian validates proposed final value against journal replay and a recorded permit.
- The guardian serializes final effect writes with hold transitions inside its own event loop. Raising a hold invalidates earlier permits with an epoch increment. A delivery is blocked while held; a stale permit stays invalid after release.
- On macOS the guardian file append calls F_FULLFSYNC where available; on Linux it calls fsync. The CI claim is about the tested Linux execution only, not full independent Mac power-loss semantics.

## Exact verification

Run **only on a disposable Linux CI machine** where the test launcher can drop privileges:

    sudo python3 -B evidence/compiled-strongest/installation/pilot/two_uid/integration.py

The launcher selects two unused numeric UIDs, stages exact source file bytes into a read-only-to-client source directory, starts both real processes, and checks 27 deterministic complete-run variants: baseline, 18 kills (six steps × after-journal/after-execution/after-sink), five double-kill recovery cases, and three holds. It requires exactly **28 actual SIGKILLs**, identical ordered journal inputs and sink values to the inherited ideal model, unique effect IDs, absence of accepted sink writes during held time, and guardian-owned mode-0600 receipts. The monitor log records **permits, not independently sensed execution**.

Independent CI: .github/workflows/ir143-two-uid-replay.yml. Read its actual results before promoting any assertion from local tests.

### Incomplete-client / hold-ACK liveness control

Hostile source review found an additional denial-of-service seam in the first candidate: the single-threaded guardian originally waited indefinitely for the next newline from a public client. A resident could open public.sock, send an incomplete message, and block the processing of the controller's hold.

The repair imposes a **total 50-ms wall-clock request-read deadline**, an 8192-byte request bound, and a 50-ms send timeout, then drops incomplete requests without dispatching them. The independent Linux control slowloris_hold_check.py holds an untrusted client socket open with a partial message for three seconds and requires a guardian-identity hold RPC to finish with under 300 ms of **measured socket round-trip time while the adversary is still connected**. This test measures only one input-blocking mechanism; no universal or hardware deadline is inferred because synchronous disk flush, system scheduling, faults and other channels can still delay work. See the latest CI run for the actual verdict.

### Eleven active kernel-denied controls

The alien-UID client attempts to append/truncate the journal, truncate the monitor, truncate the sink, create HOLD, unlink/rename the public socket, change journal permissions, create a file in the guardian directory, signal the guardian process, and connect to the private controller. Each must be denied by Linux permissions. The public controller verb must also be rejected.

### Deliberately retained failures / counterexamples

1. **Forged but model-consistent execution is accepted:** A hostile client can request a journal entry, get a permit, calculate the expected f value *without running the purported original resident step*, and deliver it. Thus a guardian-stamped permit plus deterministic-replay match is **not** independent evidence of actual resident execution, source-level legitimacy, continuing physical subject identity, or consent.
2. **An independent IPv4 socket can still be opened:** Linux DAC on these files does not confine network, power, heat, clocks, display, RF, auxiliary processes or other causal output channels. This is **not** all-effect coverage or a physical harm threshold.
3. **Input/journal authorization is syntactic:** An untrusted client can request the next source step; the gateway does not possess an independently authenticated subject-direction oracle. The monitor records allowed requests, not external proof of who genuinely directed them.
4. **Guardian remains a failure and compromise boundary:** Single-threaded response serializes represented effects; guardian crash during a journal append, arbitrary partial writes, resource exhaustion, service compromise, Linux kernel failure, and malicious guardian are *not* settled by the resident-only SIGKILL suite. Service availability and bounded time-to-hold-ACK still require independent measurement.
5. **Physical and semantic bridges are open:** Nothing here establishes source-complete BCRD, all-minds founding reach, physical carrier preservation, genuine free choice, all feasible rivals, universal coupling cap or X3 across the original four stages.

## Review obligations

- Separate guardian journal/monitor/effect functions into independently auditable authorities or provide a formally verified common-core refinement; add real peer-credential verification, backpressure limits and malformed-message fuzz tests.
- Introduce an **independently trusted authorization source**, plus adversarial subject-direction countermodels and an execution witness independent of the untrusted caller. The current apparent success must not be relabeled as actual authority.
- Expand the source-driven cross-principal harness to guardian crashes/power cuts (with valid receipt recovery), common-mode faults, early request-to-ACK bounds, unauthorized host outputs, and independent physical instrumentation.
- Connect exact implemented trace schemas to UPTFence and original X3 proof under separately verified assumptions, preserving worldwise/common-policy quantifier gap in IR-140 and every-mind scope from earlier sources.

**Disposition:** A finite model's crash-replay/hold functions through two OS principals is a substantial engineering step if CI passes. It is not multi-principal physical protection of all outputs, authenticated noncoercion, identity continuity, or unconditional original X3. No automatic merge or publication.
