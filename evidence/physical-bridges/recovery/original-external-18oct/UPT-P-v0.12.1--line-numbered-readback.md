# UPT-P v0.12.1: the Universal Protection Theorem, in protection form (assembled; design for tolerance; closed-form island condition)

**v0.12.1 = v0.12 (preserved) plus Theorem CH, the closed-form Chernoff
island condition (`CHERNOFF-ISLAND.md`).** The locality bonus is
**retracted**: locality bounds harm per failure (q = 1/P), not capacity
needed. The island figures are replaced by CH's rigorous ones.

**v0.12 = v0.11.1 (preserved) plus conclusion (p).**

- **Island holding:** pooling (SR11-11); births not packets (SR11-12);
  births scaling with population (SR11-13).
- **μ is a parameter.**
- **B4:** telemetry with a no-false-safe guarantee.
- **B6:** shirking detection, the Wald information floor, and the
  deterrence/ender tension, resolved by sizing.
- **The locality bonus (as measured in v0.12; retracted in v0.12.1, see CH).**

The sources are `B4-B6-MU.md`, `work/check_b4b6.py`,
`work/check_shirk_sizing.py`, `work/check_load.py` and
`SELF-REVIEW-v0.11.md`.

**v0.11.1 = v0.11 (preserved) plus repairs SR11-1 to SR11-9
(`SELF-REVIEW-v0.11.md`, `work/check_sr11.py`).**

- **The holding-load margin (SR11-1, as corrected):** with ongoing pure-ender
  arrivals, the island requirement is **about 60 hosts**. The 40-host figure
  covers a single ender only, and the earlier 97 was an overcount. **Pool,
  don't partition (SR11-11).**
- **κ* corrected** to 0.60 under full exclusion. **Full exclusion
  manufactures enders (SR11-10), so v0.11.1 uses *patient* exclusion: κ* =
  0.297.**
- **Theorem G in two forms.**

**v0.11 = v0.10 (preserved) plus conclusion (o): Theorem MN, the narrow place
moves to T, and the residual seams R-1 to R-9 (`RESIDUALS-AND-MN.md`,
`work/check_residuals.py`).**

**v0.10 = v0.9 (preserved) plus conclusion (n), the C-boundaries made tight
and the B-bridge made measurable (`BOUNDARIES-AND-BRIDGE.md`,
`work/check_bc.py`).**

**v0.9 = v0.8 (preserved) plus conclusion (m), resolutions of the sealed known
seams (`KS-RESOLUTION.md`, `work/check_ks.py`).** It also adds a binding
notation table (§N), the hazard-adjusted patience premise (P4b′), a witness
world with **no exogenous growth**, pooling sustained by exclusion (so
lexicographic keepers are no longer load-bearing), and checked citations.

## §N. Notation (binding on every file in this bank)

| Symbol | Meaning | Not to be confused with |
| --- | --- | --- |
| **ζ** | a mind's continuous **discount rate** (D1, P4b; ζ* = 2/25 in the book's instance). *Earlier files write ρ.* | ρ |
| **ρ, ρ(t), ρ_S** | **margin**: distance inside S; the largest sustainable margin at t; the inradius of S | ζ |
| **β** | discount factor per date, β = e^{−ζ} | — |
| **φ, φ_t** | **holding-failure probability** (Theorem Φ) | χ |
| **χ_t** | **conversion rate** of stock into signal or margin (H4, TW3). *Earlier files write φ_t.* | φ |
| **ε** | a keeper's **execution-failure probability** (NS, MS, NP) | ε_Θ |
| **ε_Θ** | **per-step noise exit** in Θ2 (P2, Gate C-∞) | ε |
| **f, g** | the margin-to-hazard upper and lower bounds (Theorem M, H1) | — |
| **κ** | pooling cost | κ_r (rescue cost) |

**The true relations between these quantities are lemmas, not shared symbols**
(m1, m3). Sharing a symbol would assert the quantities are equal, and they
are not.

**v0.8 = v0.7 (preserved) plus conclusion (l), seams A1–A14 (`SEAMS-A.md`,
`work/check_seams_A.py`).**

- **Joint satisfiability:** one witness world meets every premise at once.
- **Mixing** for the shortfall event.
- **Unequal keepers**; twilight deterrence.
- **Flow-funded adversaries; unequal upkeep** (a strengthening); stochastic
  capacity; rescue cost; imperfect detection.
- **Time-varying parameters; races; spatial reach** (the book's fourth power,
  bridged to NP); risky funding and heavy tails.
- **The lever loop.**

The DD and Φ3 illustrations are corrected to the β consistent with (P4b).

**v0.7 = v0.6 (preserved) plus conclusion (k), the narrow place (Theorem NP,
`NARROW-PLACE.md`, `work/check_narrow_place.py`).** The premise "enough
protection-first capacity in the narrow place" is now exact and sharp:
C·(1 − ε) > c·(K_E(0) + a·S_max) + A, per island.

**v0.6 = v0.5.2 (preserved) plus conclusions (g)–(j) and premise (IS).** They
come from five candidate files:

- (g) deterrence by physics, Theorem DD (`DETERRENCE.md`);
- (h) the holding-failure law, Theorem Φ, with splitting MS and the growth
  join J1 (`PHI.md`, `PHI-JOINS.md`, `SEAMS-4.md`);
- (i) diversity, space and islands: J2, J3 and IS (`PHI-JOINS.md`,
  `SEAMS-4.md`);
- (j) ghosts, Theorem G (`GHOSTS.md`).

§0 is strengthened by DD and G, and §8 is updated. Earlier versions are
preserved byte for byte.

**v0.5.2 = v0.5.1 plus conclusion (f), the twilight (TW0–TW3,
`TWILIGHT.md`, `work/check_twilight.py`).**

18 October 2026, Pacific/Auckland. **Author-side assembly by Claude (Opus 5.5),
team blue.** It has had author and integrator checks only. **No non-author
has read anything since v0.2** (ruling 19). It is not self-accepted.

**v0.5.1 = v0.5 (`774ec34a…`, preserved) plus repairs SR5-1 to SR5-11**, from
`SELF-REVIEW-v0.5.md`. The exact witnesses are in
`work/check_selfreview_v05.py`. Every repaired passage is marked
**[SR5-n]**.

**What v0.5 assembles into one document.** v0.4 (`0552e1dc…`) plus five
candidate files:

- the Margin Law, Theorem M, with Proposition CW (`MARGIN-LAW.md`);
- the two-sided survival law H1 (`HORIZON.md`, used as a tool);
- Theorem DOOM, Corollary U and Theorem K (`BRIDGES-TO-T.md`).

Earlier versions are preserved byte for byte.

**New in v0.5:**

- premise (P2′) (the margin fits);
- premise (MR) (mutual rescue);
- conclusions (d) (doom and uniqueness) and (e) (keepers inherit);
- §8, the **hardening map**: what would earn a stronger statement.

## 0. The statement, as earned today

The Whole Argument (HRE text, line 11823) gives the target:

> *"Every mind either has a reason of its own to keep the living free, or is
> held by minds that do, and the arrangement lasts."*

**UPT-P (protection form).** Take a world whose physics allows care until its
natural end T_end, with margins that fit (P1, P2, P2′). Suppose the keepers
who put protection first hold enough capacity, with stated margins for
noise, failure and sabotage (P4c, MR). Then:

1. **every mind keeps for its own reasons, except pure enders** (minds that
   value ending for its own sake) **and minds whose gain exceeds g\*(φ), and
   those are held** ((g), DD; (b)). With redundant holding, g* is
   astronomical, so **holding works by deterrence, almost never by
   restraint**;
2. **the protected histories continue, with probability as close to 1 as we
   choose, through T\*_η**, the last date at which the margins fit, at
   margins that grow at most logarithmically in the horizon (a). **Keeping
   dominates through T_end.** Because margins grow only like √(log T), T*_η
   covers all but the final twilight **[SR5-1]**;
3. **ending early dooms whoever tries it**: the attempt is held, or it
   dissipates and stands alone (d);
