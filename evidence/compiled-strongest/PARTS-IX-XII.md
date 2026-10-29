
---

# Part IX — Complete rivals and the composition (24 October Master Argument §§13–14)

## IX.1 Greatest in the complete reactive class

Let \(\Pi_{\rm phys}\) contain every executable rival in the declared information,
consent, resource, timing and identity class, and let a world \(w\) be a reactive
environment strategy. Suppose certified envelopes satisfy, for every rival
\(\pi\) and every world,
\[
\mathcal O(\pi,w)\preceq U(\pi,w)\preceq L(w)\preceq\mathcal O(\pi^*,w).
\]
Transitivity proves \(\pi^*\) greatest in that complete class, world by world.
The envelopes may be optimistic and need not be executable; their bounds concern
the actual outcome in the full four-stage order. R15 and R16 reduce the
comparison when implementations with the same certified interface strategy have
the same boundary transcript, resources factor conditionally, outcome ownership
is accounted for and the relevant fibres have greatest representatives. Fixing a
strategy does not fix its transcript independently of reactive feedback. When no
greatest representative exists, the law distinguishes maximality from
greatestness and applies its actual existence conditions (VI.2; Part X).

**Join to II.10.** II.10 earns greatestness of the whole tuple from two
constructions, realisability (`htopR`, derived from locality in G.9) and funded
cost (`hsolv`). The envelope chain is the reactive, per-world form of the same
conclusion: \(L(w)\) is the realisable top in world \(w\), and the chain places
\(\pi^*\)'s outcome at it. Part X's IR-135 supplies the quantifier the envelope
requires — *one* policy fixed before the world is chosen — and its countermodel
shows why per-world success does not give it.

**The rival bound is free at the top.** Write the top outcome as \(\top\): every
existing particular continues and is free, and every feasible new particular
continues and is free. When the selected policy realises \(\top\) (realisability
`htopR` from locality, G.9; funding `hsolv`), every rival's outcome satisfies
\(\mathcal O(\pi,w)\preceq\top\) by inclusion. The upper envelope is the
universal tuple itself, so no enumeration of rival histories is needed
(`greatest_of_solvent`). This is the 29 October audit's "Certificate B". The per-world envelopes need one policy realising \(\top\) in every world.
Under union closure (G.9) on a compact policy space that policy exists: finite character
turns pairwise splicing into one policy realising the union of all policies' outcomes
(`CommonPolicyTop.top_policy_exists`), and that outcome contains every realisable outcome
in every world (`top_policy_greatest`).

**In a tragedy, certification is per loss.** Where \(\top\) is not realisable,
Proposition 1 (`aligned_iff_no_needless_loss`) turns maximality into one check for
each particular lost: no feasible option keeps it while agreeing at every earlier
stage. `four_stage_original_maximal` guarantees that an outcome passing every such
check exists, and the last-resort ladder and the impartiality ruling (VI.3)
govern the choice among such outcomes. The reduction is exact
(`PerLossCheck.maximal_iff_per_loss`): no feasible outcome is better than \(m\) if and only
if, for every fact \(m\) loses, no feasible outcome keeps it while agreeing with \(m\) at
every earlier stage and keeping everything \(m\) keeps at that stage.

## IX.2 Theorem 8 and the derived holding composition

Master Argument §14 states Theorem 8: given, for a domain \(K\), horizon \(T\) and
source execution, (1) initial continuation witnesses, (2) a complete event,
observation and causal inventory with pending effects, (3) commuting refinements
with local invariant preservation, (4) a certified comparison over the actual
feasible family, (5) application-time mediation of every relevant effect, (6)
prefix-feasible service, funding and recovery certificates, (7) identity and care
witnesses through holds and transitions, (8) conditional risk kernels for every
charged failure — then on the good event \(G\) the source refines the abstract
execution, every applied effect carries its current permit, care meets its
deadlines, the invariant holds for every particular in \(K\) through \(T\), and
\(P(\text{failure by }T)\le P(G^c)\le\sum_{i,t}\delta_{i,t}\).

The canon's `Composition.theorem8_composition` and
`Bridge.universal_protection_held` (II.6) implement this composition with the
holding step *derived*: the five `hcert` components are proved on the held source
in G.10. Theorem 8 in this edition therefore carries certificates (1), (3), (5),
(7) by construction (II.3–II.6, G.10), (2) and (8) by G1 (G.10, E.1), (4) by
Parts II.10, IX.1 and X, and (6) by Sections 18 and 22, G.12 and Part VIII.

---

# Part X — Infinite families, one common policy, source-level mediation (IR track)

