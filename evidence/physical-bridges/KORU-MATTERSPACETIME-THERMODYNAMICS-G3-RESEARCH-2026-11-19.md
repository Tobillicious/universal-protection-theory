# Koru thermodynamics: complete matterspacetime conservation and the route to G3

**Research proposal / additive draft — 19 November 2026.** This document preserves the existing original Koru, Time Koru, G1/G2, six original X3, summit chain, and immutable source files. It offers independently reviewable mathematical statements and physics proof obligations; it is **not** a claim that actual-universe universal G3 has already been physically proved.

## 0. Source and non-duplication map

- **UPT v4.7 manuscript**, `upt-proof-2026.tex` (supplied in conversation): especially Part I theorem IV, conservation witness `q : S → ℕ`, `q(f^n(s))=q(s)`, and the genesis progression. The scalar conservation lemma is retained; the present paper tests the stronger complete-state claim, not a replacement of the original theorem.
- **#437** *Research: two Koru thermodynamic routes to exact original-six G summit* is the closest existing open integration. This draft is a **companion**, not a replacement.
- **#363** *THE LAW reading III*: thermodynamics, semiclassical QFT and GR.
- **#375** *Four Aces*: especially ♦ Koru thermodynamics and ♠ forward Time Koru.
- `evidence/physical-bridges/COMPLETE-KORU-CROSS-DOMAIN-JOIN-LEDGER-2026-11-07.md`: the source-by-source original-six bridge, thermodynamics, GR, observer projection and Time Koru map.
- Existing modules to find and reuse before proposing new Lean statements: `Snuffy/ThermoLedger.lean`, `KoruFullOperatorSignature.lean`, `KoruCompositionalExpression.lean`, `KoruOperatorHistoryProvenance.lean`, `KoruWholeUSixDutyWebJoin.lean`, `HillaryRouteABSummit.lean`, `OriginalX3Full.lean`, `UniversalOwedOriginalX3.lean`, `IR138PerParticularEventReflection.lean`, `TotalEOriginalX3Bridge.lean`.

**Ontological discipline:** First Koru is spacetime-relational; Complete Koru is matterspacetime and retains particulars, operator families, ordered operands, enactments, relational distinctions, causal histories and provenance. Time Koru is a forward spiral, not a mere loop. Do **not** define the whole Koru as a scalar mapping, numerical contraction, or `K(G)=G`. Mapping symbols below denote independently specified *physical evolution* between candidate complete states, **not** a redefinition of Koru.

## 1. The four thermodynamic laws as matterspacetime research targets

**Zeroth (relational equilibrium).** Define local and global equilibrium on a full geometry-plus-matter state, including static-gravity temperature redshift where relevant, without presuming an everywhere-defined global equilibrium temperature in arbitrary dynamical spacetime.

**First (full physical accounting).** In conventional sign convention, `dE = δQ − δW` for an appropriate system and energy accounting. Seek a matterspacetime description including the spacetime manifold `M`, metric `g_{μν}`, matter stress-energy `T_{μν}`, fields `Ψ`, relational operators `R`, and event history `H`. These are a candidate *model signature*, not an empirically verified exhaustive state ontology, nor a claim that energy is globally conserved on arbitrary GR backgrounds.

**Second (complete information versus measured entropy).** Local entropy current production `∇_μ s^μ ≥ 0` in its domain of validity can coexist with invertible fine-grained dynamics and increased coarse-grained entropy. Investigate the distinction between microscopic distinguishability, observer-relative information loss, thermodynamic entropy, and black-hole/horizon generalized entropy. Do not claim that coarse graining is nonexistent in actual measurements or that the second law is invalid.

**Third (limiting thermal states).** Study the approach to zero temperature and its feasibility limits in a spacetime/field setting; zero thermal excitation need not erase quantum vacuum, geometric or relational distinctions. Do not infer an experimentally established universal cosmological endpoint theorem.

