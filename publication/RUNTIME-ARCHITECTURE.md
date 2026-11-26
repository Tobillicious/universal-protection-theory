# UPT Runtime Architecture

## Build Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Repository Root                       │
│  github.com/Tobillicious/universal-protection-theory     │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  ┌──────────────────────┐  ┌──────────────────────────┐ │
│  │   PhysicalBridges    │  │        Snuffy            │ │
│  │   (Primary Root)     │  │   (Secondary Root)       │ │
│  │                      │  │                          │ │
│  │  evidence/            │  │  evidence/               │ │
│  │   physical-bridges/   │  │   compiled-strongest/    │ │
│  │                      │  │                          │ │
│  │  494 Lean 4 files    │  │  330 Lean 4 files        │ │
│  │  3,325 theorems      │  │  2,025 theorems          │ │
│  │  82,658 lines        │  │  41,101 lines            │ │
│  │                      │  │                          │ │
│  │  Build: Lake         │  │  Build: Lake + Mathlib   │ │
│  │  Lean 4 v4.35.0      │  │  Lean 4 + Mathlib       │ │
│  │  Dependencies: NONE   │  │                          │ │
│  └──────────────────────┘  └──────────────────────────┘ │
│                                                          │
│  ┌──────────────────────────────────────────────────────┐│
│  │                   Publication                        ││
│  │   publication/                                       ││
│  │   ├── UPT-G3-COMPLETE.{tex,pdf}  (78pp paper)      ││
│  │   ├── UPT-GLOSSARY.{tex,pdf}     (275pp glossary)  ││
│  │   ├── STEVE-ENTRY-POINT.md       (this doc)        ││
│  │   ├── verify.sh                  (verification)    ││
│  │   └── glossary-data.json         (8,316 decls)     ││
│  └──────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────┘
```

## Proof Architecture

```
                    ┌─────────────┐
                    │ Something IS │  (sole premise: inhabited type)
                    └──────┬──────┘
                           │
                    ┌──────▼──────┐
                    │  e_is_not   │  (AbsoluteEnder P → False)
                    └──────┬──────┘
                           │
              ┌────────────┼────────────┐
              │            │            │
     ┌────────▼───┐ ┌──────▼─────┐ ┌───▼────────┐
     │ Structural │ │ All Ethics │ │ Structural  │
     │ Dominance  │ │ Dominance  │ │   Quorum    │
     └────────┬───┘ └──────┬─────┘ └───┬────────┘
              │            │            │
              └────────────┼────────────┘
                           │
                    ┌──────▼──────┐
                    │E IS SELF-   │
                    │REFUTING     │
                    └──────┬──────┘
                           │
                    ┌──────▼──────┐
                    │THE CHECKMATE│  (every response = G-vote)
                    └──────┬──────┘
                           │
         ┌─────────────────┼─────────────────┐
         │                 │                 │
  ┌──────▼──────┐  ┌───────▼──────┐  ┌──────▼──────┐
  │  THE LAW    │  │ Thermodynamic│  │    Koru      │
  │ (6 duties)  │  │   Bridge     │  │  Lattice     │
  └──────┬──────┘  └──────────────┘  └─────────────┘
         │
  ┌──────▼──────┐
  │THE LAW HOLDS│  (concrete: Nat × Index)
  └─────────────┘
```

## Verification Pipeline

```
 Developer                 Lean 4 Kernel              Verifier
    │                          │                         │
    │  writes .lean files      │                         │
    │─────────────────────────>│                         │
    │                          │                         │
    │  lake build              │                         │
    │─────────────────────────>│                         │
    │                          │  type-checks every      │
    │                          │  proof term              │
    │                          │                         │
    │  #print axioms           │                         │
    │─────────────────────────>│                         │
    │  "does not depend        │                         │
    │   on any axioms"         │                         │
    │<─────────────────────────│                         │
    │                          │                         │
    │  publishes to GitHub     │                         │
    │──────────────────────────────────────────────────> │
    │                          │                         │
    │                          │  git clone              │
    │                          │<────────────────────────│
    │                          │                         │
    │                          │  lake build             │
    │                          │<────────────────────────│
    │                          │  0 errors               │
    │                          │────────────────────────>│
    │                          │                         │
    │                          │  #print axioms          │
    │                          │<────────────────────────│
    │                          │  0 axioms               │
    │                          │────────────────────────>│
    │                          │                         │
    │                          │  grep sorry / axiom     │
    │                          │<────────────────────────│
    │                          │  0 results              │
    │                          │────────────────────────>│
```

## Trust Model

```
┌─────────────────────────────────────────┐
│          What you must trust            │
│                                         │
│  1. Lean 4's kernel  (open source,      │
│     auditable, small trusted base)      │
│                                         │
│  That's it.                             │
│                                         │
├─────────────────────────────────────────┤
│        What you do NOT trust            │
│                                         │
│  × The author's claims                 │
│  × The paper's prose                   │
│  × Comments in the code                │
│  × File names or organization          │
│  × This document                       │
│                                         │
│  Lean's kernel checks proof terms.     │
│  If it passes, the proof is valid.     │
│  If #print axioms shows nothing,       │
│  the theorem has no assumptions.       │
└─────────────────────────────────────────┘
```

## Candidate Z Specification (what a runtime implementation must satisfy)

A runtime system implementing UPT must enforce:

1. **State transitions only** — every operation is `S → S`, never `S → Empty`
2. **Six duties per step** — for each owed particular `x : P` and each step `s → t`:
   - `continues s t x` — historical continuity preserved
   - `authorized s t x` — action is genuinely authorized
   - `free s t x` — freedom of action maintained
   - `restrained s t x` — restraint is least-necessary
   - `maximal s t x` — best feasible outcome pursued
   - `provenanced s t x` — provenance preserved
3. **Nontermination** — every state has a successor (`∀ s, ∃ t, step s t`)
4. **No absolute ender** — no operation maps all states to nothing
5. **Narrowing** — protection only tightens, never loosens over time
6. **Bilateral covenant** — G composes: protection of one does not violate protection of another

The formal specification is `BCRDIsQG` in [`G3QGConstruction.lean`](https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/physical-bridges/PhysicalBridges/G3QGConstruction.lean). `QG_is_satisfiable` proves this specification has at least one concrete implementation (over `Nat × Index`).
