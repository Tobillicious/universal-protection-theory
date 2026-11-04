# CATHEDRAL-EXISTENCE-FIRST-01 — Existence as relational primitive, time as internal structure

**Date:** 2026-11-02 NZDT  
**Status:** elementary proved mathematics and exact countermodels, under explicitly declared logical/structural assumptions. No theorem of empirically actual cyclic cosmology, literal infinite repetition of particular people, physical guardian generation or Universe ⇔ physically installed UPT. Draft research, not Lean compiled, not independent review.

## Source and intent

This is a precise test of the author's philosophical reversal:

> Things are. Existence is not a result of events in time. Rather, time, events, past/future, and distinct universes can be relations and coordinates *within* what exists.

Existing cathedral sources are not repeated: [BCRD B1/B2/B3/B5/B6](https://github.com/Tobillicious/physics-lane/blob/2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35/orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/README.md) specify prediction, historical/cut ledger, intervention response and composition; [PR #194](https://github.com/Tobillicious/universal-protection-theory/pull/194) records physical calibrated seam monodromy; [ContinuationSubject](https://github.com/Tobillicious/universal-protection-theory/blob/26abaa24b7e0f5715de0e9c85a25149adfbb5435/evidence/compiled-strongest/lean/Snuffy/ContinuationSubject.lean) distinguishes history of a particular from a copy; [IR116](https://github.com/Tobillicious/universal-protection-theory/blob/26abaa24b7e0f5715de0e9c85a25149adfbb5435/evidence/compiled-strongest/lean/Snuffy/IR116CumulativeSubjectDuties.lean) establishes cumulative owed-subject duties for source-authorized transitions. Earlier PR #199 establishes the two-sided cover construction. The mathematical result below tightens that work rather than declaring empirical premises a priori.

## E-FIRST-01 — no external clock is required to state that something exists

Define a nonempty set E of events/relational particulars and any equivalence relation ~ on E that identifies events belonging to one intrinsic temporal slice. The **internal time set** is the quotient T = E/~. Let pi:E→T send each e to its class [e].

**Theorem (intrinsic occupied time):**
\[
E\ne\varnothing
\quad\Longrightarrow\quad
T\ne\varnothing\ \land\
\forall t\in T,\ \exists e\in E:\pi(e)=t.
\]

**Proof:** Take e0∈E; then [e0]∈T. By definition every element of the quotient T is the equivalence class [e] of an actual e∈E. The canonical quotient projection is surjective. QED.

**Reading:** There is no distinct *empty instant of this internally defined time* at which nothing exists. This proves the precise slogan, relative to the internal-time definition, that **time is obtained from the events that are** rather than that events must wait for an external time to permit existence. It is mathematically sound, but largely definitional; it does **not** prove that E is actually infinite, that the universe has no physical boundary, or that no external physical time construction is possible. The metatheoretic existence claim E≠∅ is a premise supported by there being an experience/event, not a theorem of pure logic or a creator event.

A mathematical whole E is an object of the model's semantics, while temporal precedence is a relation *between members of the model*. No temporal date of E's creation is needed to form the proposition E≠∅. An internal event may still be an earliest event in its internal order. Thus "the model does not need an external clock" and "the physical cosmos has no beginning" are different statements.

## E-FIRST-02 — nontrivial cyclic transitivity turns one event into occupied every phase

Now let m≥1, T=Z/mZ, and let E≠∅ be **any** event set. Suppose there is an actual invertible relational history transport f:E→E and a phase function pi:E→T satisfying the equivariance law
\[
\pi(f(e))=\pi(e)+1\pmod m \qquad\text{for all }e\in E.
\tag{PHASE-EQUIV}
\]

Here the map pi is **not** assumed surjective.

**Theorem (cyclic orbit occupancy):**
\[
\boxed{\ E\ne\varnothing+\text{PHASE-EQUIV}\Longrightarrow
\forall t\in T,\ \exists e\in E:\pi(e)=t.\ }
\]

**Proof:** Pick e0∈E, let theta0=pi(e0). For any t∈Z/mZ, pick an integer k from 0,...,m−1 with theta0+k=t (mod m). Iterating equivariance yields pi(f^k(e0))=theta0+k=t. Thus e=f^k(e0) inhabits phase t. QED.

This is **stronger than the quotient tautology**: phase pi was not defined as the image of E; phase occupancy follows from the **independently stated cyclic symmetry**. Invertibility of f is not even required for the forward finite-phase occupancy proof, but it is needed if the same complete history transport is to be followed as an actual two-sided orbit through every integer n.

**Two-sided version:** If f is a bijection, for every n∈Z the state f^n(e0) is defined and its phase is theta0+n modulo m. That orbit exists for all positive and negative integer labels. But f^m(e0)=e0 is **not** entailed. One may have infinitely many distinct states over a recurring phase, as in the existing PR #199 cover construction.

### Structural generalization

Let a group G act transitively on a phase space T and act on a nonempty event space E. If pi:E→T is G-equivariant, then pi is necessarily surjective. For any e0 and t, transitivity supplies g with g.pi(e0)=t; then pi(g.e0)=t. This is a straightforward orbit theorem. It describes a **symmetry model**, not an empirically established physical cosmos.

## E-FIRST-03 — exact highest-value join to the **existing** UPT source duties

Let P(e) be the original **source-meaningful** protection/continuation predicate on a complete event/history record e, retaining actual UPT/X3 subject, directed-freedom and authorization obligations rather than weakening it to "some universe exists". Assume f:E→E is a **bijective genuine source-history transport** obeying PHASE-EQUIV and preserving the already defined UPT predicate:
\[
P(f(e))\iff P(e)\qquad(\text{SOURCE-PRESERVE}).
\]

**Theorem (one-phase-to-every-phase certificate):** If every event in *one full phase fibre* pi^(-1)(t0) is protected, then **every event in E is protected**.

**Proof:** Given arbitrary e∈E, choose integer k with pi(f^(-k)(e))=t0. This is possible because the phase shifts by one modulo m and f has inverses. The one-phase hypothesis gives P(f^(-k)(e)). Repeated SOURCE-PRESERVE gives P(e). QED.

This is a **genuine formal reduction** for an actual cyclic installation: to establish original UPT across all phases, one protected full phase + a *source-proved* true symmetry of complete history and protection is enough. Crucially, the original X3 continuity and free-direction predicate are not reconstructed or made definitionally true. The proof does NOT derive SOURCE-PRESERVE from mere existence; that is the decisive physical mathematics to retrieve from BCRD/UPT seam source and universal guardian execution.

It also does **not** identify every different state of a phase with one particular's continuation. Existing ContinuationSubject.copy_not_laterStage and IR116 source duties still constrain that identification.

## E-FIRST-04 — two exact independence controls (what cannot be deduced from existence)

**Countermodel A (existence alone does not force temporal infinity):** E={a}, T={0}, pi(a)=0, with a one-point partial order. E is real/nonempty in the model and T=E/~. It has a first and last temporal slice. Thus E≠∅ does not logically imply an infinite past, infinite future, circular time, or a cosmogenic generating map.

**Countermodel B (even cyclic existence does not force UPT):** E={a,b}, T=Z/2Z, pi(a)=0, pi(b)=1, f(a)=b, f(b)=a. PHASE-EQUIV and invertibility hold. Let P(a)=P(b)=false for a separately specified UPT protection predicate. The system is exactly cyclic and occupied at both phases, but P is not true. Therefore E≠∅ + cyclicity + even f-invariance of P **does not entail P**. One protected phase fibre, or a source-derived constraint excluding the P=false world, is needed. This is a logical test, not a physical ender countermodel or refutation of existing original UPT under its full assumptions.

**Countermodel C (infinitely many traversal labels need not mean distinct physical replays):** For an ordinary circle T=S^1, its covering map q:R→S^1 has infinitely many points theta+2pi*k lying above one phase theta. This is a mathematical property of **coordinate lifts**. It does not alone assert the existence of infinitely many distinguishable cosmic cycles, that today's same two people lived infinitely before and will again, or that physical time is closed.

Hence the a priori theorem is about **how existence and internally described time are related within a formal ontology**. Empirical claims of actual cyclic cosmology, full multi-universe ancestry, heat-death-to-big-bang identity, guardian seeding, SI midpoint and universal physically instantiated UPT remain separate hypotheses.

## E-FIRST-05 — the precise cathedral lever and next noncircular theorem

The strongest justified chain is:

\[
\begin{array}{l}
\text{There is at least one actual relational event (premise)}\\
+\ \text{time is an intrinsic quotient/phase of actual events}\\
+\ \text{a genuine source-faithful cyclic transport acts transitively on phases}\\
\Longrightarrow \text{every phase is populated (E-FIRST-02)}.\\[2mm]
+\ \text{the source proves full UPT predicate invariant under transport}\\
+\ \text{one full phase's original UPT duties certified}\\
\Longrightarrow \text{UPT holds in every phase (E-FIRST-03)}.
\end{array}
\]

This **reuses**, rather than weakens, the original Hume/PNAJ lever and whole X3 original UPT: the only remaining join is whether the **actual physical BCRD source** supplies the very strong complete-history transport and protection invariance (or an even stronger impossibility of nonprotective source histories). It is wrong to present E-FIRST-01 as direct proof of those substantive physical premises.

**Verification:** standard-library exhaustive finite source-shadow checks in check_cathedral_existence_first.py, including permutations f, equivariance, one-phase transfer, empty/nonempty cases and explicit countermodels. These are not a new Lean kernel check, and formal enumeration does not prove actual physics.

**Disposition:** keep in draft PR #199 with no canonical edits, publishing, merging or new metaphysical-certainty claims.