4. **the end is the unique point at which a transition makes sense**: every
   earlier date is strictly dominated by keeping and sending copies without
   ending, for any channel, and only T_end is undominated (d2) **[SR5-5]**;
5. **keepers inherit, and enders are ghosts.** Enders can exist, but they
   cannot persist, accumulate or win, and **their share of mind-time has
   density zero**, falling like (ln T)/T ((e), (j));
6. **the whole holding budget is the narrow place, and the narrow place has a
   sharp threshold.** The condition is r = C(1−ε)/H > 1, which says expected
   protection-first capacity exceeds the largest threat plus headroom (k). If
   r > 1, splitting drives the probability that holding fails to 0. If r < 1,
   splitting drives it to 1, even when C > H. Splitting fixed capacity
   among many independent keepers drives the probability that holding fails
   down like a law of large numbers (MS). Growing keeper numbers make the
   holding budget converge over any horizon (J1). **Each causally bound island
   meets these premises on its own** ((h), (i), IS).
7. **the premise set is jointly satisfiable, even with no exogenous growth.**
   A 40-host island whose keepers multiply only by splitting meets every
   premise, including hazard-adjusted patience, to T_end = 10¹⁰⁰. That gives
   P(protected) ≥ 0.99996 across two islands ((m2); the earlier growth
   witness is (l1)). Every closable mathematical seam is addressed (l).
   What remains is facts about a world (BRIDGE), and boundaries proved
   permanent.
8. **the theorem attains its own boundaries.** Its margins are optimal: within
   0.8% of the minimum any scheme could need at 10¹⁰⁰ dates. Restraint is
   spent only on pure enders, only in the narrow place. The twilight lapse is
   a vanishing fraction. And the end comes from physics, not from noise (n).
9. **the narrow place moves to T.** Once a world's capacity clears the worst
   plausible allied threat with a coalition margin (SR11-1), the holding
   ratio stays above 1 before the twilight. With the living fading no slower than capacity,
   it never falls in the twilight either. **The only bottleneck left is the
   end**, the one date where care cannot be paid and the only undominated
   transition date. With keepers first, the start was never narrow (o).
10. **protection is designed for tolerance.** Small faults cannot be caught
    fast: Wald's information floor is about 189 observations for a 10%
    shirker. They cannot be punished hard either, because full exclusion
    manufactures enders. So they are **absorbed by margin**: universal 10%
    shirking costs about 35% more capacity (43 → 58 hosts, by CH). The theorem
    holds **for every μ**,
    given the island its μ requires (p).

**"Universal" means three things here:**

- **scope:** every protected being;
- **minds:** every mind, reached or held;
- **time:** until the universe can no longer sustain care.

**It is not unconditional.** PB0, Pillar 2 and Θ0 prove that unconditional
preservation is impossible. §5 shows that no premise can simply be dropped.
**§8 lists every qualifier in the statement above, with the result that
would retire it.**

## 1. Ingredients and status

| Ingredient | Supplies | Status |
| --- | --- | --- |
| Theorem V, V-B | feasibility and admission; Borel extension | Codex-reviewed; GLM-adopted (U4). V-B: Codex-authored, Claude-reviewed |
| L-C, L-B | finite-horizon admission; one-shot verification | Codex-supplied |
| Theorem E v1.1 | keeping margins | Codex ACCEPT-WITH-REPAIRS; repairs applied |
| Θ0, Θ1, Θ2, TS | thermal margin, no-go, survival law | Codex-reviewed; GLM-adopted |
| Coverage bound | P(covered harm) ≤ Σαᵢqᵢ | The Whole Argument, text line 11521 |
| Prop. 1.11a | enders are transients | HRE S-19 |
| L-B_T; Gate D; EG, EG-U, D2c, KA | v0.2–v0.3 | drafter-checked; unreviewed |
| Hazard rule, Lemma P, KA′, LC | v0.3.1 | author self-review; unreviewed |
| NS, DS, AI, P-Σ, RM, AN | v0.4 | drafter-checked; unreviewed |
| Gate C-∞ | funding regimes; annuity ≈ perpetuity; cosmic margin | banked (`11489df4…`); unreviewed |
| **Theorem M, Prop. CW, H1** | margin classes; cross-world insurance; survival sandwich | **new here**; drafter-checked; unreviewed |
| **DOOM, Corollary U, Theorem K** | doom of early ending; uniqueness of the end; keepers inherit | **new here**; drafter-checked; unreviewed |
| **DD, Φ, MS, J1–J3, IS, EDC, G** | deterrence; holding-failure law; splitting; growth; diversity selection; spatial margin; islands; ghosts | **new in v0.6**; drafter-checked; unreviewed |

## 2. Lemma L-B_T (finite-horizon one-shot verification). PROVED

For a time-dependent measurable Markov profile σ on dates 0, …, T−1, σ is an
equilibrium against every feasible history-dependent randomised unilateral
deviation **iff**, for all k, t, x and b,

    r_k(x, b, σ_t^{−k}(x)) + β ∫ v_{k,t+1} dK(x, b, σ_t^{−k}(x)) ≤ v_{k,t}(x).    (B_T)

*Proof:* one-shot deviation for necessity; telescoping for sufficiency.

## 3. Theorem UPT-P

### Setting U

- **World.** A discounted stochastic world (Setting V, or T). S is the
  continuation **and direction** of the protected histories. A replacement or
  copy is not in S (rulings 2 and 3).
- **Minds.** Countably many. Capacity follows K̇ = a·x − u·K, with a common
  upkeep rate u > 0 (1.11a).
- **Physical noise.** σ in d dimensions (Θ2), or bounded displacement (Θ1).
  The full-support lower bound g > 0 is Θ0.
- **Execution noise.** An intended pool fails with probability ε > 0, and an
  intended no-pool becomes a pool with probability δ > 0. Also:
  - ε + δ < 1;
  - the noise is independent across minds and dates;
  - adversaries do not control it.
- **Lexicographic keepers L** hold the declared good first. Their beliefs
  about adversaries have full support. **Adversaries D** may sabotage, with
  total capacity A(t).

### Definitions

- **(D-T\*) The natural end.** T_end is the last date at which care is
  payable. At T_end, no policy has positive continuation probability for S.
- **(D-J) Transition.** Any act that ends a protected history before T_end,
  directly or by consuming its upkeep. A departure that ends nothing is not
  a J.
- **(D-R) Rival.** Not producible at t_e without ending. A rival transition
  is either resource-rival or intrinsically ending.
- **(D-H) Held.** Admitted actions are safe and compose. A held ender gains
  no new hosts.
- **(D-M) Margin and channel.** In each threat channel k (physical, funding,
  holding, sabotage), P(failure at t | history) ≤ f_k(m_k) (Theorem M).

### Premises

- **(P1) Viability and funding.** The noise-free core starts in C₀ (L-C).
  Care is funded through T_end by a regime of Gate C-∞:
  - flow income y ≥ 4, which gives the horizon-free Lundberg bound under
    random income;
  - an endowment at the perpetuity price 4(1+r)/r;
  - under bounded uncertain returns, the worst-case price 4(1+r_min)/r_min.
- **(P2) Physical margin.** Every executed action aims at least
  m ≥ σ·√(2d·ln(2dT_end/η)) inside S.
- **(P2′) The margin fits, date by date [SR5-1].** Let ρ(t) be the largest
  margin physics allows at t. It shrinks toward T_end. T*_η is the last date
  with Σ_{t<T*_η} f(ρ(t)) ≤ η. The level guarantee holds through T*_η. On
  (T*_η, T_end], the twilight, the bounds of H1 apply, and keeping still
  dominates (d2).
  - **Two-sided [SR5-2].** Survival at level 1 − η is *possible if*
    Σ f(ρ(t)) ≤ η. It is *impossible for every policy if*
    Π(1 − g(ρ(t))) < 1 − η. The region between is not decided by the bounds.
- **(P3) Coverage, date by date.** Each mind is reached or held, except on
  C_iᶜ, with αᵢ = P(C_iᶜ), harm given failure at most qᵢ, and Σαᵢqᵢ < ∞.
  Joint safety is supplied by E5 in product worlds and is part of (P3)
  otherwise. For held minds, αᵢ is bounded by (P4c)'s holding budget.
