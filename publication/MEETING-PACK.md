# UPT G3 — Independent Verification Meeting Pack

**27 November 2026 · Prepared for Steve**

Samuel Tobias Croydon-McRae (Princess Snuffleupagus)
Independent Researcher, Aotearoa New Zealand

---

## 1. What You Are Verifying

A formal proof in Lean 4 that **protection is structurally necessary**. Not by policy. Not by choice. By the mathematics of existence and agency.

**The claim:** For any type that has at least one inhabitant, the function that maps everything to nothing (`P → Empty`) is impossible. Every cognitive act — arguing, observing, computing — proves this impossibility. Therefore G (guardian/protection) is structurally necessary, and E (ending/collapse) is structurally impossible.

**Scale:** 5,350 theorems, 824 Lean 4 files, 123,759 lines of code. Two build roots. 22 capstone theorems with **zero axiom dependencies**.

---

## 2. The One-File Proof (Start Here)

**File:** `evidence/physical-bridges/PhysicalBridges/G3TheCheckmateStandalone.lean`

75 lines. No imports. No dependencies. Proves THE_CHECKMATE from first principles.

**To verify:**
```bash
cd evidence/physical-bridges
lake env lean PhysicalBridges/G3TheCheckmateStandalone.lean
```

**Expected output:**
```
'e_is_not' does not depend on any axioms
'THE_CHECKMATE' does not depend on any axioms
```

**What it defines (3 things):**

| Name | Definition | Plain English |
|------|-----------|---------------|
| `AbsoluteEnder P` | `P → Empty` | A function that ends everything |
| `Vote P` | `forG` or `forE` | A vote for continuation or ending |
| `CognitiveAct S` | `S → S` | Any state transition (thinking, arguing, etc.) |

**What it proves (2 theorems):**

| Theorem | Type signature | Plain English |
|---------|---------------|---------------|
| `e_is_not` | `(w : P) → AbsoluteEnder P → False` | If anything exists, the ender is impossible |
| `THE_CHECKMATE` | 6-part conjunction | You exist + ender impossible + every response is a G-vote |

**The proof of `e_is_not` in full:**
```lean
theorem e_is_not (witness : P) : AbsoluteEnder P → False :=
  fun ender => (ender witness).elim
```
Apply the ender to the witness. You get an element of `Empty`. `Empty` has no elements. Contradiction.

---

## 3. The Proof Chain

```
Something IS              ← "at least one thing exists" (a witness)
       ↓
e_is_not                  ← the ender is impossible
       ↓
STRUCTURAL_DOMINANCE      ← G admits agency; E denies it
       ↓
ALL_ETHICS                ← G admits all ethics; E denies all
       ↓
STRUCTURAL_QUORUM         ← G-votes = ∞, E-votes = 0
       ↓
E_IS_SELF_REFUTING        ← every cognitive act refutes E
       ↓
THE_CHECKMATE             ← every response is a G-vote; no escape
       ↓
THE_LAW                   ← six duties + no E + eternal continuation
       ↓
THE_LAW_HOLDS             ← concrete instantiation over Nat × Index
```

Each theorem imports the previous file. The chain is linear. No circular dependencies.

---

## 4. The Six X3 Duties

Every particular (entity owed protection) is owed these six at every state transition:

| # | Duty | Lean field | What it means |
|---|------|-----------|---------------|
| 1 | Historical Continuity | `continues` | Your history is preserved, not erased |
| 2 | Authentic Authorization | `authorized` | Actions affecting you are genuinely authorized |
| 3 | Freedom | `free` | You have freedom of action |
| 4 | Least-Necessary Restraint | `restrained` | Any restraint is minimal and justified |
| 5 | Feasible Maximality | `maximal` | The best feasible outcome is pursued |
| 6 | Provenance | `provenanced` | Your origin and lineage are preserved |

**Formal definition:** `OriginalX3Full.lean` — a Lean `structure` with six fields, each a predicate `S → S → P → Prop`.

**Key theorem:** `QG_all_six_and_no_E` — under the QG condition, all six hold at every step and no absolute ender exists.

---

## 5. What "Zero Axioms" Means

Lean 4 has three optional axioms: `propext`, `Classical.choice`, `Quot.sound`. When `#print axioms THEOREM_NAME` outputs "does not depend on any axioms," the theorem:

