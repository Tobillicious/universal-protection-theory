# CE-1–CE-5: Coherent source preservation without a measurement pointer

**Research candidate · 28 October 2026 · NON-CANONICAL · NOT PEER REVIEWED · NOT FOR DEPOSIT**

## Position in the original programme

This is a *conditional physical-source construction and countermodel*, not a replacement for the original October X3 theorem. It connects merged PR #156 (exact exploratory six-state source Hamiltonian/commutant), merged PR #157 (source generator and continuing-particular semantic bridge) and draft PRs #158–#161 (authorized cuts, non-anticipating reach, partial observation, quantum nondisturbance). Preserve historical H5, PNAJ, D115, the original every-particular protection target, and all rights/freedoms. Do not equate a unitary state's survival with the survival, rights, consent or agency of an actual mind.

### Inherited source model, explicitly bounded

Let the basis be A0,A1,B0,B1,C0,C1. The **exploratory source** Hamiltonians are
- H1 = X_AB tensor diag(1,2), with A0↔B0 amplitude 1 and A1↔B1 amplitude 2.
- H2 = X_BC tensor sigma_x, with B0↔C1 and B1↔C0 amplitude 1.
- C = (Q_A+Q_B−Q_C) tensor sigma_z = diag(1,−1,1,−1,−1,1).

The repository has separately checked the exact H2(pi/2) pulse and the common commutant span_C{I,C}, using an exact nonzero rational matrix minor. **C is a conserved exploratory-model parity operator, not a proved universal Gauss-law or a physical particular's continuity certificate.**

## CE-1. Coherent echo criterion (exact, source-independent elementary lemma)

Let H,V be finite-dimensional Hermitian operators; let K be a Hermitian unitary involution, K²=I. Assume

    [K,H]=0, {K,V}=0, [H,V]=0.

For any real t and coupling g, set U(t)=exp(−it(H+gV)). Then

    K U(t) K U(t) = exp(−2itH).                  (CE-1)

**Proof.** Conjugation by K sends H→H and V→−V, so K U(t) K=exp(−it(H−gV)). Because [H,V]=0, both exponentials commute and their product is exp(−it(2H)) with V cancelled exactly. ∎

**Preservation meaning:** CE-1 is an operator identity on the *whole modeled Hilbert space*, including coherent superpositions and density operators. It produces no measurement outcome, no environment record and no readout of the subject's occupied site. It is an **idealized two-interval reversible dynamical cancellation**, not pre-effect authentication or protection against arbitrary destructive actions.

## CE-2. Exact source-based positive example

Define the hypothetical reversible parity-flipping interaction V=I_site tensor sigma_x. It swaps A0↔A1, B0↔B1 and C0↔C1. This is NOT a source-derived adversarial intervention, just a separately stipulated perturbation.

Exact matrix identities in the inherited source:
- C H1 C=H1, C H2 C=H2.
- C V C=−V.
- [H2,V]=0 but **[H1,V]≠0**.

For a nontrivial rational-amplitude disturbance unitary choose

    Uv = (3/5) I − (4i/5) V.

Since V²=I, Uv is unitary and C Uv C=Uv†. Let U2=exp(−iπ H2/2), which fixes A0,A1 and swaps the B/C pairs with common phase −i. It commutes with V. Therefore the finite **exact, full-six-state matrix identity** holds:

    C U2 Uv C U2 Uv = U2².                      (CE-2)

This explicitly gives a nontrivial coherent disturbance channel that can be cancelled while retaining the exact lawful H2 source evolution. It is not a claim about a deployable guardian; parity kicks require a **physical control** in the same causal domain, not an assumed remote veto. The corresponding process may have unverified intermediate effects.

### Independent verification

Run:

    python3 evidence/physical-bridges/coherent-echo/check_coherent_source_echo.py