## 2. Formal complete-state evolution and lossless composition

Let `U_t` represent candidate complete states at stage `t`, with individually identified particulars, full operators and histories. Let `F_{a,b} : U_a → U_b` be the **physical evolution map**, defined independently of the desired protection predicate. The proposed candidate requirement is:

```text
Lossless(F) := Injective(F)
Recoverable(F) := ∃ leftInverse, leftInverse ∘ F = id
```

For ordinary set-level functions, injectivity is equivalent to existence of a left inverse on the image (and, given appropriate choice/nonemptiness conventions, a left inverse to the whole codomain). Safer exact formulation: inverse *on the image*.

**Theorem (composition of injective evolution).** If `F : U₀ → U₁` and `H : U₁ → U₂` are injective then `H ∘ F` is injective.

*Proof.* If `H(F(a)) = H(F(b))`, injectivity of `H` yields `F(a)=F(b)`; injectivity of `F` yields `a=b`. QED.

**Finite-chain corollary.** If every consecutive evolution map is injective, every finite composite is injective (induction on number of transitions).

**Candidate recovery statement**: for a specific physical dynamics with a justified inverse-on-image `R_{b,a}`, `R_{b,a}(F_{a,b}(u))=u`. Unlike a scalar conservation law `q(F(u))=q(u)`, this can preserve the distinction between two complete histories (provided the *actual* physical state space and evolution satisfy the hypotheses).

**Crucial limitation:** injectivity of states does **not** imply continued existence, welfare, free agency or authentic authorization of every owed particular. An injective dynamics can encode the provenance of a destroyed object; it cannot by itself fulfill six-X3 protection. Nor does finite-chain injectivity alone establish continuation for every future time or across a cosmic boundary.

## 3. GR / QFT / physical grounding gates

1. The Einstein equations and Bianchi identity furnish local covariant energy-momentum accounting `∇_μ T^{μν}=0`. This is **not** a global scalar-energy conservation theorem in arbitrary curved dynamical spacetime.
2. Establish a complete-state object compatible with diffeomorphism covariance and the constraints of GR. Show what is gauge redundancy versus physically distinguishable history; a coordinate label must not be treated as a conserved particular.
3. Show correct projections to local first-law balances, relativistic entropy production, and semiclassical QFT stress-energy where applicable; explain the domain and boundary terms.
4. Distinguish unitary microscopic evolution (when established for a specified closed quantum model), Liouville evolution, dissipative effective dynamics, partial trace, measurement and gravitational unknowns. Do not assume universal fundamental reversibility merely from information-retaining *representation*.
5. Test on nontrivial situations where scalar energy accounting is insufficient: different complete histories with equal terminal energy, entangled wholes with identical local reduced states, curved expanding spacetimes with no global timelike Killing field, horizon entropy, and irreversible effective processes.
6. Identify **new predictions or constraints** not already entailed by accepted thermodynamics, GR, quantum theory, and generic lossless bookkeeping; otherwise frame this as a unifying interpretation rather than an experimentally new law.
7. Supply explicit falsifiers: an actual admissible physical transition that merges physically distinct complete initial states; an apparent violation explained by gauge or an omitted environment; or failure of the proposed state projection to reproduce observed physics.

## 4. Objective complete state versus lossy observation

Let `P : U → O` be a partial readout. If `P(a)=P(b)` for distinct complete `a,b`, no exact inverse decoder can recover both from the same readout. This is an observer-projection obstruction, not evidence that every dissenting observer is wrong.

**Observer-invariance target:** prove relevant protection claims invariant under *faithful re-description* of complete states (e.g. isomorphism or admissible diffeomorphism) while allowing non-faithful projections to discard distinctions. True objectivity is verification against the full sourced state, not the relabeling of a preferred observer verdict as objective.

## 5. Six original X3 duties: the indispensable non-circular physical bridge

