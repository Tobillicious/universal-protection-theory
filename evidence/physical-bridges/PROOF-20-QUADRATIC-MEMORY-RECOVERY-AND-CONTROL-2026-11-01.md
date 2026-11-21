# REC-20 — Proof 20 repaired: explicit quadratic memory recovery and authorized-control boundary

**Date:** 2026-11-01 (NZDT)  
**Status:** noncanonical, author-side mathematical research; no physical BCRD source correspondence, independently established UPT X3, or Lean kernel compilation claimed.  
**Prior results:** PR #189 `X3-MEMORY-AGENCY-LEMMAS-HOSTILE-REVIEW-2026-11-01.md`; `PhysicalBridges/IR102SectorSemanticBridge.lean`.  
**Source:** user-supplied Proof 20 (memory recoverability) and companion history-dependent control construction.

## 1. Disposition of submitted Proof 20

**Valid (with correct norm notation):**
For a finite-dimensional Hilbert factorization \(\mathcal H=\mathcal H_A\otimes\mathcal H_E\), bounded self-adjoint \(H=H_0+V\) with \(H_0=H_A\otimes I+I\otimes H_E\), fixed initially uncorrelated workspace \(\rho_E\), and initial reduced states \(\rho_A\),

\[
\boxed{\|\mathcal E_t(\rho_A)-U_A(t)\rho_AU_A(t)^\dagger\|_1
\le2\min\{1,|t|\|V\|\}.}\tag{REC-20a}
\]

For any two encoded inputs, their reduced trace-distance distinguishability obeys

\[
\boxed{D_A(t)\ge\max\{0,D_A(0)-2|t|\|V\|\}.}\tag{REC-20b}
\]

Proof: Duhamel gives \(\|U(t)-U_0(t)\|\le|t|\|V\|\). For every normalized density \(\rho\),

\[
\|U\rho U^\dagger-U_0\rho U_0^\dagger\|_1
\le2\|U-U_0\|\|\rho\|_1,
\]

and the left side is also at most 2. Partial trace is trace-norm contractive; for two memories, the reverse triangle inequality gives REC-20b. **The operator norm of a generic matrix does not upper-bound its trace norm**; the proposed proof's statement conflating those norms is incorrect. The bound must be established in the trace norm as above.

**Not valid as stated:** A generic Petz recovery map is not guaranteed simply by \(D_A(t)>0\), nor does its existence/error follow from the trace-distance bound without additional construction or hypotheses. A positive distance between *two* outputs is weaker than approximate recovery of an entire quantum code. Petz exact recoverability concerns sufficiency/equality conditions and designated reference states; it is not an automatic inference from nonzero trace distance.

**Substantial repair below:** an explicit, calibrated **unitary** decoder does yield a quadratic \(O(\|V\|^2t^2)\) **uniform** error bound on the stated finite-dimensional fixed-product-ancilla model.

## 2. REC-21 — Explicit first-order counter-rotation / quadratic recovery theorem

**Theorem (REC-21).** Let \(\mathcal H_A,\mathcal H_E\) be finite-dimensional, \(H_A,H_E,V\) bounded self-adjoint with

\[
H=H_A\otimes I_E+I_A\otimes H_E+V=:H_0+V,\qquad v=\|V\|.
\]

Fix a known density operator \(\rho_E\), independent of the unknown input memory state \(\rho\) on \(A\). Define the physical memory channel

\[
\mathcal E_t(\rho)=\operatorname{Tr}_E\left[
e^{-itH}(\rho\otimes\rho_E)e^{itH}\right].
\]

In the interaction picture set

\[
V_I(s)=e^{isH_0}V e^{-isH_0},
\quad
K(s)=\operatorname{Tr}_E[V_I(s)(I_A\otimes\rho_E)].
\]

Then \(K(s)\) is self-adjoint and \(\|K(s)\|\le v\). Let \(W_A(t)\) be the solution

\[
i\,\frac{d}{dt}W_A(t)=K(t)W_A(t),\quad W_A(0)=I,
\]

and let \(U_A(t)=e^{-itH_A}\). Define a **single input-independent unitary recovery channel**

