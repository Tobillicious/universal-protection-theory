# IR-69 — Resource-derived closure bridge and its physical boundary

**Scope:** formal derivation from explicitly bounded nonnegative
resource capacities and finite incompatibility certificates, connected
to the **unchanged original two-stage** `UPTExist.LexBetter` order and
the entire modeled infinite feasible universe via IR-68.

## Derivation

Let a candidate outcome be an unrestricted retention subset of
`Bool × Nat` (two priority stages, countably many possible
retention facts at each stage). For every resource channel `r`,
let `weight r fact : Nat` be a nonnegative resource cost and
`capacity r : Nat` a finite capacity. No bound on the number of
channels is built into this theorem.

Define a *resource-feasible* outcome as one for which **every finite
distinct set of its retained facts** has a total cost at most the
corresponding capacity in every channel. Add independently specified
hard conflicts, each witnessed by a finite set of retained facts.

A finite set is now a **derived forbidden pattern** precisely if
it is a hard-conflict pattern, or is distinct and has total resource
cost greater than some channel capacity. The kernel proves the
equivalence:

`CapacityFeasible s ↔ Feasible (DerivedForbidden ...) s`

This is the missing finite-obstruction *representation theorem for
this concrete class of resource constraints*. Its premise is an exact
mathematical resource/cause specification, **not** an unproved
`IsFinitary` statement.

If no hard conflict forbids the empty retention state, resource
nonnegativity proves it feasible; IR-68 then derives original-order
global two-stage lex maximality across **all** feasible retention
outcomes, including infinite ones, with arbitrary cross-stage
resource competition.

A concrete shared-capacity example charges 1 for each of two
incompatible priority facts, with total capacity 1; retaining both
is infeasible, so the theorem has genuine conflict.

## Sharp countercontrol: indefinite obligations

The physical-style property `EventuallyAbsent s` says there exists
a time/limit after which none of the indexed commitments persist.
Every finite-prefix selection satisfies it, but the full infinite
selection does not.

The module proves that **no finite forbidden-pattern family is
equivalent to this property**. Therefore the finitary route does not
follow merely from asserting that some finite energy or capacity
exists. If physical feasibility includes genuine infinite-horizon
temporal/liveness/continuation obligations or global tail conditions,
we need another existence/closure argument or a genuinely warranted
finitary reduction.

## What the repository and current evidence actually warrant

The working `PHYSICAL-TEST-PROTOCOL.md` states plainly that no
particular validated physical instrument and complete inventory have
yet been supplied. The instrument evidence JSON contains OPEN fields
for real actuator admission, in-flight coverage, residual calibration,
actual service delivery and timing. The repository is therefore not
currently evidence for equivalence between **all original actual X3
physical feasible histories** and `CapacityFeasible`.

To promote IR-69 to actual X3 existence we would need:

1. **Semantic completeness:** a source-level account of every
   original particular, priority/freedom/continuation fact, and actual
   feasible history, with an outcome representation preserving every
   originally defined predicate.
2. **Sound and complete causal/resource inventory:** no physically
   consequential unrepresented channel or unbounded interaction.
3. **Nonnegative additive accounting with defensible units:** measured
   or physically derived resource costs, finite capacities and
   interactions; resource replenishment/recycling/coupled nonlinear
   effects require explicit stateful treatment.
4. **All infeasibility accounted:** any physically infeasible
   preserved-history proposal must violate one derived finite budget
   or certified finite causal conflict. This is a substantive
   completeness obligation, not a fact derived by the Lean theorem.
5. **Positive realizability:** feasible retention descriptions must
   correspond to executable/continuing physical histories, not just
   descriptions that pass numerical budgets.
6. **Infinite-horizon scrutiny:** no hidden tail-only incompatibility
   (e.g. obligations that fail only after unbounded time) is allowed
   in the claimed model class unless separately demonstrated safe.
7. **Actual protected freedom:** source-level maximality/selection is
   not equivalent to every freedom being jointly possible, delivered
   or historically continued.

This is a mathematically useful class theorem and a precise
falsification plan. It does **not** demonstrate that actual universal
physical feasibility has been proved finitary or that full X3 now
follows unconditionally.

**Merge policy:** independent source-level theorem may be reviewed
and merged once CI passes; do not promote the separate empirical and
semantic claim or merge the unverified physical-controller drafts.
