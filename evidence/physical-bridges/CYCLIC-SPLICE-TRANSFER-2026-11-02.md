# Cyclic splicing from the existing UPT dynamics

2 November 2026. Research continuation of PR #195, integrated with PR #205. Mathematical derivation in the stated controlled-state model; physical application remains conditional.

The new question is whether the existing policy-combining construction retains cyclic consistency. The earlier Hume argument, original preservation order, and X3 results retain their original statements and conditions. This note does not rederive them.

## Source record

The pasted conversation ends at an earlier version of [PR #195](https://github.com/Tobillicious/universal-protection-theory/pull/195). Its current head, `d2cbb38a6740a5ecdc67116038953beada0d8eb7`, already contains **UPT-CYCLIC-EXISTING-PROOF-TRANSFER-2026-11-02.md**. That addendum identifies CYCLIC-G9, history transport and physical selection as the new joins. Merely restating those obligations would repeat existing work.

The following source files were read and their Git blob SHAs checked against UPT commit `26abaa24b7e0f5715de0e9c85a25149adfbb5435`:

- [G2Splice.lean](https://github.com/Tobillicious/universal-protection-theory/blob/26abaa24b7e0f5715de0e9c85a25149adfbb5435/evidence/compiled-strongest/lean/Snuffy/G2Splice.lean): `block_splice_run`, `block_splice_keeps`, `splice_grade`, `outcome_splice`, `union_realizable`.
- [R16Cut.lean](https://github.com/Tobillicious/universal-protection-theory/blob/26abaa24b7e0f5715de0e9c85a25149adfbb5435/evidence/compiled-strongest/lean/Snuffy/R16Cut.lean): `LocalTo`, `AgreeOn`, `closed_cut_step`.
- [CommonPolicyTop.lean](https://github.com/Tobillicious/universal-protection-theory/blob/26abaa24b7e0f5715de0e9c85a25149adfbb5435/evidence/compiled-strongest/lean/Snuffy/CommonPolicyTop.lean): `top_policy_exists`, `top_policy_greatest`.
- [Compiled master, G.9 and G.11](https://github.com/Tobillicious/universal-protection-theory/blob/26abaa24b7e0f5715de0e9c85a25149adfbb5435/evidence/compiled-strongest/SNUFFY-UPT-STRONGEST-MASTER.md#L2564): the existing dynamics construction and its full physical correspondence obligation.

The original [BCRD specification](https://github.com/Tobillicious/physics-lane/blob/2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35/orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/README.md) and [M5 coherence source](https://github.com/Tobillicious/physics-lane/blob/2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35/orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/M5-CRITICAL-PAIR-COHERENCE.md) were also read. Their B1–B7 conditions do not themselves establish the seam or exact disjoint block structure used below.

## 1. New shared-cut transfer theorem

Let the modeled source state be a node assignment \(s\in S=V^{\mathcal N}\). Let \((B_x)_x\) be pairwise disjoint blocks covering **every modeled state node**. A dependency relation \(D\) closes each block, and each policy transition \(T_p:S\to S\) is `LocalTo D` in the existing R16 sense. These are the original G2 dynamics hypotheses, with complete coverage made explicit. This autonomous form is the source theorem with environment type `Unit`.

Fix a common starting state \(s_*\), a positive step count \(n\), and a policy-independent seam \(\sigma:S\to S\). Suppose \(\sigma\) is injective on the relevant modeled physical states. Define the closed-policy fiber

\[
P_{\sigma,s_*,n}=\{p:\sigma(T_p^n(s_*))=s_*\}.
\]

**Theorem CYCLIC-SPLICE-03A.** For any nonempty collection of policies in this fiber, choose one policy \(c(x)\) for each block. Form the source's block-spliced transition \(T_c\). Then

\[
\boxed{\sigma(T_c^n(s_*))=s_*.}
\]

Moreover, throughout the segment, the spliced trajectory on each block is exactly the chosen original trajectory on that block.

**Proof.** The final assertion is the existing `G2Splice.block_splice_run`, specialized to the autonomous case. For any two closed original policies \(p,q\),

\[
\sigma(T_p^n(s_*))=s_*=\sigma(T_q^n(s_*)),
\]

so injectivity gives identical terminal states. Choose one such terminal state \(t_*\). At time \(n\), block agreement says that \(T_c^n(s_*)\) equals \(t_*\) on each block. Complete coverage makes these states equal everywhere. Applying \(\sigma\) gives the claimed closure. □

**Useful strengthening:** this theorem imposes no block-locality restriction on the seam. It can mix block coordinates. Shared starting data and seam injectivity already force a single terminal state.

The policy maps here are the existing controlled-source family \(T_p\). This theorem does not prove that alternative controllers can all inhabit one physically complete universal state with identical initial data. Identifying the controlled model with the actual closed world remains part of the physical application.

## 2. The resulting CYCLIC-G9 transfer

Suppose each particular's existing source-grounded continuation/freedom grade is determined by its own complete block trajectory over the segment. Equality of those trajectories therefore preserves its grade. This is an application condition on the existing outcome interpretation; synthetic labels cannot establish it.

For two closed policies \(p,q\), select the higher-grade original policy on each block, as `G2Splice.splice` already does. Trace agreement preserves that selected grade; `splice_grade` gives its maximum. Consequently `outcome_splice` gives, stage by stage,

\[
\mathcal O(p\sqcup q)=\mathcal O(p)\cup\mathcal O(q)
\]

for the original four stages \((L_E,F_E,L_N,F_N)\). The new theorem establishes **dynamic cyclic closure** of this same splice in the shared-cut fiber.

If the source's physical implementation and resource certificates also admit the block-spliced policy, this establishes CYCLIC-G9 on that fiber. If this nonempty closed-policy space is compact and each fact-realization set is closed, the existing `CommonPolicyTop.top_policy_greatest` applies directly and supplies a greatest **closed** policy. No new greatestness proof is needed.

For a finite nonempty family that is closed under the grade-selected splice, the greatest realized outcome follows by iterating the same binary operation. For an infinite family, compactness/closed realization must still be supplied; injectivity alone supplies neither.

This conclusion concerns one specified modeled fiber. A controller that works uniformly across different worlds or starting cuts requires a further uniform construction; it does not follow by choosing a different best policy separately in each world.

## 3. Exact criterion when the seam is not injective

Define the seam fiber

\[
F_{s_*}=\sigma^{-1}(\{s_*\}).
\]

For \(u,v\in S\), write \(\operatorname{mix}_J(u,v)\) for the state taking \(u\)'s values on blocks in \(J\), and \(v\)'s values on all other blocks.

**Theorem CYCLIC-SPLICE-03B.** For two original closed policies and their block splice,

\[
T_c^n(s_*)=\operatorname{mix}_J(T_p^n(s_*),T_q^n(s_*)).
\]

Thus the splice closes **exactly when this mixed endpoint belongs to** \(F_{s_*}\). In particular, every binary block splice closes if the fiber is closed under these mixes. Injective seams satisfy this automatically because every nonempty fiber is a singleton.

**Proof.** Apply source block agreement at time \(n\), then the definition of seam closure. □

For a finite block partition, mixing-closed fibers are precisely the products of their block projections, often called rectangular sets. If arbitrary constant local endpoint policies are available, rectangularity is also necessary for universal binary splice closure: take any two endpoints in the fiber, realize them by constant local transitions, and splice the selected blocks. A nonrectangular mix then witnesses failure. This converse describes the abstract model; it does not assert those constant policies are physically realizable.

This gives an explicit seam test rather than another assumed preservation rule.

## 4. Limits demonstrated by exact controls

1. **Noninjective, nonrectangular seam.** On two bits, let \(\sigma(a,b)=(a\mathbin\oplus b,0)\) and \(s_*=(0,0)\). Constant endpoint policies ending at \((0,0)\) and \((1,1)\) both close. Their mixed endpoint \((0,1)\) does not. Dynamic locality alone does not repair this seam.
2. **Different starting cuts.** On three bits, let \(\sigma(a,b,c)=(b,a,1-c)\). The active policy \(p(a,b,c)=(a,b,1-c)\) closes from \((0,0,0)\); \(q(a,b,c)=(1-a,1-b,1-c)\) closes from \((0,1,0)\). Taking the first block from \(p\), the second from \(q\), and the phase block from \(p\), including the mixed seed, fails closure. Hence an injective seam alone does not establish G9 across arbitrary starting cuts. A block-local seam, compatible choices along transported blocks, or another source-derived gluing condition would be needed there.
3. **Uncovered carrier.** With identity seam and seed \((0,0)\), both \(p(a,b)=(a,b\oplus a)\) and \(q(a,b)=(1-a,b)\) close after two steps. Taking only the first bit from \(q\) and leaving the interacting second bit under default \(p\) ends at \((0,1)\). Every seam-relevant node must be covered by the agreement argument, or separately certified.
4. **Shared budget.** Policies toggling only the first or only the second bit each close after two steps and each cost one active controller. Their splice toggles both and closes, but costs two. A budget of one rejects it. Dynamic closure does not prove funded physical feasibility.

These controls concern explicit missing hypotheses of the transfer result. They are not countermodels to the full physical BCRD programme or the original X3 theorem.

## 5. What advances, and what remains

The new implication is

\[
\begin{gathered}
\text{existing exact closed-block dynamics}\\
+\ \text{shared cut and period}\\
+\ \text{injective physical seam}\\
\Longrightarrow\ \text{block-spliced dynamics remain cyclic}.
\end{gathered}
\]

Together with the existing local outcome semantics and admitted, funded implementation, this transfers the original union-realizability construction into that cyclic fiber. This removes a specific seam-consistency obstruction under explicit, independently testable hypotheses.

It does not yet prove \(\text{Universe}\Leftrightarrow\text{UPT}\). The next source-specific work is to identify which true closed-policy family shares these cuts, certify the physical seam and outcome provenance, and check the combined resources and controller realization. Applying the result to the whole family requires a justified relationship between different fibers. Establishing that actual physical dynamics selects or instantiates the greatest policy remains the separate necessity direction already named in PR #195.

The compiled G.11 already records the need for full physical policy/outcome correspondence, including interacting records, shared constraints and successful effect delivery on one execution. BCRD B7 also asks for state-dependent locality; this note uses the certified G2 block model and does not establish B7.

## Verification

Run `python3 check_cyclic_splice_transfer.py`. The accompanying standard-library verifier checks all 24 bijective seams on four states, all 16 independent two-bit transition policies, four shared seeds, segment lengths one through four, all closed ordered policy pairs, all four binary block selections, and four-stage union outcomes using an explicitly synthetic local trace grade. It also checks the fiber criterion for all 256 total seams and all 1,024 target fibers, and executes the four missing-hypothesis controls above.

**Observed result: PASS.** There were 7,872 closed ordered policy-pair cases, 31,488 verified block splices (21,504 with internal state changes), and 7,872 four-stage union checks. The fiber checks and all four missing-hypothesis controls passed. Exact counts are saved in `cyclic-splice-verification.json`.

The original finite checks exercise the mathematical argument above. The Lean kernel check for the newly formalized boundary and PR #205 join is reported below; physical continuation and cosmological application retain their source obligations.

## 6. Join with PR #205: safe selectors and cyclic splices

The source for this integration is [PR #205 at c2ce0dadaefaf750ed24c9a48d623de76af5808a](https://github.com/Tobillicious/universal-protection-theory/tree/c2ce0dadaefaf750ed24c9a48d623de76af5808a/evidence/physical-bridges). Its exact theorem is `guardian_exists_iff_fibre_has_common_action`.

Let the actual modeled source state be \(s\), the guardian's cut quotient be \(\pi\), and define

\[
A_{\rm safe}(s)=\{a:\mathrm{Allowed}(s,a)\land
  \forall t,\ \mathrm{Step}(s,a,t)\Rightarrow P(t)\}.
\]

PR #205 establishes that a cut-only safe selector exists precisely when

\[
\forall o,\quad
\bigcap_{s:\,\pi(s)=o,\ P(s)} A_{\rm safe}(s)\ne\varnothing.
\]

This requires a common safe action on each protected fibre. It does **not** require the entire sets \(A_{\rm safe}(s)\) to be identical on that fibre. Factoring those sets through \(\pi\), together with nonempty safe choices, is sufficient. Factoring empty sets is insufficient. The new Lean lemma `factored_nonempty_actions_have_fibre_guard` makes this stronger sufficient route explicit; the finite verifier checks both distinctions.

### The minimal Lean 4 boundary

The committed module `PhysicalBridges/CyclicSpliceTransfer.lean` states and proves:

```lean
theorem injective_seam_splice_closed
    (block : Block → Node → Prop)
    (hCover : ∀ n, ∃ b, block b n)
    (seam : (Node → Value) → (Node → Value))
    (hInjective : Function.Injective seam)
    (initial reference : Node → Value)
    (terminal : Block → (Node → Value))
    (spliced : Node → Value)
    (hReference : seam reference = initial)
    (hClosed : ∀ b, seam (terminal b) = initial)
    (hAgreement : ∀ b n, block b n → spliced n = terminal b n) :
    seam spliced = initial
```

The proof uses seam injectivity to identify every donor terminal cut with the closed reference, then uses covering block agreement to identify the spliced cut with that reference. `G2Splice.block_splice_run` supplies the agreement when the cut is the complete modeled node assignment. The run's common starting cut and period appear in the shared endpoint-closure target; the minimal endpoint theorem needs no additional time parameter.

### The joined guardian theorem

`fibre_common_guardian_preserves_cyclic_splices` takes PR #205's `FibreHasGuard`, constructs its cut-only policy, and concludes for every endpoint reached along a finite source path executing that policy:

\[
P(s_{\rm splice})\quad\land\quad
\sigma(\pi(s_{\rm splice}))=\pi(s_{\rm initial}),
\]

provided its cut agrees blockwise with the closed donor cuts. Protection is inherited directly from PR #205's finite guarded-path theorem; endpoint closure is inherited from the new injective-seam theorem.

There are two explicit interfaces:

1. **The mixed action is actually fibre-common safe.** The splice trace must execute the selected guardian action (`IR109.PolicyReach` in the Lean statement). Safety of separate donor policies does not itself make every mixed action safe. A splice-closed common safe-action set, or an independently justified product of local safe-action sets, can discharge that composition obligation. Actual physical effects require the source-mediation certificate already identified in PR #205.
2. **Block agreement holds on the cut used for seam closure.** If \(\pi\) is a lossy quotient, its compatibility with block mixing must be established. An injective seam on quotient values cannot recover distinctions already discarded by \(\pi\). The original full-cut realization satisfies this interface by using the identity cut. A coarse guardian selector may also be lifted to a finer cut using PR #205's existing refinement theorem.

The verifier contains two decisive controls. With \(P=\{00,11\}\), both the identity and the double-bit flip are safe, while their single-bit splice visits an unsafe state before closing after two steps. Separately, the parity quotient identifies terminal states \(00\) and \(11\), but their mix \(01\) has a different parity: even an identity seam on that quotient does not close the splice without cut compatibility. These delimit the implication precisely.

### Kernel check and replay

The baseline PR #205 candidate was marked uncompiled. Compiling it exposed a reserved `protected` binder, an induction hypothesis incorrectly applied as a function, and an unavailable contradiction tactic. The integration escapes the original binder name and repairs those two proof terms; theorem statements and physical hypotheses retain their original meaning.

The repaired PR #205 module and all three new transfer lemmas were checked with the repository's pinned **Lean 4.35.0**, together with their original source dependencies. An axiom inspection covers the minimal seam theorem, factorization corollary, joined guardian theorem and original guardian iff. It contains no placeholder proof axiom.

From the repository root, replay the standalone finite verifiers:

```bash
python3 evidence/physical-bridges/check_cyclic_splice_transfer.py
python3 evidence/physical-bridges/check_bcrd_cut_guard_fibres.py
```

For Lean, stage the five unchanged inherited controller sources as documented in `evidence/physical-bridges/README.md`, then run:

```bash
cd evidence/physical-bridges
lake build PhysicalBridges.CyclicSpliceTransfer
```

The expanded splice verifier preserves the original **31,488** splice checks and adds **65,536** cut/protection/trace configurations. Of those, **17,632** satisfy the checked guarded-execution conditions, yielding **2,297,856** guarded closed-splice instances when joined to the original splice cases. These are finite modeled instances, not counts of physically verified guardians. The original PR #205 verifier separately passes its **65,536** action models and **288** first-breach paths.

The module, verifier, verification record and this note are integrated on PR #205's research branch. The canonical UPT manuscript and original X3 statements remain unchanged. Physical universal protection and the universe–UPT equivalence retain their independently stated obligations.
