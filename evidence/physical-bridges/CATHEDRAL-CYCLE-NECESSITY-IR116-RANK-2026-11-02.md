# CATHEDRAL-CYCLE-NECESSITY-01 — Cyclic protection via the existing UPT source theorems

**2 November 2026 (NZDT).** New finite-graph necessity/safety equivalence, cyclic IR116 consequences, and a source-interface ledger. Draft research; noncanonical; no physical cosmology claim and no new Hume/X3/greatestness proof.

## Prior theorems, retained verbatim

Pinned UPT source at immutable main SHA 26abaa24b7e0f5715de0e9c85a25149adfbb5435:

- [IR116CumulativeSubjectDuties.lean](https://github.com/Tobillicious/universal-protection-theory/blob/26abaa24b7e0f5715de0e9c85a25149adfbb5435/evidence/compiled-strongest/lean/Snuffy/IR116CumulativeSubjectDuties.lean): EveryOwedSubjectProtected; cumulative_duties_preserved; initial_cohort_retains_continuity_and_every_required_option; old_or_new_remains_owed. Original monotone owed-subject ledger and robust protection on **actual fixed-policy source transitions**.
- [IR134SourceExtractedOutcome.lean](https://github.com/Tobillicious/universal-protection-theory/blob/26abaa24b7e0f5715de0e9c85a25149adfbb5435/evidence/compiled-strongest/lean/Snuffy/IR134SourceExtractedOutcome.lean): complete physical source run extraction; every_source_prefix_retains_owed_cohort; source-owned four-stage outcomes, not arbitrary externally supplied history labels.
- [IR135CommonPolicyWorlds.lean](https://github.com/Tobillicious/universal-protection-theory/blob/26abaa24b7e0f5715de0e9c85a25149adfbb5435/evidence/compiled-strongest/lean/Snuffy/IR135CommonPolicyWorlds.lean): **one** policy fixed before all reactive worlds; policy-dependent world response; explicit failure of combining separate per-world winners.
- [G2Splice.lean](https://github.com/Tobillicious/universal-protection-theory/blob/26abaa24b7e0f5715de0e9c85a25149adfbb5435/evidence/compiled-strongest/lean/Snuffy/G2Splice.lean), [G2Held.lean](https://github.com/Tobillicious/universal-protection-theory/blob/26abaa24b7e0f5715de0e9c85a25149adfbb5435/evidence/compiled-strongest/lean/Snuffy/G2Held.lean) and [G2Physical.lean](https://github.com/Tobillicious/universal-protection-theory/blob/26abaa24b7e0f5715de0e9c85a25149adfbb5435/evidence/compiled-strongest/lean/Snuffy/G2Physical.lean): existing greatestness, held-source and physical-control theorems **under their existing premises**. PR [#196](https://github.com/Tobillicious/universal-protection-theory/pull/196) already proves a conditional cyclic G2 splice and held-top shortcut. Do not repeat any of these.
- [Frozen BCRD foundation](https://github.com/Tobillicious/physics-lane/blob/2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35/orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/README.md) defines B1–B7 open cut composition targets, not a physically derived unrestricted cyclic trace. P0/N1/N2 and M5/M7 source controls are retained in PRs #193–194.

**New task:** test the strong claim that **all physically possible closed histories necessarily satisfy the original UPT law**, rather than only admitting some greatest protective policy. Can one exclude an avoidably violating cyclic history using a finite, independently grounded source certificate?

## CYCLE-NECESSITY-01 — exact finite cyclic-exclusion/rank equivalence

Let S be a finite set of **complete source states** and A be a finite set of **actual source-admitted labelled transitions** with maps src,dst:A→S. Keep action, disturbance and historical provenance labels: two edges may have the same endpoints but different physical effects. Let Bad:A→{0,1} be a **separately justified original-UPT violation monitor**. This monitor is **not** supplied by the graph theorem and must respect original X3, ledger, freedom and authorization semantics. In particular full four-stage maximality is a **global** comparison and cannot automatically be substituted for an edge-local Bad label.

A complete closed walk is a nonempty composable list e₁,...,e_k with dst(e_i)=src(e_(i+1)) and dst(e_k)=src(e₁).

**Theorem CYCLE-NECESSITY-01.** These conditions are equivalent:

1. Every complete directed closed walk has Bad(e)=0 on every constituent edge.
2. For every bad edge u→v there exists **no** path v⇝u (including the zero-length path when u=v).
3. No bad edge has both endpoints in the same strongly connected component (SCC).
4. There exists a finite **obstruction-rank certificate** V:S→ℕ₀ such that

\[
\boxed{V(\mathrm{src}(e))\ \ge\ V(\mathrm{dst}(e))+\mathrm{Bad}(e)\qquad\forall e\in A.}
\tag{RANK}
\]

Moreover choose V(s)≤|S|−1.

**Proof.** (1)⇒(2): a bad edge and the returning path form a forbidden closed walk. (2)⇔(3): any edge u→v already witnesses u⇝v, so u and v are in the same SCC precisely when v⇝u exists. (4)⇒(1): sum (RANK) around a closed walk; the V terms telescope and give 0≥Σ Bad(e_i), forcing each nonnegative Bad(e_i)=0. (3)⇒(4): contract all SCCs into a finite DAG. Each edge *within* an SCC is good. For every contracted vertex C define V(C) as the **maximum sum of Bad-edge weights along directed paths beginning at C** (allow the empty path, weight zero). There are at most |S|−1 intercomponent edges on any such path. For any edge C→D, V(C)≥Bad(e)+V(D); for intracomponent edges V is equal and Bad=0. Pull V back to original states. QED.

**Interpretation:** V is a **finite well-founded certificate**, NOT a new entropy, cosmic complexity metric, or physical time variable. This result decides the finite source graph problem exactly. It does not derive which graph genuinely describes BCRD matterspacetime or that Bad genuinely encodes an original-X3 violation.

**Exact controls:**
- Nontrivial two-state good cycle 0→1→0, with a *transient* bad branch 1→2 from which there is no return: has RANK and active nonvacuum closed histories.
- Bad two-cycle 0→1→0 with second edge bad: cyclic recurrence alone permits a violating closed history; no RANK can exist.

## CYCLE-IR116-02 — cumulative subject duties around an exact source seam

Fix any original subject m. Assume the **already banked IR116 hMonotone** condition along a given source policy: owed(s,m)⇒owed(t,m) for every actual s→t.

**Theorem:** On every finite *truly source-identical* closed trace s₀→...→s_k=s₀, the owed(m) predicate is identical at **every** cut. **Proof:** forward monotonicity carries owed from any vertex to every later vertex, and the remaining part of the same directed loop carries it back. QED.

This does NOT say local births are prohibited. It says a **globally cumulative owed ledger on a truly closed complete history cannot add a subject for the first time in each lap**. In a physically cyclic whole, all owed identities need consistent global seam indexing even as local current lives and configurations change. This is exactly why original X3 source identity/IR116 ledger may not be replaced by a cleared record or copy. Under a seam permutation, one needs a source-certified identity transport before making the corresponding statement.

## CYCLE-IR116-ANCHOR-03 — one protected anchor per recurrent SCC

Let P(s) be the **original IR116.EveryOwedSubjectProtected** predicate, preserving its actual continuation and *all* required executable option obligations. Assume the source's already defined hRobust/local protection is valid along every transition under the fixed policy:

\[
P(\mathrm{src}(e))\Rightarrow P(\mathrm{dst}(e)).
\tag{GUARD}
\]

**Theorem:** Given GUARD, **every vertex on every closed walk is protected** if and only if **every SCC containing a nonempty closed walk has at least one protected vertex**.

**Proof:** If every cyclic vertex is protected, each recurrent SCC has a protected vertex. Conversely, given x on a closed walk, choose a protected anchor a in its SCC. By strong connectivity there is a source path a⇝x; GUARD propagates P along that path. QED.

This directly joins **old IR116 robust source protection** to **new cyclic reachability**, with no reproof of X3. The single strongly connected source-graph special case needs only one P anchor. However, “one relational universe” does NOT by itself imply its entire source-state graph is strongly connected, and neither physical source closure nor protected anchors have been demonstrated for every possible universe.

## Exact IR134/IR135 source interface

A legitimate graph must be built from an *already verified source*:

\[
\mathrm{PhysicalStep}_{next}(s,a,t)\iff\exists d,\ next(s,a,d)=t.
\]

Fix a policy π, observation function and actually admitted disturbances; IR134 extracts **real complete state histories**, not caller-invented histories. For reactive IR135 worlds the disturbance is world(s,π(observe(s))) on that very execution. **Do not union incompatible choices into a graph and then claim hybrid directed cycles represent a source-admitted universe.** Where required, augment graph vertices with the *unchanged policy/world identity and causal memory* and prove that graph closed walks coincide with physically admitted closed histories.

The same applies to all physical cyclic seams: an external coarse cut returning is not automatically a historically identical full source state (BCRD N1/N2 and original X3). If some directed closed walks are physically forbidden by global consistency not encoded in the graph, the rank certificate remains **sufficient** but not necessarily a **necessary** condition for the real physical histories.

### What this genuinely leaves to prove for Universe ⇒ actual UPT

1. Derive **the true physical cyclic source graph** from BCRD B5/B6/M5/M7 plus original source history/cause semantics; do not assume a clock or all cycles realizable.
2. Derive from the original UPT's full source outcomes a **faithful violation/continuation monitor**. Original X3 stage-wise maximality, authorization and avoidability cannot silently be weakened to a bit.
3. Derive from independently physical dynamics **either** RANK (excluding all bad recurrent edges) **or** GUARD plus certified protected anchors in each physically recurrent component (possibly using the already established G2Held source policy as an anchor where genuinely installed).
4. Prove **actual physical source selection/authorization**: existence of a top feasible guardian is not the assertion every physically possible cyclic history uses that guardian.
5. Only then test the reverse physical UPT⇒Universe meaning; an abstract mathematics of UPT does not create a physical cosmos by itself.

This is the precise analytical frontier. We have proved an iff *within the fully specified finite source graph*; we have **not** proved universal physical protection, eternal recurrence, or creation of successive universes. No earlier UPT theorem is downgraded or re-proved.

## Verification

Run: python evidence/physical-bridges/check_cathedral_cyclic_necessity.py

- **19,767 exhaustive** directed labelled graphs (absent/good/bad edge for every ordered pair), sizes 1–3, checking no bad recurrent edge iff finite RANK exists, with all inequalities checked.
- **157,794 exhaustive** assignments of a protected/owed state predicate across the same graphs, checking IR116-style forward monotonicity, constant owed status within SCCs, and the recurrent-anchor criterion.
- **2,400 seeded random** directed graphs with 4–5 states.
- Positive nonconstant protected cycle, transient violation branch, and bad-cycle countercontrol.

All locally passed. No new Lean kernel compilation or independent physical validation; mathematical proofs above are independent of enumeration.

## 6. Source-backed caution: an existing IR134 theorem already separates feasibility from selection

A final read of the **actual compiled** [IR134 source](https://github.com/Tobillicious/universal-protection-theory/blob/26abaa24b7e0f5715de0e9c85a25149adfbb5435/evidence/compiled-strongest/lean/Snuffy/IR134SourceExtractedOutcome.lean) recovered **unexercised_freedom_under_permanent_stutter**. Its source-specified serviceStep allows a true action to increment the counter, but the actual false-selecting policy remains at zero for every finite disturbance history. This is **already machine-proved** and is explicitly identified by the source as the inherited IR-43 progress warning. It shows that the *availability* of a feasible action does not ensure the actual controller chooses it. It is **not** a proof of UPT's failure or a nontrivial source-validated cosmological countermodel: the example is an inactive fixed point, whereas the proposed cyclic universe is intrinsically dynamic. But it is an exact source-backed reason not to infer that because a top protection policy can exist, **every** closed physical source must select it.

Likewise [IR135](https://github.com/Tobillicious/universal-protection-theory/blob/26abaa24b7e0f5715de0e9c85a25149adfbb5435/evidence/compiled-strongest/lean/Snuffy/IR135CommonPolicyWorlds.lean) already includes each_world_separate_success_does_not_yield_common_policy; a local winner selected separately for each world is not a single guardian for all reactive worlds. Keep these **old countercontrols** in the cathedral proof inventory; do not “repair” them by weakening original UPT universal scope.

The next bridge therefore has to be source-dynamical: derive **actual protection-selecting necessity** or the SCC/rank exclusion of all unprotected closed histories from *independently justified* BCRD physical constraints, with a complete physical history and action-responsive world. Merely observing a cyclic cut and citing G2Held does not discharge that implication.


## 7. Generalization beyond finite state sets (important scope repair)

The **closed-walk ⇔ return-path ⇔ SCC** subtheorem (conditions 1–3 of CYCLE-NECESSITY-01) does **not depend on finiteness at all**. For an arbitrarily large directed labelled graph, even with infinitely many source states, a **finite** nonempty violating closed walk exists iff some bad edge u→v admits a **finite** directed return path v⇝u. The proof by concatenating an edge and a return path is unchanged. Likewise CYCLE-IR116-ANCHOR-03 works over arbitrary directed graphs and arbitrary subject domains because source-policy protection propagates along finite reachability paths.

**The natural-number RANK condition is only guaranteed by the SCC theorem for a finite graph.** In an infinite graph with an endless one-way sequence of bad transitions and no return paths, there is no bad closed walk, yet a rank into ℕ₀ need not exist: such a rank would have to decrease strictly forever. In that case the general graph condition (no bad edge inside any SCC) remains the exact characterization of **finite** closed source walks, and any well-founded potential needs separately justified global progress/well-foundedness hypotheses. Also, if actual cyclic matterspacetime requires a non-discrete/infinite compositional trace, equivalence with **finite walks** needs a source-specific completeness theorem; do not declare the general graph fact a physical universal-cosmology proof.


## 8. INFINITE-ANCESTRY-01 — the author's survival lever, tested at its strongest

**Motivation:** The proposed philosophical cathedral join is not another derivation of "there is a universe". It is: **if there have been indefinitely many ancestral cosmogenic transitions and a historical lineage nevertheless exists now, what survival mechanism must be mathematically present?** This section treats this as the actual research target and separates its logical and probabilistic versions.

### Conditional survival theorem — no independence hypothesis

Let C_n be the event that one particular historically continuous ancestral lineage survives n consecutive universe-to-universe transitions. Assume C_(n+1)⊆C_n and, for some ε∈(0,1], that for every n with P(C_n)>0,

\[
P(C_{n+1}\mid C_n)\le 1-\varepsilon.
\tag{UNIFORM-RISK}
\]

Then by multiplying conditional probabilities (and treating a zero term as permanently zero),

\[
P(C_n)\le(1-\varepsilon)^n P(C_0),
\quad\text{hence}\quad
\boxed{P\Bigl(\bigcap_{n\ge0}C_n\Bigr)=0.}
\tag{SURVIVAL-0}
\]

**Proof:** \(P(C_{n+1})=P(C_n)P(C_{n+1}\mid C_n)\) because C_(n+1)⊆C_n. Induction yields the geometric bound. Continuity from above for probability measures gives the intersection probability as the decreasing limit. QED.

**This does not assume independent cycles.** Thus a model positing **positive probability** of a continuously surviving lineage through an infinite ancestral succession cannot also posit a uniform positive lower bound on the conditional risk of extinction at each succession.

**Scope caution:** The occurrence of the present world is *not proof that its ancestral lineage has existed infinitely often*, that the same physical particular survived every ancestral transition, or that that event has positive probability in some independently validated ensemble. Mathematical probability-zero events can occur in some models and conditioning on "we exist" introduces a selection effect. The conclusion is a model-level incompatibility, **not identification of guardians, UPT or physical cyclic cosmology**.

### The exact missing uniqueness/selection join

Even if we independently established an indefinitely continuous ancestral line, the result above would not force the historical protection architecture of UPT. Other possible mechanisms may avoid a uniform failure floor; even nonzero risks with \(\sum_n \varepsilon_n<\infty\) can permit positive probability of infinite survival. And indefinite existence of **some** universe is weaker than continuous preservation of **all original X3 historical particulars and their freedoms**.

An explicit deterministic logical model: state U_n alternates between A and B for every integer n via a reversible 2-cycle; the world is richly differentiated, has a well-defined transition, is eternal in both directions, and has **no source-identified guardians**. Thus the implication "closed universe ⇒ guardians" requires **independent physical exclusion** of such non-guardian cycles. A second model may have each cosmos seed the next while independently ending many original particulars; then eternal cosmogenesis still does not entail original-X3 universal protection.

The genuine next theorem must rule these possibilities out from **source-derived** physics and original UPT constraints, not predefine "source-admissible" to mean "protected".

### The proposed reciprocal \(\varphi\) and physical comparability

If the proposed scalar is \(\varphi(x)=x+1/x\), then, for nonzero x,
\[
\varphi(x)=\varphi(1/x).
\]
This is an **exact reciprocal symmetry**, but noninjective labels by themselves are not a source-proved equivalence of **whole physical universes or thermodynamic ledgers**. One needs a map of complete state/history data and source-faithful transport of entropy, work, agency and identity.

If instead the *iteration rule* of successive universes were \(x_{n+1}=\varphi(x_n)\) with x_n>0, then \(x_{n+1}-x_n=1/x_n>0\): the scalar strictly increases and has **no finite positive periodic orbit**. Therefore it is essential to specify whether \(\varphi\) is an invariant/descriptor, a duality, a potential, or the **dynamical generation map**. Do not conflate them.

The existing [UPT thermodynamic ledger](https://github.com/Tobillicious/snuffy-canon-edition/blob/main/CANON-EDITION-V4.1/inserts/18-theorem-8-thermodynamic-ledger.md) uses capital \(\Phi\) for a **different storage/Lyapunov functional** based on code error and escrow shortfall. A notational resemblance does not identify it with x+1/x or a cosmogenic transfer. Preserve the prior thermodynamic results and ask for the actual source-defined link rather than invent it.

### What we can now honestly claim

- **Proved:** infinite-lineage survival under a uniform conditional failure floor has probability zero; no independence assumption.
- **Proved:** \(\varphi(x)=\varphi(1/x)\) for x≠0, but positive iteration x↦x+1/x is not periodic.
- **Not proved:** infinitely many ancestral universes physically occurred; guardian production is the unique cosmogenic mechanism; the new universe is identical to its predecessor in full BCRD/UPT source semantics; UPT follows by physical necessity from "there is a universe".
- **Highest-value next cathedral join:** find a source-validated cosmogenic transition \(\Gamma:\mathcal U\to\mathcal U\) and prove that its **entire physically admissible generative image**, rather than an arbitrary policy choice, preserves the existing UPT X3 history/freedom obligations. Only if the physics of \(\Gamma\) itself compels that source property would the author's existence-based lever close noncircularly into the proposed Universe ⇒ actual UPT necessity result.