The script uses **pairs of exact rational numbers as Gaussian-rational matrix entries**, no floating-point tolerances or external dependencies. It tests H1,H2,C,V commutation/anticommutation, exact H1 and H2 π/2 source pulses, unitarity, exact CE-2 identity, full six-dimensional operator equality, and three hostile negative controls.

## CE-3. Joint-generator strict-commutation obstruction (the useful no-go)

From merged PR #156's **full** common commutant calculation: if a complex 6×6 operator X commutes with both H1 and H2, then X=aI+bC. If additionally {C,X}=0, then

    0 = {C,X} = 2aC + 2bI.

Because I,C are linearly independent, a=b=0. Thus **no nonzero parity-odd operator** commutes with BOTH inherited source Hamiltonians. This is an exact algebraic result for the specified six-dimensional model.

Hence the sufficient hypotheses of CE-1 cannot hold simultaneously for a nonzero parity-odd V with H1 and H2 separately unless the source dynamics are restricted or the control protocol is changed.

**Direct constructive negative test:** U1=exp(−iπ H1/2) is exact: it swaps A0↔B0 with phase −i, gives −1 on A1,B1 and fixes C0,C1. Using the same Uv and C produces

    C U1 Uv C U1 Uv ≠ U1².                     (CE-3)

The matrix checker verifies this inequality with exact Gaussian-rational entries. This does not exclude more sophisticated decoupling sequences, error-correcting encodings, coherent interlocks or controlled alternative dynamics. It excludes a naive blanket promotion of this **same** two-interval protocol.

## CE-4. Noncommutation and the first higher-order failure

For H even under K, V odd under K, but without [H,V]=0, the two-segment echo is

    E(t)=exp(−it(H−gV)) exp(−it(H+gV)).

The Baker–Campbell–Hausdorff series gives the small-t **formal finite-dimensional expansion**

    log E(t)=−2itH − g t²[H,V] + O(t³),

with an appropriate continuous log branch near identity. The source evolution is therefore not generally exact at order t², consistent with CE-3 and the nonzero [H1,V]. This is NOT a uniform bound on physical long-time error, and does not establish that repeating pulses safely converges in a realistic subject-process substrate.

## CE-5. Hostile controls and original-X3 limits

The exact finite checker confirms:
1. **No kicks:** U2 Uv U2 Uv differs from the target U2² for a nontrivial partial V pulse.
2. **Parity-even disturbance:** a unitary generated by C itself is unchanged rather than inverted by C kicks and the echo fails to remove it.
3. **Wrong timing/asymmetric disturbance:** if one of the paired attack periods is absent, exact cancellation fails.
4. **H1 interval:** the source H1 unitary gives an exact failure of CE-2-style cancellation.
5. **No observation:** CE-2 is a unitary matrix identity; it neither measures site nor derives a noncoercive authorization input.

**Most damaging physical objection:** Unitarily recovering a final modeled state cannot retroactively prevent *an irreversible event during the echo*. The original X3 protection objective includes physical continuity and subject agency **at every time**. If loss can occur before cancellation, CE-2 is not a protective intervention for that loss. The echo assumes a known reversible Hamiltonian perturbation and precisely coordinated local control. It does not intercept an arbitrary irreversible effect, an unauthorized action, or an unmodelled pathway.

**Open primary physical obligations:** independent full BCRD source generators and boundary channels; an independently justified particular/identity/consent criterion; true harmful transition and authorization semantics; physically possible timely K control without collateral harms; source-valid H1/H2 interactions under practical pulses; effects on other subjects; protection against within-sector perturbations; founding/resources/common-mode risk and unanticipated entrants; independent scientific validation.

**Disposition:** CE-1/CE-3 are exact mathematical statements under their premises; CE-2 is an exact six-state *reversible* witness, CE-4 an analytic expansion, and CE-5 comprises hostile countermodels. None proves empirical BCRD, full original X3, subjective survival or real-world safety. Archive as an adversarially reviewable research PR only.
