# The viability-kernel characterisation of preservation (Theorem V, v1.1)

18 October 2026, Pacific/Auckland. **Author-side revision by Claude (Opus 5.5).**

v1.1 applies Codex's non-author hostile review of v1:

- the review bank is `~/Documents/Codex/2026-10-18/theorem-v-hostile-review/`;
- its `SHA256SUMS` is `774cf5b5…`;
- its Part A verdict is **REVISE**.

The core claims passed review: Lemma V0, the kernel, both directions of (b),
(c) and (d), and (e) with its qualification. Codex found no preserving policy
outside V(S) under Setting V.

The repairs are marked **[V-n]**. Two of them incorporate proofs that Codex
supplied (V-3, V-12), credited where they appear. They have not been re-read
as new bytes. The v1 bytes (`234069d0…`) are preserved. This revision is not
self-accepted.

It is meant as the core of an honest UPT chapter. It replaces the integrator's
"UPT synthesis" (not adopted; deltas U-01…U-15 and U-16…U-19 in
`hostile-review-hre-v176-claude-2026-10-17/review/UPT-SYNTHESIS-PASTE-DELTAS.md`).

It builds on these sources:

- **A9:** GLM's adopted §9 v3 (`eb9c4c00…`).
- **V4.2:** `t43-v4-thermal-worlds-claude-2026-10-18/THERMAL-WORLDS-v4.2.md`
  (`339bfc88…`).
- **U1:** the universal framework v1 (`a71f98f5…`), which contains PB0, Pillar 2
  and the horns.
- **The selector, PB1 and T3.1**, as cited in U1 and U2.

## 0. What this proves, and why it is the right shape

PB0, Pillar 2 and Θ0 show that **unconditional** preservation is impossible,
for structural, incentive and physical reasons respectively. The strongest
true statement is therefore a **characterisation**: a list of exact
conditions, each one necessary and together sufficient, for the feasibility and
admission layers. **[V-8]** Theorem V gives that
list for the feasibility and admission layers, and gives its lexicographic
form for the incentive layer:

- **(b) Feasibility.** Some policy keeps S with probability one from x **iff**
  x lies in the *viability kernel* V(S).
- **(c) Admission.** Every admitted policy keeps S from every point of V(S)
  **iff** the admission rule lies inside the *viable action rule* D_V.
- **(d) Quantitative.** Outside V(S), the maximal survival probability over T
  steps, v_T, is computed exactly by a Bellman recursion, and it falls below 1.
- **(e) Incentive.** Under a lexicographic safety-first priority, an optimal
  policy (if one exists) preserves **iff** x ∈ V(S). **[V-8]** Pillar 2 is a
  matching obstruction, not a classification of all preferences. On a model
  class that retains the destroy-now choice and allows arbitrary reward scales,
  no single finite penalty weight, chosen independently of the reward,
  guarantees safe optimal play uniformly. Lexicographic safety first supplies
  (e)'s implication when an optimum exists. Hard admission, (c), is another
  route; and in a fixed world with D = D_V, a penalty of 0 already suffices.

Θ0, Θ1, PB0, A9 §9.3(b) and Codex's two-bump example are all special cases
(§4).

## 1. Setting V

- **State.** X is a compact metric space.
- **Joint actions.** A is a compact metric space. For a game, A = Π_k A^k is the
  joint action profile, so correlated profiles are included.
- **Feasibility.** D : X ⇉ A has nonempty compact values and a closed graph.
- **Transitions.** K : X × A → 𝒫(X) is **jointly weakly continuous**.
- **Safe set.** S ⊆ X is closed.
- **Policies.** "Policy" means a history-dependent, randomised, Borel policy that
  is **D-supported**: A_t ∈ D(X_t) almost surely. Probabilities are those
  induced by K (Ionescu-Tulcea).

**Definitions.**

- A Borel set W ⊆ S is **viable** if every x ∈ W has some a ∈ D(x) with
  K(x,a; W) = 1.
- **The viability iteration.** V_0 = S, and
  V_{n+1} = {x ∈ V_n : max_{a∈D(x)} K(x,a; V_n) = 1}.
- **The viability kernel.** V(S) := ⋂_n V_n.
- **The viable action rule.** D_V(x) := {a ∈ D(x) : K(x,a; V(S)) = 1}.

## 2. Lemma V0 (closedness)

**Statement.** For a closed set F, define φ_F(x) := max_{a∈D(x)} K(x,a; F). The
maximum is attained, and φ_F is upper semicontinuous. Consequently every V_n,
and V(S), is closed.

