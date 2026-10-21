# Rejection sampling with statistical error: an exact budget

This independent derivation supplies a candidate mathematical budget for the statistical lottery route. It does not implement or attack a VSS protocol.

Let Q be uniform on q field residues, with 1≤m≤q. Rejection sampling accepts A={0,…,c−1}, where c=m floor(q/m), and returns the accepted residue modulo m. Write a=Q(A)=c/q. Uniform accepted residues induce the uniform distribution on m options.

Assume **at every reachable attempt history** that the next raw law P has total variation at most ε from Q, and that the attempt returns a well-typed field value. These are end-to-end round assumptions, not consequences of the population threshold alone.

## Conditioning bound and sharpness

Let p=P(A)>0. For distributions restricted to A,

`2 TV(P(.|A),Q(.|A)) ≤ (Σ_A |P−Q| + |p−a|)/a ≤ 2 TV(P,Q)/a`.

The first inequality writes P/p−Q/a as (P−Q)/a + P(1/p−1/a). The second uses |p−a|≤Σ_{A-complement}|P−Q|. Mapping accepted residues to options cannot increase total variation. Every distribution on m options is at most 1−1/m from uniform, so the resulting bound is

`TV(option,uniform_m) ≤ min(1−1/m, ε/a)`.

It is sharp for the permitted raw-law class. Transfer ε of probability from accepted non-target residues to a target accepted residue, while leaving acceptance probability a unchanged. Until all non-target accepted mass is exhausted, the option deviation is ε/a. At ε=a(1−1/m), a point mass is obtained and the cap is attained.

For q=5,m=3,ε=1/100, the raw law `(21/100,19/100,1/5,1/5,1/5)` has TV ε. Its eventual option law is `(7/20,19/60,1/3)`, with TV **1/60**, exactly ε/(3/5). This strengthens the earlier counterexample to the unamplified-δ assertion.

## Adaptive histories and termination

If ε<a, the conditional acceptance probability at every history is at least a−ε. Thus the probability of reaching attempt N+1 is at most `(1−a+ε)^N`: termination is almost sure, with expected attempt count at most `1/(a−ε)`.

Conditioned on the particular history where an acceptance occurs, the selected option law satisfies the same ε/a bound. The final law is a mixture of these conditional accepted laws. Convexity of total variation preserves the bound, so arbitrary history-dependent choices of P cannot worsen it. Independent stationary attempts attain the sharp examples above.

If ε≥a, the raw-law allowance can permit all acceptance mass to be removed; almost-sure termination no longer follows from this premise. A small correctness error also does not prove that a protocol call itself returns. Call termination/timeouts remain a separate assumption.

## Candidate parameter contract

For desired complete output error Δ<1 and the constant-round guarantee above, a sufficient choice is

`ε ≤ a Δ`.

With n contributors whose conditional per-call failure bounds compose by a union bound and whose ideal resource yields the required raw uniformity, it suffices to allocate each call at most `a Δ/n`. This assumes fresh conditional entropy, consistent/private/binding sharing and validated recovery. It does not derive those cryptographic guarantees.

An alternative is a summable failure allocation, such as `Δ/2^r` to the r-th complete round. Coupling with an ideal run and a union bound then gives total failure at most Δ, provided good rounds simulate the ideal resource. Every call still needs a termination rule. `ErrorBudget.lean` checks the finite weighted union and coupling-event bounds; the infinite-series/termination arguments in this note are analytical, not represented as a Lean measure theorem.

## A finite-cap contract that reports abort

For a hard cap N, report an explicit abort after N rejections. Under the conditional raw-law premise, abort probability β is at most `(1−a+ε)^N`. Conditioned on an acceptance within the cap, the same mixture argument gives option TV at most ε/a. On the extended alphabet consisting of options and abort, comparison with an ideal uniform option having no abort gives the sufficient bound

`TV(complete output, uniform options) ≤ ε/a + (1−a+ε)^N`.

For q=5,m=3 and desired total Δ=1/1000, choose ε=3/10000 and N=9. Then ε/a=Δ/2 and the abort bound is below Δ/2. This is a candidate complete error contract with an explicit availability loss, not zero-abort fairness. Giving each attempt a supplied worst-case duration τ yields a duration cap Nτ plus separately billed setup/finalisation; an almost-sure return without a time bound would not do that.

A second sufficient finite-cap contract applies when the guarantees are failure couplings rather than raw TV: if at most nN calls each fail with conditional probability at most η, and outside those failures the whole finite execution couples to the ideal resource, then

`complete error ≤ nNη + (1−a)^N`.

The second term is the ideal rejection-abort probability. A deadline timeout is charged as a failure or explicit abort, not removed by conditioning on fast successful calls. The finite union/coupling proof in `ErrorBudget.lean` supplies the first term; ideal rejection and the probability interpretation remain analytical. This route and the conditional-raw-law route use different premises and their budgets should not be conflated.

## Evidence and scope

`lottery_bounds.py` checks 49,481 conditional option laws, exact sharp examples, all 21 denominator-20 raw laws within TV 1/20 of uniform F5, dynamic finite-horizon event bounds for history-dependent selection, and both finite-cap parameter accounts using exact fractions. The general inequalities above establish the continuum bound; the finite scan is a cross-check. No fresh physical fairness, malicious VSS implementation or author adoption is claimed.
