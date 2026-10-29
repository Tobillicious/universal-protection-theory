# IR-142 — Separate guardian and resident OS principals (real patched sink)

**29 October 2026, draft. Original X3 unchanged.** Stacked on [IR-141 PR #181](https://github.com/Tobillicious/universal-protection-theory/pull/181), parent 6b0e256a1a3bab604fc12c5683550528843fd03d. No published book or canon changed.

## Concrete result

IR-141 fixed the software sink's HOLD/check/commit race under a cooperative POSIX flock; the earlier process-sharing-filesystem demonstration still left the resident free to alter the flag, lock, log or socket. IR-142 tests one *genuine OS-enforced isolation step* against the **actual patched reference-runtime/sink.py** on Linux. It changes no installed hardware and creates no canonical proof.

- A guardian-owned temp directory is mode 0755 (resident may traverse, not change entries).
- The guardian process runs at an otherwise unused numeric UID and GID with a 0077 umask. Its sink.log is mode 0600. It retains the HOLD file and hold.lock. The guardian controls hold transitions via common.set_hold as its own OS identity.
- A different UID/GID (without supplementary groups) runs the attacker/client process. The **only** deliberately public resource inside that directory is the actual sink's Unix-domain request socket, set to mode 0666 by the privileged test launcher after the guardian creates it.
- The guardian server uses the unchanged IR-141 critical section for HOLD check and final log commit.
- Linux tests substitute os.fsync for Mac-only F_FULLFSYNC inside a **test-only Python launcher**; production common.py is not rewritten and Mac semantics are not inferred.

## Exact controls, visible failures

The script launches these different effective OS identities and tests:

| Action from untrusted UID | Expected |
|---|---|
| Deliver effect 0 through public socket before hold | Accepted, guardian writes |
| Guardian raises hold; deliver effect 1 through socket | Refused; held=True |
| Truncate guardian sink log | Kernel permission denied |
| Append to guardian sink log | Kernel permission denied |
| Truncate guardian HOLD file | Kernel permission denied |
| Unlink guardian HOLD file | Kernel permission denied |
| Unlink or rename guarded lock inode | Both kernel permission denied |
| Unlink the guardian-owned public socket | Kernel permission denied |
| Change sink log mode or add direct file inside guardian directory | Both kernel permission denied |
| Guardian releases hold, resident delivers effect 1 | Accepted |
| Resident submits **arbitrary forged** ID/value while not held | **Accepted: authorization still absent** |
| Resident creates an independent IPv4 UDP socket | **Succeeds: other physical channels not confined** |

The nine filesystem permission denials establish a meaningful OS isolation fact: subject to Linux's normal DAC semantics, without escalated capabilities or guardian control, an unrelated unprivileged process cannot alter guardian-owned files or remove the guardian's socket entry. This is narrower than hostile-process containment across a whole host.

### Replay

From an appropriate disposable Linux host with root needed *only to assign separate UIDs*:

    sudo python3 -B evidence/compiled-strongest/installation/pilot/linux_os_principals.py

An automatic Ubuntu CI workflow runs the same test without creating persistent users. Local Linux test: **PASS** (9/9 file tampering attempts denied, held sink effect refused, resume works, arbitrary payload and independently open network socket both succeed as explicitly expected). GitHub Actions results must be assessed separately from this local report.

## What has *not* been proved

1. **Full existing resident runtime is not yet separated.** The original resident.py currently writes a journal and takes hold_guard() itself; that client must be refactored to use guardian-owned journal/permit/effect services before the full crash-recovery harness can run in the untrusted UID. IR-142 runs a separate-UID request client against the actual protected sink; it does NOT falsely report an end-to-end multi-principal resident.py installation.
2. **Authentic authorization remains unproved.** The sink accepts arbitrary IDs/values when HOLD is clear. A credentialled broker must verify subject identity, legitimate direction, idempotent sequence and policy before final effects; the authorized principal may not be synonymous with a socket client.
3. **Whole-system output containment remains unproved.** A process can open another network socket or write to other host resources, and computation itself has heat, power and side effects. DAC alone cannot provide a physical total-output inventory or a universal harm threshold. Stronger network namespaces, syscall policies, hardware fencing, and independently instrumented emission boundaries require separate evidence.
4. **Other hostile capabilities:** If the resident inherits privilege, has ACL/group access, can exploit guardian/server code, can starve the public socket, can access an alternate output, or can relabel a process as itself, this test does not stop it. The privileged launcher and root OS are trusted; kernel correctness and guardian code are premises.
5. **Timing and availability:** Delayed hold ACK is still possible while an accepted effect commits; no bounded deadline is inferred. Test success does not imply fairness, noncoercion, continuing physical subject identity, complete harm prevention, or maximal original X3.
6. **Formal refinement:** No Lean theorem yet proves that the Linux kernel semantics, Python code, guardian authority, observed transitions and complete physical system satisfy the original UPTFence/X3 premises. That is a new proof obligation, not a reason to weaken X3.

### Next engineering join

Split the *full* resident/monitor/journal/sink runtime into separately permissioned compartments, with a guardian-only journal and controller, authenticated requests, protected output routes and intentional fault-injection tests. Keep an untrusted client unable to change HOLD or spoof subject authorization, while preserving actual replay semantics. After that, assess bounded latency and perform independent channel-completeness testing and original X3 composition.

**Disposition:** real, reproducible Linux DAC boundary for **one** sink endpoint. Preserve both explicit negative controls. Do not merge, publish, or promote to physical/universal protection without independent review.
