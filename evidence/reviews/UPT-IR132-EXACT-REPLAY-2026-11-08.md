# IR132 exact boundary-code replay

8 November 2026. Source pin: `7c4eb625bce58739ce19c891cc89eb63a92ebe84`.

Read the complete [checker](../physical-bridges/checks/ir132_exact_boundary_code.py), then ran it unmodified with Python 3. Exit code 0; all assertions passed. This is exact Fraction-based finite matrix arithmetic, not a fresh Lean replay or physical deployment experiment.

For its fixed-ancilla isometry V, all four logical 2-by-2 matrix units satisfy boundary intertwining and exact compression/recovery. The environment matrix units compress to scalar multiples of identity. Linearity extends these matrix-unit identities to their linear spans. In a DIFFERENT encoding W, the logical bit resides in the environment while the boundary is fixed: two distinct encoded basis densities have identical boundary matrix-unit expectations. This is an encoding-dependent comparison, not an assertion that complete BCRD boundary access is insufficient.

The checker also verifies Kraus completeness and the actual output of a trace-preserving reset channel: I/2 maps to |0><0|. The displayed entropy values ln(2), zero, and relative entropy ln(2) follow analytically from those diagonal states; the script does not numerically calculate logarithms. A subsystem CPTP reset is not whole-universe unitary erasure, and this calculation alone does not violate a globally accounted thermodynamic law.

The PNAJ section checks the error lower bound 1/2 at FIVE specified rational estimates and verifies attainment at 1/2. Despite its printed minimax label, it does not mechanically enumerate all possible estimates. The general two-judgment lower bound follows separately from 1 <= |a| + |1-a| <= 2 max(|a|,|1-a|), under the stated common-accessible-datum condition. It is not a universal gap theorem for arbitrary richer access or different judgments.

Executed output:

```text
PASS IR132 exact logical/boundary matrix units and isometric code
PASS IR132 non-reconstructible bulk bit under fixed boundary data
PASS IR132 trace-preserving reset: relative entropy ln2 > 0, entropy change -ln2 < 0
PASS IR132 conditional PNAJ minimax gap 1/2 on indistinguishable inputs
```

Merge status checked before this addendum: PR #418 clean and mergeable, base unchanged, three added review documents only. The then-current head had zero check runs. Both inspected repository workflows exclude evidence/reviews/** in their path filters. Hence no exact-head CI success was claimed and no merge was performed under the repository instruction requiring exact-head CI. No theorem or workflow changed.
