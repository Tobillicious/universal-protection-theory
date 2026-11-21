# Lean ↔ Isabelle correspondence ledger

**Status:** provisional; no successful Isabelle build receipt yet. Never interpret this ledger as a proof of equivalence without checking exact statements.

| Scope | Lean | Isabelle/HOL | Match status | Verification |
|---|---|---|---|---|
| Pair-averaging / coarse concentration | `research/lean/KoruThermoQuadratic.lean:coarse_concentration_le` (rationals) | `research/isabelle/Koru_Thermo_Quadratic.thy:coarse_concentration_le` (reals) | Same polynomial inequality, **different domains** | Isabelle pending |
| Coarse quadratic entropy | `coarse_quadratic_entropy_ge` (rationals) | `coarse_quadratic_entropy_ge` (reals) | Same algebraic form; domain differs | Isabelle pending |
| Cyclic quadratic entropy | `cyclic_quadratic_entropy_invariant` (rationals) | `cyclic_quadratic_entropy_invariant` (reals) | Same polynomial form; domain differs | Isabelle pending |
| Four-state Gibbs/Shannon numerical witness | `research/check_koru_four_state_entropy.py` | Not formalized | Numerical example only | Isabelle not started |
| General finite Gibbs entropy | Not yet established in this branch | Not yet established | Open | Open |
| Physical matterspacetime bridge | Not established by this pilot | Not established | Open | Open |
| Original six X3 / Hillary join | Canonical Lean files elsewhere | Not yet ported | Open | Open |

## Verification gate

- [ ] Record Isabelle version and successful build SHA/log.
- [ ] Record Lean pinned version and successful build SHA/log for research files.
- [ ] Audit theorems' definitions, premises, domains, quantifier scope, and conclusions.
- [ ] Confirm no `sorry`/axiomatic shortcuts or unsupported physical claim promotion.
- [ ] Extend to general Gibbs entropy only after this pilot is checked.

## Build

```sh
isabelle build -D research/isabelle -v
```

GitHub Actions workflow: `.github/workflows/isabelle-pilot.yml`.
