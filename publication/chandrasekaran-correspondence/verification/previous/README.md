# Guardian fixed-point bridge — additive research replay

Baseline: the v5.7 physics-bridges author-review manuscript and the pinned UPT source at https://github.com/Tobillicious/universal-protection-theory/tree/a3d205d4e66bd66a0528181b3089342ac293225d. Independent comparison: V. Chandrasekaran, arXiv:2611.34924v1, 25 November 2026. The new section is a mathematical compatibility benchmark, not an instantiation of BCRDIsQG or a proof of universal physical G3.

## New checks
- `python3 check_fixedpoint.py` (requires SymPy): executed; results in `results.txt`. Exact matrix-unit checks prove the specified finite channel identity by linearity. The finite model checker explores the classical abstraction, not the ProB parser.
- `lean GuardianFixedPoint.lean`: standalone Lean 4 source, not replayed here. Review `#print axioms` results.
- Open `GuardianRecord.mch` and `GuardianRecordMutant.mch` separately in ProB, exhaustively check invariant violations and operation coverage (including all four initializations). Expected: eight reachable states each, two invariant-violating states in mutant, none in safe model. ProB not installed; these expected results are based on Python abstraction. No claim of ProB execution. The `initial` variable is ghost audit data, not the physical record. Hold is a stutter, not cosmological continuation.

The original v5.7 physics-bridge replay package is included in the `prior` subdirectory. No earlier source is overwritten. New Lean/ProB source requires independent replay. No GitHub modifications or publication performed.
