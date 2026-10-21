# GLM problem 0b: independent audit

20 October 2026. The full proposal fails as a derivation of P-ISLANDS. Several arithmetic and algebra
components pass. This audit does not turn a failed derivation into an assumed physical theorem.
The original proposal and checker are preserved unchanged in inputs/author/proposals/glm-0b/.

The author's original checker returns exit 0 on its own ten checks. Repeating that result establishes
reproducibility of its arithmetic and predicates. The independent checks below reject several of
the implications that those predicates are labelled as proving.

## Accepted components

For N = 400, T = 64, P = 5856/5, epsilon = 1/8192, f = 3/2 and tau = 1:

- E_min = f P tau = 8784/5 = 1756.8.
- r = epsilon N P = 915/16 = 57.1875 per date.
- rT = 3660, so floor(rT/E_min) = 2.
- The strict critical share for this budget certificate is 9/51200 = .00017578125.
  Equality allows a count upper bound of three. Failure of this inequality does not prove an attack
  is feasible; the cost estimate is only a lower bound, not a sufficient construction.
- tau = 1/8 gives an upper bound of 16. The original control share 1/5120 gives three.
  That share is 8/5 times 1/8192, not double; a true doubling gives an upper bound of four.
- Consistent changes of energy and time units preserve the dimensionless ratio. Changing the physical
  duration assumption is a different operation and changes the ratio.
- The degree-16 polynomial 0x1100b passes an independent irreducibility check. All ten two-share
  coefficient determinants are invertible. With independently uniform fresh coefficients and the
  specified exposure cap, this proves the finite-field two-share secrecy statement.
- Two 202-of-400 quorums intersect in at least four islands. With at most two nonconforming voters,
  at least two intersection members are honest. Intersection alone does not prove liveness.

These statements retain their additional cost, exposure, execution and authority premises.

## Failures in the full claim

**1. Arrival counts and outstanding losses are different.** JW2.6 promises up to 64 reseed dates after
stable physical return. It supplies no bound on the preceding physical outage. Even granting the
stronger statement that every rolling 64-date interval has at most two new losses, arrivals at dates
0, 40 and 80 leave three islands unavailable at date 80 if none has returned. Each rolling interval
still contains at most two arrivals. Flapping not clearing the count reinforces this problem.
A count budget for a calendar period cannot reset outstanding debt at the next boundary.

**2. Conservation supplies no matched-draw lower bound.** Energy accounting can be additive and
conservative while a small physical actuator opens a supply path and stops a high-power plant.
The unused input can remain stored or be dissipated. The independent check gives an abstract
energy-conserving countermodel with actuation P/100 < P. It is not a measured attack price against
the proposed architecture. It disproves the inference from conservation alone. A real lower bound
on disabling the dispersed, defended plant still needs architecture and evidence. GLM explicitly
labels f and tau assumed, but its PL1/G2 wording also incorrectly attributes a matched-draw floor
to conservation.

**3. A long expectation does not prevent early success.** For two marked mirrors among 399 foreign
islands, enumerate all 79401 unordered marked pairs in a blind probe order without replacement.
The expected maximum position is 800/3, giving 200/3 dates at four probes per date. In a four-date
window there are 16 distinct probes. The exact probability that both mirrors lie among those probes is

    C(16,2) / C(399,2) = 120/79401 = 40/26467.

Its decimal floor is .00151131597838818150. The mean is longer than four dates while early success
has positive probability. Under a recognizable-probe model this is discovery success; otherwise the
proposal needs a different observation model and cannot use search order statistics as a locator.
This does not claim all 16 islands can be disabled inside the maintained k = 2 cap.

The prose formula 2(N+1)/3 is also off by one population unit: the sample has N-1 foreign candidates,
so the expectation is 2N/3. The original code uses the correct 2N/3 and reports the correct 200/3 dates.
At 600 probes/date a complete search takes at most 399/600 = .665 dates in this same probe model;
the expected time alone is still not the proof of that hard upper bound.

**4. The blind-hit probability is a conditional single-attempt result.** With an ideal hidden uniform
mirror pair, known home plus two blind extra losses hits with probability 1/79401. JW2.7's strict
parity-cycle version instead has 199 foreign candidates and probability 1/19701. The full-400 option
does not prohibit numerical adjacency. Neither numerical condition establishes geographic separation.

