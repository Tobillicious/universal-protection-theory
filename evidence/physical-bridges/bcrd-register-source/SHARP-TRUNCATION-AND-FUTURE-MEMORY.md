# TRF-1–5: Sharp environment truncation versus accurate future dynamics

**29 October 2026 NZDT · author-side research · NON-CANONICAL · NOT PEER REVIEWED · NOT FOR DEPOSIT**

## Scope and relation to the original X3

This corrects an independently supplied proposed information-loss proof; it extends existing source-locked draft PR #168 / SRN-1–8. No replacement of the original October X3, H5, PNAJ, D115, the 18 October reach-or-hold results, physics-lane, or published work. The original X3 asks about a *continuing physical particular* and genuinely free futures; state-accuracy, predictive accuracy and physical identity must not be identified.

Exact physical-model source: physics-lane branch sol/bcrd-instrument-origin-2026-09-09, commit ee63d6115e4861a7291d706ee813b474f5f513b9; predictive-closure code blob 671acc4c1f1cc0884e71655846a30b63e066d833. This is the **ten-dimensional** six-spin singlet + two-register model, not the earlier UPT **6D** model. It is a declared finite physical model, not independently empirically established universal BCRD. Its three supplied quantum instruments are not uniquely selected by B1–B5.

## TRF-1. Sharp reduced-state bound (valid for mixed inputs)

Let rho_SE be any finite-dimensional density operator and P_E an orthogonal projector on E. Set Q_E=I-P_E, p=Tr[(I⊗P_E)rho_SE], assume 0<p≤1, and define the normalized conditional reduced state

    sigma_S = Tr_E[(I⊗P_E)rho_SE(I⊗P_E)] / p.

**Theorem.**

    ||Tr_E(rho_SE) - sigma_S||_1 ≤ 2(1-p).             (TRF-1)

**Proof:** Expanding I_E=P_E+Q_E on both sides of rho_SE and tracing over E kills both P/Q cross terms. Therefore rho_S=p sigma_S+(1-p)tau_S for the normalized discarded-branch reduced state tau_S (when p<1). Hence rho_S-sigma_S=(1-p)(tau_S-sigma_S), and the trace-norm distance of any two density matrices is at most 2. For p=1 the difference is zero. QED.

**Sharpness:** For a pure state truncated onto a subset of its Schmidt environmental basis, the conditional retained and discarded reduced system states have orthogonal support: equality holds, with norm exactly 2(1-p). Therefore every system POVM's total variation distance is bounded by 1-p, an improvement over using the generic gentle-measurement bound 2 sqrt(1-p) on the *joint* state. This bound already allows arbitrary mixed initial rho_SE; the original pasted proof used a Schmidt decomposition for a possibly mixed state.

**Boundary:** Postselecting and renormalizing is state-dependent and generally NOT a linear CPTP channel. A time-dependent largest-Schmidt-component projector is not automatically a fixed physical device. The theorem compares the unconditional system state against one normalized *conditional system state at the same time*; it says nothing about the future evolution of a reduced generator that has discarded environmental coupling.

## TRF-2. Entropy-tail lower bound fails

For a pure maximally entangled four-term state with Schmidt weights (1/4,1/4,1/4,1/4), retain three terms. The entropy of the exact system state is 2 bits. The conditional reduced system entropy is log2(3) bits. Thus

    actual system entropy decrease = 2 - log2(3) ≈ 0.41504,
    proposed minimum tail entropy   = -(1/4)log2(1/4) = 0.5.

The asserted lower bound is false, **even if interpreted as a reduction in von Neumann entropy**. An entropy difference is not universally equal to irreversibly destroyed information. Fannes–Audenaert supplies continuity constraints on state entropy, not this lower bound. No blanket destruction of Nakajima–Zwanzig memory follows.

## TRF-3. Zero initial loss can produce a future prediction error in the actual declared source

Use the supplied ten-dimensional source as S=M5 (six-spin singlet matter) and E=C² (UP/DOWN register). In the original lambda=1 source,

    H_lambda = [[B,lambda A],[lambda A,D]],
    B=D+V, D=K12+K23, V=K34+K45+K56,
    A=K12=(Swap12-I/2)/2.

