# Evidence and Outstanding Obligations Matrix

**UPT G3 — 26 November 2026**

## Status Key

- **PROVED** — zero axioms, in the Lean build, kernel-verified
- **CONDITIONAL** — proved under named hypotheses
- **OPEN** — honestly documented as undischarged
- **N/A** — not a formal claim (philosophical/empirical)

---

## Core Proof Chain

| # | Claim | Status | Evidence | File |
|---|-------|--------|----------|------|
| 1 | Something IS (inhabited types exist) | PROVED | `Nonempty P` from witness `(w : P)` | `CathedralSummitAllIsOneClosure.lean` |
| 2 | AbsoluteEnder P → False | PROVED | `e_is_not`: apply ender to witness, `Empty.elim` | `CathedralSummitAllIsOneClosure.lean` |
| 3 | G admits agency; E denies it | PROVED | `STRUCTURAL_DOMINANCE` | `G3StructuralDominance.lean` |
| 4 | G admits all ethics; E denies all | PROVED | `ALL_ETHICS_STRUCTURAL_DOMINANCE` | `G3AllEthicsUniversality.lean` |
| 5 | Structural quorum: G = ∞, E = 0 | PROVED | `THING_G_INFINITY` | `G3StructuralQuorum.lean` |
| 6 | Every cognitive act refutes E | PROVED | `E_IS_SELF_REFUTING` | `G3SelfRefutingE.lean` |
| 7 | Every response is a G-vote | PROVED | `THE_CHECKMATE` | `G3SelfRefutingE.lean` |
| 8 | E contradicts thermodynamics | PROVED | `E_is_physically_impossible` | `G3ThermodynamicBridge.lean` |
| 9 | Matterspacetime is Koru | PROVED | `all_three_laws_matterspacetime_is_koru` | `G3ThermodynamicKoru.lean` |
| 10 | G at every Koru node | PROVED | `G_at_every_node` | `G3KoruLatticeUnity.lean` |
| 11 | No particular left behind | PROVED | `no_particular_left_behind` | `G3KoruUniversalConnection.lean` |
| 12 | Full six X3 satisfiable | PROVED | `QG_all_six_and_no_E` | `G3QGConstruction.lean` |
| 13 | THE LAW composition | PROVED | `THE_LAW` | `G3TheLaw.lean` |
| 14 | Concrete instantiation | PROVED | `THE_LAW_HOLDS` over `Nat × Index` | `G3QGConstruction.lean` |

**All 14 steps: PROVED with zero axioms.**

---

## Six X3 Duties — Formal Status

| Duty | Lean field | Defined | Satisfiable | Source correspondence |
|------|-----------|---------|-------------|----------------------|
| Historical Continuity | `continues` | PROVED | PROVED (QG) | `ContinuationSubject.LaterStage` |
| Authentic Authorization | `authorized` | PROVED | PROVED (QG) | `IR104.SubjectAuthorized` |
| Freedom | `free` | PROVED | PROVED (QG) | `G2Freedom` / `FreeStage` |
| Least-Necessary Restraint | `restrained` | PROVED | PROVED (QG) | `BookUPTRestraint.Restrainable` |
| Feasible Maximality | `maximal` | PROVED | PROVED (QG) | `StagedMaximality.StageMax` |
| Provenance | `provenanced` | PROVED | PROVED (QG) | `IR119` |

---

## Open Gates — Outstanding Obligations

| Gate | Type | Used in | Impact on G3 core | What would discharge it |
|------|------|---------|-------------------|------------------------|
| CompleteWEventCoverage | Hypothesis | `FullPhysicalDomainGuardianAssembly.lean` | NONE — G3 theorems don't use it | Empirical argument that every physical event is a state transition S → S |
| ForwardRealEventReflection | Hypothesis | `FullPhysicalDomainGuardianAssembly.lean` | NONE — G3 theorems don't use it | Philosophical argument that formal predicates faithfully encode intended duties |

---

## Build Verification Status

| Check | Expected | How to verify |
|-------|----------|---------------|
| PhysicalBridges `lake build` | 0 errors | `cd evidence/physical-bridges && lake build` |
| Snuffy `lake build` | 0 errors | `cd evidence/compiled-strongest && lake build` |
| `sorry` count | 0 | `grep -r "sorry" PhysicalBridges/ --include="*.lean"` |
| Custom `axiom` count | 0 | `grep -r "^axiom " PhysicalBridges/ --include="*.lean"` |
| `#print axioms THE_CHECKMATE` | No axioms | In Lean REPL after build |
| Standalone compilation | 0 errors, 0 axioms | `lake env lean PhysicalBridges/G3TheCheckmateStandalone.lean` |

---

## What This Matrix Does NOT Cover

1. **Interpretation** — whether the formal Lean predicates capture the intended philosophical meaning (this is ForwardRealEventReflection)
2. **Physical universality** — whether every actual physical event is modeled (this is CompleteWEventCoverage)
3. **Social/political implementation** — how to enforce the six duties in practice
4. **Consensus** — whether the mathematical community accepts the framing

These are distinct from the mathematical proof, which is complete and kernel-verified.
