# Proofs 22–26 — Exact QND, energy, selection, current, and master-synthesis referee

**Date:** 2026-11-01 (NZDT)  
**Status:** draft research audit / constructive conditional replacements. **NOT** a proof of physical BCRD source completeness, autonomous agency, original X3 or universal protection. **NO Lean kernel verification.**  
**Source:** proposed Proofs 22 (QND memory readout), 23 (metabolic authorization), 24 (variational branch optimization), 25 (boundary current implementation), and 26 (master authenticated history-to-effect synthesis), supplied by the research author. Related existing draft PR #189 develops phase-resolved capacity, calibrated memory recovery and finite history-bound control-gate model.  
**Source modules inspected:** `PhysicalBridges/IR102SectorSemanticBridge.lean`, `IR105AuthorizationIndependence.lean`, `IR108ObservationObstruction.lean`, `IR109RobustObservationViability.lean`, `IR112RobustContinuityOptions.lean`, `IR116CumulativeSubjectDuties.lean`, `IR117SourceInstallationAdapter.lean`, `IR125FourChannelSeparation.lean`, `IR129BoundaryInvisibleKernel.lean`, `IR131ActionLabelledBranching.lean`, `IR132ExactBoundaryReconstruction.lean`, `IRFinalApplyFence.lean`, and `Oct10ParticularContinuationBridge.lean`.

## Verdict at a glance

| Proof | Accepted | Rejected / open |
|---|---|---|
| 22 | Exact QND conservation of the measured **observable**, under a condition on the **total Hamiltonian**; nondemolition of orthogonal classical codeword eigenstates | Preservation of every memory density matrix and every trace distance; orthogonal pointers without dephasing; universal readout time inequality |
| 23 | Battery–target exchange can conserve total number/energy; explicit bounded operating model | Expectation of `H_ctrl` as metabolic work, `E_bind=ħδ` without units, energy inequality as consent, violation as a theorem of immediate dissociation |
| 24 | A **supplied** finite feasible set with a specified selector can implement an argmin; an explicit finite-time perturbation norm gives a branch-error bound | The exchange Hamiltonian magically minimizes an unrelated functional or creates classical bifurcation; asserted unconditional `(g/(ħJ))²` |
| 25 | Genuine Heisenberg continuity identities; conditional current bound and physical channel map from a sourced interaction | Nonzero current without a dynamical witness, real part of commutator of Hermitians nonzero, malformed P–Q direct-sum/tensor product, arbitrary all-time capacity from `g<δ/2` |
| 26 | Conditional typed composition of independently substantiated steps | Definite physical subject, universal X3, same-subject consent, actual effect-boundary completeness, all-time occupancy and agency inferred from above proofs |

## QND-22A. Correct nondemolition theorem

Let \(M_A=\sum_k m_k\Pi_k\) be a bounded Hermitian memory observable and \(U(t)=e^{-itH_{\rm tot}/\hbar}\). If

\[
\boxed{[H_{\rm tot},M_A\otimes I_{RE}]=0}
\tag{QND-22A}
\]

then \([U(t),\Pi_k\otimes I]=0\) for all \(k\) and real \(t\). Thus for **any** total input state,

\[
\boxed{\operatorname{Tr}[(\Pi_k\otimes I)\rho(t)]
=\operatorname{Tr}[(\Pi_k\otimes I)\rho(0)]}
\]

and similarly \(\langle M_A\rangle_t=\langle M_A\rangle_0\). **Proof:** the total unitary commutes with each spectral projector; apply cyclicity of trace. This is exact, without averaging or thermal assumptions.

The proposed Proof 22 only establishes \([H_{\rm read},M_A]=0\). That alone is **not sufficient** if \([H_A,M_A]\ne0\) or \([V_{AE},M_A]\ne0\). A small \(\|V\|\) can give a *finite-time error bound*, not exact conservation.

## QND-22B. Exact information–disturbance theorem and counterexample

