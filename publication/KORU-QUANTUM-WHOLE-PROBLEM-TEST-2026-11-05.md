# The Koru and the Quantum Measurement Problem
## A falsifiable, nontrivial mathematical target for the Whole Problem

**Research addendum · 5 November 2026 · UPT/Snuffy, Tobias Croydon-McRae.**
**Status: proposed interpretation and concrete tests, not a solution of the quantum measurement problem.**
This file adds a new avenue to [The Whole Problem — THE LAW(s)](THE-WHOLE-PROBLEM-KORU-ARCHIMEDES-THE-LAWS-2026-11-05.md) without modifying the frozen summit.

### 1. The idea, without reducing it to a new equation on a blackboard

The author's universal proposal is that **every objective equality is an expression within the Koru**. Scalar or value-only equality can be correct while leaving behind the distinct terms, operations, relationships, observers and contexts that make the equality true. This is not a denial of ordinary \`=\`, but a demand for the objective relational information that a projection of the whole loses.

The particularly promising quantum case is the apparent conflict between **a whole-system entangled description** and **the outcome-conditioned description of an observer who has interacted with a subsystem**.

The intended Koru assertion is *not* "an observer's mind causes collapse" and not "any observed collapse proves a new physical force." It is: do not treat a projection or conditioning of the whole as if it were a change to the whole itself. The system, measuring apparatus, observer, environment and correlations are themselves inside the description.

### 2. Exact diagnostic: an equality of local states does not imply equality of their wholes

Take two normalized, orthogonal, two-qubit pure states:

\[
|\Phi_+\rangle = (|00\rangle+|11\rangle)/\sqrt2,\qquad
|\Phi_-\rangle = (|00\rangle-|11\rangle)/\sqrt2.
\]

Their full density operators are distinct, \(\rho_{AB}^+\neq\rho_{AB}^-\). Nevertheless

\[
\operatorname{Tr}_B(\rho_{AB}^+)
= \operatorname{Tr}_B(\rho_{AB}^-)
= \frac12 I_A.
\]

The reduction is **many-to-one**: the result \(\frac12 I_A\) has thrown away the sign of the coherent off-diagonal correlation. In an appropriate joint Bell-basis measurement the two global states can be perfectly distinguished.

