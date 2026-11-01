# SEL-1–SEL-5 — Hostile audit of proposed Proofs 9 and 9.1: closure, quasiperiodicity and autopoietic spectral quantization

**Date:** 2026-11-01 (NZDT)  
**Disposition:** the proposed implications "boundary closure ⇒ global spectral ladder" and "positive all-time sector capacity ⇒ rationally commensurate spectrum" are **false under their stated abstract premises**. A corrected, physically demanding observable-gluing theorem is proved below.  
**Status:** non-canonical, author-side/AI-assisted mathematical research; not a BCRD source-level validation, a proof about real cosmology, or an X3 protection certificate. Keep as a draft PR.

## 1. Exact time-average fact (SEL-1)

For any real energy gap \(\Delta\),

\[
\lim_{\tau\to\infty}\frac1\tau\int_0^\tau e^{-i\Delta t}\,dt
=\begin{cases}1&\Delta=0\\0&\Delta\ne0.\end{cases}
\]

For \(\Delta\ne0\), evaluate the integral as \((1-e^{-i\Delta\tau})/(i\Delta\tau)\); the numerator has modulus at most 2, so the expression tends to zero. **The result does not distinguish rational from irrational nonzero gaps.**

For a finite-dimensional Hamiltonian with spectral projectors \(\Pi_E\) and an initial density matrix \(\rho\),

\[
\boxed{\lim_{\tau\to\infty}\frac1\tau\int_0^\tau
e^{-iHt}\rho e^{iHt}\,dt=\sum_E\Pi_E\rho\Pi_E.}\tag{SEL-1}
\]

This is a *mathematical Cesàro average* of distinct pure or mixed states, not by itself a physical dissipation channel. The formula applies equally to the commensurate Hamiltonian \(\operatorname{diag}(0,1,2)\) and the incommensurate \(\operatorname{diag}(0,1,\sqrt2)\).

**Typing defect in supplied Proof 9.1:** its feedback integral first has vector-valued integrand and right hand side, then silently replaces the integrand with an operator-valued sum of dyads. A vector and an operator cannot be equated without defining an explicit compatible map.

## 2. Explicit incommensurate state with uniformly positive capacity and nonzero leakage coupling (SEL-2)

Let

\[
H=\operatorname{diag}(0,1,\sqrt2)\quad\text{on }\mathbb C^3,
\quad
|\psi\rangle=\sqrt{\tfrac{49}{50}}|0\rangle+\tfrac1{10}|1\rangle+\tfrac1{10}|2\rangle,
\quad P=|\psi\rangle\langle\psi|.
\]

The state is normalized, and **all three** energy amplitudes are nonzero. Define active-sector occupancy:

\[
C(t)=\langle\psi|U(t)^\dagger P U(t)|\psi\rangle
=\left|\tfrac{49}{50}+\tfrac1{100}e^{-it}+\tfrac1{100}e^{-i\sqrt2t}\right|^2.
\]

By the reverse triangle inequality, for every real \(t\),

\[
\boxed{C(t)\ge
(\tfrac{49}{50}-\tfrac1{100}-\tfrac1{100})^2
=(\tfrac{24}{25})^2=\tfrac{576}{625}=0.9216>0.9.}\tag{SEL-2}
\]

For a rank-one projector, \(g=\|(I-P)HP\|\) equals the standard deviation of energy in \(\psi\). Here

\[
\boxed{g^2=\langle H^2\rangle-\langle H\rangle^2
=\frac{297-2\sqrt2}{10000}>0.}\tag{SEL-3}
\]

Thus the state is **not** an exactly invariant eigenspace; there is genuine off-diagonal coupling. Nevertheless, its occupancy is bounded above 0.9 at **every** time.

No \(T>0\) has \(U(T)|\psi\rangle=e^{i\phi}|\psi\rangle\): because all three amplitudes are nonzero and the first energy is 0, such a recurrence would require both \(T\in2\pi\mathbb Z\) and \(\sqrt2T\in2\pi\mathbb Z\), impossible for positive \(T\). The complete Hamiltonian likewise has no projective global period.

Kronecker density of the two incommensurate relative phases on the torus implies the *infimum* of the occupancy is exactly \(576/625\), though it need not be attained at a finite time.

For every choice \(0\le\theta<1\), choosing the small nonzero satellite weights sufficiently tiny yields the same construction with \(\inf_t C(t)>\theta\), no exact recurrence, and nonzero \(g\).

**Further note on the claimed local maintenance map:** the replacement channel

\[
\mathcal M(\rho)=\operatorname{Tr}(\rho)\,|\psi\rangle\langle\psi|
\]

is a well-defined CPTP map with fixed state \(\rho_\infty=P\). It does not change the spectrum of the *separately specified* Hamiltonian \(H\) into a ladder. That is a formal counterexample to "a CPTP autopoietic fixed-point condition implies spectral quantization" without a separately derived joint source/channel dynamical constraint. A replacement channel is **not** by itself a model of biological self-maintenance or the X3 notion of historical identity.

## 3. An actual closed *quasiperiodic* invariant orbit set (SEL-4)

