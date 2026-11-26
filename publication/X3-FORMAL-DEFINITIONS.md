# Formal Definitions of the Six X3 Duties

**Source:** [`OriginalX3Full.lean`](https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/physical-bridges/PhysicalBridges/OriginalX3Full.lean)

## The Structure

```lean
structure OriginalX3 {S : Type u} {P : Type v}
    (continues authorized free restrained maximal provenanced : S → S → P → Prop)
    (s t : S) (x : P) : Prop where
  historicalContinuity : continues s t x
  authorization        : authorized s t x
  freedom              : free s t x
  restraint            : restrained s t x
  maximality           : maximal s t x
  provenance           : provenanced s t x
```

## Parameters

- `S` — the state space (physical states of the world)
- `P` — the type of particulars (entities owed protection)
- `s t : S` — a state transition from `s` to `t` (a physical event)
- `x : P` — the particular being protected
- Each duty is a ternary predicate `S → S → P → Prop` (pre-state, post-state, particular)

## The Six Duties

### 1. Historical Continuity (`continues`)

**Formal type:** `S → S → P → Prop`

**Meaning:** The particular's history is preserved through the transition. The particular at time `t` retains its identity from time `s`. Nothing is erased.

**Source predicate:** `ContinuationSubject.LaterStage` — a later stage of the same continuation subject. `copy_not_laterStage` proves that a copy is not a continuation.

### 2. Authentic Authorization (`authorized`)

**Formal type:** `S → S → P → Prop`

**Meaning:** Actions affecting the particular during the transition `s → t` are genuinely authorized — by the particular itself or by a legitimate authority. Not forged, not impersonated, not bypassed.

**Source predicate:** `IR104.SubjectAuthorized` — the three-case authorization schema. `IR105` separates authorization from mere accounting.

### 3. Freedom (`free`)

**Formal type:** `S → S → P → Prop`

**Meaning:** The particular has freedom of action in the post-state `t`. Its future options are not artificially constrained beyond what the other duties require.

**Source predicate:** `G2Freedom` / `FreeStage` — freedom as availability of future state transitions.

### 4. Least-Necessary Restraint (`restrained`)

**Formal type:** `S → S → P → Prop`

**Meaning:** Any restraint imposed during the transition is the minimum necessary. Restraint exists only to protect other duties (e.g., preventing one particular's freedom from violating another's continuity).

**Source predicate:** `BookUPTRestraint.Restrainable` — restraint bounded by necessity.

### 5. Feasible Maximality (`maximal`)

**Formal type:** `S → S → P → Prop`

**Meaning:** Among all feasible outcomes of the transition, the one chosen is the best available for the particular. Not utopian perfection — the best that can actually be achieved given all constraints.

**Source predicate:** `StagedMaximality.StageMax` — maximality over feasible alternatives.

### 6. Provenance (`provenanced`)

**Formal type:** `S → S → P → Prop`

**Meaning:** The particular's origin, lineage, and causal history are preserved and traceable. Where it came from is not lost or falsified.

**Source predicate:** `IR119` — provenance tracking.

## Key Theorems

### Un-weakening (the proxy is strictly weaker)

The original BCRD controller used only `continues ∧ authorized` as a proxy. This is **strictly weaker** than the full six:

```lean
theorem originalX3_strengthens_proxy (s t : S) (x : P)
    (h : OriginalX3 continues authorized free restrained maximal provenanced s t x) :
    continues s t x ∧ authorized s t x :=
  ⟨h.historicalContinuity, h.authorization⟩

theorem proxy_is_strictly_weaker :
    ∃ ... (continues s t x ∧ authorized s t x) ∧
      ¬ OriginalX3 continues authorized free restrained maximal provenanced s t x
```

There exists a world where continuation and authorization hold but restraint is violated. The two-field proxy misses it. The full six catches it.

### All six satisfiable under QG

```lean
-- In G3QGConstruction.lean:
theorem QG_all_six_and_no_E (qg : BCRDIsQG S P) ...
```

Under the QG condition, all six duties hold at every step, and the absolute ender is impossible.

## Relationship to THE LAW

`TheLaw` (in [`G3TheLaw.lean`](https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/physical-bridges/PhysicalBridges/G3TheLaw.lean)) composes all six duties with:
- Something IS (inhabitation)
- No absolute ender
- Eternal continuation (every state has a successor)
- Nonvacuous protection (at least one particular is owed)
- Bilateral covenant (G composes)
- Narrowing (protection only tightens, never loosens)
