# IR-140 — Joint policy maximality does not entail worldwise maximality

**29 October 2026 (NZDT). Draft, non-canonical hostile control. Original all-particular/four-stage X3 unchanged.**

## Provenance and target

Review target: [compiled strongest PR #178](https://github.com/Tobillicious/universal-protection-theory/pull/178), head `1d5488de2baf6891a74d70a7b7e15d37dba25099`, specifically `evidence/compiled-strongest/lean/CommonPolicyMaximal.lean`, `CommonPolicyTop.lean` and Part XII.2 item 4. This is a separate negative-control result based on `main`: it does **not** rewrite, cherry-pick, narrow, or merge the compiled candidate.

The `CommonPolicyMaximal.common_policy_maximal` statement uses world-indexed facts `(stage, (world, particular))` and obtains one policy whose **joint** set of facts admits no lexicographically better **joint** feasible set, assuming compact policy space and closed fact-realisation sets. This is a valid joint maximality claim. It does **not** imply the stronger per-world quantification:

- Joint: **exists policy q; for all rival q', not LexBetter(joint(q), joint(q')).**
- Worldwise: **exists policy q; for every world w, for all rival q', not LexBetter(out(q,w), out(q',w)).**

The manuscript already distinguishes a stronger **top** result under a union-closure assumption. This control tests that the distinction is kept explicit in the S2/S10/physical-X3 joins.

## Exact two-world countermodel

Take worlds `w0,w1`, policies `left,right`, and original four priority stages (0 existing continuation, 1 existing freedom, 2 new continuation, 3 new freedom). All facts lie at stage 0.

| Policy | w0 | w1 | Joint facts |
| --- | --- | --- | --- |
| left | keeps a | keeps none | {(0,w0,a)} |
| right | keeps none | keeps b | {(0,w1,b)} |

There are no other feasible policies. The two worlds give the same observation before choice, so a policy cannot switch based on which world obtains.

**All of the abstract `CommonPolicyMaximal` structural assumptions hold:** the two-element discrete policy space is compact; every fact's policy-realisation preimage is closed; the mandatory baseline is empty and all freedom prerequisites hold vacuously. Both joint outcomes are inclusion-incomparable at the first priority stage, so **both are jointly lexicographically maximal**. Yet `left` is strictly worse than `right` in `w1`, and `right` is strictly worse than `left` in `w0`. **No policy is maximal in every world.**

The union of the two outcomes is unrealizable, so `CommonPolicyTop`'s union-closure premise is false here, exactly as required. An additional `both` policy would remove the obstruction *if it were genuinely executable*; admitting it by definition is not a physical construction.

## Reproduction

```sh
python3 evidence/physical-bridges/ir140_common_policy_countermodel.py
```

This deterministic finite checker exhaustively compares the two policies at all four original stages, confirms each is jointly maximal but fails in one world, and checks failure of union closure and indistinguishable observations. It uses Python standard library, no random choices. It is **not** a Lean proof or physical experiment; independently recheck its encoding against the Lean `LexBetter` definition.

## Consequence for the preserved strongest theorem

Keep all original X3 demands: every actual particular and relation; genuinely same continuing history and independent direction; the complete physically feasible four-stage family; protection against real action-reactive opponents. Do not replace them with joint-menu maximality.

To obtain the *worldwise* conclusion for a fixed observation-only policy, supply **at least one** independently justified bridge:

1. **Uniform realizable top:** prove a union-closure/concurrent-emulation mechanism that works with the **actual** shared resources, deadlines, and hidden observations (the `CommonPolicyTop` route), or
2. **Common worldwise maximal selector:** directly show the intersection of worldwise-maximal policy sets is nonempty, by source-executable, observation-compatible witnesses. IR-113/135 may help state this condition but cannot generate a policy from incompatible observations, or
3. **Weaker but expressly conditional theorem:** retain the correct joint-maximal statement while marking the worldwise original-X3 physical bridge open, without redefining X3 as a weaker objective.

This is complementary to existing IR-135 hidden-world obstruction and IR-139 executable-rival falsification. It is **not** a new empirical claim, no argument that original X3 is false, and not permission to narrow its objective.

**Disposition:** focused countermodel; Python exact checks performed locally; pending independent mathematical/Lean review. No canonical manuscript, publication, or physical-installation claim changed.

