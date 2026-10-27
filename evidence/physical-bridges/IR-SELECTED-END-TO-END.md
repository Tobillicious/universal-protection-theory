# Selected-policy end-to-end composition (IR-17 to IR-10)

This draft imports unchanged IR-10 (IREndToEnd) and IR-17 (IRSelectedMaximality), then proves IRSelectedEndToEnd.selected_conditional_end_to_end_certificate.

## Interface improvement

Earlier IR-10 requires (1) global full-safe-menu cofinality, and (2) a realising observation-uniform policy for EVERY outcome in the safe menu.

The new theorem instead accepts a GIVEN outcome and observation-uniform policy, with:
- local maximality in the unchanged original UPT stagewise order;
- no originally feasible omitted option strictly improving that selection;
- a policy which realises the selected outcome and preserves the modeled kernel.

The conclusion preserves the existing IR-10 composition: original full-feasible maximality, policy realisation, conditional held-state refinement, greatest model kernel, finite-run safety, source-to-record observational correspondence, and the model's post-effect limit.

## Still conditional

NoExcludedImprover is a named, load-bearing property of the original full feasible family, NOT a conclusion proved for actual hardware. Replacing cofinality with this weaker condition does not prove feasibility or eliminate the need for external physical evidence.

Original sensor/latency/effect budgets, complete physical-log correspondence, continuation semantics, nondeterministic model coverage, kernel existence, and physically executable policy remain unverified for a real installation.

The IR-10 equality of beforePhysical and afterPhysical is conditional on both endpoints matching the log projection. It must NOT be used to deny unmodeled external drift: IR-12 supplies a distinct bounded-drift model. Integrating that stronger model is a subsequent obligation.

## Verification gates

- [ ] Pinned Lean 4.35 CI green
- [ ] Manually inspect theorem signature and printed axioms
- [ ] Check no physical or semantic premise was dropped
- [ ] Verify negative control from IR-17 (excluded strict improver)
- [ ] Keep as draft; no merge or publication without author review

X3 and all canonical UPT priorities are unchanged.
