
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
(`greatest_of_solvent`). This is the 29 October audit's "Certificate B".

**In a tragedy, certification is per loss.** Where \(\top\) is not realisable,
Proposition 1 (`aligned_iff_no_needless_loss`) turns maximality into one check for
each particular lost: no feasible option keeps it while agreeing at every earlier
stage. `four_stage_original_maximal` guarantees that an outcome passing every such
check exists, and the last-resort ladder and the impartiality ruling (VI.3)
govern the choice among such outcomes.

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
redirected to the canon and the source hash recorded in each header. IR-134/135
remain in draft PR #172 of that repository. Each is cited by
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

**Lemma I (interception in time; `interception_in_time`).** A guard within
\(\rho\le c_s(d-\tau)\) of the particular, signalling at \(c_s\) and responding in
\(\tau\), acts before \(d\). For attacks with \(d\le\tau\) (an adjacent attacker
acting in one step, the finite-speed countermodel of 28 October) the requirement
is \(\rho=0\): the interlock is at the particular's own effect channels. That is
exactly the canon's mediation: every effect on a protected particular lands only
through a fenced sink checked at application time (II.5, `UPTFence`; IR-91/92 for
all nine channels), and per-site E9 sensing with quorum no-masking
(`E9SelfHealing.no_masking`, `Instruments.branchC_complete`) detects below-
threshold and logical attacks. With \(\rho=0\) Lemma W says every particular of the
domain carries its own fenced channels at every time.

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
jurisdiction.

**Lemma R (risk; `outer_lane_risk`).** If failure of the outer lane is contained in
founding failure, a holding failure at some date, or a charged account failure,
its probability is at most \(\eta_F+\sum_t\varphi_t+\sum_i\delta_i\), with no
independence assumed.

**Lemma H (the hold is a common viable action; `HoldCommonAction`).** IR-113
shows that one observation-only protective policy exists exactly when every
observation class has an action keeping every compatible viable state viable.
The holding route supplies that action. A faithful hold lands no effect, so its
safety does not depend on which hidden state is actual. Its admitted successors
stay viable whenever the holding cycle's interval bound holds:
\(\varepsilon+(W/\hbar)\Delta\le r_{\rm dec}\) (`Bridge.qsl_within_radius`), or for discrete
faults \(2\lambda\tau<d\) (`Bridge.headroom_within_radius`). Under that bound the hold
is a common viable action at every observation class
(`hold_is_common_viable_action`, no axioms). One policy that acts wherever an
action is safe for the whole class, and holds elsewhere, keeps viability
everywhere (`act_or_hold_policy`). In the two-world countermodel, where `a`
protects in one hidden world and harms in the other and `b` does the reverse, no
effect-landing action is safe in both (`no_effect_action_safe_in_both`), but the
hold is (`two_world_resolved`). The common-action premise of IR-113/135/137 is
therefore derived from the holding cycle, not assumed.

**Composite (`ReachBeforeHarm.reach_before_harm`).** Under Lemma W's hypotheses
with \(\rho\le c_s(d-\tau)\): at every \(t\ge0\), every particular of \(D(t)\) has a
guard \(g\in G(t)\) with \(|x-g|/c_s+\tau\le d\) — it is reached before its deadline.

## XI.3 The theorem

**Theorem XI (reach before harm).** Suppose at founding time \(t_0\):

1. **(Founding threshold.)** Protection-first capacity satisfies
   \(r=C(1-\varepsilon)/H>1\) with \(H=c(K_E+aS_{\max})+A\) (Theorem NP), split among
   \(n\) independent keepers (MS), so that \(\varphi(n)\le\exp(-2n(1-\varepsilon-H/C)^2)\)
   (`NarrowPlace.np_splitting_bound`);
   founding fails with probability at most \(\eta_F\).
2. **(Initial coverage.)** Every particular of \(D(t_0)\) carries its fenced effect
   channels and is within interception radius \(\rho\le c_s(d-\tau)\) of a funded
   guard.
3. **(Expansion at least as fast as the domain.)** The guarded region expands at
   speed \(v\ge c\): the wavefront of Section 21.7, whose sweep succeeds with an
   \(O(t^{d_G})\) cumulative bill (G.12).
4. **(Funding.)** Income meets premise 6's master solvency condition, whose first
   term \(\omega_0R(t)^{d_G-1}\) is exactly the boundary-maintenance rate of the
   expanding region; equivalently Paper 11's endowment flow per island, or a Gate
   C-∞ regime.