The 16-probe discovery probability is 120 times the one-blind-pair hit probability. Redraw therefore
needs a conditional success bound, not only an average time. Route caches, traffic, failure signals,
recognizability and adaptive observation all matter.

At the maintained two-loss cap, whole-island losses cannot remove all three images, so this excess-loss
experiment is not an additional baseline failure term. If excess is admitted, its occurrence probability,
number of attempts and conditional leakage must be budgeted. The conditional probability 1/79401
alone is about 125.94 times the entire 10^-7 common allowance. It cannot simply be inserted into that
allowance. A smaller unconditional risk might follow from a separately proved rare-excess law; none
is supplied. With no attempt or excess law, a horizon union bound supplies only the trivial bound one.

**5. The joint cap counts all causes.** A coalition budget for two attacks leaves no third slot for
ordinary island loss, false isolation, a nonconforming captured authority, or an uncleared earlier loss.
An all-cause outstanding cap needs a joint accounting rule. The local site-fault law is not that rule.

**6. Several advertised design facts are still candidate obligations.** JW2.6 uses public adjacent
placement, not a secret PRF layout. JW2.7 proves a balanced scattered-placement capacity screen and
finite recovery matching, conditional on protected caches and interfaces. A threshold seed does not
hide plaintext routes. The 512-bit seed/459-effective-bit distinction, anonymous transport, leakage
and setup costs cannot be erased by citing the threshold-share lemma.

**7. The original checker has predicate weaknesses.** Its approximate blind-probability check tests
only rounded_author - computed < tolerance; a computed probability of one half would also pass.
The actual number is close, but the check is one-sided. Its four controls reject selected arithmetic
or Boolean inequalities; they do not establish sufficiency or necessity of all nine assumptions.
In section 6 the generic intersection condition at least two is insufficient with two dishonest
members; strict honest overlap needs intersection greater than the dishonest cap. The actual
202-of-400 intersection of four passes.

## Corrected conditional rolling-budget lemma

Let E_min > 0, L > 0, B >= 0, r >= 0 and integer F_other >= 0. Suppose:

1. Every attack-induced island loss clears within L of its physical onset, including detection,
   physical outage, stable return, reseeding and final clearance.
2. In every rolling interval of length L, attack onsets have a charged count A satisfying
   A E_min <= B + rL. This envelope already covers stored energy, prepared work, borrowed equipment
   and costs paid before onset. It is an additional primitive bound, not a consequence of a power share.
3. At most F_other other whole-island losses are simultaneously outstanding. No shared cause or
   existing episode is omitted or counted as having cleared early.

Then, at every time t,

    outstanding(t) <= floor((B+rL)/E_min) + F_other.

Proof: every outstanding attack-induced loss began in (t-L,t]; apply the rolling onset envelope
to that interval and add the independent all-other-causes cap. Losses at t-L have cleared under
the lifetime premise. This is a deterministic implication, with no independence assumption.

For a desired cap k >= F_other, its budget certificate passes exactly when

    B+rL < (k-F_other+1) E_min.

This equivalence concerns the integer budget certificate, not actual feasibility of all budgeted attacks.
The lemma does not derive any of its resource or lifetime premises from physics.

At GLM's illustrative values with B = 0, F_other = 0 and k = 2, it requires L < 2304/25 = 92.16 dates.
If reseeding needs 64 dates and the only preceding contribution is physical delay D, it requires
D < 704/25 = 28.16 dates. Any additional detection/clearance delay consumes that same allowance.
JW2.6 supplies no such physical return bound. At L = 64, the strict stock allowance is
B < 8052/5 = 1610.4 energy-equivalent units. Reserving just one other loss with unchanged parameters
gives a total cap of three, so the k = 2 certificate fails.

This is a more precise conditional target for problem 0b. It does not establish P-ISLANDS or rung 4.

## Line-by-line coverage and evidence

CLAIMS.json maps each D-row, A-row, physical-law row, proof section and checker predicate to source
line numbers and a disposition. G1-G10 are each checked as stated limitations. The table records
both accepted arithmetic and failed inferences rather than treating the original exit code as a proof.

RESULTS.json contains exact rational values and floored decimal displays. The independent enumeration,
field test, arrival counterexample and eleven adverse controls run in pairs. The copied original checker
also runs twice. REPLAY.json records exit codes and hashes; PORTABLE-REPLAY.json records the relocated
run. Neither receipt asserts physical realization or author adoption.
