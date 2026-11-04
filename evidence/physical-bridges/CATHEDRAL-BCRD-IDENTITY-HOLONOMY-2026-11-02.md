# CATHEDRAL-BCRD-HOLONOMY-01 — Exact identity descent around cyclic relational cuts

**Date:** 2 November 2026 NZDT
**Status:** mathematical theorem with elementary graph/path proof, finite exact local checker; one uncompiled Lean candidate. Independent physical BCRD source correspondence, real cyclic cosmology, and full original-X3 continuation remain UNPROVED.
**Disposition:** independent focused draft PR, canonical source unchanged; no merge or Zenodo release.

## 0. Motivation — an existence-first cathedral join, not a new physical substrate

The author's starting point remains **Things are. Thus things are.** Mathematical existence is not a process competing probabilistically against its own cessation. Internal dynamics cannot make a true event in one fixed complete history become a non-event in *that same history*.

The specific NEW problem is more subtle than that truth: a physically cyclic cut may return to the same observable cut configuration while a particular's **historical identity orientation** has changed. Can we prove an exact and efficient criterion for whether the same original particular is coherently transported over *all admissible refinements and cycles*?

The answer is yes as a **conditional mathematical coherence theorem** using nothing beyond BCRD native relational cuts, event identity correspondences, path composition and source-calibrated boundary readouts.

### Existing source architecture — not reconstructed here