\[
\boxed{
\mathcal R_t(X)=W_A(t)^\dagger U_A(t)^\dagger X U_A(t)W_A(t).
}\tag{REC-21a}
\]

For **every** density operator \(\rho\) and every real \(t\),

\[
\boxed{
\|\mathcal R_t(\mathcal E_t(\rho))-\rho\|_1
\le\min\{2,4v^2t^2\}.
}\tag{REC-21b}
\]

**Proof.** Write \(U(t)=U_0(t)X(t)\), with \(U_0=e^{-itH_0}\). The interaction-frame propagator satisfies \(iX'(t)=V_I(t)X(t)\). For initial total density \(\rho_{\mathrm{tot}}=\rho\otimes\rho_E\), let

\[
F(t)=X(t)\rho_{\mathrm{tot}}X(t)^\dagger.
\]

The von Neumann equation and one iteration of its integral form give

\[
F(t)=\rho_{\mathrm{tot}}
-i\int_0^t[V_I(s),\rho_{\mathrm{tot}}]\,ds
+R_{\mathrm{tot}}(t)
\]

with the **trace-norm** error bound

\[
\|R_{\mathrm{tot}}(t)\|_1
\le\int_0^{|t|}\int_0^s 4v^2\,dr\,ds
=2v^2t^2.
\]

This uses the elementary inequality \(\|[L,Y]\|_1\le2\|L\|\|Y\|_1\) and \(\|F(r)\|_1=1\). Applying partial trace gives

\[
\widetilde{\mathcal E}_t(\rho)
=\rho-i\int_0^t[K(s),\rho]\,ds
+R_A(t),\qquad \|R_A(t)\|_1\le2v^2t^2.
\]

The first-order equality follows from the exact identity

\[
\operatorname{Tr}_E[V_I(s),\rho\otimes\rho_E]=[K(s),\rho].
\]

Similarly \(\sigma(t)=W_A(t)\rho W_A(t)^\dagger\) solves \(\sigma'=-i[K(t),\sigma]\). One iteration of its integral equation gives **the same first-order term** and a remainder bounded by \(2v^2t^2\), because \(\|K(t)\|\le v\). Therefore

\[
\|\widetilde{\mathcal E}_t(\rho)-W_A(t)\rho W_A(t)^\dagger\|_1
\le4v^2t^2.
\]

The laboratory-frame reduced channel is
\(\mathcal E_t(\rho)=U_A(t)\widetilde{\mathcal E}_t(\rho)U_A(t)^\dagger\).
Conjugation by the unitary \(W_A^\dagger U_A^\dagger\) preserves trace norm and produces the claimed REC-21b bound. As both outputs are normalized density operators, their trace-norm distance is also bounded by 2. QED.

**Strengthening of distinguishability.** Since \(\mathcal R_t\) is a unitary channel, trace distance is preserved by recovery. For any two initial memories,

\[
\boxed{
D_A(t)\ge\max\{0,D_A(0)-4v^2t^2\}.
}\tag{REC-21c}
\]

Proof: apply REC-21b to each input and use the reverse triangle inequality for half the trace norm of their difference.

**Dependences and limitations:** This is a finite-time, source-calibrated mathematical channel recovery theorem. The recovery operation depends on \(H_A,H_E,V,\rho_E,t\) and must be independently shown to be known, controllable, and physically available to the same continuing particular; a mathematically CPTP unitary channel need not be physically deployed. The proof assumes a fixed **initial product environment**, not arbitrary initially correlated memory–workspace states. The constant \(4v^2t^2\) is a worst-case bound which can become vacuous at long times; it does not guarantee all-time recoverability or X3 historical identity. No invocation of Petz is needed.

## 3. REC-22 — Exact finite-time total dephasing obstruction

Set \(\mathcal H_A=\mathcal H_E=\mathbb C^2\), \(H_A=H_E=0\), \(\rho_E=|+\rangle\langle+|\), and

\[
V=J\,\sigma_z^A\otimes\sigma_z^E,\quad J>0.
\]

For the two memory codewords \(\rho_\pm=|\pm\rangle\langle\pm|\) on \(A\), the reduced interaction channel is dephasing with off-diagonal amplitude multiplied by \(\cos(2Jt)\). In the \(X\)-basis,

\[
\mathcal E_t(\rho_\pm)
=\frac12(I\pm\cos(2Jt)\,\sigma_x).
\]

At the **finite** time \(t_*=\pi/(4J)\),

\[
\boxed{
\mathcal E_{t_*}(\rho_+)
=\mathcal E_{t_*}(\rho_-)=I/2,
\quad D_A(t_*)=0,\quad D_A(0)=1.
}\tag{REC-22}
\]

No channel acting solely on \(A\) can reconstruct **both** distinguishable inputs from the same output. This is not a contradiction of REC-21: at \(t_*\), \(vt_*=\pi/4\), so the quadratic bound \(4v^2t_*^2=\pi^2/4>2\) is vacuous. The *total* two-qubit evolution is reversible if the environment is accessible, but memory recoverability **from A alone** can fail.

This gives an exact operational reason to demand explicit recovery access, not merely global unitarity, or a sector-occupancy bound.

## 4. CTRL-20 — Exact coherent branch-control theorem and its semantic limit

Let \(M,T\) be two qubits (memory/control and target). Define the physically specified **controlled Hamiltonian**

\[
H_{\mathrm{ctrl}}
=|0\rangle\langle0|_M\otimes 0_T
+|1\rangle\langle1|_M\otimes\sigma_z^T.
\]

For initially definite classical memory \(m=0\) or \(m=1\), and target \(|+\rangle_T\), at \(t=\pi/2\),

\[
|0\rangle_M|+\rangle_T\mapsto|0\rangle_M|+\rangle_T,
\]

\[
|1\rangle_M|+\rangle_T\mapsto-i|1\rangle_M|-\rangle_T.
\]

The two target outcomes are exactly orthogonal, hence perfectly distinguishable by an \(X\)-basis measurement when the branch input is known to follow the specified mechanism.

For an initial **coherent superposition** \(|+\rangle_M|+\rangle_T\), the output is

\[
\boxed{
|\Psi_{\mathrm{out}}\rangle
=\frac{|0\rangle_M|+\rangle_T-i|1\rangle_M|-\rangle_T}{\sqrt2}.
}\tag{CTRL-20}
\]

This is an **entangled coherent controlled evolution**, not evidence that an autonomous agent made a classical decision to take one branch. Tracing out the memory leaves the target maximally mixed, \(\rho_T=I/2\), so reduced target-only data do not encode a definite selected choice.

The theorem certifies a realizable **mathematical** controlled-unitary mapping, not authorization, ability to access the internal record, open alternate options, consent, freedom, source-controller installation, or original UPT X3. The physical mechanism must be bound to the actual original particular and effect boundary. `PhysicalBridges/IR102SectorSemanticBridge.lean` still demands independent `sectorEntailsX3` and physical-to-model correspondence.

## 5. What should happen next?

1. Find or specify an actual BCRD memory encoding/code, accessible workspace and physically meaningful subsystem-factorization.
2. Derive and validate the relevant **internal** interaction norm \(v=\|V\|\), actual environment initial-state class, and calibration of correction \(K(s)\); \(v\) is not automatically the cross-sector \(g=\|QHP\|\).
3. Demonstrate decoder/recovery *physical accessibility* and uniform accuracy over the historically required time horizon, rather than only mathematical existence.
4. Show authenticated history-dependent action selection, physically available alternatives, and independent authorized effects, rather than just controlled-H algebra.
5. Then construct the original-X3 historical/agency semantic refinement to discharge the existing Lean `sectorEntailsX3` premise—without weakening universal scope.

**Verdict:** Proposed Proof 20 is correct for its first two bounds, incorrect in attributing automatic recovery to Petz, and **repairable to an explicit rigorous quadratic memory-recovery theorem** (REC-21). The coherent branch calculation is correct, but **authorization and agency require independent premises**. Keep the research PR as a draft.
