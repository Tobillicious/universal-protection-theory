# Joint assumptions register (v0.17.12)

20 Oct 2026. Claude, author side. This answers open problem 5's first step: one place listing every premise and
warranty the rung-4 theorem rests on. For each, it records what depends on it and how it is carried. "Floor" means
the item sits inside the declared common floor (η_common ≈ 10⁻⁷). The floor is a **sum** over its gaps, so every
floor item must fit inside that one shared allowance.

| # | Item | Kind | Used by | How it is carried |
|---|---|---|---|---|
| 1 | Law: conservation, locality, Landauer, the information limit | physics | everything | Taken as law |
| 2 | P-K3 (≤ 3 islands per pool, ≤ 71 hosts per island, per window) | capability | G1, G2, G4, C2, 0b | Reduced to site-level primitives (`0B-K3.md`) |
| 3 | e_site, s (D-SPREAD), B, r, D, F_other | physical primitives of P-K3 | 0b | Declared; to be measured |
| 4 | P-PROV (≤ 42,800 providers withdrawn, chosen beforehand) | capability | provider accounts | Declared (rung 3) |
| 5 | P-REDRAW (pool membership and route privacy) | design and capability | placement | Declared (rung 3) |
| 6 | P-FAULT (joint site-fault law), with p bound to the 32-date window and timeout misfires included | physical | every loss account | Declared joint all-cause subset law; historical marginal drive-rate arithmetic is an illustration, not certification of P-FAULT (RUNG5-AUDIT.md) |
| 7 | P-LAT (timeout 1/1024 date; slow means crashed) | timing | G1 | Timeout/design contract plus a loss law charging slow attempts; propagation arithmetic does not establish end-to-end service or that joint loss law |
| 8 | P-LOCK (lockstep majority round within the step deadline) | timing | C2 | Declared complete majority-round timing contract, or its separately charged C2 allowance; real implementation evidence required |
| 9 | P-START residual (re-attestation plus planning ≤ 3/4 date) | timing | G1 | Reduced (F2) |
| 10 | P-SWITCH (a safe checkpoint for the switch occurs) | operational | G6, F1 | Declared. Postponing never reduces protection |
| 11 | P-COMMISSION (capital supplied and commissioned before activation) | boundary condition | the whole schedule | Declared. Thermodynamics gives only a floor |
| 12 | P-TRAJECTORY (outside capacity and population support the schedule) | boundary condition | the phase schedule | Declared |
| 13 | M2 (27.9% of minds value the dividend above 15/68) | about minds | provider performance grid (pc, μ), so the holding, rescue and vacancy accounts; and conclusion 3 | **Removed from protection under D-ENDOW + P-ENDOW + P-ROUTES (rung 5)** |
| 14 | C-SEQ (≤ 2³¹/2⁴⁵⁹ per gate per island-date, uniform) | crypto contract | confidentiality and integrity accounts | Its own four ledger accounts (not the floor) |
| 15 | D-GATE (share release uses only the 4 existing gate types) | design rule | account table | **D** relative to the declared 4-step release protocol (F4) |
| 16 | Erasure warranty (retired keys and shares are destroyed) | hardware warranty | G2 composition | Floor; standard practice as a **cryptographic erase** (NIST SP 800-88 Rev. 1, PHYSICAL-FACTS fact 7) |
| 17 | Trusted clocks, retirement and keys survive pause, reboot, rollback and capture | hardware warranty | G2, journals | Floor |
| 18 | Attestation and committed host duty | hardware warranty | G2 authority, care | Floor |
| 19 | J-LIVE and journal contracts | protocol contract | G4 | Floor; quorum arithmetic checked (G4) |
| 20 | Attested certificate validator | protocol contract | certificates | Floor |
| 21 | Full-image checkpoint streams resume at startup (inherited JW2.6) | protocol contract | G1 completion | **D** (F3): the stream budget already covers all 400 islands, and both generations are present by date 32 |
| 22 | Mode C confidentiality | realization contract | confidentiality account | Open (roadmap); within its account |
| 23 | Verified core (spec, hardware below the ISA, proof checker, compiler) | engineering | floor size | Floor: sum of gaps |
| 24 | Identity: each mind declares its criterion | about minds | C2, care | Declared |
| 25 | P-FULLPOOL (pre-twilight phases run complete 400-island k = 3 pools) | schedule | conclusion 5 | Declared (referee finding 2) |

| 26 | D-ENDOW (committed capacity owned by the jurisdiction; attested committed duty) | design | rung 5 | Declared design rule |
| 27 | P-ENDOW (energy, maintenance and replacement supplied to T_end) | boundary condition | rung 5 | Declared |
| 28 | P-ROUTES (a provider role is unavailable only by physical fault or removal) | physical | rung 5 | Declared |
| 29 | Grid laws μ, d, ZLAW (provider vacancy and service laws within the grid range) | physical | rung 5 | Declared joint vacancy/service moment contracts, stated explicitly in RUNG5-AUDIT.md; marginal means or service rates are insufficient |
| 30 | P-AUDIT (cap on compromised islands; integrity warranty) | hardware or capability | journals, audit | Declared (rung 3) |
| 31 | P-NO-DESTRUCTION, J-LIVE, mixed host/job law, placement and freshness | protocol contracts | §0, conclusions 2 and 5 | Declared (rung 3) |
| 32 | C2 share ≤ 3.05% | about minds (population) | §0A conclusion 5 | Declared |

## What the register shows

- **Floor items (16, 17, 18, 19, 20, 23)** all draw on the same 10⁻⁷. C-SEQ (14) has its own ledger accounts.
  Sub-allowances are declared in `check_floor.py` (below).
- **The timing premises (7, 8, 9)** are where physical measurement would most directly firm up the theorem.
- **The boundary conditions (11, 12)** are not engineering gaps. They define the theorem's domain, like initial
  conditions in physics.
- **Two items (21, 22) are inherited or open** rather than declared fresh. They are the realization risk.

## Floor sub-allowances (declared targets, `check_floor.py`)

| Floor item | Sub-allowance over the whole horizon |
|---|---:|
| Verified-core gaps: specification, hardware below the ISA, proof checker, compiler (4 × 1.5×10⁻⁸) | 6×10⁻⁸ |
| Erasure warranty | 1×10⁻⁸ |
| Trusted clocks, retirement and keys | 1×10⁻⁸ |
| Attestation and committed host duty (hardware correctness; attestation crypto is in its own account) | 1×10⁻⁸ |
| Journal implementation and certificate validator | 1×10⁻⁸ |
| **Sum** | **1×10⁻⁷** |

These are **targets**, not measurements. Each warranty must be engineered to fail at most its sub-allowance over
the horizon. The split is a choice, and any split summing to at most 10⁻⁷ keeps the ledger unchanged.
The verified core gets the largest share because it has four gaps, and any one of them suffices to fail. The sum bound needs no independence.

## Current dependency disposition (21 October 2026)

RUNG5-DEPENDENCIES.md now classifies every one of the 21 protection accounts, the reserve, the C2 allowance and all 32 items above. RUNG5-AUDIT.md independently checks the M2-removal step and both error-law choices. Its corrected mixed-host four-phase ceiling is 8.4e-7, or8.8e-7 when the separate C2 timing allowance is charged in each phase. These remain below 1e-6. The original technical source is retained for provenance; obsolete status labels there do not override this current classification. No empirical implementation premise is promoted by arithmetic replay.
