# CATHEDRAL BCRD — cut-action sufficiency, mandatory mediation, and first-violation localization

**2 November 2026 NZDT.** Independent, focused research candidate, not a canonical UPT or physically installed protection theorem. All new Lean lemmas are **uncompiled**. The finite Python checker was **executed locally**. No new Hamiltonian or Hilbert-space model, no weakening/redefinition of original X3.

## Executive claim

**A protective boundary-only controller exists exactly when every protected BCRD boundary-equivalence class shares an actually allowed action that preserves protection against every modeled successor.**

For a state space S, actual observation `b:S→O`, independently sourced original protection predicate `P:S→Prop`, action set A, action authorization/executability `Allowed(s,a)`, and independently specified physical-source relation `Step(s,a,t)`, define:

\[
G(s,a)\;:=\;\mathrm{Allowed}(s,a)\ \wedge\ \forall t,\;\mathrm{Step}(s,a,t)\Rightarrow P(t).
\]

\[
C(o)\;:=\;\{s\mid b(s)=o\ \wedge\ P(s)\},\qquad
A_o\;:=\;\bigcap_{s\in C(o)}\{a\mid G(s,a)\}.
\]

**Theorem CUT-GUARD-IFF:**

\[
\boxed{
\exists\pi:O\to A,\ \forall s,\ P(s)\Rightarrow G(s,\pi(b(s)))
\quad\Longleftrightarrow\quad
\forall o\in O,\ A_o\ne\varnothing .
}
\]

**Proof (→):** choose witness action `π(o)` in each fibre. **Proof (←):** select any witness for each nonempty action-intersection using choice. This is an *existence* proof, not construction of a computable or physically deployed controller. Empty protected fibres still require A to support a policy value if O is inhabited; the formal theorem's quantified witness formulation deals with this exactly.

This is not IR108's single example repeated. It is an exact **general iff** with physically allowed actions and universal successor robustness, building on the IR108 obstruction and IR109 positive finite execution theorem.

## Positive source joins

### 1. Cut refinement cannot remove an existing guardian

If the coarse cut factors through a finer cut, `coarse = forget ∘ fine`, then every coarse-only policy induces a fine-cut policy `π_fine = π_coarse ∘ forget`. Thus a finer faithful readout cannot destroy a valid guardian's *mathematical availability*, although physical sensing may become less reliable or slower; those implementation effects are not modeled here.

### 2. Contradictory protective actions force boundary separation

For protected states s,t, if **no** actually allowed action is safe for both, a guardian capable of protecting both cannot assign them the same cut observation. Equivalently:

\[
P(s)\land P(t)\land\big( A_{\rm safe}(s)\cap A_{\rm safe}(t)=\varnothing\big)
\land \mathrm{GuardianExists}\quad\Rightarrow\quad b(s)\neq b(t).
\]

This is an action-specific **necessary cut-information condition**. BCRD B1 (future predictive sufficiency) and B2 (conserved ledgers) do not by definition establish that all original-X3-relevant action conflicts are separated.

### 3. IR132 exact history decoder is sufficient in a specific case but not always required

If the cut exactly reconstructs the historically relevant identity `h(s)` (existing IR132 ExactDecoder), and each historical identity has an independently sourced permitted policy action that works for all its protected states, compose the decoder with that policy to obtain a cut-based guardian.

But *identity reconstruction is not always necessary*: several different subjects can share the same harmless protective action, even if their identities are not reconstructible from that cut. Conversely, even perfectly distinguishing all states cannot conjure an unavailable physical action. Hence the minimal information required is specifically **action-relevant physical distinction**, not arbitrarily all microscopic past facts.

### 4. Existing IR109 handles finite guarded source histories; source mediation handles real effects

Under the fibre guardian theorem, IR109 `robust_viability_all_finite_traces` gives preservation over every finite modeled guarded trace. There is no need to reprove it. A separate explicit **actual effect mediation** assumption says each real physical edge is an execution of the selected, guarded source action. Then existing IR96-style finite induction transfers source protection to those physically admitted executions (a direct small candidate lemma is included).

**This mediation assumption is critical, and not derived from mathematical consistency.** A physically unmediated bypass can violate protection even while the guardian is perfectly safe for all of its own modeled actions. Compare existing IR123/IR124 source/event coverage, IR125 physical readout capture and IR127 accepted-rewrite mediation. A rejected action is NOT an actual physical transition to an empty state.