5. **(Charged accounts.)** The twenty-one charged accounts of Section 22.3 have
   genuine conditional kernels with \(\sum\delta\le10^{-6}\).

Then from \(t_0\) through \(T\le T_{\rm end}\), with probability at least
\(1-\eta_F-\sum_{t\le T}\varphi_t-\sum_i\delta_i\):

- every particular of \(D(t)\) — including every particular newly arising after
  founding — is within interception radius of a guard and carries fenced effect
  channels at every \(t\) (Lemma W, Lemma I);
- therefore every mind \(m\), wherever it is, can affect a protected particular
  only through a mediated channel inside guard reach before the effect's deadline:
  either its effect is admissible (inside \(D_V\)) — it is reached, or acts as a
  keeper by its own reasons, \(R(m)\) — or it is restrained by the holding
  construction of II.3–II.6 while its care continues, \(H(m)\);
- the holding coalition forms without coordination (Lemma P) and keeps its
  advantage (VII.5 (b3), Theorem MN: \(r(t)\) non-decreasing before the twilight);
  \(\sum_t\varphi_t\) converges when keepers grow (J1);
- the guarantee is carried by one observation-based policy fixed before the world
  is chosen (IR-113, IR-135; IR-72 for the infinite horizon), and every admitted
  policy preserves (Theorem V(c), Theorem E (E4) admission route);
- the continuation invariant holds for every protected particular by
  `Bridge.universal_protection_held` on the good event (II.6).

