# CATHEDRAL-CYCLE-01 — Existing UPT block-splicing already yields a conditional cyclic closure theorem

**Date:** 2026-11-02 (Pacific/Auckland)  
**Status:** focused draft research join, noncanonical, unmerged. Analytical corollary of an **existing machine-checked Lean theorem**; new corollary itself has **not** been Lean-compiled or independently reviewed. Exhaustive finite diagnostic locally PASS. **No cosmological recurrence, actual UPT implementation, X3 reconstruction or universe ⇔ UPT necessity claimed.**

## The cathedral inventory — reuse, do not rebuild

Pinned main-branch source as examined on 2 November 2026, main SHA 26abaa24b7e0f5715de0e9c85a25149adfbb5435:

1. [G2Splice.lean](https://github.com/Tobillicious/universal-protection-theory/blob/26abaa24b7e0f5715de0e9c85a25149adfbb5435/evidence/compiled-strongest/lean/Snuffy/G2Splice.lean) **already proves**:
   - Union realizability for the full staged continuation/free-direction outcome under its specified independent local policy components: G2Splice.union_realizable and G2Splice.outcome_splice;
   - Top/grand outcome under per-particular available best components: G2Splice.top_realisable and G2Splice.whole_outcome_greatest;
   - For causally closed **disjoint** state blocks and local transitions, the actual block-spliced trajectory agrees, on each block at **every discrete step**, with the source policy assigned to that particular: G2Splice.Dynamics.block_splice_run and block_splice_keeps.
2. [R16Cut.lean](https://github.com/Tobillicious/universal-protection-theory/blob/26abaa24b7e0f5715de0e9c85a25149adfbb5435/evidence/compiled-strongest/lean/Snuffy/R16Cut.lean) supplies Closed D C, LocalTo D T, AgreeOn and closed_cut_step. Its dynamical causal-graph premises must be independently instantiated; they are not consequences of merely naming a BCRD cut.
3. [CommonPolicyTop.lean](https://github.com/Tobillicious/universal-protection-theory/blob/26abaa24b7e0f5715de0e9c85a25149adfbb5435/evidence/compiled-strongest/lean/Snuffy/CommonPolicyTop.lean) already gives a greatest policy from compactness, closed realization sets and union-closure. No reproof.
4. [IR134SourceExtractedOutcome.lean](https://github.com/Tobillicious/universal-protection-theory/blob/26abaa24b7e0f5715de0e9c85a25149adfbb5435/evidence/compiled-strongest/lean/Snuffy/IR134SourceExtractedOutcome.lean) already requires outcomes derived from actual stepwise source execution and checks original-cohort obligations along the whole source history.
5. [IR135CommonPolicyWorlds.lean](https://github.com/Tobillicious/universal-protection-theory/blob/26abaa24b7e0f5715de0e9c85a25149adfbb5435/evidence/compiled-strongest/lean/Snuffy/IR135CommonPolicyWorlds.lean) already addresses a *single* policy before all action-reactive worlds, not a post hoc independent policy chosen separately in each world. Its required uniform profile and source premises are not erased.
6. [ContinuationSubject.lean](https://github.com/Tobillicious/universal-protection-theory/blob/26abaa24b7e0f5715de0e9c85a25149adfbb5435/evidence/compiled-strongest/lean/Snuffy/ContinuationSubject.lean) and existing X3 bridges retain historical same-particular continuation, care and consent distinctions. No X3 reproof.
7. [PR #188](https://github.com/Tobillicious/universal-protection-theory/pull/188) already audits quantum/spectral period and return limits; [PR #191](https://github.com/Tobillicious/universal-protection-theory/pull/191) isolates the bulk-isomorphism bridge; [PR #193](https://github.com/Tobillicious/universal-protection-theory/pull/193) finite BCRD cut-map closure; [PR #194](https://github.com/Tobillicious/universal-protection-theory/pull/194) source M5/M7 seam contextual and operational orientation; [PR #195](https://github.com/Tobillicious/universal-protection-theory/pull/195) maps UPT's law and feasibility to cyclic closure. **No banked theorem in these is silently rescoped or downgraded.**
8. The older physics-lane branches named "next-universe" concern **OV-NEXT-001 port–matter exchange**, not independently verified cyclic cosmology. Do not treat a similar branch name as supporting this physical claim.

## CYCLIC-G2-JOIN-01 — the exact new corollary hiding in G2Splice

Work **inside the source's existing functional state and cut model**, not a newly imported Hilbert space. Let N be nodes, V their value type, E inputs, Part the protected particulars and Pol source policy labels. A full cut record is s:N→V. The declared dependency graph is D:N→N→Prop and the particular block is B x:N→Prop.

Assume the **already proved G2Splice.Dynamics.block_splice_run** premises:

- each B x is D-closed: Closed D (B x);
- blocks are pairwise disjoint: B x n and B y n imply x=y;
- every source-policy transition T p is LocalTo D;
- all compared runs begin at the *same* complete state s0 and receive the *same* admissible input sequence env:Nat→E.

Add two explicitly new **cyclic-domain** premises:

- **coverage:** every node lies in some protected block: ∀n, ∃x, B x n;
- **matched period:** at a specified positive circuit length h, each selected policy's source run returns to s0 **on its assigned block**:
  
  ∀x n, B x n ⇒ runIn (T (choice x)) s0 env h n = s0 n.

**Theorem CYCLIC-G2-JOIN-01:**

\[
\boxed{\mathrm{runIn}(\mathrm{blockSplice}(B,T,\mathrm{choice},p_0),s_0,\mathrm{env},h)=s_0.}
\]

**Proof (one reuse of the original theorem):** For arbitrary node n, coverage supplies x with B x n. The source's block_splice_run at step h says the spliced run equals the selected policy's run at node n. The matched-period premise says that selected run equals s0 at n. Thus the spliced run equals s0 at every node; function extensionality gives the displayed equality. **Nothing about full X3, greatestness or Hume is reproved.** QED.

**Lean-style corollary (uncompiled candidate for source reviewer):**

~~~lean
import Snuffy.G2Splice

namespace Snuffy.G2Splice.Dynamics

variable {N V E Part Pol : Type}

theorem block_splice_period_of_block_period
    (D : N → N → Prop) (B : Part → N → Prop)
    (hclosed : ∀ x, Closed D (B x))
    (hdisj : ∀ x y n, B x n → B y n → x = y)
    (hcover : ∀ n, ∃ x, B x n)
    (T : Pol → (N → V) → E → (N → V))
    (hloc : ∀ p, LocalTo D (T p))
    (choice : Part → Pol) (p₀ : Pol) (s₀ : N → V)
    (env : ℕ → E) (h : ℕ)
    (hperiod : ∀ x n, B x n →
       runIn (T (choice x)) s₀ env h n = s₀ n) :
    runIn (blockSplice B T choice p₀) s₀ env h = s₀ := by
  funext n
  obtain ⟨x, hx⟩ := hcover n
  exact (block_splice_run D B hclosed hdisj T hloc choice
    p₀ s₀ env h x n hx).trans (hperiod x n hx)

end Snuffy.G2Splice.Dynamics
~~~

The theorem is mathematically immediate from the cited **compiled** source theorem. The new Lean snippet is a **review candidate**, not a claimed successful Lean kernel run; it is deliberately outside the published compiled canon.

## CYCLIC-G9-TRANSFER — what existing UPT joins can now discharge

Let p and q be **actually admitted source policies** whose runs both close on the same full initial cut s0 at the same h against the same inputs env. For each particular x choose the policy component that attains the better **source-verified continuation/freedom grade**, as in the existing G2Splice.splice/outcome_splice construction. Under causal block locality, disjointness and coverage, CYCLIC-G2-JOIN-01 shows that the **mathematical block-spliced transition** still closes at h. The source's block_splice_keeps transports local continuation observations. G2Splice.outcome_splice proves that higher graded source components realize the stage-wise union.

This brings a previously missing component of PR #195's CYCLIC-G9 **within reach**:

\[
\text{closed p, closed q}
+\text{G2 local source blocks}
\Longrightarrow
\text{closed mathematical block-splice preserving the selected grades}.
\]

**However, one cannot silently equate** the G2Splice.splice *abstract policy* with the separately defined G2Splice.Dynamics.blockSplice **transition**. The current source contains no universally established identification of those two objects for every physical installation. For the FULL physical CYCLIC-G9 premise one still must certify:
(a) a source-implemented, admitted composite policy r whose real transition equals that block splice, including external world response and all original constraints;
(b) correspondence between the policy grade g and actual local historical continuation/free-direction readouts;
(c) matching closed end-to-start *physical* seam, not merely controller return to a prior software state; and
(d) the source's capacity/feasibility/authorization, R16 locality and original X3 provenance.

These are concrete **join interfaces**, not gaps in the earlier mathematical UPT proof.

## World-reactive caveat — reuse IR135 rather than reprove it

The source theorem block_splice_run assumes a common **external input stream env** for compared source policies. In IR135 the world can respond to the policy's actions, and the disturbance stream is consequently **policy-dependent**. The premises do not hold merely because each policy closes against its *own* reactive disturbance history.

For each reactive world, one must first source-justify either the same intervention inputs, or a stronger simulation/bisimulation correspondence between the spliced and source traces. The canon already contains IR134 actual source execution and IR135 single-policy reactive-world machinery. **Do not infer uniform cyclic physical closure across reactive worlds without that additional source correspondence.**

## Hostile control — why block locality is a real hypothesis

Binary two-node state s=(a,b), starting at s0=(0,0). Define

p(a,b)=(1−a,1−b) (flip both), and q(a,b)=(b,a) (swap).

Both source policies satisfy p²(s0)=q²(s0)=s0. But a hybrid selecting the **first output** of p and the **second output** of q evolves by

r(a,b)=(1−a,a).

Then r(s0)=(1,0) and r²(s0)=(0,1) ≠s0.

Why no contradiction? q's second output depends on the *other block's* first input, so the source hypothesis LocalTo D with the chosen singleton block does **not** hold. This is a precise, transparent failure of the unauthorized join.

## The user’s strong new necessity target

This corollary **proves a nontrivial part of compatibility** of local G2 protection dynamics with a repeated cut-state closure in the stipulated source model. It does NOT force a real closed universe to select its greatest feasible policy or prove that every physically possible closed universe is protective.

The proposed Universe ⇔ UPT bridge now reduces more sharply to:
- **BCRD physical cyclic seam** with M5/M7 tested source-faithful history/observer transport;
- **source-level implementability** of G2 policy splice under cyclic constraints and **action-reactive worlds**;
- **noncircular selection/necessity** excluding actually admissible, avoidably erasing closed histories, rather than assuming they are forbidden.

Original Hume/PNAJ, greatestness, and X3 are **already banked**. Do not reopen them.

## Local verification

Run: python evidence/physical-bridges/check_cyclic_g2_join.py

An exhaustive finite 2-bit, two-block product-control check tested **16,384** tuples of source-policy pairs, block selections, initial states and h∈{1,2,3,4}; **3,104** cases met the matched-cycle premise, all produced the spliced return, and **1,440** had a nonconstant first step. An exact hostile control demonstrates loss of closure when cross-block locality fails.

**This is a finite control of the new corollary, NOT Lean compilation or physical BCRD validation.** No canonical changes, merge, release, or X3 rewriting.