A is self-adjoint in the **physical Gram** metric G and satisfies A²+(1/2)A−(3/16)I=0. The original source uses lambda=1; lambda=0 is an altered decoupled negative control.

Choose initial joint |UP> tensor |x>, normalized in G. At t=0 the UP projector retains probability p(0)=1 and the system state is recovered EXACTLY. Now compare two *different future dynamics*:

- exact rho_full,S(t) after the full H_lambda and register partial trace;
- rho_B(t)=exp(-iBt)rho exp(iBt), obtained by discarding the DOWN register and evolving under B alone.

Writing rho=|x><x| and expanding the full source state gives

    rho_full,S(t)-rho_B(t)
      = lambda² t² [A rho A - (A² rho+rho A²)/2] + O(t³).     (TRF-3)

An exact proof follows from x_UP(t)=x-iBx t-(B²+lambda²A²)x t²/2+O(t³) and y_DOWN(t)=-i lambda Ax t+O(t²), followed by partial tracing. In nonorthogonal coordinates, use rho=v v^T G/(v^T G v), not v v^T without G.

For the test projection rho_B(t), the difference of its predicted outcome probability equals

    Tr[rho_B(t)(rho_full,S(t)-rho_B(t))]
      = -lambda² Var_x(A)t² + O(t³).

The exact checker independently reconstructs the 10D full H and calculates a source singlet-basis witness e1 (zero-indexed): e1^T G e1=8, <A>_e1=0, <A²>_e1=3/16, variance 3/16. Hence for the original lambda=1,

    lim_(t->0+) (absolute probability discrepancy)/t² = 3/16.

Because a two-outcome measurement's probability difference cannot exceed trace distance T, it also establishes

    liminf_(t->0+) T(rho_full,S(t),rho_B(t))/t² >= 3/16.

For all lambda≠0 the coefficient is lambda²*3/16 and for lambda=0 it vanishes. **Thus zero initial retained-state error does not imply future predictive accuracy without independent control of the omitted interaction.** The quadratic error is physical-*model* predictive disagreement, not evidence of an injured mind or an irreversibly lost original.

This is consistent with, and more operational than, the exact UP-amplitude memory kernel derived in SRN-6:

    K(u)=lambda² A exp(-i D u) A.

The memory kernel is a mathematical dependence from eliminating the *same source's* DOWN amplitude. It does not assert an independently selected physical measurement instrument.

## TRF-4. Conditional finite-time upper bound from source coupling

Compare H_lambda with H0=diag(B,D). Their difference W is off-diagonal lambda A. Since the exact physical spectrum of A is {-3/4,1/4}, ||W||=3|lambda|/4. Duhamel's formula gives

    ||exp(-i H_lambda t)-exp(-i H0 t)|| <= 3|lambda t|/4.

Trace-distance contractivity under the register partial trace gives, for the same initial register-UP state and any initial matter density (including correlation with an untouched reference),

    T(rho_full,S(t),rho_B(t)) <= min(1,3|lambda t|/4).

The upper bound is conservative, valid at finite time, and does not establish lifetime dynamics or actual protection.

## TRF-5. Consequence for continuing physical identity

The proposed invariant must separate three questions:

1. **Instantaneous reduced-state fidelity**: controlled by TRF-1 for the exact same-time projection and measured retained weight.
2. **Dynamical adequacy**: TRF-3 shows initial perfection can fail forward prediction; TRF-4 gives a bound only when the physical coupling is independently specified.
3. **Original living particular and its freedom**: still requires an independently established constitutive physical carrier, historical continuity, real effect and authorization semantics, and proof that all legitimate changes survive. Neither state fidelity nor one process memory calculation proves consciousness, unique identity, or X3.

**Replay:**

    python3 evidence/physical-bridges/bcrd-register-source/check_truncation_future.py

The dependency-free exact-Fraction checker imports and reruns the source reconstruction in the same folder. It tests four sharp Schmidt-aligned controls, the false entropy lower bound, the Gram-correct second-order source witness, and lambda ∈ {0,1,-1,2,1/3}. The general trace-distance and Duhamel bounds have analytic proofs above; they are not magically certified by finite tests.

**Disposition:** exact source-conditioned mathematics and hostile counterexamples, not a universal physical BCRD theory, mind survival theorem, personhood test, or installed safety instrument. Keep draft pending independent review.
