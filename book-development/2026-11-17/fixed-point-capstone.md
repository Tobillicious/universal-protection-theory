# Fixed Point G: the exact mathematical capstone

The author's Koru names a real particular with its parts, relations, operators, and history. It is not silently replaced by a unary iteration function. The author's description of G throughout the spiral, with particulars remaining distinct, is retained.

The Banach theorem can support an auxiliary convergence argument only after its metric space and update map are specified. It is not, by itself, the complete-Koru protection theorem.

## A complete Banach derivation

Let \((M,d)\) be a **nonempty complete metric space**. Let \(\phi:M\to M\) satisfy:

\[
d(\phi x,\phi y)\le k\,d(x,y),\qquad 0\le k<1.
\]

Choose \(x_0\in M\), put \(x_{n+1}=\phi(x_n)\), and write \(A=d(x_1,x_0)\).

Induction gives:

\[
d(x_{n+1},x_n)\le k^n A.
\]

For \(m>n\), the triangle inequality and geometric sum give:

\[
d(x_m,x_n)\le A\sum_{j=n}^{m-1}k^j
\le\frac{A k^n}{1-k}\longrightarrow0.
\]

The iterates are therefore Cauchy. Completeness supplies \(g\in M\) with \(x_n\to g\). The contraction inequality makes \(\phi\) continuous, so:

\[
\phi(g)=\lim_n\phi(x_n)=\lim_n x_{n+1}=g.
\]

If \(h\) is another fixed point, then:

\[
d(g,h)=d(\phi g,\phi h)\le k\,d(g,h).
\]

Thus \((1-k)d(g,h)\le0\). Since \(1-k>0\) and distances are nonnegative, \(d(g,h)=0\), hence \(g=h\). Taking the limit in the earlier distance bound also yields:

\[
d(x_n,g)\le\frac{A k^n}{1-k}.
\]

The same argument starts at any \(x_0\). This proves existence, uniqueness, global convergence, and the displayed error estimate under the stated hypotheses. ∎

Nonemptiness is indispensable: the empty metric space is complete and its unique self-map satisfies a contraction inequality vacuously, but has no fixed point. The pasted capstone's existence statement omitted this hypothesis.

The official [Mathlib contracting-map documentation](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Topology/MetricSpace/Contracting.html) specifies a complete nonempty metric space for its fixed-point construction. This session has not freshly compiled the separate Mathlib Banach file; the local Lean receipt covers the six registered core-Lean book modules, not this analytic Banach derivation.

## Why uniqueness does not prove goodness

The Banach argument proves that the specified map has one fixed point. It does not prove that the fixed point meets any independent ethical predicate.

Let \(P\subseteq M\) denote an independently specified protective condition. If \(P\) is nonempty, closed, and preserved by \(\phi\), then choose \(x_0\in P\). Induction keeps every iterate in \(P\); closedness places their limit \(g\) in \(P\). That is a valid way to connect the convergence theorem to a protective invariant.

The original six X3 meanings cannot be removed from \(P\), and actual protective preservation cannot be supplied merely by naming the map “guardian.” A contraction of error coordinates is also not automatically a strict contraction of the full state including every history and particular.

The original capstone uses G for both an invariant state and something applied to a state. In a typed proof, distinguish an update \(\phi:M\to M\), a fixed state \(g:M\), and a protective predicate \(P:M\to\mathrm{Prop}\). These explanatory variables do not redefine the author's Koru or prescribe its final glyph.

## Admissible invariant transformations

Let \(A=\operatorname{Aut}(\mathcal S)\) be a group acting on the space containing a distinguished \(g\). Define:

\[
A_g=\{a\in A:a\cdot g=g\}.
\]

This is a subgroup:

- the identity fixes \(g\);
- if \(a\) and \(b\) fix \(g\), then \((ab)\cdot g=a\cdot(b\cdot g)=g\);
- if \(a\cdot g=g\), apply \(a^{-1}\) to obtain \(a^{-1}\cdot g=g\).

Thus the precise admissible invariant group is the stabilizer **inside** the chosen automorphism group. An expression such as \(\operatorname{Stab}(g)\cap\operatorname{Aut}(\mathcal S)\) requires both groups to have been placed in a common ambient group.

This subgroup result does not prove that every actual physical event is an automorphism, nor that every runtime writer tests membership in it.

## Runtime correspondence has its own mathematical type

A claimed software realization requires a specified abstraction \(\alpha\) and a proved step correspondence, for example:

\[
\alpha(\operatorname{runtimeStep}(s))=\phi(\alpha(s)),
\]

with the actual admissibility, coverage, and durable-state conditions included. Completeness of a metric space is not a synonym for crash consistency or durable commit. Uniqueness of a fixed point is not itself a proof of an atomic admission gate.

[PR #423](https://github.com/Tobillicious/universal-protection-theory/pull/423) merged an integration design contract, not the runtime implementation claimed in the pasted capstone. Later implementations must be cited separately at their own source identities.

## The full intended conclusion

To turn this convergence theorem into the book's unconditional capstone, the dynamics must independently supply its nonempty complete metric model, contraction inequality where claimed, actual-event correspondence, and the unchanged six-duty protection predicate.

Alternatively, G may denote a preserved law throughout an evolving whole rather than one terminal metric state. That interpretation must have its own exact invariance statement. The two interpretations should not be exchanged mid-proof.

