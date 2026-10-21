# Assurance register: what each premise rests on

Claude, 22 October 2026, in answer to a referee's request for an assumption-to-evidence register. This file does not
replace `paper-11/rung4-gates/ASSUMPTIONS-REGISTER.md` (numbers 1 to 30 below are its numbers); it adds what kind of
support each item has, and the obligations of the execution boundary, the security protocols, holds and the lottery,
which that register does not list.

**Kinds of support.**
- **PROVED**: a theorem checked in Lean, or an exact program, in this package.
- **REDUCED**: replaced by named, smaller premises, with the reduction proved.
- **CITED**: a standard result from a primary source, used inside its stated model and assumptions.
- **MEASURED**: observed component data. Always an illustration here, never a certificate of a premise.
- **DECLARED**: stated and not established. It is a requirement on a future system.
- **OPEN**: neither established nor yet reduced.

**Scope.** Every probability bound is for one commissioned jurisdiction (pools of 400 islands, at most 10²⁰ islands,
a horizon of at most 10¹⁰⁰ model dates). Bounds compose by the union bound without any independence assumption: M
jurisdictions together fail with probability at most M × 10⁻⁶. A bound for one jurisdiction is never advertised as
one for many.

## The care plant (Paper 11)

| # | Item | Support | Note |
|---|---|---|---|
| 1 | Physical law | taken as law | |
| 2 | P-K3 | REDUCED | to the site primitives in 3 (`0B-K3.md`) |
| 3 | Site primitives (e_site, s, B, r, D, F_other) | DECLARED | to be measured |
| 4 | P-PROV | DECLARED; non-adaptivity PROVED unnecessary | removals may depend on everything (items 1 and 2, Codex); the information and timing condition stays DECLARED |
| 5 | P-REDRAW | DECLARED | |
| 6 | P-FAULT, the joint site-fault law | DECLARED | marginal drive rates are MEASURED illustrations, not the all-cause site law; the admissible date length is PROVED conditionally (`DATE-WINDOW.md`) |
| 7 | P-LAT | DECLARED | component times MEASURED; no rare-tail bound |
| 8 | P-LOCK | DECLARED, or its charged allowance | |
| 9 | P-START | REDUCED to one residual | component times MEASURED |
| 10 | P-SWITCH | DECLARED | that postponing never reduces protection is argued in G6 |
| 11, 12 | P-COMMISSION, P-TRAJECTORY | DECLARED boundary conditions | |
| 13 | M2 (minds valuing the dividend) | removed at rung 5 | the dependency audit (Codex) PROVED no protection account uses it |
| 14 | C-SEQ | DECLARED crypto contract | carried in its own accounts |
| 15 | D-GATE | design rule | |
| 16 to 18, 20, 23 | Hardware warranties (erasure, clocks, attestation, validator, verified core) | DECLARED | inside the one common floor of 10⁻⁷ |
| 19 | J-LIVE and journals | DECLARED | quorum counting PROVED for all parameters (`UPTQuorum`) |
| 21 | Checkpoint streams at startup | REDUCED | F3 |
| 22 | Mode C confidentiality | OPEN | within its account |
| 24, 25 | Identity criteria; full pools before twilight | DECLARED | |
| 26 to 28 | D-ENDOW, P-ENDOW, P-ROUTES | design rule; DECLARED | |
| 29 | Grid laws (vacancy, service) | DECLARED joint contracts | their exact meaning is stated in RUNG5-AUDIT; monotonicity PROVED (`UPTMonotone`) |
| 30 | P-AUDIT | DECLARED | |
| | The four-phase bound, 8.8 × 10⁻⁷ | PROVED conditional on all of the above | an analytical union bound, not a measured failure probability |

## The execution boundary (Chapter 16.5)

| Item | Support | Note |
|---|---|---|
| Check-at-apply fencing: no write lands after the floor is raised | PROVED | `UPTFence` |
| Certified grants and floors compose with the fence | PROVED | `ControllerFence` (Codex) |
| Isolation: a resident reaches targets only through the fenced path | DECLARED | the runtime's no-sandbox mutant shows it is necessary |
| Tokens cannot be forged | CITED (message authentication) and DECLARED (key secrecy) | |
| E-LIN: each target applies its floor and writes in one durable order | DECLARED storage semantics | the runtime realises it with file locks and full-sync; that is an illustration |
| Complete effect coverage: every real effect passes a fenced target | DECLARED, with the bypass inventory OPEN | a bypassing channel defeats the global result without contradicting any local theorem |

## The security protocols (Paper 12, Agents together)

| Item | Support | Note |
|---|---|---|
| Lottery fairness when contributions are bound before reveal | PROVED | `UPTLottery`; binding and consistent opening each shown necessary |
| Byzantine broadcast, four agents and one fault | PROVED | `UPTBroadcast` (Codex); the general case is CITED (Lamport, Shostak and Pease) |
| Verifiable secret sharing with complaints | CITED, with an analytical construction | Gennaro, Ishai, Kushilevitz and Rabin; Ben-Or, Goldwasser and Wigderson; Codex's replicated construction |
| Controller finality and receipts | PROVED in the protocol model | Codex's adapter; PBFT safety CITED as an explicit premise |
| Signatures and digest binding | CITED, computational | deviation at most δ_crypto, never zero |
| Private delivery; authentication | CITED | Shannon; Portmann |
| Key endowment, fresh entropy, reliable slot timing | DECLARED | timing joins item 5 |

## Holds and the lottery (Paper 12)

| Item | Support | Note |
|---|---|---|
| A faithful hold dominates every lethal option | PROVED, given a faithful hold | `statewise_dominance`, `UPTHoldAdequacy` |
| A hold replays to the undisturbed state, in completed steps | PROVED | the general hold theorem |
| The world outside does not move on while a mind is held | DECLARED, through the co-hold certificate | the certificate is least relative to its supplied obligation operator; that the operator includes every dependency that needs protecting is DECLARED and must be shown in each application |
| The draw is over outcomes, so describing an outcome twice cannot move it | PROVED | `UPTLotteryMenu` |
| Descriptions are mapped to their true outcomes; the eligible family is the law's feasible, aligned family | DECLARED, agreed input | broadcast agrees on the bytes, not on their truth |
| How to choose among incomparable maximal outcomes | the author's ruling | counting lives first is PROVED compatible with the law (`UPTCountRefinement`) and PROVED not to follow from it |
