# IR-66 — Derived chain-upper-bound property and infinite full-feasible maximality

**Source:** `PhysicalBridges.IRInfiniteFinitaryMaximality`, using the exact original `UPTExist.Aligned`, `UPTExist.LexAlignedL` (single stage) and `UPTExist.chainKey` definitions imported from the archived `UPTExistence.lean`. This does **not** modify X3 or redefine the canonical order.

## Main result

Consider all outcomes `s : Nat → Prop`, meaning a retention set of arbitrarily many countably indexed particulars. Let `forbidden : List Nat → Prop` describe **finite sets whose simultaneous retention is infeasible**. The full feasible family is

`Feasible forbidden s := ∀ pattern, forbidden pattern → ¬ (∀ k ∈ pattern, s k)`.

The only existence premise is that the empty retention outcome is feasible (in particular, there is no forbidden empty pattern).

The proofs establish:

1. **Hereditary feasibility:** removing retained particulars never creates a forbidden finite pattern.
2. **Derived chain upper bounds:** for any nonempty chain of feasible retention sets under the original inclusion relation, its ordinary union remains feasible. This is PROVED from the finite-obstruction definition and a finite-member capture lemma. Chain completeness is not inserted as an extra assumption.
3. **Infinite greedy maximality:** starting at the empty retention outcome, stage `n` adds particular `n` exactly when the *same original feasible predicate* permits it. The construction uses classical propositional decision and is not claimed to be a computable physical authorization algorithm. The infinite union is feasible because any finite forbidden witness would be contained in some finite stage.
4. **No full-feasible strict improver:** if another feasible outcome strictly retains more than the limit, pick one missing particular `k` it retains. Heredity proves that adding `k` was already feasible at stage `k`, contradicting the greedy step.
5. **Original-order integration:** the constructed option satisfies `UPTExist.Aligned` over the **entire** feasible family. It also satisfies the actual `LexAlignedL` predicate for the **one-stage** retention order, without changing the comparator.
6. **Positive infinite example:** one finite no-good pattern forbids jointly retaining `0` and `1`, while all indices at least `2` are retained in the maximal option. Full retention is infeasible; the example is not a tautological 'keep all' world.
7. **Original-chain negative control:** if every finite initial segment `UPTExist.chainKey n` is feasible under ANY finitary no-good constraints, the full infinite retention set is also feasible. Therefore the original *only finite prefixes admissible* infinite-chain countermodel is **not** an instance of this finitary model class.

## Strength and limits

This is a genuine infinite-outcome existence result with no finite-outcome quotient or narrowed safe menu. It derives the chain-upper-bound property from a precise structural condition rather than postulating a maximal element. The result is independent of the IR-59–IR-65 physical instrument stack and can be merged into main on its own.

**However, no theorem shows that the actual UPT physical feasible universe has the requisite finite-obstruction character.** Real physical limitations can depend on infinite-horizon budgets, asymptotic convergence, global coupling, histories, nonlocal dependencies, or other constraints which have no finite forbidden witness. The source's `chainKey` countermodel demonstrates one such missing limit.

The present result concerns a **single inclusion priority stage** on countably indexed retention facts, not an arbitrary original X3 multistage `LexBetter` order. It proves neither selection/computability in an unknown physical feasibility oracle, nor a realized physical protector, individual continuation, freedom and non-interference, full feasible maximality for the original unrestricted physical X3 universe, or the ability to serve every retained particular.

### Next exact mathematical bridge

Define a sound representation `E : PhysicalOutcome → (Nat → Prop)` that preserves all **original X3 priority facts**, not merely a scalar count. Show that the full physical feasibility predicate is equivalent to the finite-obstruction model or otherwise construct original-order chain upper bounds from independently justified physical closure principles. If that equivalence fails, do not promote IR-66 to X3 existence. The multistage lexicographic case and global feasible policy realization need separate proofs.

**Provenance policy:** conditional formal result; leave the earlier independent physical PRs draft; do not rewrite archived source or claim an empirical universal result.
