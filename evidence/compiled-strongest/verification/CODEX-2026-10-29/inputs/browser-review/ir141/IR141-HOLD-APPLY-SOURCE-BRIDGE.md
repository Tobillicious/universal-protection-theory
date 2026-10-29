# IR-141 — A hold/application linearization repair and its physical limit

**29 October 2026 (NZDT). Draft, noncanonical. Original X3 unchanged.** Stacked repair against the *unmerged* compiled strongest [PR #178](https://github.com/Tobillicious/universal-protection-theory/pull/178), exact parent head 1d5488de2baf6891a74d70a7b7e15d37dba25099. It does not update the published Snuffy edition, Canon 4.2, or original theorem statements.

## Source-identified break

The pilot's 29 October application-time permit repair did not close an inter-process check-then-act race:

- Original sink.py: check existence of the HOLD path, then append and F_FULLFSYNC the effect without locking the controller's flag transition. The controller in harness.py creates/removes the path concurrently.
- Original monitor.py: check flag, append grant record, respond. Original resident.py can run *after* grant while the controller raises a hold.
- The reported monitor field exec_while_held is computed from an event field hardcoded held=False for accepted grants. It is not an independent sensor of every actual execution. The harness's timestamp inspection is more informative but cannot exclude an adversarially scheduled interleaving.

The resulting concrete trace is CHECK(no HOLD) -> ACK(HOLD) -> COMMIT(effect). A lucky zero-failure randomized campaign does not exclude it.

## Changed executable source

1. common.py: a POSIX flock inter-process exclusive guard; set_hold(run, active) changes the HOLD flag *inside the same lock* and returns request-to-ACK latency.
2. sink.py: wraps both flag check and durable sink application under the common lock.
3. resident.py: a **cooperative** step holds that lock from monitor-permit request through the modeled state-changing step, including the SIGKILL injection point. A permit cannot be reused across an acknowledged hold.
4. harness.py: raises and clears holds through set_hold and records hold_raise_request_to_ack_s and hold_clear_request_to_ack_s. The previously reported 0-second after-raise execution metric must never be substituted for *request-to-ACK* latency.

The linearization point is the actual HOLD mutation while the lock is owned. Work already in flight is allowed to finish **before the hold acknowledges**. A requested hold may wait for the previous operation to leave its critical section. This is the correct atomic contract for the **software model** but is insufficient for a hard deadline until a worst-case request-to-ACK bound is independently measured and enforced.

**Protocol theorem (conditional, informal):** assuming (a) controller alone may change HOLD and does so under the same exclusive lock, (b) all effect applications are through the sink and that sink holds the lock from check to commit, (c) the OS supplies correct mutual exclusion, and (d) the appending/storage action is the represented final effect, then no accepted sink commit can occur strictly between a hold ACK and the following release ACK. Either an effect acquires the lock first and commits before hold ACK, or hold acquires it first and the effect sees HOLD. A separate cooperative resident-step argument substitutes permit+step as its guarded critical region. The strict event-order claim is about the protected software log, not arbitrary outside-world effects.

## Deterministic falsification and protected control

Run on macOS/Linux with Python 3.9+:

    python3 evidence/compiled-strongest/installation/pilot/hold_linearization_checks.py

The script spawns a real child process, pauses the sink exactly *after* checking no HOLD but *before* committing, and forces the controller to request HOLD. With the original unguarded pattern the sink commits **after hold ACK**. With the repaired guard, the hold request must wait; the sink commits **before hold ACK**. An explicit malicious-bypass control demonstrates that a writer with direct access to the log still writes during HOLD. The independent interleaving test was reproduced on Linux locally. A second test, source_hold_integration.py, starts the **actual patched sink.py** as a child process, injects an external pause immediately after its real HOLD check, holds the controller transition during its locked commit, verifies that the real sink refuses a later effect during HOLD, and substitutes POSIX fsync only on platforms lacking Mac F_FULLFSYNC. Both tests ran against a reconstructed Linux local copy; no remote CI or Mac replay is claimed. These are software protocol checks, **not** a Mac F_FULLFSYNC end-to-end replay or a kernel proof.

Run the exact patched-source integration from the repository root:

    python3 evidence/compiled-strongest/installation/pilot/source_hold_integration.py

## What the test establishes, and what it does not

**Evidence now improved:** a reproducible race, a code-level synchronization repair, and a request-to-ACK measurement field that the older claims lacked. No new empirical claim is made from the historical 27, 400, or 1000 tests until the revised code is actually rerun on the measured Mac.

**Still unproved:**

- **Hostile-code separation:** The resident, sink, monitor, controller, HOLD path and journal currently run under one user's filesystem permissions. A hostile resident can modify the guard file, bypass the sink, or create another output. A separate process is not a trusted hardware/OS authority. Enforce distinct users/sandboxes and deny the resident write/control access before attributing hostile security.
- **All-effect completeness:** Local sink callbacks are not arbitrary physical effects: sockets, displays, power draw, heat, radio emission, and side channels can escape. The ChannelMeter total-energy lemma alone does not eliminate one-bit harmful triggers. Independent output-closure instrumentation and per-harm thresholds remain needed.
- **Physical harm deadline:** The hold **request-to-ACK** worst-case, all in-flight work, sampling error, clock accuracy, scheduler delays and bypass consequences require measurement and a conservative upper bound. A passing rho=0 synthetic reach check does not establish actual coverage.
- **Journals vs subjects:** A full-synced journal and sequence/author labels establish recorded events in this device, not the original subject's continuing subjective/physical identity, correct authorization, or independent freedom.
- **Statistical inference:** The original 400 tests' zero observed failures and associated one-sided binomial confidence limit apply to the experimental trial distribution, *not* a supremum over hidden states or adversarial schedules. The ItemisedRisk model's per-state conditional kernel upper bounds are not thereby physically verified.
- **External independence:** Testing one machine and checking its own source is not an independent hardware review; independent human inspection, different machines/OSes, adversarial code execution and authenticated raw instrumentation remain necessary.
- **Formal refinement:** There is no new Lean theorem relating *these Python source operations and operating-system file locking* to UPTFence or the full original X3. An exact trace adapter with authenticated events, verified OS assumptions and a full-system refinement would be a further bridge.

## Next execution/review obligations

- Run the current 27-test suite and 1,000/400 randomized campaign again on the Mac, and verify negative mutants still fail. **Not run in this PR.**
- Add a true adversarial distinct-OS-principal test, including resident attempts to unlink HOLD and replace the lock inode, direct-sink bypass, in-flight output, and network or power channels. Pass requires independent containment, not another cooperative mutex.
- Measure controller *request-to-ACK* tails (including when the sink is blocked inside F_FULLFSYNC), then incorporate that bound into the actual physical round-trip and harm deadline.
- Build source-level refinement checks and a real measured causal-channel inventory for the controlled enclosure; keep all original particulars, four stages, and complete-rival objective unweakened.

**Disposition:** a real software race and an independently reproducible synchronization protocol; physical original X3 remains open. Do not merge or publish without review.

