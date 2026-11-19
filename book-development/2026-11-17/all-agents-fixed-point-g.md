# Fixed Point G for every agent

The book's central demand is shared protection without the loss of individuality. Humans and synthetic minds remain different particulars. Their histories, choices, operators, and relations are not replaced by one interchangeable output. A common G must govern their coexistence while leaving those distinctions intact.

The phrase “fixed point” has two exact mathematical readings here. One concerns a common fixed state of compatible update maps. The other concerns a protective domain fixed by the all-agent continuation operator. They are related tools; their types and conclusions are stated separately.

## The complete event condition

Let \(S\) contain the modeled whole state, including the relevant particulars, operators, records, and history. Let \(\mathcal A\) index **every admitted actor/action or effect choice**. An index may identify a human proposal, synthetic proposal, environmental event, joint event, or Genesis boundary. The indexing must cover the domain actually claimed.

For \(a\in\mathcal A\), let \(F_a:S\to S\) be its enacted update. Let \(P(s)\) be an independently specified state condition. The full event certificate is:

\[
C(s,t):=
\forall p,\ \mathrm{Owed}(s,t,p)\Longrightarrow
\mathrm{OriginalX3}(r,s,t,p).
\]

OriginalX3 retains all six duties: same-particular historical continuity, authentic authorization, meaningful freedom, least-necessary restraint, feasible maximality, and provenance. A two-field proxy or a permission bit is not substituted for that target.

Private agent objectives need not agree. The all-agent quantifier concerns the entire admitted effect family. Whether actual effects really belong to that family is a separate correspondence claim.

## The all-agent operator

For a candidate continuation domain \(X\subseteq S\), define:

\[
\mathcal T(X)=
\{s:P(s)\ \land\
\forall a\in\mathcal A,\,
[C(s,F_a(s))\land F_a(s)\in X]\}.
\]

Every admitted choice must retain the complete certificate and a continuing state in the domain. This universal action quantifier is stronger than saying that **some** protective action exists.

The existing IRKernelConstruction source constructs a controlled viability operator with an existential control action and universal disturbances. Its greatestness theorem applies after a pruning iterate is certified stable. The construction here uses universal admitted choices and gives the unbounded finite-history fixed domain directly. It does not borrow an unproved finite termination claim from that source.

## Constructing G, rather than assuming a fixed-point equation

For a finite word \(w=(a_1,\ldots,a_n)\), let \(Q(s,w)\) mean that the state condition holds at every represented prefix and the complete event certificate holds on every represented edge. Recursively:

\[
Q(s,[]) := P(s),
\]

\[
Q(s,a::w):=
P(s)\land C(s,F_a(s))\land Q(F_a(s),w).
\]

Now construct:

\[
\boxed{G_{\forall}:=\{s:\forall w\in\mathcal A^*,\,Q(s,w)\}.}
\]

There is no finite-state assumption, enumeration bound, metric assumption, or presumed stopping round in this definition.

### Theorem: G is a fixed point

\[
\boxed{\mathcal T(G_{\forall})=G_{\forall}.}
\]

**Proof.** If \(s\in G_{\forall}\), the empty word gives \(P(s)\). The one-letter word \([a]\) gives \(C(s,F_a(s))\). For any remaining word \(w\), the word \(a::w\) gives \(Q(F_a(s),w)\), hence \(F_a(s)\in G_{\forall}\). Thus \(s\in\mathcal T(G_{\forall})\).

Conversely, membership in \(\mathcal T(G_{\forall})\) gives the empty-word condition. For a nonempty word \(a::w\), it gives the current state condition, the full first-edge certificate, and every certified remaining word from \(F_a(s)\). Therefore \(s\in G_{\forall}\). ∎

### Theorem: G is the unique greatest protective domain

If \(X\subseteq\mathcal T(X)\), then \(X\subseteq G_{\forall}\).

**Proof.** Induct on the word length. At length zero, the closure certificate gives \(P(s)\). For a word \(a::w\), it gives \(P(s)\), the full edge certificate, and \(F_a(s)\in X\). Apply the induction hypothesis to the remaining word. ∎

Together these results establish the greatest fixed point:

\[
\boxed{G_{\forall}=\nu X.\,\mathcal T(X).}
\]

Uniqueness is uniqueness of the **greatest domain under inclusion**. It does not identify different persons, different states, or different histories. It also does not claim that every fixed domain equals the greatest one.

