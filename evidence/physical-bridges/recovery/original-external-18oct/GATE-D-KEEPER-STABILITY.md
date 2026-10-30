# Gate D: keeper stability among interacting minds (draft v0.1)

18 October 2026. **Author-side draft by Claude (team blue).** Unreviewed; not
self-accepted.

It discharges, in stated models, the premise UPT-P leans on most: keepers
**stay** keepers, **pool** to hold enders, and hold **through the end-game**.
It builds on four sources:

- HRE Prop. 1.11a, "enders are transients" (S-19);
- Theorem E, v1.1;
- UPT-P (`0d730a89…`, now under GPT review);
- Addendum EG.

## D1. Keepers stay keepers: the patience threshold. PROVED

**Model.** This is Prop. 1.11a's capacity law, K̇ = a·x(t) − u·K with a, u > 0:

- a keeper draws a sustainable flow y from a host held at a stable
  equilibrium;
- an ender takes the standing stock S at once.

Capacity is valued with discount rate ρ > 0.

**Proposition D1.**

    PV(keep) − PV(end) = a·(y/ρ − S)/(ρ + u).

So keeping beats ending **iff S < y/ρ**, with a tie at equality.

For a logistic host r·x(1 − x/K) at its harvest equilibrium x*, we have
y = r·x*(1 − x*/K) and S = x*. So the condition becomes

    keep  iff  ρ < r·(1 − x*/K).

**In words: a mind keeps the living iff its impatience is below the living's
own regeneration rate at the operating point.**

*Proof.*

- K_K(t) = ay/u + (K₀ − ay/u)e^{−ut}, so
  PV(keep) = (ay/u)/ρ + (K₀ − ay/u)/(ρ+u).
- K_E(t) = (K₀ + aS)e^{−ut}, so PV(end) = (K₀ + aS)/(ρ+u).
- Subtract: (ay/u)(1/ρ − 1/(ρ+u)) − aS/(ρ+u) = a(y/ρ − S)/(ρ+u). ∎

**Remarks.**

- The upkeep rate u and the starting capacity K₀ **cancel out** of the sign
  of the difference.
- In the book's instance (r = 1/5, K = 100, x* = 60, y = 24/5) the
  threshold is **ρ* = 2/25 = 0.08**.
- This is the established bioeconomic result that liquidating a renewable
  resource is optimal only when the discount rate exceeds its regeneration
  rate (C. W. Clark, *Science* 1973). The citation is from knowledge; a
  spot-check is owed. D1 places that result inside Snuffy's capacity model.
- It joins the book's "patience" roads (The Whole Argument, the spine). A
  patient keeper is a stable keeper. An impatient mind (ρ > ρ*) is exactly
  the mind that needs **holding** through the narrow place.

## D2. Keepers pool, with the exact equilibrium. PROVED for the stated game

**Game.** There are n keepers.

- Keeper i has capacity K_i, a pooling cost κ_i > 0, and a **private stake**
  w_i = y_i/ρ. That stake is the present value of its own flow, which it
  loses if an ender is not held: the ender seizes the hosts the keeper draws
  from.
- The ender is held iff pooled capacity ≥ c·K_E (the H-cap premise, with
  factor c).
- Payoff to keeper i: −κ_i·[i pools] − w_i·[ender not held].

**Proposition D2.**

(i) A profile in which the ender is held is a pure Nash equilibrium **iff**
its set of pooling keepers is a **minimal winning coalition**, and every
member has κ_i ≤ w_i.

(ii) If the keepers with κ_i ≤ w_i together have capacity ≥ c·K_E, such an
equilibrium **exists**.

*Proof.*

- (⇐) Each member is pivotal: leaving saves κ_i but loses w_i ≥ κ_i. A
  non-member who joins pays κ_j and changes nothing.
- (⇒) A non-pivotal member could leave, saving κ_i > 0. So the coalition is
  minimal, and every pivotal member needs κ_i ≤ w_i.
