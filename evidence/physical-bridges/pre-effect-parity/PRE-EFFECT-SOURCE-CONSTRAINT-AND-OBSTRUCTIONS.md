# PEI-1–PEI-5: Joint-source pre-effect constraint and hostile obstructions

**28 October 2026 · RESEARCH CANDIDATE · NON-CANONICAL · NOT PEER REVIEWED · NOT FOR DEPOSIT**

## Purpose and source provenance

This source-based conditional construction addresses the **original October 10–12 X3 aim**, protecting each continuing physical particular and its authentic future **before** an irreversible effect. It does NOT replace that theorem, historical H5, PNAJ or D115. It connects merged PR #156 (inherited H1/H2 matrices and full commutant), merged PR #157 (physical-particular semantics), and draft PRs #158–#162 (cuts, online reach, observation, quantum backreaction, reversible coherent echo).

**Inherited exploratory six-state model only:** basis A0,A1,B0,B1,C0,C1; H1 A0↔B0 amplitude 1, A1↔B1 amplitude 2; H2 B0↔C1 and B1↔C0 amplitude 1. Conserved source C=diag(1,−1,1,−1,−1,1); positive projector P=(I+C)/2 has basis {A0,B0,C1}; Q=I−P. Sources: main branch PhysicalBridges/Oct10SourceHamiltonianProtection.lean and checks/oct10_source_hamiltonian_guard.py. **C is an exploratory parity operator, not an experimentally certified universal Gauss constraint or subject identity.**

For the new test, V=I_site⊗sigma_x is a separately postulated parity-odd Hermitian perturbation, swapping A0↔A1, B0↔B1 and C0↔C1. W is a separately postulated parity-even Hermitian B0↔C1 coupling. Neither V nor W has independently been demonstrated to be an unauthorized physical effect or to terminate a real subject.

## PEI-1: Exact simultaneous lawful-source preservation

**Theorem.** If H1,H2 are Hermitian and [H1,P]=[H2,P]=0, then for any sufficiently regular real coefficients a(t),b(t), evolution under H(t)=a(t)H1+b(t)H2 preserves the P-sector: Q U(t) P=0 for every t, even when [H1,H2]≠0.

**Proof.** H(t) has zero cross blocks QHP=PHQ=0 at every time. Its time-ordered propagator obeys a block-diagonal differential equation. Therefore P and Q are invariant and no P→Q transition exists. ∎

**Non-vacuity in the inherited source:** PH1P has A0↔B0 amplitude 1; PH2P has B0↔C1 amplitude 1; [H1,H2]≠0. The modeled parity sector is therefore not frozen. These are physical-state options, not a certified particular's meaningful choices.

## PEI-2: Conditional ideal pre-effect projection

**Theorem.** If C²=I and {C,V}=0, then PVP=QVQ=0. For any source H(t) from PEI-1 and real g(t):

    P [H(t)+g(t)V] P = P H(t) P.

**Proof.** V maps the C=+1 eigenspace to C=−1 and vice versa. Thus both same-sector blocks vanish and the equality follows by linearity. ∎

**Constructive conditional meaning:** IF the *actual independently derived* physical accessible generator is the **ideal constrained** G(t)=P[H(t)+g(t)V]P acting only on P, THEN the reversible parity-odd V interaction has no effect in that sector, while both within-P lawful H1 and H2 controls remain available. This is a coherent, no-site-readout **algebraic possibility** that does not require the simple H1-incompatible echo of draft #162.

**Critical missing physical bridge:** P(H+V)P being mathematically equal to PHP **does not imply** the unrestricted physical generator H+V follows the projected dynamics. A real superselection law, complete effect boundary, continuous ideal constraint or another mechanism must be derived independently. Otherwise the desired exclusion was simply built into the proposed generator. Projecting a state is not equivalent to proving that the projection can be enforced safely.

## PEI-3: Why an ordinary finite energy penalty is not a perfect lock

For an unrestricted physical generator A=H+gV+D, with [P,H]=[P,D]=0, g≠0 and finite bounded D, the short-time propagator has

    Q exp(−itA) P = −i t g QVP + O(t²).