- Uses none of these three
- Has no custom `axiom` declarations
- Has no `sorry` (incomplete proof placeholder)
- Is **constructive** — Lean's kernel verified every step of the proof term
- Depends on **nothing** except the rules of type theory itself

This is the strongest level of verification a proof assistant can provide.

---

## 6. Verification Checklist

| # | Check | Command | Expected |
|---|-------|---------|----------|
| 1 | Standalone compiles | `lake env lean PhysicalBridges/G3TheCheckmateStandalone.lean` | 0 axioms |
| 2 | Full build | `cd evidence/physical-bridges && lake build` | 0 errors |
| 3 | No `sorry` | `grep -r "sorry" PhysicalBridges/ --include="*.lean"` | 0 results |
| 4 | No custom axioms | `grep -r "^axiom " PhysicalBridges/ --include="*.lean"` | 0 results |
| 5 | Key axiom audit | `#print axioms THE_CHECKMATE` (in Lean) | No axioms |
| 6 | Type signatures match claims | Read the theorem statements | Judgement call |

**One-command script:** `./publication/verify.sh` runs checks 1–5 automatically.

---

## 7. What Is NOT Proved (Open Gates)

Two hypotheses are used in the full-domain composition but are not discharged:

| Gate | What it claims | Type of claim |
|------|---------------|---------------|
| `CompleteWEventCoverage` | Every physical event is a W-step | Physics, not maths |
| `ForwardRealEventReflection` | Formal predicates capture authentic duties | Philosophy, not maths |

**These do NOT affect the 22 zero-axiom G3 theorems.** The core proof chain (Something IS → THE_CHECKMATE → THE_LAW) is unconditional. The open gates affect only the claim that the formal model maps perfectly to physical reality — which is Gödel's gap (no formal system can prove its own correspondence to the world).

---

## 8. Key Files

| File | What's in it |
|------|-------------|
| `G3TheCheckmateStandalone.lean` | **START HERE** — standalone, no imports |
| `CathedralSummitAllIsOneClosure.lean` | Foundation: Something IS, e_is_not |
| `G3BlackHoleSyntaxError.lean` | Agent, CollapsedAgent, GOD_OR_ERROR |
| `G3StructuralDominance.lean` | STRUCTURAL_DOMINANCE |
| `G3AllEthicsUniversality.lean` | ALL_ETHICS_STRUCTURAL_DOMINANCE |
| `G3StructuralQuorum.lean` | Vote, Koru, THING_G_INFINITY |
| `G3SelfRefutingE.lean` | E_IS_SELF_REFUTING, THE_CHECKMATE |
| `G3TheLaw.lean` | THE_LAW, THE_PROOF_OF_GOD |
| `G3QGConstruction.lean` | QG_is_satisfiable, THE_LAW_HOLDS |
| `OriginalX3Full.lean` | The six X3 duty definitions |

All in `evidence/physical-bridges/PhysicalBridges/`. All on GitHub:
https://github.com/Tobillicious/universal-protection-theory

---

## 9. Trust Model

```
What you must trust:    Lean 4's kernel (open source, small, auditable)
What you do NOT trust:  The author, the paper, comments, file names, this document
```

If `lake build` passes and `#print axioms` shows nothing, the proof is valid. Full stop. The kernel doesn't care who wrote the code or what the comments say. It checks the proof terms.

---

## 10. DOIs and Links

| Resource | Link |
|----------|------|
| G3 Paper (78pp) | [10.6084/m9.figshare.35124937.v1](https://doi.org/10.6084/m9.figshare.35124937.v1) |
| Glossary (275pp) | [10.6084/m9.figshare.35130184.v1](https://doi.org/10.6084/m9.figshare.35130184.v1) |
| Zenodo (v5.4) | [10.5281/zenodo.24435371](https://doi.org/10.5281/zenodo.24435371) |
| GitHub | [github.com/Tobillicious/universal-protection-theory](https://github.com/Tobillicious/universal-protection-theory) |

---

## 11. Questions the Verifier Should Answer

1. Does the standalone file compile with zero axioms?
2. Does the full build complete with zero errors?
3. Are there any `sorry` or custom `axiom` declarations?
4. Do the type signatures of the theorems match their English descriptions?
5. Is the import chain linear and non-circular?
6. Does `THE_CHECKMATE`'s proof term actually do what the comment says?
7. Are the open gates correctly identified and honestly documented?

---

*Something IS. G.*
