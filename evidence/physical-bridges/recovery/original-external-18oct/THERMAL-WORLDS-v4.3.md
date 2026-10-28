# T4.3 v4.3 additions: thermal worlds (Nash restored, a sharp smoothing lemma, and a survival law in place of almost-sure preservation)

18 October 2026, Pacific/Auckland.

**Author-side revision by Claude (Opus 5.5).** v4.3 applies Codex's Part B
finding D42-5 (bank `774cf5b5…`, Part B verdict ACCEPT-WITH-REPAIRS) to one
sentence in §4, marked **[D42-5]**. The v4.2 bytes (`339bfc88…`) are
preserved.

v4.2 applied the four local
corrections from Codex's delta read of v4.1. That bank is
`~/Documents/Codex/2026-10-18/t43-v4.1-delta-read/`, SHA256SUMS `96fe948a…`,
with verdict REVISE. Each correction is marked **[D41-n]** where it occurs, and
they are listed in §13. The v4.1 bytes (`cf897848…`) are preserved unchanged.
The rest of this header is carried over from v4.1.

v4.1 implemented the six repairs from Codex's non-author hostile review of v4:

- the review bank is `~/Documents/Codex/2026-10-18/t43-v4-thermal-worlds-hostile-review/`;
- its `SHA256SUMS` is `94f9f358da8b291019f429fe7f720331fdfd0baee01b58448b36327478b12f7a`;
- its verdict is **ACCEPT-WITH-REPAIRS**.

Each repair is marked **[Rn · T4-m]** where it occurs, using the review's own
numbering. The reviewed v4 bytes are preserved unchanged, as
`THERMAL-WORLDS-v4.md` (`e0215f70…`).

The repairs themselves have **not** been re-reviewed. Codex states that its
proposed repair text was "not … independently re-reviewed as new target
bytes". A delta read of these changed passages is therefore owed before
adoption. GLM decides on adoption, as the framework's author.

This revision builds on:

- **A9:** GLM's adopted §9 v3, `eb9c4c00…`;
- **U3:** `fecbbe5d…`;
- **C:** `5413a5dd…`, with its errata in
  `t43-next-revision-candidates-claude-2026-10-17/ERRATA-C.md`;
- **He–Sun 2017**, arXiv:1311.1562v3, PDF SHA-256 `114ec464…`.

## 0. What this adds

A9 proves that a stationary *correlated* equilibrium exists. It leaves
uncoordinated Nash OPEN in general, and it proves almost-sure preservation
under an exact one-step safe-mass hypothesis. This note asks what happens in a
**thermal world**: one where the shared state diffuses under noise, and a
fresh fluctuation that nobody controls is observed by everyone. It has four
results.

1. **Lemma TS (sharp in the continuous class).** Noise converts weak
   continuity into total-variation continuity:
   ‖(μ−ν)∗ρ‖_TV ≤ ½‖∇ρ‖_{L¹} W₁(μ,ν).
   - Under Setting T it supplies A9's **(AC)** and **(NC)**.
   - It supplies C's **(EC)** and **(NC′)** *when Q₀ is additionally jointly
     weakly continuous on X × A*. **[D41-2]**
   - It does not supply C's continuous-feasibility hypothesis (FC), and it
     does not make a torus profinite. **[R2 · T4-12]**
2. **Θ1. Nash is restored.** With finitely many players, a stationary Markov
   perfect **Nash** equilibrium exists. With a bounded displacement law and a
   safety margin at least the noise radius, preservation remains **almost
   sure**.
3. **Θ0. No-go.** If the displacement law has full support on the torus (for
   example, a strictly positive continuous density), **no D-supported policy
   preserves a proper closed product safe set with probability one.**
4. **Θ2. The survival law.** Under Gaussian noise σ with margin m:
   - P(exit within T steps) ≤ T·2d·e^{−m²/(2dσ²)};
   - **the mean exit time has an exponential lower bound**,
     E[τ] ≥ e^{m²/(2dσ²)}/(4d).

   **[R6 · T4-14]** This is a lower bound. It is not an exact escape law or a
   sharp rate.

