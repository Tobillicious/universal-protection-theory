# QND-1–QND-5: Source-derived conserved readouts and register-diagonal obstruction

**29 October 2026 NZDT · NON-CANONICAL AUTHOR-SIDE RESEARCH · NOT PEER REVIEWED · NOT FOR DEPOSIT**

## Source and novelty limits

This uses the **actual declared 10D six-spin singlet × two-register Hamiltonian** from physics-lane branch sol/bcrd-instrument-origin-2026-09-09 (head ee63d6115e4861a7291d706ee813b474f5f513b9), reconstructed in source-locked draft PR #168, not earlier UPT's distinct 6D qutrit/relation-qubit exploratory model. Its author-side instrument-origin results have **independent acceptance NONE**: B1–B5 do not uniquely derive one of Lüders J0, Swap45-after-outcome J1 or Jhalf. Physics-lane supplied register UP/DOWN, pair12 singlet/triplet, pair23 singlet/triplet **effects**, and the post-outcome Swap45 operation.

We apply the established nondemolition/commutant criterion [H,E]=0 for a **time-independent effect whose outcome probability stays constant under the unmodified closed source H for every input state**. This is stronger than merely being able to perform a projective measurement once; it does not imply an installed instrument or single-copy non-disturbance for arbitrary superpositions. General QND and no-information-without-disturbance are known physics, not new laws.

Let M be the 5D total singlet (nonorthogonal basis Gram G), A=K12=(Swap12−I/2)/2, B=D+V, D=K12+K23, V=K34+K45+K56. The inherited source has lambda=1 in

    H_lambda=[[B,lambda A],[lambda A,D]].

A is invertible by A²+A/2−3I/16=0 and A-inverse=(16/3)A+(8/3)I.

## QND-1. The supplied frozen effects are not stationary under source H

For a static effect 0≤E≤I, expectation Tr[E rho(t)] is constant for **every** closed-system input iff [E,H]=0, by the Heisenberg equation and nondegeneracy of the trace pairing. The exact Fraction checker reconstructs source H and verifies nonzero commutators with:
- register-UP projector P_UP;
- pair12 singlet projector (1/4)I−K12, lifted identically to both registers;
- pair23 singlet projector (1/4)I−K23, also register-lifted;
- post-outcome Gram-unitary involution I_reg⊗Swap45.

All three complementary outcomes have commutators of opposite sign, so the whole two-outcome families likewise lack a conserved nontrivial outcome partition. The four chosen commutator columns are **linearly independent** (rank 4), so no nonzero linear combination of these four source operators cancels the commutator. The exact matrix nonzero-entry counts are 18, 24, 54 and 18 respectively, but the invariant conclusions use zero/nonzero and rank—not those basis-dependent counts.

**Caveat:** Failure to commute means not continuously quantum-nondemolition for **arbitrary** states under unchanged H. It does not mean the measurement cannot be made, that all input states are disturbed, or that any change is subject injury. J1 post-outcome Swap45 changes the state even if frozen immediate Born effects match J0; sequential statistics depend on the update rule. No actual physical apparatus has been selected.

## QND-2. Exact 10D theorem: ALL register-block-diagonal stationary observables are scalar

**Theorem.** Under the declared coupled source lambda≠0, if a linear operator O of the form

    O=diag(C,E), C,E ∈ Mat_5(C),

commutes with the inherited full H_lambda, then O=c I_10 for some scalar c. This includes all block-diagonal Hermitian observables and projection effects. Conversely scalar identity commutes with H.

**Proof.** Expanding [O,H_lambda]=0 in register blocks gives necessary conditions

    [C,B]=0,    [E,D]=0,    C A=A E.

Because A is invertible, E=A-inverse C A. Substitution reduces the necessary equations to

    [C,B]=0,    [A-inverse C A,D]=0.      (QND-2a)

These are homogeneous linear constraints in **25 complex variables** C_ij, all with rational coefficients. Independently reconstructed exact source spin swaps yield a 50×25 rational coefficient matrix M. The checker performs exact Fraction Gaussian elimination and obtains **rank(M)=24**. A separate explicit rank certificate is the 24×24 minor formed from coefficient columns 0..23 (row-major C_ij) and rows

    (0,1,2,3,4,5,6,7,8,9,10,11,13,14,15,16,17,18,19,21,25,26,27,28),

whose determinant is exactly

    det = -3519 / 65536 ≠ 0.

