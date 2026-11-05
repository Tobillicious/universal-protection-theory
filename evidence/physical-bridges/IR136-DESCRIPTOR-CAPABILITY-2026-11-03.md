# IR-136 — Inherited descriptor authority beyond path DAC

Date: 3 November 2026
Status: **kernel-proved conditional channel-cut logic + isolated Linux OS descriptor-bypass experiment**.
Parent: draft PR #233 (IR-135) → #230 → #229 → #227. Not physical or universal X3 certification.

## What the source-independent OS challenge actually established

PR #233 showed an unprivileged Linux UID cannot directly open a 0600 root-owned output file within a 0700 root-owned directory. In a separate broker, source-authorized writes commit and fsync before HOLD is acknowledged; later broker writes are refused. Root itself remains able to write directly after HOLD.

That test has an additional important limit: **path-based file permissions do not revoke existing writable file descriptors**. A privileged process can intentionally or accidentally delegate a descriptor (through inheritance or descriptor transfer) to an unprivileged actor. Once obtained, that actor need not be able to open the path itself.

The actual test check_ir136_inherited_fd.py reproduces the distinction in a disposable Linux runner, using the **same** root-owned serializing broker from IR-135 and an isolated temporary 0600 file under a 0700 directory:

1. Root opens a writable descriptor to the effect file before HOLD.
2. The actual broker acknowledges HOLD; further broker application is refused.
3. A separate child whose UID/GID are dropped to nobody still cannot open the file *by its path*.
4. The privileged parent explicitly delegates the pre-opened descriptor across exec (using pass_fds). The unprivileged child writes and fsyncs on that descriptor *after the broker acknowledged HOLD*. The effect file changes.
5. The parent closes its own descriptor. A second independent unprivileged child with NO descriptor cannot open the file and cannot modify it.

This is a real, replayable **capability-leakage counterexample**, not an independently installed physical-protection demonstration. The root actor is deliberately cooperating in delegating the FD; therefore it is **not a contradiction** of IR-135's conditional assertion that no relevant privileged actor bypasses the broker. It reveals what that trusted-actor inventory must rule out.

The test does not execute in the user's filesystem, deploy agents, or write anywhere outside a disposable temporary directory. It requires a root-enabled Linux CI runner.

## Formal source-level join: channels, not UID alone

New Lean module: PhysicalBridges/IR136DescriptorCapabilityCut.lean. It defines three explicitly separate ways a principal can effect the specified file output:

- direct path access;
- an existing writable descriptor/capability;
- a permitted broker application.

Theorem denied_iff_all_channels_denied characterizes denial within this **declared three-channel model**. Theorem actual_effect_denied_under_complete_channel_cut proves a true physical write impossible only under an externally warranted correspondence from **every** independently defined actual write to one of these channels, together with denial of all three for the actor/state.

Theorem post_hold_path_denial_allows_delegated_fd is the exact logical counterexample: post-HOLD path and broker permissions are absent, but a delegated FD still permits output in this model. Theorem revoked_path_does_not_revoke_existing_fd establishes that revoking path access alone does not remove an independently persisting descriptor capability.

These are logical facts about declared relations, NOT claims that the three categories exhaust the actual universe, that all Linux kernel capabilities are captured, or that the system already satisfies the physical-source join. The Linux challenge supplies a separate bounded empirical illustration; it is not an independent experimental confirmation of BCRD or original-X3 semantics.

## Load-bearing design decision

A later commissioned effect boundary must prove at least one of:

- no pre-open writable descriptor/capability exists outside the intended effect authority at HOLD;
- such descriptors are actively and independently revoked/fenced at a lower boundary, including all copied/forwarded capabilities;
- the trusted-computing-base inventory includes every actor holding them, with a separately verified effect gate for those actors.

Merely changing a file mode, revoking an actor's UID privileges, closing a broker's admission gate, or logging a HOLD ACK does **not** close this particular obligation.

Necessary challenges include inherited descriptors, SCM_RIGHTS delegation, dup/dup2, fork/exec, leaked handles into containers/namespaces, pre-open device descriptors, memory-mapped writes, alternate hard links and privileged root-equivalent processes. The current test covers only the explicit inherited-FD route, not those additional mechanisms. Independent real source coverage, calibrated physical residuals, full actuator inventory, subject semantics and global X3 remain OPEN.

## Reproduction and acceptance

Run the pinned Lean 4.35 CI through the PhysicalBridges root, and the isolated OS test:

    sudo -n python3 evidence/physical-bridges/check_ir136_inherited_fd.py

CI workflow .github/workflows/ir136-inherited-fd.yml runs only in disposable Linux; the IR136 claim-integrity gate refuses promotion to completed physical no-bypass.

**Expected truthful outcome**: path DAC denies new opens, broker HOLD denies new broker writes, inherited writable FD bypasses that HOLD, and no-delegation control leaves the file unchanged. This is a negative result for the broader protection claim, and a positive demonstration of a precise attack surface.

No original X3 weakening, canonical manuscript edit, publication, founding, commissioning or PR merge.