**Not addressed here:**

- Nash with no fresh, publicly observed fluctuation (remains OPEN);
- GLOBAL, BRIDGE and universality;
- the level-limit programme on non-profinite spaces;
- the Many Minds §4 derivation log, which is a separate lane.

## 1. Setting T (thermal worlds)

- **Players.** **Finitely many players, I = {1, …, N} with N < ∞.**
  **[R3 · T4-2]** No conclusion is claimed for infinite player sets.
- **State.** X = Y × Z.
  - Y = 𝕋^d = ℝ^d/ℤ^d, the flat torus with geodesic metric d_Y.
  - Z is a compact metric space carrying an **atomless** Borel probability ζ.
- **Actions.** Player k has a compact metric action set A^k. The feasible sets
  D^k(x) ⊆ A^k are nonempty and compact, with a closed (hence measurable)
  graph. Write D(x) = Π_k D^k(x).
- **Rewards.** Each r_k : X × A → ℝ is bounded, measurable in x and continuous
  in a. The discount β ∈ (0,1) is common.
- **Noiseless motion.** Q₀ : X × A → 𝒫(Y) is measurable in x and weakly
  continuous in a.
- **Thermal noise.** ρ is a probability density on ℝ^d with ρ ∈ W^{1,1}. Wrap
  it onto 𝕋^d.
- **Transition (stipulated model).**

      K(x, a; dy′ dz′) = (Q₀(x,a) ∗ ρ)(dy′) ⊗ ζ(dz′)

  **The next z′ is drawn fresh from the fixed atomless law ζ, independently of
  the previous state and actions.** **[R3]**
- **(PO) Public observation.** z is part of the state that every player
  observes. **[R3]**
- **Safe set.** S = S_Y × Z, where S_Y ⊊ 𝕋^d is closed with nonempty interior.
- **Policy quantifier.** **"Every policy" means every policy that respects this
  conditional transition model.** Policies may be history-dependent,
  randomised, correlated, or use public signals or z. They cannot alter K.
  **[R6 · T4-9]**

The physical reading is that Y is a diffusing macro-state and Z a re-thermalised
micro-state. That reading is interpretive. Every proof uses only the
hypotheses above.

## 2. Lemma TS (thermal smoothing)

**Lemma TS.** For probability measures μ and ν on 𝕋^d,

    ‖μ∗ρ − ν∗ρ‖_TV ≤ ½ ‖∇ρ‖_{L¹(ℝ^d)} · W₁(μ, ν).

The convention is ‖·‖_TV = sup_A |·(A)| = ½‖·‖_{L¹}. This is He–Sun's
convention (their §2, n. 16), so it is the convention A9 inherits.
**[T4-7]**

*Proof.* **[T4-6 route]**

1. For torus points y and y′, choose lifts whose difference h has minimal
   Euclidean norm modulo ℤ^d. Then |h| = d_Y(y, y′).
2. Periodisation contracts L¹ differences. So
   ‖δ_y∗ρ − δ_{y′}∗ρ‖_{L¹(𝕋^d)} ≤ ‖ρ(·−h) − ρ‖_{L¹(ℝ^d)}.
3. For ρ ∈ W^{1,1}, ‖ρ(·−h) − ρ‖_{L¹(ℝ^d)} ≤ |h|·‖∇ρ‖_{L¹}. To see this,
   integrate the directional derivative along h, apply Tonelli, and pass to
   the Sobolev representative by smooth approximation.
4. So TV(δ_y∗ρ, δ_{y′}∗ρ) ≤ ½|h|‖∇ρ‖_{L¹}.
5. Mix this inequality over any coupling of μ and ν, then take the infimum of
   the transport cost. The result is the stated W₁ bound.

This argument does not need a duality locator. ∎