- **(P4) Keepers win, and keepers hold.**
  - **(P4a)** Enders have no sustained flow. A held ender gains no new
    hosts.
  - **(P4b)** S < y/ζ (D1).
  - **(P4b′) Hazard-adjusted patience (v0.9, m1).** The *effective* discount
    rate ζ + λ, with λ = −ln(1 − hazard per date), satisfies
    ζ + λ < r(1 − x*/K). A keeper alone at a thin margin fails this (0.744
    at margin 1; 0.116 at margin 4). **Rescue groups satisfy it** (0.0513 with
    49 partners). Patience depends on survival, so (MR) also serves (P4b).
  - **(P4c) Lexicographic capacity with margins. No selection premise.**
    - **Sabotage margin, with seizure headroom [SR5-3]:**
      Σ_{i∈L} K_i(0) ≥ c·(K_E(0) + a·S_max) + A(0). Here S_max is the
      largest host stock one successful seizure can take, so holding resumes
      after any single success. Either adversaries are held, so that A
      decays at rate ≥ u, or the margin is assumed at every date.
    - **Holding budget:** Σ_t φ_t ≤ η_h.
    - **Fallback:** on dates without the joint margin, selection among
      finite-trade-off pooling equilibria is a premise (D2).
  - **(P4d)** Covered by (P4c) where (P4c) holds through T_end. Otherwise,
    holding is available on the dates where a believed hazard exceeds h*(g).
- **(MR) Mutual rescue.** A keeper that fails at t is restored if some
  partner in its rescue group does not fail at t **and has capacity left**.
  Failures are independent within a date. (Rescue is individually rational
  for willing keepers, by CW2.) The capacity drain of rescuing is not
  modelled **[SR5-11]**.
- **(IS) Island self-sufficiency (v0.6; SEAMS-4 S4).** After cosmological
  horizon fragmentation, protection is per causally bound island. Each
  island must satisfy (P4c), (MR), CW and MIX *within* itself. Global
  protection is ≥ 1 − Σ over islands of the island budgets, and cross-world
  pacts are capped at island scale. *This is a weakening the theorem
  carries:* more islands raise the probability that *some* island fails.
- **(EDC) Exponential decay of correlations (v0.6; J3), a physical premise.**
  α(d) ≤ C·e^{−d/ξ}. It is used only where MIX's floor is converted into a
  spacing.
- **(PK) Pacts are among keepers [SR5-9].** A mind that turns ender leaves
  every pact it was in. Its world is no longer insured by the others.

### Conclusions

**(a) Protection to the horizon, priced by margins.**

    P( every protected history continues, with its direction, through T_end ) ≥ 1 − η_phys − η_fund − η_hold − η_sab − Σ (other αᵢqᵢ).

This holds for dates through T*_η **[SR5-1]**. The channel budgets compose by
Theorem M (M4), with no independence assumed between channels. For held
minds, coverage failure *is* holding failure, so it is counted once, in
η_hold, and not again in αᵢqᵢ **[SR5-8]**. Each budget is bought by a
margin:

| Channel | Margin | For T = 10¹⁰⁰, η = 10⁻⁶ | Growth |
| --- | --- | --- | --- |
| physical (Θ2) | m ≥ σ√(2d·ln(2dT/η)) | 22.1σ (1-D), 38.4σ (3-D) | √(log T) |
| funding, flow (Lundberg) | balance e with e^{−Re} ≤ η | 26 in the instance | none |
| holding (RM) | n ≥ ln(T/η)/ln(1/ε) able keepers | 106 at ε = 10%; 53 at 1% | log T |
| sabotage (AI) | Σ_L K ≥ c·K_E + A | stationary | none |

**(b) Holding is coordination-free, robust and persistent.**

- **(b1) Dominance (NS, DS).** Each lexicographic keeper pivotal in some
  configuration strictly prefers to pool, whatever others intend.
- **(b2) Immunity (AI).** Against every adversary strategy, pure, mixed or
  coordinated, P(held at t) ≥ (1−ε)^{|U|}.