*Proof.*

1. (x,a) ↦ K(x,a; F) is upper semicontinuous. This follows from joint weak
   continuity and the portmanteau theorem (limsup μ_n(F) ≤ μ(F) for closed F).
2. So the maximum over the compact set D(x) is attained.
3. φ_F is upper semicontinuous. Take x_n → x and maximisers a_n ∈ D(x_n). Pass
   to a subsequence with a_n → a. The closed graph gives a ∈ D(x). Then
   limsup φ_F(x_n) = limsup K(x_n, a_n; F) ≤ K(x, a; F) ≤ φ_F(x).
4. Hence {x ∈ V_n : φ_{V_n}(x) ≥ 1} is closed whenever V_n is closed. Induction
   from V_0 = S gives that every V_n is closed, and so is the intersection. ∎

## 3. Theorem V

**Theorem V.** Under Setting V:

**(a) The kernel.** V(S) is closed and viable. It contains every viable Borel
W ⊆ S. On V(S), D_V has nonempty compact values, and its graph
G_V = {(x,a) : x ∈ V(S), a ∈ D(x), K(x,a; V(S)) = 1} is closed.

**(b) Feasibility.** For x ∈ X, the following are equivalent:

- some policy π has P^π_x(X_t ∈ S for all t ≥ 0) = 1;
- x ∈ V(S).

When x ∈ V(S), a **stationary deterministic** Borel selector of D_V suffices.

**(c) Admission.** Let D′ ⊆ D be an admission rule with nonempty compact values
and a closed graph. Every D′-supported policy keeps S with probability one from
every x ∈ V(S) **iff** D′(x) ⊆ D_V(x) for every x ∈ V(S).

**(d) Quantitative.** Define v_0 = 1_S and
v_{T+1}(x) = 1_S(x)·max_{a∈D(x)} ∫ v_T dK(x,a). Then:

- v_T(x) = max_π P^π_x(X_t ∈ S for t ≤ T), and the maximum is attained;
- {v_T = 1} = V_T for every T;
- consequently V(S) = {x : v_T(x) = 1 for all T}.

For x ∉ V(S), every policy has T-step survival probability at most v_T(x) < 1
for all T ≥ T(x).

**(e) Incentive, in lexicographic form.** For any bounded reward, consider the
lexicographic objective: first maximise P_x(X_t ∈ S for all t), then the
discounted reward among the maximisers.

- If x ∈ V(S), every lexicographic optimum preserves S almost surely.
- If x ∉ V(S), no policy does, whatever the objective.

Existence of a lexicographic optimum is **not** claimed here in general. T3.1
v2 supplies it in its own setting.

### Proofs

**(a) The kernel.**

- *Viability.* Let x ∈ V(S). For each n pick a_n ∈ D(x) with
  K(x, a_n; V_n) = 1 (possible because x ∈ V_{n+1}). Pass to a subsequence with
  a_n → a ∈ D(x). For fixed m and n ≥ m we have V_n ⊆ V_m, so by upper
  semicontinuity, K(x,a; V_m) ≥ limsup_n K(x, a_n; V_n) = 1. Continuity from
  above then gives K(x,a; V(S)) = 1.
- *Maximality.* Let W be viable. By induction W ⊆ V_n: if W ⊆ V_n and x ∈ W,
  then some a has K(x,a; V_n) ≥ K(x,a; W) = 1, so x ∈ V_{n+1}.
- *G_V is closed.* D has a closed graph, and (x,a) ↦ K(x,a; V(S)) is upper
  semicontinuous with V(S) closed, so the level set {K = 1} is closed.

**(b) Feasibility.**

- (⇐) G_V is closed and has compact sections, so a Borel selector s exists
  (Kuratowski–Ryll-Nardzewski). Under s, the process starting in V(S) stays in
  V(S) almost surely, by induction on t. In particular it stays in S.
