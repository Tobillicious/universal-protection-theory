# Time Koru content fidelity — strict relational extension theorem

**Additive publication proof note · 20 November 2026 · draft PR #663**

This tests the author's proposed link between the Time Koru (`꩜ₜ`) and *genuine non-reindexing novelty* in the Tree of Life and Endless Knowledge. It does not alter the existing Koru definitions or weaken original X3 protection.

## Relational content and the new source conditions

Let `U` denote configurations; let `R` be complete-relational-content presentations; and let `Σ : U → R` extract complete content, **excluding merely external epoch labels**. Let `r ⊏ s` be a strict relational extension order satisfying transitivity and irreflexivity. Use the glyph `꩜` for the author's relational correspondence; ordinary logical equality is still required for comparing content objects inside the proof.

Assume

* **F1, order respects content:** `꩜ₜ(y,z) → Σ(y) ⊏ Σ(z)`.
* **F2, strict relational extension:** `⊏` is transitive and irreflexive.

A composite Complete-Koru-plus-Time-Koru transition `꩜c(x,y) ∧ ꩜ₜ(y,z)` includes a `꩜ₜ` transition as its second stage. The immediate shift is therefore a consequence of F1–F2, irrespective of the outward first-stage relation.

> **Important:** if `Extends` itself is *defined* as proper extension, and `꩜ₜ(y,z) → Extends(Σ(y),Σ(z))` is postulated, then non-repetition is a valid deduction **from an explicit novelty premise**, not an independent discovery that real Time Koru dynamics always create novelty. The open obligation is to derive F1 from an independently specified physical mechanism.

## Theorem A — immediate complete-content distinction

```text
꩜ₜ(y,z) → Σ(y) ≠ Σ(z).
```

**Proof:** F1 gives `Σ(y) ⊏ Σ(z)`. Assuming `Σ(y)=Σ(z)`, substitution yields `Σ(y) ⊏ Σ(y)`, contradicting F2's irreflexivity. Q.E.D.

## Theorem B — global non-recurrence in a finite Time Koru chain

Suppose `z₀,…,zₘ` is any sequence with `꩜ₜ(zₖ,zₖ₊₁)` for every `k<m`. Then

```text
∀ i j, 0 ≤ i < j ≤ m → Σ(zᵢ) ≠ Σ(zⱼ).
```

**Proof:** By F1 each adjacent pair is related by `⊏`. By transitivity, `Σ(zᵢ) ⊏ Σ(zⱼ)` for every `i<j`. Equality of any earlier and later content would contradict irreflexivity. Q.E.D.

This result does not require the separate actualisation premise. To conclude that the **new content is actual**, add the existing witnessed-transition assumption and C4 actualisation bridge from `KORU-GENESIS-GLOBAL-NONRECURRENCE-PROOF-NOTE-2026-11-20.md`.

## Theorem C — actualised content novelty, conditional

For any supplied finite chain `z₀,…,zₘ`, if `Act(z₀)`, every step has a witnessed realisation satisfying the earlier C4 rule, and F1–F2 hold, then

```text
Act(zₘ) ∧ ∀ k<m, Σ(zₖ) ≠ Σ(zₘ).
```

**Proof:** Inductively propagate `Act` through realised steps; combine with Theorem B. Q.E.D.

## Critical comparison with the existing source

[KoruEternalKnowledgeSeed.lean](../evidence/physical-bridges/PhysicalBridges/KoruEternalKnowledgeSeed.lean) proves `renew_twice` and `complete_seed_recurs_without_reversing_time`: after two renewals, the entire **source/history/ethics record** is identical while the epoch advances. If `Σ` extracts just that frozen complete source record, then

```text
Σ(successor(successor(s))) = Σ(s)
```

and Theorem B **cannot apply to those two successive source renewals**; there is no strict `⊏` extension in the source. Adding an epoch number to `Σ` would merely restore the very relabelling loophole we are trying to close.

Consequently the strong content rule F1 must be established for a **different, richer, nonperiodic physically warranted complete-content structure** (for example, genuine incrementally preserved causal provenance). It must not be presented as a consequence of the current period-two frozen-W source.

## Relabelling and isomorphism test

If relational content is represented by labelled graphs or sets of named relations, literal inequality `Σ(y) ≠ Σ(z)` is insufficient for **structural** novelty: permuting the names may yield unequal presentations of isomorphic structures. For a representation-independent proof, take `R` to be relational structures modulo admissible isomorphism, or require `⊏` to be invariant under such isomorphisms. A genuinely new extension must then survive an isomorphism/renaming test.

Additionally, if historical provenance is added to `Σ`, it must be causally verified and not merely a fresh label masquerading as new physical information.

## Publication status

**Proved from F1–F2:** finite-chain content non-recurrence.

**Proved with C4 and witnessed chains:** actualised novelty within such chains.

**Not derived by these theorems:** universal physical satisfaction of F1, existence of realised future steps, genuine novel non-isomorphic matterspacetime content, or necessary cosmic Genesis/God. Those remain separate empirical/physical/theological obligations.

No new Lean compile, physical validation, or independent replay is claimed by this publication note.