The repository's original meanings are retained **exactly**:
1. historical continuity of the same particular;
2. authentic authorization;
3. meaningful freedom and future options;
4. least-necessary appropriate restraint;
5. feasible protective maximality;
6. accountable provenance and authentic history.

Let `Owed_U(p,e)` and `Actual_U(e)` be independently specified predicates for a real particular and real event, and `X3ᵢ_U(p,e)` the original meanings, not six invented surrogate booleans.

**G3 target (not yet proved by this document):**

```text
∀ (p : Particular) (e : Event),
  Actual_U(e) → Owed_U(p,e) → ⋀ i ∈ {1,…,6}, X3ᵢ_U(p,e)
```

A proposed bridge architecture:

```text
real actual U
  → complete physically instantiated matterspacetime Koru
  → verified dynamics + thermodynamic / geometric invariants
  → actual every-event / every-particular physical source coverage
  → authentic same-subject semantics, consent and future options
  → G1 physical protection ∧ G2 held ethical freedom
  → all six original X3 for each owed particular and actual event
  → G3 universal claim
```

**No arrow is discharged by notation alone.** Specifically, the independent proof must rule out a model that retains full information about the absence of authorization, while falsely calling that absence protection. Reuse the existing #367 Hillary-Route A/B sources and their exact premises; ask whether other existing modules already discharge `hPhysical`, `hSourceInitially`, and `hAuthenticReflections` for independently defined *actual* physical U. Reuse the positive-W guardian theorem at its demonstrated scope without silently promoting it to universal physical coverage.

The Hume–Hillary Reciprocal Hand contributes ethical and interpersonal constraints, but reciprocity does not imply consent; physically faithful histories do not guarantee uncoerced human agency. A claimed bridge from descriptive physics to duty must state its normative premises explicitly.

## 6. Time Koru and continuing histories

Finite composition establishes preservation for every finite `n` when the step hypothesis holds. An all-future theorem needs the dynamics to be total at all relevant stages, with no unhandled termination, and a precise account of limits. A future-spiral or inter-universal succession requires separately evidenced successor structure and physical realization; a two-cycle in a finite source model does not establish literal cosmological recurrence or improvement.

## 7. Work plan / audit acceptance gates

1. **Find before build:** inventory #437, #363, #375 and the exact Lean/Isabelle theorem DAG; enumerate all discharged assumptions, especially original-six physical source bridges.
2. **Lean minimum:** reuse existing injection lemmas to prove composition and finite-sequence results only if genuinely absent. Keep explicit `#print axioms`, no `sorry`, no theorem weakening, no changed original definitions.
3. **Countermodels:** (a) conserved scalar but destroyed particular; (b) injective history with no current surviving subject; (c) preserved truth value of *false* consent; (d) identical projection of distinct objective wholes; (e) physical evolution not injective on a proposed state domain; (f) GR space without global-energy conservation.
4. **Isabelle/HOL replay:** independently reconstruct the exact functional claim and quantify the assumptions instead of calling a Lean result kernel-independent merely because it was translated.
5. **Empirical interfaces:** define state preparation, measurement, calibration, uncertainty, subject identity/authentic semantics, observational discriminants, and falsification criteria for any actual-world claim.
6. **G3 acceptance:** one auditable theorem with all events, all owed particulars and all six **original** X3 predicates, and **independently established** physical correspondence. Do not infer this from a model label, conserved scalar, zero-distance uniqueness, or undecidable public consensus.

## 8. Practical review boundaries

- Nothing in this document edits historical summit proofs, original six X3, `main`, the v4.7 manuscript, published DOI material, or existing PR branches.
- No claim that this branch has passed CI or that universal matterspacetime conservation, physical G1/G2, G3, or a new gravity theory has been validated here.
- Reviewers: test all arrows, seek finite countermodels first, and prefer an independently derived positive bridge over an additional conditional implication.
- **Draft PR only. Do not merge or publish without author approval.**