**Sharpness, continuous witness.** **[R4 · T4-6]** In dimension 1, take the
normalised symmetric trapezoid density:

- support [−a, a], with a = 1/8;
- constant height H on [−b, b], with b = 1/16 and H = 1/(a+b) = 16/3;
- linear sides.

It lies in W^{1,1}, with ‖ρ′‖_{L¹} = 2H = 32/3. Take μ = δ₀ and ν = δ_h with
h = 1/32. Then

    TV = H·h = 1/6 = ½·(32/3)·(1/32) = ½‖ρ′‖_{L¹}·W₁.

So the coefficient ½ is attained in the continuous class. Codex checks this
exactly in its checker group `continuous_TS_sharpness`. Multiplying by
slowly varying smooth factors in the other coordinates shows that ½ is optimal
in every fixed dimension. *This is not a claim that the bound is best possible
for every individual density.*

The discrete equality in this bank's group TS is consistent with this. On its
own it is not evidence of continuous sharpness.

**Constants.**

- Gaussian ρ = N(0, σ²I_d): ‖∇ρ‖_{L¹} = E|N(0,I_d)|/σ ≤ √d/σ. In dimension 1
  this equals √(2/π)/σ.
- Scaled bump ρ_r(u) = r^{−d}ρ₁(u/r): ‖∇ρ_r‖_{L¹} = ‖∇ρ₁‖_{L¹}/r.

**Corollary TS.**

(i) **Under Setting T.** K(x,a) ≪ λ := Leb_Y ⊗ ζ, with an explicit jointly
Borel density. **[R3 · T4-3]**
- Take a nonnegative Borel representative of the wrapped density ρ̃.
- Define q₀(y′|x,a) = ∫_Y ρ̃(y′ − v) Q₀(x,a; dv).
- Q₀ is state-measurable and action-continuous with separable action space, so
  by Carathéodory it is jointly Borel. q₀ is then jointly Borel in
  (y′, x, a), and Tonelli gives it total mass 1.
- Replace q₀ by zero exactly where q₀ is infinite. That set is jointly Borel,
  and for each fixed (x,a) it is null in y′. The replacement is therefore a
  pointwise, jointly Borel operation; it does not assume one common exceptional
  set for all parameters. **[D41-3]**
- Then q((y′, z′) | x, a) = q₀(y′ | x, a) is a density of K with respect to λ,
  and it does not depend on the **next** z′.

Also, a ↦ K(x,a) is TV-continuous, by Lemma TS: on compact Y, weak continuity
and W₁-continuity coincide. Together these give A9's (AC) and (NC).

(ii) **If, in addition, Q₀ is jointly weakly continuous on the compact space
X × A.** Then Q₀ is uniformly W₁-continuous, and K satisfies C's (EC) and
(NC′). **[R2 · T4-12]**

**Setting T alone does not guarantee (EC).** **[D41-2]** The localised-bump
example of T4-12 shows the failure. It uses a bump density supported in
[−1/32, 1/32], so it does not hold for every noise density. In it, Q₀ = δ₀ or
δ_{1/4} according to the sign of the current y. Then the states ±1/n converge
together while their next-state laws stay at TV distance 1. (ii) supplies
neither (FC) nor a profinite topology.

## 3. Theorem Θ1 (bounded displacement noise: Nash, and almost-sure preservation with a margin)

**Hypothesis (M_r).**

- The wrapped displacement law is supported in B̄(0, r), with r < ½.
- For every x ∈ S and a ∈ D(x), supp Q₀(x,a) ⊆ S_Y^{−r} := {y : B̄(y,r) ⊆ S_Y}.

**Theorem Θ1.** Under Setting T (finitely many players) and (M_r):

(a) The game has a stationary Markov perfect **Nash** equilibrium.

(b) Every D-supported strategy profile that respects the transition model
preserves S almost surely from every safe initial state. This includes every
equilibrium.

*Proof of (a).*

