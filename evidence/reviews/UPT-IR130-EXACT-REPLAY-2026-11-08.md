# IR130 exact sector-channel replay

8 November 2026. Pinned source: `7c4eb625bce58739ce19c891cc89eb63a92ebe84`.

Read the complete [ir130_exact_sector_channels.py](../physical-bridges/checks/ir130_exact_sector_channels.py), then ran the unmodified checker with Python 3. Exit code 0; every assertion passed. All matrix arithmetic uses Fraction, with no floating-point tolerance. This is a finite matrix replay, not fresh Lean compilation or certification of physical boundary access or subject semantics.

The three real rational Kraus families satisfy sum K^T K = I: pinching, soft dephasing, and amplitude damping. Their real coefficients make transpose the appropriate adjoint here. The Kraus form supplies complete positivity; the verified completeness identity supplies trace preservation. The tested states are explicitly positive normalized densities: I/6, a basis projector, and an equal coherent pure-state projector.

Exact Tr(delta^2) values on the specified changed inputs are 1/2, 2/25, and 512/625 respectively. These deltas are real symmetric, so this quantity is their squared Hilbert–Schmidt norm. A nonzero value proves matrix inequality and mathematical distinguishability given a suitable observable; it does not establish that the necessary observable is physically boundary-accessible.

Nonidentity pinching and dephasing leave I/6 fixed; dephasing also fixes the active level-2 basis state. Consequently nonidentity of a channel alone does not imply that every input changes. On the active level-2 state, amplitude damping transfers population to level 0 with probability 16/25, leaving 9/25 at level 2; soft dephasing leaves that state's population unchanged. These are distinct channels, not interchangeable implementations of one operation.

Executed output:

```text
PASS IR-130 exact six-dimensional rational CPTP controls
pinching coherent delta^2 = 1/2
soft dephasing coherent delta^2 = 2/25
amplitude damping |2> delta^2 = 512/625
nonidentity pinching and dephasing have fixed valid states
```

This strengthens the executed-check evidence for the earlier source review while retaining its restricted domain. It does not establish authentic six-duty preservation or violation for a living particular, nor a universal singularity claim. No theorem source changed.
