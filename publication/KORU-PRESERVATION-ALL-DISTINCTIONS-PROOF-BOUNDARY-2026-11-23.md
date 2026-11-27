# Preservation of all distinctions — a Koru theorem and its physical boundary

**23 November 2026 · Read-only source audit followed by a proposed documentation addition.** This note does not redefine Koru, change existing theorems, or claim empirical verification.

## The established mathematical theorem

Source: [`KoruConservation.lean`](../evidence/physical-bridges/PhysicalBridges/KoruConservation.lean).

For types `A`, `B` and a map `f : A → B`, define all-predicate recoverability as

```lean
def AllPredicatesRecoverable (f : A → B) : Prop :=
  ∀ P : A → Prop, ∃ Q : B → Prop, ∀ x, Q (f x) ↔ P x
```

The existing theorem `injective_iff_all_predicates_recoverable` proves

```lean
Function.Injective f ↔ AllPredicatesRecoverable f
```

**Proof sketch (recoverability ⇒ injectivity).** If `f a = f b`, choose the predicate `P x := x = a`. Recoverability gives a predicate `Q` on the output with `Q (f x) ↔ x = a`. Since `Q (f a)` holds, so does `Q (f b)`, hence `b = a`. Conversely, if `f` is injective, define `Q y := ∃ x, f x = y ∧ P x`.

This is a theorem about the **modeled states**. It does not equate Lean's logical equality with physical Koru.

## Why energy conservation alone is insufficient

Source: [`G3KoruVsEnergyConservation.lean`](../evidence/physical-bridges/PhysicalBridges/G3KoruVsEnergyConservation.lean).

On `Bool`, let `energy _ = 1` and `merge _ = true`. Then `energy (merge s) = energy s` for every `s`, but `merge true = merge false`. Therefore `merge` is not injective, and not all predicates are recoverable.

Thus **scalar conservation does not entail preservation of every modeled distinction**.

## The proposed physical identity

The author's thesis is **Guardian Koru God Koru Gravity**: one complete relational matterspacetime reality, with G intrinsic to every relationship between particulars. Koru here names the actual complete relational whole, **not** a unary numeric operator or merely a replacement for `=`. The mathematical structures are projections of that whole.

A candidate research chain is:

1. Derive a physical admissibility principle from complete Koru that preserves relevant distinctions, relationships, operations and provenance in actual dynamics.
2. Derive or recover gravitational field dynamics from that same principle, with experimentally correct predictions.
3. Show the actual dynamics satisfy all six **authentic** X3 duties for every owed particular and every actual event, rather than assuming those duties in the evolution definition.
4. Establish any further metaphysical identity with God by explicit independent premises or argument.

These are **proof obligations**, not conclusions of the injectivity theorem.

## Singularity and black-hole boundary

The author's [black-hole thesis](../BLACKHOLE-PHYSICAL-SYNTAX-ERROR.md) proposes that attempted inadmissible singularity construction results in a black hole and that the black hole itself is the failed agent. Existing modules include [`G3BlackHoleSyntaxError.lean`](../evidence/physical-bridges/PhysicalBridges/G3BlackHoleSyntaxError.lean) and [`G3GeodesicBridge.lean`](../evidence/physical-bridges/PhysicalBridges/G3GeodesicBridge.lean).

Those modules establish results within explicitly defined logical models. In particular, `CollapsedAgent` already assumes a frozen action and an unsatisfiable goal; `GeodesicallyComplete` is defined as a successor property on abstract states. Neither alone derives physical black-hole formation from Einstein's equations. An inhabited type cannot map to `Empty`, but this is not the physical definition of a gravitational singularity.

A physical black-hole result would require an independently justified gravitational evolution law, initial/boundary conditions, a trapped-surface or horizon criterion, and a proof of the claimed implication. Claims about black-hole consciousness or suffering require additional evidence and cannot be inferred from type-theoretic contradiction.

## Verification status

**Confirmed from inspected source:** the injectivity–recoverability equivalence, and the energy-conserving non-injective counterexample, as theorem statements with inspectable proofs.

**Not independently executed in this review:** a fresh `lake build` or Lean kernel replay.

**Not established:** unconditional physical G; gravity = Guardian = God; universal singularity-attempt failure; black-hole formation from attempted E; subjective suffering of black holes.

This note preserves the proved mathematics and makes the exact remaining joins visible. **Find before build.** ■