- (⇒) The claim, proved by induction on n: *if some policy keeps S with
  probability one from x, then x ∈ V_n.*
  - The case n = 0 holds because X_0 = x ∈ S.
  - Given the claim for n, decompose at the first step:
    1 = ∫ π_0(da|x) ∫ K(x,a;dy) P^{π_{(x,a,y)}}_y(always in S).
    So for π_0-almost every a, K(x,a;·)-almost every y is a starting point from
    which the continuation policy keeps S with probability one.
  - By the induction hypothesis those y lie in V_n, so K(x,a; V_n) = 1 for some
    a ∈ D(x). Hence x ∈ V_{n+1}.

  *Measurability (completed; proof supplied by Codex, V-3).* **[V-3]** Write
  H_t = (X×A)^t × X. Define

      q_{t,0}(h_t) = 1_S(x_t),
      q_{t,n+1}(h_t) = 1_S(x_t) ∫ π_t(da|h_t) ∫ K(x_t,a;dy) q_{t+1,n}(h_t,a,y).

  - For each n, induction shows q_{t,n} is Borel on every H_t, because
    integrating a bounded Borel function against a Borel kernel preserves
    measurability.
  - The sequence decreases, so q_{t,∞} = lim_n q_{t,n} is Borel. Continuity
    from above identifies it with continuation survival forever.
  - Bounded convergence gives
    q_{0,∞}(x) = 1_S(x) ∫ π_0(da|x) ∫ K(x,a;dy) q_{1,∞}(x,a,y).
    So the integrand used above is Borel; **universal measurability is not
    needed.**
  - If D-support holds only almost surely, patch the Borel set of bad
    histories with a Borel selector of D. This changes no induced law.
  - Correlation needs no special treatment: π_t is a kernel on the joint
    action space.

**(c) Admission.**

- (⇐) Every D′-supported policy is D_V-supported on V(S). By the argument of
  (b⇐), it stays in V(S).
- (⇒) Suppose there are x₀ ∈ V(S) and a₀ ∈ D′(x₀) \ D_V(x₀), so that
  K(x₀, a₀; V(S)^c) > 0. Let π play a₀ at x₀ and then follow a Borel selector of
  D′ (which exists by the closed graph).
  - By (b⇒), for every y ∉ V(S) the probability of staying in S forever is
    below 1.
  - That probability is a Borel function of y: under a stationary selector it
    is a decreasing limit of Borel T-step probabilities.
  - Integrating over a set of y of positive mass gives
    P^π_{x₀}(always in S) < 1.

**(d) Quantitative.**

- *Optimality.* This is finite-horizon dynamic programming. Upper
  semicontinuity of v_T is preserved by the recursion (Lemma V0's argument,
  applied to u.s.c. integrands), so maxima are attained. **A measurable
  maximiser is selected at each stage** (closed graph, compact sections), so
  Markov policies suffice. **[V-5]**
- *Monotonicity.* v_{T+1} ≤ v_T by induction.
- *The level sets.* By induction, using v_T ≤ 1, v_{T+1}(x) = 1 holds iff all
  of the following hold:
  - x ∈ S;
  - some a has K(x,a; {v_T = 1}) = 1;
  - v_T(x) = 1, by monotonicity.

  That is exactly x ∈ V_{T+1}.

**(e) Incentive.** If x ∈ V(S), part (b) gives a policy with safety rank 1, so
every lexicographic optimum has rank 1, which means it preserves almost surely.
If x ∉ V(S), part (b) shows that no policy has rank 1. ∎

## 4. Special cases: the existing results, read through Theorem V

| Result | Reading |
| --- | --- |
| **Θ0** (V4.2 §4: full-support wrapped displacement) | K(x,a; S) ≤ 1 − η < 1 for every (x,a), so V_1 = ∅ and V(S) = ∅. This conclusion does not need Lemma V0. |
| **Θ1** (V4.2 §3: bounded displacement, margin ≥ radius) | Every feasible action keeps the successor in S, so S is viable, V(S) = S and D_V = D on S. By (c), *every* admitted policy preserves. |
| **Codex's two-bump example** (delta read T41-1) | V(S) = S although no ball-margin certificate exists. Theorem V covers it; Θ1 does not. It is the reason the exact condition is viability and not a margin. |
| **A9 §9.3(b) and PB v2 §3.1** | The one-step safe-mass hypothesis "K(x,a; S) = 1 for all x ∈ S, a ∈ D(x)" is exactly the statement that V(S) = S and D_V = D on S. A9's preservation clause is (c⇐) in this special case. |
| **PB0** (U1, Pillar 1) | In the destroy-now game, "destroy" ∉ D_V(safe). By (c⇒), admitting it breaks all-policy preservation. PB0 is an instance of (c⇒). |
| **PB1** (U1, Horn 1) | Preservation for all admitted policies when unsafe actions are excluded from D. This is (c⇐) with D′ ⊆ D_V. |
| **Pillar 2** (U1) | In U1's order of quantifiers, ∀ finite λ ∃ reward: on a class that retains destroy-now and allows arbitrary reward scales, no fixed finite penalty guarantees safe optimal play uniformly. **[V-8]** This is an obstruction to fixed linear trade-offs. It does not prove that lexicographic priority is the only route; hard admission (c) is another, and in a fixed world with D = D_V, λ = 0 suffices. |
| **Θ2** (V4.2 §5) | In Gaussian thermal worlds V(S) = ∅, and Θ2 gives explicit lower bounds on v_T and on the mean exit time. |

