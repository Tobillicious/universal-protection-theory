# Rung 5: independent dependency certificate

21 October 2026. Codex's focused non-author check of the step from the existing conditional rung 4 to rung 5. **PASS for that dependency step, under the contracts below.** This is a successor candidate; the original v0.17.12 technical source and earlier sealed banks remain unchanged. No additional rung is introduced.

## Statement and domain

Retain the supplied, commissioned phase schedule and its proved service inequalities. Under D-ENDOW, P-ENDOW and P-ROUTES, interpret the declared provider/grid laws as the joint moment contracts specified below. Retain the physical action caps, information/timing restriction on withdrawals, cryptographic warranties, identity/population scope and all other dependencies in RUNG5-DEPENDENCIES.md. Then the protection calculation and its horizon bound apply to every assignment of values and beliefs and every command-level policy within that domain. M2, the dividend-valuation premise, is absent from protection.

The claim quantifies over permitted commands and physical interventions satisfying the stated contracts. It does not quantify over physical violations of those contracts, an unsupplied endowment, or arbitrary changes of the covered identity/population class. No mind is required to value the dividend or voluntarily continue service. D-ENDOW specifies committed hardware duty; P-ENDOW supplies its continuing physical resources. Ownership alone does not prove either implementation correctness or supply.

## The three dependencies that were actually traced

1. The legacy `flow.full` computes incentive gaps and **filters rows** when a gap is nonpositive. The TW-1 wrapper also asserts positive incentive gaps. That API remains useful for the earlier incentive question; it is not a universal protection entry point. With valuation zero it drops every row.
2. The independent `checks/rung5/kernel.py` constructs all 21 account bounds directly from physical/service inputs, without an incentive filter, valuation, disutility, belief or command-policy argument. All ten legacy grid labels are retained. The row's old response label indexes its declared vacancy law; it does not supply the new hardware-service probability.
3. At each fixed vacancy law and physical cap, replacing the old service probability by at least 499/500 weakly decreases holding and rescue, and their coordinated-load sum. No other account or reserve reads that service probability. Changing valuations/disutility in the unfiltered captured calculation leaves 1,260 account cells unchanged. A deliberately injected economic term is detected, demonstrating that this check can see such a dependence.

The captured original baselines match 420 account cells exactly. An independent 512-bit outward rational implementation checks 1,680 account comparisons across both plants, all ten rows, old/new service and the two error-law choices. Its analytical upper enclosures do not exceed the captured conservative bounds. The five vacancy cutoffs are checked by the two adjacent exact inequalities, independently of the source's cutoff search.

## Joint laws used by the account formulas

Let n=115,200 provider roles, W at most 42,800 removed before the outcomes they could target, D the remaining down count, and u=n-W-D. Let pc be the physical service lower bound, at least 499/500 at the selected p_role=1/500 design point. The two-state availability law supplies weights 29/30 and 1/2 for the declared up/down classes.

The holding/rescue proof uses **joint lower-service moment domination**: for every z in the declared finite grid, the relevant success count S has

`E[z^(-S)] <= (1-(29/30)pc+(29/30)pc/z)^u (1-(1/2)pc+(1/2)pc/z)^D`.

Rescue uses the same expression with z replaced by z squared. Holding multiplies by z^(needed-1); rescue multiplies by z^n. Minimising these Markov bounds over the declared grid gives the account bounds. Independent Bernoulli service with these parameters is one sufficient implementation; any joint process satisfying the moment bounds is also sufficient. Neither single-role pc nor the two-state marginal transition matrix alone establishes the product bound.

The vacancy proof uses the declared joint domination

`E[z^D] <= (15/16+z/16)^115200 exp(400 mu (z-1))`

at the trials named by the model. This can be supplied by the stated binomial/Poisson domination, including its required joint law. A mean vacancy rate alone is insufficient. At the model's admissible histories, where an adaptive decision uses conditional bounds, these contracts must hold in that conditioned setting. Unconditional marginals cannot silently replace them.

These are the precise probabilistic meanings needed from the existing grid-law premise. They remain declared physical/process contracts. They are not inferred from M2, average drive failure rates, a privacy slogan or the finite arithmetic checks.