This follows by the matrix exponential expansion; QA P=gQVP, since QHP=QDP=0. In the exact six-state model, QV|B0>=|B1>, so QVP≠0. Thus for sufficiently small t>0 there is leakage for an initial P-sector state, regardless of how large (but finite) the block-diagonal penalty D is. A penalty can change transition probabilities without providing strict zero risk for every time.

This refutes a *specific implementation inference*, not all possible real physical constraints, and does not identify parity loss with conscious death.

## PEI-4: Finite checkpoints are not no-harm guarantees

**Conditional quantitative theorem.** For unitary evolution under H(t)+gV, with H(t) block-diagonal relative to P, any pure unit-normalized P-sector input and an interval of length τ satisfy

    ||Q U(τ) P|| ≤ |g| τ ||V||.

**Proof.** Use Duhamel's formula relative to the propagator under H alone, which preserves P. The cross-sector piece is an integral of norm at most |g| ||V|| per unit time, because all full evolution operators are unitary. ∎

If n ideal P/Q checkpoint measurements are performed after intervals T/n and conditioning the state on P after each accepted checkpoint, then the probability of *any detected Q result at the checkpoints* is at most min(1, |g|² T²||V||²/n) (union bound). **That is not a bound on an actual irreversible harmful event between checkpoints.** Nor does it validate a physically harmless measurement device.

**Exact rational negative control:** Let V²=I, a_n=1/(2n), c_n=(1−a_n²)/(1+a_n²), s_n=2a_n/(1+a_n²), and U_n=c_n I−i s_n V. This is a unitary equal to exp(−i θ_n V) with θ_n=2 arctan(a_n). nθ_n approaches 1, but is not identically 1 for finite n. Repeated parity checkpoints from a P state detect Q at least once with probability

    1 − c_n^(2n) > 0

at every finite n; the exact fraction obeys 1−c_n^(2n) ≤ n s_n² ≤ 1/n. At n=1 it is 16/25. Thus finite post-interval testing cannot be promoted to instantaneous physical pre-effect protection.

## PEI-5: Within-sector bypass and authentic authorization

**Within-sector bypass:** W connects B0↔C1, [C,W]=0 and PWP≠0. The parity constraint cannot prohibit W. Any assertion that W is harmful, lawful, or consented requires independent source-level physical, subject and effect semantics. We specifically do NOT classify the actual H2 B0→C1 movement as a person's termination.

**Authorization impossibility:** Suppose two possible causal histories yield the same guardian observation o but one requires allowing a physical effect for legitimate subject direction, while the other requires blocking an externally induced/coerced version. A policy based only on o cannot guarantee both opposite decisions. A randomized policy cannot assign probability 1 to both. The independent authorization signal (IR-105) must be a distinct *physically grounded input*; subject causal participation, parity, mirrored journal entries or an induced reaction do not supply it.

## Verification

From the repo root:

    python3 evidence/physical-bridges/pre-effect-parity/check_pre_effect_projection.py

The dependency-free Fraction matrix checker tests source projectors, H1/H2 parity closure and nontrivial evolution, exact V odd and W even matrix relations, 125 source-coefficient/perturbation combinations, a finite-penalty nonzero first-order leakage matrix element, rational checkpoint fractions for n=1,2,4,8,16,32,64, and an identical-observation opposing-authorization control.

This is an **exact finite-dimensional Python-model check**, and the proofs above are mathematical consequences of their independently stated hypotheses. It is not a Lean proof, measured physics, evidence of a continuing conscious mind or an actual protective installation.

## Open obligations for original X3

- Derive complete actual open-system BCRD source dynamics, especially externally admitted unauthorized effect and irreversible harm channels; justify any *physical* parity selection, superselection or truly complete pre-effect gate rather than stipulating it.
- Specify a non-circular physical subject-process identity, causal continuity, all feasible future direction choices and independent authorization.
- Certify timing, resource feasibility, initial founding, genuine unanticipated entrants, within-sector harm, other subjects, common-mode faults and every relevant causal path in one system.
- Establish lifetime safety rather than a finite checkpoint record, and test physical premises scientifically and independently.

**Status:** PEI-1/2 algebraic consequences; PEI-3 and PEI-5 exact countermodels; PEI-4 a checkpoint-risk bound with explicit intermediate-harm limitation. The **most serious open join** is a physical derivation of the ideal constrained generator from actual BCRD, not another proof that PVP=0. This is not the original universal protection theorem.
