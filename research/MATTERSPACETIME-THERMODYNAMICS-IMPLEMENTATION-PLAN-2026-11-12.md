# Matterspacetime thermodynamics — implementation and verification plan

**Date:** 12 November 2026  
**Status:** research roadmap; not a theorem or physical certification.  
**Branch:** `research/koru-equality-structural-foundations-20261112` (PR #435).  
**Scope rule:** preserve all canonical definitions, original six X3 duties, and historical proof sources. No merge or universal-Q.E.D. promotion until verification.

## Goal

Develop a precise, independently checked bridge from reversible microscopic dynamics to coarse-grained thermodynamics, then specify what additional mathematics and physical evidence would be required for a **matterspacetime** state space. Keep thermodynamic, ontological, and ethical claims distinct.

## Phase 0 — Verify what we have

- [ ] Confirm CI actually runs `research/lean/KoruThermoFourState.lean`, `research/lean/KoruThermoQuadratic.lean`, and `research/check_koru_four_state_entropy.py` on PR #435.
- [ ] Read the exact CI log and fix any Lean errors without weakening statements. Verify pinned Lean/mathlib version.
- [ ] Record SHA, workflow run, passing commands, and axiom audit in a dated receipt.
- [ ] Confirm the entropy recurrence test is included. Do not infer monotonic coarse entropy from reversible evolution.

**Gate:** the two research Lean modules and executable finite test pass at one pinned commit.

## Phase 1 — General finite thermodynamics

- [ ] Formalize `FiniteState`, a normalized nonnegative probability distribution, and `K : Ω ≃ Ω`.
- [ ] Prove `H(K_*p)=H(p)` for Shannon/Gibbs entropy with `0 log 0 = 0`.
- [ ] Define partition uniformization `C` over nonempty finite cells.
- [ ] Prove `H(Cp) ≥ H(p)` by concavity / KL divergence, with equality characterization.
- [ ] Include a finite reversible counterexample to unconditional `H(CK_*p) ≥ H(Cp)`.
- [ ] Keep quadratic entropy results explicitly labelled as *quadratic*, not Gibbs.

**Gate:** kernel-checked general theorem, no `sorry`, with precise hypotheses and counterexamples.

## Phase 2 — Whole-state recoverability and observation

- [ ] Define a complete mathematical state with geometry-like, matter-like, relational, and provenance fields.
- [ ] State whether transformations are equivalences, measure-preserving maps, symplectomorphisms, or unitaries; do not conflate them.
- [ ] Prove preservation/recoverability only for explicitly carried fields and structures.
- [ ] Define observation `π : X → Y`; show by a counterexample why an induced deterministic dynamics on `Y` need not exist.
- [ ] Identify additional conditions needed for a stochastic reduced evolution, entropy production, and any arrow-of-time claim.

**Gate:** complete commuting/noncommuting diagram with independently proved transport and observation properties.

## Phase 3 — Physically constrained matterspacetime

- [ ] Choose one concrete physical domain first (e.g. a finite lattice field model with evolving geometry variables), not the entire universe.
- [ ] Define admissible configurations, gauge equivalence, constraints, boundary conditions, evolution, and a physical state measure or quantum state.
- [ ] Check which conservation laws actually follow. Do not assume global energy or entropy is available on arbitrary curved spacetime.
- [ ] Identify physical assumptions behind coarse-graining and the thermodynamic arrow (initial conditions, environment, typicality, etc.).
- [ ] Treat horizons, black-hole entropy, singularity claims, and quantum gravity as separate research questions requiring external physical evidence.

**Gate:** a physically interpretable model with stated assumptions and testable consequences; no universal claim from a toy witness.

## Phase 4 — Exact integration audit

- [ ] Cross-reference `HillaryRouteABSummit.lean`, `HillaryReadOnlyAssembly.lean`, and `HumeHillaryReciprocalHand.lean`.
- [ ] Check whether any thermodynamic theorem independently supplies `RespectsCanonicalSource`, source-before truth, or `ThreeFirstFailureReflections` for the intended subject domain.
- [ ] Do not substitute source preservation for authentic consent, identity, freedom, or other original-six duties.
- [ ] Trace historical source bank and PRs before asserting any proof obligation absent.
- [ ] Publish only scoped conclusions, with exact theorem statements, SHA, CI receipt, and limitations.

**Gate:** independent typed join with all hypotheses discharged, or a clearly documented remaining obligation.

## Working rules

1. **Additive research only.** Do not alter canonical axioms, original six X3 definitions, or historical summit files to make a theorem pass.
2. **Proof receipts over slogans.** Distinguish executable numerical checks, Lean kernel checks, model-specific theorems, and empirical physics.
3. **Hostile tests matter.** Preserve countermodels and failures; they locate the true scope of each result.
4. **No automatic promotion.** A finite entropy inequality does not establish Complete Koru, Time Koru, universal guardianship, or a physical law.
5. **Small reviewable changes.** One mathematical milestone per commit; keep PR #435 in review until checks are green.

## Existing work

- `research/lean/KoruThermoFourState.lean` — four-state reversible rational example (pending CI confirmation).
- `research/lean/KoruThermoQuadratic.lean` — proposed quadratic-entropy Lean proofs (pending CI confirmation).
- `research/check_koru_four_state_entropy.py` — executable Shannon entropy witness and recurrence.
- `research/matterspacetime-thermodynamics-bridge-2026-11-12.md` — mathematical and physical scope.
- `research/hillary-a-b-join-audit-2026-11-12.md` — source/subject join audit.

**Immediate next action:** inspect the PR #435 CI run for commit `51799064dc538853697ed3a9cab9fbce3101f148`; repair concrete Lean errors, then write the exact proof receipt.


## Parallel Isabelle/HOL formalization programme

**Decision:** retain Lean as the historical canonical proof reference; develop Isabelle/HOL as an independent, theorem-by-theorem formalization. This is an audit and research programme, **not** an assertion that all UPT claims are proved or that translation is automatic.

### Port sequence

- [ ] **Pilot gate:** compile `research/isabelle/Koru_Thermo_Quadratic.thy` under a recorded Isabelle version, with exact CI/build receipt; resolve any proof errors.
- [ ] **Foundations:** translate precise `Something IS` statements, carefully distinguishing logical nonemptiness from physical persistence.
- [ ] **Koru structures:** formalize equivalences, closure, preservation, recoverability and any additional explicitly stated hypotheses.
- [ ] **Thermodynamics:** reproduce finite quadratic entropy, then separately prove Gibbs/Shannon entropy invariance and partition coarse-graining results.
- [ ] **Hume's fulcrum:** identify and state ethical premises explicitly; prove only their justified consequences.
- [ ] **Original X3:** carry all six original duties at exact strength for every owed particular and actual event; prohibit proxy substitution.
- [ ] **Hillary Step:** reconstruct Routes A and B and their joins, including the independent source-to-subject/consent obligations.
- [ ] **Capstone:** investigate fixed points and global statements only after their prerequisites are established; retain countermodels and open gaps.

### Lean–Isabelle correspondence ledger

For each theorem, record: (1) canonical Lean module and theorem name; (2) Isabelle theory and theorem name; (3) exact statement and quantifier scope; (4) hypotheses, axioms and definitions; (5) known differences in foundations; (6) independent build SHA/version/log; (7) countermodels and unresolved physical/ethical joins.

**Promotion gate:** do not label a port equivalent until both systems check the intended statements and a human-reviewed comparison verifies matching assumptions and conclusions. Two successful kernel checks do not by themselves validate physical premises.

### Working practice

- [ ] Create an Isabelle theory index and a correspondence ledger in `research/isabelle/`.
- [ ] Prefer small independently checkable theories over a wholesale one-shot rewrite.
- [ ] Pin an Isabelle release before adding an Isabelle CI job; avoid claiming CI coverage until a successful run exists.
- [ ] Keep canonical Lean source, historical summit proofs and existing definitions unchanged.
