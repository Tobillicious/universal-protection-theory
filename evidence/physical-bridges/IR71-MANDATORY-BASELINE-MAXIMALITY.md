# IR-71 — Coupled infinite maximality from a mandatory feasible baseline

IR-70 proved that an unrestricted positive duty such as **retain
particular A** is not downward-closed and so cannot be represented
exactly as a family of forbidden retained-fact patterns. This is
a limitation of that particular representation, not proof that
infinite original-order maximality fails.

IR-71 introduces a mathematically different construction that
keeps a **mandatory protected baseline** throughout optimization.

## Original-order theorem

Let every outcome be an arbitrary retention subset of two
countably infinite original priority layers (tagged `Bool × Nat`).
Let finite forbidden patterns couple these priorities arbitrarily.
Let `required` be the mandatory set of retained facts, and
assume independently that `required` satisfies those physical-style
constraints.

The complete feasible family is defined as:

`RequiredFeasible required outcome` precisely if
`outcome` satisfies the common finite-conflict predicate AND
every fact in `required` occurs in `outcome`.

This family is not downward-closed globally.

The source-level construction starts **from required**, not empty.
Its first infinite greedy phase adds higher-priority retained
facts where jointly feasible. Its second infinite phase starts
from that limit and adds lower-priority facts while leaving
higher-priority retention unchanged.

The module proves that every finite phase retains the baseline,
both infinite limits are feasible, and no outcome in the **whole
required-feasible family** is strictly better in the *unchanged*
original two-stage `UPTExist.LexBetter` order.

A second theorem connects this construction to IR-69's
nonnegative additive bounded resource costs and finite
cross-priority causal conflicts. This retains mandatory positive
protections and still derives original-order maximality, conditional
on the mandatory baseline being **genuinely jointly feasible**.

The module also proves that such positive-duties feasibility
is not downward-closed as a predicate on all retention sets,
so the construction does not hide IR-70's counterexample.

## Physical and original-X3 limits

This is **NOT** evidence that any particular required physical
history or complete original X3 freedom bundle is jointly feasible.
It formalizes what follows IF an independently specified set
of mandatory retained facts has a physically feasible implementation
in a source-specified bounded resource/finite-conflict world.

A real feasibility predicate might also include adaptive plans,
positive service duties, nonadditive dynamics, histories and
infinite-tail conditions not represented by these source-level
retention facts. It is open whether full original X3 semantics
can be represented faithfully by mandatory facts plus finitary
optional extensions.

No claim of actual physical deployment, the physical continuation
of any particular, or all-stage original X3 maximality follows.
No canonical archived source is altered; all claims are conditional.
