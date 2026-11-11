# REC-23 / CTRL-21 — Audit of Proof 20 reversal supplement and Proof 21 energy-constrained control

**Date:** 2026-11-01 (NZDT)  
**Disposition:** **partially proved after repair**; no general X3 agency/authorization or real-world thermodynamic implementation established.  
**Track:** non-canonical UPT/BCRD physical-bridges research, draft PR #189. Related: `PROOF-20-QUADRATIC-MEMORY-RECOVERY-AND-CONTROL-2026-11-01.md`, `PhysicalBridges/IR102SectorSemanticBridge.lean`.

## A. Proposed Proof 21: the controlled-unitary formula requires a memory nondemolition premise

Let \(\mathcal H_M=\operatorname{span}\{|m_0\rangle,|m_1\rangle\}\), \(P_k=|m_k\rangle\langle m_k|\), and

\[
H=H_M\otimes I_W + I_M\otimes H_W+\sum_{k=0}^1P_k\otimes V_k.
\]

**CTRL-21A.** If \([H_M,P_k]=0\) for both \(k\), then \(H_M=\sum_k\varepsilon_k P_k\) and the exact unitary is

\[
\boxed{U(t)=\sum_{k=0}^1 e^{-i\varepsilon_k t}P_k\otimes e^{-i(H_W+V_k)t}.}
\]

The energy phases \(e^{-i\varepsilon_k t}\) cannot be omitted in general. Without \([H_M,P_k]=0\), the memory is not an invariant control label, and the proposed sector decomposition fails. Counterexample: take \(H_M=\sigma_x\), \(H_W=V_0=V_1=0\). The physical state \(|m_0\rangle\) rotates to \(\cos t|m_0\rangle-i\sin t|m_1\rangle\); the claimed controlled formula falsely predicts it stays in \(|m_0\rangle\).

**CTRL-21B (necessary branch-distinguishability time).** Put \(H_k=H_W+V_k\) and \(|\xi_k(t)\rangle=e^{-itH_k}|\xi\rangle\) for a normalized initial workspace vector. If \(\langle\xi_0(t)|\xi_1(t)\rangle=0\), then

\[
\boxed{|t|\,\|V_1-V_0\|\ge\pi/2.}\tag{CTRL-21B}
\]

