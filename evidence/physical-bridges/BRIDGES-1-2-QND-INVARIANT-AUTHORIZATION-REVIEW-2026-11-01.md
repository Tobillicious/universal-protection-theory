# BRIDGES-1–2 — Common invariant sector, QND memory algebra and history-labelled action gate

**Date:** 2026-11-01 (NZDT)  
**PR:** #190 (draft, noncanonical evidence).  
**Review of:** author-supplied "Bridge 1: QND Memory Inspection & Invariant Boundary Containment" and "Bridge 2: Action-Labelled Branching & Thermodynamic Authorization", plus engineering sketch of `ir117_adapter.py` and `ir131_branching.py`.  
**Disposition:** **common-projector capacity theorem ACCEPTED after repairing the proof**; exact controlled exchange ACCEPTED for the toy; **arbitrary reduced memory-state preservation, thermal expenditure inference, variational minimization and real gate authorization NOT ESTABLISHED**. No Lean kernel compilation or physical implementation claim.

## B1-1. Repair of the proof of the time-dependent invariant-sector bound

Let \(P,R\) be orthogonal projectors on the SAME Hilbert space, \(U(t)\) unitary, \([U(t),R]=0\) for **every** time including readout and action epochs, and \(d=\|P-R\|_{\rm op}<1/2\). For every normalized \(\psi\in\operatorname{Ran}P\),

\[
\boxed{C_P(t)=\|PU(t)\psi\|^2\ge 1-4d^2>0\quad\forall t.}\tag{B1-1}
\]

**Exact proof.** As \((I-P)P=0\),

\[
(I-P)U(t)P=(I-P)[U(t),P]P=(I-P)[U(t),P-R]P.
\]

The commutator inequality \(\|[U,X]\|\le2\|U\|\|X\|\) and \(\|U\|=1\) give \(\|(I-P)U(t)P\|\le 2d\). Therefore \(\|(I-P)U(t)\psi\|^2\le 4d^2\), proving the claimed bound without any time average or recurrence. QED.

**False step in the submitted proof:** its route instead gives \(C_P(t)\ge(\sqrt{1-d^2}-d)^2\) and asserts that this is \(\ge1-4d^2\). At \(d=1/10\), the former is \((\sqrt{99}/10-1/10)^2\approx0.8010\) and the latter is \(0.96\): **the asserted inequality is false**. The valid stronger conclusion comes from the commutator argument above, not that algebraic step.

**Coverage:** \(d\) is not by itself a certificate that some physical \(R\) actually commutes with the full operational propagator. A numerical function that inputs only \(P,R\) cannot verify \([U(t),R]=0\) for all time. Independent source-grounded generator checks and switching/measurement interface verification are essential. If \(P=R\), capacity is exactly one for every initially supported state. If \(0<d<1/2\), the result is a positive floor, **not generally 100% capacity**.

## B1-2. QND means eigenprojector nondemolition, not full memory-state preservation

Let the memory observable \(M_A=\sum_k m_k\Pi_k\). The valid sufficient condition for conserved populations is

\[
\boxed{[H_{\rm total}(t),M_A\otimes I_{\rm rest}]=0\quad\text{throughout readout/control}.}\tag{B1-2}
\]

Merely checking \([M_A,H_{\rm read}]=0\) is insufficient if another term in \(H_{\rm total}\) fails to commute with \(M_A\). Under B1-2, all measured eigenspace weights remain constant. For a pointer initially in a pure fiducial state, an ideal controlled readout has

\[
|m_k\rangle_A|r_0\rangle_R\mapsto|m_k\rangle_A|r_k\rangle_R
\]

and gives the exact reduced-memory density matrix

\[
\boxed{\rho_A'=\sum_{k,l}\rho_{kl}\langle r_l|r_k\rangle
|m_k\rangle\langle m_l|.}\tag{B1-3}
\]

