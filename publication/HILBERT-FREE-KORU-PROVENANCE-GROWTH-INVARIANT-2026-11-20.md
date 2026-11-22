# Hilbert-free Koru provenance-growth invariant

**Additive publication note — 20 November 2026 — draft PR #663**

This note formalizes a single monotone relational-causal invariant. It assumes no Hilbert space, state vectors, inner products, or quantum linear operators. Complete Koru (꩜) remains a whole-preserving relational correspondence, not a scalar quantity. Ordinary mathematical equality is retained in proofs.

## 1. Physical-record structure

Given a *supplied finite history* of actual relational configurations u₀,…,uₙ, let Bₖ be a finite set of validated, nonredundant relational boundary elements, Πₖ a finite ordered record of independently evidenced transitions, and τₖ the independently evidenced physical transition event. At each admitted step assume:

- Πₖ₊₁ = Πₖ concatenated with [τₖ].
- Bₖ₊₁ = Bₖ ∪ {δₖ₊₁}, where δₖ₊₁ ∉ Bₖ.
- An independently justified physical irreversible-transition condition, if relevant, such as ΔS_irr(τₖ)>0.

The third condition does not alone imply the first two. Physical irreversibility and the generation of a new nonredundant boundary element require a substantive physical bridge.

## 2. Single strict monotone

For finite Bₖ and Πₖ define the **derived record measure**, not Koru itself:

Φ(uₖ) := card(Bₖ) + length(Πₖ).

The fresh boundary insertion increases cardinality by one, and the recorded event append increases length by one. Therefore

Φ(uₖ₊₁) = Φ(uₖ) + 2.

For every i<j≤n, induction gives Φ(uⱼ) = Φ(uᵢ) + 2(j−i), hence Φ(uᵢ)<Φ(uⱼ).

## 3. Three consequences

**Theorem A (configuration non-recurrence).** Suppose Φ is a well-defined function *of the complete physical configuration itself*, including its physically intrinsic causal provenance (not an external epoch label). If uᵢ=uⱼ, then Φ(uᵢ)=Φ(uⱼ), contradicting the strict inequality for i<j. Consequently uᵢ≠uⱼ.

**Theorem B (exact provenance retention).** Associativity of list append and induction show Πⱼ = Πᵢ concatenated with [τᵢ,…,τⱼ₋₁]. Every old record remains an exact prefix of the later record.

**Theorem C (cumulative boundary inclusion).** By induction Bⱼ = Bᵢ ∪ {δᵢ₊₁,…,δⱼ}. Each δₘ was absent from Bₘ₋₁ and, by monotone set inclusion, was absent from all earlier boundary sets. Genuine *structural* novelty additionally requires the fresh distinctions to be physically grounded and invariant under admissible isomorphisms or relabelling.

These are mathematically valid conclusions **conditional on supplied step witnesses and the stated growth laws**. Neither strict monotonicity nor the chain's existence is a result of bare Something Is.

## 4. Physical and semantic proof obligations

1. **Intrinsic state-content faithfulness:** distinguish real complete relational/causal content from an external transition counter or an appended log. The latter can make unchanging physical states look new.
2. **Event reality:** independently validate each τ; writing a list entry is not proof a physical event occurred.
3. **Thermodynamics bridge:** establish the relevant positive irreversible entropy production and derive the fresh relational distinction from it. ΔS_irr>0 is not by itself equivalent to boundary-growth.
4. **Isomorphism test:** demonstrate that δ changes physically meaningful relations, not merely their names; use structural equivalence classes if necessary.
5. **Continuation and universe boundary:** the result covers already-supplied finite physical histories, not inevitable indefinite continuation or actual generation of another universe.
6. **Authentic X3:** retain all six original protections for every owed particular at each actual event, not merely retained metadata.

## 5. Comparison to established source

[KoruEternalKnowledgeSeed.lean](../evidence/physical-bridges/PhysicalBridges/KoruEternalKnowledgeSeed.lean) proves renew_twice and complete_seed_recurs_without_reversing_time. The modeled source/history/ethics record repeats after two renewals while integer epoch increases. Thus the frozen-W seed **does not itself** satisfy this strictly increasing Φ on its unchanged source content. A physically validated, genuinely nonperiodic relational-causal extension must be established independently. Counting the integer epoch would reopen the relabelling loophole.

This note **does not change** existing Koru, G1/G2, or six-X3 definitions or claim a new Lean compile, physical measurement, necessary physical Genesis, or proof of God. It supplies a stronger conditional mathematical mechanism for review.