He–Sun's **Theorem 1**, quoted exactly by Codex (T4-2, PDF p. 14), reads:
"Every discounted stochastic game with a (decomposable) coarser transition
kernel has a stationary Markov perfect equilibrium." **[R3 · T4-2]** It
inherits the §2 standing assumptions:

- finitely many players;
- a countably generated state space;
- compact metric actions;
- measurable, nonempty, compact feasible correspondences;
- bounded payoffs, measurable in the state and continuous in actions;
- discounts below 1;
- a jointly measurable kernel with a jointly measurable density relative to
  one probability measure;
- norm continuity in the action profile.

Setting T meets every one of these:

- X is compact metric, hence standard Borel.
- The feasible correspondences are as required.
- The density is the one constructed in Corollary TS(i).
- Norm continuity is supplied by Lemma TS.

**Definition 1, coarser transition kernel.** Take G = 𝔅(Y) ⊗ {∅, Z}. The
density depends only on y′, so it is G-measurable.

**No G-atom: the completed check (T4-4).** **[R3]**

- Let D be any Borel set with λ(D) > 0. Fix a Borel injection b : Z → [0, 1].
- Put p(y) = ζ(D_y) and F(y,t) = ∫ 1_D(y,z) 1{b(z) ≤ t} ζ(dz). F(y,·) is
  continuous, because ζ is atomless.
- For p(y) = 0 put a(y) = 0. Otherwise let a(y) = inf{t ∈ [0,1] :
  F(y,t) ≥ p(y)/2}. This is Borel, by joint measurability and rational
  thresholds. **[D41-3]** Set
  E = D ∩ {b(z) ≤ a(y)}.
- Then, for every Borel B ⊆ Y, λ(E △ (D ∩ (B × Z))) = λ(D)/2 > 0.
- So E cannot be recovered from G restricted to D, even up to λ-null sets.
  This meets He–Sun's *strong-completion* definition of a G-atom.

This uses the fresh atomless next-z law. It does not need z to be uniform or
payoff-irrelevant.

Theorem 1 then gives (a). This agrees with Duggan (2012). Codex checked the
available primary source and found that this product form is a noisy
stochastic game in Duggan's sense (T4-5). Codex did not separately check the
final journal wording.

*Proof of (b).* Let x ∈ S and a ∈ D(x). Write the next coarse state as Y₀ + U,
with Y₀ ∼ Q₀(x,a) and U the wrapped displacement. Since Y₀ ∈ S_Y^{−r} and
|U| ≤ r, we get Y₀ + U ∈ B̄(Y₀, r) ⊆ S_Y. Hence K(x,a; S) = 1, which is A9's
one-step safe-mass hypothesis, and A9 §9.3(b)'s induction applies. The argument
does not depend on the policy (T4-8). ∎

**Remarks.**

- (M_r) forces λ(S) > 0.
- The margin must be at least the radius: the checker's probe M2 shows this.
- **(M_r) concerns the *wrapped* displacement law.** A density with unbounded
  support on ℝ^d can wrap to a bounded displacement law and satisfy (M_r).
  Codex's T4-10 example does exactly that: bumps with weights 2^{−|n|}/3 are
  placed at every integer n and all wrap onto one bump. **[R1 · T4-10]**

## 4. Proposition Θ0 (no-go: full-support noise defeats almost-sure preservation)

**Statement.** Suppose ρ is continuous and strictly positive on ℝ^d (for
example Gaussian), so the wrapped displacement law has full support. Then:

- ρ̃ ≥ c := min_{[−½,½]^d} ρ > 0;
- for every (x, a), K(x, a; S^c) ≥ c·Leb(S_Y^c) =: η > 0;
- under every policy that respects the transition model, and from every
  initial state, P(X_t ∈ S for all t ≤ T) ≤ (1 − η)^T → 0.

*Proof.*

- For every y, ρ̃(y) = Σ_{k∈ℤ^d} ρ(ŷ+k) ≥ ρ(ŷ), where ŷ is the representative
  in [−½,½]^d. So ρ̃ ≥ c.
