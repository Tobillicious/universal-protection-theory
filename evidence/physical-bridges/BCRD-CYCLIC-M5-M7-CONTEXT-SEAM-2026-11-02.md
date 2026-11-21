# BCRD-CYCLE-05 — M5 cyclic context separation and M7 calibrated seam holonomy

**Date:** 2026-11-02 (NZDT)
**Record:** Source-anchored **new finite/concrete cyclic-extension theorems**. Noncanonical draft, not proof of cosmic circularity, original UPT/X3 physical instantiation, or a full BCRD trace in arbitrary microscopic models. No Hilbert-space representation, Hamiltonian, or externally running time.

## 0. Earlier source proofs kept intact — no repetition of X3

Source anchors (frozen physics-lane commit 2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35):

- [BCRD original README](https://github.com/Tobillicious/physics-lane/blob/2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35/orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/README.md): native cut/event algebra, open process composition, B1 future-predictive completeness; B2 ledger; B3 calibrated intervention response; B4 spectator controls; B5 exact composition; B6 refinement independence; B7 state-dependent locality as research target.
- [M5 critical-pair coherence architecture](https://github.com/Tobillicious/physics-lane/blob/2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35/orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/M5-CRITICAL-PAIR-COHERENCE.md): already distinguishes **M5-S full-process equality** from **M5-W weaker boundary restriction** and M5-C compensated mismatch; strong/weak differentiation is not new here.
- [M7 Tier-0 calibrated intervention/gauge semantics](https://github.com/Tobillicious/physics-lane/blob/2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35/orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/M7-TIER0-INTERVENTION-SEMANTICS-GAUGE.md): already proves finite author-side kernel/protocol quotient results, with fixed intervention protocols and warning against state-dependent recalibration as mere gauge. In particular, operational kernel K_b=ker a_b and fibre E_b=V/K_b are source-provided, not an invention of this PR. Programme-wide M7 and physical geometry were not established by that frozen checkpoint.
- [PR #193](https://github.com/Tobillicious/universal-protection-theory/pull/193) added the finite cut algebra \(\mathcal B_X=\mathcal P(X)\), its join-preserving \(\Phi_R\) representation, cyclic loop-consistency tests, and BCRD source P0/N1/N2 physical quotient controls.
- [October original X3 continuation/source bridge](https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/physical-bridges/OCT10-PARTICULAR-CONTINUATION-SOURCE-SEMANTIC-BRIDGE.md) and [IR102](https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/physical-bridges/PhysicalBridges/IR102SectorSemanticBridge.lean) preserve original particular/protection obligations; none are reproved or overwritten here.

**NEW cyclic-extension targets:** (a) precisely how powerful closing contexts must be to distinguish processes that agree on a coarse exterior boundary; (b) how calibrated M7 intervention-response classes transport across a cyclic seam, including nontrivial orientation/monodromy even when the base cut returns.

## 1. M5-CYCLIC-CONTEXT-05 — all cyclic contexts separate complete finite processes

Fix finite nonempty physical cut-record sets X,Y. Work in the *specified finite classical control realization* of PR #193:
\[
\mathcal B_X=\mathcal P(X),\quad \Phi_R(A)=\{y:\exists x\in A\ R(x,y)\},
\qquad R\subseteq X\times Y.
\]
Given an **admitted** closing context \(C\subseteq Y\times X\) define the complete loop-start set
\[
L_C(R):=\{x\in X:\exists y\in Y\ [R(x,y)\land C(y,x)]\}
=\operatorname{Loop}_{\rm id}(\Phi_C\circ\Phi_R).
\]

**Theorem M5-CYCLIC-CONTEXT-05 (unrestricted finite relation category):**
\[
\boxed{R=S\iff \forall C\subseteq Y\times X,\quad L_C(R)=L_C(S).}
\]
Equivalently, all finite cyclic contexts distinguish the complete relational process map, not merely its coarse exterior projection.

**Proof:** If R=S, all compositions and their loop sets agree. Conversely, suppose R≠S. Without loss, there is \((x_*,y_*)\in R\setminus S\). Choose the allowed *mathematical selector* closing relation \(C_*=\{(y_*,x_*)\}\). Then \(x_*\in L_{C_*}(R)\). But \(x_*\notin L_{C_*}(S)\): the only possible closing intermediate record is \(y_*\), and S lacks that pair. This contradicts equality of all contextual loop sets. Hence R=S. QED.

**Critical scope restriction:** The converse requires access to the **full family of selector contexts C**, not just whatever coarse physical contexts are source-authorized. If real BCRD only admits a restricted class \(\mathscr C_{\rm phys}\), the theorem instead defines an operational equivalence relation \(R\equiv_{\mathscr C_{\rm phys}}S\) iff their \(L_C\) agree for every admitted C. It must then be proven from BCRD source/instruments whether \(\mathscr C_{\rm phys}\) separates the claimed physical distinctions; do not silently promote mathematical selectors into physically allowed interventions.

**Relation to existing M5-S/W:** Exact M5-S full process equality is stable under every subsequent context and cyclic closure *in this finite realization*. M5-W coarse-output equality alone is not stable against contexts that genuinely observe forgotten intermediate distinctions. This is not a new M5 proof; it is the exact **cyclic contextual consequence and converse**.

**Weak coherence countermodel:** Let X=Y={0,1}, R=identity and S=bit flip. Let the coarse terminal observation \(r:Y\to\{*\}\) forget the bit. Then r∘R and r∘S are equal as coarse relations. But with the identity closing context, \(L_{\mathrm{id}}(R)=\{0,1\}\) and \(L_{\mathrm{id}}(S)=\varnothing\). This is not a BCRD-ready admissible quotient if the bit is causally or ledger-relevant at the seam. It demonstrates exactly why B1/B2 and source-approved context coverage must be checked before claiming closure from a coarse record.

## 2. M7-SEAM-05 — calibrated operational-response quotient transport

The following is a **general elementary linear theorem** framed on M7's *existing* operational primitives; it does not assume M7's specific quantum representation or introduce new Hamiltonian/Hilbert machinery.

Let B be a set of source-identified boundary configurations. Let V be the **fixed** (boundary-state-independent) vector space of calibrated intervention protocols, in accord with frozen M7. For each \(b\in B\), let \(W_b\) be the physically declared observable infinitesimal response space and
\[
a_b:V\longrightarrow W_b
\]
a linear response anchor, as in the source's Tier-0 setup. Set \(K_b:=\ker a_b\) and \(E_b:=V/K_b\). Let \(\sigma:B\to B\) be a candidate **cyclic seam bijection**. Let \(S:V\xrightarrow{\sim}V\) be one *fixed, state-independent*, source-admissible protocol relabeling and \(\tau_b:W_b\xrightarrow{\sim}W_{\sigma b}\) be source-admissible response identifications. Require exact seam covariance
\[
\boxed{a_{\sigma b}(S v)=\tau_b(a_b(v)),\quad\forall b,v.}\tag{COV}
\]

**Theorem M7-SEAM-05A (quotient transport):** Under (COV), S induces a well-defined **bijection**
\[
\boxed{\bar S_b:E_b\overset{\sim}{\longrightarrow}E_{\sigma b},\qquad
[v]_{K_b}\mapsto[Sv]_{K_{\sigma b}}.}
\]
**Proof:** If v−w∈K_b then a_b(v−w)=0; (COV) implies \(a_{\sigma b}(S(v-w))=\tau_b(0)=0\); so S(v−w)∈K_{\sigma b}. Invertibility of S and τ_b implies \(S(K_b)=K_{\sigma b}\), so the induced map has a well-defined inverse from S^−1. QED.

**Theorem M7-SEAM-05B (cyclic monodromy obstruction):** If \(\sigma^N b=b\), then the N-fold seam transport induces an automorphism
\[
\operatorname{Mon}_b:E_b\to E_b,\qquad [v]\mapsto[S^N v].
\]
A *specific physically calibrated intervention class* returns exactly to its original operational class after N seams **iff**
\[
\boxed{S^N v-v\in K_b}
\quad\text{equivalently}\quad
a_b(S^N v)=a_b(v).
\]
By itself, \(\sigma^N b=b\) does not imply that condition. All protocol classes return only if \(S^N\) induces the identity on \(E_b\). A nontrivial monodromy can return to identity after a multiple of N, or never, depending on the source-admitted structure.

**Proof:** Applying the quotient transport N times around the closed seam sends [v] to [S^N v] in the same quotient \(E_b\). Equality of these classes means precisely \(S^N v-v\in K_b\). Definition of kernel gives the equivalent response equality. QED.

**Interpretation discipline:** \(\tau_b\) may be an observer/readout relabeling. Whether nontrivial monodromy is a **physical distinction** or a **gauge/readout re-description** is not settled by this theorem. It depends on original source-calibrated intervention and outcome semantics; the theorem is a diagnostic, not a cosmological claim.

## 3. M7-SEAM-05C — exact real-linear orientation example

No imported physical clock, no Hilbert space. Use two cut configurations \(B=\{0,1\}\) and a candidate seam swapping them, \(\sigma(0)=1,\sigma(1)=0\). Let \(V=\mathbb R^2\) with **fixed** calibrated protocol labels \(v=(u,w)\). Set two state-dependent operational anchors
\[
a_0(u,w)=w,\qquad a_1(u,w)=u.
\]
These have different kernels \(K_0=\{(u,0)\}\) and \(K_1=\{(0,w)\}\), paralleling M7's state-dependent protocol-equivalence principle in a minimal real-linear control.

Take the globally fixed invertible protocol identification
\[
S(u,w)=(w,-u),\qquad
\tau_0(z)=z,\quad\tau_1(z)=-z.
\]
Then
\[
a_1(S(u,w))=w=\tau_0(a_0(u,w)),\\
a_0(S(u,w))=-u=\tau_1(a_1(u,w)).
\]
Hence the covariance condition holds, and S carries the kernels appropriately.

Yet \(\sigma^2(0)=0\) and \(S^2=-I\), so the **base cut returns after two seams while the operational class has sign monodromy**:
\[
a_0(S^2 v)=-a_0(v).
\]
For example, \(v=(0,1)\) has outcome \(1\) initially and \(-1\) after two seams (under fixed source-calibrated numeric readout). After four seams \(S^4=I\) and the class returns exactly.

**Significance:** A periodic boundary configuration does not automatically guarantee exact recurrence of the *observer/intervention orientation* needed to compare internal event histories. Depending on what is physically identified vs gauge, orientation monodromy can be an essential extra invariant in an ERR proof. This directly addresses the observer-orientation aspect of the original *matterspacetime* conjecture **as a mathematical toy**, not an assertion about the universe.

## 3A. M7-SEAM-05D — direct exact test against the original frozen M7 anchor

The previous Section 3 is a simplified real-linear model. We can go one step closer to **the actual already-derived frozen M7 Tier-0 source** without introducing any Hilbert-space representation ourselves.

The source's one-parity operational response anchor is, with its fixed sign convention,
\[
\boxed{a_r(v)=-v\times r},\qquad r,v\in\mathbb R^3,\ r\ne0.
\]
Its source-proven kernel is \(K_r=\operatorname{span}(r)\), so \(E_r=\mathbb R^3/\operatorname{span}(r)\).

For any **proper rotation** \(R\in SO(3)\), independent of the boundary state, take
\[
r\mapsto Rr,\qquad v\mapsto Rv,\qquad \tau_r(w)=Rw.
\]
Because proper rotations preserve the cross product,
\[
\boxed{a_{Rr}(Rv)=-(Rv)\times(Rr)=R(-v\times r)=R\,a_r(v).}\tag{M7-COV-EXACT}
\]
Thus the proposed fixed orientation seam satisfies the exact pre-existing M7 response covariance law and induces
\[
\bar R_r:E_r\xrightarrow{\sim}E_{Rr},\quad [v]\mapsto[Rv].
\]
For the frozen two-parity anchor \(a_{(r_+,r_-)}(v_+,v_-)=(-v_+\times r_+,-v_-\times r_-)\), the same derivation works blockwise with a fixed pair of proper rotations \(R_+,R_-\); conserved parity weights remain unchanged by this prescribed relabeling. This is a **mathematical symmetry** of the previously sourced anchor, not an independently installed physical seam in spacetime.

**Concrete orientation holonomy even with fixed boundary configuration:** Let \(r=(0,0,1)\), \(v=(1,0,0)\), and choose the fixed 90-degree proper rotation about the r-axis
\[
R(x,y,z)=(-y,x,z).
\]
Then \(Rr=r\) after **one seam**, but in the operational quotient \(E_r\),
\[
[v]=[(1,0,0)]\ne[(0,1,0)]=[Rv]
\]
because their difference is not in \(\operatorname{span}(r)\). Likewise the source-calibrated vector response changes from \(a_r(v)=(0,1,0)\) to \(a_r(Rv)=(-1,0,0)\). Four rotations return both intervention and response classes exactly.

**Status:** the covariance identity and monodromy distinction are exact for the *already-bank\-ed M7 finite Tier-0 operational anchor*. They do **not** imply that the physical spacetime seam implements R, nor that a proper rotation must be a distinguishable physical operation rather than an admissible gauge/readout-frame change. That distinction depends on the source's fixed calibrated protocol and observer semantics. This is the immediate nontrivial orientation check to carry into any future cyclic BCRD source-level test.

## 4. New small source-specific research joins

Already established and retained: frozen M5 full vs weak process coherence; M7 fixed-protocol, state-dependent response-kernel quotients, finite author Tier-0 controls; the UPT/X3 physical-continuation architecture. The new cyclic bridge must test:

1. **Admissible closing contexts:** Which closing tests C are physically admissible under actual BCRD cut algebra, B3 protocols and B5/B6 refinement? Does the permitted family separate the claimed histories? Do not count a mathematically possible selector as a physical intervention without a source certificate.
2. **Source-calibrated seam:** Derive an actual \(\sigma\), fixed S and response identifications \(\tau_b\) from the same physical BCRD process; do not insert them to make recurrence true.
3. **Operational monodromy:** Compute transport of M7's *already derived* \(E_b=V/\ker a_b\) around that seam, and decide from source semantics which monodromies are gauge, physical, forbidden or nontrivially recurrent.
4. **Full physical history/particular:** Separate identical cut maps and cyclic signatures from complete bulk-history isomorphism (PR #191) and source-grounded same-particular continuation (existing October original X3 bridge); don't reprove or replace X3.

**Claim ceiling:** Theorem 05 on full finite closing contexts and the linear M7 response-quotient transport/monodromy are proved in their declared mathematical settings and exact example. No universal physical BCRD feedback, actual observer-relative cosmic cyclic time, cosmic creation by guardians, proof of universal physical UPT, or inevitable future survival follows. This is a focused **cyclic-extension** audit.

**Tests:** \`evidence/physical-bridges/check_bcrd_m5_m7_cyclic_seam.py\` performs exhaustive relational cut-context checks for all 256 ordered pairs of binary relations, verifying the all-context separation theorem with 16 closing contexts each (4096 tests), and exact integer-valued checks on 98 state-and-protocol covariance cases (2 cut states × 49 calibrated protocol vectors) for the seam orientation example; plus weak-coherence and four-seam controls.