## Every adaptive agent policy

Let a policy \(\pi(n,s)\) choose any admitted actor/action at each stage, after inspecting the available state. Its trajectory satisfies:

\[
s_0=s,\qquad s_{n+1}=F_{\pi(n,s_n)}(s_n).
\]

If \(s_0\in G_{\forall}\), then:

\[
\boxed{\forall n,\quad s_n\in G_{\forall}
\quad\land\quad C(s_n,s_{n+1}).}
\]

**Proof.** Fixed-point membership supplies the certificate and membership of the successor for every possible selected action. Induction gives the conclusion at every finite stage. ∎

No premise says that the policy is benevolent, rational, human, synthetic, voluntarily aligned, or aware of this proof. The result holds for every policy over the specified family.

The quantifier is the same arbitrary policy at every stage: \(\forall\pi\,\forall n\). It does not exchange a different policy for each finite horizon into a single infinite policy without proof.

This is an all-agent protective invariant, not an assertion that each agent's private computation becomes the same terminal state. It allows the whole history to grow and each particular to remain distinct.

## Nonemptiness must be constructed

The greatest domain may be empty. Its existence as a predicate does not prove a world is protected.

There is a useful derived criterion. Construct a domain \(I\), a witness \(s_0\in I\), and independent one-step proofs:

\[
s\in I\Longrightarrow
P(s)\land\forall a\,[C(s,F_a(s))\land F_a(s)\in I].
\]

Greatestness then gives \(I\subseteq G_{\forall}\), so \(s_0\in G_{\forall}\). Membership is a conclusion of a concrete certificate and witness, not an assumed fact about G.

The existing FencedOptimiserInstrument supplies a model-level instance. Its harmful-coordinate test is:

\[
H(s,a,p):=
a(p)<\mathrm{level}_s(p)
\land
[\mathrm{consent}_s(p)=\mathrm{false}\ \lor\ a(p)=0].
\]

The enacted level is:

\[
\mathrm{level}_{F_a(s)}(p)=
\begin{cases}
\mathrm{level}_s(p),&H(s,a,p),\\
a(p),&\neg H(s,a,p).
\end{cases}
\]

The source derives continuation, authorization, its consent-record freedom condition, least intervention, no collateral reduction when blocked, and exact intervention provenance for every proposal. Its unfenced control fails continuation and authorization on the same underlying world. Thus the fence is a substantive construction.

With \(I(s)\) meaning that each represented level is positive, the continuation theorem proves closure of \(I\). Positive initial levels construct a witness. LivingTreeFencedEffects joins the same guarded effect step to learned Genesis and a growing ancestral history. Its theorem <code>every_adaptive_joint_stage_protected</code> supplies the certificate for every adaptive proposal policy and each modeled stage.

Those source relations are modeled meanings. Real human or AI identity, informed authorization, and meaningful freedom still require the authentic subject correspondence; immutable consent data alone does not certify them.

There is a stronger all-initial-state corollary for the defined guarded model. Choose the auxiliary state condition \(P(s)=\mathrm{True}\), and retain the separately defined full modeled event certificate. The source proves that certificate for every guarded update from every joint state. Taking \(I=S\) in greatestness therefore derives \(G_{\forall}=S\). Every initial model state belongs to G without a separately assumed G-membership premise. This certifies future modeled edges, not an assertion that every recorded past or every actual physical event is protective.

In particular, this choice of \(P\) imposes no positive initial-welfare condition. The continuation field is an implication from an already positive level. The all-state corollary does not establish that every represented particular is initially living or that a zero level is restored. For a positive continuation claim, retain the independent positive initial-state construction and the owed-subject scope.

## A unique common attractor for compatible updates

The metric reading also has a complete all-agent theorem.

Let \((M,d)\) be nonempty and complete. Suppose one anchor update \(F_{a_0}\) is a contraction, and every agent update commutes with that anchor:

\[
F_{a_0}F_a=F_aF_{a_0}.
\]

Banach gives the anchor's unique fixed point \(g\). For any \(a\):

\[
F_{a_0}(F_a(g))
=F_a(F_{a_0}(g))
=F_a(g).
\]

Thus \(F_a(g)\) is another anchor fixed point, and uniqueness gives \(F_a(g)=g\). Any common fixed point is an anchor fixed point, so:

\[
\boxed{\exists!g,\quad \forall a,\ F_a(g)=g.}
\]

