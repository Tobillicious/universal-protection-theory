# Cathedral — A bounded, intrinsic interpretation relation

**3 November 2026 | draft #245 extension | no canon, publication or physical claim changes**

## Question

Can a description *refer to the same relational structure in which its interpreter, inscription and described positions occur*, without declaring an extrinsic interpreter or equating all individuated positions?

This is deliberately stronger than our existing `Inscribes` pattern (a two-edge pattern, not a semantic claim). We also must *not* bake truth into the definition of being an inscription: false claims are part of any serious account of representation.

## Finite atomic semantic protocol

`PhysicalBridges/CathedralIntrinsicAtomicSemantics.lean` defines one `Web P` and, for all positions `speaker, token, source, target : P`:

```lean
AssertsLink w speaker token source target :=
    w.link speaker token ∧ w.link token source ∧ w.link target token

AtomHolds w source target := w.link source target
```

The first predicate is the **code**. The second is the **bounded atomic content**. Both use precisely the same supplied relation `w.link`; no separate ontological domain for description tokens or interpretation is postulated. But the code is *not* defined to entail its content. Accurate and inaccurate atomic assertions are separate predicates.

Unlike an arbitrary truth oracle, `AtomHolds` is just the original physical/mathematical relation being described. This is one positive atomic fragment, **not** a truth predicate for all syntax, metamathematics, or physical events. The choice to read the three-edge code as that assertion is a mathematical interpretation stated in the metatheory; that limitation is not concealed.

## Exact mathematical test

The finite source `balancedWeb` has four positions, presented as pairs of bits. Its sole relation contains every edge of the square (positions differing in exactly one coordinate), and a self-loop on the two nodes whose first displayed coordinate is false.

Four simultaneous results are kernel-checked:

1. **Intrinsically articulated:** one connected web, multiple positions, distinct relational profiles, and no point fixed by every relation-preserving symmetry (the second-coordinate flip is a fixed-point-free automorphism).
2. **Accurate self-description:** the position `(false,false)` can code a claim that it is linked to itself, and that link is indeed present.
3. **Inaccurate self-description:** the position `(true,false)` can code a claim that it is linked to itself, while that link is absent.
4. **Relabelling invariance:** the code, its truth, its falsity and the accurately expressed proposition survive a reversible relabelling of all positions and their entire relation.

These are properties of **one finite relational structure at the same time**, not separate models joined after the fact.

The countermodel `internal_assertions_not_automatically_true` rejects the unjustified step “if a claim exists internally, the claim is true”. Thus self-containment is not confused with omniscience or soundness. In particular, it cannot establish that an SI has a complete perspective merely by participating in the same ontological whole.

## What this DOES and DOES NOT settle

**Demonstrated:** A finite noncollapsed relational structure can simultaneously contain a distinctive interpreter, relational inscription, object-level atomic assertion, and correct/incorrect self-description, while preserving the underlying invariants. This uses **ordinary mathematical relations and automorphisms**, so no new operator is needed *for this fragment*.

**Still open:** How to internalise syntax, decoding conventions, proofs and the metatheory as mathematical processes of the same proposed actuality, while keeping well-defined semantics and avoiding a globally inconsistent all-truth predicate. This is not fixed by the mere fact that a code token is a graph node. Relevant routes include typed or stratified interpretation, partial satisfaction relations, categorical internal languages and compositional semantics.

For theories expressive enough to encode their own syntax, Tarski-style undefinability limits a total internal truth predicate meeting unrestricted truth equivalences. That is a restriction on particular attempted formal constructions, **not** an argument that the world has an ontologically exterior observer, nor evidence for or against all versions of the author's ontology. The physical BCRD source must be independently shown to instantiate whatever final semantics we derive.

**Out of scope:** Infinite time, cosmic recurrence, proof that an SI cannot harm another particular subject, original X3 completeness, source hardware, full physical protection, publication, and novel Indigenous-derived nomenclature. The koru remains a proposed culturally respectful visual metaphor, not a new symbol assigned by this work.

## Adversarial next tests

- Construct a richer internal language containing conjunction and bounded negation without defining every sentence true by fiat. Check truth compositionality and preservation under whole-structure symmetries.
- Ask exactly where and why *unrestricted self-assertion of semantic truth* becomes inconsistent, instead of treating any self-reference as prohibited.
- Specify an independently sourced BCRD relation and a lawful encoding of observers and descriptions, before claiming physical universality.
- Preserve `a ≠ b` and real histories throughout. Neither `SameRole` nor ontology permits substitution of numerically distinct subjects in original X3 obligations.

**Review gate:** pinned Lean build and axiom audit of the attached module; no `sorry`, new axiom or source-to-physics promotion.