The pointer overlaps multiply offdiagonal coherence. For mutually orthogonal \(r_k\), the readout can distinguish **classical eigenstate labels** but dephases their superpositions on the memory register. A simple memory-control CNOT maps \(|+\rangle_A|0\rangle_R\) to \((|00\rangle+|11\rangle)/\sqrt2\), hence \(\rho_A'=I/2\ne|+\rangle\langle+|\). QND does NOT imply the arbitrary-state equality \(\rho_A(t)=\rho_A(0)\), does not authenticate historical truth or freshness, and does not imply global state collapse did or did not happen.

**Positive repair:** For a *source-justified classical orthogonal memory code* \(\rho_A=\sum_k p_k|m_k\rangle\langle m_k|\) with a nondemolition pointer interaction, the ideal reduced code state remains unchanged and the pointer can contain accessible classical label information. A quantum-coherent memory code needs an independently constructed decoder/recovery operation and corresponding access and backaction proof.

## B1-3. Tensor-factor exchange does not establish P-to-Q sector current

In the proposed qubit toy \(P_M=|1\rangle\langle1|_M\otimes I_{TBQ}\). With

\[
H_{\rm ex}=J|1\rangle\langle1|_M\otimes
(|10\rangle\langle01|+|01\rangle\langle10|)_{TB}
\]

and \(|1\rangle_M|01\rangle_{TB}\), one indeed has \(C_{P_M}(t)=1\) and \(\langle N_T\rangle_t=\sin^2(Jt)\), \(\frac{d}{dt}\langle N_T\rangle=J\sin(2Jt)\). But \([H_{\rm ex},P_M]=0\), so **actual population current across \(P_M\leftrightarrow I-P_M\) is exactly zero**. The target excitation current is *within the \(P_M\) sector* and across **tensor factors B and T**, not across its orthogonal complement. A real externally accessible target may be in a tensor factor external to the memory **but this does not make the target external to \(P_M\)'s range**. Deriving an actual BCRD spatial boundary or subject identity from the memory-label projector remains a source obligation.

## B2-1. Feasible choices and an actual optimizing selector are independent

IR-131 uses an **action-labelled transition relation** and independently specified `authorised` predicate. It proves preservation of multiple *possible* alternatives under an injective, action-preserving embedding; it does not compute the source policy, certify consent, or guarantee action is performed.

For a nonempty **finite** feasible-and-authorized set \(F(s)\), an implemented policy \(\pi(s)\in F(s)\) is optimal only when it **actually satisfies**

\[
\boxed{J(s,\pi(s))=\min_{a\in F(s)}J(s,a).}\tag{B2-1}
\]

A memory-controlled Hamiltonian chooses whichever branch its memory label specifies. Its existence does not yield B2-1 for an unrelated integral Lagrangian. Counterexample: label \(m=0\) chooses branch 0 with \(J_0=10\), while branch 1 has \(J_1=0\). Both conditional Hamiltonian and orthogonal-outcome equations can hold even though the branch is not optimal.

An exact robustness theorem survives: if unique nominal cost-gap \(\Delta\) between selected branch and every rival exceeds \(2\eta\), where \(|J'-J|\le\eta\) pointwise, the selected minimizer remains the minimizer under those cost errors.

## B2-2. Energy-conserving exchange is not metabolic consent or its proposed bound

The inequality \(\|H_{\rm ctrl}\|<\delta/2\) does NOT imply
\(\operatorname{Tr}(H_{\rm ctrl}\rho)\le\theta\hbar\delta\) by "multiplying by \(\theta\)". This multiplication has no logical basis and mixes gap units unless \(\delta\) has been defined as a frequency rather than energy.

For \(\hbar=1\), take \(\delta=1\), \(H_{\rm ctrl}=0.4|1\rangle\langle1|\), \(\rho=|1\rangle\langle1|\), \(\theta=0.2\). The norm condition \(0.4<1/2\) holds but \(\operatorname{Tr}(H_{\rm ctrl}\rho)=0.4>0.2=\theta\delta\).

The expectation of the controlled interaction is also not battery work. In the resonant battery-target exchange, \(\langle H_{\rm ex}\rangle_0=0\) on \(|01\rangle\), yet \(\Delta E_B=-\omega\) and \(\Delta E_T=+\omega\) at the exchange epoch. Real resource feasibility requires independently calibrated battery energy *before* the action, switching/preparation/reset/heat accounting, and current actuator readiness. Authorization requires consent/source-origin; cost and authorization are not synonymous (IR-105).

## B2-3. Keep all six final-commit predicates and verify at the actual sink

The full gate predicate is

\[
\boxed{
\begin{aligned}
\mathrm{PermitAtSink}(s,r)\iff{}&
\mathrm{TrustedGrant}(s,r)\land
\mathrm{CorrectSubject}(s,r)\land
\mathrm{CurrentHistory}(s,r)\\
&\land\mathrm{FreshEpochNonce}(s,r)\land
\mathrm{NotHeld}(s)\land
\mathrm{Funded}(s,r).
\end{aligned}}\tag{B2-2}
\]

Proposed Bridge 2 reduces this to three conditions; the reduction is false. QND memory inspection does **not** imply history freshness, and optimizing an action does **not** imply trusted consent.

The submitted Python sketch has additional **security correctness defects**:
- `request["grant_valid"]` is treated as trust; an untrusted caller can set it to `True`.
- It compares two subject IDs **both supplied by the request**, rather than binding a grant to a protected actual source subject.
- `state_history_valid` is externally supplied, so checking it is not an authenticated physical history comparison.
- The nonce is **consumed during evaluation**, before any atomic effect and durable receipt. Thus a check can falsely consume a permit, and a separately committed effect is not established.
- Battery is never actually debited or atomically checked at the sink; a negative `energy_cost` can pass the numeric comparison unless input validation is supplied.
- No final-apply fencing, physical source controller/actuator correspondence, hold race atomicity or no-bypass coverage is derived.

**Do not deploy these snippets as a physical authorization mechanism.** PR #189's synthetic `check_authenticated_history_to_effect.py` provides a more accurately scoped model with trusted issue as an independent premise, atomic model apply, live epoch, nonce consumption, receipt and resource transfer. It is not hardware or subject consent either.

IR-117 and IR-131 are **Lean files** `PhysicalBridges/IR117SourceInstallationAdapter.lean` and `IR131ActionLabelledBranching.lean`, not Python interfaces established by the proposed filenames. A real adapter must explicitly prove/refine the existing source structures, not merely create similarly named Python classes.

## BRIDGE-12C. Conditional combined theorem worth preserving

Let a physically sourced particular have an independently justified projection \(P\). Suppose a common projector \(R\) is conserved by **every** actual readout, source-control, battery-target and effect operation; \(d=\|P-R\|<1/2\). Assume:
1. The memory is encoded in a **defined** QND-compatible classical code or an independently verified coherent recovery code and is actually accessible to the same continuing particular.
2. A real source-authenticated authorization protocol checks owner, current history, epoch, nonce, hold and actual available battery **at the final physical sink**.
3. The installed selector genuinely computes the minimum-cost permitted action over a nonempty physically feasible set, or an explicitly stated nonoptimal policy is used without claiming optimization.
4. A physically complete source/actuator/boundary correspondence and durable receipt prove that an accepted effect actually happens, including delayed/in-flight effects and no bypass.
5. The original historical-subject continuation and freedom semantics, cumulative owed-subject duties and required alternatives are preserved by each physical step, independently of occupancy.

Then the standard commutator proof gives

\[
C_P(t)\ge1-4d^2\quad\forall t,
\]

the model gate establishes **conditional** correctly authorized effect receipts at final apply, and source simulation/induction can transfer those statements to finite real traces **if all five independently verified interfaces hold**. The external-target excitation model provides a **synthetic nonvacuous example** of action while conserving an invariant memory label. This does **not** discharge original-X3 subjecthood or the physical completeness/authorization premises. It is a sound **conditional composition schema**, not a demonstration of an installed universal protection system.

**Status:** Research-stage audit and repairs; keep #190 draft/unmerged; request independent source-level and physical reviewer evidence before changing the theorem's status.