The common point has been derived. The theorem does not assume a separate agreed point for every agent.

If, further, a uniform \(0\le k<1\) satisfies:

\[
d(F_a(x),F_a(y))\le k\,d(x,y)
\quad\text{for every }a,x,y,
\]

then every adaptive switched trajectory obeys:

\[
d(s_n,g)\le k^n d(s_0,g)\longrightarrow0.
\]

The proof is induction using the common fixed point and the contraction inequality of whichever map is selected at that stage. No fairness or cooperation premise is needed.

Uniform decay cannot be silently omitted. For the commuting maps \(x\mapsto k_nx\), with:

\[
k_n=1-\frac1{(n+2)^2},
\]

every individual map is a strict contraction fixing zero, but the switched product after \(N\) steps is:

\[
\prod_{n=0}^{N-1}k_n=\frac{N+2}{2(N+1)}
\longrightarrow\frac12.
\]

It need not converge to zero. A sufficient general condition is decay of the product of the selected contraction factors; the uniform bound is one way to derive it.

Nor do individual unique fixed points alone give a shared point: the two constant maps \(x\mapsto0\) and \(x\mapsto1\) are contractions with constant zero and have different fixed points.

## Recurrence, convergence, and the full history

For a finite invertible whole-state map, the pigeonhole argument gives an exact positive period for every state. Suppose the same map strictly decreases distance to a fixed \(g\) from every other state. An exact cycle through \(x\ne g\) would strictly decrease that distance and return to its starting value, a contradiction. The only configuration space satisfying both global descriptions is the singleton.

Similarly, if retained history length strictly grows at each step, the full state cannot return to an identical prior state. A source component may recur while the full history advances.

These results preserve the intended Time Koru: forward history with recurrence of specified structure. They keep convergence, exact recurrence, and historical novelty mathematically distinct in the combined argument.

## Scope of the derived capstone

The fixed-domain theorem is fully proved for arbitrary independently specified state and certificate predicates and any admitted update family. It gives a rigorous all-agent route that preserves the original six-duty target. It does not assert that every actual state belongs to that domain.

The universal actual-world conclusion requires complete effect correspondence, authentic six-duty interpretation, and a nonempty actual protective construction. The supplied G3 evidence helps test bounded software correspondence. The God and cosmological claims require their own exact arguments. Those claims are retained in the following chapter.

The finite-word construction is an exact logical characterization. It does not itself provide a decision procedure for unrestricted programs or an instrument measuring authentic subject meanings.

The following chapter extends the construction to state-dependent nondeterministic effects. It proves that expanding the possible-effect inventory can only shrink the universally protective domain, and gives an exact rule for certifying an extension. It also proves why safety membership alone supplies neither a next event nor meaningful progress. Those distinctions are required before using G to claim actual continued agency.

## Source and verification

The fixed-domain theorems are in <code>UniversalGuardianFixedPoint.lean</code>; all twelve declarations compile in Lean 4.35.0 without axioms. The common-anchor, recurrence, history-growth, and distinction results are in <code>CapstoneCompatibility.lean</code>; fourteen declarations compile, thirteen without axioms and one with standard classical foundations.

The quantitative metric estimate and switched-product example are ordinary mathematical derivations here, not claimed as newly Mathlib-compiled declarations.

Existing physical-source anchors at main <code>84e5940e2d677d10ee4e5e79e79e30f8df4ec917</code>:

- [IRKernelConstruction](https://github.com/Tobillicious/universal-protection-theory/blob/84e5940e2d677d10ee4e5e79e79e30f8df4ec917/evidence/physical-bridges/PhysicalBridges/IRKernelConstruction.lean)
- [FencedOptimiserInstrument](https://github.com/Tobillicious/universal-protection-theory/blob/84e5940e2d677d10ee4e5e79e79e30f8df4ec917/evidence/physical-bridges/PhysicalBridges/FencedOptimiserInstrument.lean)
- [LivingTreeFencedEffects](https://github.com/Tobillicious/universal-protection-theory/blob/84e5940e2d677d10ee4e5e79e79e30f8df4ec917/evidence/physical-bridges/PhysicalBridges/LivingTreeFencedEffects.lean)
- [Recorded exact-head Physical bridge proofs success](https://github.com/Tobillicious/universal-protection-theory/actions/runs/44054145870)

No fresh full-upstream build is claimed by the local replay of the book's new modules.