- S_Y^c is open and nonempty, so it has positive measure.
- At each step the conditional probability of exit is at least η, whatever has
  happened before.
- Multiply over the T steps. ∎

**Consequence.** **[R1 · T4-10, T4-13]** Under Θ0's full-support hypothesis,
no D-supported policy has probability-one preservation of a proper closed
product safe set. One sufficient case for probability-one preservation is a bounded wrapped
displacement law together with an adequate margin (Θ1). **[D41-1]** The
margin is not necessary. Codex's two-bump example shows this: the noise density
has mass near 0 and near the antipode, the safe set is two arcs, every
successor is safe, and yet no Θ1 ball-margin certificate exists. **[D42-5]**
Whether *some* policy preserves from a specified x is characterised by
x ∈ V(S), by Theorem V(b). The all-policy conclusion also needs the admission
condition, by Theorem V(c). In Setting T this rests on the Borel extension
supplied by Codex in V-12, now §5 of Theorem V v1.1. It has not been re-read
as new bytes. A margin alone does not restore probability-one preservation
under Gaussian noise; there, Θ2's survival bounds are the true statement.

**Codex's inventory of preservation clauses.** Codex inventoried 62 clauses in
A9, U3 and the HRE (evidence file `PRESERVATION-CLAUSES.md`). It found **no
unconditional probability-one physical preservation claim**: each one already
carries a transition or support premise. What Θ0 constrains is any
*application* that imports those conclusions while dropping that premise.
Codex's item A4 is an example: A9 §9.5's "Clauses (b) … hold" depends on the
retained safe-mass requirement. (FLF) removes (AC) and (NC); it does not remove
safe mass.

## 5. Theorem Θ2 (the survival law)

**Setting.**

- Setting T, with ρ = N(0, σ²I_d) wrapped.
- A margin m ∈ (0, ½) with (M_m*): for every x ∈ S and a ∈ D(x),
  supp Q₀(x,a) ⊆ S_Y^{−m}.

**Theorem Θ2.**

(a) With finitely many players, a stationary Markov perfect Nash equilibrium
exists. The proof of Θ1(a) applies. **[R3]**

(b) The bounds below hold for every D-supported profile that respects the
transition model, and from every safe initial state. Let τ be the exit time and
ε := sup_{x∈S, a∈D(x)} K(x,a; S^c). Then:

- (i) ε ≤ P(|σ N(0,I_d)| > m) ≤ 2d·e^{−m²/(2dσ²)};
- (ii) P(τ ≤ T) ≤ T ε;
- (iii) E[τ] ≥ 1/(2ε) ≥ e^{m²/(2dσ²)}/(4d);
- (iv) E[Σ_{t≥0} β^t 1{X_t ∉ S}] ≤ εβ/(1−β)².

Codex attacked all four bounds inside Setting T, and all four survived (T4-11).

*Proof.*

(i) An exit from a target Y₀ ∈ S_Y^{−m} requires d_Y(Y₀, Y₀+U) > m. That
implies |U| > m, which implies max_i |U_i| > m/√d. Combine the Chernoff bound
P(|N(0,1)| > u) ≤ 2e^{−u²/2} with a union bound over the d coordinates.

(ii) The bound in (i) holds for every feasible profile, pointwise. So
P(τ = t | τ ≥ t) ≤ ε, whatever the strategies, correlation or history.

(iii) By (ii), P(τ > t) ≥ 1 − tε. Let N = ⌊1/ε⌋. Then

    E[τ] ≥ Σ_{t=0}^{N} (1 − tε) = (N+1)(1 − εN/2) ≥ (N+1)/2 ≥ 1/(2ε).

(iv) P(X_t ∉ S) ≤ tε, and Σ_t β^t t = β/(1−β)². ∎

