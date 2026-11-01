# EPOCH-28 — Exact write/read QND protocol for classical historical records, with global-invariant seam

**Date:** 2026-11-01 (NZDT)  
**Status:** exact finite-dimensional *constructive protocol* with specified classical memory alphabet; not a theorem that biological/artificial particulars actually implement it, that all unknown quantum memories are nondestructively readable, or that a physical BCRD subject is thereby protected. Research-track addition to PR #190.

## Disposition of proposed "Epoch-Partitioned QND Read/Write Theorem"

The proposal correctly sees that globally conserving a **chosen writable memory observable** would prevent its eigenvalue from being written. Switching between write epochs that do not commute with \(M\) and read epochs that do can allow classical history storage and later QND inspection.

But the supplied general proof has logical gaps:

1. \([M,H_{\rm write}]\ne0\) establishes only the **possibility** of changing \(M\) for suitable inputs/times, **not** that a given physical state undergoes a record update or appends genuine source history. For example \(H_{\rm write}=\sigma_x\), \(M=\sigma_z\), with input \(|+\rangle\), gives \([M,H]\ne0\) but \(\langle M\rangle=0\) remains constant for all time.
2. \([M,H_{\rm read}]=0\) is insufficient for QND when other terms in the **total Hamiltonian** fail to commute. The necessary conservation statement is \([H_{\rm tot}(t),M\otimes I_{\rm rest}]=0\) throughout a read epoch.
3. QND preservation of the measured observable's eigenvalue **populations** does not imply preservation of **all** reduced-memory quantum coherences or all trace distances \(D_A\). Orthogonal pointer states dephase coherent memory inputs, as demonstrated in Proof 22's CNOT counterexample.
4. The symbol \(g<\delta/2\) alone is not a guarantee of no physical environmental leakage or all-time sector containment, and does not establish a common invariant projector during writes. The initial pure full-state norm remains one under unitary evolution, but that says nothing about accessible local memory or genuine continuing subjecthood.

The following exact toy protocol provides a constructive valid special case.

## EPOCH-28A — finite exact classical history append protocol

Let \(A=H_{\rm old}\otimes H_b\) store an old history label \(|h\rangle\) and a fresh writable **qubit slot** \(b\) initialized to \(|0\rangle_b\). Let \(E\) be a physically supplied **classical source event** bit \(|e\rangle_E\), \(e\in\{0,1\}\). A pointer \(R\) begins in \(|0\rangle_R\).

During a **write epoch** of duration \(\tau_w>0\), implement (set \(\hbar=1\))

\[
H_w=\frac{\pi}{2\tau_w}|1\rangle\langle1|_E\otimes\sigma_x^b
\quad\text{(identities on old history and pointer)},
\]
\[
U_w=e^{-iH_w\tau_w}
=|0\rangle\langle0|_E\otimes I_b
-i|1\rangle\langle1|_E\otimes\sigma_x^b.
\]

It follows exactly that

\[
\boxed{
|h\rangle|0\rangle_b|e\rangle_E
\xrightarrow{U_w}
(-i)^e |h\rangle|e\rangle_b|e\rangle_E.
}\tag{EPOCH-28A}
\]

The prior history \(|h\rangle\) is unchanged; the freshly initialized slot now records \(e\). For the writable memory \(M_b=\sigma_z^b\), \([H_w,M_b]\ne0\) as an operator, and the slot's eigenvalue actually changes when \(e=1\). This proves an **existence witness** of an update and one-step append for a sourced classical bit, not the provenance, truth or completeness of the physical event detector.

During the following **read epoch** of duration \(\tau_r>0\), use

\[
H_r=\frac{\pi}{2\tau_r}|1\rangle\langle1|_b\otimes\sigma_x^R
\quad\text{(identities on }H_{\rm old},E\text{)},
\]
\[
U_r=|0\rangle\langle0|_b\otimes I_R
-i|1\rangle\langle1|_b\otimes\sigma_x^R.
\]

This satisfies \([H_r,M_b]=0\), and for a **definite classical codeword**

