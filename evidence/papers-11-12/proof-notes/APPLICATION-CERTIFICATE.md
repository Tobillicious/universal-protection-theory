# What would connect the constructions to a hold application

The bank supplies mathematical components, not a filled application certificate. A complete application can use different sufficient components, but their interfaces must compose.

| Obligation | Evidence supplied here | Application evidence still absent |
|---|---|---|
| Outcome order | Full canonical preorder, upward-event and stagewise equivalences; selective-repair alternative | Correct outcomes/feasible policies for the application and the selected normative order |
| Commit semantics | Deterministic ideal, preserved journal/sink prefixes and explicit reconstruction convention | Which implementation events are resident steps, effects and permitted reconstruction; identity correspondence |
| Persistent effects | One-pending-step proof with an atomic ordered sink | Durable journal/sink atomicity, effect-to-ID transaction or another sufficient effect interface |
| Monitor | Continuation congruence and a complete protected counter contract | Sensor coverage/granularity, invariant enforcement, reset/wrap protection and fault model |
| Release | Verified-prefix checkpoints and a gated replay window | Checkpoint/state sizes, execution costs, service interval, crash budget and release-barrier enforcement |
| Co-hold | Closure leastness, a conditional outside full-trace proof and duration feedback | Sound dependency relation, actual boundary/freeze enforcement, outside observations and inputs |
| Resources and schedule | Conditional bill monotonicity and recovery arithmetic | Whole-boundary storage/energy/controller resources, timing and priority/service proofs |
| Lottery, if used | Sharp statistical and finite-cap budgets | Entropy, malicious setup/recovery contract, conditional error accounting, call time bounds and abort policy |

## Keep the clocks distinct

1. **Stop latency:** veto/request to the last prohibited new commit. This is where an applicable controller last-finisher/priority certificate belongs.
2. **Hold duration:** elapsed time during which commits remain fenced. Dependency tolerances and duration-dependent co-hold closure refer to a justified bound for this interval.
3. **Release/recovery latency:** resumption to a drained, continuation-safe state. The new `Tload+B Teval+Tsink` expression bounds active recovery after the last crash, with new commits excluded.
4. **Scheduling and disruption:** waiting for service, fresh crashes and contention can add elapsed time. A logical action count does not account for them automatically.

No equality among these clocks is inferred. A proposed duration bill h(C) must identify which interval it bounds and include all charged work, resources and disruption assumptions. If adding peers lengthens that interval, the closure calculation must be self-consistent at the enlarged duration. A supplied serial or parallel schedule can justify a bill; using a maximum or a sum without that schedule does not.

Storage has its own horizon/family account. A bounded replay suffix leaves the retained history footprint unbounded in the generic journal implementation. Conversely, a deterministic known trajectory may be regenerated from much less information, with a separate computation bill. Neither fact supplies a new I-1 population or resource number.

This is an obligation map for evaluating a concrete application. Empty cells are not discharged by the proofs in adjacent cells, and failure to fill this particular sufficient certificate does not prove all faithful-hold architectures impossible. The existing Paper 11 v0.17.12 rungs 3-5 are retained. This generic component map does not reopen them or add a rung; a real deployment still instantiates the declared physical premises.
