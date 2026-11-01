# X3-MEM–AGENCY — Hostile review of proposed Proofs 17 and 18, with exact replacement lemmas

**Date:** 2026-11-01 (NZDT)  
**Status:** draft, non-canonical mathematical research for PR #189. Formal conditional lemmas and exact countermodels; not a Lean-kernel proof and not a proof that the original UPT X3 predicate is physically realized.  
**Source bridge inspected:** \`PhysicalBridges/IR102SectorSemanticBridge.lean\`, which explicitly requires \`sectorEntailsX3\` independently of sector closure.

## Disposition

**Proof 17 ("Information-Theoretic Memory Retention") is false as stated**. The argument conflates a **direct-sum sector decomposition** \(\mathcal H=\operatorname{Ran}P\oplus\operatorname{Ran}Q\) with a **tensor-product subsystem decomposition** \(\mathcal H=\mathcal H_A\otimes\mathcal H_E\). Partial trace requires the second; for a normalized density operator the reduced state \(\rho_A=\operatorname{Tr}_E\rho\) has \(\operatorname{Tr}\rho_A=1\) identically. The proposed "capacity" \(C_p=\operatorname{Tr}\rho_p\) is therefore not a measure of sector occupancy.

Moreover, \(g=\|QHP\|\) controls *transitions across the chosen direct-sum sector boundary*. It does **not** bound entanglement generation and entropy change **within** that sector; weak \(g\) does not imply a small reduced-subsystem interaction.

**Proof 18 ("State-Dependent Boundary Feedback and Relational Agency") is false as stated**. The displayed nonlinear equation is a possible mean-field/control model, not derived from the BCRD source or generic microscopic quantum dynamics. Nonlinearity or state dependence alone implies neither a positive Lyapunov exponent, saddle-node bifurcations, different feasible actions, agent authorization, nor the original X3 freedom predicates.

**Do not compose them into a claimed X3 theorem.** See the exact counterexamples and the correct conditional replacement results below.

## MEM-1. Exact memory-entropy counterexample with zero external leakage, capacity 1, and spectral dominance

Construct a **proper** direct-sum sector:

\[
\mathcal H=(\mathbb C^2_A\otimes\mathbb C^2_B\otimes\mathbb C^2_R)\oplus\mathbb C|f\rangle.
\]

Let \(P\) project onto the entire eight-dimensional \(A\otimes B\otimes R\) sector; \(Q=I-P\) projects onto the one-dimensional spectator \(f\). Label the computational basis \(|a\,b\,r\rangle\). Select three distinct vectors

\[
|a\rangle=|000\rangle,\quad |b\rangle=|011\rangle,\quad |c\rangle=|101\rangle.
\]

Define a bounded self-adjoint Hamiltonian by

\[
H|a\rangle=3|a\rangle,\quad
H|b\rangle=\frac{\pi}{2}|c\rangle,\quad
H|c\rangle=\frac{\pi}{2}|b\rangle,
\]

give the five other computational-basis vectors in \(A\otimes B\otimes R\) distinct diagonal energies \(4,5,6,7,8\), and let \(H|f\rangle=0\). This is block-diagonal with respect to \(P\oplus Q\), therefore

\[
\boxed{g=\|QHP\|=0,\qquad C_{\mathrm{site}}(t)=\|Pe^{-iHt}\psi_0\|^2=1\quad\forall t.}
\]

Prepare

\[
|\psi_0\rangle=\sqrt{\tfrac45}|a\rangle+\sqrt{\tfrac15}|b\rangle.
\]

The energy value \(3\) is simple and isolated from every other energy by a full spectral gap \(\delta=1\); its spectral weight in the initial vector is \(w_*=\tfrac45>\tfrac12\). The other nonzero weights are \(\tfrac1{10}\) each, on energies \(\pm\pi/2\). Thus even the **spectral-dominance** and the **isolated-gap** premises are met; \(g<\delta/2\).

At \(t=1\), exact unitary evolution gives

\[
U(1)\psi_0=e^{-3i}\sqrt{\tfrac45}|000\rangle-i\sqrt{\tfrac15}|101\rangle.
\]

Initially, the reduced **A**-subsystem state is \(\rho_A(0)=|0\rangle\langle0|\), with \(S(\rho_A(0))=0\). At \(t=1\),

\[
\rho_A(1)=\tfrac45|0\rangle\langle0|+\tfrac15|1\rangle\langle1|,
\]

and so

\[
\boxed{S(\rho_A(1))=h_2(1/5)
=-\tfrac45\log(\tfrac45)-\tfrac15\log(\tfrac15)>0.}\tag{MEM-1}
\]

No averaging or Markov assumption appears. The reduction became mixed through **internal** correlations within the protected P-sector, despite **zero** P-to-Q coupling and **perfect** sector occupancy. Therefore no universal \(|dS(\rho_A)/dt|\le\kappa g\) can hold on these assumptions: the right hand side is zero for the whole trajectory while the entropy changes.

This does **not** assert that a real particular was destroyed or that global quantum information vanished; it precisely distinguishes protected occupancy, globally reversible information and *locally accessible memory*.

## MEM-2. Correct finite-time reduced-state disturbance bound

Suppose the actual physical subsystem decomposition **really is** \(\mathcal H_A\otimes\mathcal H_E\), with

\[
H=H_0+V,\qquad
H_0=H_A\otimes I+I\otimes H_E,
\]

where the operators are bounded and self-adjoint; \(V\) is the explicitly identified *A–environment interaction*, **not automatically \(QHP\)**.

For any initially normalized total density operator \(\rho(0)\), let \(\rho_A(t)=\operatorname{Tr}_E(U(t)\rho(0)U(t)^\dagger)\) and \(\rho_A^0(t)\) be the corresponding reduced state evolved by \(H_0\). Duhamel yields \(\|U(t)-U_0(t)\|\le |t|\|V\|\). Applying the trace-norm triangle inequality and contractivity of partial trace,

\[
\boxed{\|\rho_A(t)-\rho_A^0(t)\|_1
\le 2\min(1,|t|\|V\|).}\tag{MEM-2}
\]

For a Hermitian, physically accessible memory observable \(M\) on \(A\),

\[
\boxed{|\operatorname{Tr}M(\rho_A(t)-\rho_A^0(t))|
\le 2\|M\|\min(1,|t|\|V\|).}\tag{MEM-2a}
\]

This is a finite-time **distance from the ideal local trajectory**, not a guarantee that the original raw memory expectation is constant (even the ideal local Hamiltonian may change it).

For two encoded logical alternatives \(\rho^{(0)}(0),\rho^{(1)}(0)\), let \(D_A(t)=\tfrac12\|\rho_A^{(0)}(t)-\rho_A^{(1)}(t)\|_1\) quantify their readable distinguishability. Since the local ideal evolution is unitary,

\[
\boxed{D_A(t)\ge\max\{0,D_A(0)-2|t|\|V\|\}.}\tag{MEM-2b}
\]

This is a valid **conditional, finite-time, memory-distinguishability** certificate. For arbitrarily long time it can become vacuous. Deriving a uniform historical memory guarantee requires stronger source-bound dynamics, a noiseless code, physically realizable recovery operations, or another separately proved instrument.

**On the supplied master-equation step:** a generic reduction of a finite closed quantum system does not automatically satisfy a time-local Lindblad equation with a dissipator bounded by \(Cg^2\). Such an equation requires independently justified weak-coupling, time-scale, Markov/secular and/or memory-kernel assumptions. A bare entropy derivative bound with factor \(\log d\) is also not generally valid without spectral regularity, since the derivative of \(-\operatorname{Tr}\rho\log\rho\) involves \(\log\rho\), unbounded near zero eigenvalues. Finite-time entropy continuity bounds can be derived from MEM-2 with explicit subsystem dimension and trace distance instead.

## AGENCY-1. Exact nonchaotic state-dependent feedback counterexample

For one qubit take \(M=V=\sigma_z\), \(H_0=0\), and zero dissipator:

\[
\dot\rho=-i[\operatorname{Tr}(\sigma_z\rho)\,\sigma_z,\rho].
\]

Set \(z=\operatorname{Tr}(\sigma_z\rho)\). The equation gives \(\dot z=0\), so the *exact* solution is

\[
\boxed{\rho(t)=e^{-iz(0)t\sigma_z}\rho(0)e^{iz(0)t\sigma_z}.}\tag{AGENCY-1}
\]

The feedback is genuinely state-dependent for initial states with different \(z\). Yet \(z\) is conserved, no distinct macroscopic attractors or decision variables are supplied, and the transverse Bloch-sphere angle simply advances linearly at a rate \(2z\). Dependence of angle on \(z\) yields, at worst, **linear shear in the tangent dynamics**; the maximal Lyapunov exponent is zero, not necessarily positive.

More basically, because density operators form a bounded metric space, the supplied expression \(\lim_{t\to\infty}t^{-1}\log(\|\delta\rho(t)\|/\|\delta\rho(0)\|)\) for **fixed nonzero initial separation** cannot produce a positive exponent in a bounded state space. Positive Lyapunov exponents are defined from an *infinitesimal tangent perturbation* (take variation to zero appropriately before infinite time), not from a single pair at fixed initial distance.

Feedback-induced nonlinearity also does not preserve the originally assumed free-flow quasiperiodic torus, let alone force saddle-node bifurcations.

## AGENCY-2. Correct conditional, nonvacuous history-to-branch model

A concrete controlled system can exhibit **distinct history-conditioned branches without chaos**:

- Take a target qubit with initial state \(|+\rangle=(|0\rangle+|1\rangle)/\sqrt2\).
- Let a recorded internal memory bit \(m\in\{0,1\}\) select one of two *physically available* controls: \(H_0=0\), \(H_1=\sigma_z\).
- At fixed time \(t=\pi/2\),

\[
U_0(t)|+\rangle=|+\rangle,\qquad
U_1(t)|+\rangle=-i|-\rangle,
\]

which are orthogonal and operationally distinguishable output states.

This proves **possibility of nontrivial history-conditioned control** under the explicit premise that the memory record and actuation mechanism actually exist and implement the chosen Hamiltonian. It is not alone the original X3 freedom requirement: independent premises concerning an *agent's* authorization, internal option selection, capability, safety, feasible alternatives and noncoerced outcomes remain essential.

A natural formal target is an *operational refinement theorem* connecting an encoded internal history \(m\), an authorized controller \(\pi(m,s)\) that selects from a nonempty feasible set, a verified physical effect relation \(R_{\mathrm{phys}}\), and an independently supplied source-level predicate for original-X3 historical continuation and freedom.

## X3 composition: do not weaken the original predicate

The existing exact source \`evidence/physical-bridges/PhysicalBridges/IR102SectorSemanticBridge.lean\` proves X3 along physical transitions **only if** the user supplies:

1. physical-to-model transition completeness,
2. model-sector closure, and
3. \`sectorEntailsX3 : ∀s, sector s → x3 s\`.

It also has \`sector_closure_alone_insufficient\`, a countermodel refuting the inference from sector closure to an independently defined X3 predicate.

MEM-2 and AGENCY-2 can become **components of a source-backed certificate**, not direct substitutes for premise (3). No combination of occupancy + an arbitrary reduced-entropy bound + state-dependent nonlinear feedback proves all original UPT freedoms by itself.

**Next productive derivation:** source-identify a physical/semantic record \(p\), its *actual* accessible memory algebra or encoded logical alternatives, its allowed interaction Hamiltonian/decoder/recovery, and authorized physically executable controls. Derive a trace-preserving historical correspondence and specific reachable freedoms under adversarial effects; then discharge \`sectorEntailsX3\` at the unchanged original strength. Do not claim source proof, independent validation, or world-level universal protection from this mathematical note.