**Interpretive note (non-load-bearing).** **[R6 · T4-14]** Suppose,
*additionally*, that σ² = 2DΔt with the Einstein relation D = k_B T/γ. Then the
**lower bound** in (iii) is e^{γ m²/(4 d k_B T Δt)}/(4d). Halving the temperature
squares the exponential factor of that **lower bound**. This is not an exact
escape distribution, a sharp Arrhenius rate, or a measured physical law. The
temperature identification is a premise.

## 6. The profinite form (Θ-P) and K3

In A9's profinite setting, take a re-thermalised fine coordinate z ∈ {0,1}^ℕ
with the fair product law. Let K = Q(x,a) ⊗ ζ, where Q ≪ λ_Y has densities that
are TV-continuous in a. **Also retain the safe-mass requirement Q(x,a; S_Y) = 1
for every safe x and every feasible a.** **[R5 · T4-14]** Product noise on the
unrestricted fine coordinate is not enough on its own.

Then, with finitely many players:

- Nash holds, by the Definition 1 argument of §3;
- A9 §9.3(b) preservation holds, because S = S_Y × Z and the safe mass is
  retained.

K3 is the pure case: Y is trivial, and the transition is the fair product law.

## 7. Scope ledger (A9 → v4.1)

| Item | A9 (v3, adopted) | v4.1 |
| --- | --- | --- |
| Uncoordinated stationary Nash | OPEN in general; holds under (FLF) | **Holds in thermal worlds with finitely many players**: Θ1(a), Θ2(a), Θ-P. Premises: PO, fresh atomless next-z, the stipulated noise model. Still OPEN without such a fluctuation. |
| The thermodynamic bridge | none | **Lemma TS** (sharp in the continuous class). Under Setting T it gives (AC) and (NC). It gives (EC) and (NC′) **when Q₀ is additionally jointly weakly continuous**. **[D41-2]** It gives neither (FC) nor a profinite topology. **[R2]** |
| Almost-sure preservation | under exact one-step safe mass | Θ1: almost sure under a **bounded wrapped displacement law with margin ≥ radius**. Θ0: **impossible** under full-support displacement. Θ2: **exponential lower bound** on mean survival time under Gaussian noise. **[R1, R6]** |
| Finite-shadow convergence | Conjecture T4.3-L | C's T4.3-L(EC) on profinite X, with C's constants corrected (ERRATA-C). Not claimed on tori. |
| GLOBAL / BRIDGE / universality | OPEN | OPEN (untouched) |

## 8. Side repair for the derivation lane: the sharp D91 bound

The deposited boxed bound (EQ-11499) s(1−s)/(1+κs) ≤ 1/(4κ) is false. At
s = ¼, κ = 4 the left side is 3/32 and the bound is 1/16. The **sharp** bound is

    s(1−s)/(1+κs) ≤ 1/(1+√(1+κ))²   for s ∈ [0,1], κ ≥ 0,

with equality at s = 1/(1+√(1+κ)).

*Proof.* Put t = √(1+κ). Then

    (1+t)^{−2}(1+κs) − s(1−s) = (1−(1+t)s)²/(1+t)² ≥ 0.

Codex verified the identity, the optimiser and the asymptotics (T4-17). The
bound is at most ¼, and it expands as 1/κ − 2/κ^{3/2} + O(κ^{−2}). The
generalised bound EQ-11548 is **not** repaired here.

## 9. Finite witnesses

`work/check_thermal_worlds.py` is unchanged from v4. Codex replayed it
byte-identically in fresh copies (T4-1). Codex also ran independent checker
groups:

- `continuous_TS_sharpness`;
- `TV_normalization`;
- `unbounded_noise_counterexample`;
- `state_EC_counterexample`.

Its independent mutations include one real survivor, recorded in T4-16. These
are finite shadows. They prove no theorem.

## 10. Citations: checked and owed

- **He–Sun 2017.** §2, Definition 1, Theorem 1 (quoted, PDF p. 14), n. 16 (the
  TV convention) and Proposition 2. Read by Claude and, independently, by
  Codex.