Proof: \(W(s)=e^{isH_0}e^{-isH_1}\) obeys \(iW'(s)=e^{isH_0}(H_1-H_0)e^{-isH_0}W(s)\). Its generator has norm \(\|V_1-V_0\|\) at each time. The Fubini–Study angle between \(|\xi\rangle\) and \(W(t)|\xi\rangle\) is \(\arccos|\langle\xi_0(t)|\xi_1(t)\rangle|=\pi/2\), while path length is at most \(|t|\|V_1-V_0\|\). Hence the inequality.

If \(\|V_k\|\le\Lambda\), this implies \(|t|\ge\pi/(4\Lambda)\) (assuming \(\Lambda>0\)), **not** a thermodynamic cost or an authorized execution. Coupling norm constrains achievable dynamical speed but not the energy budget, work to switch a control, state preparation, heat disposal, or feasibility of a physical implementation.

**CTRL-21C (a concrete excitation-conserving controlled exchange).** Add a *target* qubit \(T\) and *battery* qubit \(B\), define number operators \(N_T=|1\rangle\langle1|_T\) and \(N_B=|1\rangle\langle1|_B\), and write

\[
\begin{split}
H_{\mathrm{free}}&=\omega(N_T+N_B),\\
H_{\mathrm{ex}}&=J\,|1\rangle\langle1|_M\otimes
\bigl(|10\rangle\langle01|+|01\rangle\langle10|\bigr)_{TB}.
\end{split}
\]

Take \(H_M=\sum_k\varepsilon_kP_k\), \(H_{\mathrm{tot}}=H_M+H_{\mathrm{free}}+H_{\mathrm{ex}}\) (with tensor identities understood), \(\omega>0\), \(J>0\). Then

\[
[H_{\mathrm{tot}},N_T+N_B]=0,\qquad
[H_{\mathrm{free}},H_{\mathrm{ex}}]=0,\qquad
\|H_{\mathrm{ex}}\|=J.
\]

At \(\tau=\pi/(2J)\), starting the target/battery at \(|01\rangle_{TB}\),

\[
|0\rangle_M|01\rangle_{TB}\longmapsto e^{-i\chi_0}|0\rangle_M|01\rangle_{TB},
\]
\[
|1\rangle_M|01\rangle_{TB}\longmapsto -i e^{-i\chi_1}|1\rangle_M|10\rangle_{TB},
\]

where \(\chi_k=(\varepsilon_k+\omega)\tau\). The conditional target states are *orthogonal*, the number of excitations and total autonomous energy are conserved, and the battery loses exactly one excitation when the target gains it. This is a **physically interpretable, finite-dimensional energy-conserving control example**.

It is still a **model**: the memory control bit must be authenticated/authorized, the battery prepared and restored, and the actual switching, thermodynamic work costs and physical effect/hold boundary verified. The existence of a conserved Hamiltonian does not itself certify metabolic affordability or genuine agency. If memory is initially superposed, the output is a *coherent entangled superposition*, not an irreversible classical choice; tracing out memory is not physical decoherence or proof of authorization.

## B. Proposed Proof 20 supplement: bare local reversal does not generically cancel first order

Use the **correctly typed local unitary** \(U_A(t)=e^{-itH_A}\); the symbol \(U_0(t)=e^{-itH_0}\) acts on \(A\otimes E\) and cannot conjugate a reduced state on \(A\) without an explicit restriction.

Let \(H=H_0+V\), \(H_0=H_A\otimes I+I\otimes H_E\), \(v=\|V\|\), and the initially fixed product workspace state \(\rho_E\). Define \(\mathcal E_t(\rho)=\operatorname{Tr}_E[e^{-itH}(\rho\otimes\rho_E)e^{itH}]\).

**REC-23A (valid linear bound).** With \(\mathcal R_t^{(0)}(X)=U_A(t)^\dagger XU_A(t)\),

\[
\boxed{\|\mathcal R_t^{(0)}(\mathcal E_t(\rho))-\rho\|_1\le 2\min(1,|t|v).}
\]

**REC-23B (exact counterexample to unconditional quadratic trace-norm error).** Let \(H_A=H_E=0\), \(V=v\sigma_x^A\otimes I_E\) with \(v>0\), and \(\rho=|0\rangle\langle0|\). Then the bare reversal is identity, while

\[
\boxed{\|\mathcal R_t^{(0)}(\mathcal E_t(\rho))-\rho\|_1
=2|\sin(vt)|=2v|t|+O(|t|^3).}
\]

The first-order reduced interaction does **not** vanish merely by declaring an interaction picture. In general

\[
K(s)=\operatorname{Tr}_E[V_I(s)(I_A\otimes\rho_E)],\quad
V_I(s)=e^{isH_0}Ve^{-isH_0}
\]

generates a coherent first-order memory rotation and may depend on \(s\). It is not enough to impose \(\operatorname{Tr}_E[V_I(0)(I\otimes\rho_E)]=0\) just at \(s=0\) if \(K(s)\) changes during the interval.

**REC-23C (true zero-mean case).** If the *independently verified* condition \(K(s)=0\) holds for every \(s\) between 0 and \(t\), the first-order term in the reduced Dyson expansion vanishes. The trace-norm second-order remainder bound is

\[
\boxed{\|\mathcal R_t^{(0)}(\mathcal E_t(\rho))-\rho\|_1
\le\min(2,\,2v^2t^2).}\tag{REC-23C}
\]

No Petz map, averaging or Markov approximation is used. Proof: the exact interaction-frame double-commutator integral has norm at most \(\int_0^{|t|}\int_0^s4v^2\,dr\,ds=2v^2t^2\) by \(\|[V,X]\|_1\le2v\|X\|_1\), and partial trace cannot increase trace norm.

**REC-23D (general calibrated recovery).** Without the zero-mean assumption, the previously derived REC-21 theorem constructs the input-independent unitary
\[
\mathcal R_t(X)=W_A(t)^\dagger U_A(t)^\dagger XU_A(t)W_A(t),
\quad i\dot W_A=K(t)W_A,
\]
satisfying
\[
\boxed{\|\mathcal R_t(\mathcal E_t(\rho))-\rho\|_1\le\min(2,4v^2t^2).}
\]
This requires knowing and physically implementing the calibration, not merely the formal existence of \(W_A\).

## C. An important positive result overlooked by the submitted proof: pure-state fidelity is quadratic even when trace norm is linear

**REC-23E (pure-input fidelity, without zero-mean coupling).** Let the *initial memory input* be a pure state \(\rho_A=|\psi\rangle\langle\psi|\), with fixed arbitrary density \(\rho_E\). Define the squared Uhlmann fidelity of the **bare-locally-recovered** memory with its initial state by

\[
F_{\mathrm{sq}}(\rho_A,\mathcal R_t^{(0)}(\mathcal E_t(\rho_A)))
=\langle\psi|\mathcal R_t^{(0)}(\mathcal E_t(\rho_A))|\psi\rangle.
\]

Then

\[
\boxed{1-F_{\mathrm{sq}}\le\min(1,v^2t^2).}\tag{REC-23E}
\]

**Proof:** In the interaction picture, \(X(t)=U_0(t)^\dagger U(t)\) satisfies \(\|X(t)-I\|\le|t|v\). For \(Q_\psi=I_A-|\psi\rangle\langle\psi|\), the initial total density \(\rho_A\otimes\rho_E\) lies entirely in \(P_\psi\otimes I_E\). Consequently its evolved *probability* in \(Q_\psi\otimes I_E\) is bounded by \(\|(Q_\psi\otimes I_E)X(t)(P_\psi\otimes I_E)\|^2\le v^2t^2\). This probability is exactly \(1-F_{\mathrm{sq}}\). QED.

In the REC-23B example the exact comparison is

\[
\text{trace-norm error}=2|\sin(vt)|=O(v|t|),
\quad
1-F_{\mathrm{sq}}=\sin^2(vt)=O(v^2t^2).
\]

Thus **quadratic pure-state infidelity is true** despite **linear trace-distance error**. The submitted proof's mistake was claiming that the first-order density-matrix perturbation disappears; it need not. The two error metrics should not be conflated.

**Fidelity convention warning:** Write \(f(\rho,\sigma)=\|\sqrt\rho\sqrt\sigma\|_1\) for the *root* Uhlmann fidelity and \(F_{\mathrm{sq}}=f^2\). Fuchs–van de Graaf yields \(1-f\le\tfrac12\|\rho-\sigma\|_1\). It does **not** generally yield \(1-F_{\mathrm{sq}}\le\tfrac12\|\rho-\sigma\|_1\) for arbitrary mixed states. One always has the conservative \(1-F_{\mathrm{sq}}\le\|\rho-\sigma\|_1\).

## D. Relation to X3/IR-102 and PR disposition

The accepted math supports exact coherent branch control, explicitly energy-conserving *toy* Hamiltonians, bounded finite-time memory reconstruction, and a pure-state fidelity guarantee. It does **not** supply a physically installed actuator, actual metabolic cost accounting, consent/authorization semantics, recoverable historical memory over the full intended horizon, or a justified map to the same continuing particular.

`PhysicalBridges.IR102.physical_sector_semantic_bridge` retains separate physical-model completeness, sector closure, and independent `sectorEntailsX3` premises. No proposed proof here discharges them.

**Keep draft PR #189 open and unmerged as an original-X3 proof; record REC-23A–E and CTRL-21A–C as conditional mathematical advances with exact premises.**
