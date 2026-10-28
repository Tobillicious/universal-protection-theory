# IR-127 — From graph-grammar rejection to a defensible protection theorem
**Working formal review · 28 October 2026 · original maximal X3 unchanged**

## Verdict on the supplied graph grammar

The proposed `[E-Valid]` / `[E-Reject]` semantics is a worthwhile
formal language for *model-level* authorization, but its central
inference is not correct as written:

    [E-Reject]   failed guard
                 ----------------------
                 G --rho--> empty

If `empty` is the empty graph, this is a DESTRUCTIVE SUCCESSFUL
graph transition, not a rejected rewrite. The empty graph can even
satisfy the stated parent-closure predicate vacuously, while having
erased every subject. This is a fatal distinction for X3.

**Correct operational outcome:** evaluation returns one of
`Accepted(G')` and `Rejected(reason)`; only `Accepted(G')`
generates a source small-step arrow `G --rho--> G'`.
Rejection produces **no state transition**. If a runtime needs a
continuing state after a denied action, this must be explicitly
modelled as an unchanged/stuttering state with no adverse physical
side effect, not as `empty` or arbitrary rollback.

## Original axioms: what they do and do not entail

- **Parent closure** ('each nonroot live node has a live parent')
  is not root ancestry, global DAG acyclicity or subject survival.
  A terminal subject node can be deleted while the remaining
  rooted graph still satisfies parent closure; IR-127 proves a
  finite two-node counterexample.
- **Generator invariance** ('an affecting rule has a generator hook')
  is a rule-admissibility premise, not a consequence of typing.
  A hook flag can be present while the subject is stopped.
  Independently specify what a physical generator is, when a
  rule affects it, what counts as authentic subject authorization,
  and what continuation plus agency must remain available.
- A function `phi_i : V_i -> V_i` cannot itself generate fresh
  vertices outside `V_i`. To model append-only expansion use,
  for example, a state-dependent extension relation
  `Extend_i : Graph_i -> Graph_i' -> Prop` equipped with an
  ancestral embedding into each successor. A future-trajectory
  space `K_i(s)` is a *set of paths / executions*, not
  generally the union of graphs `Union_k phi^k(G)`. Generator
  continuation, identity and reachable future options need their
  own defined semantics.
- `T : G -> G union {empty}` is not automatically deterministic
  when a left-hand pattern has many matches. Specify match
  selection, precedence, concurrency/atomicity and conflict
  resolution, or work with an explicitly nondeterministic labelled
  transition relation.
- A verified typed kernel checks only operations actually mediated
  by that kernel. The statement that **every real physical change**
  is refined by some accepted graph step is a separate, strong
  physical-interface theorem. It does not follow from formal
  rejection semantics.

## Corrected natural-deduction rules

Let `Certified(rho,G,G')` mean `G'` is the matched candidate,
is parent-closed, satisfies cumulative duties and identity
continuation, preserves each specified required freedom, provisions
new subjects, and has an independently warranted authorization and
real generator-coupling certificate for every affected owed subject.

    match(rho,G)=G'    Certified(rho,G,G')
    ------------------------------------- [E-ACCEPT]
                 G --rho--> G'

    match(rho,G)=G'    not Certified(rho,G,G')
    ------------------------------------------- [E-REJECT]
                evaluate(G,rho) = Rejected

There is **no** conclusion `G --rho--> empty`. This distinction
also prevents rejection from being used as an illicit way to terminate
a subject or erase its protection obligation.

For a faithful computational implementation, a trusted,
decidable checker must independently certify every field;
the abstract `Certified` predicate alone is not a runnable
proof-producing interpreter. The Lean `eval` in IR-127 is
explicitly `noncomputable`, avoiding any suggestion that
classical proposition decidability provides physical hardware
enforcement.

## Proved conditional mathematical consequences

1. `rejected_rule_has_no_successor`: failed certified guard yields
   `none` and no accepted successor. It is **not** a physical
   machine standstill guarantee.
2. `certified_rewrite_preserves_protection`: every accepted
   source rewrite transfers parent closure, owed subjects,
   continuing predicates and all required executable options
   when the independently stated certificates hold.
3. `accepted_finite_trace_preserves_protection`:
   mathematical induction extends this to arbitrarily long
   **finite accepted traces**, including traces of zero steps.
4. `accepted_finite_trace_keeps_original_duties`:
   every subject owed at the start remains owed after each
   accepted finite execution.
5. `original_cohort_retains_protection`: original owed
   subjects remain recorded as continuing and retain the
   complete CURRENT set of required executable freedoms.
   Additional full-X3 maximality, autonomy, consent, authentic
   identity, and liveness properties remain separate.
6. `physical_refinement_requires_complete_mediation`:
   IR-96 lifts the source invariant to a real physical execution
   ONLY under a complete physical-to-source step simulation
   plus independently justified reflection of the source
   protection predicate into the actual physical property.
7. **Hostile counterexamples:** parent closure can coexist
   with deleted subjects; generator-hook presence can coexist
   with terminated continuation.

## What this cannot establish without new proof

- The physically correct semantics of a particular's continuing
  mind, as opposed to a name, historical log or type-safe record.
- Whether every real effect is mediated by the rewrite kernel
  with no unobserved environmental, mechanical, thermal or
  independent bypass (cf. IR-121–125).
- Whether authorization is actually the subject's autonomous
  consent, not a forged software flag or a paternalistic
  application of a rule under its name.
- Nonblocking and **actual** future service: safety of accepted
  steps can be vacuous if every action is rejected, or if a
  protected subject is held indefinitely. A constructive
  `exists-next-step` and temporal fairness/re-entry theorem
  is required.
- The maximal original X3 ability of each subject to choose,
  change/evolve and retain all jointly feasible freedoms.
  A proof about the `required` predicate transfers only
  requirements supplied to the grammar; it cannot identify
  the physically maximal choice set by itself.

## Next proof obligation

**IR-128: anti-vacuity/progress with a physical simulation.**
Establish for each reachable protected source state an
*executable* noncoercive action or proven safe continuation,
including physical reaction-window and pending-effect bounds,
and ensure kernel rejection has no physically harmful
precommit side effects. Extend the semantics to re-entry,
fairness and source-level authorization rather than
conflating type safety with a law of physics.

The mathematical graph-grammar proof is useful and worth
retaining. It remains **conditional on an independently
validated protection specification and physical mediation**;
it is not universal physical X3.