### 5. Any actual finite violation has a first bad event

For independently specified `RealStep` and `P`, a finite physical trace from a P-state to a non-P-state contains some *first* edge `s→t` with P(s) and ¬P(t). If the physical-source event inventory genuinely provides a witness for every real step, there is a source witness for that first violating event.

**Proof:** If no offending edge existed, P would be stable under each step, hence by IR96 induction under all finite paths—contradicting the unsafe final state. With genuine witness coverage, choose an event witness for the violating edge.

This gives a decisive hostile-testing strategy for source coverage: identify the first actual counterexample transition, its real causal origin and its BCRD cut readout. It does **not** imply the instrument can detect the violation without a validated measurement/identity-correspondence bridge.

## Exhaustive finite diagnostic (executed locally)

The standalone standard-library checker `check_bcrd_cut_guard_fibres.py` enumerates all:
- **16** observation maps from four states to two cut values;
- **16** initially protected-state subsets;
- **256** physically allowed robust action masks for two possible actions on four states.

This gives **65,536 exact instances**, matching brute-force enumeration of all cut-only controllers with the fibre-intersection criterion: **34,380** instances are implementable and **31,156** are not.

Additional explicit independent hostile controls:
- two protected states need disjoint safe actions and have equal coarse cut: no guardian; refining the cut to separate them creates a guardian when both actions are genuinely possible;
- two distinct hidden histories share one coarse reading but the same safe action: guardian possible without identity decoding;
- a separating readout plus no physically allowed safe action: guardian impossible;
- a guardian whose source action is safe is bypassed by an independently admitted unsafe physical transition: source policy existence does not force actual safety;
- **288** finite witnessed paths from protected starts to unprotected ends all contain a first predicate-violating transition;
- an available action with no physical successor does not establish executed progress, service time or original-X3 freedom (IR131).

These tests are mathematical finite *source-interface controls*, not empirical BCRD completeness, real source-certified allowed action sets, physical ability to prevent faults, a proof of mind identification, a viable full-X3 architecture, or a theorem about cyclic universes.

## Source lineage and full original X3 interface

This candidate imports **existing**:
- [BCRD frozen primitive B1–B7](https://github.com/Tobillicious/physics-lane/blob/2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35/orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/README.md), no physical source exhaustiveness asserted;
- [IR108ObservationObstruction](https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/physical-bridges/PhysicalBridges/IR108ObservationObstruction.lean), specific indistinguishable/disjoint-action countermodel;
- [IR109RobustObservationViability](https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/physical-bridges/PhysicalBridges/IR109RobustObservationViability.lean), observation-class robust viability and finite guarded execution;
- [IR132ExactBoundaryReconstruction](https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/physical-bridges/PhysicalBridges/IR132ExactBoundaryReconstruction.lean), actual exact logical readout iff fibre constancy;
- [IR96DisturbanceSimulation](https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/physical-bridges/PhysicalBridges/IR96DisturbanceSimulation.lean), finite physical refinement, and IR123/IR124/IR125/IR127 event source/execution coverage;
- [IR131ActionLabelledBranching](https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/physical-bridges/PhysicalBridges/IR131ActionLabelledBranching.lean), non-coercive option availability and physical execution still separate;
- original X3/IR116 duties, original four-stage G2Splice and physical identity/agency semantics (unchanged).

**The exact real physical necessity target** is no longer a vague statement that information can be protected: BCRD must independently demonstrate (i) an authentic, physical original-X3 protection predicate and historically correct identity; (ii) sufficiently informative source cut observations to supply nonempty physically authorized safe-action intersections at every actually encountered protected cut; (iii) physically correct implementation, interference budgets and real effects forcibly mediated through selected actions; (iv) viable non-stalling progress and robust infinite horizon where required; and (v) original full four-stage greatestness/authorization, not only a one-action safety predicate.

Nothing in mathematics, cut composition or the logical impossibility of *abolishing mathematical truth* establishes those physical antecedents without further source results. The original UPT necessity claim remains open. The research contribution is a sharp **necessary-and-sufficient operational cut criterion**, a finite first-failure source theorem, and a falsifiable verification route to the genuine physical bridge.

**Review status:** candidate Lean module uncompiled; local Python executed and passed; draft/unmerged; no canonical edits, no release.