- **(b3) Persistence (P-Σ).** On held stretches, Σ_L K_i/(c·K_E + A) is
  non-decreasing.
  - **Exponential form** (integrator's quotient-rule form, verified). With
    keeper flow y > 0 and a held ender (zero inflow), R = K_K/K_E satisfies
    dR/dt = a·y/K_E > 0. So

        R(t) − R(0) = (a·y/(u·K_E(0)))·(e^{ut} − 1).

    **The keepers' relative advantage grows exponentially, at the upkeep
    rate.** This holds on held stretches. As flows fade in the twilight, it
    weakens to dR/dt ≥ 0.
- **(b4) Redundancy (RM).** φ_t ≤ εⁿ with n independent able keepers.
- **(b4′) Mixing replaces exact independence (MIX).** Suppose that for any
  region and **any union of other regions** each at separation ≥ d from it
  **[SR5-7]**, events
  satisfy |P(A∩B) − P(A)P(B)| ≤ α(d). *Pairwise mixing is not enough:* take
  three fair bits with the third the XOR of the first two. The events "each
  is 0" are pairwise independent, yet jointly they have probability
  1/4 > 1/8. Then

      P(all n fail) ≤ εⁿ + (n−1)·α(d).

  *Proof.* Induct on n, with B = the joint failure of the other n−1:
  P(A₁ ∩ B) ≤ ε·(ε^{n−1} + (n−2)α) + α ≤ εⁿ + (n−1)α. ∎

  Redundancy works down to the floor (n−1)α(d). Spatial separation, causal
  or thermal, drives that floor toward 0. Common-cause shocks are the part
  that does not mix, and they are the margin-insensitive class (M3).

  *Integrator corrections, kept.* Zero noise correlation does not imply
  independent failures. The bound "εⁿ + Σ ρᵢⱼ ε²" does not follow. The
  mixing bound above is the valid form. Proof given; not machine-checked.
- **(b5) Across worlds (CW).**
  - Same-world redundancy has a floor s.
  - A k-world pact lowers a world's unheld probability to s^k, with net gain
    exactly (w − κ)(s − s^k) for each world.
  - Over T dates, survival is (1−s)^T alone against (1 − s^k)^T in the
    pact: 2.2 × 10⁻⁴⁴ against 0.990 at s = 1/100, k = 3, T = 10⁴.

**(c) No early transition** (v0.3.1–v0.4).

- **(c1)** Non-rival transitions are dominated outright (KA′).
- **(c2)** Rival transitions are ending:
  - **value:** they are dominated before T_end and tie only at T_end;
  - **game theory:** the hazard rule, h_t ≤ h*(g) = 1 − (g−1)/(βg), with
    truthful anchoring;
  - **physics (LC):** an ender's lifetime capacity is finite, (K₀ + aS)/u.
- **(c3)** The remainder is held.

**(d) Doom of early ending, and uniqueness of the end.**

- **(d1) DOOM.** A mind attempting J before T_end is held.
  - **Attempts, every date [SR5-4]:** P(J succeeds at some date ≤ T) ≤
    Σ_t φ_t ≤ η_h. This holds even if the mind tries again every date. RM
    sizes n so that T·εⁿ ≤ η_h.
  - **After a success [SR5-3]:** seizure headroom restores holding at the
    next date. The ender then gains no new hosts, its capacity decays to 0,
    and (with its margin bounded by its capacity) H1 gives its own survival
    ≤ Π(1 − g(ρ_M)) → 0.
  - **Insurance [SR5-9]:** by (PK), it forfeits cross-world insurance.
- **(d2) Corollary U, repaired through KA′ [SR5-5].** Compare each
  transition date t with **keep, and send copies without ending whenever a
  channel allows**. That policy carries max_{s≤T_end} min(I(s), C(s)), which
  is at least what any transition carries, *for any channel C(t), including
  one that dies at T_end*. It also keeps continuation c(t) > 0 before T_end.
  - So **every t < T_end is strictly dominated.**
  - **T_end is the only transition date not dominated**, where it ties with
    keeping, since c(T_end) = 0.
  - *Witness UCHAN:* naive carried-first ranking of transition dates picks
    t = 2 when the channel dies at the end. The repaired comparison leaves
    only T_end undominated.

**(e) Keepers inherit; enders are ghosts (Theorem K).**

- **(e1)** Under (MR), a keeper's survival is ≥ Π(1 − f(ρ_K)ⁿ). That makes
  it **margin-sensitive**: in the book's instance, 0.448 alone, 0.917 at
  n = 2, 0.996 at n = 4. **n = 33 gives 1 − 10⁻⁶ over 10¹⁰⁰ dates**, and the
  narrow place uses 1.4 × 10⁻¹⁴ of that budget.
- **(e2)** An ender's margin reaches 0 in finite time, and **rescue needs
  capacity**. So every ender coalition, of any size, is
  **margin-insensitive**: survival ≤ Π(1 − g(0)) → 0. In the instance,
  log₁₀ survival over 3000 dates is about −895 for n = 1, 2, 6 and 30.
  - **Without the instance's integer rounding.** A continuous margin
    m_E(t) = m_E(0)e^{−ut} **never reaches 0 in finite time**. (The
    integrator's draft said it does, and that step is false.) But it falls
    below any δ by t_δ = ln(m_E(0)/δ)/u.
  - Suppose rescue needs margin ≥ δ, and the hazard satisfies
    g_δ := min_{m≤δ} g(m) > 0 (true when g is continuous with g(0) > 0).
    Then from t_δ on, every ender coalition dies with probability ≥ g_δ per
    date, and survival ≤ (1 − g_δ)^{t−t_δ} → 0.
  - **K2 therefore does not depend on rounding.**
- **(e3) [SR5-6]** Expected enders alive ≤ λ_E·L_E, which is bounded
  (Little's law), while keepers alive ≥ λ_K·t·(1 − η) through T_end. So
  **through T_end the ender share falls like 1/t**: ≤ 0.86% at t = 3000 in
  the instance; 2.5% at t = 10³ and 2.6 × 10⁻⁵ at t = 10⁶ under the
  witness's rates.
  - In infinite time, keeper lifetimes are also finite, so the share tends to
    the tiny positive constant λ_E·L_E/(λ_E·L_E + λ_K·L_K), not to 0. That
    is beyond the theorem's horizon.

**(f) The twilight, (T*_η, T_end] (TW0–TW3).**

- **(f0) The end arrives.** Where the sustainable margin is 0 on the last k
  dates, every policy survives them with probability ≤ (1 − g(0))^k. The level
  guarantee ending at T*_η is physics. That is what "natural end" means.
- **(f1) Pathwise dominance.** Couple the two policies on the same noise
  path. Keeping, and sending the same message through the same channel draw,
  carries at least as much and continues at least as long as any non-rival
  jump, **on every sample path, under every noise law**.
  - *Checks:* Cauchy (binding and wide channels) and Gaussian noise: 0
    violations in 16,629, 16,629 and 48,382 coupled cases.
  - *Positive control:* a rival jump with a wide channel gives 13,384
    violations, so the test can fail.
- **(f2) Holding persists.** Once flows fade, every capacity decays at the
  common rate u, so every ratio is constant. The holding margin at the
  twilight's start, with headroom, lasts to T_end.
- **(f3) The rival seam.** A twilight jump that consumes the living to send
  more is ending, so:
  - it is held, by (f2), NS/DS and AI;
  - it is refused by every mind that ranks continuation first (the archive is
    secondary; *The Proportion*; D60);
  - its extra yield G(t) ≤ χ_t·a·S(t) tends to 0 at the end (χ = conversion rate, §N);
  - with a binding channel, liquidation buys exactly nothing (0 in 16,629
    cases).

**(g) Deterrence by physics (Theorem DD).** A finite-trade-off mind keeps
forever iff g ≤ g*(φ), where

    g*(φ) = 1 + β·p_X·V_K + β·V_K·(p_K − p_X)/φ,   V_K = 1/(1 − β·p_K).

This is exact, with retries allowed and every advantage given to the
attacker. The **premium** β·V_K·(p_K − p_X)/φ is the cost of exposing oneself
(rescued against alone), divided by the probability that holding fails.

- *Checks:* φ = 10⁻⁶ gives g* = 4395.5. φ = 10⁻²⁰ gives g* ≈ 4.4 × 10¹⁷.
- *Consistency:* φ = 1 recovers the hazard rule.
- *Positive control:* with no exposure cost, the premium vanishes.

**(h) The holding-failure law (Theorem Φ), splitting (MS) and growth (J1).**

- **(h1) Exact form.** φ_t = P(Σ Bᵢ·Kᵢ(t) < thr_t), a binomial or
  Poisson-binomial tail. *Check:* equal to brute force.
- **(h2) Non-increasing on held stretches**, by coupling on the execution
  pattern. It is front-loaded into the narrow place. The floor is
  φ_∞ ≈ n·ε^{n−1}, not εⁿ, because seizure headroom exceeds one keeper's
  ceiling.
- **(h3) Two jobs.**
  - Deterrence needs only φ ≤ φ*(g), which is **horizon-free**: 13 keepers
    deter every g ≤ 10⁸ for any horizon.
  - Restraint of pure enders needs Σφ ≤ η_h (109 keepers over 10¹⁰⁰ dates at
    fixed n).
- **(h4) MS, many small keepers.** With total capacity C and C·(1−ε) > H,
  splitting into n independent keepers gives φ(n) ≤ exp(−2n·(1 − ε − H/C)²).
  *Check:* fixed C = 960 takes φ from 1.8 × 10⁻¹⁸ at n = 20 to
  **3.8 × 10⁻²⁰⁵ at n = 240**. *Control:* with C(1−ε) < H, φ tends toward 1.
  Lexicographic keepers prefer to split, down to the rescue-capacity limit.
- **(h5) J1, growth.** If keeper numbers grow (by MS, or by new flows such as
  the guardian transition), **Σ_t φ_t converges**. The infinite-horizon
  budget is 4.157 × 10⁻⁴ in the instance, almost all of it at t = 0. Later
  ender cohorts' costs also converge (SEAMS-4, COHORT).

**(i) Diversity, space and islands.**

- **(i1) Covering diversity (J2a)** replaces the common-cause floor s with a
  binomial tail: 4.96 × 10⁻⁸ against 10⁻².
- **(i2) Selection (J2b).** Monoculture groups are margin-insensitive. Through
  10⁴ dates they survive ≤ 2.2 × 10⁻⁴⁴, against ≥ 0.9995 for covering-diverse
  groups. **Diversity is selected.**
- **(i3) Spatial margin (J3, under EDC).** The spacing needed is
  d ≥ ξ·ln((n−1)·C/η), which is logarithmic.
- **(i4) Islands (IS).** Protection is per island.

**(j) Ghosts (Theorem G).** Enders can exist (PB0 needs that possibility),
but:

- they cannot persist (K2);
- they cannot accumulate (K3);
- they cannot win (DOOM);
- no finite-trade-off mind becomes one (DD).

Their time-averaged share of mind-time is ≤ (a/b)·ln((a + bT)/(a + b))/T → 0.
In the instance that is 4.5 × 10⁻⁷ at T = 10⁹. The share also tends to 0
when pure enders keep arising at any constant rate.

**(k) The narrow place (Theorem NP).** Let r = C(1−ε)/H, with
H = c(K_E + aS_max) + A.

- **(k1) Sharp threshold** under splitting:
  - r > 1: φ → 0 exponentially (Hoeffding);
  - r < 1: φ → 1;
  - r = 1: φ → ½.

  *Checks:* r = 6/5 gives 3.7 × 10⁻¹⁵ at n = 320. r = 19/20 gives 0.999,
  although C > H.
- **(k2) The binding date is the start:** the ender is largest and the
  keepers smallest. It is not the twilight.
- **(k3) Book instance.** The threshold is C > 144.4, and C = 200.
  Splitting into 49 keepers gives φ = 5.4 × 10⁻⁷, against 4.2 × 10⁻⁴ as
  built.
- **(k4) Price.** C = 200, 240 and 284 reach 10⁻⁶, 10⁻¹² and 10⁻²⁰.
- **(k5) Meeting it buys the horizon (with J1), per island (IS).** *It is an
  initial condition. The theory prices it exactly; it cannot make a world
  meet it.*

**(l) Seams A1–A14 (`SEAMS-A.md`).**

- **(l1) Joint witness.** With β = 19/20 (patient, P4b ✓), r = 1.29 (NP ✓),
  a 49-way split with rescue capacity (MS ✓), margin 22.2σ inside 25σ
  (P2′ ✓), Lundberg funding, sabotage 10 with headroom 60, and growth LA′:
  - η_phys = 1.9 × 10⁻⁷;
  - η_fund = 6.3 × 10⁻⁷;
  - **η_hold = 5.7 × 10⁻⁵**, almost all at t = 0;
  - η_rescue = 5.3 × 10⁻¹⁵;
  - g* = 1.67 × 10⁵;
  - **P ≥ 0.99988 over two islands.**

  *Catch:* the earlier illustrative β = 9/10 violated (P4b). With the
  consistent β, deterrence is stronger.
- **(l2) Mixing.** TV(joint, product) ≤ 2(n−1)α. So φ_mix ≤ φ_indep + 2(n−1)α
  for the shortfall event (300 exact laws, 0 violations).
- **(l3) Unequal keepers.** φ ≤ exp(−2(E − H)²/ΣKᵢ²), with
  E = Σ(1 − εᵢ)·Kᵢ. The threshold stays sharp under replication.
- **(l4) Twilight deterrence.** The logistic gain-to-flow ratio is ≤ 12.5. A
  mind keeps at every date with ≥ 2 left. The final date adds ≤ φ.
- **(l5) Flow-funded adversaries** are bounded by their ceiling, so the margin
  at t = 0 holds at every t.
- **(l6) Unequal upkeep.** d ln(Kᵢ/K_E) = (a·y/Kᵢ − uᵢ) + u_E ≥ 0 at or below
  the ceiling. *The common-u premise is dropped.*
- **(l7) Bounded capacity noise.** Deviation ≤ ξ_max/u, so use K − ξ_max/u.
- **(l8) Rescue cost.** The fixed point keeps the margin (c = 18.97,
  margin 4).
- **(l9) Detection q.** g* = 9.5 × 10⁶, 6.2 × 10⁶, 1.7 × 10⁶ and 20 for
  q = 1, ½, 1/10 and 0. **Deterrence needs detection.**
- **(l10) Comparison lemma.** The sup parameters dominate time-varying g_t,
  φ_t and partial exclusion.
- **(l11) Races.** Headroom h gives ≤ C(W, h+1)·φ^{h+1}, which is
  margin-sensitive.
- **(l12) Reach.** The book's keeper count is Poisson(8πν(1−h)v³/λ_K⁴), and
  thinning gives φ = P(Poisson(Λ_K(1−ε)) < k). Halving λ_K takes φ from 0.34
  to 3.5 × 10⁻²⁷. *NS derives the pooling that the book assumes.*
- **(l13) Funding: "flows plus buffer"** never raises ruin, and physical
  cutoffs make heavy tails bounded.
- **(l14) The lever loop.** Diversity makes KA, CW and J2 strict, with the
  computed ties.

**(m) Known seams resolved (`KS-RESOLUTION.md`, `work/check_ks.py`).**

- **(m1) Hazard-adjusted patience (KS-1).** Hazard adds to impatience:
  ζ_eff = ζ + λ. This joins (P2) to (P4b), and gives (P4b′). It is the
  true form of the integrator's "margin–discount duality". It is a
  **relation, not an identity.**
- **(m2) Satisfiable with no exogenous growth (KS-5, KS-13).**
  - **Setting:** a 40-host island (a single ender; **with ongoing pure-ender
    arrivals, about 60 hosts**: SR11-1 corrected, SR11-11); keepers multiply **only by
    splitting**,
    with n(t) = min(120, ⌊C(t)/4⌋); T_end = 10¹⁰⁰.
  - **Budgets:** η_hold = 1.75 × 10⁻⁵ and η_rescue = 4.3 × 10⁻⁹, with tails
    bounded rigorously by monotonicity. Every date is hazard-adjusted
    patient.
  - **Result:** **P ≥ 0.99996 over two islands.**
  - *Island capacity:* a 30-host island (ceiling 1440) fails, and 40 hosts
    (ceiling 1920) pass. The requirement is finite and modest.
- **(m3) Execution is a margin channel (KS-3).** With ε = f(m_exec),
  execution margin improves r directly. ε = 2⁻⁶ gives φ = 3.8 × 10⁻¹⁷,
  against 2.6 × 10⁻⁴ at ε = 2⁻³.
- **(m4) Pooling by exclusion (KS-6), as repaired by SR11-10 to *patient*
  exclusion.** Full exclusion makes excluded keepers impatient (m1). By D1
  they would then end their hosts, so **full exclusion manufactures enders**
  (0.12 per date at k = 3). Exclusion must leave the excluded keeper's
  hazard ≤ 0.0283, so that it stays patient. Then κ* = 0.297 (0.235 at
  hazard 0.02). *The original statement below is superseded:* A finite-trade-off keeper that would
  lose its rescue membership if detected (with probability q) pools whenever
  κ ≤ κ*(q). The values are κ* = 0.70, 0.67 and 0.49 of a date's flow for
  q = 1, ½ and 1/10, and 0 at q = 0.
  - **Pooling becomes a best reply independent of pivotality**, because the
    penalty is private.
  - **So (P4c)'s capacity counts lexicographic keepers *and*
    exclusion-incentivised finite-trade-off keepers.** Lexicographic keepers
    are no longer load-bearing.
- **(m5) To hold is to detect (KS-7).** In the threshold model, an attempt
  fails only on a date when holding succeeds, which means keepers pooled
  against it. The holders act on the attempt, so they observe it. **Under
  H-cap, q = 1 for held attempts.** A9's q < 1 covers only covert attempts
  that fail spontaneously.
- **(m6) Generality of the model (KS-11).**
  - *Hard top needed for sharpness.* If P(hold | capacity c) = h(c), the law
    of large numbers gives φ(n) → 1 − h(C(1−ε)). NP's collapse needs h = 1
    above some H. With a soft ramp, φ → 0.5 (checked).
  - *General capacity laws.* K results need only K̇ ≤ −u(K) < 0 without
    inflow, and a positive keeper equilibrium.
  - *Doom under bounded noise (KS-8).* With margin μ(K) for any continuous μ
    with μ(0) = 0, and noise with a nondegenerate density on a ball of radius
    b > 0, the exit hazard is ≥ g_b > 0 once the margin is below b. So
    DOOM(b) holds under Θ1-type noise too.
- **(m7) Budgeted admission composes (KS-9).** Admission rules that allocate
  shares s_i of the global margin m, with Σ s_i ≤ m, are jointly safe in
  additive-displacement worlds. This gives joint safety beyond E5's product
  worlds. *Control:* safe-alone harvests 3 + 3 > 5 fail.
- **(m8) Intrinsically ending transitions need capacity (KS-12).** Capacity
  above the keeper ceiling requires seizure, and seizure is held (DOOM(a)).
  So physics enters intrinsic transitions **through holding**.
- **(m9) Evidence quality (KS-15 to KS-17).**
  - Citations checked: Kalashnikov–Norberg 2002 (*SPA* 98:211–228),
    Krauss–Starkman 2000 (*ApJ* 531:22–30), Dyson 1979 (*RMP* 51:447–460),
    Gibbons–Hawking 1977 (de Sitter T ≈ 2.7 × 10⁻³⁰ K; local observers see
    2×), and the Lundberg bound.
  - **Clark 1973 (*Science* 181:630–634) is cited as *related* work.** Its
    extinction threshold (discount > 2× maximum reproductive potential, by a
    secondary source) differs from D1's exact operating-point condition.
  - **Correction (chat only, no file):** the aestivation critique is
    Bennett, Hanson & Riedel (2019), not "Bennett, Brin & Lineweaver".
  - Decimal (60-digit) cross-check of the floats.
  - **Rigorous binomial-tail remainders** (≤ 2B(M), ratio ≤ ½).

**Named boundaries, not seams.** KS-10 (pure enders held by definition) and
KS-14 (the final twilight date is held, and adds ≤ φ) are boundary C.

**(n) Boundaries attained; bridge made measurable (`BOUNDARIES-AND-BRIDGE.md`).**

- **(n1) Optimal margins (C1).** m_suff/m_nec = 1.043, 1.008 and 1.001 at
  T = 10¹⁰, 10¹⁰⁰ and 10¹⁰⁰⁰. *Proof:* survival ≤ (1−p)^T, together with the
  Mills-ratio lower bound on Q.
- **(n2) The pure-ender residue (C2).** Holding is necessary exactly for g = ∞
  and for nothing else (DD). Its cost converges, is front-loaded, and is
  > 0 under full support.
- **(n3) The twilight fraction (C3).** It shrinks like m*/ρ_max: 6.6% at
  100σ, 0.6% at 1000σ.
- **(n4) Noise is not the binding end (C4).** At 25σ the noise-limited
  lifetime is about 10¹³⁷ dates, beyond the longest physical T_end
  (about 10¹⁰⁰ years). The end is (D-T*).
- **(n5) The bridge (B1–B6).**
  - B1: flows and T_end are **consistent**. Red dwarfs last 6–10 × 10¹²
    years; stellar flow lasts about 10¹⁴ years; fainter flows last to about
    10¹⁰⁰ years (Adams & Laughlin 1997). Margins of 9.7σ and 22.1σ.
  - B2: EDC is **consistent for local noise**. Regional hazards correlate
    within their range.
  - B3: island capacity is **consistent, given a units mapping**. The Local
    Group (about 2.3 × 10¹² M☉) stays bound.
  - B4: **NP is open and actionable.** Measure C, ε and H. The levers are
    named.
  - B5: **protection-first minds exist (weak form), by instance.** The
    strong form is parked with Corollary Q.
  - B6: shirking-detection in practice is **open**.

**(o) Theorem MN, and the residual seams (`RESIDUALS-AND-MN.md`).**

- **(o1) MN1.** r(t) is non-decreasing before the twilight (witness:
  1.29 → 28.8).
- **(o2) MN2.** In the twilight r is non-decreasing iff s_S ≥ u. *New premise
  (MN2).*
- **(o3) MN3.** Once r > 1, the only bottleneck is T_end (D-T*, U).
- **(o4) MN4.** Initial risk ≤ μλ·t₁. Keepers first give t₁ = 0.
- **(o5) Residuals.**
  - R-1: dimensionless form.
  - R-2: k-strike forgiveness (**κ* = 0.60**, corrected in SR11-2; honest
    exclusion 10⁻³ per date).
  - R-3: bounded noise and concave upkeep, machine-checked.
  - R-4: bounded synergy.
  - **R-5: sweep 20/24, each failure cured by capacity** (90 hosts at
    ε = 1/8; all four verified, SR11-5).
- **(o6) Coalition margin (SR11-1).**
  - Pure enders present at once are about Poisson(m₀), with
    m₀ = μλ·L_E = 2.56 × 10⁻⁵.
  - Allied, j of them threaten j·H_fresh.
  - *First count (overcounted: headroom and sabotage per ender, all fresh,
    allied):* +40.6 at 40 hosts, ≤ −6 at 97.
  - **Corrected load model** (`work/check_load.py`; held from arrival, so no
    alliances; decayed capacities; headroom and sabotage counted once):
    **+8.5 at 40 hosts, −7.7 at 60 hosts.**
  - **Pooling Lemma (SR11-11).** Partitioning is fatal: 60 hosts gives −7.7
    pooled and +47.7 split in two. (A "locality bonus" with global
    pooling and local threats was claimed in v0.12. **It is retracted in
    v0.12.1:** locality bounds harm per failure, not capacity.)
  - **The m2 and MN statements hold with an island of 43 hosts, by Theorem
    CH** (the looser enumeration gave about 60).
- **(o7) G in two forms (SR11-3).** With growth, density zero. With static
  flow, share ≤ m₀/(m₀ + n_max) = 2.1 × 10⁻⁷.
  - R-7: excluded capacity of about 1.9 per date is absorbed.
  - R-8: μ's effect is bounded.
  - R-9: DD is already hazard-adjusted.

**(p) Island holding, telemetry, shirking, and μ (`B4-B6-MU.md`).**

- **(p1) Pool, don't partition (SR11-11).** For 60 hosts, log₁₀ risk is −7.7
  pooled and +47.7 split in two. Threats are **births in place**, not routed
  traffic, so cut-capacity and perimeter-gate arguments do not apply
  (SR11-12).
- **(p2) Island requirement, by Theorem CH (closed form, rigorous).**

      P(fail) ≤ inf_θ exp(θh₀ + Σ_a m_a(e^{θK(a)} − 1))·(ε + (1−ε)e^{−θK_k})ⁿ.

  - The island is protected to T when the exponent reaches ln(T/η).
  - **It needs 43 hosts** at μλ = 10⁻⁶ (each extra host buys about 2.7 orders
    of magnitude).
  - Universal 5% / 10% shirking: **50 / 58**.
  - *The locality bonus is retracted:* under pooled holding, loads from all
    localities add. Locality bounds **harm per failure** (q = 1/P), so
    per-history risk falls by P, while (a)'s "every history" is unchanged.
- **(p3) μ is a parameter.** By CH, hosts needed are **41, 43, 51 and 72** for
  μλ = 10⁻⁸, 10⁻⁶, 10⁻⁴ and 10⁻². (A looser enumeration gave 45 to 175.) No
  theory of μ is needed for the theorem.
- **(p4) B4 telemetry.** ε_upper = ε̂ + √(ln(1/δ)/2N). SAFE iff
  r_lower > 1. There were 0 false-SAFE declarations in 4000 audits, even at
  true r = 0.947. The dashboard shows r_lower, φ̂, ĝ*, and in the twilight
  s_S and u.
- **(p5) B6 shirking.**
  - **SPRT** (α = β = 10⁻³) detects 30% shirking in about 29 dates and 10% in
    about 197. The Wald floor ln(1/α)/KL ≈ 189 is information-theoretic.
  - **Deterrence:** κ* = 0.164 at s = 0.3, and **0 at s = 0.1**.
  - **The tension, proved:** harsh punishment manufactures enders
    (SR11-10).
  - **Resolution, by sizing:** ε_eff = ε + (1−ε)s. Hosts needed are 50, 55 and
    65 for s = 0, 5% and 10%.

### Proof

**(p)** All of (p) comes from the corrected load model plus SPRT. See
`work/check_load.py`, `check_b4b6.py` and `check_shirk_sizing.py`.

**(o)** MN1 is P-Σ plus Φ2 monotonicity. MN2 is TW2 with the headroom decay
rate. The residuals are evaluated in `work/check_residuals.py`.

**(n)** C1 uses the two-sided Gaussian bounds. C3 and C4 are direct
evaluations. B is evidence, not proof, with sources in
`BOUNDARIES-AND-BRIDGE.md`.

**(m)** The full proofs are in `KS-RESOLUTION.md`. In outline:

- (m1) by hazard-adjusted discounting;
- (m2) by exact sums plus a monotone-coupling tail bound;
- (m4) by one-shot deviation;
- (m6) by the law of large numbers, plus a lower bound on bounded-noise
  exit;
- (m7) by the triangle inequality.

**(l)** The full proofs are in `SEAMS-A.md`. In outline:

- (l2) by two-rectangle decomposition plus induction;
- (l3) by weighted Hoeffding;
- (l4) by finite-horizon DP;
- (l6) by the log-derivative;
- (l7) by a geometric series;
- (l9) by policy evaluation;
- (l10) by monotonicity;
- (l12) by Poisson thinning.

**(k)** Hoeffding on both sides of H/C = 1 − ε, and the CLT at equality
(`NARROW-PLACE.md`).

**(g)–(j).** The full proofs are in `DETERRENCE.md`, `PHI.md`,
`PHI-JOINS.md`, `SEAMS-4.md` and `GHOSTS.md`. In outline:

- **(g)** solves the stationary two-state Bellman boundary.
- **(h)** uses coupling, the binomial tail, and Hoeffding.
- **(i)** uses enumeration of class-shock patterns, plus MIX with EDC.
- **(j)** uses Little's law and ∫ a/(a + bt).

**(f)**

- (f0) is (H1)'s upper bound with g(0) > 0.
- (f1) is a coupling: identical message, identical delivery event, and B's
  later sends taken as a maximum.
- (f2): K̇ = −uK for all, so (K_i/K_j)′ = 0.
- (f3) combines (f2) with DOOM(a), the value order of (c2), and H4.

**(a)** For each channel, P(some failure by T_end) ≤ T_end·f_k(m_k) ≤ η_k, by
(M2) with the stated margin (P2, P2′, P1, P4c). Theorem M (M4) unions the
channels. Coverage failures are added by the coverage bound. Outside all of
these events:

- reached minds satisfy (B_T);
- held minds play admitted, jointly safe actions;
- care is paid;
- noise stays within the margin.

By L-C, S is kept through T_end.

**(b)**

- (b1) Full support gives P(pivotal) > 0, which is a strict first-ranked
  gain.
- (b2) The crossing argument, given each adversary profile.
- (b3) d/dt ln(K_i/K_E) = a·x_i/K_i ≥ 0, and the denominator decays at
  rate ≥ u.
- (b4) Independence.
- (b5) Enumeration of world-shock patterns. The cost share follows by
  symmetry: κ(ks − ks^k)/k.

**(c)** As in v0.3.1.

**(d)**

- (d1) Combines (b), 1.11a, H1's upper bound, and CW1.
- (d2) Loss-first: c(t) > 0 = c(T_end). Carried-first: I(t) ≤ I(T_end), with
  ties broken by c.

**(e)**

- (e1) Death at t requires all n partners to fail.
- (e2) With empty margins there is no rescue, and g(0) > 0.
- (e3) Linearity of expectation over arrival cohorts. ∎

## 4. What the composition shows

1. **The narrow place is bridged durably.** L-C gives it exactly. NS/DS
   remove the coordination problem. AI removes the adversary problem. MR
   reduces its cost to 1.4 × 10⁻¹⁴ of the budget.
2. **The noise that forbids certainty is the noise that makes keepers
   pool.** Θ0 against NS.
3. **Every guarantee is a margin, and every margin grows at most
   logarithmically.** This is Theorem M. The same noise forbids "forever"
   and permits "until the end" (M5).
4. **Diversity is the mechanism of protection, not only its goal.** Only
   independent worlds and independent keepers turn margin-insensitive floors
   into margin-sensitive guarantees (CW, M3).
5. **Every bridge leads to T_end.** There are eleven independent reasons to
   keep to the end: value, patience, capacity, self-survival, holding,
   redundancy, game theory, information, funding, cooperation and margins
   (`BRIDGES-TO-T.md`). Ending early is doom (d1). The end is the unique
   sensible point (d2).
6. **Keepers inherit.** Rescue needs capacity, and only renewing flows keep
   capacity (e).

## 5. No premise can simply be dropped (exact counterexamples)

| Drop | What fails | Witness |
| --- | --- | --- |
| (P1) | a bill is missed, or the start leaves C₀ | §11.40 with 13 units; an endowment one below 84 fails |
| (P1), positive returns | no finite endowment is almost-surely safe | C∞-1, NONPOS |
| (P2) | every proper S is left almost surely | Θ0 |
| (P2′) | if Π(1 − g(ρ(t))) < 1 − η, **no policy** reaches 1 − η; dropping only the sufficient condition proves nothing (M5CONV) **[SR5-2]** | M5, two-sided |
| (P4c), seizure headroom | after one seizure of 60, an ender at 20 rises to 80 > the keepers' 60, and is unheld afterwards **[SR5-3]** | SEIZE |
| KA′ in (d2) | ranked naively, a channel dying at T_end makes t = 2 look best **[SR5-5]** | UCHAN |
| (P3), coverage | an unreached, unheld mind destroys | PB0 |
| (P3), joint safety | 3 + 3 > rK/4 = 5 | COMPOSE |
| (P4a) | with ender inflow, K_i/K_E falls | v0.3.1 probe M2 |
| (P4b) | an impatient keeper ends its host | D1, ζ > 2/25 |
| (P4b′) | a lone keeper at margin 4 has effective rate 0.116 > 0.08: impatient, so it ends its host | KS probe M1 |
| island capacity, (m2) | a 30-host island (ceiling 1440) fails over 10¹⁰⁰ dates; its rescue margin is 2 | KS probe M2 |
| hard top, (m6) | with a soft holding ramp, φ → 1 − h(E) = 0.5: no collapse | KS probe M3 |
| pooling, (p1) | split the island in two: 60 hosts goes from −7.7 to +47.7 | SR11-11 |
| subtle-shirk deterrence, (p5) | at s = 0.1, κ* = 0: not deterred, so the margin must absorb it | `check_shirk_sizing` PARTIAL |
| keeper scaling, (p2) | with n fixed at 120, universal 5% shirking stays unabsorbed even at 100 hosts (+2.8) | process note |
| (P4c), noise | without noise, "nobody pools" is stable | NS CTRL |
| (P4c), sabotage margin | 175 violations in 42 games | AI CTRL |
| (P4c), independence | correlated keepers: per-date failure ε for every n | M3, RM |
| (P4c), lexicographic capacity | "no pooling" is stable among finite-trade-off keepers | D2 |
| (P4d) | a finite-trade-off mind destroys at the final step | hazard rule |
| (MR), capacity to rescue | empty partners cannot rescue: coalition size buys nothing | K2 (−895 for every n) |
| (MR), independence | shared world-shocks: floor s | CW1; probe M1 |
| Coupling / non-rival, in (f1) | a rival twilight jump carries more in 13,384 cases; without coupling, B sometimes carries less | TW1 control; probe M2 |
| Non-rival, in (c1) | a peak-hungry transition cannot be copied | LC caveat, 70 against 48 |
| Exposure cost, in (g) | with p_X = p_K, the deterrence premium vanishes: g* = V_K for every φ | DD CTRL |
| Capacity margin, in (h4) | with C(1−ε) < H, splitting drives φ toward 1 | MS CTRL |
| Growth, in (h5) | with static n, the holding budget grows linearly | J1 CTRL |
| Covering, in (i1) | without covering slack, diversity does not beat the monoculture floor | J2 probe M2 |
| (IS) | P(some island fails) rises with the number of islands (10⁻⁶ → 10⁻³ at m = 1000) | HORIZON |
| Growing keepers / finite ender lives, in (j) | with either removed, the ender share does not tend to 0 | G probes M1, M2 |
| The reliability ratio, in (k) | with r = 19/20 (C > H), splitting drives φ to 0.999; with r < 1, more keepers make it worse | NP SHARP |
| Upkeep, in (l6) | a keeper far above its ceiling *can* lose ground to a slow-decaying ender (transient) | A probe M1 |
| Detection, in (l9) | with q = 0, g* = 20 ≈ V_K: no deterrence premium | A probe M2 |
| Twilight, in (l4) | the final date is not deterred, so it is held (f2) and adds ≤ φ | A probe M3 |

**Scope.** "Not removable without replacement". The table does not show
that any premise is the weakest possible.

## 6. What remains

**Closable mathematical seams: none open.** All of A1–A14 are addressed in
(l). Some closures carry a named premise:

- union-mixing (A2);
- a logistic host (A4);
- detection, without which there is no deterrence (A9);
- energy cutoffs on shocks (A13);
- LA′ growth in the A1 witness. **No longer needed: (m2).**

**B. Facts about a world (BRIDGE), now with status (n5).**

- B1 flows and T_end: **consistent**.
- B2 EDC: **consistent locally**; regional hazards need spacing beyond their
  range.
- B3 island capacity: **consistent, given a units mapping.** The model needs
  about 60 hosts once ongoing arrivals are counted (SR11-1 corrected).
- **B4 the narrow place: reframed by MN** as "has this world crossed
  r > 1?". After that, the narrow place is T. **Telemetry with a
  no-false-safe guarantee (p4).**
- B5 keepers exist: **weak form demonstrated by instance**; the strong form
  is parked.
- B6 detection of shirking: **detected by SPRT (p5).** Subtle shirking is
  absorbed by sizing, not deterred. Real-world detection rates are BRIDGE.

**C. Boundaries proved permanent, and now proved attained (n1–n4).**

- No unconditional preservation, **at optimal cost**.
- Pure enders are held, **at narrow-place cost only**.
- The level ends in the final twilight, **a vanishing fraction**.
- No "forever", **but physics, not noise, sets the end**.

**D. Process.**

- Independent review: none since v0.2. This waits on the author's ruling.
- Publication path.
- Parked items: Q, P, P′.
- Value inheritance (μ → 0) needs a theory not yet written.

## 7. Finite witnesses

| Checker | Groups |
| --- | --- |
| `work/check_upt_composition.py` | BOUND, REACHED, NARROW, TIMING, ENDGAME, K |
| Gate D: `check_gate_d.py` | D1, D2, D2b, D3 |
| `work/check_v03_candidates.py` | EGU-GEO, EGU-BND, D2c |
| `work/check_ka.py` | KA |
| `work/check_v031.py` | HAZARD, PERSIST, LEXSEL, COPY, INTEGRATED, COMPOSE |
| `work/check_ns.py` | NS, CTRL, RM |
| `work/check_ns_routes.py` | AI, CTRL, PSUM |
| Gate C-∞: `check_gate_c_inf.py` | FLOW, ENDOW, WORST, NONPOS, ANNUITY, MARGIN |
| `work/check_margin_law.py` | SENSITIVE, INSENSITIVE, LUNDBERG, COMPOSE |
| `work/check_cw.py` | FLOOR, PACT, DEEP, WORLDS |
| `work/check_horizon.py` | SANDWICH, ENDPOINT, ALLOC, CONVERT, TIMING |
| `work/check_doom.py` | SELF, HELD, UNIQUE |
| `work/check_keepers_inherit.py` | RESCUE, GHOSTCO, GHOSTS, N_FOR_ETA |

| `work/check_selfreview_v05.py` | M5CONV, SEIZE, UCHAN, SHARE (the SR5 witnesses) |
| `work/check_twilight.py` | TW0, TW1 (Cauchy, Gaussian, binding and wide channels, rival control), TW2 |
| `work/check_deterrence.py` | THRESH (closed form = bisection), CTRL, HAZARD |
| `work/check_phi.py` | PHI1 (= brute force), PHI2, PHI3, PHI4 (illustrative), N_COMPARE |
| `work/check_phi_joins.py` | J1 and its control, J2a, J2b, J3 (illustrative) |
| `work/check_seams4.py` | SURPLUS, SPLIT and its control, HORIZON, TAILV2 (the integrator's checker fails as written), COHORT and its control |
| `work/check_ghosts.py` | DENSITY, MUTATE, FINITE (probes illustrative) |
| `work/check_narrow_place.py` | SHARP (both sides, and equality), INSTANCE, CMIN, GEMINI (the integrator's checker: equivalent pass conditions, float underflow) |
| `work/check_seams_A.py` | A1 WITNESS (joint satisfiability), A2 MIXTV, A3 HETERO, A4 TWILIGHT, A5 ADVFLOW, A6 UPKEEP, A7 STOCH, A8 RESCUE, A9 DETECT, A10 MONO (floats), A11 RACE, A12 REACH (floats), A13 FUNDMIX (illustrative) |
| `work/check_ks.py` | KS1, KS3, KS5 (static-flow witness to 10¹⁰⁰, with a 30-host control), KS6, KS9 (illustrative), KS11, KS16 (Decimal), KS17 |
| `work/check_bc.py` | C1 optimal margins (log-space floats, Mills bounds), C3 twilight fraction, C4 noise lifetime |
| `work/check_residuals.py` | MN1, MN2 and its control, MN4, R2, R3, R4 (illustrative), R5 sweep (20/24; failures cured by capacity), R7 |
| `work/check_sr11.py` | COAL (coalition tail by island size), KAPPA (corrected), CURE (all 4 points), GSTAT |
| `work/check_load.py` | the corrected simultaneous holding load (40 hosts +8.5, 60 hosts −7.7; control: the SR11-1 overcount) |
| `work/check_b4b6.py` | MU, TEL (no false-SAFE), SPRT, SHIRK |
| `work/check_shirk_sizing.py` | LOCALITY (superseded: the bonus is retracted), PARTIAL, SIZE, WALD |
| `work/check_chernoff_island.py` | Theorem CH (rigorous closed-form bound): hosts by μ and by shirking; CH ≤ enumeration |

**Groups that are true by construction, and so illustrate rather than test
[SR5-10]:**

- COPY (v0.3.1);
- INSENSITIVE and COMPOSE (Margin Law);
- CONVERT (H);
- UNIQUE (DOOM).

All use exact rationals, except where floats are labelled. **Each has
probes that must FAIL_AS_REQUIRED.** They are finite shadows and prove no
theorem.

## 8. The hardening map: earning a stronger statement

The table gives each qualifier in §0, what has already retired it in v0.6,
and what is left.

| Qualifier | Retired in v0.6 | What is left |
| --- | --- | --- |
| "physics allows care until T_end" (P1, P2, P2′) | the cooling era helps (SEAMS-4 S3, Dyson) | BRIDGE: real ρ(t) and funding. The de Sitter floor ends care at the twilight (TW0, S3) |
| "keepers who put protection first hold enough capacity" (P4c) | **reduced to one exact, sharp initial condition (k):** C(1−ε) > c(K_E(0)+aS_max)+A, per island. Above it, everything follows (MS, J1, DD, G) | an **initial condition**. It is priced exactly; whether a given world meets it is BRIDGE |
| "reached or held" | **retired by DD:** only pure enders, and gains above g*, are held | the residue is irreducible, and is named |
| "independent failures" | **closed in the theorem:** J2b selection; J3 spacing; **(l2)** a mixing TV bound for *every* event, including the shortfall | EDC and union-mixing *in a real world* (BRIDGE) |
| "through T*_η" | (f), plus **(l4) twilight deterrence**: keep at every date with ≥ 2 left | the level in the final twilight is impossible (f0; boundary C) |
| "enders are ghosts" | **retired by G:** density zero | μ → 0 (value inheritance) |
| per-island protection (IS, new) | stated honestly as a weakening | island capacity: can one bound group hold the margins? |
| "in the stated models" | **(l3)** unequal keepers; **(l6)** any upkeep rates; **(l7)** stochastic capacity; **(l11)** races; **(l12)** spatial reach (the book's own reach model) | wider still: non-threshold holding mechanisms; continuous-type minds |

**What v0.6 has earned.** The strongest wording now supported is:

> *Every mind keeps the living free for reasons of its own, except minds that
> value ending for its own sake. Those are held by keepers whose numbers the
> world can multiply. They cannot last, accumulate or win. The arrangement
> lasts, island by island, until the universe can no longer sustain care, and
> no transition makes sense before then.*

**It rests on:**

- enough protection-first capacity in the narrow place;
- the margins;
- (IS);
- independence or mixing;
- the stated models.

**In v0.8, every closable seam is addressed (l), and the premise set is
jointly satisfiable (l1).** As before, the one premise carrying the whole
budget is exact. It is a
sharp threshold on initial conditions: r = C(1−ε)/H > 1 at the narrow place,
per island. It cannot be retired by mathematics, because it is a fact about a
world. It is the point where the theorem hands over to BRIDGE.

