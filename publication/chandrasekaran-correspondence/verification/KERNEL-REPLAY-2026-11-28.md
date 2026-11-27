# Lean kernel replay — 28 November 2026

## GuardianContinuation.lean — standalone greatest fixed-point module

**Toolchain:** Lean 4.35.0 (leanprover/lean4:v4.35.0)
**Build command:** `lean GuardianContinuation.lean`
**Result:** All four theorems compiled successfully.

| Theorem | Axioms | Status |
|---------|--------|--------|
| `guardian_fixed` | none | G = F(G) proved |
| `guardian_greatest` | none | G is the unique greatest fixed predicate |
| `safe_successor` | none | Every G-state has a successor in G |
| `no_common_output` | none | Injective maps cannot collapse distinct states |

## G3ExpandedGenesisBridge.lean — expanded genesis module

**Toolchain:** Lean 4.35.0
**Build command:** `lake build PhysicalBridges.G3ExpandedGenesisBridge`
**Result:** 188 jobs built, zero sorry.

| Theorem | Axioms | Status |
|---------|--------|--------|
| `no_collapse_under_injection` | none | Injective evolution cannot erase distinctions |
| `no_common_centre` | none | Distinct inputs cannot converge to same output |
| `EXPANDED_GENESIS` | propext, Quot.sound | Injectivity + handedness + epoch advancement |
| `COLLAPSE_REFUTED` | propext, Quot.sound | Distinct states never merge through genesis |
| `INFINITE_ENRICHMENT` | propext, Quot.sound | All predicates recoverable at every stage |
| `G_IS_EXPANDED_E_IS_COLLAPSED` | propext, Quot.sound | Ender self-refutes; genesis preserves all |

## Full project build

**Build command:** `lake build`
**Result:** 497 jobs, zero sorry.

No regressions. All existing theorems pass. The new module integrates cleanly.