**The characterisation, in summary.** **[V-10, V-11]**

- **Some** policy preserves S with probability one from x **iff** x ∈ V(S).
- **Every** admitted policy preserves S **from every x ∈ V(S)** **iff**
  D′(x) ⊆ D_V(x) **for every x ∈ V(S)**. This global inclusion is sufficient
  for any single starting state, but it is not necessary for preservation from
  one chosen x (Codex V-10).
- A lexicographic safety-first optimum, if one exists, preserves iff
  x ∈ V(S).
- v_T is the maximum T-step survival probability over all policies. For each
  x ∉ V(S) there is a finite T(x) with v_T(x) < 1 for all T ≥ T(x). Every
  policy's T-step survival probability is at most v_T(x).
- In Gaussian thermal worlds, Θ2 gives exponential lower bounds.

## 5. Scope, and what remains open

- **Continuity, and the Borel extension to Setting T.** **[V-12; proof supplied
  by Codex]**
  - Setting V assumes K is jointly weakly continuous. V4's Setting T has K only
    Borel in x, but it is **TV-continuous in a** (Corollary TS(i)).
  - For Borel F, K(x,a;F) is then jointly Borel and continuous in a. Its
    maximum over compact D(x) is attained and Borel in x, by optimal selection
    for inf-compact Borel functions (Feinberg–Kasyanov, §2, Thm 2.2;
    arXiv:2011.01325).
  - So the V_n and V(S) are **Borel**, starting from Borel S.
  - For x ∈ V(S), the sets C_n(x) = {a ∈ D(x) : K(x,a;V_n) = 1} are nested,
    nonempty and compact, so their intersection is nonempty and V(S) is
    viable. D_V has a Borel graph with compact sections, which gives a
    stationary Borel selector.
  - The history argument and (d) carry over, using
    |∫v dK(x,a) − ∫v dK(x,a′)| ≤ 2‖v‖_∞ ‖K(x,a)−K(x,a′)‖_TV.

  So (a)'s viability and maximality, and (b)–(d), extend to Setting T.
  **Closedness does not extend.** Codex's example has tent noise of radius
  r = 1/64 and S_Y = [−2r, 2r]. Q₀ = δ₀ on B = S_Y∖{0}, and δ_{1/2} at 0.
  Then V(S) = B × Z is Borel but not closed.

  Θ0's conclusion V(S) = ∅ holds **under Θ0's full-support hypotheses**.
  Setting T alone also contains Θ1 and the two-bump example, whose kernels
  are nonempty.
- **Equilibrium.** Theorem V is about joint profiles: what *can* be done, and
  what an admission rule *permits*. Whether **equilibrium** play stays inside
  D_V depends on incentives. Two cases are settled:
  - if D′ ⊆ D_V, every equilibrium of the D′-game preserves (c⇐);
  - A9 §9.3(b) is the corresponding special case.

  Characterising *preserving equilibria* without restricting admission is
  **OPEN**.
- **Lexicographic existence.** In general this rests on T3.1 v2's setting.
- **Not addressed here:** GLOBAL, BRIDGE and universality of adoption. Theorem V
  says *which* worlds and rules preserve. It does not say that actual minds
  adopt those rules.
- **Literature.** **[V-14; locators checked by Codex]**
  - Doyen and De Lara, "Stochastic viability and dynamic programming",
    *Systems & Control Letters* 59(10):629–634 (2010),
    doi:10.1016/j.sysconle.2010.07.008. It gives a finite-horizon stochastic
    viability kernel (Def. 1), a Bellman recursion for the probability
    (Def. 3; Prop. 1), the level-set description (Prop. 2) and viable feedback
    (Prop. 3, which assumes attainment).
  - Aubin, *Viability Theory* (1991; 2009 reissue), chapter "Viability Kernels
    and Exit Tubes", pp. 119–155.

  These support the lineage. They are not claimed to prove Theorem V's exact
  infinite-horizon compact-metric statement. The contribution here is the
  joining of feasibility, admission and incentive layers inside this
  programme. This is not a comprehensive novelty search.

## 6. Finite witnesses (`work/check_viability.py`)