Hence rank≥24. The identity C=I_5 solves the homogeneous constraints, hence nullity≥1 and rank≤24; therefore the kernel is exactly span{I_5}. Consequently C=cI_5 and E=A-inverse C A=cI_5, so O=cI_10. The remaining bottom-left cross-block commutator is automatically zero for the scalar. QED.

**Interpretation:** Any nontrivial static conserved effect in the full source must have **cross-register components**, or use a different physical dynamical model/restriction/time-dependent protocol. Even *arbitrary* block-diagonal measurement effects beyond the three frozen families are excluded within this **specific class and this Hamiltonian**. This does NOT classify every conceivable POVM, adaptive measurement, environmental dilation, measurement-based control, or a source instrument that itself changes H.

**Decoupled control:** For lambda=0, P_UP commutes with the altered block-diagonal H_0. The no-go therefore depends materially on the actual declared nonzero register coupling.

## QND-3. A positive conserved observable exists: H itself

The source Hamiltonian satisfies [H,H]=0 and is **G_10-self-adjoint**. Its actual off-register block A is invertible, so H lies **outside** the excluded block-diagonal class. Thus there are nontrivial source-invariant mathematical observables (including functions of H). The ideal spectral energy projectors commute with H.

**Very important:** This is **not** an instrument-origin construction. The supplied frozen instruments do NOT include arbitrary spectral measurement of H. A projective energy measurement generally dephases arbitrary superpositions even though its outcomes are conserved for the postmeasurement system. Having a conserved quantity is not equivalent to being able to measure it without disturbing every input or preserving conscious continuation, consent and agency.

## QND-4. Even every stationary observable cannot encode all dynamic phase history

Let U(t)=exp(-iHt), and take any rho and shifted preparation rho_tau=U(tau) rho U(tau)†. For every stationary effect E with [E,H]=0,

    Tr[E rho_tau]=Tr[E rho].

This holds for the **entire** H-commutant, not just its energy projectors. However, a separate exact inherited CRF pair23 source witness has

    d/dt Tr[(I_reg⊗P_23,singlet) U(t)rho U†(t)]|_{t=0} = -3/8

for the original lambda=1. Hence the pair23 expectation differs between rho and rho_tau for small nonzero tau, while **all** stationary effects agree. This is an exact source-conditioned case where conserved snapshots alone fail to determine the dynamical time-phase relevant to later measurements. A system with an externally calibrated clock or an explicitly time-dependent readout may contain additional information; the theorem does not rule those out.

**Important distinction:** These are two different preparations along one lawful unitary orbit, not evidence of two different conscious particulars or a lost original. The proof concerns sufficiency of a static conserved-effect data record for modeling future *time-indexed* outcomes.

## QND-5. Next physical obligation; what X3 still lacks

What can be derived so far is a **negative criterion** for a restricted static readout class, a positive conserved mathematical quantity and a time-phase underdetermination. A real bridge requires:
1. A physically derived **autonomous system+apparatus Hamiltonian** and initial apparatus state, not arbitrary inserted Kraus effects; actual resulting POVM/instrument, energy/work/entropy accounting, timing and side effects.
2. A source-justified non-invasive or bounded-disturbance measurement protocol for its **specified admissible states**, including time-dependent/coherent options and open-system environmental corrections.
3. A proof that the information genuinely accessible to that instrument suffices for the physically relevant continuing carrier, including causal influences inaccessible from a matter-only marginal.
4. Independent physical-to-actual-conscious-particular semantics, original/copy/fork criteria, subject consent and legitimate future freedoms. Neither mathematical QND nor information completeness establishes this.

## Replay

    python3 evidence/physical-bridges/bcrd-register-source/check_source_qnd.py

Dependency-free exact Fraction checker; imports/replays the same committed source reconstruction and exact CRF causal-record witness; tests all supplied effects, arbitrary block-diagonal commutant, a nonzero rational 24×24 minor, conserved H and decoupled lambda=0 control. Analytic arguments explain how the exact rank proves the theorem; there is no claim to a new physical law, independent referee acceptance or any actual apparatus.

**Disposition:** QND-1 negative source effect tests; QND-2 exact finite-source commutant theorem with separately checkable determinant; QND-3 positive mathematical observable; QND-4 time-shift sufficiency countermodel; QND-5 physical and semantic obligations. **No canonical manuscript change, historical theorem narrowing or original X3 proof.**