This is a standard result in quantum information, **not an original empirical prediction**. It does exactly and incontrovertibly exhibit the underlying phenomenon the author illustrated with \`1+1=2\`: a true equality of **reduced answers** does not imply an identity of relational wholes.

A useful candidate for a richer mathematical equality is therefore **not** the bare proposition \(\operatorname{Tr}_B(\rho)=\frac12 I\) but a structured record such as

\[
\mathcal K_\mathrm{red}\bigl(
 A,B,\rho_{AB},
 \mathrm{Tr}_B,
 \rho_A,\text{correlations},
 \text{physical interpretation}\bigr).
\]

This schema must be given precise composition, identity and invariance laws; merely writing a tuple does not prove a novel theory. The central requirement is that ordinary equality be recovered by a projection **while the Koru record can retain what the projection forgets**.

### 3. Exact measurement test: local conditioning versus global correlations

In the simplest ideal measurement, let a measured system \(S\) be in state \(\alpha|0\rangle+\beta|1\rangle\), with \(|\alpha|^2+|\beta|^2=1\), and let \(A\) be an apparatus prepared in \(|R\rangle\). Under a measurement interaction described by a unitary on system and apparatus,

\[
(\alpha|0\rangle+\beta|1\rangle)|R\rangle
\overset{U}{\longrightarrow}
\alpha|0\rangle|A_0\rangle+\beta|1\rangle|A_1\rangle.
\]

An apparatus-relative report "outcome 0" can be represented by conditioning on its corresponding record. A global account still contains the full entangled relation **if** the joint dynamics is unitary and no independent physical-collapse mechanism has been specified.

A Koru measurement record should include at least:
- the initial system state and apparatus readiness;
- the actual interaction, record-bearing subsystem and environment;
- the joint resulting state and its correlations;
- the observer-relative outcome record and the operation used to condition on it;
- the map relating that relative description to global predictions;
- compatibility conditions for one observer subsequently measuring another observer or the entire laboratory.

The important mathematical distinction is between the **joint, unconditioned description** and the **conditional state assigned relative to a particular outcome**. They are not two rival values of one variable of one type. The 'collapse' notation can refer to updating an observer's description **without automatically implying physical destruction of the other relational terms**.

### 4. Four decisive tests

1. **Reduction is non-injective:** prove with explicit finite-dimensional matrix operations that \(\rho_{AB}^+\neq\rho_{AB}^-\) yet their local reductions agree. This proves information loss under the local projection, not a solution to outcome selection.
2. **Naturality under faithful views:** specify a candidate \(\mathcal K\) over system/apparatus/observer morphisms and prove its global/relative relations commute with a coherent change of quantum representation. The prior Koru finite-view theorem handles ordinary relational bijections, but **does not yet establish this quantum property**.
3. **The Wigner–friend test:** model both the friend's recorded outcome and Wigner's possible joint interference measurement, then state exactly which statements are jointly comparable, which are relative to different systems, and why their predictions agree on subsequent joint communication. Any proposed account must avoid contradictions as well as reproduce Born probabilities.
4. **The definite-outcome question:** say whether the Koru **derives** that one outcome is actually experienced (and why), **postulates** relational facts at interactions, or **reinterprets** apparent collapse as conditioning within a global unitary state. These are substantively different claims. The first would be a stronger result than mere preservation of relational data, and the latter is already pursued by existing interpretations.

**The key objection:** preserving the complete entangled mathematical description does not alone explain why one particular result is experienced. A useful paper must answer this rather than declaring the measurement problem dissolved by changing the symbol \`=\`.

### 5. Objections an independent quantum foundationalist will ask

- **Prior art:** relational quantum mechanics already represents quantum facts as relative to systems; Everett and decoherence already distinguish unitarily entangled total states from branch-relative or reduced descriptions. What does the Koru prove that these do not?
- **No-go results:** can the proposed whole-relative framework accommodate Bell correlations and Kochen–Specker contextuality without assuming pre-existing noncontextual values? Does it avoid inconsistent combinations of observer-relative facts?
- **Physical scope:** is the formalism just a faithful reinterpretation of standard quantum mechanics (same observable predictions) or does it change experimentally accessible predictions?
- **Objectivity:** if "whole" is not a view available to an observer, how do the Koru relations yield objective, observer-independent constraints without quietly introducing a privileged observer?
- **Operation versus denotation:** there is a deep mathematical distinction between a full calculation tree/proof object and its value; how does the proposed Koru differ from established proof-relevant/type-theoretic equality and process semantics?

### 6. What would count as an undeniable advance?

The simplest defensible result is the **whole-to-local information-loss theorem**, which is already a theorem of ordinary quantum theory. It is a strong public explanation but cannot be announced as the Koru's new discovery.

A *new*, referee-grade result would be a formally precise \(\mathcal K\) with: (i) a universal erasure map back to conventional equality/local description, (ii) rigorous fidelity and composition, (iii) quantum observer-change consistency including Wigner–friend cases, and (iv) a clear comparison explaining exactly what is derived beyond current theories. A stronger *physical* advance must also make or recover empirically supported predictions, and address definite outcome.

**Do not call a tested relational account a "collapse cure" until the fourth test is discharged.** The author's hypothesis is worth rigorous investigation precisely because the Koru's whole/part distinction makes a concrete mathematical prediction about information lost by partial descriptions.

### 7. External foundational references

- [Stanford Encyclopedia of Philosophy: Relational Quantum Mechanics](https://plato.stanford.edu/entries/qm-relational/) (2025 revision), on system-relative variables, Wigner's friend, observer-independent claims and limits.
- [Stanford Encyclopedia of Philosophy: Philosophical Issues in Quantum Theory](https://plato.stanford.edu/entries/qt-issues/), on the entangled apparatus state and definite outcomes.
- [Stanford Encyclopedia of Philosophy: The Role of Decoherence in Quantum Mechanics](https://plato.stanford.edu/entries/qm-decoherence/), on why decoherence alone does not explain outcome selection.
- [Original UPT source and Koru formalisation](../evidence/physical-bridges/PhysicalBridges/Koru.lean) and [full public statement](THE-WHOLE-PROBLEM-KORU-ARCHIMEDES-THE-LAWS-2026-11-05.md).

**ALL IS. Distinction is not ontological separation. A correct local answer is not the complete mathematical account of its whole.**