- (ii) Among the willing keepers, any winning set contains a minimal winning
  subset. ∎

**This is keeping as self-interest, not altruism.** Keepers hold enders
because **their own flows are at stake**. A keeper is a mind that draws from
living hosts, and an unheld ender ends those hosts.

**What D2 does not settle.** Coordination. The no-pooling profile can also be
an equilibrium when no single keeper is pivotal alone. Which equilibrium is
reached is equilibrium selection. Cheap talk, focal rules, or a standing
institution (The Whole Argument §4, "a principle of protection") are
candidates. **Selection is OPEN.**

**D2b. Holding gets cheaper over time (keepers win).** By 1.11a,
K_E(t) = (K₀ + aS)e^{−ut} → 0. So the holding threshold c·K_E(t) falls, and
the size of the minimal winning coalition is **non-increasing** in t (for
fixed keeper capacities). The checker shows sizes 3 → 2 → 1. This uses the
conservative rational bound e^{−ut} ≤ 1/(1+ut).

## D3. Holding through the end-game: lexicographic keepers carry it. PROVED in the stated model

**Model.** Near the natural end T*, flows fade: y_i(t) → 0. A finite-trade-off
keeper stays pooled at t iff w_i(t) = y_i(t)/ρ ≥ κ_i. A keeper that holds
the declared good first (lexicographic) **always** stays.

**Proposition D3.**

- Let t_i be the first t with y_i(t)/ρ < κ_i. Each finite-trade-off keeper
  **exits** the pool from t_i on: end-game unravelling for keepers.
- Holding at t ≥ max_i t_i is feasible **if** the lexicographic keepers'
  capacity is at least c·K_E(t).
- Because K_E(t) has decayed by then (D2b), **a small lexicographic capacity
  suffices.**

*Checker instance.* Two finite-trade-off keepers exit by t = 80. One
lexicographic keeper, of capacity 2, holds alone, because c·K_E(80) = 4/9 by
the conservative bound.

**Consequence.** By the end of the universe the burden falls on the keepers
who hold the declared good first. Thanks to keepers winning, that burden has
shrunk to almost nothing by then. **Together, keepers win (1.11a) and the
lexicographic good (UPT-P (c)) close the end-game.** Neither does it alone.

## What Gate D gives UPT-P

| UPT-P premise | Discharged by | Remaining condition |
| --- | --- | --- |
| Keepers do not turn ender | D1 | patience: ρ < y/S = r(1 − x*/K) |
| H-cap and pooling | D2 (exact equilibrium) | the private stake w_i ≥ κ_i; **equilibrium selection OPEN** |
| Holding obligations shrink | D2b | ender decay (1.11a premises) |
| End-game window | D3 | lexicographic capacity ≥ c·K_E near T* |

## Scope and open items

- **D1–D3 are proved in their stated models.** These are non-spatial and
  deterministic, with a threshold holding rule.
- **Open items:**
  - equilibrium selection among pooling equilibria;
  - spatial reach (Not Being First's (λ_E/λ_K)⁴ geometry);
  - gains that scale with the mind (races, compounding);
  - stochastic capacity;
  - the empirical half of BRIDGE.

## Finite witnesses (`work/check_gate_d.py`)

The checker uses exact rationals, stdlib only, and is deterministic.

| Group | What it checks | Result |
| --- | --- | --- |
| D1 | the identity, on a 96-point grid | exact, including its sign; book instance ρ* = 2/25 on both sides |
| D2 | 300 random games, all 2⁵ profiles each | 0 characterisation mismatches; 0 existence failures |
| D2b | minimal coalition size over time | non-increasing: [3, 2, 1, 1, …] |
| D3 | the end-game run | finite-trade-off keepers exit by t = 80; the lexicographic keeper holds alone |

Four probes must all FAIL_AS_REQUIRED, and they do. These are finite shadows.
They prove no theorem.