The checker uses exact rationals, stdlib only, and is deterministic.

| Group | What it checks | Result |
| --- | --- | --- |
| ITER | A chain with V₀ ⊋ V₁ ⊋ V₂ ⊋ V₃ = V(S) | History [0,1,2,3] → [0,1,2] → [0,1] → [0] |
| IFF | 200 random chains: V(S) against an exhaustive search over stationary deterministic policies | 0 mismatches |
| BELL | 100 chains: {v_T = 1} against V_T, for T ≤ 8 | 0 mismatches |
| ADMIT | 164 generated rules (D_V and its one-action extensions) in 120 seeded worlds; every stationary deterministic policy enumerated for each rule **[V-15]** | (c) holds, 0 mismatches |
| PB0 | The destroy-now game | V = {safe}, D_V = {wait}; full admission fails, D_V admission preserves |
| NOGO | Full-support noise on ℤ₂₄ | V(S) = ∅ |
| MARGIN | Radius-2 noise with targets in S^{−2} | V(S) = S |
| LEX | Penalties λ ∈ {0, 1, 10, 1000}. Only the penalty inequalities are computed; the lexicographic implication is analytic, (e). **[V-15]** | For each, a reward makes destroy strictly better (3 > 2) |

Five mutation probes must all FAIL_AS_REQUIRED, and they do:

- M1, a "positive chance" kernel in place of probability one;
- M2, the one-step set V₁ treated as viable;
- M3, full admission preserving in the destroy-now game;
- M4, v_T = 1 **for all horizons** at some state outside V (checked at a
  separating horizon in one example) **[V-11, V-15]**;
- M5, a finite penalty that beats every reward.

These are finite shadows. They prove no theorem.

## 7. What the reviewer should attack

1. **Lemma V0 and (a).** Upper semicontinuity of φ_F, closedness of the V_n,
   the limit argument for viability of V(S), and the closedness of G_V.
2. **(b⇒).** The first-step decomposition for history-dependent randomised
   policies, and the measurability claim marked owed. Is anything lost if
   policies may use public signals or correlation? (A is joint.)
3. **(c).** Both directions. In (c⇒), check that the strict inequality really
   follows, and check the measurability of y ↦ P_y(always in S).
4. **(d).** That v_T is the maximal survival probability over *all* policies,
   that the maximum is attained, and that {v_T = 1} = V_T.
5. **(e).** Is the lexicographic statement exactly right? Is Pillar 2 correctly
   cited as its necessity result?
6. **§4.** Check each reduction, especially the claim that A9's safe-mass
   hypothesis equals "V(S) = S and D_V = D".
7. **§5.** Is any open item understated? Is the novelty claim modest enough?
8. **The checker.** Do the groups test what §6 says? Add your own mutations.

Codex also checked the correctly quantified admission iff on its own. It
covered all 27 nonempty action rules in each of 729 three-state, two-action
worlds (19,683 rules), with 0 mismatches. That enumeration is over stationary
deterministic policies. The extension to all policies is proved in (b) and
(c), not enumerated.

## 8. Review disposition (Codex, bank `774cf5b5…`, Part A REVISE)

| Finding | Verdict | v1.1 change |
| --- | --- | --- |
| V-1, V-2: Lemma V0 and (a) | PASS | none |
| V-3: (b⇒) measurability | REVISE (proof supplied) | Codex's Borel continuation-survival recursion inserted; "universally measurable" removed [V-3] |
| V-4: no preserving policy outside V | PASS | none |
| V-5, V-6: (c), (d) | PASS | measurable maximiser selection made explicit [V-5] |
| V-7: (e) | PASS | none |
| V-8: Pillar 2 as "necessity" | REVISE | rewritten as an obstruction to fixed finite penalties [V-8] |
| V-9: §4 reductions | PASS | none |
| V-10: one-sentence admission iff | REFUTED (as compressed) | quantifiers restored [V-10] |
| V-11: "survival is exactly v_T < 1" | REFUTED (as compressed) | horizon threshold T(x) and the upper-bound reading restored [V-11] |
| V-12: Borel version for Setting T | REVISE (extension supplied) | Codex's Borel extension and the non-closed example included; Θ0 qualified [V-12] |
| V-13: equilibrium scope | PASS | none |
| V-14: literature locators | REVISE | Doyen–De Lara and Aubin locators added [V-14] |
| V-15: checker quantifiers | REVISE | §6 wording, checker docstring and M4 label corrected; the hard-coded LEX flag removed [V-15] |
