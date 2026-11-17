# G3 R5 alternative: authority-owned fixed effect (research only)

Status: **isolated draft; not R5 complete mediation and not G3 acceptance**.
Starting point: PR #614 pin-repaired commit `1a3b54fa87253f0a950853f24480cadc90e3f9b9`.
No change to the original-six Lean proofs, authority, HOLD ordering, recovery, or existing syscall-trace gate.

## Why this is a different route

R5 is a property of a defined protected effect boundary, **not a requirement that
strace prove the entire host has no side effects**. The already implemented
`AuthorityOwnedMarkerService` owns the exact synthetic `fixed.marker` target
and the serialized HOLD/effect journal; the dropped-UID client merely requests
one fixed operation. The authority rejects unexpected peer roles and operations.
The minimal client does not accept arbitrary commands, destinations or a
caller-supplied effect callback. Existing DAC separation prevents other fixture
UIDs from directly opening the protected marker path.

This lane makes **bounded, effect-side** positive and negative tests available
independently of the observational syscall-trace qualification step. It does
not remove, override, or claim to replace any existing R5 test.

## Reused existing implementation

- `koru_authority_owned_marker_service.py`: trusted authority, exact fixed
  operation, peer-UID check, and effect-time HOLD.
- `koru_no_inherited_fd_executor.py`: exact fixed request, no inherited FDs,
  peer PID/UID check, Landlock and seccomp confinement. This still uses the
  original kernel security controls; it is **not** a sandbox-less route.
- `koru_fixed_workload_contract.py` and
  `koru_pinned_security_dependencies.py`: fail-closed source and import pinning.
- Existing real disposable-Linux tests: authority-owned effect, unauthorized
  direct write, HOLD-first denial, unknown-operation denial, no duplicate
  effect on restart, SIGKILL before/after effect, same-UID counterfeit peer,
  alternative UNIX destination, and post-connect kernel fence.

The accompanying workflow explicitly runs those tests without `strace`.
A successful result supports the **bounded fixed.marker fixture only**.

## Independent acceptance questions — fail closed

1. **Effect ownership:** Can the configured executor, requester or controller
   produce or alter `fixed.marker` through any path other than the authority?
   Confirm DAC and all tested alternatives; inventory untested paths.
2. **Authority authenticity:** Is the designated authority *instance*
   authenticated, not only a peer with the same UID? Retain the existing
   same-UID fake-peer negative control; observe outcomes independently.
3. **HOLD linearization:** Does HOLD prevent the fixed marker at effect time?
   Preserve authority journal ordering and crash/replay failure controls.
4. **No ambient capability:** Check inherited/open/passed descriptors, IPC,
   alternate sockets, privileged mutation, interpreter imports, and process
   creation. A bounded suite does not establish exhaustive OS-level closure.
5. **External correspondence:** Exact `hCoverage` and six independent
   `hMeaning` premises remain unresolved until authentic real effect/subject
   evidence is supplied; synthetic marker outcomes are not a substitute.
6. **R4/R7:** Independent off-host checkpoint custody, immutable combined-head
   replay, signed receipts and independent review are separate release gates.

## Result interpretation

- **Green alternative workflow:** bounded authority-owned research tests pass;
  do **not** conclude complete mediation or unconditional G3.
- **Red workflow:** inspect exact failing assertions, preserve all negative
  controls, correct only the demonstrated issue on an isolated draft.
- **No accepted substitution:** the pre-existing R5 syscall trace still needs
  completion unless an independent reviewer explicitly accepts a *new
  specified scope and evidence standard* demonstrating complete effect-path
  coverage. Do not waive that requirement by renaming the test.

This is an additional branch of Hume's tree: reuse the root proofs, evaluate
another implementation/evidence route, and leave every unresolved particular
visible.
