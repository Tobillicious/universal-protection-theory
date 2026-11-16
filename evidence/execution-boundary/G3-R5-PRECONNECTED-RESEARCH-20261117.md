# G3 R5 — preconnected stream / seccomp feasibility experiment

**Find before build.** Existing #600 proves that the confined executor can still contact an unrelated AF_UNIX destination. Existing #601 demonstrates that UID plus JSON response shape does not authenticate the *authority instance*. This additive test explores one possible kernel connection-control building block, without modifying any existing launcher, policy, authority, HOLD, original-six X3 proof, R4 custody file, or protected effect.

## Precise experiment
- Parent deliberately creates a disposable connected AF_UNIX socketpair.
- Child receives exactly the test socket descriptor, installs a Linux seccomp filter denying `socket`, `socketpair`, and `connect` (including x32 ABI denial on x86_64).
- Child confirms all three syscall paths are denied with `EPERM`; bidirectional PING/PONG remains operational on the preconnected descriptor.
- A standalone local Linux run passed 1/1 unittest before this branch was authored. **No exact-head CI has been executed or claimed.**

## What this does NOT establish
This is NOT production G3 and NOT a safe modification to the current fixed executor:
1. **Direct incompatibility:** the existing launcher deliberately uses `pass_fds=()` and a zero-ambient-FD audit. This experiment deliberately passes a connected descriptor. Do not relax those invariants without independent proof of an equivalent stronger invariant.
2. The parent-created socketpair does NOT authenticate the true authority or demonstrate a trusted one-endpoint handoff. An untrusted connector or leaked write FD could create serious violations.
3. The experimental filter blocks only three connection-making calls; it is not the entire existing seccomp, Landlock, FD, source-pinning or syscall policy. Existing file and kernel effect channels are NOT tested here.
4. No authentic rights, human consent, actual-subject semantics, real effect or HOLD linearization is exercised.
5. Off-host custody and rollback resistance (R4) remain separate gates.

## Review-before-repair acceptance gates
- Preserve #601 same-UID fake peer as a hostile control.
- Establish exact authority endpoint identity (not just UID) and trustworthy descriptor provenance.
- Prove that the pre-confinement phase cannot perform unauthorized effects.
- Ensure no inherited writable file descriptor or unintended socket enters the confined executor; audit descriptors by type, identity and peer.
- Deny alternate abstract/pathname AF_UNIX endpoints, and all subsequent `connect` calls.
- Verify authorized actual marker creation, HOLD-first refusal, withdrawal, source/checkout identity, and R4 rollback tests **on one exact integration SHA**.
- Keep this research-only draft unmerged and undeployed until integrated acceptance gates pass.

This is one experimentally supported step toward choosing an R5 design, **not** an unconditional universal-protection theorem.