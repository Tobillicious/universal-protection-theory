# IR-70 — Exact finite-refutation criterion for the full original feasibility question

**Question:** When does a full feasible outcome family genuinely admit
the kind of finite-obstruction closure used in IR-66–IR-69?

**Answer as mathematics (not physical observation):** for an arbitrary
predicate `F : (Bool × Nat → Prop) → Prop` over the unrestricted two-stage
retention outcome universe, the following are exactly equivalent:

1. For every infeasible outcome, there is some finite list of
   its retained facts that cannot all occur together in **any**
   physically feasible larger outcome (a finite certificate that
   forces infeasibility).
2. There is a (possibly infinite) family of forbidden finite
   retained-fact patterns whose avoidance describes **exactly**
   the full feasible predicate F for every outcome.

The proof requires neither a finite number of actual outcomes nor a
finite number of forbidden patterns. The source formalizes both
directions. It also derives that such a predicate must be
**hereditary/downward closed**: if an outcome is feasible, retaining
a subset of its facts is also feasible.

Given an actual full predicate F satisfying this exact condition and
a feasible empty retention outcome, the original two-stage
`UPTExist.LexBetter` global maximality follows by the verified
coupled IR-68 proof, with no substituted feasible family.

IR-69's exact nonnegative additive resource capacity + finite hard
conflict model is a sufficient case of this criterion. Its proof
produces the finite refutation theorem by a separate source-level
derivation.

## The epistemic/physical boundary

**This does not establish that actual X3 physical feasible histories
satisfy the criterion.** The repo currently lacks a validated physical
instrument, measured full causal inventory, source-level definition of
the entire physical feasibility predicate, and experimental evidence
that every failure has a finite retained-fact refutation.

Crucially, some physical and semantic requirements are *positive
duties*, not only prohibitions on sets of retained commitments.
For such a requirement, removing a person's continuity, rights or
service could itself make an outcome infeasible. Then feasibility
might NOT be downward closed, and no exact forbidden-retained-facts
description can capture the original full feasibility predicate.
Likewise an infinite-tail requirement can fail with no finite
witness; IR-69 formally proves a counterexample.

To use these theorems for actual X3, we must either demonstrate that
all positive obligations are encoded as independent mandatory base
facts with an honest feasibility semantics, or derive a more general
closure/existence theory that allows obligations, nonmonotone
feasibility, and infinite-horizon dynamics. Simply re-labeling
positive duties as forbidden sets would silently change X3.

This theorem is an exact diagnosis of what remains to be shown.
It should not be called an unconditional universal protection or
full original-X3 feasibility proof.

## Physical verification needed

- A specific bounded instrument and independently complete causal/
  resource inventory.
- Exact physical feasible outcome semantics, retaining all original
  individuals, priorities and historical continuation rights.
- Empirical or theoretical proof of finite violation witnesses,
  including every relevant cross-stage constraint and infinite
  horizon, not just the constraints currently modeled.
- Check for physically required positive commitments and failures
  caused by removing, not merely adding, retained subjects.
- Operational existence/physical realization of selected outcomes
  and independently authenticated continued service.

**Archive policy:** original UPT source unchanged; merge independent
formal theorem only after pinned Lean and claim-ledger validation.