- **Duggan 2012.** Codex checked the available primary source for this product
  case (T4-5). The final journal wording has not been checked.
- **Standard results:**
  - the W^{1,1} translation inequality: Codex replaced the duality locator
    with a direct coupling proof;
  - the Gaussian Chernoff tail;
  - the Carathéodory joint-measurability argument.
- **Physics premise:** the Einstein relation.

## 11. Remaining gates

1. **A delta read of the v4.1 changes by a non-author.** Codex itself, on the
   changed passages only, is acceptable.
2. **GLM's adoption decision**, as framework author.
3. **No deposit before (1) and (2).** Any deposit must carry the Codex review
   bank alongside it.

## 12. Review disposition

| Codex finding | Codex v4 verdict (historical) | Author's proposed v4.1 response |
| --- | --- | --- |
| T4-1 replay | PASS | §9 |
| T4-2 Theorem 1 and finite players | REVISE | §1 finite I; §3 Theorem 1 quoted [R3] |
| T4-3 joint density | PASS (proof supplied) | Corollary TS(i) construction [R3] |
| T4-4 no G-atom | PASS (proof supplied) | §3 completed check [R3] |
| T4-5 Duggan product case | PASS | §3, §10 |
| T4-6 TS sharpness | PASS (needs a continuous witness) | §2 trapezoid witness; coupling proof [R4] |
| T4-7 TV normalisation; C's factor 2 | REVISE (C) | §2 convention; ERRATA-C [R4] |
| T4-8 bounded-noise preservation | PASS | §3(b) |
| T4-9 Θ0 policy quantifier | PASS (clarify) | §1, §4 "respects the transition model" [R6] |
| T4-10 "unbounded noise" | **REFUTED as quoted** | §4 consequence rewritten; §3 remark on wrapped laws [R1] |
| T4-11 Θ2 bounds | PASS | §5 |
| T4-12 summary drops the EC premise | **REFUTED (summary)** | §0, Corollary TS(ii), §7 [R2] |
| T4-13 clause inventory | REVISE | §4 inventory paragraph [R1] |
| T4-14 Θ-P safe mass; physical reading | REVISE | §6 safe mass [R5]; §0 and §5 "lower bound" wording [R6] |
| T4-15, T4-16 witnesses and mutations | PASS | §9 |
| T4-17 D91 | PASS | §8 |

This table is a historical mapping of the v4 review. It is not evidence that
the six requirements are discharged; §13 records the delta read that checked
that.

## 13. Delta-read disposition (Codex, bank `96fe948a…`, verdict REVISE)

| Codex delta finding | Codex verdict | v4.2 correction |
| --- | --- | --- |
| T41-1: R1 overstates necessity ("needs") | REVISE | §4: changed to "one sufficient case"; the margin is not necessary (two-bump example) [D41-1] |
| T41-2: R2's "only when / only if" | REFUTED (literal necessity) | §0, Corollary TS, §7: changed to "when … additionally". The T4-12 counterexample is now tied to its localised bump [D41-2] |
| T41-3: R3's quantile domain and infinity set | REVISE | §3: a(y) = 0 on zero-mass fibres and t ∈ [0,1]; Corollary TS(i): pointwise jointly Borel replacement [D41-3] |
| T41-4: carry 2M through C line 114 | REVISE | ERRATA-C extended [D41-4] |
| T41-5: R5 safe mass | PASS | unchanged |
| T41-6: R6 lower-bound and policy wording | PASS | unchanged |
| T41-7: §12 labels | PASS (relabel recommended) | §12 columns relabelled |

These corrections are author-side and have not been re-read. Codex's delta
read is not a new independent review of Codex's own replacement arguments.
| D42-5 (Theorem V review, Part B): the added viability iff | REVISE | §4 sentence replaced by the scoped existence statement and the admission condition; "mass near" wording [D42-5] (v4.3) |