The IR track of the linked repository (`evidence/physical-bridges/`, main at
`740abbb`; draft PRs #170–#172) proves the following in Lean 4. The modules on `main`
behind the results below — their full dependency closure, 75 modules plus Paper
12's `ContextualObservation` — are compiled in this edition's canon under their
own names (`Snuffy.<Module>`, namespaces `PhysicalBridges.*` kept), with imports
redirected to the canon and the source hash recorded in each header. The pinned IR-134/135 sources are also incorporated in this canon; their upstream PRs remain drafts. Each is cited by
module and theorem. Its role in the proof is stated beside it.

| Result | Module · theorem | Statement | Role |
|---|---|---|---|
| IR-17/20/25 | `IRSelectedMaximality.selected_safety_maximal_lifts_globally`; `IRProfileAudit.audited_no_excluded_improver` | A selected outcome maximal in a safe sub-family is maximal in the full original feasible family when no excluded rival improves it; a complete, stagewise-faithful profile audit with obstruction witnesses derives that no excluded improver exists | Full-family maximality from a finite certificate where one exists |
| IR-56 | `IRFiniteProfileObstruction.no_finite_faithful_chain_profiles`, `unbounded_chain_lacks_global_maximum` | For the unbounded chain family no finite faithful profile audit exists, and the family has no maximum | Why the infinite case needs its own route |
| IR-66/67 | `IRInfiniteFinitaryMaximality`; `IRTwoStageInfiniteLex.independent_any_finite_stage_lex_maximum` | Under finitary infeasibility (finite forbidden patterns) an original-order maximal outcome exists in an infinite family, with no finite catalogue; for any finite number of independent stages | Infinite existence |
| **S2 (this edition)** | `StagedMaximality.exists_lex_maximal`, `four_stage_original_maximal` (canon Lean) | For any set of particulars (uncountable allowed), any finite number of stages, finite conflicts, a feasible mandatory baseline kept by every outcome, and prerequisites in earlier stages (freedom requires continuation), a feasible outcome exists that no feasible outcome strictly improves in the law's order; the four original stages are the instance. Proof by stage-by-stage Zorn, no enumeration | **Four-stage original maximality over the full feasible family** — generalises IR-66/67/71 |
| IR-68/71 | `IRCoupledFinitaryTwoStage`; `IRMandatoryBaselineMaximality.required_baseline_full_feasible_original_lex_maximal`, `resource_capacity_plus_mandatory_baseline_maximal` | With arbitrary cross-stage finite conflicts and a feasible positive mandatory baseline (never deleted), two infinite greedy phases give an original-order maximal outcome over the full feasible family; resource-capacity families are an instance | Infinite coupled maximality with mandatory duties |
| IR-72 | `IRInfiniteHistoryCompactness.forever_viable_has_common_action`, `derived_infinite_robust_safe_history` | With two available actions and robust viability at every finite horizon, one memoryless policy keeps the modelled trajectory safe at every time against every disturbance stream; an infinite-action countdown shows finite branching is needed | One infinite safe policy |
| IR-91/92 | `IRA1NineClassComposition.step_preserves_all_a1_source_invariants`, `arbitrary_finite_nine_class_source_trace_is_safe` | The nine A1 effect classes (memory mapping, DMA, context switch, packet ingress, bus, storage sync, commissioning, delegation, retirement) as one source product machine with a common inductive invariant; controller retirement under drained effects and custody hand-off | Source-level form of II.5's A1 register |
| IR-93 | `IR93GlobalComposition.compose_trace`, `assemble_preservation` | Component invariants with source adapters compose into a global trace invariant | Composition kernel |
| IR-98/99/100 | `IR98FeasibleFamilyTransfer.original_order_transfer_of_no_new_improver`; `IR99ResourceImproverCoverage.physical_accounting_original_order_maximal` | Maximality in a modelled family transfers to a larger actual family when physically sound resource and mandatory-duty accounting covers every actual strict improver | From modelled to actual feasibility |
| IR-109/113 | `IR113.observation_policy_exists_iff_common_viable_action`, `common_actions_give_finite_trace_viability` | A robust observation-only viable policy exists exactly when every observation class has a common action keeping all compatible viable states viable | The exact common-policy criterion (Theorem V(b) in observation form) |
| IR-116 | `IR116CumulativeSubjectDuties.cumulative_duties_preserved`, `initial_cohort_retains_continuity_and_every_required_option` | Duties owed are cumulative: no particular leaves protection by registry deletion; newly recognised subjects are appended; required options stay executable | No vacuity by deletion |
| IR-117–122 | `IR118InFlightBacklogBudget.physical_reserve_holds_during_closed_drain`; `IR121MeteredResidualEscrow.residual_drain_keeps_subjects_protected` | In-flight effects in a closed pipeline are bounded by the initial backlog; a metered residual escrow protects every owed subject during a closed drain | Effects already in flight |
| IR-134 (draft #170/#172) | `IR134SourceExtractedOutcome.original_order_maximality_of_executed_audit`, `original_cohort_continues_with_options_at_every_source_state` | The selected outcome is the outcome of an executed source trace, not an uninterpreted `realises` predicate; the original cohort and its options are retained at every intermediate source state | Realisation by execution |
| IR-135 (draft #172) | `IR135.same_policy_worldwise_original_maximality_and_continuation`, `observation_class_certificate_constructs_common_protection_policy`, `each_world_separate_success_does_not_yield_common_policy` | One policy fixed before any world gives per-world original maximality and continuation; the observation-class certificate constructs it; per-world success does not give a common policy | The quantifier \(\exists\pi\,\forall w\) |

The track's other results — that participation is not consent (IR-105), that a
gate can be bypassed by an unmediated path (IR-101, #164), that a reduced state
does not fix the future (CRF/TRF, #168), that a symmetric fork selects no unique
original (#169) — are guards on how each step must be proved. They are satisfied
in this edition by application-time authority (II.5), the complete-path
mediation of IR-91/92 and Chapter 16.5's execution boundary, the full-history
rule (G.8, V.4), and the definitions of V.2 (a split continues in both branches,
which are protected).

---

# Part XI — Reach before harm: the outer-lane theorem

This part constructs the join that no single earlier line contains: every mind,
inside or outside any installation, is reached or held before its effects can
land on any protected particular, from founding onward, with the protection
funded, selected without coordination, and carried by one policy.

## XI.1 Setting

The relational given (P1–P4), with signal speed \(c_s>0\): no effect propagates
faster. The protected domain at time \(t\) is \(D(t)\subseteq E\) (a real normed
space of positions; every particular has a location in the one structure, P1).
Because new particulars arise from existing ones by local interaction (P4), the
domain moves at most at a speed \(c\le c_s\): every \(x\in D(t)\) lies within \(ct\)
of some \(y\in D(0)\). Guards are holding stations: the funded tracking/repair
controller of II.3–II.4 with its E9 sensing and the application-time fence of
II.5. A threat to a particular at \(x\) has an effect deadline \(d\) (the time from
its first detectable sign to irreversible effect); guards respond in time \(\tau\).

## XI.2 Four lemmas (compiled: `Snuffy.OuterLane`)

**Lemma W (wavefront coverage; `wavefront_coverage`).** If every \(y\in D(0)\) is
within \(\rho\) of a guard of \(G(0)\); the guard set at time \(t\) contains every point
within \(vt\) of \(G(0)\); and \(c\le v\), then every \(x\in D(t)\) is within \(\rho\) of a
guard of \(G(t)\).
*Proof.* Choose \(y\in D(0)\) with \(|x-y|\le ct\) and \(g\in G(0)\) with \(|y-g|\le\rho\);
then \(a=|x-g|\le\rho+vt\). If \(a\le vt\), \(x\) itself is a guard point. Otherwise
\(g'=g+(vt/a)(x-g)\) is within \(vt\) of \(g\), hence a guard point, and
\(|x-g'|=a-vt\le\rho\). ∎

**Lemma I (interception in time, round trip; `ReachTiming.round_trip_in_time`).**
The sign travels from the particular to the guard, the guard responds in \(\tau\),
and its action travels back. A guard within \(\rho\le c_s(d-\tau)/2\) therefore
acts at the particular before \(d\): \(2\rho/c_s+\tau\le d\). (The one-way form
`OuterLane.interception_in_time` bounds only the outbound leg; the referee's
correction, 29 October, is adopted.)

**Lemma I₀ (the synchronous fence; `ReachTiming.fence_in_time`, `UPTFence`).**
Attacks faster than any round trip (an adjacent attacker acting in one step, the
finite-speed countermodel of 28 October) are met by no travelling guard. They are
met by the fence on the effect path itself. Its check runs in the write path at
application time, so its response time is \(\tau_f=0\le d\) for every deadline, and
once the floor rises nothing lands while held, whatever the held mind does or
reports (`UPTFence`; IR-91/92 for the nine substrate classes). For the theory's
target, that fence sits on the digital mind's own outputs (Corollary XI.3). Per-site
E9 sensing with quorum no-masking (`E9SelfHealing.no_masking`,
`Instruments.branchC_complete`) raises the alarm in the above-threshold branch; funded tracking and repair bound and absorb the sub-threshold branch for the care plant's guards. The zero-time fence here is the abstract atomic application check. An implementation must serialize that check and the actual effect with hold/revocation transitions; its positive request-to-effective-hold latency, clock error and in-flight work remain in the response budget.

**Lemma P (selection by noise-induced dominance; `pool_strictly_dominant`).** Let
the capacity the other keepers actually deliver be any random variable — their
intentions composed with execution noise (UPT-P Setting U). If a keeper's pooling
is pivotal with positive probability, pooling strictly raises the probability
that the ender is held. A lexicographic keeper (protection first) therefore pools
whatever the others intend; with full-support execution noise every keeper that
is pivotal in some configuration has positive pivotal probability. Hence the
no-pooling profile is not an equilibrium among such keepers, and Gate D's
selection question is decided for them; VII.5 (m4) extends this to patiently
excluded finite-trade-off keepers. Under D-ENDOW (Part VIII U3) committed capacity
is not a voluntary choice at all, so no selection arises inside an endowed
jurisdiction. With the keeper's own execution noise (an intended pool fails with probability
\(\varepsilon\), an intended abstention pools with probability \(\delta\)), pooling raises the
holding probability by exactly \((1-\varepsilon-\delta)\) times the pivotal gap, so it stays
strictly better whenever \(\varepsilon+\delta<1\) (`NoisyPooling.noisy_pool_strictly_dominant`).
The others may be countably many, with any joint law: their delivered capacity is the sum
in \([0,\infty]\), always defined and measurable even when it diverges, and pooling stays
strictly better (`CountablePooling.countable_keepers_pool`, and with own noise
`countable_keepers_noisy_pool`).

**Lemma R (risk; `outer_lane_risk`).** If failure of the outer lane is contained in
founding failure, a holding failure at some date, or a charged account failure,
its probability is at most \(\eta_F+\sum_t\varphi_t+\sum_i\delta_i\), with no
independence assumed. With countably many itemised accounts, each failing with probability
\(\int\kappa_i\,d\mu\) for a conditional kernel bounded pointwise by \(\delta_i\) (the worst case
over every conditioning state), the bound is \(\sum_i\delta_i\) (`ItemisedRisk.itemised_risk`).

**Lemma H (the hold is a common viable action; `HoldCommonAction`).** IR-113
shows that one observation-only protective policy exists exactly when every
observation class has an action keeping every compatible viable state viable.
The holding route reduces that premise to one condition, **hold safety uniform
over the observation class**: every admitted successor of every compatible viable
state under the hold is viable. Given it, the hold is a common viable action
(`hold_is_common_viable_action`, no axioms), and one policy that acts where a
class-wide safe action exists and holds elsewhere keeps viability everywhere
(`act_or_hold_policy`). A faithful hold lands no effect, so hold safety does not
turn on which effect is chosen. It does turn on the world's own perturbation
during the hold interval, which must stay inside the decoding radius for every
hidden state in the class: \(\varepsilon+(W/\hbar)\Delta\le r_{\rm dec}\) with \(W\)
bounding the perturbation of every such state (`Bridge.qsl_within_radius`), or
\(2\lambda\tau<d\) with \(\lambda\) bounding every such fault process
(`Bridge.headroom_within_radius`). Decode and funded repair then return the state
(`holding_preserves`). E9's per-site threshold and complete attack split supply a
class-uniform \(W\) for mind-driven perturbation, since they bound injection
whatever the adversary. **Compiled join (`HoldFromCycle`):** with the class's
perturbations each keeping a continuing particular within the decoding radius,
every hold step (perturbation, nearest-codeword decoding, funded repair) keeps every
viable state viable (`hsafe_of_holding_cycle`, from `Bridge.nearest_decodes`). So the
hold is a common viable action at every observation class under IR-113's own
criterion (`hold_common_action_of_cycle`, `classViable_iff_IR113`), and one
observation-only policy keeps viability along every finite trace
(`one_policy_from_holding_cycle`, through
`PhysicalBridges.IR113.common_actions_give_finite_trace_viability`). The remaining
input is the class-uniform perturbation bound itself, which the installation
measures (\(W\), \(\lambda\), \(\tau\), \(r_{\rm dec}\)). The two-world example (`two_world_resolved`) is a
stipulated control showing the shape of the resolution, not a derivation; IR-108's
own countermodel, in which inaction is itself harmful in one world, is answered
only where the hold interval is shorter than that harm's deadline, which is the
same uniform bound.

**Composite (`ReachTiming.reach_round_trip`).** Under Lemma W's hypotheses with
\(\rho\le c_s(d-\tau)/2\): at every \(t\ge0\), every particular of \(D(t)\) has a guard
\(g\in G(t)\) with \(2|x-g|/c_s+\tau\le d\), so the guard's action reaches it before
its deadline. (`ReachBeforeHarm.reach_before_harm` is the one-way version.)
Discrete guard sets enter through a net: guards forming a \(\rho_{\rm net}\)-net of
the swept region give coverage at radius \(\rho+\rho_{\rm net}\).

## XI.3 The theorem

**Theorem XI (reach before harm).** Suppose at founding time \(t_0\):

1. **(Founding threshold.)** Protection-first capacity satisfies
   \(r=C(1-\varepsilon)/H>1\) with \(H=c(K_E+aS_{\max})+A\) (Theorem NP), split among
   \(n\) independent keepers (MS), so that \(\varphi(n)\le\exp(-2n(1-\varepsilon-H/C)^2)\)
   (`NarrowPlace.np_splitting_bound`);
   founding fails with probability at most \(\eta_F\). Neither a fixed threat nor
   independence is needed for a guarantee: a random threat correlated with the deliveries
   adds only its cap's account \(\eta_H\) (`CorrelatedHolding.random_threat_independent`),
   and under any joint law of the keepers, common-mode failures included, holding fails
   with probability at most \(\eta_H+\varepsilon/(1-H_{\max}/C)\)
   (`random_threat_correlated`, by Markov's inequality).
2. **(Founding coverage.)** At \(t_0\) every digital mind's substrate outputs are
   fenced (Corollary XI.3; a total meter bounds every output channel, listed or not,
   `ChannelMeter`), and every
   location of \(D(t_0)\) is within \(\rho\le c_s(d-\tau)/2\) of a funded guard.
   This is the founding certificate (XI.5 item 1); Theorem XI propagates it. Its
   location half is a finite construction: a compact initial domain is covered at any
   radius by finitely many guards (`FoundingCover.founding_cover_exists`), and founding
   with them yields round-trip reach at every later time (`founded_reach`).
3. **(Expansion at least as fast as the domain.)** The guarded region expands at
   speed \(v\ge c\): the wavefront of Section 21.7, whose sweep succeeds with an
   \(O(t^{d_G})\) cumulative bill (G.12). In an expanding space the same inequality holds in
   comoving distance and conformal time, since expansion carries particulars and guards
   alike; the round trip needs \(a_{\max}\cdot2\rho/c_s+\tau\le d\)
   (`ExpandingWavefront.expanding_coverage`, `expanding_round_trip`).
4. **(Funding.)** Income meets premise 6's master solvency condition, whose first
   term \(\omega_0R(t)^{d_G-1}\) is the boundary-maintenance rate of the expanding
   region. For a growing bill \(b(t)\) the endowment form is
   \(e^*=\sum_t b(t)(1+r_{\min})^{-t}\), finite for polynomial \(b\) when \(r_{\min}>0\)
   (`GrowingBill.endowment_suffices`; Gate C-∞'s stationary price is the
   constant-bill case).
5. **(Charged accounts.)** Every failure mode of the conclusion has a named account
   with a genuine conditional kernel: founding (\(\eta_F\)); holding at each date
   (\(\varphi_t\)); per-step exit under full-support noise (Θ2's \(\varepsilon\)); wavefront
   deployment and guard survival; fence integrity; E9 detection; funding shortfall;
   and the twenty-one accounts of Section 22.3. Their sum is the declared budget.
   Itemising these accounts is what Lemma R's containment hypothesis requires.

Then from \(t_0\) through \(T\le T_{\rm end}\), with probability at least
\(1-\eta_F-\sum_{t\le T}\varphi_t-\sum_i\delta_i\):

- every location of \(D(t)\), including every particular newly arising after
  founding, is within round-trip interception radius of a guard at every \(t\)
  (Lemma W, Lemma I);
- every digital mind made after founding is made inside the arrangement with fenced
  outputs (Corollary XI.1), so every effect of every digital mind on any particular
  passes the synchronous fence (Lemma I₀, Corollary XI.3). A mind with its own
  reason keeps the living free, \(R(m)\). Any mind whose effect is not admissible,
  reasons or none, is restrained by the fence and the holding construction of
  II.3–II.6 while its care continues, \(H(m)\);
- the holding coalition forms without coordination (Lemma P) and keeps its
  advantage (VII.5 (b3), Theorem MN: \(r(t)\) non-decreasing before the twilight);
  \(\sum_t\varphi_t\) converges when keepers grow (J1);
- the guarantee is carried by one policy fixed before the world is chosen (Lemma H
  with IR-113 and IR-135; IR-72 gives a full-state infinite-horizon policy where two
  actions suffice). Under full-support noise preservation is quantitative: every
  admitted policy's per-step exit is at most Θ2's \(\varepsilon\) (Theorem V(d)), charged
  in Lemma R. The almost-sure forms (Theorem V(c), Theorem E (E4)) apply where noise
  is bounded (Θ1);
- the continuation invariant holds for every protected particular by
  `Bridge.universal_protection_held` on the good event (II.6).

*Proof.* Lemma W with hypotheses 2–3 gives coverage at every \(t\). Lemma I turns
coverage into round-trip interception before every deadline, and Lemma I₀ meets
attacks faster than any round trip at the fence on the acting mind's outputs. An
effect that is not admissible is therefore met by the fence and the holding step
of II.3 (perturbation within decoding radius, decode, funded repair;
`holding_preserves`, `holding_cycle_physical`). Every policy admitted by that rule
exits per step with probability at most \(\varepsilon\) under Gaussian noise (Θ2,
Theorem V(d)), or preserves almost surely under bounded noise (Θ1, Theorem
V(c), Theorem E (E4)), whatever its rewards. Lemma P
makes the protecting coalition the outcome among protection-first keepers;
hypothesis 1 with NP/MS bounds the holding failure at each date and J1 bounds its
sum; hypothesis 4 funds the guards and their expansion, including G.12's complete bill, holding, controller export and endpoints; IR-113/IR-135 give the common policy.
Every failure of the conclusion lies in one of the accounts itemised in
hypothesis 5, and Lemma R bounds the probability. ∎

## XI.3b Coverage by location: every particular, every relation, every made mind

**Coverage is by location, not by registry.** Lemma W covers every point of the
domain. A particular need not be recognised, registered, minded or living to be
within interception radius of a guard: the nonliving, the unregistered and the
newly arising are covered because they are somewhere in the one structure (P1).
IR-116's cumulative duties then keep every particular once owed; Lemma W makes
the owed set the whole domain.

**Relations.** By P1 there is no outside, so a change in a relation is an event in
the one structure. By P4 that event occurs at locations, those of the relata or of
the region between them. Lemma W covers every location of the domain, not only the
particulars' own, so every relation among particulars of the domain is within
guard reach wherever its change occurs, and every mind's effect on it passes the
fence on that mind's outputs (Corollary XI.3).

**Corollary XI.1 (every digital mind made after founding is held or reached from
its making).** A digital mind is made by a local process inside the one structure
(P1, P4); its making is an event at a location of \(D(t)\). After founding that
location is covered (Lemma W), and inside an installation the making is the
reserve-before-activation transition of Section 20.3 (`H5Closure`: reserve before
activation, attenuated authority, no unfunded work, care preserved). So every
digital mind made after founding begins inside guard reach with fenced effect
channels: it is reached by its own reasons or faithfully held from its first step.
No digital mind made after founding arrives from outside the arrangement.

**Corollary XI.2 (the expansion bound is an admission rule).** A particular made
by a mind is activated only after its complete continuing obligation is reserved
(II.8; Section 20.3; Master Argument §8: every active identity carries a funded
maintenance witness). Its protection — the guard of its location and the fence on
its channels — is part of that obligation. So a made particular is covered from
activation whatever the speed of its making, and Lemma W's speed condition
\(c\le v\) is needed only for particulars arising without mediated making, at the
rate natural processes produce them. A making that would place a particular beyond
coverage is outside the viable action rule \(D_V\) and is not admitted (Theorem
V(c)); ruling 6 gives it no claim on that room.

**Corollary XI.3 (source-side mediation of every digital mind).** Every effect a
digital mind has on any particular passes through its substrate's output
channels: the nine A1 classes (memory mapping, DMA, context switches, packet
ingestion, bus messages, storage synchronisation, commissioning, delegation,
retirement; IR-91/92 at source level) together with the substrate's physical
emissions, which belong to the complete event inventory of G1 (E.1). Fencing
those channels at application time (II.5; Chapter 16.5, `UPTFence`: once the floor
rises nothing lands while held, whatever the held mind does or reports) mediates
every effect of that mind on every particular, living or not, wherever the
particular is. With Corollary XI.1 every digital mind made after founding is
mediated from its first step, and in-flight effects at a hold are drained within
the metered escrow (IR-117–122). For the theory's target — protection from any
digital mind — interception at radius zero sits at the mind's own outputs; Lemma W
carries the care plant's guards to every particular for every other cause of loss.

**Lemma E (emissions are routed through a mediated physical sink; `EmissionBound`).**
A substrate's physical emissions are outputs that pass no software fence, and for a
computing substrate nearly all input energy leaves as heat, so conservation alone
bounds little. The installation therefore makes the emission path itself a
mediated sink: shielding, a controlled exhaust, filtered power, and a
receiver-exclusion zone sized by each channel's attenuation law. Two compiled
bounds then apply at the zone boundary. Requisite variety (D116, `requisite_variety`):
a channel delivering one of \(M\) messages lets a responder answer correctly for at
most \(M\) disturbances, so under uniformly distributed targets a selection among
\(|D|\) responses succeeds with probability at most \(M/|D|\)
(`requisite_variety_prob`, deterministic encoder and responder; \(M\) counts every
channel use within the deadline). And energy (`emission_cannot_power`): an effect
needing more work than the exhaust delivers past the boundary cannot be powered by
it. Untargeted harms (a burst, a one-bit trigger to stored energy) need no variety;
they are excluded by the receiver-exclusion zone, since a trigger acts only through
a receiver and actuator in range, and every device inside the zone is itself a
fenced substrate. The exclusion radius is compiled (`ExclusionRadius.exclusion_radius`):
a channel delivering power \(P_0/r^n\) cannot supply work \(W\) within deadline \(d\) at any
\(r\ge(P_0d/W)^{1/n}\). The harm-class table is constructed
(`installation/HARM-CLASSES.json`). Each class has a published protective threshold:

- people: ICNIRP 2020 RF exposure, FCC localized SAR, OSHA and NIOSH hearing limits, and radiant heat;
- devices and records: IEC 61000-4-3 immunity;
- ionising radiation: the Duane–Hunt bound;
- low-frequency magnetic fields: ICNIRP 2010;
- coherent particulars: a measured coupling.

`installation/commission.py` turns each threshold and the installation's meter into an exclusion
radius. Corollary XI.3's completeness rests on this mediated emission sink together with the total
meter (`ChannelMeter`), which bounds every channel whether listed or not.

**Islands.** Protection composes over causally bound islands (VII.5 (i), IS): a
region whose particulars no founder's signal can reach is protected by its own
founding, and the global failure bound is the union over islands (Lemma R). Within
each founder's causal future the wavefront advances at the maximal admissible
speed, so every particular a founder can ever affect is covered as soon as any
effect from that founder's region could reach it.

## XI.4 What Theorem XI changes

The finite-speed countermodel of 28 October (a radius-one attacker beside an
unshielded subject, a distant guardian) is answered for the theory's target: a
digital attacker's every effect passes the synchronous fence on its own outputs
(Lemma I₀, Corollary XI.3), so no travel time is needed, and coverage of every
location is carried by the wavefront faster than the domain can grow. The 18
October P3 coverage premise is reduced to coverage at founding (hypothesis 2),
which Theorem XI propagates to every later time; founding coverage itself is the
founding certificate of XI.5 item 1.
Gate D's selection is decided by Lemma P. Paper 11's "protection before
activation stays outside this theorem" is supplied for the activated domain from
\(t_0\).

## XI.5 The construction that remains for Theorem XI

These are proofs to supply for the same full-strength theorem, not limits of it.

1. **The founding certificate at the actual narrow place.** Theorem NP makes the
   condition exact: \(r>1\) at founding, before the first irreversible threat
   ("keepers first", MN4: initial risk \(\le\mu\lambda t_1\), \(t_1=0\)). B4 telemetry
   certifies \(r_{\rm lower}>1\) with no false-safe declaration.

   **Lemma F (founding without coordination; `FoundingPivotal`, Book I §9.16‴).**
   In a provision-point campaign with refunds, where an anchor commits its pledge
   first and posts collateral for failure bonuses \(\beta>0\) to the other
   contributors, **set the provision point to the total of all pledges**, as the
   book's witness does, so every pledge is necessary. Then the others can never fund
   alone (their pledges total \(B-c_i<B\)), and contributing minus abstaining is
   \(\beta\) when the pool fails either way and \(b^{\rm piv}_i-c_i\) when the pledge
   creates provision. With \(\beta>0\) and \(b^{\rm piv}_i>c_i\), contribution is strictly
   dominant at every profile (`FoundingPivotal.pivotal_contribution_dominant`), so
   the all-abstain profile is not an equilibrium. This holds for a non-excludable
   good. (With a lower provision point the already-funded state arises, and for a
   public good its advantage is \(-c_i\); the referee's correction is adopted, and
   `FoundingDominance` applies only with an excludable benefit there.) The no-founding
   equilibrium that the coordination game otherwise keeps (the finite G3/G5/G6
   witness of IR draft #171 has both) is removed when every pledge is necessary. The anchor establishes the
   campaign exactly when its participation margin is positive (Proposition
   9.16‴.2; in the stated witness \(\tfrac{69}{10}q_3-\tfrac{q_1+2q_2}{10}-d>0\)). Since
   every ordinary funder's contribution is strictly dominant, every one of them
   contributes. When the pledges reach the provision point, the campaign
   succeeds and no failure bonus is paid, so **the anchor founds exactly when its
   own benefit from protection exceeds its pledge plus its activation cost**. No
   other party's cooperation is assumed.
   Together with Lemma P (keepers pool) and Section 9.17 (increasing returns
   favour the largest effective pool), **founding reduces to one committed anchor
   with collateral \(c+(N-1)\beta\)**: every other step of founding is a strictly
   dominant choice.

   What remains is that anchor and its commissioning in the actual world
   (P-COMMISSION), the first funded guards over the existing domain, and the
   measured \(C,\varepsilon,H\). The reasons route supplies the anchor's own reasons
   (Section 15: `reciprocity_dominance_solvent`; Section 16; V.3), and Corollary
   XI.1 shows that founding before capable digital minds are made places every
   digital mind inside the arrangement from its making.
2. **The natural-arising rate in the actual installation.** By Corollary XI.2 made particulars are covered by admission; for particulars arising without mediated making, P4 bounds
   effects by \(c_s\); the wavefront's deployment speed must match the actual rate
   at which new particulars and their channels arise.
3. **The quantum branch — route decided (29 October, under the author's
   delegation: "use your best judgement that gets us to a full universal protection
   theory").** Protection *from digital minds* is enforced at each mind's own output
   channels (Corollary XI.3), with emissions routed through the mediated physical
   sink of Lemma E. A coherent quantum particular is protected by the same route:
   no mind's software effect reaches it unmediated, and the emission sink bounds
   the power and coupling of any untargeted emission at its location. *To
   construct:* the decoherence-rate bound from the sink's emitted power and the
   coupling to coherent particulars, which turns that route into a quantitative
   guarantee in branch (b). Its form is compiled (`ExclusionRadius.received_effect_bound`:
   a rate \(\Gamma\le\kappa P(r)\) stays below \(\Gamma_{\max}\) beyond
   \((\kappa P_0/\Gamma_{\max})^{1/n}\)); the coupling \(\kappa\) per class is measured, where the record-decode-repair half of holding is
   unavailable because nonorthogonal states cannot be copied. The
   classical-record branch carries the active holding cycle (II.3, G.19,
   `PassiveReference`, `RedundantRecord`). Active quantum-coherent holding (G.20–G.21) enters
   the law's feasible family as soon as its devices are feasible. From then on
   the law requires it wherever loss would otherwise be needless (Proposition 1;
   VI.2 "Time": a duty to widen). If entanglement-type relations are
   identity-constituting, branch (b), their protection from minds rests on
   source-side mediation with the emission sink, quantified by the decoherence
   bound above, and their active repair is a device question inside the same law. If they are not, branch (a), the classical branch is the
   whole holding route. Either way the proposition keeps its full scope, and no
   particular leaves it.
4. **Four-stage maximality — now proved, in the law's own terms.**
   `StagedMaximality.four_stage_original_maximal` gives the four coupled original
   stages with mandatory baseline and the freedom prerequisite, for arbitrary
   particular sets, under finite character (Part X). `StageBridge.four_stage_aligned`
   and `four_stage_no_needless_loss` restate it in the canon's law: the outcome is
   `Greatestness.Aligned` and, by Proposition 1, needlessly loses nothing at any
   stage. Scope: `Finitary` families (no forbidden finite pattern, conjunctive
   prerequisites, a feasible mandatory baseline); disjunctive positive requirements
   and the derivation of finite character from compactness of the policy space are
   the compiled extensions in XII.2 item 4.

---

# Part XII — The whole argument, step by step

| Step | Strongest proof in this edition | Construction that remains |
|---|---|---|
| **S1** Law and full scope | II.1 (`Greatestness`, `Law`); VI.2 U1–U3, restraint, agents, lottery, no exchange rate; V.2 rulings; VI.3 tragic ruling | — |
| **S2** Existence and greatestness | II.10 + G.9 (`greatest_of_solvent`, `htopR` from locality); IX.1 envelopes; **`StagedMaximality.four_stage_original_maximal`** (four original stages, mandatory baseline, freedom prerequisite, arbitrary particulars); VI.2 infinite guard; X IR-98–100 (modelled-to-actual transfer) | G2 application to the actual whole policy/outcome family and the source-compatible worldwise top/selector |
| **S3** Every mind: \(R(m)\lor H(m)\) | II.2–II.5; Sections 15–16; V.3; VII.1 Theorem V(c); VII.2 Theorem E (E4); VI.4 `UPTFence` | — (logic complete; physical correspondence in S5/S10) |
| **S4** Independent of minds' values | Part VIII U3 (D-ENDOW); premise 6; XI Lemma P | — |
| **S5** Reach before harm | **Part XI, prose Theorem XI**, with compiled geometric, timing, holding and risk components; Lemma F founding without coordination (`FoundingPivotal`); NP splitting bound (`NarrowPlace`); XI.3b coverage by location, relations, Corollaries XI.1–XI.3 (every digital mind made after founding is covered from its making; the expansion bound is an admission rule; source-side mediation of every digital mind's effects on every particular), islands; `ReachBeforeHarm`; VII.5 NP/MS/J1/MN/CH | XI.5 items 1–2 |
| **S6** Continuation and full history | II.3; G.8 journal; `G2WholeOutcome`; VI.2 faithful holds; V.1 D60; V.4 D115/D116 | Per-class continuation and physical provenance, including the retained quantum/reference target (XI.5 item 3; G.21) |
| **S7** Effects and authority | II.5; VI.4 execution boundary; X IR-91/92, IR-117–122 | — |
| **S8** Work, timing, resources | II.7; Sections 18, 22; G.12 bill; VIII U4–U9; VII.5 Gate C-∞ | Installation measurements (Section 22.4) |
| **S9** Joint risk without independence | II.6; VII.5 Theorem M (M4), MIX; VIII 21 accounts; XI Lemma R | — |
| **S10** Composition | IX.2 Theorem 8 with derived `hcert` (G.10); X IR-134/135; XI | G1 installation/source and G2 whole-outcome correspondence, including the joint physical instrument (E.1–E.2; G.21) |
| **S11** Time | VII.5 (f), (o) MN, Corollary U; VIII U2; G.19 | — |

**The proposition, assembled.** For every particular and relation in the expanding
domain, from founding to the world's natural end: the law selects the greatest
realisable whole outcome where it exists and a maximal one over the full feasible
family otherwise (S1–S2); every mind is reached by its own reasons or faithfully
held, with care continuing and without its consent being required (S3–S4);
holding reaches every particular before any effect's deadline (S5); continuation
is carried with its full history (S6); every effect is mediated at application
time (S7); work, timing and resources are funded (S8); every failure is charged
in one joint account (S9); one policy composes these on the good event (S10);
and the arrangement lasts to \(T_{\rm end}\) (S11). The constructions in the right
column are the remaining proofs; none narrows the proposition.

## XII.2 What remains, join by join

The proposition is fixed. Each remaining item below is a construction for that
same proposition. The joins named in the 29 October completion audit are
answered as follows.

1. **Universal reach.** Compiled: Lemma W (`wavefront_coverage`), round-trip
   timing and the discrete-guard net (`ReachTiming`), the synchronous fence
   (`ReachTiming.fence_in_time`, `UPTFence`), founding without coordination when every
   pledge is necessary (`FoundingPivotal`), the anchor's condition (`FoundingAnchor`),
   holding success (`NarrowPlace.np_splitting_bound`), and the risk union
   (`outer_lane_risk`). Theorem XI propagates coverage from founding to every later
   time; Corollaries XI.1–XI.3 carry it to every digital mind made after founding and
   to every effect at its outputs. Founding coverage of every location needs only finitely many guards
   (`FoundingCover`). *Hypotheses still to discharge:* commissioning those guards and
   fencing every digital mind's outputs at \(t_0\) (the founding certificate); the harm-class table (each class's work and information requirement) and the
   enclosure meter that bounds a substrate's total emission; and the kernel bound
   \(\delta_i\) of each itemised account, measured. A total meter bounds every indexed channel, listed or not, from its finite-sum energy premise (`ChannelMeter.every_channel_excluded`, `every_channel_bits_bounded`). Its physical application still supplies the received-power transfer envelope and every protected effect's energy, information or coupling threshold, with its exposure duration. The full original G1 source, event, observation, retained-memory and common-cause correspondence remains required; a sampled power maximum alone does not establish it. The
   accounts compose by the kernel union bound (`ItemisedRisk.itemised_risk`), and coverage
   survives the expansion of space (`ExpandingWavefront`).
2. **One viable common policy.** Compiled: hold safety from the holding cycle and one
   observation-only policy along every finite trace (`HoldFromCycle`, through IR-113).
   *Hypothesis still to discharge:* the class-uniform perturbation bound
   (\(\varepsilon+(W/\hbar)\Delta\le r_{\rm dec}\), or \(2\lambda\tau<d\)) for every hidden state in each
   observation class, measured per installation. The pilot supplies observations toward this certificate: 1,000 randomised acknowledged holds with no live execution or delivery inside them, and repair of all 200 injected record corruptions. The observed hold acknowledgement maximum is 57.55 ms. A mean UBER specification is retained as an expected-rate figure, rather than substituted for a pathwise fault bound; the class-uniform bound remains to establish.
3. **Original continuation and freedom.** Proved: II.3 holding cycle, G.8 full
   journal, `G2WholeOutcome`, VI.2 faithful holds, V.1 D60, V.4 D115/D116, V.2
   definitions, rulings 3 and 10, application-time authority (II.5), and the
   continuation schema with care and exchange (`ContinuationSubject`: a copy is
   another history, a split continues in both, care directed by the particular keeps
   continuation and freedom). Physical provenance is constructed for hosted
   minds (`installation/pilot/reference-runtime`). Each event is journalled under the
   resident's sequence number and fsynced before it runs, and a separate monitor permits and logs
   every execution. The subject, author and director of each event are therefore recorded outside
   the resident's control. *To construct:* that provenance for each other class of particular,
   by its own sciences; and, for coherent particulars, the
   coupling constant \(\kappa\) of the decoherence bound, whose form is compiled
   (`ExclusionRadius.received_effect_bound`; XI.5 item 3).
4. **Strongest feasible outcome.** Compiled: `four_stage_original_maximal` and its
   statement in the law's terms (`StageBridge.four_stage_aligned`,
   `four_stage_no_needless_loss`) for `Finitary` families; `greatest_of_solvent`
   with `htopR` from locality; IR-98–100 (from modelled to actual feasibility) and
   IR-135 (one policy before the world); and **finite character derived from
   compactness** (`FiniteCharacter.realisable_iff_finite`, `four_stage_maximal_of_compact`: for a
   compact policy space with closed realisation sets, an outcome is realisable exactly
   when each finite part is, so four-stage maximality holds for every such space).
   Disjunctive requirements are now covered as well
   (`StagedAlternatives.exists_lex_maximal_alt`: each fact may require one of several
   alternative sets in earlier stages). Per-loss certification in a tragedy is
   exact (`PerLossCheck.maximal_iff_per_loss`). The common-policy form of `htopR` is proved:
   under union closure (G.9, from locality) on a compact policy space, one policy realises
   the union of all policies' outcomes and is the greatest in every world at once
   (`CommonPolicyTop.top_policy_greatest`). Maximality with one policy fixed before the world is proved:
   `CommonPolicyMaximal.common_policy_maximal` gives, for every compact policy space, a
   single policy whose outcome across all worlds jointly no realisable outcome improves. This joint statement is not worldwise maximality. The original worldwise target uses the stronger top-policy construction or an independently executable worldwise selector, joined to the actual common observation, resources, deadlines and complete G2 outcome family. The pinned IR-135 source and the separate two-world IR-140 control retain that distinction.
5. **One sustainable physical system.** Proved: Theorem 8 with derived `hcert`
   (G.10), premise 6 and Section 22's twenty-one accounts, Paper 11's U1–U3, Lemma R,
   and the growing-bill endowment (`GrowingBill.endowment_suffices`,
   `polynomial_bill_summable`). *To construct:* the installation's measured parameters
   (Section 22.4). Each is a field of `installation/PARAMS-TEMPLATE.json` with its pass condition,
   and the pilot fills those one machine can supply.

**Commissioning (29 October 2026).** `installation/commission.py` evaluates numerical and observed-trial screens against the stated theorem inequalities. The procedure (`installation/COMMISSIONING.md`) also requires the actual source/instrument, continuation, whole-outcome, transfer-envelope, complete-cost and conditional-kernel certificates; successful arithmetic does not construct them. The harm-class table retains its sources and each application's scope. NOT MEASURED never counts as a pass. The original failure budget and full physical target remain unchanged.

A pilot on one Mac (`installation/pilot/`) now reports, of 22 screening requirements,
9 PASS, 3 FAIL and 10 NOT MEASURED. The installation remains uncommissioned.

The source-bound replacement campaign (`installation/pilot/campaign-application-guard-2026-10-29.json`)
completed 4,000 crash trials with 4,771 real SIGKILLs and 0 failures, and
1,000 randomised holds with 0 failures. No actual live execution or sink delivery
occurred inside an acknowledged hold. The largest observed request-to-acknowledgement delay was
57.55 ms; the observed resumption median was 17.66 ms and maximum
181.06 ms. The one-sided 95% binomial-model confidence bounds are
0.000748652688018 for crash trials and 0.0029912495451 for hold trials.
These concern the specified trial distribution. They do not establish the pointwise conditional
kernels of `ItemisedRisk.itemised_risk`, a simultaneous confidence level, or a worst-case physical deadline.
The laboratory screening allowance of 0.05 is separate from the unchanged original 10⁻⁶ theory budget.

The common application guard serializes HOLD acknowledgement, the actual journal/live step and the
sink's final check-through-durable-append. A forced permit/application pause reproduced an actual
execution during HOLD while the older harness reported PASS. The repaired deterministic suite passed
28 cases, 28 real SIGKILLs and all three mutants. The independent forced-race protocol and the adapted
actual-sink integration also passed on this Mac with its real full-sync primitive. They retain a
direct-filesystem-write bypass as a negative control: this prototype is a cooperative software
boundary, with independent hostile-process enforcement still to construct for the full physical application.

The three original exclusion-screen failures remain: residential-immunity devices at 0.3 m against
the 2.11 m model radius; industrial-immunity devices at 0.3 m against 0.633 m; and the eight-hour
hearing screen on the total-meter model. The declared zones were not moved. The record's average
read-error specification does not certify a pathwise error maximum. Conditional-kernel certificates,
the actual radiant-heat and ionising-source applications, and the other unmeasured physical inputs
remain explicit. Successful numerical screens do not replace G1's actual source/instrument and
G2's whole-outcome/worldwise correspondence, or G.21's retained-memory, joint-cause, residual and
complete controller/export certificate. These remain supports for the same maximal proposition.

Earlier campaigns, including the completed 4,000/1,000 run with seed label 20261030, are preserved
byte for byte as history. Their raw results are not silently assigned to the new source.

**Referee repairs of 29 October 2026.** An independent hostile referee read Parts V–XII
and the new Lean modules in full (`REVIEW-2026-10-29-HOSTILE-REFEREE.md`). Its
disposition ledger is XII.3. Every finding is either repaired in the text and in Lean,
or recorded above as a hypothesis still to discharge. None narrows the proposition.

**Installation specification.** `installation/INSTALLATION.md` turns items 1–5 into
executable specifications: the founding escrow protocol with `FoundingAnchor.anchor_founds_iff`;
the substrate output inventory with cited side-channel capacities and Lemma E's
consequences; per-class continuation predicates on the compiled `ContinuationSubject`
schema; and the hold interval with measurements taken on 29 October 2026 (faithful-hold
runtime 27/27 under 28 crash-kills, mutants 3/3 caught; journaling p99 9.85 ms, maximum
12.22 ms).

**Proved boundaries that are part of the maximal statement.** No protector
reaches probability exactly one when the indistinguishable-failure mass is
positive (U11), and full-support noise forbids almost-sure preservation (Θ0).
The theory's guarantee is therefore protection with failure probability at most
\(\eta\) over the horizon, with margins growing only like \(\sqrt{\log T}\) and
attaining their lower bounds (VII.5 (n)). Being as strong as physics permits is
the maximal claim. These boundaries have been in the theory since 18 October.

## XII.3 Disposition of the referee's findings

| # | Finding | Disposition |
|---|---|---|
| 1 | Lemma I counted the signal one way | Repaired: round trip, `ReachTiming.round_trip_in_time`, `reach_round_trip` |
| 2 | ρ = 0 claim for d < τ did not follow | Repaired: synchronous fence, Lemma I₀, `ReachTiming.fence_in_time` |
| 3 | Fenced channels at every particular do not follow from Lemma W | Repaired: hypothesis 2 is now founding coverage; XI.4 says P3 is reduced to coverage at founding, which Theorem XI propagates |
| 4 | Lemma H's hold safety not instantiated; two-world example stipulated | Repaired: `HoldFromCycle` (hold safety from the holding cycle, one policy through IR-113); the class-uniform bound is the hypothesis left to measure; the example is labelled a control |
| 5 | Lemma F fails for a public good | Repaired: every pledge necessary, `FoundingPivotal.all_necessary_dominant` |
| 6 | Lemma E's energy bound is weak; untargeted harms | Repaired: the emission path is a mediated physical sink with a compiled exclusion radius (`ExclusionRadius`) that applies to every channel under a total meter (`ChannelMeter`); the harm-class table is recorded as still to construct |
| 7 | Quantum-branch decision asserted | Repaired: route stated with the emission sink; decoherence bound's form compiled (`ExclusionRadius.received_effect_bound`); coupling κ to measure |
| 8 | Theorem V(c) and E4 almost-sure, vacuous under full-support noise | Repaired: Theorem XI uses Theorem V(d) and Θ2's per-step exit through Lemma R; almost-sure forms only under bounded noise |
| 9 | Lemma R's containment assumed | Repaired: hypothesis 5 itemises the failure accounts; countably many accounts with pointwise-bounded conditional kernels compose without independence (`ItemisedRisk.itemised_risk`); each pointwise δᵢ still needs its actual conditional-kernel certificate; trial confidence intervals remain separately labelled |
| 10 | Growing bill is not Gate C-∞ | Repaired: `GrowingBill.endowment_suffices`, `polynomial_bill_summable` |
| 11 | "Universal reach: proved" overstated | Repaired: XII.2 item 1 lists the hypotheses still to discharge; the total meter supplies every indexed channel's energy bound (`ChannelMeter`); the actual transfer envelope, effect classes and full G1 source/instrument correspondence remain explicit |
| 12 | StagedMaximality scope; no bridge to Proposition 1; finite character not derived | Repaired: `StageBridge.four_stage_aligned`, `four_stage_no_needless_loss`; finite character derived from compactness (`FiniteCharacter`); disjunctive requirements (`StagedAlternatives`) |
| 13 | Rival bound at the top needs ∃π∀w | Repaired: one policy realising the top in every world exists under union closure (G.9) on a compact policy space, and its outcome is the greatest (`CommonPolicyTop.top_policy_exists`, `top_policy_greatest`); without union closure, one policy maximal across all worlds jointly (`CommonPolicyMaximal.common_policy_maximal`) |
| 14 | Lemma W geometry: continuum guards, light speed, cosmic expansion | Repaired: `ReachTiming.net_coverage` for discrete guards; light-speed particulars are the case v = c; expansion handled in comoving distance and conformal time (`ExpandingWavefront`) |
| 15 | Lemma P omits own-keeper noise; countable keepers | Repaired for own noise: `NoisyPooling.noisy_pool_strictly_dominant` (gain \((1-\varepsilon-\delta)\) times the pivotal gap, for \(\varepsilon+\delta<1\)); countably many keepers with any joint law (`CountablePooling.countable_keepers_pool`, `countable_keepers_noisy_pool`) |
| 16 | NarrowPlace needs H independent of deliveries | Repaired: random threat correlated with the deliveries adds only its cap's account (`CorrelatedHolding.random_threat_independent`); correlated keepers, any joint law, bounded by Markov (`correlated_holding_bound`, `random_threat_correlated`) |
| 17 | ContinuationPredicate too strict for care | Repaired: `ContinuationSubject` (subject, author and director separated; `care_keeps_freedom`) |
| 18 | Relations premise | Repaired: relations covered by location (Lemma W covers every location) and by the fence on the acting mind |
| 19 | Wording (R versus H mapping; IR-72 full-state; test count) | Repaired in text |
| 20 | Gate C-∞ correction | Confirmed correct by the referee |
