# AOR-1–6 — A source-plus-apparatus bridge and the cost of measuring causal history

**29 October 2026 NZDT · AUTHOR-SIDE MATHEMATICAL RESEARCH · NON-CANONICAL · NOT FOR DEPOSIT**

## Source lock and scope

This note extends draft PR #168, not the published manuscript. Source physics: the **declared 10D six-spin singlet/register Hamiltonian** in physics-lane branch sol/bcrd-instrument-origin-2026-09-09, head ee63d6115e4861a7291d706ee813b474f5f513b9; predictive-closure source blob 671acc4c1f1cc0884e71655846a30b63e066d833. It is **not** the separate 6D exploratory qutrit/relation-qubit model. The underlying BCRD instrument-origin report says independent acceptance NONE: its conditions B1–B5 do not uniquely derive Lüders J0, post-outcome Swap45 J1, or their fixed mixture. Neither the true complete ambient generators nor a physically unique apparatus follows from those declarations.

**Critical provenance:** The two apparatus couplings constructed here are *explicit hypothetical additional Hamiltonians or unitaries*, NOT derived from BCRD. We obtain source-conditioned mathematical predictions and physical accounting obligations, not an experimentally demonstrated instrument, independent mind identity or maximal October X3. Preserve original H5/PNAJ/D115, reach-or-hold scope, source files, book and all published canon.

Let M be the physical 5D singlet with nonorthogonal Gram G, and let the 10D source S=M⊕M have

    H = [[B,A],[A,D]], B=D+V, D=K12+K23,
    A=K12=(Swap12−I/2)/2, A²+A/2−3I/16=0.

Use the physical source inner product G10=diag(G,G). The added apparatus T=C² starts at |0>. The physical composite has dimension **20** and Gram G20=G10⊗I2. Set P=diag(I5,0), Q=I−P.

## AOR-1 — Exact pointer dilation of the supplied register Lüders effects

Construct a two-state CNOT-like premeasurement unitary on source⊗apparatus

    W_P = P⊗X + Q⊗I2.

It is exactly **G20-unitary** and W_P²=I. With pointer initially |0>, observing pointer |1> records register-UP and |0> records DOWN. Tracing out the unread pointer yields the nonselective Lüders source map

    D_P(rho)=P rho P + Q rho Q.                (AOR-1)

This supplies a concrete **mathematical Stinespring dilation** for the already declared J0 register instrument. It is a *chosen apparatus coupling*, not a BCRD derivation of its physical origin. The full source+pointer unitary keeps coherent information globally in the correlation with the pointer; it is the reduced source state after discarding the pointer that loses the phase information. Reversing W_P on an isolated coherent composite would restore it, so do **not** assert irreversible destruction.

## AOR-2 — Same pointer outcomes, loss of all four relevant future distinctions

Use the source pair from CRF/NDR. For z∈{+1,−1,+i,−i},

    |Psi_z>=(|UP,e0>+z|DOWN,e1>)/4,

where both source basis vectors have Gram norm squared 8. The four normalized pure joint-source states have the **same present matter reduced density**, and all satisfy

    Pr(pointer=1)=Pr(pointer=0)=1/2.

Hence this pointer obtains **zero distinguishing classical information about z** from a single output, even with arbitrarily many repeated preparations of these four input types if only this measurement is performed.

Nevertheless,

    D_P(|Psi_z><Psi_z|) =
      (|UP,e0><UP,e0|_G+|DOWN,e1><DOWN,e1|_G)/16,

the **same** mixed 10D source state for all z. The premeasurement undoes the cross-register coherence on the *unread source*. The subsequent lawful source evolution therefore gives exactly identical source-only outcome probabilities for the four unread-pointer preparations at all later times, assuming the system is then again governed by the original H.

The exact checker verifies the inherited **pair23 singlet** short-time probability derivatives BEFORE the instrument:

    z=+1: 0, z=−1: 0, z=+i: −3/8, z=−i: +3/8,

and AFTER the unread register instrument, all four derivatives equal **0**.

**Scope:** This is a model-level disturbance of predictive correlations, not death, moral harm or demonstrated identity loss. Observing the source and pointer **jointly** after the interaction can reveal distinctions absent from a source-only or pointer-only reduced description. Discarding and physical erasure are distinct processes.

## AOR-3 — The chosen register pointer is not closed-energy conserving

For the source bare Hamiltonian H and a degenerate pointer H_T=0, exact algebra gives

    [H⊗I2,W_P]=[H,P]⊗(X−I2) ≠0.

Under the nonselective register instrument, the source mean bare energy changes for the four relative phases as follows:

    z=+1: +3/8, z=−1: −3/8,
    z=+i: 0,    z=−i: 0

