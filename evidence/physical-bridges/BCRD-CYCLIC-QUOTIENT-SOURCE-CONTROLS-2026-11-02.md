# BCRD-CYCLE-04B — Cyclic closure on source-derived physical cut quotients

**Date:** 2026-11-02, NZDT.
**Scientific class:** Exact finite quotient/composition theorem and original-source **P0/N1/N2-inspired** test controls. No claim of physical cosmic closure, exact recurrence of all microscopic descriptions, original X3 physical instantiation, or completion of BCRD as a theory of gravity. Addendum to focused draft PR #193.

## Frozen source anchors

- [BCRD README at frozen physics-lane commit 2b50c811](https://github.com/Tobillicious/physics-lane/blob/2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35/orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/README.md), §§1–2, 4 and 7. P0 declares state (q,n), physical cut and future signature q, and an n-flip as a *gauge-like redundancy candidate*; N1 declares a future signature depending on q XOR n and rejects q-only predictive sufficiency; N2 declares a separately conserved charge/ledger c and rejects silently omitting c from ledger completeness.
- [Original finite control script](https://github.com/Tobillicious/physics-lane/blob/2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35/orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/tests/verify_bcrd_finite_controls.py) was inspected; its positive and negative controls were not invented for this cyclic note.
- [Draft PR #193](https://github.com/Tobillicious/universal-protection-theory/pull/193) proves CUT-ALG-04A/B on \(\mathcal B_X=\mathcal P(X)\) and join-preserving process maps. Original X3 continuity and freedoms remain preserved in existing UPT source bridges.

## QUOTIENT-04E — exact finite descent/congruence criterion

Let S be a finite set of microscopic descriptions in a declared BCRD finite control; q:S→X is an **onto source-validated physical cut quotient**, with cut information algebra B_X=P(X). Let f:S→S be a deterministic microscopic event update in this declared test class.

**Theorem.** There exists a well-defined *unique* induced cut-level update fbar:X→X such that

\[
\boxed{q\circ f=\bar f\circ q}
\]

**if and only if**

\[
\boxed{q(s)=q(t)\implies q(f(s))=q(f(t))\quad\forall s,t\in S.}
\]

**Necessity:** Apply the commuting equation to s,t with equal q-values.
**Sufficiency:** For any x in X, choose s with q(s)=x; set fbar(x)=q(f(s)). The congruence hypothesis makes the value independent of choice. This yields the equation, and onto q makes fbar unique. QED.

If f,g descend through the same q, g∘f descends as gbar∘fbar. This follows by composing the commuting diagrams, and certifies an exact finite **cut-level B5-compatible quotient**.

**Cyclic consequence:** If fbar^N(x)=x, then for every micro-description s with q(s)=x,

\[
\boxed{q(f^N(s))=\bar f^N(q(s))=q(s).}
\]

This proves recurrence of the declared **physical cut class**, not necessarily exact micro-description recurrence \(f^N(s)=s\), entire interior history recurrence, or physically continuing same particular. The source q must pass B1 predictive, B2 ledger, B3 causality and B4 spectator controls before interpreting its equivalence as physical.

## P0-CYCLE-04F — frozen source positive/gauge-like control

P0 declares S={(q,n):q,n in {0,1}}, physical cut q, future signature q and ledger q. Let qcut(q,n)=q, and use its actual gauge-like redundancy flip:

\[
f(q,n)=(q,1-n).
\]

Then

\[
\bar f(q)=q,\qquad \bar f^1(q)=q,\qquad f(q,n)\ne(q,n)\ \forall(q,n).
\]

**Every declared physical cut class closes after one event although NO microscopic description is a one-step fixed point.**

Thus an overstrict raw-token identity requirement is **not necessary** for the source's own finite *gauge-candidate* physical-equivalence closure. The source P0 is a finite diagnostic and labels this flip *gauge-like redundancy candidate*, not a proven universal physical gauge symmetry.

## N1-CYCLE-04G — independent predictive hidden-memory negative control

The original N1 future signature is \(\mathrm{Future}(q,n)=(q,q\oplus n)\). At equal q but different n, the declared future outputs differ, so q-only cannot be a sufficient input cut for this declared future. No unique mapping q→Future can factor through qcut. A supposed cyclic quotient identifying n here fails original B1/N1; it has erased observable causal information.

## N2-CYCLE-04H — independent ledger negative control

When the physical ledger explicitly includes conserved c, descriptions (q,0), (q,1) have different conserved charge data even if a simplified future signature reports only q. B2 demands accounting for c at the seam; B3/B4 then address causal spectator or superselection implications. A q-only cyclic identification is **not licensed** just because a simple q-future prediction is unchanged. This is different from N1's failure.

## Why this advances the actual cyclic question

**Finite source-compatible closure condition:**

\[
\boxed{\text{source-certified physical cut quotient }q\ +\
       \text{congruent evolution }f\ +\
       \text{consistent cyclic cut class}}
\]

The source's P0/N1/N2 finite controls discriminate a legitimate observational quotient from predictively or ledger-incomplete replacements. They yield a sharp warning: **a cyclic history should not be forced to preserve arbitrary microscopic labels**, but it must preserve the genuinely physical distinctions selected by original BCRD causal and ledger tests.

This does NOT establish a universal BCRD cyclic trace, real closed matterspacetime, original X3 physical same-particular continuation or a world-scale mechanism. For larger claims, reuse frozen M5 critical pair/coherence and M7 calibrated intervention semantics as appropriate, plus the already-existing original X3 physical-source bridge. Do not re-prove X3.

**Verifier:** evidence/physical-bridges/check_bcrd_cyclic_quotient_source_controls.py — finite P0 positive gauge-flip, N1 predictive hidden-memory and N2 ledger hostile controls plus compatible cut composition, locally passed on 2 Nov 2026.
