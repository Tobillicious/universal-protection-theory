# Protection, continued agency, and complete effect coverage

Protection must retain actual people and synthetic particulars with meaningful options. An abstract theorem certifying every permitted edge can be true of a system that permits no edge at all. That logical possibility makes progress and agency part of the construction, rather than consequences of the word “safe.”

The deterministic all-agent theorem remains valid. This chapter extends it to state-dependent permissions and nondeterministic outcomes, and states precisely what it does and does not establish.

## Effects with more than one possible outcome

Let \(R(a,s,t)\) mean that action or event \(a\), from state \(s\), can enact successor \(t\). Specify \(R\) independently of the protection verdict. The same action may have several possible successors, and an action need not be enabled at every state.

Keep the independently interpreted state condition \(P\) and the complete original-six event certificate \(C\). Define:

\[
\mathcal T_R(X)(s):=
P(s)\land\forall a,t,\ R(a,s,t)\Longrightarrow[C(s,t)\land X(t)].
\]

Let \(Q_0(s)=P(s)\), and recursively:

\[
Q_{n+1}(s):=P(s)\land\forall a,t,\ R(a,s,t)
\Longrightarrow[C(s,t)\land Q_n(t)].
\]

Construct \(G_R(s):=\forall n\in\mathbb N,\ Q_n(s)\).

**Theorem.** \(G_R=\mathcal T_R(G_R)\), and every \(X\subseteq\mathcal T_R(X)\) is contained in \(G_R\).

**Proof.** If every finite horizon is certified, horizon zero gives \(P(s)\), horizon one gives the first-edge certificate, and horizon \(n+1\) gives horizon \(n\) at every successor. Conversely, the fixed-domain condition supplies every horizon by the same decomposition. Induction on the horizon includes every separately certified post-fixed domain. ∎

Every represented execution beginning in \(G_R\) therefore retains membership and the complete event certificate on every edge. The proof covers every possible represented outcome, rather than selecting a favorable outcome of a nondeterministic action.

For \(R(a,s,t)\iff t=F_a(s)\), the relational domain equals the original deterministic domain. This equality is proved, so the extension preserves the earlier result and its certificate meanings.

## Why expanding coverage can make a guarantee smaller

