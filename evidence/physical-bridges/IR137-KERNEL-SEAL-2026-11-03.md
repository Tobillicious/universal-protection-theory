# IR-137 — Kernel-sealed object versus actual physical-effect authority

Date: 3 November 2026. Status: conditional Lean theorem + isolated Linux kernel tests. **NOT** a complete physical X3 result, installed hardware or persistent filesystem proof.
Stack: #235 → #233 → #230 → #229 → #227.

## Coordination with concurrent model work

The concurrent BDL warm-start PRs #228, #231, #232 and #234 report a coarse-shadow projection, a missing §7 degree-2 geometric block quotient, measured source-cell code distance, and an amended closed-membrane minimum weight. The M3 3D geometric hull still needs reconciliation; this PR does not duplicate that lane or infer it is complete.

## The positive, bounded mechanism

Linux memfd_create with MFD_ALLOW_SEALING can create one anonymous volatile memory-file object whose bytes are frozen by adding F_SEAL_WRITE, F_SEAL_SHRINK, F_SEAL_GROW and F_SEAL_SEAL. This differs from discretionary permissions: when the strong write seal has actually been installed, even a previously opened writable descriptor can no longer modify the **identified memfd**.

The source Linux manual warns of two crucial failure modes. A preexisting MAP_SHARED writable mapping prevents installing F_SEAL_WRITE (EBUSY). The weaker F_SEAL_FUTURE_WRITE may be installed while such a mapping exists, but it permits that OLD mapping to keep modifying the contents. Reference: https://man7.org/linux/man-pages/man2/memfd_create.2.html and https://man7.org/linux/man-pages/man2/F_GET_SEALS.2const.html .

## Actual temporary Linux OS test

The test evidence/physical-bridges/check_ir137_kernel_seals.py runs in disposable Ubuntu CI under root, using only anonymous in-memory objects:

1. Create a memfd, write the initial data, and pass an already writable descriptor to an unprivileged child. Verify the child really CAN write before sealing.
2. Install and read back the four strong seals. Compute SHA-256 of the exact identified object bytes.
3. Challenge the original inherited descriptor after sealing in separate root and unprivileged child processes. Verify write, pwrite, truncate and new shared writable mmap are all denied; bytes and digest stay identical.
4. Create another memfd with an existing writable shared mapping: F_SEAL_WRITE must refuse installation, F_SEAL_FUTURE_WRITE must permit the old mapping to write, and after unmapping the stronger seal becomes installable.
5. Create a third, distinct output memfd to demonstrate that privileged actors can substitute another object **without modifying the original sealed object at all**.

The strong-seal test protects the **one actual memfd object** from the specified syscall attempts. It does not constrain external files, alternate memfds, devices, kernel compromise, outputs or the physical universe. The seal installation is the tested object's local kernel linearization point; there is no claim of global distributed HOLD ACK.

## Conditional Lean theorem

The module PhysicalBridges.IR137KernelSealedObject uses an independently specified real-step relation, selected output-object identity, object bytes, external effect readout and sealed-state predicate. Its contract requires four separately verified assumptions:

- Strong seal persists for all real steps.
- The identified strongly sealed object's content is preserved for all real steps.
- The actual relevant effect output remains bound to the same authenticated object; no object substitution.
- The actual physical effect readout is faithfully represented by that object's measured content.

The one-step theorem and its finite-trace induction then derive constant effect readout along the actual trace. These premises are **not** proved for real BCRD or arbitrary installations.

The explicit negative theorems show that a sealed original object can coexist with substituted output object and a changed effect; they also separate the weaker future-write seal from revocation of old shared mappings. The actual kernel test independently challenges these cases.

## Remaining physical join

The current next external obligations are: authentic final-effect object identity and no replacement, full writable mapping/descriptor inventory, every hardware/OS/external actuator and side effect, independently calibrated effect residuals and source correspondence, subject continuation and original X3 feasible-rival semantics, infinite history and resource commitments, and complete source-compliant 3D quantum warm start. All remain OPEN.

The companion fail-closed ledger audits claims and negative controls; it does not authenticate physical evidence. No X3 change, canonical manuscript edit, commissioning, publication, founder agreement, or merge.