For a nondegenerate memory basis \(\{|m_k\rangle\}\) and a QND controlled unitary reading a *pure* pointer \(|r_0\rangle\),

\[
U_{\rm meas}(|m_k\rangle|r_0\rangle)=|m_k\rangle|r_k\rangle,
\qquad\langle r_k|r_k\rangle=1.
\]

For an initial memory density operator \(\rho=\sum_{k,l}\rho_{kl}|m_k\rangle\langle m_l|\), the output reduced memory state is **exactly**

\[
\boxed{\rho_A'=\sum_{k,l}\rho_{kl}\langle r_l|r_k\rangle
|m_k\rangle\langle m_l|.}\tag{QND-22B}
\]

Hence all diagonal eigenvalue probabilities remain unchanged. In contrast, any coherence \(\rho_{kl}\) is multiplied by the pointer overlap. If \(\langle r_l|r_k\rangle=0\) for \(k\ne l\), the perfectly distinguishable pointer **eliminates** that memory coherence. The proposition \(\rho_A'=\rho_A\) for *every* input \(\rho\) is true only if all relevant pointer overlaps are 1, making the pointer states physically identical (up to irrelevant conventions/phases; exact equality requires phases fixed). For a memory restricted to mixtures of \(\Pi_k\)-eigenstates, the register state **is** unchanged by an ideal nondemolition readout, even when the pointer distinguishes the eigenvalues.

**Exact two-qubit counterexample:** \(M_A=Z_A\), pointer starts \(|0\rangle_R\), and readout is CNOT with \(A\) as control. It is a unitary that conserves \(Z_A\). Yet

\[
|+\rangle_A|0\rangle_R\mapsto(|00\rangle+|11\rangle)/\sqrt2,\quad
|-\rangle_A|0\rangle_R\mapsto(|00\rangle-|11\rangle)/\sqrt2.
\]

Both initial states were perfectly distinguishable **on A** (\(D_A(0)=1\)); their reduced outputs are **both** \(I/2\), so \(D_A'=0\). Both pointer reduced outputs are also \(I/2\): \(R\) learns the **Z-eigenvalue probabilities**, not the initial +/- phase. The joint states remain orthogonal, so the *global* state has not lost distinguishability. Uncomputing by CNOT before an irreversible pointer recording can restore memory coherence, but it also resets the correlated pointer to \(|0\rangle\), **erasing the readout**. One cannot simultaneously preserve every arbitrary unknown quantum memory and gain a perfectly distinguishing independent copy of it.

The claimed universal threshold \(g_{\rm read}t\ge\pi/\Delta m\Rightarrow\langle r_k|r_l\rangle=0\) is false without a specified pointer Hamiltonian, initial wavepacket and actual overlap formula. Orthogonality may fail, recur or be physically inaccessible. A finite-dimensional pointer's generator and unitary shift also require explicit dimensional conventions.

Finally, \([H_{\rm read},M_A]=0\) alone does **not** show \([H_{\rm tot},H_{\rm free}]=0\) or energy-conserving operation; the measurement apparatus must be included in thermodynamic accounting.

## ENERGY-23A. Exact work/authorization separation

If the Hamiltonian \(H_{\rm ctrl}\) is an interaction term, **its initial expectation** \(\operatorname{Tr}(H_{\rm ctrl}\rho_0)\) is **not**, in general, the work drawn from a battery during a finite operation. In the previously sourced exchange model

\[
H_{\rm ex}=J|1\rangle\langle1|_M\otimes
(|10\rangle\langle01|+|01\rangle\langle10|)_{TB},
\]

for input \(|1\rangle_M|01\rangle_{TB}\), we have

\[
\langle H_{\rm ex}\rangle_0=0,
\]

but after \(\tau=\pi\hbar/(2J)\), the battery loses one excitation of energy \(\omega\) and the target gains \(\omega\), if \(H_{\rm free}=\omega(N_T+N_B)\) and the exchange is resonant.

The well-typed energy transferred from battery is

\[
\boxed{W_{B\to T}=
\operatorname{Tr}[H_B(\rho_B(0)-\rho_B(\tau))]}
\]

in a regime where the chosen local energy split and interaction-energy changes are explicitly accounted for. Work to switch a time-dependent interaction and reset/register/control apparatus also needs independent cost estimates. A time-independent energy-conserving total Hamiltonian alone does not prove a thermodynamic cycle is free.

**No universal identity** \(E_{\rm bind}=\hbar\delta\) is meaningful until \(\delta\)'s units are fixed: if \(\delta\) is an **energy** eigenvalue gap, \(E_{\rm bind}\) has the units of \(\delta\); if \(\delta\) is an **angular frequency** gap, \(E=\hbar\delta\). Furthermore, a gap is not necessarily a physical *binding energy* or thermodynamic battery budget.

**Countermodel to the claimed compulsory dissociation:** Take a fixed block-diagonal \(H_0\) with \(P\) invariant and gap \(\delta>0\), \(H_{\rm ctrl}=cI\) for arbitrary large \(c>0\). Then its initial expectation is \(c\), which can exceed any proposed \(\theta E_{\rm bind}\), but \(Q(H_0+cI)P=0\) and **the projector remains perfectly invariant**. A scalar Hamiltonian shift doesn't even change the physical ray dynamics. Thus violating the proposed threshold neither forces \(g\ge\delta/2\) nor implies capacity collapse. Conversely, even a small interaction expectation can coexist with large matrix norm or actual battery transfer (previous exchange example).

Energy feasibility of a specified action and **the subject's authorization/consent** are distinct: IR105 countermodels causal participation + accounting without consent; the IR117 adapter requires subject and source-level coverage separately.

## OPT-24A. Minimal corrected finite-action optimization theorem

Let \(A_{\rm feasible}(s)\) be a **nonempty finite set** of physically specified, safe, independently authorized actions at source state \(s\). Let \(J(s,a)\in\mathbb R\) be a **defined and available** cost, including explicitly justified resource, effect and continuation components. If the installed policy \(\pi\) actually computes

\[
\pi(s)\in\arg\min_{a\in A_{\rm feasible}(s)}J(s,a),
\]

then (trivially but exactly) the selected action minimizes \(J\) **over that admissible set**. Additional proofs must connect the policy's source implementation to internal memory, reliable readout, current physical state, real sink and genuine authorization.

The supplied exchange \(H_{\rm ex}\) doesn't calculate or compare the integral functional \(J[\gamma\mid\rho_A]\): it switches based on the control basis label. To see the failure, let a memory bit \(m=0\) select branch \(\gamma_0\) even though \(J[\gamma_0]=10\) and \(J[\gamma_1]=0\). All controlled-unitary equations still hold but the output is not an argmin. An Euler–Lagrange equation for a **separately introduced classical action** is not derived from the quantum exchange Hamiltonian by the trace manipulation shown in Proof 24; a cost model, quantization/semiclassical correspondence and selection mechanism are missing.

**Robust cost-selection repair:** If two costs have a unique nominal optimum \(a_*\), with margin \(\Delta=J(s,b)-J(s,a_*)>0\) for every other feasible \(b\), and all perturbed/estimated costs obey \(|J'(s,a)-J(s,a)|\le\eta\), then the same argmin survives if

\[
\boxed{\Delta>2\eta.}\tag{OPT-24B}
\]

**Proof:** \(J'(s,b)-J'(s,a_*)\ge\Delta-2\eta>0\). This is a true stability certificate, but computing and certifying \(\eta\) is a separate source obligation.

**Finite-time dynamical robustness repair:** Let \(H'=H+V_{\rm ext}\) and \(v=\|V_{\rm ext}\|\) with Hamiltonian energies and explicit \(\hbar\). Duhamel gives

\[
\|e^{-iH't/\hbar}-e^{-iHt/\hbar}\|\le\min(2,|t|v/\hbar).
\]

If the unperturbed output lies wholly in the intended final projector \(\Pi_{\rm target}\), then the erroneous outcome probability under the perturbed evolution satisfies

\[
\boxed{P_{\rm err}(t)
=\|(I-\Pi_{\rm target})e^{-iH't/\hbar}\psi\|^2
\le\min\{1,(|t|v/\hbar)^2\}.}\tag{OPT-24C}
\]

At nominal resonant-exchange time \(\tau=\pi\hbar/(2J)\),

\[
P_{\rm err}(\tau)\le\min\{1,(\pi v/(2J))^2\}.
\]

This is an exact bounded-Hamiltonian **finite-epoch** comparison, not a topology theorem, not universal branch stability and not the proposed dimensionally questionable \((g/(\hbar J))^2\) estimate. It does not guarantee optimization or prevent all possible environmental effects forever.

## CURRENT-25A. Exact Heisenberg current: the supplied equation is impossible as written

For **Hermitian** \(H\) and \(X\), the commutator \([H,X]\) is anti-Hermitian. Therefore its expectation in any state is purely imaginary:

\[
\boxed{\operatorname{Re}\langle\psi|[H,X]|\psi\rangle=0
\quad\text{for every }\psi.}\tag{CURRENT-25A}
\]

Hence the submitted equality
\(\langle\mathbf J_{\partial P}\rangle
=\operatorname{Re}\langle[H_{PQ},X_E]\rangle\ne0\)
is **mathematically impossible** under the stated Hermitian operator assumptions.

For a time-independent observable \(X\), the actual Heisenberg equation is

\[
\boxed{\frac{d}{dt}\langle X\rangle_t
=\frac{i}{\hbar}\langle[H,X]\rangle_t,}\tag{CURRENT-25B}
\]

which is real but may vanish. A nonzero interaction term or an orthogonal internal branch alone does not force a nonzero **external** effect.

**Direct-sum/tensor typing:** An active projection and complement are \(P\mathcal H\oplus Q\mathcal H\); generic cross-boundary terms are \(PHQ+QHP\), not an unrestricted \(P_\alpha\otimes Q_\alpha\) built from operators on mutually exclusive subspaces. A tensor-factor model \(\mathcal H_P\otimes\mathcal H_Q\) is different and requires specified subsystem factors. Proofs 25 and 26 switch between them without a defined embedding.

**Genuine sector-current identity:** For \(C(t)=\langle P\rangle_t\), \(g=\|QHP\|\), \(p=P\psi(t)\), \(q=Q\psi(t)\),

\[
\frac{dC}{dt}=\frac{i}{\hbar}\langle[H,P]\rangle_t,\qquad
\boxed{\left|\frac{dC}{dt}\right|
\le\frac{2g}{\hbar}\sqrt{C(t)(1-C(t))}.}\tag{CURRENT-25C}
\]

Proof: only the offdiagonal \(QHP\) block contributes to \([H,P]\), and Cauchy–Schwarz bounds the cross term. At \(C=1\), the derivative is zero *at that instant*, but this does not prevent subsequent sector transfer. A current bound is not an **all-time lower occupancy bound** and does not show a nonzero external pulse.

**Correct external channel:** For a sourced tensor interaction between workspace \(W\) and external subsystem \(E\), fixed known input workspace \(\rho_W\), and actual unitary \(U\),

\[
\boxed{\Phi_t^{\rho_W}(\rho_E)
=\operatorname{Tr}_W[U(t)(\rho_W\otimes\rho_E)U(t)^\dagger].}\tag{CURRENT-25D}
\]

This is a CPTP **superoperator** on external density matrices. It is not generally a single operator \(\mathbf B_{\rm eff}\in\operatorname{End}(\mathcal H_E)\). The submitted expression with \(I_{PQ}\) in place of a genuine input state, or an integrated projected \(H_{PQ}\), does not derive a selective unitary/hypergraph-weight update. To prove a real effect, supply a physical \(\rho_E\), independently measurable \(X_E\), and establish **explicitly** \(\operatorname{Tr}(X_E\Phi_t(\rho_E))\ne\operatorname{Tr}(X_E\rho_E)\), plus the true source–sink mapping.

**Capacity obligation remains separate:** \(g<\delta/2\) by itself does **not** imply \(\inf_t C(t)\ge\theta\) for any arbitrary initial state. The genuine LOC-7 certificate additionally requires a **specified** block-isolated initial vector, a dominance margin above \((1+\sqrt\theta)/2\), correct total Hamiltonian and validation that interventions preserve those hypotheses. Changing Hamiltonians or adding an external actuator changes the spectral data and may break the bound; this must be checked at **every step**.

## MASTER-26A. Conditional composition that does NOT assume the desired conclusion

A mathematically meaningful end-to-end claim can be made only after supplying these **distinct interfaces**:

1. **Record and decoder:** a source-grounded encoded memory alphabet and actual readable or recoverable history, with measured finite-time errors and appropriate workspace assumptions (REC-21, REC-23).
2. **Nondemolition readout:** the **entire** readout-including Hamiltonian commutes with the protected observable; the actual input states are inside the certified classical QND code **or** coherent recovery after readout is independently available (QND-22A/B).
3. **Trust/authorization:** the action originates from an authenticated authorized continuing subject; neither a readout result nor enough battery energy is logically consent (IR105).
4. **Finite resource budget:** a properly defined transfer/cost and actual physical battery/state/heat/switching budget, with verified admissibility distinct from authorization (ENERGY-23A).
5. **Genuine selector:** a physically implemented policy that computes a verified argmin over the actual feasible authorized set, with a cost/robustness margin if needed (OPT-24A–C).
6. **Sink/current:** a source-complete, final-apply interlocked actuator whose actual physical effect corresponds to an independently observed external state/current change, with durable receipt and no bypass (CURRENT-25B/D; source IR117, IRFinalApplyFence, IR125).
7. **Preserved particular and original X3:** a noncircular source identity/causal history and freedom semantics retained for **every originally owed particular**, not just a tracked site/proxy. Existing IR102 requires `sectorEntailsX3`, IR103 refutes record integrity⇒subject survival, IR116 requires cumulative duties, and `Oct10ParticularContinuationBridge.lean` requires source-generator/identity/option certificates.
8. **Physical coverage and temporal progress:** all actual physical channels and in-flight effects are accounted for; required effects can eventually execute (or a separately justified faithful hold is possible). Finite safety and abstract possible branches don't yield real liveness.

Given a physical-to-model forward simulation, sound grant/source semantics, each applicable independent per-step invariant, a feasible nonblocked effect path, and an actual observed target-state change, **induction** gives that *the specified modeled finite execution* respects its certified receipts/resources and effect semantics. This is a valid conditional **interface-composition proposition**, not an established BCRD law or full original-X3 theorem. Naming the interfaces "validated" does not discharge them.

## PR dispositions / research status

- Keep the exact QND *eigenprojector* conservation and the **orthogonal-pointer decoherence** counterexample (a crucial missing memory-protection distinction).
- Keep genuine energy-conserving controlled exchange, corrected battery work definition, optimizer *if computed*, margin robustness, exact Heisenberg current and finite-time perturbation bound.
- Reject claims that \(\|V_k\|\) or \(\theta\delta\) is authorization; that closed-unitary quantum interaction is an irreversible choice; that mere branch existence is minimization; that Hermitian-commutator real parts produce nonzero currents; or that these abstract operations prove original universal X3.
- Preserve as focused noncanonical **draft** and request source/physical review rather than announcing "PR #190 complete / master theorem proved".