*Proof.* Lemma W with hypotheses 2–3 gives coverage at every \(t\). Lemma I turns
coverage into interception before every deadline, with \(\rho=0\) mediation at the
particular's own channels for adjacent attackers. An effect on a protected
particular that is not admissible is therefore met by the holding step of II.3
(perturbation within decoding radius, decode, funded repair; `holding_preserves`,
`holding_cycle_physical`) and the fence; by Theorem V(c) and Theorem E (E4)
every policy admitted by that rule preserves \(S\), whatever its rewards. Lemma P
makes the protecting coalition the outcome among protection-first keepers;
hypothesis 1 with NP/MS bounds the holding failure at each date and J1 bounds its
sum; hypothesis 4 funds the guards and their expansion (G.12's bill is the
integral of premise 6's boundary term); IR-113/IR-135 give the common policy.
Every failure of the conclusion lies in founding failure, a holding failure, or a
charged account, and Lemma R bounds the probability. ∎

## XI.3b Coverage by location: every particular, every relation, every made mind

**Coverage is by location, not by registry.** Lemma W covers every point of the
domain. A particular need not be recognised, registered, minded or living to be
within interception radius of a guard: the nonliving, the unregistered and the
newly arising are covered because they are somewhere in the one structure (P1).
IR-116's cumulative duties then keep every particular once owed; Lemma W makes
the owed set the whole domain.

**Relations.** By P2 identity is constituted through relations, and by P4 every
change propagates locally. A relation therefore changes only through an effect on
the state of at least one of its relata. Every relation among particulars of the
domain is carried by the fenced channels of its relata, and is protected with them.

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

**Lemma E (emissions carry no targeted harm beyond the meter; `EmissionBound`).**
A substrate's physical emissions are outputs that pass no fence. Two bounds place
them in the mediated ledger. By conservation (P1) the metered input energy splits
into the energy accounted at fenced sinks and the emitted remainder. An effect
needing more work than that remainder cannot be powered by emissions
(`emission_cannot_power`). By requisite variety (D116, compiled as
`requisite_variety`), a channel delivering one of \(M\) messages lets a responder
answer correctly for at most \(M\) disturbances, whatever the encoding. So a
targeted effect that must select among more than \(M\) responses within its
deadline succeeds with probability at most \(M/|D|\) (`requisite_variety_prob`;
\(2^{k-n}\) in bits, `narrow_channel_bits`). A harmful effect through emissions
therefore needs both unaccounted energy and unmediated channel capacity. The
installation meters the first and bounds the second (Section 21.3's calibrated
channel cap applies to every accessible side channel). Corollary XI.3's
dependence on the G1 inventory is thereby reduced to these two measured
quantities.

**Islands.** Protection composes over causally bound islands (VII.5 (i), IS): a
region whose particulars no founder's signal can reach is protected by its own
founding, and the global failure bound is the union over islands (Lemma R). Within
each founder's causal future the wavefront advances at the maximal admissible
speed, so every particular a founder can ever affect is covered as soon as any
effect from that founder's region could reach it.

## XI.4 What Theorem XI changes

The finite-speed countermodel of 28 October (a radius-one attacker beside an
unshielded subject, a distant guardian) is answered at its root: in Theorem XI no
protected particular is unshielded, because coverage is established at founding
and carried by the wavefront faster than the domain can grow, and adjacent attacks
meet the particular's own fenced channels. The 18 October P3 coverage premise is
derived from founding coverage, expansion speed and funding, rather than assumed.
Gate D's selection is decided by Lemma P. Paper 11's "protection before
activation stays outside this theorem" is supplied for the activated domain from
\(t_0\).

## XI.5 The construction that remains for Theorem XI

These are proofs to supply for the same full-strength theorem, not limits of it.

1. **The founding certificate at the actual narrow place.** Theorem NP makes the
   condition exact: \(r>1\) at founding, before the first irreversible threat
   ("keepers first", MN4: initial risk \(\le\mu\lambda t_1\), \(t_1=0\)). B4 telemetry
   certifies \(r_{\rm lower}>1\) with no false-safe declaration.

   **Lemma F (founding without coordination; `FoundingDominance`, Book I
   §9.16‴).** In a provision-point campaign with refunds, where an anchor commits
   its pledge first and posts collateral for failure bonuses \(\beta>0\) to the other
   contributors, contributing minus abstaining is \(\beta\) when the pool fails
   either way, \(b^{\rm piv}_i-c_i\) when the pledge creates provision, and
   \(b^{\rm already}_i-c_i\) when others fund alone. With \(\beta>0\) and both benefits
   above the pledge, contribution is strictly dominant at every profile of the
   others' pledges (`contribution_strictly_dominant`), so the all-abstain
   profile is not an equilibrium (`no_abstention_equilibrium`). The no-founding
   equilibrium that the coordination game otherwise keeps (the finite G3/G5/G6
   witness of IR draft #171 has both) is removed. The anchor establishes the
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
3. **The quantum branch — decided (29 October, under the author's delegation:
   "use your best judgement that gets us to a full universal protection
   theory").** The decision does not change the protection guarantee, in either
   branch. Protection *from digital minds* is enforced at each mind's own output
   channels (Corollary XI.3, Lemma E). A coherent quantum particular is therefore
   protected exactly as a classical one is: no mind's effect reaches it
   unmediated, and it evolves under its own physics, in its own direction. The
   classical-record branch carries the active holding cycle (II.3, G.19,
   `PassiveReference`, `RedundantRecord`). Active quantum-coherent holding (G.20–G.21) enters
   the law's feasible family as soon as its devices are feasible. From then on
   the law requires it wherever loss would otherwise be needless (Proposition 1;
   VI.2 "Time": a duty to widen). If entanglement-type relations are
   identity-constituting, branch (b), their protection from minds is already
   given by source-side mediation, and their active repair is a device question
   inside the same law. If they are not, branch (a), the classical branch is the
   whole holding route. Either way the proposition keeps its full scope, and no
   particular leaves it.
4. **Four-stage maximality — now proved.** `StagedMaximality.four_stage_original_maximal`
   gives the four coupled original stages with mandatory baseline and the freedom
   prerequisite, for arbitrary particular sets, under finite character (Part X).

---

# Part XII — The whole argument, step by step

| Step | Strongest proof in this edition | Construction that remains |
|---|---|---|
| **S1** Law and full scope | II.1 (`Greatestness`, `Law`); VI.2 U1–U3, restraint, agents, lottery, no exchange rate; V.2 rulings; VI.3 tragic ruling | — |
| **S2** Existence and greatestness | II.10 + G.9 (`greatest_of_solvent`, `htopR` from locality); IX.1 envelopes; **`StagedMaximality.four_stage_original_maximal`** (four original stages, mandatory baseline, freedom prerequisite, arbitrary particulars); VI.2 infinite guard; X IR-98–100 (modelled-to-actual transfer) | — |
| **S3** Every mind: \(R(m)\lor H(m)\) | II.2–II.5; Sections 15–16; V.3; VII.1 Theorem V(c); VII.2 Theorem E (E4); VI.4 `UPTFence` | — (logic complete; physical correspondence in S5/S10) |
| **S4** Independent of minds' values | Part VIII U3 (D-ENDOW); premise 6; XI Lemma P | — |
| **S5** Reach before harm | **Part XI, Theorem XI** (`OuterLane` compiled); Lemma F founding without coordination (`FoundingDominance`); NP splitting bound (`NarrowPlace`); XI.3b coverage by location, relations, Corollaries XI.1–XI.3 (every digital mind made after founding is covered from its making; the expansion bound is an admission rule; source-side mediation of every digital mind's effects on every particular), islands; `ReachBeforeHarm`; VII.5 NP/MS/J1/MN/CH | XI.5 items 1–2 |
| **S6** Continuation and full history | II.3; G.8 journal; `G2WholeOutcome`; VI.2 faithful holds; V.1 D60; V.4 D115/D116 | Per-class continuation predicates in the installation (quantum branch decided, XI.5 item 3) |
| **S7** Effects and authority | II.5; VI.4 execution boundary; X IR-91/92, IR-117–122 | — |
| **S8** Work, timing, resources | II.7; Sections 18, 22; G.12 bill; VIII U4–U9; VII.5 Gate C-∞ | Installation measurements (Section 22.4) |
| **S9** Joint risk without independence | II.6; VII.5 Theorem M (M4), MIX; VIII 21 accounts; XI Lemma R | — |
| **S10** Composition | IX.2 Theorem 8 with derived `hcert` (G.10); X IR-134/135; XI | G1 installation/source correspondence (E.1) |
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

1. **Universal reach.** Proved: Theorem XI with `ReachBeforeHarm`, coverage by
   location (XI.3b, no registry), relations through their relata, Corollary XI.1
   (every digital mind made after founding is inside from its making), XI.2 (the
   expansion bound is an admission rule) and XI.3 (every digital mind's every
   effect is mediated at its own output channels). Founding without coordination
   is Lemma F (`FoundingDominance`), and holding success is NP
   (`NarrowPlace.np_splitting_bound`). *To construct:* the founding anchor and its
   commissioning before capable digital minds are made, and the G1 inventory of
   every substrate output channel. Physical emissions enter through Lemma E, so what remains for them is to meter the input energy and the accounted dissipation, and to bound the capacity of each side channel (E.1).
2. **One viable common policy.** Proved: Lemma H derives the common safe action
   from the hold (`HoldCommonAction`), with Theorem V(b)–(c), IR-113/135 and IR-72
   for the infinite horizon. *To construct:* the hold-interval bound in each
   installation (\(\varepsilon+(W/\hbar)\Delta\le r_{\rm dec}\); Section 22 parameters).
3. **Original continuation and freedom.** Proved: II.3 holding cycle, G.8 full
   journal, `G2WholeOutcome`, VI.2 faithful holds, V.1 D60, V.4 D115/D116, V.2
   definitions (a split continues in both branches), rulings 3 and 10, and
   application-time authority (II.5). *To construct:* the continuation predicate
   for each physical class of particular in the installation (II.1: "for each
   physical class, the bridge supplies the predicates"). The quantum branch is
   decided (XI.5 item 3): protection from minds is branch-independent.
4. **Strongest feasible outcome.** Proved: `four_stage_original_maximal` over
   the full feasible family (finite character = the ruling that real tragedies
   are finite), `greatest_of_solvent` with `htopR` from locality, the IX.1
   envelopes, IR-98–100 (from modelled to actual feasibility), and IR-135. The
   feasible family is the family of information- and causality-feasible
   policies, the policies that can actually be executed, as IR-135's countermodel
   requires. No rival enumeration is needed: at the top the upper bound is the universal tuple (IX.1), and in a tragedy maximality is certified one loss at a time (Proposition 1). *To construct:* in a tragedy, the installation's per-loss checks.
5. **One sustainable physical system.** Proved: Theorem 8 with derived `hcert`
   (G.10), premise 6 and Section 22's twenty-one accounts, Paper 11's U1–U3, and
   Lemma R (one ledger without independence). *To construct:* the installation's
   measured parameters (Section 22.4).

**Proved boundaries that are part of the maximal statement.** No protector
reaches probability exactly one when the indistinguishable-failure mass is
positive (U11), and full-support noise forbids almost-sure preservation (Θ0).
The theory's guarantee is therefore protection with failure probability at most
\(\eta\) over the horizon, with margins growing only like \(\sqrt{\log T}\) and
attaining their lower bounds (VII.5 (n)). Being as strong as physics permits is
the maximal claim. These boundaries have been in the theory since 18 October.
