# Global non-recurrence of realised Koru histories

**Additive proof note for the proof-of-God public reading guide · 20 November 2026**

This supplements, but does **not alter**, the existing Complete Koru, Time Koru, Genesis, G1/G2 or six-X3 source definitions. The glyph `꩜` denotes a relational correspondence, never a scalar `K(G)` or a substitution for ordinary logical equality in the metatheory.

## 1. Independent structural conditions

Let `U` be a configuration type, `꩜c(u,v)` the outward Complete Koru relation, `꩜t(v,w)` the Time Koru relation, and `u ≺ v` an irreflexive, transitive progression order on complete configurations.

* **C1 — outward monotonicity:** `꩜c(u,v) → u ≺ v`.
* **C2 — temporal monotonicity:** `꩜t(v,w) → v ≺ w`.
* **C3 — strict order:** `≺` is transitive and irreflexive.
* **C4 — realisation bridge:** `Act(u) ∧ ꩜c(u,v) ∧ ꩜t(v,w) ∧ Realised(u,v,w) → Act(w)`.

Define the *witnessed composite transition*:

```text
RealisedStep(u,w) :=
  ∃ v, ꩜c(u,v) ∧ ꩜t(v,w) ∧ Realised(u,v,w).
```

Then any such transition satisfies `u ≺ w` by C1–C3. The `Act` conclusion requires C4 and actualisation of the source.

## 2. Global finite-chain theorem

For any natural number `n ≥ 1`, any list `u₀,…,uₙ` and proofs

```text
Act(u₀)
∀ k < n, RealisedStep(uₖ,uₖ₊₁)
```

we derive

```text
Act(uₙ) ∧ ∀ k < n, uₙ ≠ uₖ.
```

**Proof.** Each witnessed composite transition gives `uₖ ≺ uₖ₊₁`. Transitivity yields `uₖ ≺ uₙ` whenever `k<n`. If `uₙ=uₖ`, substituting gives `uₖ ≺ uₖ`, contradiction with irreflexivity. For actualisation, induction on `k` uses C4 and the witness of the next realised step to propagate `Act(uₖ) → Act(uₖ₊₁)`. Hence `Act(uₙ)` and non-recurrence relative to each earlier chain member. Q.E.D.

**Scope:** no realised chain is inferred to *exist* from C1–C4 alone. The theorem applies to chains that are supplied with witnessed, instantiated steps.

## 3. Well-foundedness correction

Well-foundedness is **not needed** to prove this non-recurrence theorem. A well-founded strict order excludes infinite descending chains (under the relevant conventional definitions), **not infinite ascending chains**. Example: the usual order on natural numbers is well-founded yet permits `0<1<2<⋯`. Nor does strict order alone establish convergence or continued existence of successors. Avoid claiming that well-foundedness excludes all infinite forward drift.

## 4. Genuine structural novelty is stronger than unequal configurations

If a configuration includes an epoch label, `uₙ ≠ u₀` might hold *solely* because the integer epoch changed, while all relational content repeats. The existing `renew_twice` demonstrates precisely this kind of source recurrence with forward epoch advancement.

Let `Content(u)` denote a physically interpreted complete relational signature (not merely a time index). A stronger **non-reindexing novelty** duty is

```text
∀ k < n, Content(uₙ) ≠ Content(uₖ)
```

or an equivalent physically meaningful distinguishing witness across all previous stages.

This duty does not follow from C1–C4 unless `≺` is independently shown to reflect strict, non-repeating complete-content advance (e.g., via a faithful content relation or a nonperiodic provenance extension). Do not add that conclusion silently.

For actual **cosmological** Genesis, a further bridge must independently establish that the abstract states and `Realised` witnesses refer to actual matterspacetime and that owed particulars and authentic six-X3 duties survive the crossing.

## 5. Three distinct claims for reviewers

1. **Mathematical result:** Every supplied finite realised composite chain is non-recurrent in the strict configuration order; actualisation propagates. **Proved above from C1–C4.**
2. **Structural interpretation:** Every successor introduces genuinely new complete relational content, rather than a renamed/re-indexed copy. **Additional content-faithfulness obligation.**
3. **Physical/theological conclusion:** Actual cosmic Genesis is necessary and identifies a creator God. **Requires independent physical necessity and identification arguments; not established merely by (1).**

This file is a publication companion, not a replacement for the frozen source theorems or a report of new Lean compilation.
