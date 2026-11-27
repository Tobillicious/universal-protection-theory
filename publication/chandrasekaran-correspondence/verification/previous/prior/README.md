# G3 null-cone bridge: reproducibility package (27 November 2026)

Author-review research supplement, not a verified physical G3 certificate.

Source inspected: https://github.com/Tobillicious/universal-protection-theory/tree/a3d205d4e66bd66a0528181b3089342ac293225d

- `publication/UPT-GLOSSARY.tex` (blob 3283795b4600cedc4025be3468b0f50c580dea16): v5.7 identifier and project-reported counts.
- `REPLAY.md` (fb3b59766c39381b5ac64ccfb37b369e42873e85): conditional assembly and semantic gate.
- `G3PreQGComplete.lean` (369ee6360410861a9708c18e57b83982ebb65d07): exact `BCRDIsQG` interface and conditional theorem.
- `G3TheLaw.lean` (c2773eb5aa2eaf9db6bae99b6eec89e0963df542): full assembly.
- `G3QGConstruction.lean` (569a739ae18d08adee7309deec6a95699d5c10bf): Nat/Index satisfying model, explicitly not empirical identification.
- `G3QGInterpretationNecessity.lean` (59d46f683c56fc68a65835c3e423b6d2141572cb): same-physics opposite-authorization interpretations.
- `G3ThermodynamicBridge.lean` (eebb1b686de0490d15eaabc3007a83e9c7e37215): cyclic-genesis model with assumed nonterminal dynamics.

All Lean paths are under `evidence/physical-bridges/PhysicalBridges/`. Source read, not rebuilt; v5.7 deposited archive not downloaded. Chandrasekaran arXiv:2611.34924v1 sections 4.2, 4.4 and C.1 were consulted.

## Reproduce
1. `python3 check_finite.py` (executed here; output in finite_check.txt).
2. `lean NullConeBridge.lean` with Lean 4 (not installed in this environment; source awaiting replay).
3. In the pinned repository, `cd evidence/physical-bridges; lake build`; copy `UPTIntegration.lean` to that directory, `lake env lean UPTIntegration.lean` (not executed here).
4. Open `G3Boundary.mch` and `G3BoundaryMutant.mch` separately in ProB, run exhaustive invariant checking with no state/transition bound. Ensure all 64 parameter values of Stage are enumerated; inspect operation coverage and deadlocks. Expected: safe invariant holds, mutant violates it after staging all but authorization then committing. ProB is not installed; actual ProB results remain outstanding. Python checks the specified finite transition abstraction, not the B parser or ProB implementation.

The safe guard illustrates how a finite monitor can enforce a six-field receipt policy; it neither establishes that the receipts are authentic nor that physics enforces that policy. HOLD is always enabled, so absence of deadlock here does not prove physical time continuation or liveness of commits.