- [Frozen BCRD B1–B7 primary source](https://github.com/Tobillicious/physics-lane/blob/2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35/orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/README.md): complete relational cuts, B5 exact process-map composition, B6 physically valid refinement/path consistency, B1 prediction and B2 ledger sufficiency. Original programme ceiling remains finite author controls, not physically proven cosmology.
- [Frozen M5 critical-pair architecture](https://github.com/Tobillicious/physics-lane/blob/2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35/orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/M5-CRITICAL-PAIR-COHERENCE.md): distinguishes M5-S strong complete process equality, M5-W weak boundary-projected equality and compensated closure. A physical response/gauge quotient needs source justification, not merely a word identity.
- [Frozen M7 fixed-intervention semantics](https://github.com/Tobillicious/physics-lane/blob/2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35/orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/M7-TIER0-INTERVENTION-SEMANTICS-GAUGE.md): changing calibration by state-dependent active feedback is not necessarily a gauge relabelling; operational response equivalence is source-defined.
- [Draft PR #194](https://github.com/Tobillicious/universal-protection-theory/pull/194): M5 contextual strong/weak coherence and an M7 cut-return whose response orientation has nontrivial monodromy. Current work gives a general **finite graph identity-descent certificate**, not another specific rotation example.
- [Draft PR #199](https://github.com/Tobillicious/universal-protection-theory/pull/199): observer phase can return without complete historical state recurrence.
- [Draft PR #201](https://github.com/Tobillicious/universal-protection-theory/pull/201): actual IR128-certified history embeddings compose and retain old source-live witnesses and distinctions. IR128 only provides **injections** in general; it does not automatically supply two-sided inverse maps for every real physical cut.
- [Original IR132 exact boundary reconstruction](https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/physical-bridges/PhysicalBridges/IR132ExactBoundaryReconstruction.lean): a logical history variable is exactly recoverable from a cut readout only when constant on the readout fibres. An unseparating readout cannot prove identity preservation.
- [Original IR116 cumulative duties](https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/physical-bridges/PhysicalBridges/IR116CumulativeSubjectDuties.lean): accounting for owed particulars must not silently reset across source transitions. Still distinct from their subjective physical continuity and full X3 option rights.

No new Hamiltonian or Hilbert-space dynamics is introduced.

## 1. HIST-HOLONOMY-01 — globally coherent historical identity iff fundamental cycles fix it

Let a **finite connected undirected graph** Γ=(V,E) index cuts, with one reference root r. Its unoriented edge u—v signifies that a **bidirectionally source-certified historical identity correspondence** can be compared between these two cuts. This graph is a mathematical index of *valid cut comparisons*, **not** an assumption that actual microscopic physical time can be reversed. Require a historical label set L_v at each cut and an actual historical correspondence

\[
f_{uv}:L_u\overset{\sim}{\longrightarrow}L_v,\qquad f_{vu}=f_{uv}^{-1}.
\]

Here the correspondences are bijections *on the certified comparison fibres*. This is substantially stronger than BCRD B5 exact composition of arbitrary (possibly noninjective) process maps. No real inter-universe bijection or full physical identity semantics is assumed to have been derived.

Choose a spanning tree τ of Γ. For each vertex v, let T_v:L_r→L_v be the unique composite transport along the tree path r→v. Thus T_r=id, and tree edges are exactly coherent by construction.

Every **non-tree edge** e=(u,v) supplies a root-label holonomy

\[
\boxed{H_e=T_v^{-1}\circ f_{uv}\circ T_u:L_r\to L_r.}
\]

A coherent global section through a chosen original subject x∈L_r is an assignment s_v∈L_v satisfying s_r=x and f_uv(s_u)=s_v along *all* edges.

**Theorem HIST-HOLONOMY-01:**

\[
\boxed{
\text{Global coherent section through }x
\iff
\forall e\in E\setminus\tau,\quad H_e(x)=x.
}
\]

**Proof, necessity:** on each tree edge any coherent section is forced to equal s_v=T_v(x), by induction along the unique tree path. On every chord u→v, the edge equation is f_uv(T_u(x))=T_v(x). Apply T_v^{-1} to give H_e(x)=x.

**Proof, sufficiency:** define s_v:=T_v(x) on all vertices. Each tree edge is coherent by the definition of T. Each non-tree edge is coherent because H_e(x)=x implies f_uv(T_u(x))=T_v(x). Hence every edge is coherent. QED.

**Every particular, not one distinguished anchor:** all labels in L_r have coherent sections iff **every** chord holonomy is the identity map. This follows pointwise from the previous iff:

\[
\boxed{
\forall x\in L_r,\;\text{coherent section through }x
\iff
\forall e\in E\setminus\tau,\quad H_e=\mathrm{id}_{L_r}.
}
\tag{FULL-HIST-FLATNESS}
\]

For a finite connected graph the spanning tree has |V|−1 edges, so the number of independent chord conditions is exactly

\[
\boxed{\beta_1(\Gamma)=|E|-|V|+1.}
\]

This is a finite **basis of conditions**, not an assertion that physical BCRD conditions are independent stochastic events. The theorem is a standard discrete holonomy/descent argument newly joined here to the source's historical-identity obligations.

### Important semantics

A source-certified particular's identity is **not** assumed to be any arbitrary short string label. It requires a physically grounded old-to-new particular identification and intervention/continuity semantics. One must not silently promote a label permutation to real subject transport. The theorem states *what to test if and when* such authentic identity fibres can be extracted from BCRD.

## 2. HIST-HOLONOMY-02 — calibration and gauge invariance of the certificate

Let g_v:L_v→L_v be a legitimate, independently source-approved change of local cut coordinates, and transform each edge by

\[
f'_{uv}=g_v\circ f_{uv}\circ g_u^{-1}.
\]

The corresponding tree transport is T'_v=g_v∘T_v∘g_r^{-1}, so each chord holonomy is conjugated at the root:

\[
\boxed{H'_e=g_r\circ H_e\circ g_r^{-1}.}
\]

Therefore the set of coherent root subjects is carried bijectively by g_r and complete flatness H_e=id is invariant. This theorem proves the diagnosis cannot be changed by mere **legitimate passive relabellings**.

**BCRD M7 redline:** An arbitrary physical change of a calibrated intervention protocol is not automatically a legitimate g_v. The M7 source differentiates actual active feedback from coordinate gauge. The mathematical theorem only covers *certified re-descriptions*, not unauthorized replacement of physical interventions.

## 3. HIST-HOLONOMY-03 — weak boundary coherence cannot certify full historical flatness

Let b:L_r→B be the actual calibrated root-cut historical readout. Suppose a loop with holonomy H looks unchanged at the level of that readout:

\[
\forall x,\quad b(Hx)=b(x).
\]

If b is injective on the **source-defined historical identity domain**, then b(Hx)=b(x) implies Hx=x for each x, so H=id.

Thus:

\[
\boxed{
\left[b\circ H=b\;\land\;b\text{ injective}\right]
\Longrightarrow H=\mathrm{id}.
}
\tag{CUT-SEPARATION}
\]

Conversely, if H≠id and b∘H=b, then b is necessarily noninjective. Any undetected identity permutation is hidden inside a nonseparating readout fibre, precisely the issue isolated in IR132. This is a specific algebraic junction of **M5-S versus M5-W** with the original IR132 source criterion, not a new detector or physical capture claim.

No claim that all physical BCRD readouts are injective on historical identities: B1 predicts future observable signatures, which need not reconstruct past identities. B2 ledger completeness for conserved distinctions is not automatically *history reconstruction*.

## 4. HIST-HOLONOMY-04 — finite closed cohort injections force invertibility, but infinite ones need not

IR128 gives injective old-source embeddings, not automatically bijective correspondences. However, for a **finite actual closed sequence** of historical fibres

\[
L_0\hookrightarrow L_1\hookrightarrow\cdots\hookrightarrow L_m=L_0
\]

with **all fibres finite and each seam injection source-validated**, cardinalities obey

\[
|L_0|\le|L_1|\le\cdots\le|L_m|=|L_0|.
\]

Hence all cardinalities are equal; each injection is a bijection. This provides an exact conditional bridge from *finite closed injective* source embeddings to the invertible history fibres used by HIST-HOLONOMY-01.

It does **not** establish that a physically closed cosmogenic cut has finite subject/history fibres or that its final historical fibre is actually identical to its starting one. A closed *observer phase* is weaker than an equal complete history cut.

**Infinite countercontrol:** the injection n↦n+1 of ℕ into itself is not surjective. Even a repeated type name or observer phase can conceal new historical-index drift on an infinite fibre.

## 5. Hostile countermodel — one protected history can coexist with two twisted histories

Take a 3-cut triangle and three historical labels a,b,c at each cut. Tree edges carry identity correspondences, but the closing chord exchanges b and c while fixing a. All edge maps are mathematically bijective and compose exactly.

- Around the cycle, a returns to a: its coherent section exists.
- Around the same cycle, b returns to c and c returns to b: neither has a single-valued global identity section.
- The coarse readout b(a)=0 and b(b)=b(c)=1 is unchanged after the cycle despite the nontrivial historical twist.

This is a finite exact **logical** countercontrol: full mathematical compositional consistency of cuts and weak boundary equality do not guarantee coherent identity for every historical particular. It does NOT prove the actual original BCRD permits this historical twist under its full strong M5, M7 and B1–B7 physical constraints. If the independent physical source rules out such twists, the new theorem turns that into a clean positive certificate.

This is particularly relevant to original X3: verifying one standing subject is not the same as ensuring **every historical subject** has coherent identity and free opportunities. Original full X3 additionally concerns *active subjective continuation and authorized options*, which no holonomy check alone establishes.

## 6. Exact outstanding source joins

To upgrade the mathematical theorem to a physically meaningful necessity result, do not assume the UPT result as a premise. Instead derive from the original BCRD physical source:

1. **Identity fibres:** an independently valid criterion for a historical particular and for valid correspondences between physically admitted BCRD cuts; show which cut relations are invertible on the exact historical domain and which are only injections.
2. **Source-complete comparison network:** all physically admitted cuts and admissible refinements, including external interventions and hidden channels; avoid presenting an incomplete observed graph as a complete physical event graph.
3. **Flatness or fixed-point constraint:** derive each independent chord holonomy's identity action (or preservation of each original identity if the fibre is restricted), using actually established M5 strong/compensated composition and M7 source-calibrated interventions, not just M5-W coarse equality.
4. **Physical continuation:** join the newly coherent identities to original IR116 duties, IR131 genuine choices, original October particular-continuation source semantics, and full unchanged X3. Recorded past existence is necessary but **not sufficient** for currently living subject activity or authorized physical freedom.

The principal positive theorem target is thus:

\[
\begin{gathered}
\text{actual source-complete BCRD cut graph}\\
+\text{source-faithful historical identity fibres}\\
+\text{independently certified holonomy flatness}\\
+\text{original X3 physical continuation/agency bridges}\\
\Longrightarrow\text{global original-subject continuity/rights on all admitted cuts}.
\end{gathered}
\]

It is not legitimate to call a physical ender "logically impossible" merely because it would violate a *condition not yet derived* from the physical source. The exact mathematical non-retroactivity claim from #201 remains true but does not itself imply physically infinite individual continuation.

## 7. Verification and review boundary

Checker: evidence/physical-bridges/check_bcrd_identity_holonomy.py, Python stdlib, exact integer/permutation computations and direct coherent-section comparison. Locally executed and passed:

- 44 connected labelled undirected graphs with 1–4 cuts;
- 117,230 labelled correspondence systems across 1–3 identity labels;
- 350,955 specific subject-label section tests;
- 253,791 independent chord/holonomy checks;
- 8,726 fully flat systems, 108,504 nontrivial holonomy systems;
- 26,028 systems with only some labels admitting global coherent sections;
- 216 exact local gauge-relabelled versions of the 3-cut hostile example;
- coarse readout vs separating readout controls, all root gauge conjugacy checks for <=4 labels, finite-injection return obstruction.

All exact local controls are author-side **mathematical diagnostics**. The Lean file is a **candidate not built in this environment**, not a new Lean kernel certificate. No independent physics, cosmic cycle, original X3 physical guardian, or universal multiverse conclusion is asserted.

**One-sentence result:** a genuine identity-preserving cyclic BCRD history would have to pass an exact, gauge-stable **E−V+1 chord-holonomy flatness certificate** on original historical identity data. This isolates an important missing noncircular source bridge and does so without any new Hamiltonians or Hilbert-space mechanics.