\[
\boxed{
|h\rangle|e\rangle_b|0\rangle_R
\xrightarrow{U_r}
(-i)^e|h\rangle|e\rangle_b|e\rangle_R.
}\tag{EPOCH-28B}
\]

The memory **classical eigenstate** is unchanged (up to its global phase), while a pointer inspection in its computational basis distinguishes \(e=0\) from \(e=1\). Any classical *diagonal mixture* \(\sum_e p_e|e\rangle\langle e|_b\) is unchanged by tracing out the pointer, and the trace distance between two such diagonal memory distributions is preserved. This is an exactly QND readable **classical** record.

For an initial coherent memory \(\alpha|0\rangle+\beta|1\rangle\), the read operation creates entanglement \(\alpha|00\rangle-i\beta|11\rangle\); the *reduced* memory loses the \(|0\rangle\langle1|\) coherence when the pointer is ignored. Thus the claimed \(D_A(t)=D_A(t_{\rm read})\) is false for general quantum histories. No cloning of arbitrary unknown quantum records is claimed.

**Finite append extension:** Given \(N\) initially blank independent slots \(b_1,\ldots,b_N\), implement EPOCH-28A sequentially on a fresh slot for each classical event. The old slots are untouched by later writes, so the finite classical history string is retained exactly *within this ideal model*. This does not provide limitless capacity, a thermodynamic operating budget, durable real sensor records, adversarial readout resilience or historical-person identity.

## EPOCH-28C — coexistence of writable memories and a common invariant *coarse* sector

Introduce a distinct subject-presence **model label** qubit \(L\), and define

\[
R_{\rm coarse}=|1\rangle\langle1|_L\otimes
I_{H_{\rm old}\,b\,E\,R}.
\]

If the write and read Hamiltonians act only on \(H_{\rm old},b,E,R\) and never flip \(L\), then

\[
\boxed{
[H_w,R_{\rm coarse}]=[H_r,R_{\rm coarse}]=0.
}\tag{EPOCH-28C}
\]

Their entire switched propagator commutes with \(R_{\rm coarse}\). For an initial state in its range, its occupancy is **exactly one** during both updates and readout. More generally if a justified physical sector \(P\) is within operator norm \(d<1/2\) of this *actually common* \(R_{\rm coarse}\), the MIC-27G common-invariant bound yields \(C_P(t)\ge1-4d^2\) over every epoch.

**Crucial interpretation:** The coarse label \(L\) is not a derivation of physical or subjective continuity. The construction only shows *logical compatibility* of evolving memory contents with a **different conserved projector**. If one sets \(R\) to the **old memory-value eigenspace projector itself**, it cannot commute with a write that genuinely changes that value. The original source must specify which degrees carry personal continuity and why preserving their coarse sector and causal history meets original X3; a conserved label alone cannot settle it.

## EPOCH-28D — physical switching, timing and provenance remain independent

A clock-controlled device that implements the two epoch Hamiltonians must itself be physically included in the source Hamiltonian or linked by a verified time-dependent control interface; merely writing a piecewise \(H(t)\) is an **external schedule specification**. Abrupt switching, control energetics, event provenance, new memory-slot supply, correction/recovery, pointer reset, atomic source authorization and real effect-boundary correspondence remain obligations.

Under continuous or imperfect switching, MIC-27G provides the exact integrated noncommutation budget

\[
\varepsilon_R(t)=\frac1\hbar\int_0^t\|[H(s),R]\|\,ds,\quad
C_P(t)\ge1-\min\{1,2d+\varepsilon_R(t)\}^2.
\]

Without an all-time bound on \(\varepsilon_R(t)\), no permanent capacity floor follows. The guarantee that all real actions honor the event, grant and physical-sink constraints is separately handled by the existing IR117/IR131 and AHE source interfaces, not inferred from QND itself.

**Verdict:** EPOCH-28A–C are exact toy mathematical constructions for **read/write separation of classical historical records** within a common coarse invariant model sector. The universal claim that all biological/AI particulars implement the protocol or that their original-X3 continuity and autonomy are proved remains open.