Suppose \(R\subseteq R'\), with the same states, state condition and event certificate. Then:

\[
\boxed{G_{R'}\subseteq G_R.}
\]

**Proof.** A state protected against every \(R'\)-edge is protected against every \(R\)-edge. Its \(R'\)-domain is therefore post-fixed for \(\mathcal T_R\). Greatestness gives the inclusion. ∎

This is the direction relevant to discovering a bypass. A guarantee for a smaller inventory cannot be extended to a larger inventory merely by retaining its name.

There is also an exact extension rule. If every \(R'\)-edge from \(G_R\) has the full certificate and returns to \(G_R\), then \(G_R\) is post-fixed for \(\mathcal T_{R'}\). Thus \(G_R\subseteq G_{R'}\), and together the two inclusions give equality.

That rule identifies the proof needed when adding a new actuator, dependency, environmental effect or Genesis event. A model update must establish the new edges' actual meanings and closure. It cannot add only a label to the old inventory.

## Deadlock and endless idling

If no edge leaves a state, the universal edge condition is vacuous. With \(P=\mathrm{True}\), even a wholly deadlocked system can satisfy \(G_R\). This is a checked counterexample to inferring continuation merely from the greatest safety-domain theorem.

An independent seriality theorem repairs that particular gap:

\[
\forall s\in G_R,\quad\exists a,t,\ R(a,s,t).
\]

Combined with fixed-domain closure, induction constructs a certified execution of every finite length from each state in \(G_R\). The same independent full certificate remains on every constructed edge.

Seriality is still insufficient for meaningful agency. A system with one endless idle action is serial and can preserve an abstract safety predicate forever while never reaching a separately specified goal. The accompanying counterexample proves this too. It does not refute a full authentic freedom certificate; it prevents substituting a weaker certificate for one.

An actual agency theorem must identify subjects' usable admissible options, the conditions under which an option remains enabled, and whether execution is guaranteed or merely available. A bounded response claim requires a clock and a derived deadline. A fair-scheduling claim requires a scheduling theorem. These facts do not follow from state membership alone.

Nor does a proof over all finite natural-numbered prefixes automatically establish an event at a limit stage, a transfinite epoch, or a finite-time accumulation of infinitely many steps. Include such events in the transition semantics and prove their certificates before using them in a cosmological claim.

## An existing construction of bounded service

The supplied `lalala.zip` recovers source results that go beyond the generic seriality criterion. These are already part of UPT's research track; the book should use them rather than describe progress only as an unfilled requirement.

`IRServiceProgress.ranked_trace_reaches_goal` proves robust finite service from an invariant, an absorbing goal and a natural-number rank that strictly decreases on every non-goal step. `IRBoundedStalls` relaxes that condition: productive events strictly decrease the rank, stalls do not increase it, and the supplied event trace has a certified upper stall budget \(B\). Rank zero must imply service.

For initial rank \(r_0\), a completed trace of at least \(r_0+B\) events then reaches the service goal. This follows by counting productive events: an unserved endpoint would leave positive rank after enough strict decreases, contradicting the available initial rank. The invariant holds throughout the trace.

`IRClockedBoundedStalls.exact_horizon_clocked_service` adds an independently meaningful time function and maximum delay \(\Delta\) between completed events. At the exact completed horizon \(N=r_0+B\), it derives:

\[
\boxed{\mathrm{Inv}(s_N)\land\mathrm{Served}(s_N)
\land t_N\le t_0+(r_0+B)\Delta.}
\]

The source constructs a concrete witness in `IRConcreteClockedStalls`: start at rank two; enact one stall and two productive events; use four modeled time units per event. The rank trace is \(2,2,1,0\), and the endpoint is served within twelve modeled units. A three-stall trace fails service, supplying an explicit negative control. This is a synthetic service example, not an authentic-subject certificate.

These results can be joined to G by proving that the same enacted transitions preserve G and carry its complete event certificate. The progress assumptions must refer to that same transition family and same actual history. A goal about a numerical counter cannot silently become delivered freedom for a person.

The theorem also requires the critical events actually to complete. A delay inequality over supplied timestamps does not cause an event to happen. The source's frozen-clock and slow-clock controls make that limitation explicit. Thus the book now contains a positive bounded-service route while retaining the actual scheduling, time, service-meaning and six-duty correspondence that an implementation must establish.

These modules were freshly compiled from the supplied archive with Lean 4.35.0. Their source bytes match the corresponding files at reviewed main `0f6eec3`. See the [ranked service source](https://github.com/Tobillicious/universal-protection-theory/blob/0f6eec330376b7f246ab236214b1b0ffcb1bb0ac/evidence/physical-bridges/PhysicalBridges/IRServiceProgress.lean), [bounded-stall source](https://github.com/Tobillicious/universal-protection-theory/blob/0f6eec330376b7f246ab236214b1b0ffcb1bb0ac/evidence/physical-bridges/PhysicalBridges/IRBoundedStalls.lean), and [clocked service source](https://github.com/Tobillicious/universal-protection-theory/blob/0f6eec330376b7f246ab236214b1b0ffcb1bb0ac/evidence/physical-bridges/PhysicalBridges/IRClockedBoundedStalls.lean).

## Authorization can change

The concrete guard's unchanged consent flag is a modeled relation. It is not an operational interface for withdrawing authorization, deliberating, or exercising a new choice. A subject can have the same stored consent bit while losing every available option; the negative-control module constructs that case explicitly.

An authentic implementation must interpret authorization at the time of the effect, including permitted withdrawal and its ordering against the effect. It must also show that legitimate updates to authorization belong to the admitted effect family. Record immutability alone cannot do this work.

Protection of another particular also limits which harmful effects may be enacted. The freedom claim therefore concerns authentic agency within mutually protective bounds. It cannot simultaneously mean that every possible harmful command is executed and that every affected particular is protected. Any restraint still owes the original authorization, least-restraint, actual-feasibility and provenance duties.

## What the moving Git source adds

The book's proof-source pin remains \(84e5940\). The hostile review also inspected main \(0f6eec330376b7f246ab236214b1b0ffcb1bb0ac\), the merge of PR #642. The comparison contains 151 changed files and no changed Lean file.

That merge adds reserved controller worker capacity, bounded request handling, a separate emergency HOLD endpoint, and tests for ordinary-side saturation and recovery. It improves the older availability finding. The inspected source explicitly retains shared CPU, database locks, disk, kernel backlog, and compromised control identities as limits. The fixture's protected effect remains one authority-owned zero-byte marker.

The new Hume substitution crosswalk and ethics atlas require independently meaningful subjects, actual effects, and all six authentic reflections. They do not claim that typed substitution by itself proves those premises. These statements agree with the mathematical boundary in this chapter.

Exact-head workflow conclusions and independent reproduction must be checked separately. This review has not run the privileged Linux suites locally and does not infer their success from a merge or from another commit's green run.

The full Actions endpoint records six successful workflows on that exact main head, including Physical bridge proofs. New draft #643 also records successful strict syscall-denial observations. The hostile review bound its artifact to the provider digest, but found and locally repaired a trace-parser false acceptance for padded or fragmented target-call records. The Git-specific review records the precise scope; a green run does not remove that demonstrated limitation.

## Verification

The nine declarations in `GuardianRobustness.lean` compile under Lean 4.35.0 without axiom dependencies. They prove the relational fixed domain, greatestness, coverage direction, exact extension rule, deterministic agreement, execution protection and finite progress under seriality. Two of those declarations are explicit deadlock and endless-idling controls.

These results strengthen the usable theorem. They leave actual coverage, authentic duties, and actual progress to independently constructed evidence, rather than defining them away.