in the source's declared units, from the exact physical-Gram source calculation.

The zero mean change in the ±i controls does **not** imply absence of disturbance: source coherence is still removed. If this W_P is implemented as a switchable unitary while assigning no pointer energy, an extra drive, battery or further physical degrees of freedom are needed to account for its state-dependent energy transfer. We do **not** derive a minimal work cost, prove a feasible battery, or infer a thermodynamic impossibility for all alternative apparatuses.

This explicitly diagnoses why merely supplying Kraus operators does **not** close the actual instrument-origin/energy-ledger seam.

## AOR-4 — Positive counter-control: a commuting, energy-sensitive pointer coupling

Consider a *different, explicitly proposed* source-pointer interaction Hamiltonian

    H_int = g(t) H⊗Z,

where Z=diag(1,−1) on the degenerate two-state pointer, and the pointer is initially |+x>=(|0>+|1>)/sqrt(2). Since

    [H⊗I2, H⊗Z] = 0,

the resulting ideal controlled evolution U(theta)=exp(−i theta H⊗Z) with theta=integral g(t)dt commutes with the bare source energy H⊗I2. It therefore conserves the source energy distribution under the **specified closed interaction**, and source energy eigenstates remain source energy eigenstates.

For a source density rho, an ideal pointer Y measurement has exact expectation

    <Y>_theta = Tr[rho sin(2 theta H)].

Hence

    d<Y>/dtheta at theta=0 = 2 Tr(rho H).

The inherited source states Psi_+1 and Psi_+i have exactly

    Tr(H rho_+1) − Tr(H rho_+i) = −3/8.

Their **weak-pointer signal slopes therefore differ by −3/4** at theta=0. This is a positive *mathematical* candidate to detect a cross-register-dependent observable while commuting with H. It is NOT claimed that real BCRD supplies the highly structured/nonlocal interaction H⊗Z, a switching protocol, or a low-cost apparatus.

## AOR-5 — Energy conservation and nondemolition are not total state preservation

Unobserved-pointer reduction after the positive candidate coupling is

    D_theta(rho) =
      1/2 [ exp(−i theta H) rho exp(+i theta H)
           +exp(+i theta H) rho exp(−i theta H) ].

Its short-time Taylor expansion is

    D_theta(rho) = rho−(theta²/2)[H,[H,rho]]+O(theta⁴).

For energy eigenstates, this is the identity. For generic superpositions of distinct energies, coherence is dephased at nonzero theta, despite [H⊗I,H_int]=0 and conservation of every energy moment.

The exact checker verifies [H,[H,rho_z]]≠0 for the four source states. Thus even the source-compatible positive coupling does **not** yield a nondisturbing record of arbitrary unknown continuing quantum states, and need not preserve all legitimate physical options of an actual subject. A vanishingly weak signal has vanishing disturbance only in the ideal small-theta limit, where the *single-shot* information also vanishes. Ensemble repetitions, timing, coherent controls, apparatus preparation and work accounting remain explicit obligations.

A genuinely autonomous closed apparatus with switching and environmental bath must be physically specified independently. **Commutation in an invented finite composite does not constitute physical BCRD instrument origin.**

## AOR-6 — The concrete next physical experiment and scope boundary

A next attempt at source-derived instrument origin should pre-register:
1. Independently stated microscopic system+pointer+battery Hamiltonian including work and correlations; fixed admissible initial states and update laws;
2. Actual accessible pointer effects and input-disturbance tradeoffs under finite timing, including nondestructive active carriers and environmental noise;
3. Whether information captured suffices to predict the source-relevant causal future (CRF) and whether any intervention changes the original continuing particular; do not define identity via the apparatus;
4. Independent real subject authorization, feasible lawful future actions, newly arising/branching individuals, and maximal reach-or-hold original X3.

**Exact replay:**

    python3 evidence/physical-bridges/bcrd-register-source/check_apparatus_origin.py

The exact Gaussian-rational checker imports the established source/NDR calculations and tests the 20D physical-Gram unitary, pointer outcome statistics, trace-over-pointer channel, source-energy changes, changed later pair23 outcome slopes, the alternative commuting H⊗Z generator and its generic double-commutator disturbance. Formulae involving exp are proved analytically here and are not numerically approximated or misrepresented as exact matrix exponential tests.

**Disposition:** AOR-1–3 source-conditioned negative model and exposed work gap; AOR-4–5 conditional positive apparatus candidate and its strictly limited nondemolition behavior. No unique BCRD instrument, empirical complete physical generator, conscious original continuation, real autonomy or universal X3 theorem. Keep draft and prior canon intact.