Let \(\mathbb P(\mathcal H)\) be the space of pure quantum rays (equivalently rank-one density operators), and \(\mathcal L=\mathcal P(\mathbb P(\mathcal H))\) its complete powerset lattice. Given the continuous unitary flow \(\operatorname{Ad}_{U(t)}\), define the **dynamical saturation boundary map**

\[
\mathcal B(X)
=\overline{\{U(t)\rho U(t)^\dagger:\rho\in X,\ t\in\mathbb R\}}.
\]

The overline is closure in the standard topology of finite-dimensional projective Hilbert space. This map is inflationary (time 0), monotone, and idempotent (group property, continuity and closure). Consequently every orbit closure \(K=\mathcal B(\{\rho_\psi\})\) is a fixed point, with

\[
\boxed{\mathcal B(K)=K,\qquad
\partial_{\mathcal B}(K)=\mathcal B(K)\setminus K=\varnothing.}\tag{SEL-4}
\]

For the above three-level \(H,\psi\), the orbit closure \(K\) is an invariant two-torus of relative phases. The flow is quasiperiodic and has no positive exact projective return of \(\psi\), even though its orbit *closure* is compact, invariant and has no open \(\mathcal B\)-boundary.

Thus **finite-dimensional dynamics can possess genuine global boundary closure without an exact spectral ladder**. The construction gives a specific mathematically natural boundary map; it is not claimed to coincide with the physically defined BCRD boundary operator.

A simpler *finite-set* graph version likewise shows the insufficiency of bare closure: on the connected graph \(C_5\), define \(B(X)\) as the union of connected components meeting \(X\). On the finite lattice \(\mathcal P(V)\), this is monotone, inflationary, idempotent, and \(B(V)=V\), while its integer adjacency Hamiltonian has irrationally related gaps (see SPECTRAL-GRAPH-RIGIDITY-AUDIT-2026-11-01.md).

## 4. Strong positive replacement: tomographically complete gluing implies scalar monodromy (SEL-5)

**Theorem.** Let \(\mathcal H=\mathbb C^d\) and \(U=e^{-iHT}\) for some physically specified \(T>0\). Let \(\rho_1,\ldots,\rho_m\) be density operators whose **real linear span is the full space of Hermitian \(d\times d\) matrices**. Suppose *actual physical* one-period evolution returns each operator exactly:

\[
\boxed{U\rho_a U^\dagger=\rho_a\quad\text{for all }a.}\tag{Gluing}
\]

Then

\[
\boxed{U=e^{i\phi}I.}\tag{SEL-5}
\]

**Proof.** Conjugation by \(U\) is real-linear on Hermitian matrices, so exact gluing for the spanning set implies \(UXU^\dagger=X\) for every Hermitian \(X\). Every complex matrix is \(X+iY\) with \(X,Y\) Hermitian, so \(U\) commutes with every element of \(M_d(\mathbb C)\). The center of \(M_d(\mathbb C)\) consists of scalar matrices. Unitarity makes the scalar a phase. QED.

**Equivalent irreducible-algebra criterion:** it suffices to have a physically justified family of observables \(\{O_a\}\) generating a unital algebra \(\mathcal A\) with commutant \(\mathcal A'=\mathbb CI\), and to derive \(U(T)O_aU(T)^\dagger=O_a\) for every generator. Then \(U(T)\in\mathcal A'\), hence \(U(T)=e^{i\phi}I\).

This offers a *different, constructive* route to Proof 7: establish **actual return of an informationally complete family**, rather than claim arbitrary graph symmetry directly forces energy commensurability. It still requires physical derivation of the time \(T\) and gluing equality; assuming them is not a first-principles recurrence proof.

**Insufficient:** exact return of only one density state, or a commutative subalgebra of observables, allows noncentral \(U\). Stationary energy eigenstates are trivial examples.

## 5. Separate, necessary open obligations

1. **Physical BCRD source:** identify the frozen microscopic Hamiltonian, genuine boundary/update operator and operationally meaningful clock. A generic set-closure \(\mathcal B\) is not a sourced BCRD law.
2. **Gluing mechanism:** derive from those source objects why a suitable \(T>0\) exists and why an irreducibly generating family of *physical* observables actually returns after one period. This is not equivalent to a verbal assertion that "boundary closure selects harmonic spectra."
3. **No hidden pruning assumption:** deriving a phase-selective projection as a new operator requires showing its real implementation and accounting for all states discarded, including any already-existing particulars. "Only survivors are protected" is not universal protection.
4. **Proof 7 threshold:** phase recurrence alone does not imply \(T\|QHP\|/2<\sqrt{1-\theta}\). E.g. \(H=\sigma_x\), \(T=\pi\), \(P=|0\rangle\langle0|\) gives \(U(T)=-I\) but \(C(\pi/2)=0\).
5. **X3 correspondence:** even strict quantum-sector occupancy is not automatically the historical continuation, agency, or freedom of the same particular.
6. **Review:** these notes are mathematical counterexamples and conditional results; no physical proof of circular cosmic time, universal X3 protection, or independent validation is claimed.

## 6. Precise next question for the other model

Can a named BCRD boundary connection, Hamiltonian, source/controller instrument, or relational observable algebra **derive** a physically determined \(T\) together with exact one-cycle gluing on a family whose commutant is scalar, without presupposing phase locking? If yes, present the exact source map and proof. If not, return the strongest honest conditional result and source-level obstruction.