For physical site losses, retain the specified subset law for complete windows including timeout exclusions. For the mixed-host committee, host blocks are independent under the declared law: a shock makes all seven jobs erroneous; otherwise seven independent jobs each err with probability 1/10. Positive host-shock marginals alone do not imply that law.

## Monotonicity proof

For z>1 and 0<=pc<=1, each factor `1-w pc+w pc/z` and `1-w pc+w pc/z^2` is nonnegative and non-increasing in pc. Products and nonnegative integer powers preserve that comparison. Taking the minimum over the same finite grid and clipping at one preserve the analytical comparison. The outward arithmetic ceiling at pc=499/500 then bounds every larger pc; no general monotonicity of a floating representation is assumed. The holding, rescue and coordinated accounts therefore do not increase. Vacancy, site losses, geometry, cryptography, arrivals and committee errors are unchanged when their own supplied laws are held fixed. The complete account sum plus reserve is consequently bounded without an incentive assumption.

The general algebra is analytical. The independent program checks its finite instances and exact account composition; it is not advertised as a Lean measure-theory proof.

## Error-law integration and actual bounds

The old approximately 8.24e-7 four-phase figure belongs to the baseline independent-job calculation. The technical source also permits the JW2.7 **replacement** mixed-host law. The latter changes the committee entry, its reserve contribution and the legacy single-host quorum predicate. Both error laws were checked separately; their figures are not interchanged.

At the already published safe host-shock input q=0.000153588285, independent integer polynomial convolution agrees exactly with the source's different shock-count calculation at q=0, that q, and its adjacent grid point. The new audit does not claim that the published q is a global or rung-5-optimal physical threshold.

For the physical-service rung-5 ledger, the mixed-law analytical upper expressions have decimal displays approximately:

| Plant | Complete 21-account expression plus reserve |
|---|---:|
| TW-1, k=2 | 2.09995644860263289941492e-7 |
| pre-twilight, k=3 | 2.09521944001051452564734e-7 |
| three pre-twilight phases plus twilight | 8.38561476863417647635697e-7 |

The displays are rounded down; decisions use the exact rationals. The rigorous convenient ceilings are **each plant <=2.1e-7**, and **the complete four-phase schedule <=8.4e-7 < 1e-6**. Charging the separate C2 lockstep allowance of 1e-8 in each of the four phases gives **<=8.8e-7 < 1e-6**. No independence between phases is needed for this union bound. The common allowance and reserve remain charged; neither is removed as a saving.

The k=3 failure certificate remains strictly smaller than TW-1's at this point. A separate full-budget site-fault sensitivity witness also retains the wider k=3 certificate; it is labelled separately from the p_site=p_role=.002 design point. Resource margins and the existing repair/quorum/transition inequalities are retained; this audit does not turn an unmeasured target into hardware evidence.

These intervals enclose **analytical union-bound expressions**, not lower and upper measurements of true failure probability. In particular a computed bound exceeding a target does not prove that actual protection fails at that rate.

## Controls and remaining classification

- A zero valuation removes every row in the old incentive-filtered API; all ten physical-ledger rows remain.
- A common service outage can give each role marginal service 499/500 while a two-role failure probability is 1/500, above the product-law allowance 1/250000. The weaker marginal premise is rejected.
- A pool-wide common shock can satisfy every host's shock marginal and break the independent-host tail. The host-block joint law is explicit.
- In a two-role toy model, withdrawing one fixed role leaves failure probability 1/2; choosing the withdrawal after seeing outcomes raises it to 3/4. The numerical withdrawal cap alone is insufficient. P-PROV's information/timing condition remains a declared premise, not a consequence derived here from Mode C or P-REDRAW.
- The mixed ledger does not retain the baseline 8.24e-7 figure. Its corrected ceiling still meets the original budget.

The complete per-account and 32-item premise classification is in RUNG5-DEPENDENCIES.md. Physical realisation and current-source empirical validation remain application work. Signal travel time supplies propagation constraints, not an end-to-end latency guarantee; marginal drive statistics do not certify the joint all-cause site law. The retained measurements are labelled component observations.

## Replay

From the release root, run `python3 reproduce.py`. It includes `checks/rung5_dependency_check.py` and five explicit false-claim controls. That program can also run alone, using Python 3.9 or later and only the standard library. It imports no network or measurement collector. The independent mathematical kernel does not import the captured oracle; the oracle is used solely for source comparison and the legacy-filter controls.
