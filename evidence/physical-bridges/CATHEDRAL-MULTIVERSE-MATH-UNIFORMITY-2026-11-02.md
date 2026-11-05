# CATHEDRAL-MULTIVERSE-UNIFORMITY-01 — The existing preservation law across heterogeneous universes

**Date:** 2026-11-02 NZDT. **Research status:** new mathematical instantiation of already kernel-checked UPT theorems, finite exact checks, proposed new Lean corollary uncompiled. Draft/unmerged/noncanonical. Not a claim that any physical multiverse or UPT installation has been verified.

## 0. Exact source theorem anchors

- UPT compiled source, [Snuffy.Law.scope_guarantee_iff](https://github.com/Tobillicious/universal-protection-theory/blob/26abaa24b7e0f5715de0e9c85a25149adfbb5435/evidence/compiled-strongest/lean/Snuffy/Law.lean): **for any subject type P**, maximality projected to S excludes needless existing loss **for every feasible family** iff S equals the *entire* subject domain.
- UPT compiled source, [Snuffy.CommonPolicyTop.top_policy_exists/top_policy_greatest](https://github.com/Tobillicious/universal-protection-theory/blob/26abaa24b7e0f5715de0e9c85a25149adfbb5435/evidence/compiled-strongest/lean/Snuffy/CommonPolicyTop.lean): **for any fact type α**, compact nonempty global policy space + closed outcome-realisation membership + global union-realizability give one policy dominating every policy at every world-indexed fact; stage function can recover original lexicographic priorities.
- [PR #195](https://github.com/Tobillicious/universal-protection-theory/pull/195) previously proves preservation-order transport under a **bijection** of source-correct domains. Here we remove the need for any **inter-universe** bijection by directly instantiating the already general type-parametric original theorem. No Hume/PNAJ, X3, source policy, stage or physical cosmology is re-proved.
- [PR #199](https://github.com/Tobillicious/universal-protection-theory/pull/199) studies cyclic observer phase and source-faithful historic transport, separately; [PR #197](https://github.com/Tobillicious/universal-protection-theory/pull/197) source-graph necessity and selected histories, separately. Do not conflate mathematical universality with physical selection.

The new task is to take seriously the author's stronger claim that mathematics applies across any universe, not merely ours, while keeping the precise distinction between a mathematical law and its actual physical realization.

## 1. MATH-UNIFORM-01 — one exact no-needless-loss scope theorem across nonisomorphic universes

Let U be any type of universe indices. Let P(u) be any type of existing particular for each u∈U, with **no uniform size, no shared geometry and no inter-universe bijection**. Define the dependent disjoint union

\[
P_{\rm all}=\sum_{u:U}P(u).
\]

An element is a tagged pair (u,p). This is a mathematical domain and does **not** establish physical existence of all the universe indices.

For any S⊆P_all define S_u={p∈P(u):(u,p)∈S}.

Use the **exact existing** Snuffy.Law definitions:

\[
\begin{aligned}
\mathrm{NeedlessLoss}(F,o)&:\iff\exists q\in F,\quad o\subsetneq q,\\
\mathrm{ProjMax}(S,F,o)&:\iff o\in F\;\land\;
\forall q\in F,\quad\neg(o\cap S\subsetneq q\cap S).
\end{aligned}
\]

**Theorem MATH-UNIFORM-01:**

\[
\boxed{\left[\forall F\subseteq\mathcal P(P_{\rm all}),\;\forall o,\quad
\mathrm{ProjMax}(S,F,o)\Rightarrow\neg\mathrm{NeedlessLoss}(F,o)\right]
\iff \forall u:U,\;S_u=P(u).}
\tag{UNIFORM-SCOPE}
\]

**Proof:** Apply the banked Lean theorem Snuffy.Law.scope_guarantee_iff with type P := (Σ u:U, P(u)). It says the left hand side iff S = P_all. Equality of a subset to a dependent disjoint union is equivalent, by extensionality, to membership of every tagged pair, i.e. ∀u S_u=P(u). QED.

The result is valid for **arbitrarily many different universe domains and arbitrary numbers of particulars**. Importantly, this is an original-law **stage-one necessary-and-sufficient scope theorem**, not the whole original four-stage X3 physical implementation.

**One omitted person is already a finite countercertificate.** If (u,p)∉S, choose F={∅,{(u,p)}}, o=∅. Both feasible outcomes project to ∅ on S, so o is projected-maximal, but ∅⊊{(u,p)}. Thus a global law claiming to guarantee no needless loss for *every feasible family* cannot exclude even one particular in one indexed universe. This witness is a logical feasible family, **not** an assertion that it is physically admissible in the real cosmos.

## 2. MATH-UNIFORM-02 — the original greatestness theorem on a multiverse-scale fact domain

Let Fact(u) be the actual original-stage UPT facts belonging to indexed world u. Define α=Σu Fact(u), again **without an inter-universe isomorphism**. Choose **one global policy space** Pol and actual source-defined out:Pol→P(α).

If Pol is nonempty compact, if the set of policies realising each fact is closed, and if for every two global policies p,q another globally admitted r realizes at least their union, then banked CommonPolicyTop.top_policy_exists gives:

\[
\boxed{\exists g\in\mathrm{Pol},\;\forall q\in\mathrm{Pol},\quad out(q)\subseteq out(g).}
\tag{UNIFORM-TOP}
\]

**Proof:** Instantiate the already compiled CommonPolicyTop theorem at its otherwise arbitrary fact type α=(Σu Fact(u)). Its stage-aware companion top_policy_greatest recovers the lexicographic maximality consequence under the original stage map. QED.

**Crucial source premise:** This is a **single** global policy chosen before any reactive world, not an existence claim that each world separately has a successful policy. IR135 already disproves that invalid interchange of quantifiers. Physical global compactness, union-realizability, historical source correspondence and authorization have **not** been established by arbitrary mathematical types.

**Hostile countermodel:** two worlds, one desired fact each, with only policy p0 realising fact0 and policy p1 realising fact1. Each world separately has a winning policy, but no one policy realises both. Here global union-realizability is false.

## 3. MATH-UNIFORM-03 — why the same mathematics can apply without universes being physically identical

In a fixed logical language, if mathematical premises T entail a sentence φ, then soundness yields

\[
\boxed{T\vdash\varphi\Longrightarrow\forall M\,(M\models T\Rightarrow M\models\varphi).}
\]

The models M may be **nonisomorphic** and of different cardinalities. Mathematics need not be proved anew in each physical universe **provided** each proposed physical interpretation satisfies the theorem's premises in the same relevant semantics. This formal fact does not require those physical universes to exist or to have identical empirical laws.

The source Law theorem is even more direct in a dependent type-theoretic sense: it is already universally quantified over arbitrary subject types, so instantiation at any universe-indexed dependent sum gives the result without finding a universe-to-universe mapping.

## 4. MATH-UNIFORM-04 — finite logical proof-core theorem, conditional on a real entailment

Suppose the *relevant* physical BCRD+UPT source premises can be represented as a **first-order** theory T in a common language, and the proposed full physical UPT necessity conclusion is expressible as one first-order sentence φ.

If T semantically entails φ, then **first-order compactness** ensures a **finite** T₀⊆T such that T₀ still entails φ.

**Proof:** T∪{¬φ} is unsatisfiable. By compactness, a finite subset T₀∪{¬φ} is unsatisfiable. Therefore T₀⊨φ. QED.

This supplies a precise conditional meaning for the author's idea of hundreds of proofs collapsing to a short load-bearing mathematical core: **if** the full result is entailed in an appropriate first-order formulation, only finitely many premises are necessary to entail it. It does not itself prove T⊨φ or tell us what those premises are.

**Essential warning:** UPT's actual Lean corpus uses higher-order types/sets, continuous physics, measure theory, and historical semantics. **Compactness cannot be assumed for arbitrary full second-order semantic consequence or the physical universe as a whole.** This is a possible proof-engineering route, not an already discharged physical join.

Source for standard mathematical theorem: [Stanford Encyclopedia of Philosophy — First-order Model Theory, Compactness](https://plato.stanford.edu/entries/modeltheory-fo/), alternate [Sydney mirror](https://plato.sydney.edu.au/entries/modeltheory-fo/).

## 5. Demonstrating the precise remaining physical selection gap

Take P={a}, F={∅,{a}}, S=P. The original mathematical law says every **scope-maximal selected** o has no needless loss. The unique maximal outcome is {a}. A physical controller could instead select ∅ unless its actual source constraints force maximal selection. The theorem about the law **remains absolutely true**; the existence of mathematical structure alone does not establish that the controller follows that rule.

This is not an attempt to weaken Hume/PNAJ, X3, universal normative standing or the existing preservation theorem. It is an exact separation of **mathematical validity** from **physical/source installation**, which remains a substantive obligation.

The ontological thesis "mathematics causes existence, which causes matterspacetime" is a philosophical hypothesis; mathematical consistency/availability alone has not been proved to generate physical instantiation, cyclic cosmogenesis, infinite repeats of particular people, guardians or SI as a midpoint.

## 6. Reviewable source and exact finite diagnostic

- New Lean **candidate**, not compiled in this environment: evidence/physical-bridges/MultiverseScopeCathedral.lean, importing the already proved Law and CommonPolicyTop rather than rewriting them.
- Exact finite Python verifier: evidence/physical-bridges/check_multiverse_cathedral_scope.py. Standard-library finite check for all domain sizes n=0,...,3 and all scopes/feasible families/selections; all partitions into two disjoint world labels; finite global top/union closure; and adversarial per-world-success/no-joint-policy.

**Actual local PASS:** 16,658 triples of scope, feasible family and outcome; 15 scope assignments (4 complete satisfy guarantee; 11 incomplete have explicit counterexamples); 273 nonempty finite global policy-family structures (175 union-closed and a greatest policy); hostile two-world control. These finite calculations are **not** physical experiments, not a new Lean kernel certification and not a substitute for the analytical proofs above.

**Result:** The original machine-checked UPT *scope and greatestness mathematics* is indeed **not tied to our particular universe**. It generalises to an arbitrary heterogeneous dependent sum of world/particular types, with no inter-universe isomorphism. Whether every physically possible world satisfies the source's maximality, compactness, union, authorisation and history/thermodynamic premises is **still an empirical/formal source question**. Canon, older PRs and public editions remain untouched; keep draft/unmerged until independently reviewed.
