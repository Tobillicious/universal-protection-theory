# UPT-CYCLE-REUSE-02 — Transfer existing UPT proofs into cyclic BCRD

**2 November 2026.** Source-mapped research note on the new cyclic extension. Noncanonical, draft and unmerged. No reproof of Hume's lever, X3, or the existing UPT law.

## Exact source map — already proved, not work to repeat

- [Compiled UPT, II.1, V.2–V.3, XII.2](https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/compiled-strongest/SNUFFY-UPT-STRONGEST-MASTER.md): BCRD P1–P4 as the relational given; the original full-scope preservation law (including Law.scope_guarantee_iff); actual continuing histories and relations rather than interchangeable complexity scores; already recorded source/commissioning obligations. The user's proposal to derive value from actual relational existence is not a request to start the Hume argument again.
- [StagedMaximality.four_stage_original_maximal](https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/compiled-strongest/lean/Snuffy/StagedMaximality.lean): existing theorem giving full four-stage maximality under its finite-character feasibility structure.
- [CommonPolicyTop.top_policy_exists and top_policy_greatest](https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/compiled-strongest/lean/Snuffy/CommonPolicyTop.lean): already proves a single greatest policy given nonempty compact policy space, closed realization sets, and union realizability.
- [ContinuationSubject.LaterStage, FreeStage and copy_not_laterStage](https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/compiled-strongest/lean/Snuffy/ContinuationSubject.lean): actual source-labelled continuation is not equivalent to making a fresh copy, and freedom additionally tracks who directs a continuation event.
- [PR #194](https://github.com/Tobillicious/universal-protection-theory/pull/194): candidate seam/orientation and M5/M7 results. [PR #195 original note](https://github.com/Tobillicious/universal-protection-theory/pull/195): cyclic orientation-equivariance of the original preservation order.

The new objective is the physical necessity direction of the proposed **Universe ⇔ UPT** connection, not a new definition of a declared good.

## CYCLIC-TRANSFER-02A — direct instantiation of the existing greatestness theorem

Let P_cyc denote a *source-admitted* family of **complete closed** relational protection policies, not all admissible open BCRD policies. Let A be the source-indexed set of full world-and-stage continuation and freedom facts; the original UPT outcome map is out:P_cyc→P(A).

If P_cyc (1) is nonempty and compact, (2) has closed realization sets {p in P_cyc | a in out(p)} for each a, and (3) satisfies

\[
\forall p,q\in P_{\rm cyc},\quad
\exists r\in P_{\rm cyc}:\quad
out(p)\cup out(q)\subseteq out(r),
\tag{CYCLIC-G9}
\]

then **the existing theorem CommonPolicyTop.top_policy_greatest applies verbatim to Pol=P_cyc**, and supplies a **closed** policy whose full outcome dominates every feasible closed policy.

This is a legitimate **reapplication**, not a new proof of greatestness. The sole new question is whether the cyclic family **retains** the source's G.9 union/parallel-emulation feasibility, its compactness/closed-realization properties, and actual physical provenance after imposing the self-consistency seam.

For a finite nonempty family, the earlier Law.exists_aligned provides a *maximal* policy; it does **not** guarantee a greatest policy. Existence of even a greatest closed policy does not alone prove that physical dynamics **selects** or installs that policy.

## CYCLIC-TRANSFER-02B — exact finite append-only history obstruction

The existing source ContinuationSubject.LaterStage includes the requirement that a later finite event history list b extend earlier list a by prefix relation a <+: b.

Suppose finite lists h_0,...,h_(N−1) form a cycle of such prefix extensions and h_N=h_0. Then

\[
|h_0|\le |h_1|\le \cdots\le |h_N|=|h_0|.
\]

Thus all lengths are equal, and since each history is a prefix of the next, **every list is identical**. There is **no nontrivial finite literal prefix-extension cycle**.

This is not a disproof of *one closed relational matterspacetime*. It proves that a finite append-only history ledger in an **unfolded covering representation** cannot simply return to its **literally identical list** after having appended new events. A cyclic ontology requires a separately justified complete-object/seam transport construction, and must show correspondence to the already proven actual same-particular provenance semantics. A reconstruction/copy is not automatically physical continuation (D60).

## CYCLIC-TRANSFER-02C — independent closed feasibility and actual-selection controls

**Cyclic G9 is not automatic:** two separately consistent closed configurations may have factual outcomes {a} and {b} but no admissible closed configuration with {a,b}. In this finite logical control CYCLIC-G9 fails. This does not contradict the pre-existing physical concurrent-emulation theorem, whose feasibility, locality and resource premises must be freshly checked for the closed family.

**A greatest policy need not be selected:** the same nontrivial closed exterior carrier 0→1→0 can support two otherwise stipulated distinct internal histories, one keeping an existing a and one avoidably ending a. Both have a cyclic boundary assignment, and keep strictly dominates end on UPT's original continuation order. A closed carrier condition alone does not reject the end-choosing process. To derive **physical Universe ⇒ actual UPT**, we must exclude that possibility using the *independently justified* real BCRD dynamics/seam and a source-validated law/guard implementation, not by definition.

These are abstract logical **countercontrols** to unchecked implications from closure, not verified physical countermodels to completed BCRD, the October X3 results or an installed universal protection system.

## The one genuinely new bridge

The source results can be ported if their actual physical hypotheses transfer. Do not reprove the original moral and protection theory. Instead establish:

1. **Cyclic feasibility closure:** Does the source's G.9 concurrent emulation/splicing preserve **all actual closed seam constraints**, physical stage/free-direction constraints and resource limits, giving CYCLIC-G9 on the true closed family?
2. **History transport at one seam:** Is there an independently physically justified cyclic representation of the same particular that preserves its source-authored continuation and freedom without treating cyclic cover copies as separate births?
3. **Actual selection/installation:** Does the real BCRD closed-world dynamics exclude non-protection-aligned but otherwise consistent histories, or does physical UPT require the independently already specified commissioning/guard? This is the **new necessity theorem** proposed by the user, not something already entailed by endpoint cyclicity.

The reverse UPT⇒Universe direction must distinguish the mathematical UPT law (definable even without assuming a world) from an *installed physical UPT* (which entails a physical arena by meaning). Mere definitional implication does not establish a nontrivial cosmological equivalence.

## Verification

Accompanying standard-library diagnostic check_upt_cyclic_existing_proof_transfer.py: 3,615 finite literal list-cycle candidates with no strict append-only loop; all 15 nonempty outcome-subset families over two particulars for finite pairwise union-closure vs existence of a greatest; and explicit closed-carrier versus actual-selection controls. Finite checks passed locally, not a Lean proof or physical BCRD demonstration.

**Disposition:** Existing UPT greatestness and history semantics **reused**. New cyclic compactness/union feasibility and seam-provenance obligations **isolated**. Nontrivial physical universe⇔UPT **not yet proved**. Canon and original X3 unchanged.
