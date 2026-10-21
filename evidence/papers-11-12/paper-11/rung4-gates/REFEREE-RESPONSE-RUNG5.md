# Response to the blind referee on §0B (rung 5), 20 Oct 2026

The referee was a Claude subagent working blind, given no author self-assessment. It raised 16 findings: 2
critical, 8 major and 6 minor. All 16 are answered in v0.17.12.

| # | Severity | Finding | Response |
|---|---|---|---|
| 1 | critical | "No premise about minds" overstates: the capability caps bound minds' coordinated physical action, and rungs 1–3 relocated premises rather than removing them | **Fixed.** The claim now reads: no premise about values or beliefs, and none about command-level choices. Bounds on coordinated physical action are listed as still about minds. "Removed" is now "relocated". |
| 2 | critical | "Every population" conflicts with the C2 share, the identity declaration and P-TRAJECTORY | **Fixed.** C2 holds while the share is ≤ 3.05% (register item 32). The identity declaration and P-TRAJECTORY's population part are listed as still about minds. |
| 3 | major | The grid row r also sets μ, d and ZLAW, not only pc | **Fixed.** The grid laws are declared (register item 29). The referee's positive check is cited: pc = 499/500 at each row's (μ, d) leaves every row at or below the worst total. "Worst grid case" wording is removed. |
| 4 | major | pc ≥ 0.998 was asserted | **Fixed.** New premise P-ROUTES applies P-FAULT's subset law to provider-role non-service, which is enough for the Chernoff form. |
| 5 | major | D-ENDOW mixed a design rule with factual claims | **Fixed.** It is split into D-ENDOW (design), P-ENDOW (energy, maintenance and replacement to T_end) and P-ROUTES (exhaustiveness). |
| 6 | major | P-PROV's non-adaptivity is not a physical cap | **Fixed.** Listed as an open obligation in "Not claimed". |
| 7 | major | Inherited premises missing | **Fixed.** §0B now lists and classifies all of them. The register adds items 26–32. |
| 8 | major | The floor's existence is declared, not law-like | **Fixed.** Now "if π_B > 0 (declared)", in the paper and the companion. |
| 9 | major | The register misdescribed M2's role | **Fixed.** Item 13 now names the grid, and the title is updated. |
| 10 | minor | M2 still gates the code in three places | **Recorded** in RUNG5-NOTE, "Where M2 entered the code". |
| 11 | minor | The two readings are not independent checks; holding is at its floor | **Fixed** in §0B fact 2. |
| 12 | minor | The k = 2 extension was not stated | **Fixed.** The same 10-row structure is noted. |
| 13 | minor | The second 10⁻⁷ reserve was omitted | **Fixed.** The residual risk lists the floor, the reserve and the remainder. |
| 14 | minor | Calling a conclusion a premise | **Fixed.** M2 and KA, KA′, D-T\* are premises; conclusions 3 and 7 are addressed to minds. |
| 15 | major | Companion overclaims | **Fixed.** Endowment is conditional. "Secret islands" is now "other islands". The floor is conditional on π_B. Direct runs are marked. The threat sentence is reworded. |
| 16 | minor | The "said plainly" list was incomplete | **Fixed.** It now points to the full §0B list. |

**Still open:**
- P-PROV's non-adaptivity;
- the reducibility table (human review);
- P-ENDOW supply.

**Update:** the rung-5 checks are now banked as `check_rung5.py` (6/6, byte-identical), including each row's exact ledger change at pc = 499/500.
