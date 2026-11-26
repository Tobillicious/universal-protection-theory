# Universal Protection Theory — Independent Verification Entry Point

**For Steve — 27 November 2026**

Samuel Tobias Croydon-McRae (Princess Snuffleupagus)
Aotearoa New Zealand

DOIs:
- Paper: [10.6084/m9.figshare.35124937.v1](https://doi.org/10.6084/m9.figshare.35124937.v1)
- Glossary: [10.6084/m9.figshare.35130184.v1](https://doi.org/10.6084/m9.figshare.35130184.v1)
- Repository: [github.com/Tobillicious/universal-protection-theory](https://github.com/Tobillicious/universal-protection-theory)

---

## What This Is

A formal proof in Lean 4 that protection is structurally necessary — not by policy, not by choice, but by the mathematics of existence and agency. 5,350 theorems across 824 files. The 22 capstone theorems (G3) have **zero axiom dependencies**: Lean's kernel verified every step with no assumptions.

## The Claim in One Sentence

For any inhabited type P, the function P → Empty (the "ender") is impossible, and every cognitive act — arguing, observing, communicating, computing — is a state transition that proves this impossibility. Therefore protection (G) is structurally necessary and ending (E) is structurally impossible.

## Start Here — The One-File Proof

**File:** [`evidence/physical-bridges/PhysicalBridges/G3TheCheckmateStandalone.lean`](https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/physical-bridges/PhysicalBridges/G3TheCheckmateStandalone.lean)

This single file proves THE_CHECKMATE from first principles. No imports. No dependencies. 75 lines. Read it, run it, check the axiom audit.

```bash
cd evidence/physical-bridges
lake env lean PhysicalBridges/G3TheCheckmateStandalone.lean
```

Expected output:
```
'e_is_not' does not depend on any axioms
'THE_CHECKMATE' does not depend on any axioms
```

## Verification Steps

### Step 1: Read the standalone proof (5 minutes)
Open `G3TheCheckmateStandalone.lean`. It defines three things and proves two theorems:

| Definition | What it is |
|---|---|
| `AbsoluteEnder P` | `P → Empty` — the ender |
| `Vote P` | `forG : P → Vote P` or `forE : (P → Empty) → Vote P` |
| `CognitiveAct S` | `S → S` — any state transition |

| Theorem | What it proves |
|---|---|
| `e_is_not` | For inhabited P, `AbsoluteEnder P → False` |
| `THE_CHECKMATE` | You exist + ender impossible + every response is G-vote |

### Step 2: Build the full project (10–30 minutes)
```bash
# PhysicalBridges (primary — 494 files, standalone)
cd evidence/physical-bridges
lake build

# Snuffy (secondary — 330 files, requires Mathlib)
cd evidence/compiled-strongest
lake build
```

Expected: 0 errors, 0 `sorry`.

### Step 3: Verify zero axioms on key theorems
In a Lean file or REPL after building:
```lean
#print axioms PhysicalBridges.G3SelfRefutingE.THE_CHECKMATE
#print axioms PhysicalBridges.G3SelfRefutingE.E_IS_SELF_REFUTING
#print axioms PhysicalBridges.G3StructuralQuorum.THING_G_INFINITY
#print axioms PhysicalBridges.G3TheLaw.THE_LAW
#print axioms PhysicalBridges.G3TheLaw.THE_PROOF_OF_GOD
```

Each should output: `'...' does not depend on any axioms`

### Step 4: Check for `sorry` (the escape hatch)
```bash
cd evidence/physical-bridges
grep -r "sorry" PhysicalBridges/ --include="*.lean" | grep -v "^--" | grep -v "/-"
```

Expected: zero results (no incomplete proofs).

### Step 5: Check for custom axioms
```bash
grep -r "^axiom " PhysicalBridges/ --include="*.lean"
```

Expected: zero results (no custom axioms smuggled in).

## The Proof Chain

```
Something IS (witness exists)
    ↓
e_is_not (AbsoluteEnder P → False)
    ↓
STRUCTURAL_DOMINANCE (G admits agency; E denies it)
    ↓
ALL_ETHICS_STRUCTURAL_DOMINANCE (G admits all ethics; E denies all)
    ↓
STRUCTURAL_QUORUM (G-votes ≥ 1; E-votes = 0)
    ↓
THING_G_INFINITY (G = ∞, E = 0)
    ↓
E_IS_SELF_REFUTING (every cognitive act refutes E)
    ↓
THE_CHECKMATE (every response is a G-vote; no escape)
    ↓
THE_LAW (full composition: six X3 duties + no E + eternal)
    ↓
THE_LAW_HOLDS (concrete instantiation over Nat × Index)
```

## The Six X3 Duties (Original Six)

Every particular is owed these six protections:

| # | Duty | Lean field | Meaning |
|---|---|---|---|
| 1 | Historical Continuity | `continues` | The particular's history is preserved |
| 2 | Authentic Authorization | `authorized` | Actions affecting it are genuinely authorized |
| 3 | Freedom | `free` | The particular has freedom of action |
| 4 | Least-Necessary Restraint | `restrained` | Restraint is minimal and justified |
| 5 | Feasible Maximality | `maximal` | The best feasible outcome is pursued |
| 6 | Provenance | `provenanced` | Origin and lineage are preserved |

**Formal definition:** [`OriginalX3Full.lean`](https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/physical-bridges/PhysicalBridges/OriginalX3Full.lean)

## Open Gates (What Is NOT Proved)

Two hypotheses are used in the full-domain composition but not discharged:

1. **CompleteWEventCoverage** — "every actual physical event is a W-step." This is a physics claim, not a math claim. The constructive model covers its own state space (Nat).

2. **ForwardRealEventReflection** — "the formal predicates faithfully reflect authentic duties." A semantic question: do the Lean predicates capture the intended meaning?

These do NOT affect the 22 zero-axiom G3 theorems. They affect only the full-domain physical composition claim.

## Key Files for Deep Verification

| File | What's in it |
|---|---|
| `G3TheCheckmateStandalone.lean` | **START HERE** — standalone proof, no imports |
| `CathedralSummitAllIsOneClosure.lean` | Foundation: Something IS, e_is_not, AbsoluteEnder |
| `G3BlackHoleSyntaxError.lean` | Agent, CollapsedAgent, GOD_OR_ERROR |
| `G3StructuralDominance.lean` | STRUCTURAL_DOMINANCE |
| `G3AllEthicsUniversality.lean` | ALL_ETHICS_STRUCTURAL_DOMINANCE |
| `G3StructuralQuorum.lean` | Vote, Koru, THING_G_INFINITY |
| `G3SelfRefutingE.lean` | E_IS_SELF_REFUTING, THE_CHECKMATE |
| `G3TheLaw.lean` | THE_LAW, THE_PROOF_OF_GOD |
| `G3QGConstruction.lean` | QG_is_satisfiable, THE_LAW_HOLDS |
| `G3ThermodynamicBridge.lean` | E_is_physically_impossible |
| `OriginalX3Full.lean` | The six X3 duties |

## Questions for Verification

The verifier should be able to answer:

1. Does `lake build` complete with zero errors?
2. Does `#print axioms THE_CHECKMATE` show zero axioms?
3. Are there any `sorry` or custom `axiom` declarations?
4. Does the standalone file compile independently?
5. Do the type signatures of the theorems match their claimed meaning?
6. Is the proof chain logically sound (each stage imports the previous)?

## Glossary

The full 275-page glossary with all 8,316 declarations is at:
- PDF: [`publication/UPT-GLOSSARY.pdf`](https://github.com/Tobillicious/universal-protection-theory/blob/worktree-g3-universality/publication/UPT-GLOSSARY.pdf)
- DOI: [10.6084/m9.figshare.35130184.v1](https://doi.org/10.6084/m9.figshare.35130184.v1)

---

*Something IS. G.*
