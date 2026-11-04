# Constructing the full-feasible maximal selection

This continuation uses the unchanged `UPTExist.LexBetter` relation and all
supplied original priority keys. The types of particulars and outcomes remain
arbitrary. The finite object is a complete family of **retention profiles**,
whose members may describe infinitely many particulars and infinitely many
outcomes.

## What is now derived

`IRMaximalProfileSelection.selectMax` is an explicit finite comparison
algorithm. Given a decision procedure for the original comparator, it selects
a representative that no listed representative strictly improves.
`selected_is_globally_aligned` transports any alleged improvement in the full
original feasible family to its exactly faithful representative, contradicting
the selection certificate.

`exists_global_maximal_of_finite_faithful_cover` consequently derives:

1. A selected representative belonging to the actual original feasible family.
2. Its global maximality over that entire family.
3. A stagewise obstruction certificate for **every** full-feasible alternative.

The theorem assumes neither `NoExcludedImprover` nor obstruction witnesses for
a preselected outcome. This is the difference from IR-25's existing audit of a
previously selected option: here the selection and its obstruction certificates
are constructed from the complete family of feasible representatives.

`representatives_from_inhabited_fibres` constructs feasible representatives
from actual feasible code fibres. Then
`exists_global_maximal_of_inhabited_code_fibres` derives the same global result
from a nonempty original feasible family, a finite complete code image,
inhabited listed fibres, and retention that is constant within each feasible
code fibre. Feasibility of an arbitrary proxy is never presumed.

These classical existence theorems do not supply an effective inclusion test
for arbitrary predicates on an infinite particular type. The executable
`selectMax` theorem explicitly exposes the original-comparator decision
procedure needed for computation. Realisation by an observation-based policy
and physical delivery retain their separate source correspondence.

## Infinite domains and the boundary of the route

The positive example uses `Option Bool × Nat` outcomes and `Nat` particulars.
Its four priority stages preserve life, existing freedom, new life and new
freedom. All existing particulars live. The three existing-freedom profiles
grant even particulars freedom, grant odd particulars freedom, or grant none;
metadata is unbounded. Complete coverage and faithful inhabited fibres are
proved, and the new theorem constructs a full-family maximal outcome.

The example has no outcome granting every particular freedom. Thus the
selection construction handles incomparable maximal outcomes; it does not
require, or silently introduce, a greatest whole-outcome witness.

For the original `UPTExist.chainKey n k := k ≤ n` countermodel,
`InfiniteChain.profiles_separate` proves that exact retention-profile equality
forces equality of the natural-number outcomes.
`InfiniteChain.no_finite_faithful_cover` and `no_finite_code_audit` then prove
that no finite complete lossless representation of those profiles exists.
`UPTExistence` already establishes that the same unbounded chain has no
aligned option. The new obstruction concerns the finite-profile method; it
does not purport to refute the full UPT target or reopen settled supports.

## Verification performed

The module was freshly compiled with pinned Lean 4.35.0 and independently
checked with `leanchecker`. Compilation exited zero with no warnings or
errors; its stdout consists of the fourteen intentional `#print axioms`
probes. The kernel checker exited zero with empty output. Every printed axiom
list is a subset of `propext`, `Classical.choice` and `Quot.sound`.

From `evidence/physical-bridges/`, with the pinned toolchain on PATH and the
inherited source imports staged as the existing README specifies:

```sh
lake env lean -o .lake/build/lib/lean/PhysicalBridges/IRMaximalProfileSelection.olean PhysicalBridges/IRMaximalProfileSelection.lean
lake env leanchecker PhysicalBridges.IRMaximalProfileSelection
```

This is mathematical source verification. It supplies no new measurements,
physical deployment certificate or historical-subject identity evidence.
