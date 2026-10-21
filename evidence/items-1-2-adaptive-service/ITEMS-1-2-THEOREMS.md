# Adaptive withdrawals and the joint service law

21 October 2026. Items 1–2 of THEORY-CORE §5. These results use the existing provider-role subset-fault law in P-ROUTES/P-FAULT as written; they add no provider independence or outcome-nonadaptivity premise. The physical derivation/instantiation of that existing fault law remains item 5. The law, horizon, capacities and protection budget are retained.

## A. Exact adaptive-removal theorem

For any outcome, let N be the number of roles, F the number faulted, R a removal set of size at most W, and S the surviving service count. P-ROUTES' exhaustiveness gives

`S >= max(0, N-F-W)`.

This is pointwise. R may depend on the entire outcome, on the faults, and on every service result. No timing, probability or independence assumption about R is used. The bound is sharp for every N,F,W: remove successful roles first. In the equivalent potential-success formulation, the exact minimum is `max(0,S0-W)`.

For an integer service threshold K>=1, a shortage S<K therefore implies

`F >= N-W-K+1`.

For rescue, `2S<=N` implies `F>=N-W-floor(N/2)`. At N=115200 and W=42800, holding K=45743 requires at least 26658 faults to fail, and rescue at least 14800. Both shortage events are included in F>=1000, a deliberately loose screen. F<=999 leaves at least 71401 serving roles.

`proofs/AdaptiveWithdrawal.lean` checks the count inequality, event inclusion, both numerical thresholds, the 71401 guarantee and a construction attaining the exact survivor lower bound for every parameter. Removal bits are arbitrary, not generated before or independently of service bits. Its printed axiom audits identify only Lean's standard axioms.

## B. Subset law implies the joint service moment

At an arbitrary admissible pre-window history h, write X_i for role i's fault indicator. The source's role-level subset law is, for every fixed subset A,

`P(all i in A fault | h) <= p^|A|`.

For z>=1 the finite product identity and nonnegative coefficients give

`E[z^F | h] = sum_A (z-1)^|A| P(A subset of faults | h)`

`<= sum_A (z-1)^|A| p^|A| = (1-p+pz)^N`.

Putting S0=N-F yields

`E[z^(-S0) | h] <= (p+(1-p)/z)^N`.

Thus the joint service moment is a consequence of the existing subset law. It is not a product-of-marginals assumption. The same expansion works with heterogeneous fixed subset bounds `product_{i in A} p_i`, giving `product_i(p_i+(1-p_i)/z)`.

At p<=1/500, this also dominates the old up/down-factor bound for the full pool: for each weight 0<=w<=1, `p+(1-p)/z <= 1-w(1-p)+w(1-p)/z`. The literal P-ROUTES argument can therefore use the stronger direct physical-service bound and avoid the extra service-moment contract. The separate vacancy PGF and unrelated physical/security accounts are not silently removed.

For arbitrary fully adaptive removals, theorem A transfers shortage events to the *full-pool* potential service/fault event. One must not apply a fixed-subset probability to the randomly selected survivor set. The proof never does so. It also permits dependence between fault and removal sets, provided the source's fault subset bound holds for the fault law at the stated history.

## C. Sharp probability bound for every world parameter

Under just the same subset inequalities, for 1<=k<=N define

`A(N,k,p) = min(1, min_{1<=r<=k} [C(N,r) p^r / C(k,r)])`.

Then **the largest possible P(F>=k) is exactly A(N,k,p)**. This statement holds for every N,k and 0<=p<=1, with arbitrary fault correlations permitted by the subset inequalities.

Proof of the upper bound: `E[C(F,r)] = sum_{|B|=r} P(B subset of faults) <= C(N,r)p^r`. On F>=k, `C(F,r)>=C(k,r)`, so Markov's inequality gives each displayed bound. Take their minimum and one.

Proof of attainability: with probability A choose a uniformly random k-element fault set, and otherwise choose no faults. Every fixed r-subset has inclusion probability `A C(k,r)/C(N,r)` for r<=k and zero for r>k. By the definition of A all subset constraints hold. Its tail probability is A. This is an exact extremal construction, not a seeded simulation or an independence assumption.

For k<=0 the sharp tail is one; for k>N it is zero. The case p=0 is included. Combining A with theorem A gives the exact worst-case single-threshold service failure over adaptive removals for all N,W,K and p, within the source's role/fault model. The attacking erasure strategy removes successful roles first. The extremal fault law and this strategy attain the bound. For every admissible history the argument repeats conditionally, so subsequent history-dependent choices do not invalidate the per-window bound.

The PGF inequality is sharp too: independent Bernoulli(p) faults attain equality in every subset bound and hence in the product expression. This does not assert that independence maximises every tail; theorem C supplies the exact tail optimum over the larger correlated class.

## D. Existing design point and complete ledger

For the deliberately loose fault screen k=1000, a sufficient simple certificate is

`b = C(115200,1000) / 500^1000`.

The source role-fault subset law and a union bound give P(F>=1000)<=b. This is a looser r=k member of theorem C; numerical optimisation is unnecessary for retaining the existing target. Exact integer comparisons give `10^120 b < 10^-83`, and all four channel charges in each of four phases total `16*10^120 b < 10^-80`.

Replace only the holding, rescue and coordinated-load account expressions by `10^120 b`, `10^120 b` and `2*10^120 b`. Keep all other 18 accounts, the reserve and C2 charge. Recompute all ten rows for both plants and both error laws: 40 complete 21-account ledgers, with 720 unchanged other-account cells. Each plant remains below 2.1e-7; three k=3 phases plus twilight remain below 8.4e-7, or 8.8e-7 with C2 charged in every phase, below 1e-6.

This closes P-PROV's *non-adaptivity clause* for the existing design point and derives the joint service bound from P-ROUTES' existing subset law. The physical count cap W remains a world/capability parameter, with its exact optimal pathwise effect proved in A; no cooperative choice has been introduced. P-ROUTES' statement applying the fault subset law to provider-role non-service is used explicitly, not inferred from site marginals or component measurements.

## Checks and boundaries

The exact checker covers 87381 outcome/removal pairs and 4097 sharp-cap instances, all 6435 denominator-eight laws on three fault bits (1037 obey the subset constraints), correlated admissible laws, marginal-only countermodels, sharp attainable bounds across 324 parameter instances, and all 40 ledger rows. General probability statements B–C are analytical proofs; the Lean file checks A and the existing finite union/coupling components are retained. Finite enumeration cross-checks the general statements; it is not their general proof.

The two-role control retains the earlier counterexample: fixed removal gives failure 1/2, fully adaptive removal 3/4. It refutes copying the fixed-subset tail unchanged; it does not refute the shifted, full-pool theorem proved here. A common-outage law satisfying only marginals violates the subset/product bounds; a mutually exclusive fault law satisfies the subset inequalities without being independent.
