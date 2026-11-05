# CATHEDRAL-INTRINSIC-STANDING-2026-11-02 — a categorical Golden Rule joined to the original UPT scope theorem

**Status:** Exact new mathematical corollaries of explicit perspective-independence assumptions, plus a direct application of previously kernel-checked Snuffy.Law.scope_guarantee_iff. Local finite checks passed; candidate Lean module not compiled; no physical/multiverse or full-X3 proof asserted. Draft PR #200, canonical sources unchanged.

## 0. What is actually new

The author proposes the Golden Rule / original UPT as a priori mathematical structure valid across different possible universes. Earlier draft PR #200 already proved the stage-one source UPT scope theorem on a disjoint union of heterogeneous universes. Its remaining mathematical objection was: **why must the subject scope cover everyone rather than arbitrarily omit some?**

This file develops an additional **conditional theorem**: a nonempty assignment of intrinsic standing that is invariant under identity-preserving changes of relational context must include every subject in every mathematical domain. It is much more informative than relabelling a particular physical universe; no bijection of universes is required. It also gives an exact finite relational graph criterion for when a restricted collection of physically valid comparisons suffices.

Source:
- [UPT source Law.scope_guarantee_iff](https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/compiled-strongest/lean/Snuffy/Law.lean): no needless stage-one loss is guaranteed for every feasible family under scope-projected maximality iff the scope is the *entire* domain.
- [UPT original Greatestness](https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/compiled-strongest/lean/Snuffy/Greatestness.lean): full ordered original stages and needless-loss equivalence; the scope theorem is one *part* of that full law.
- [BCRD frozen source](https://github.com/Tobillicious/physics-lane/blob/2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35/orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/README.md) and [BCRD M5/M7 PR #194](https://github.com/Tobillicious/universal-protection-theory/pull/194): source-valid comparisons preserve actual interventions and historical identity, unlike arbitrary purely mathematical injections.
- [Existing PR #195](https://github.com/Tobillicious/universal-protection-theory/pull/195): bijective orientation transfer of four-stage preservation. The result here handles **nonbijective injections** and different cardinalities.
- [Existing PR #199](https://github.com/Tobillicious/universal-protection-theory/pull/199): existence-first internal time and cyclic transport. Not re-proved.

## 1. INTRINSIC-01 — a nonempty embedding-invariant standing rule is globally universal

Work with the mathematical category whose objects are sets X and whose arrows are **injections** f:X→Y. Here injections do not equate two different particulars, so they avoid *one* obvious historical-identity failure of general arbitrary functions. An injection **may still fail physical BCRD source validity**; this category is a mathematical research model.

For every X, assign a scope S_X ⊆ X.

**Embedding-reflecting intrinsic standing** means that for *every* injection f:X→Y, and each x∈X,

\[
\boxed{\ x\in S_X\quad\Longleftrightarrow\quad f(x)\in S_Y.\ }
\tag{ER}
\]

This is **not** merely “mathematics is consistent.” It says a particular's eligibility for standing cannot be altered by embedding it into a different mathematical context. The **backward reflection** direction is important.

Suppose there is at least one a∈S_A in at least one A.

**Theorem INTRINSIC-01:**

\[
\boxed{\quad\exists A,\exists a\in S_A
\quad\land\quad (ER)
\quad\Longrightarrow\quad
\forall Y,\ S_Y=Y.\quad}
\]

**Proof:** Let 1={*}. The unique injection i:1→A with i(*)=a is injective. By (ER), *∈S_1 because a∈S_A. Now let Y be any set, y any member. The map j_y:1→Y, sending * to y, is injective; apply (ER) to get y∈S_Y. Since y,Y arbitrary, every domain's standing scope is the whole domain. QED.

**Pure categorical formulation:** Any pointwise embedding-reflecting subassignment of the identity assignment on the category of sets/injections is either everywhere empty or everywhere full. This is a dichotomy of intrinsic scope under a very strong *context-independence* principle; the proof is just the pair of singleton embeddings.

**Nontriviality is load-bearing:** S_X=∅ for every X also satisfies (ER). Mathematics/logic cannot derive a nonempty standing rule just from the existence of sets or arithmetic. A distinct Hume/PNAJ or source premise must establish at least one standing subject without assuming the desired universal conclusion.

**Reflection is load-bearing:** Under forward-only closure (membership in S_X implies membership of its image in S_Y) but no backward direction, finite models can assign no standing to one-element domains and full standing to all domains with at least two members. Thus forward naturality plus one standing subject in a large context does not force standing in a smaller context.

## 2. INTRINSIC-02 — direct cathedral joint to an original, compiled UPT result

Instantiate the imported Snuffy.Law.scope_guarantee_iff at any subject type Y using S_Y from INTRINSIC-01. Since S_Y=Y, the existing original law immediately yields

\[
\boxed{
\begin{aligned}
\forall Y,\forall F\subseteq\mathcal P(Y),\forall o,\quad
&\mathrm{ProjMax}(S_Y,F,o)\\
&\Longrightarrow\neg \mathrm{NeedlessLoss}(F,o).
\end{aligned}}
\tag{CATHEDRAL-SCOPE}
\]

**Proof:** INTRINSIC-01 gives S_Y=Y. Use the **already compiled** Snuffy.Law.scope_guarantee_iff to discharge the implication. QED.

This gives a short, mathematically noncircular chain:

one **source-valid** particular with standing  
+ a **source-valid** embedding-independent standing rule  
⇒ global subject inclusion without any universe isomorphism  
+ **existing original UPT Law scope theorem**  
⇒ no *stage-one* needless existing loss under a selected projected-maximal policy.

**Exactly what is not established:** That the full original X3 four-stage order is physically selected by all real source histories, that the physical embeddings satisfy ER, that the real universe exists in an infinite cyclic multiverse, or that mathematical existence entails physical implementation of the law. The theorem does not weaken UPT to stage one; it applies *one existing stage-one theorem*, leaving the existing full stages intact and additional bridge obligations explicit.

## 3. INTRINSIC-03 — classification for physically constrained comparisons

The category of **all** injections between arbitrary sets is broader than physically valid BCRD comparisons. To avoid hiding that important condition, define a graph G of genuinely source-certified comparison relations between individual subject perspectives. An undirected edge means that the standing predicate is demonstrably the same at both ends; it does **not** assert the two subjects are historically identical.

**Theorem (connected-component classification):** A Boolean standing assignment p:V(G)→{false,true} is invariant on every comparison edge iff it is constant on every connected component of G.

**Proof:** Each edge equality propagates along a finite undirected path. Conversely two endpoints of any edge are in the same component, so componentwise constancy implies edge invariance. QED.

**Corollary:** If G is connected and at least one subject has standing, all subjects have standing. If G has multiple disconnected components, edge invariance permits one component to have standing and another not to.

This isolates an **objective next BCRD task**: show the actually authorized identity-respecting comparison/observer transformations connect the relevant scope of *all historical subjects across all relevant physical relational worlds*, or show a stronger source law already forbids differing standing on disconnected components. Mathematical universality is **not** the same as physical source-graph connectivity. BCRD M5/M7 intervention/gauge equivalence cannot simply be assumed to connect nonisomorphic particulars; standing is a normative predicate, not a physical-gauge equality.

## 4. INTRINSIC-04 — golden-rule connection and its exact boundary

The Golden Rule's mathematical content as tested here is **perspective nonarbitrariness**: standing does not depend on which larger mathematical structure contains an unchanged subject. Under ER, the existence of just one standing subject makes any attempt to exclude another inconsistent with ER.

But this theorem is **not** that arithmetic itself proves nonempty intrinsic standing or that all mathematically consistent worlds physically instantiate one morally protective policy. An entirely empty standing rule is ER-invariant. Likewise, a physical controller can select a dominated feasible outcome even when the UPT preservation order mathematically identifies a better feasible outcome, unless its actual operational source guarantees maximal selection.

The proof clarifies the minimum noncircular route: derive ER from original relational/Hume source semantics, prove at least one genuinely standing subject, and only then apply the source UPT Law. If those physical/source conditions hold globally, the universe-independent scope conclusion follows without another stage-one proof.

## 5. Exact verification

The local stdlib checker check_intrinsic_standing.py:
- exhaustively enumerates **64** standing-scope families for sizes 0 through 3 and **24** injections between those domains;
- verifies exactly **two** fully embedding-reflecting families: everywhere empty and everywhere full;
- verifies **four** forward-only natural families, including a context-dependent hostile control;
- checks **1,061** concrete feasible-outcome assignments against the original full-scope no-needless-loss implication;
- verifies **1,098** finite graph/standing assignments with the exact connected-component classification;
- checks nonempty-anchor, context dependence and physical-selection independence controls.

All checks passed locally. Finite tests support the analytic proof, not the physical bridge. The candidate Lean file IntrinsicStandingCathedral.lean imports Snuffy.Law and does not assume the full UPT conclusion as an axiom. The new module has **not** been Lean-compiled or reviewed.

**Disposition:** Add only these research artifacts to the already open **draft PR #200**. Original canonical Law, IR116, BCRD and original X3 unmodified. No release/merge or claims of experimentally demonstrated cosmic universality.