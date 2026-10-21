# Response to the independent referee (20 Oct 2026)

The referee was a Claude subagent working blind: no self-review, no sealed key. It reviewed §0A, RUNG4-THEOREM.md
and check_gates.py, and reran the checker (58/58, byte-identical). It raised 8 findings: 2 major, 6 minor. All 8
are addressed below. The checker now passes 68/68, and `run_all.py` passes 105/105 across five checkers.

| # | Severity | Finding | Response |
|---|---|---|---|
| 1 | major | The 58 checks did not cover conclusions 1 (margins) or 5 (risk) | **Fixed.** New checks C1 and C5 recompute every margin fraction and the union bound from the screen's raw fields. R_k3 is the worst of all 10 ledger rows. The TW-1 side is inherited from frozen JW2.6, and that is now stated. |
| 2 | major | The union bound applies the mature k = 3 risk to founding and growth, which §3 describes as small pools | **Fixed.** New premise **P-FULLPOOL:** every pre-twilight phase runs complete 400-island k = 3 pools (Codex's full-pool route). §3 now says §0A does not use its small-seed schedule. |
| 3 | minor | "Energy 11.43 against 0.196" cannot be traced to the cited file | **Fixed.** The file's own fractions are quoted (0.00941 against 0.000168), with the raw figures attributed to their source. |
| 4 | minor | The G6.4 label overclaimed | **Fixed.** Renamed: it checks steady k = 3 memory, and the overlap peak is argued in G6, not computed. |
| 5 | minor | Two checks were tautologies | **Fixed.** The no-exclusion control is now a genuine perturbation (each lost host fails twice: 57,510 > 50,688). A.2 now checks a real inequality: evacuated minds fit the survivors' exile slots (3,096 ≤ 3,176), with a control at 7 slots. |
| 6 | minor | Admitted is not the same as completed: the last installs could land at 32 + 1/1024 | **Fixed.** New check G1.3b reserves the final timeout quantum (64 slots). The spare is still 50,624 ≥ 28,755. |
| 7 | minor | SR-2's "any offsets" was argued, not tested | **Fixed.** All 242 offset pairs for two groups are enumerated (at most 10 starts per index). Four groups are bounded by summation (at most 20). |
| 8 | minor | "4,288 certificates" should be 4,228 | **Clarified.** The committee account is recomputed at the 4,288 work cap (`CERT_LIMIT`). The 4,228 inventory fits that cap (G4.5). Both are now stated. |

**Calibration.** Scored against the author's sealed key `work/calibration-rung4` (10 expected seams), the
referee touched about 1.5: finding 7 partly overlaps R4-4, and it noted the tight endpoint margin from R4-8. It
also found 6 seams that were not in the key, including the most important one (finding 2). The author key was
the weaker instrument here, and the independent review earned its cost.
