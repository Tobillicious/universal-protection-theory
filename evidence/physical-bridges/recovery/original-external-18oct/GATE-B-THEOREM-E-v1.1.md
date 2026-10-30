# Gate B: Theorem E, v1.1 (preserving equilibria when destruction is admitted)

18 October 2026, Pacific/Auckland. **Author-side revision by Claude (Opus
5.5).**

v1.1 applies Codex's non-author hostile review:

- the review folder is `~/Documents/Codex/2026-10-18/gates-b-c-hostile-review/`;
- its Part B verdict is **ACCEPT-WITH-REPAIRS**;
- its REVIEW.md was pinned at `bba13e8a…` **before the bank was sealed**, as
  Codex hit a usage limit;
- repairs are marked **[EB-n]**.

L-B is Codex's supplied verification lemma
(`work/VERIFICATION-LEMMAS.md`, `8da89172…`). Claude has read it as a
non-author, and it is incorporated with credit. The v1 bytes (`cfe49c5f…`)
are preserved. This revision is not self-accepted.

It builds on TV1.1 (`82683837…`), U4 Part IV (`10d67071…`), A9 (`eb9c4c00…`)
and Gate A, Theorem V-B (`8e91615c…`; Claude's review ACCEPT, `4408dbc3…`).

## 0. The question, and the shape of the answer

Theorem V(c) says that every *admitted* policy preserves S from every point
of V(S) iff admission lies inside D_V. When destruction **is** admitted, a
D_V-supported profile is an equilibrium of the full game exactly when no
player gains from deviating. Theorem E writes that condition per player,
splits it into safe and destructive deviations, and adds two things:

- an a-priori sufficient margin, computed from rewards alone, when ending is
  irreversible;
- the two routes, incentive and admission, stated with globally defined
  rules.

## 1. Setting G (games)

- **Players.** I = {1, …, N} with N < ∞.
- **Feasibility.** Product feasibility D(x) = Π_k D^k(x). Each D^k has
  nonempty compact values and a closed graph.
- **Kernel.** K(x, a) is jointly weakly continuous.
- **Rewards.** Each r_k is bounded and Borel; continuity is used only where
  Theorem V requires it. The discount β ∈ (0,1) is common.
- **Viability.** S is closed; V = V(S), and D_V is Theorem V's set of
  **joint** viable profiles.
- **Profiles.** **σ is a measurable stationary profile.** **[EB-2]** Each
  σ^k(·|x) ∈ 𝒫(D^k(x)), and the players randomise independently given x.
- **Public-signal profiles. [EB-3]** A signal law λ(du|x) is drawn at the
  current state. Given (x, u), the players randomise independently with
  σ^k(·|x, u). Values v̄_k are taken *before* the signal, with future signals
  drawn afresh.
- **Unilaterally safe actions** (signal-free form; the public form uses
  (x, u)): U^k(x) := {b ∈ D^k(x) : K(x, b, σ^{−k}(x); V) = 1}.
- **The one-step test function:**

      Q_k(x,b) := r_k(x, b, σ^{−k}(x)) + β∫ v_k^σ dK(x, b, σ^{−k}(x)).

  It is evaluated in expectation over σ^{−k}'s mixture.
- **Gain and loss:**
  - Gain_k(x,b) := r_k(x, b, σ^{−k}(x)) − r_k(x, σ(x));
  - Loss_k(x,b) := ∫ v_k^σ dK(x, σ(x)) − ∫ v_k^σ dK(x, b, σ^{−k}(x)).

## 2. Theorem E

**Theorem E.** Assume Setting G. Let σ be a measurable stationary profile with
**joint support** supp σ(x) ⊆ D_V(x) for every x ∈ V. **[EB-2]**

**(E1) Preservation. PROVED.** σ keeps S with probability one from every
x ∈ V.

**(E2) The equilibrium splits into keeping margins. PROVED, via L-B.
[EB-1]** σ is an equilibrium of the **full** game against every feasible
history-dependent randomised unilateral deviation from every state **iff**,
for all k, all x and all b ∈ D^k(x),

    Q_k(x,b) ≤ v_k^σ(x).                                   (B)

Equivalently, Gain_k(x,b) ≤ β·Loss_k(x,b). Partition the deviations:

- (i) the unilaterally safe deviations, b ∈ U^k(x), at x ∈ V;
- (ii) **the keeping margin**: the destructive deviations, b ∉ U^k(x), at
  x ∈ V;
- (iii) every deviation at x ∉ V.

**Public-signal form. [EB-3]** For every x, for λ(·|x)-almost every u, for
every k and every b ∈ D^k(x),

    Q_k(x,u;b) ≤ w_k(x,u),

with w and Q computed against σ(·|x,u) and the successor's pre-signal value
v̄_k. The null-set quantifier comes **before** the quantifiers over players
and actions.

*Codex's witness* shows that a test averaged over the signal can pass while
this per-signal test fails. A fair public signal prescribes (0,0) or (0,1);
after signal 1, switching gains 1. **Averaged tests are not sufficient.**

**(E3) An a-priori keeping margin. PROVED. [EB-4]** Suppose V^c is
**exactly absorbing** under every profile. For player k define

- ρ_min := inf_{y∈V} r_k(y, σ(y));
- ρ_max := sup_{y∈V} r_k(y, σ(y));
- ρ_R := sup_{y∉V, a∈D(y)} r_k(y, a);
- p := K(x, b, σ^{−k}(x); V^c).

Then (ii) holds for a destructive b at x ∈ V whenever

    Gain_k(x,b) ≤ (β/(1−β)) · ( ρ_min − (1−p)·ρ_max − p·ρ_R ).

*Infima and suprema are needed, not minima and maxima.* Codex built a
continuous model with a measurable σ whose safe reward range is (0,1), with
no minimum or maximum. *Absorption is needed.* If ruin returns to safety with
probability ε = 1/100, the bound's expression equals 1 while the deviation is
profitable by 1/101.

**(E4) The two routes, with globally defined rules. PROVED. [EB-5]** Let
D′ = Π_k D′^k be nonempty and measurable **on all of X**, with D′(x) ⊆ D_V(x)
for x ∈ V. Use the same rewards and kernel everywhere. Let σ be an
equilibrium of this globally defined D′-game, from every state.

- **Incentive route.** If Q_k(x,b) ≤ v_k^σ(x) for every k, **every x ∈ X**
  and every b ∈ D^k(x) ∖ D′^k(x), then σ is a full-game equilibrium and it
  preserves. (E3 is one way to verify the destructive part at x ∈ V.)
- **Admission route.** If only D′ is admitted, σ preserves by (E1), whatever
  the rewards.
- **(iii) cannot be dropped.** At an unsafe absorbing state, a prescribed
  action paying 0 in D′ against an excluded action paying 1 fails the
  full-game test, even though every safe-state check passes (Codex mutation
  B6).
- One optional extension sets D′^k = D^k outside V.

**(E5) Product sub-rules exist. PROVED.** If V ≠ ∅, a Borel selector of D_V on
V gives a product rule of singletons inside D_V. What can fail is richness.
This sharpens U4 §12's "not interchangeable". It does not say that joint and
product restrictions are equivalent.

### Proofs

**(E1).** Theorem V(c⇐), or one-step invariance, applied to σ. For a public
signal, apply it signal by signal.

**(E2): L-B, supplied by Codex.**

- *Necessity.* Play b once, then revert to σ. Measurability holds through a
  singleton patch.
- *Sufficiency.* Integrate (B) against any deviating strategy's conditional
  action law, with the opponents fixed at σ^{−k}. This gives
  E[r_{k,t} + β v_k(X_{t+1}) | history] ≤ v_k(X_t).
- Multiply by β^t, sum over t < n, and telescope:
  E[Σ_{t<n} β^t r_{k,t}] + β^n E[v_k(X_n)] ≤ v_k(x).
- Because |v_k| ≤ M/(1−β), the remainder tends to 0.
- The public-signal form integrates (B-public) over the current signal and
  uses the pre-signal value. This also covers signal-dependent deviations.

*READ locators (by Codex):*

- He–Sun, arXiv:1311.1562v3, §2, pp. 10–11, equations (1)–(2). Its
  normalisation is (1−β)r, and its transition assumptions are stronger than
  Setting G's.
- He–Sun §6, pp. 21–22, on the public-signal extension.
- Börgers, *Game Theory*, Proposition 11, p. 66, for the deterministic
  one-shot statement.

L-B itself needs no compactness or continuity to verify a given measurable
profile.

**(E3).**

- σ stays in V, so ρ_min/(1−β) ≤ v_k^σ ≤ ρ_max/(1−β) on V.
- Exact absorption gives v_k^σ ≤ ρ_R/(1−β) on V^c.
- Integrate against the deviation's mixed successor law. The supremum ρ_R
  over all profiles bounds mixed rewards by linearity.
- Subtract. ∎

**(E4).**

- Deviations inside D′ are unprofitable, because σ is a D′-equilibrium.
- Deviations outside D′ are unprofitable by hypothesis, at every state.
- So L-B gives the full-game conclusion. ∎

**(E5).** Kuratowski–Ryll-Nardzewski on the closed graph G_V. ∎

## 3. Worked case: destroy-now for two players

- State 0 is safe and state 1 is ruin, absorbing with payoff 0.
- (wait, wait) pays each player 1.
- Any destroy action leads to ruin and pays the destroyer R once.
- β = ½, so the keeping value is 2.

**(E2)** gives: Gain = R − 1 and β·Loss = 1, so (wait, wait) is a full-game
equilibrium **iff R ≤ 2**.

**[EB-7] (E3) yields the same threshold here.** ρ_min = ρ_max = 1, ρ_R = 0 and
p = 1, so the right side is 1 and E3's premise is R − 1 ≤ 1. The checker
confirms R ∈ {1, 3/2, 2} pass and R ∈ {5/2, 3} fail. *(v1 said E3 stopped at
R ≤ 1. That was an arithmetic slip.)* In other models E3's reward bounds can
be conservative.

For R > 2, the admission route still preserves: (wait, wait) is the unique
admitted profile.

## 4. Relation to the book **[EB-8]**

**The primary statement** is the per-player Bellman inequality (B), for
unilateral deviations followed by σ.

**The book's comparison** is (p_E − p_C)L > G_E − G_C. It appears in the
Abstract (HRE label **S-6**, text lines 271–273) and in the chapter-1
technical lead (**S-11**, lines 475–480). §1.1 (lines 493–513) gives a
discounted path objective, compared strictly against a rival-policy
supremum.

**An exact special case.** Suppose v_k^σ = c on V and d on V^c, the baseline
stays in V, and the deviation exits with probability p. Then
β·Loss = β·p·(c − d). Set p_C = 0, p_E = p, L = β(c − d) and
G_E − G_C = Gain. (E2)(ii) is then the **weak** form of the book's
inequality, and a strict inequality gives strict preference.

**Outside that special case the relation is an analogy in Bellman
accounting, not an identity.** E2 allows indifference; Loss is a whole change
of distribution, not a single failure probability times a common L; and the
book's rival class is path policies, not unilateral deviations from a fixed
σ.

**The two routes** correspond to the book's "task-based margins" and
"legitimate action restriction" (S-4; §11.34). This is a correspondence, not
an identity.

## 5. Finite witnesses **[EB-9]**

`work/check_gate_b_theorem_e.py` (v1.1) uses exact rationals and stdlib
only. Its scope is **one pure stationary σ per game**: the first viable pure
joint action on V, and a fixed pure profile outside V. Only pure one-step
deviations are tested.

| Group | What it checks | Result |
| --- | --- | --- |
| RANDOM | 400 random and 400 structured games; 756 have V ≠ ∅ | E1 failures 0. Mismatches between the one-step test and its partition 0 (a *consistency check of the partition*, not a verification of L-B). Margin-form disagreements 0. E3 premise held in 2,012 cases, with 0 implication failures. |
| ROUTES | The destroy-now game | Exact threshold R ≤ 2. E3's premise holds exactly for R ≤ 2. |

Three probes must all FAIL_AS_REQUIRED, and they do. The third is relabelled
"is a full-game equilibrium", not "survives". **[EB-9]**

Mixed and public-signal profiles are covered analytically by L-B. They were
tested by Codex's independent mutations B1–B6 (in its review), not by this
script. The reviewed v1 checker is preserved byte-exact as
`work/check_gate_b_theorem_e-v1.py` (`4aafb76a…`).

## 6. Review disposition (Codex, Part B ACCEPT-WITH-REPAIRS)

| Finding | Verdict | v1.1 change |
| --- | --- | --- |
| EB-1: the one-shot locator | REVISE | L-B inserted, with READ locators |
| EB-2: mixed σ and joint support | PASS | measurability made explicit |
| EB-3: public-signal quantifiers | REVISE | the per-signal test (B-public), with the averaging witness |
| EB-4: E3 extrema and absorption | REVISE | infima and suprema; exact absorption retained, with the reason |
| EB-5: E4 domain | PASS (clarify) | D′ global; (iii) retained, with the mutation B6 witness |
| EB-6: E5 | PASS | none |
| EB-7: the E3 range | REVISE | E3 gives R ≤ 2 here |
| EB-8: the relation to the HRE | REVISE | Bellman inequality first; exact special case; locators S-6 and S-11; weak vs strict |
| EB-9: checker scope | REVISE | scope stated; probe relabelled |

*These repairs follow Codex's review as pinned before the bank was sealed.
Re-check against the sealed bank when it is available.*
