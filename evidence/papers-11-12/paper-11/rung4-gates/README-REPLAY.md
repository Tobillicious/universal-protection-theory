# Replaying the rung-4 and rung-5 evidence

Requirements: Python 3 (standard library only). Exact rational arithmetic throughout.

```
cd rung4-gates
python3 -B run_all.py
```

Expected final line: `{"checkers": 8, "all_pass": true, "checks": 140}`. Each checker's output must match its
recorded `.out` file byte for byte. Every control must fail its perturbed inequality, which counts as a pass for the
control.

| Checker | Checks | Covers |
|---|---:|---|
| `check_gates.py` | 68 | Rung-4 lemmas G1–G6 and G3, the 21-account table, conclusions 1 and 5 |
| `check_0b_k3.py` | 18 | The island cap from site-level primitives |
| `check_c2.py` | 8 | C2 by seven replicas |
| `check_followups.py` | 12 | C2 transition, P-START reduction, stream resumption, D-GATE |
| `check_floor.py` | 9 | Floor sub-allowances, exact π_B consistency |
| `check_c2_screen.py` | 7 | C2 resource re-screen on the frozen k = 3 model (3.05%) |
| `check_rung 5.py` | 6 | Rung 5: grid coverage, monotone rescue, each row's ledger total at pc = 499/500 |
| `check_physical.py` | 12 | Physical facts: Landauer, fibre delay, P-LAT on Earth scale, P-FAULT at measured failure rates |

**Frozen inputs.** `frozen/upt-rung4a/` is a byte-identical copy of Codex's `upt-rung4a` bank (20 Oct 2026). Verify
it with `cd frozen/upt-rung4a && shasum -a 256 -c SHA256SUMS`, which checks 529 files. The checkers read it
read-only. `check_c2_screen.py` applies one documented in-memory patch to its `k3_screen.py` and never writes to it.

**Relocation test (20 Oct 2026, repeated after `check_rung 5.py` was added).** The package was copied to a fresh
folder and run with every original source blocked by the operating system's sandbox. All 126 checks passed, and every
output matched its recorded copy.

**Scope.** These checks verify the stated inequalities and arithmetic under the declared premises. They do not show
that the premises hold in our world. See `ASSUMPTIONS-REGISTER.md`.

## Focused independent rung 5 audit (21 October 2026)

The140 checks above remain unchanged in count. From the release root, `python3 -B checks/rung5_dependency_check.py` independently reconstructs all 21 accounts, tests both error laws, exercises arbitrary valuation/disutility changes and rejects five stronger false claims. `reproduce.py` runs it and those controls automatically. RUNG5-AUDIT.md gives the current8.4e-7 mixed-law schedule ceiling and8.8e-7 ceiling with the C2 timing allowance charged per phase. RUNG5-DEPENDENCIES.md is the current complete selected-account/premise classification. Numerical source fixtures are not physical certifications.
