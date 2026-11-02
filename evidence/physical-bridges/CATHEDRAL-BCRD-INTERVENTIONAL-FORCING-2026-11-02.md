# Cathedral — interventional boundary forcing and topological finite witnesses

Date: 2 November 2026 NZDT. Focused stacked research candidate on PR #205, with original X3 and canonical source unchanged. Formal abstract result, NOT actual physical BCRD completeness.

## The forcing join (rather than assuming a guardian)

For source states S, action types A, cut b:S→O, original protection P:S→Prop, independently sourced permission/executability Allowed(s,a) and modeled source transition Step(s,a,t), define:

- Bad(s,a) := exists t such that Step(s,a,t) and NOT P(t).
- Guard(s,a) := Allowed(s,a) and for all t, Step(s,a,t) implies P(t).

PR #205 gives the necessary-and-sufficient protected-fibre common-action criterion.

**INTERVENTIONAL-FORCING:** Assume (i) for any protected s,t with b(s)=b(t), the *same physical action* a has the same Allowed and Bad response bits at both states for every a; (ii) every independently specified protected source state has at least one actually allowed robustly safe action; (iii) the ambient action type is inhabited to define policies on empty cut fibres. THEN a common safe action exists on each protected cut fibre and PR #205 gives a cut-only guardian.

Proof: choose a representative of each nonempty protected fibre; use its independently viable action. Equality of permission and bad-outcome responses transfers that exact action to every state of the fibre. Use a default only on empty fibres. This is a conditional existence theorem (classical choice), not executable code or a deployed guardian.

The stronger *source-facing* way to establish assumption (i) is to derive permission and bad-event response functions on the cut, satisfying:

    Allowed(s,a) <-> PermissionAtCut(b(s),a)
    Bad(s,a)     <-> FailureAtCut(b(s),a).

The new Lean module proves both versions and a three-state higher-order obstruction. Crucially, these response factorizations are **premises to prove from physical BCRD sources**, not supplied by PR #205. Deriving them must independently establish actual physical intervention identity, permission/executability, allowed disturbance successors, protected-being semantics and failure observability. Do not define a cut by sneaking the desired Guard/P response into it.

The frozen BCRD B1 predictive completeness is about future observable statistics. B3 addresses causal intervention response and B4 forbids universal physical spectators, but B1–B4 **do not automatically establish** that all original-X3 action-indexed counterfactual bad outcomes, authorisation and executability factor through the *guardian's specific cut*. Nor do they show pointwise availability of any safe action. Thus the actual physical forcing direction remains OPEN.

## Minimal topological lemma (the infinite-fibre continuation)

For one protected cut fibre let C_s={a in A : Guard(s,a)}. If A is compact and every C_s is closed, then

    (intersection over all s of C_s is nonempty)
       iff
    (every finite subfamily of C_s has nonempty intersection).

This is the closed-set finite-intersection property for compact spaces. Its contrapositive makes every failed infinite common-action criterion admit a **finite counter-witness**. It does NOT establish the requisite finite consistency, or a fixed size bound on witnesses, by topology alone.

If, in addition, the physically feasible action space A is a compact convex subset of R^d, and all C_s are closed convex, finite Helly plus compactness reduces the sufficient check to **every subfamily of at most d+1** states. In dimension one pairwise is enough; in dimension two triple checks are necessary. Source-certified action space dimension, convexity, closedness and exhaustive family coverage remain essential.

## Countercontrols that invalidate tempting shortcuts

1. **Three protected states, pairwise-compatible but globally incompatible.** Actions {a,b,c}; safe sets {a,b}, {b,c}, {a,c}. Every pair has a common action, yet the full intersection is empty. IR-108's pairwise obstruction alone is therefore insufficient for an exhaustive test.
2. **Connected compact one-dimensional obstruction.** A=S=[0,1], b constant, and C_s=[max(0,s-1/4),min(1,s+1/4)]. All individual sets are nonempty, closed, convex, continuously varying. C_0 and C_1 are disjoint. State/cut topology and individual convexity do not force the guard.
3. **Two-dimensional convex Helly witness.** A=[0,1]^2, C1={x>=4/5}, C2={y>=4/5}, C3={x+y<=13/10}, intersected with A. Pairwise witnesses (4/5,4/5), (4/5,1/2) and (1/2,4/5) exist, but x+y>=8/5 contradicts x+y<=13/10 for the triple.

These are abstract source-interface examples, NOT instantiated BCRD physical states.

## Exact tests

The independent standard-library checker passes locally:

- **32,768** configurations (3 states, 2 cut readings, 3 actions, 8 protected-state subsets and 512 safe masks); **24,996** have a guardian. Cut-only policy enumeration agrees with fibre intersections in every case.
- **262,144** independent 3×3 Allowed/Bad response tables; **50,653** are pointwise viable with all three protected. Across eight cut maps, **8,288** response-complete and viable cases necessarily have a guardian.
- Higher-order obstruction and connected/convex countercontrols passed.

Tests do not certify true physically available interventions, BCRD's actual cut response mapping, statewise original-X3 viability or mediating real effects.

## Next source-facing proof obligations

1. Recover actual action-indexed permission and failure signals from the frozen BCRD event/source model *without* inserting Guard or P into the cut definition. Show their cut factorization or find an aliasing witness.
2. Prove nonempty physically authorized robust safe actions at all actually relevant original-X3 protected states; include disturbances and real actuation/resource budgets; vacuous no-successor safety is not ongoing freedom.
3. Show all real effects are mediated by the chosen cut guardian (PR #205 IR109/IR96 and IR123–127), and map the abstract P to original continuing identity, agency and four-stage X3 maximal freedom.
4. If infinite action/fibre topology is invoked, prove compactness and closedness from the source; if Helly is invoked, independently prove convexity and the true effective action dimension.

**Disposition: abstract conditional forcing PROVED in source-level logic (Lean CI status separately checked); finite countercontrols PASS; actual physical BCRD→original-X3 forcing OPEN.** No canonical edits, merge, or new cosmological claim.
