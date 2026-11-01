# MASTER-26R — Repaired authenticated history-to-effect theorem: model proof, physical refinement, and countermodels

**Date:** 2026-11-01 (NZDT)  
**Status:** **partially recovered** as a conditional mathematical theorem and explicit unitary witness. Proposed unconditional Theorem 26 **not established**.  
**PR:** draft #190, noncanonical; no independent physical test, Lean kernel build, or original-X3 certification.  
**Dependencies inspected:** source modules `IR102SectorSemanticBridge`, `IR105AuthorizationIndependence`, `IR108ObservationObstruction`, `IR109RobustObservationViability`, `IR116CumulativeSubjectDuties`, `IR117SourceInstallationAdapter`, `IR131ActionLabelledBranching`, `IRFinalApplyFence`, `Oct10ParticularContinuationBridge`. Draft PR #189 AHE-1–AHE-8 and REC-21/23, CTRL-21.

## 1. Hostile review of the latest submitted Theorem 26

The proposed proof claims
\[
\mathrm{CommittedEffect}(s,r)\iff \mathrm{TrustedGrant}(r)\land \mathrm{CorrectSubject}(s,r)\land
\mathrm{CurrentHistory}(s,r)\land\mathrm{FreshEpochAndNonce}(s,r)\land\mathrm{NotHeld}(s)\land\mathrm{SufficientBattery}(s,r).
\]
This is an exact **definition of acceptance** in the serial source-model gate (AHE-1 in draft #189). It is **not** automatically a biconditional about every *actual physical external effect*. In particular:
- A device-generated grant is not subject consent (source IR105).
- QND nondemolition of an observable does not imply the observation is a fresh, correctly attributed history (IR103, IR132).
- Battery/target energy conservation does not imply a feasible funded **initial** battery; \(\operatorname{Tr}H_{\rm ctrl}\rho_0\) is not battery work (ENERGY-23A).
- Branch distinctness doesn't imply an optimizer or trusted grant (OPT-24A and IR131).
- The physical sink may be bypassed or effects may remain queued past a nominal admission check (IRFinalApplyFence/IR117).
- For Hermitian \(H,X\), \(\operatorname{Re}\langle[H,X]\rangle=0\) identically. The claimed *nonzero* physical current formula is incorrect. The correct equation is \(\dot{\langle X\rangle}=(i/\hbar)\langle[H,X]\rangle\).
- An active subspace split \(P\mathcal H\oplus Q\mathcal H\) is not a tensor factorization \(\mathcal H_P\otimes\mathcal H_Q\). The proposed trace/integrated-\(H\) formula is not in general a physical channel on \(\mathcal H_Q\), and a channel on an environmental tensor factor is not necessarily one element of \(\mathrm{End}(\mathcal H_Q)\).
- An **internal gap** \(\delta\) and \(g=\|QHP\|<\delta/2\) do not ensure an all-time capacity floor for an arbitrary initial state. Source-valued LOC-7 also needs full block spectral isolation and a correctly selected initial eigenstate; switching/feedback may change the gap and must be accounted for.

**Disposition:** Do not promote this version to a source-derived physical theorem or mark #190 merge-ready as original-X3.

## 2. RES-26A: exact weak-coupling counterexample to all-time capacity from an internal gap

In units \(\hbar=1\), take

\[
P=\operatorname{diag}(1,1,0),\quad Q=I-P,\quad
H=\begin{pmatrix}0&0&g\\0&\delta&0\\g&0&0\end{pmatrix},
\quad 0<g<\delta/2.
\]

The compressed **internal** Hamiltonian \(PHP\) has eigenvalues \(0,\delta\). The cross-sector coupling satisfies \(\|QHP\|=g\). But the external block \(QHQ\) has eigenvalue \(0\), **resonant** with the internal \(|0\rangle\) mode. For initial state \(\psi_0=|0\rangle\in\operatorname{Ran}P\),

\[
e^{-itH}\psi_0=\cos(gt)|0\rangle-i\sin(gt)|2\rangle,\quad
\boxed{C_P(t)=\cos^2(gt),\quad C_P(\pi/(2g))=0.}\tag{RES-26A}
\]

The premise \(g<\delta/2\) holds for arbitrarily small \(g\), but there is no positive all-time capacity floor. This does **not** refute LOC-7: the full **block-diagonal** \(H_0=PHP+QHQ\) has a *degenerate* zero eigenvalue, violating LOC-7's complete spectral-isolation premise.

## 3. POS-26B: explicit memory-controlled energy-conserving external target action with exact sector invariant

Let memory \(M\), target \(T\), and battery \(B\) each be qubits. Let \(\hbar=1\), \(N_T=|1\rangle\langle1|_T\), \(N_B=|1\rangle\langle1|_B\), and

\[
H_{\rm ex}=J|1\rangle\langle1|_M\otimes
(|10\rangle\langle01|+|01\rangle\langle10|)_{TB},
\quad H_{\rm free}=\omega(N_T+N_B),
\quad H=H_{\rm ex}+H_{\rm free},
\]

where \(J,\omega>0\) are energies/frequencies consistently set in units \(\hbar=1\). Then

\[
[H,N_T+N_B]=0,\qquad [H,P_M]=0,\qquad
P_M=|1\rangle\langle1|_M\otimes I_{TB}.
\]

For initial \(\psi_0=|1\rangle_M|01\rangle_{TB}\),

\[
\psi(t)=e^{-i\omega t}|1\rangle_M
\left(\cos(Jt)|01\rangle_{TB}-i\sin(Jt)|10\rangle_{TB}\right).
\]

Consequently, **for all times**,

\[
\boxed{C_{P_M}(t)=\langle P_M\rangle_t=1,}\tag{POS-26B1}
\]

and the target excitation expectation and physical Heisenberg current are

\[
\boxed{\langle N_T\rangle_t=\sin^2(Jt),\qquad
\frac{d}{dt}\langle N_T\rangle_t=J\sin(2Jt).}\tag{POS-26B2}
\]

The current is nonzero for \(0<t<\pi/(2J)\) and vanishes at the endpoints; at \(t=\pi/(2J)\) the target has one excitation and the battery zero. The state of the **memory label** remains unchanged. This is a nontrivial, exact finite-dimensional example with a conserved memory-labelled sector and a measurable external target change. The effect need **not** be a P-to-Q population leak: it occurs inside the invariant \(P_M\) sector on a **separately tensor-factorized target**.

**Limits:** \(P_M\) is a projector on a control bit, not a physically validated particular; a real person's identity/consent is not encoded by declaring \(|1\rangle_M\) to be an authorized state; battery reset, scheduling, energy to initialize/switch the interaction, sensor fidelity, durability and physically complete sink coverage are not established. The mere unitary does not issue an authenticated grant, and its output cannot be called X3 on that basis.

## 4. GATE-26C: correct discrete final-apply theorem in the precise model

Let \(S\) be the serial model state specified in PR #189 AHE-1–8: source-associated subject identifier, exact history head, epoch, consumed nonces, battery and target integer energy, held flag, trusted grant set, durable receipts. Let \(r\) carry subject/history/epoch/nonce/action. Let \(\mathrm{PermitAtSink}(s,r)\) mean:

\[
\begin{aligned}
&\neg s.\mathrm{held}\ \land\ r\in s.\mathrm{trustedGrants}
\ \land\ r.\mathrm{owner}=s.\mathrm{owner}
\ \land\ r.\mathrm{history}=s.\mathrm{history}\\
&\land r.\mathrm{epoch}=s.\mathrm{epoch}
\ \land\ r.\mathrm{nonce}\notin s.\mathrm{used}
\ \land\mathrm{funded}(s,r).
\end{aligned}
\tag{GATE-26C}
\]

The *defined* atomic gate transition \(\mathrm{apply}(s,r)\) commits if and only if \(\mathrm{PermitAtSink}(s,r)\), under the explicit definition that a successful permit commits and a rejected one is a no-op. In the permitted case, the model deducts and transfers the specified energy, consumes the nonce, appends the receipt, and updates history **atomically**. In the denied case, no modeled effect lands.

**Theorem:** Every *modeled* committed effect has a pre-state certificate satisfying GATE-26C, modeled battery+target energy is conserved, and no same-nonce replay or stale-epoch request can commit after a hold. Under a trusted issuance relation and correct subject/physical correspondence, this is a useful final-sink safety *specification*. **Proof:** constructor inversion for each allowed apply transition, and inductive invariants over serial transitions. A finite counterexample to source-completeness is a bypass that directly modifies target and battery while leaving the gate's receipts unchanged; energy remains conserved but the external effect is unauthenticated.

The converse \(\mathrm{PermitAtSink}\Rightarrow\mathrm{real\ physical\ effect}\) **is not derivable** from the predicate. It additionally needs execution readiness, a nonblocking physical sink, correctly funded/charged hardware, and fair timely delivery. Conversely \(\mathrm{realEffect}\Rightarrow\mathrm{PermitAtSink}\) requires complete coverage, authentic grants, no bypass, and a credible simulation/relation from all actual physical effects to atomic model commits.

## 5. REF-26D: exact *conditional* physical refinement and original-X3 theorem

Let \(P_{\rm phys}\) be the physical state space and \(S_{\rm gate}\) the model gate state space. Let \(R\subseteq P_{\rm phys}\times S_{\rm gate}\) be an independently justified physical-source/model relation, \(\mathrm{realStep}\) include all physical effect-bearing transitions, and \(\mathrm{gateStep}\) include committed/rejected/hold/release transitions. Define \(\mathrm{RealReach}\) and \(\mathrm{ModelReach}\) as their reflexive-transitive finite closures. Let \(\mathrm{Protected}_{\rm phys}(p)\) denote the independently grounded original subject's continuation/rights, not a definition by record receipt or occupancy.

Assume **separately**, with evidence:

1. **Initial physical-state correspondence** \(R(p_0,s_0)\).
2. **Forward complete physical-source mediation**: for every real transition \(p\to p'\) and related model state \(s\), there exists a corresponding atomic model step \(s\to s'\) with \(R(p',s')\), including any in-flight effects, releases and bypass attempts that could physically land. Every actual effect is tied to a **committed** model effect with correct observed outcome; an identity stutter cannot hide a physical effect.
3. **Authenticity and subject semantics**: the trusted-issued grant is the same *continuing subject's* genuinely authorized consent for the particular action at the precise time, not merely an authenticated device token or causal node.
4. **Faithful receipt and resource measurements**: each actual effect agrees with the exact committed receipt and externally calibrated battery/target accounting, including true hardware final-apply checks, independent current sensor calibration and no unrepresented work/heat routes.
5. **Original-X3 source semantics and preservation**: each real step of the closed effective subject/process preserves the actually existing original-X3 duties (or has an independently authorized exception) and retains all required accessible options, with cumulative owed-subject identity, source causal succession and physically realized alternatives, not merely a functioning switch. This must be proven using the unchanged original-X3 predicates and evidence, not stipulated by redefining them as occupancy and nonce freshness.
6. **Nonvacuous progress if requested**: verified actuator readiness, nonblocking transitions and appropriate fairness guarantee actual action execution, not only a logical possible alternative.
7. **Capacity under complete time-varying operations**: independently establish the all-time sector bound for the **full** physical evolution, including readout, control, battery, environment and intervention. For fixed H one sufficient condition is LOC-7's full-block isolated eigenvector with dominance margin. Across changing Hamiltonians, an alternative sufficient theorem is INV-26E below.

**Finite-trace consequence:** Starting from \(R(p_0,s_0)\) and verified initial subject protection, induction lifts each *actual* physical step to a gate step with its explicit grant/resource/finality certificate, preserves physical original-X3 by (5), and carries source/receipt correspondence. Thus for every finite physically covered trace the **specified** original particular's certified conditions and associated actual effect receipts remain sound. The conclusion is **conditional** on the independently established interfaces, especially (2),(3),(4),(5); mathematical finite-dimensional examples do not supply these facts.

**No universal reach or all-time physical completeness is proved by this abstract finite-step theorem.** The source IR117 installation adapter, IR131 authorized branching, IR105 consent independence and Oct10 particular-continuation generator obligations are directly relevant. IR102's `sectorEntailsX3` remains an independently justified hypothesis.

## 6. INV-26E: genuine all-time sector bound compatible with time-varying control

**Theorem:** Let \(P,R\) be orthogonal projectors on one Hilbert space, \(d=\|P-R\|\), and \(U(t)\) a unitary propagator satisfying \([U(t),R]=0\) for **every** time \(t\), including every readout, feedback and physical-control epoch. For any normalized \(\psi\in\operatorname{Ran}P\),

\[
\boxed{\|(I-P)U(t)\psi\|\le\min(1,2d),\quad
C_P(t)\ge1-\min(1,2d)^2\ \ \forall t.}\tag{INV-26E}
\]

**Proof:** Since \((I-P)P=0\),

\[
(I-P)U(t)P=(I-P)[U(t),P]P.
\]

Using \([U(t),R]=0\) gives \([U(t),P]=[U(t),P-R]\), hence \(\|[U(t),P]\|\le2\|P-R\|=2d\); norm of \((I-P)U(t)P\) never exceeds 1. Squaring the leakage amplitude yields the stated bound.

This is exact, **phase-resolved**, does not use time averaging or require any recurrence. A sufficient condition for \([U(t),R]=0\) is a suitably regular time-dependent Hamiltonian satisfying \([H(t),R]=0\) for *every* time, including switching/measurement/control operations. To guarantee \(C_P(t)>\theta\), it suffices that \(2d<\sqrt{1-\theta}\). Finding a physically justified invariant \(R\) close to the real particular sector \(P\), and preserving it through every real effect, remains an **unproved source-level obligation**.

This is often a more appropriate **pipeline-wide** capacity theorem than reusing a single static isolated-eigenvalue certificate after the Hamiltonian changes. It still proves only occupancy of a specified mathematical sector; original subjecthood and X3 are not automatic.

## 7. Recommendation

Retain the proposed Theorem 26 as an **unproved source-level master claim**. Preserve GATE-26C (true finite-state final-apply specification), POS-26B (energy-conserving controlled target effect with an invariant memory-labelled sector), and INV-26E (genuine all-time time-dependent sector bound) as exact mathematical progress; retain REF-26D only as **conditional refinement schema** with clearly identified unverified physical/semantic joins.

No merge/publication of PR #190 as an established original-X3 or universal physical protection theorem is warranted. Instead verify an actual physical effect sink and current sensor against the final-apply model, source-authenticated consent, memory–agent continuity, invariant-sector observations, and complete physical-channel coverage.
