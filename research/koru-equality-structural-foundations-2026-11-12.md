# Koru Equality — structural foundations (research note, 2026-11-12)

**Status:** candidate mathematical semantics; **not** a derivation of a new physical law, nor an assertion that structural isomorphism captures the intended physical Koru. This note preserves the author's proposal that Koru is a *better equality*, rather than merely another transformation operator.

## Motivation and provenance

The original kōrero begins from the distinction between a physical particular and a mathematical description of it. Equality of reduced outputs need not preserve histories, relationships, or provenance. The First Koru is proposed for spacetime; the Complete Koru for matterspacetime, including operators, ordered enactments, and histories. This note adds a precise candidate and identifies where it is insufficient. It does **not** replace existing definitions or claim that the Koru was uniquely derived from these theorems.

## Candidate structural relation

Fix a many-sorted first-order signature Σ encoding chosen particulars, relations, operations and (where represented) histories. For Σ-structures A and B, define

    A ≈ₖ B  :⇔  there exists a Σ-isomorphism f : A ≅ B.

The glyph is provisionally called **Koru Equality** (LaTeX `\\korueq`, proposed private-use codepoint U+E000). A typographical glyph does not by itself change mathematical semantics.

### Theorem A — preservation

For every first-order Σ-sentence φ:

    A ≈ₖ B  →  (A ⊨ φ ↔ B ⊨ φ).

*Proof sketch:* An isomorphism preserves atomic formulas and equality; induction over Boolean connectives and quantifiers gives the result. For formulas with free variables, assignments must be transported along the isomorphism. This result does not extend automatically to arbitrary properties not expressible in Σ.

### Theorem B — equivalence

The relation ≈ₖ is reflexive, symmetric, and transitive.

*Proof sketch:* Identity, inverse and composition of Σ-isomorphisms are Σ-isomorphisms.

### Theorem C — recoverability obstruction

Let q : X → Y. If there exists r : Y → X with r ∘ q = id_X, then q is injective. Conversely, if X is nonempty and q is injective, then such an r exists by choosing a fixed x₀ ∈ X for values outside the image of q. If X is empty, the converse requires Y empty (or else no map Y → X exists). This is a set-level fact, not a physical conservation theorem.

*Proof:* If q(x₁)=q(x₂), applying r yields x₁=x₂. Conversely, define r(q(x))=x (well-defined by injectivity), and r(y)=x₀ off the image.

## Critical limitation: actual identity versus isomorphism

Distinct physical particulars or histories can be structurally isomorphic. If Koru Equality is meant to preserve *which actual particular* and *which provenance* rather than merely structural properties, ≈ₖ is too weak. An enriched signature with rigid provenance markers, or a different relation, may be required; such a choice needs independent justification and must not simply define the intended conclusion into existence.

## Next verification obligations

1. Recover the original derivation and the three-equation obstruction from the primary kōrero and existing Lean modules.
2. Compare the candidate against `KoruCompleteEquationObstruction.lean`, `ThermoLedger.lean`, and existing physical-bridge interfaces without changing their definitions.
3. Give an explicit model of a physical process in which the proposed relation adds a testable invariant or prediction beyond standard full-state mechanics.
4. Formalize the exact enriched relation in Lean and check the kernel, axioms and countermodels. **No Lean compilation or CI verification is claimed for this note.**

This research note is intended for review, not as a completed proof of physical Koru or universal protection.
