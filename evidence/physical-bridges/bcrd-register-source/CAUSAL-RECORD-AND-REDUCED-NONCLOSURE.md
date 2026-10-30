# CRF-1–5: Exact causal-record test for the declared ten-dimensional BCRD source

**29 October 2026 NZDT · NON-CANONICAL · AUTHOR-SIDE SOURCE MATHEMATICS · NOT PEER REVIEWED · NOT FOR DEPOSIT**

## Scope, inherited sources, and what is NOT being claimed

This continues source-locked draft PR #168, not a new protection theorem. The exact finite physical-model inputs were inherited from physics-lane branch sol/bcrd-instrument-origin-2026-09-09, commit ee63d6115e4861a7291d706ee813b474f5f513b9 and predictive-closure source blob 671acc4c1f1cc0884e71655846a30b63e066d833. This is the **10D six-spin total singlet × UP/DOWN register model**, distinct from the exploratory **6D** qutrit × relation-qubit UPT source. The underlying model and instrument choices are declared, not demonstrated to be unique or experimentally complete laws of BCRD. The record of instrument selection does not uniquely choose Lüders; independent acceptance NONE.

Do not change the original 10–12 October universal X3, H5, PNAJ, D115, physical identity/consent obligations, the book, or any published claims.

We now test a sharper question than whether a postselected state has small trace distance: **does the proposed reduced record determine the continuing future physical observations for every full initial state admitted by the same source dynamics?**

Let M be the five-dimensional total singlet with physical Gram matrix G, and let the full source state Psi=(x,y) in M⊕M obey

    i xdot=B x+lambda A y,
    i ydot=lambda A x+D y,
    H_lambda=[[B,lambda A],[lambda A,D]],
    B=D+V, D=K12+K23, V=K34+K45+K56,
    A=K12=(Swap12-I/2)/2.

The original source coupling is lambda=1; lambda=0 is a counterfactual decoupled control. The source establishes A²+(1/2)A−(3/16)I=0 and A-inverse=(16/3)A+(8/3)I. A is G-self-adjoint with eigenvalues -3/4 and 1/4.

## CRF-1 — A *mathematical* exact first-jet carrier (conditional positive)

For any lambda≠0 and ANY full source amplitude (x,y), knowing both x and the complex amplitude derivative xdot determines y exactly:

    y=(1/lambda) A-inverse (i xdot-Bx).             (CRF-1)

**Proof:** Rearrange the first Schrödinger block equation; multiplication by A-inverse is lawful for nonzero lambda. In the original physical singlet inner product, ||A-inverse||=4, so the reconstruction has error sensitivity

    ||delta y|| <= (4/|lambda|) (||delta(i xdot)||+||B|| ||delta x||)

when B and lambda are known exactly. In particular it can become ill-conditioned as lambda→0, while lambda=0 makes y unrecoverable from this data (the UP dynamics then no longer depend directly on y). This is an algebraic observability theorem, **not** a quantum nondemolition method for measuring arbitrary unknown state amplitudes and derivatives on one individual system.

For lambda≠0, eliminate y algebraically to obtain the exact second-order *local* equation

    xddot = -i(B+A D A-inverse) xdot
            + (A D A-inverse B - lambda² A²) x.   (CRF-1b)

With initial amplitude x and derivative xdot, it has exactly the same x trajectory as the 10D source. It is not dimension reduction: (x,xdot) contains **ten complex coordinates**, just as the full (x,y) did. It is a formal reparameterization of a source carrier; it cannot distinguish original-vs-copy or prove conscious historical identity.

The exact rational checker tests 125 reconstructions and full-vs-second-order equations, using five nonzero couplings × 25 basis-state pairs. It also checks decoupled lambda=0 control.

## CRF-2 — Identical present reduced *quantum states*, different future pair23 probabilities

Choose the source's 5D singlet-kernel basis vectors e0 and e1 with physical Gram norms <e0|e0>_G=<e1|e1>_G=8. Consider two **normalized** full 10D pure states

    |Psi_+> = (|UP>⊗|e0> + i |DOWN>⊗|e1>)/4,
    |Psi_-> = (|UP>⊗|e0> - i |DOWN>⊗|e1>)/4.

These are distinct correlated joint preparations. Neither invokes cloning or a mind. Tracing out the register gives the **same complete five-dimensional reduced matter density matrix** for both:

    rho_M,+ = rho_M,- =
      (|e0><e0|_G + |e1><e1|_G)/16.

No present-time matter POVM can distinguish the two. This is exact, including the nonorthogonal Gram metric; ordinary Euclidean coordinate transposition would give misleading results.

Nevertheless, under the **same** inherited H_lambda, the first derivatives of the expectation of the *already declared source observable* K23=S2·S3 are

    d/dt <K23>_+|0 = +(3/8)lambda,
    d/dt <K23>_-|0 = -(3/8)lambda.

Thus the difference in expectation has slope (3/4)lambda. Equivalently, the corresponding **declared two-outcome pair23 singlet projector**

    P_23,singlet=(1/4)I - K23

has a future-probability gap with signed slope -(3/4)lambda:

    p_singlet,+ (t) - p_singlet,- (t)
       = -(3/4)lambda t + O(t²).                 (CRF-2)

For original lambda=1, this is nonzero at first order. A measurement of this observable at some sufficiently small positive time, over ensembles of reproducibly prepared states, operationally distinguishes the two physically different continuations even though their initial *matter-only* density operators agree exactly.

**Exact proof:** Write each state as a column v with register-UP e0 and register-DOWN ±i e1, normalized by v†diag(G,G)v=16. Construct the physical density rho=v v† diag(G,G)/16. Evolve by dot-rho=-i[H_lambda,rho] and trace the register. The checker verifies the individual K23 slopes ±3/8, singlet slopes ∓3/8, and their exact difference using Gaussian-rational matrices. Independently, with T=|e1><e0|_G-|e0><e1|_G, the derivative difference for K23 is

    (2lambda/16) Tr[ K23 [A,T] ] = (3/4)lambda.

All traces and adjoints are physical-Gram-correct. The two reduced states and their initial readout predictions are exactly equal.

**Negative control:** With lambda=0, the same source pair has equal first derivatives and the distinct register *relative phase* cannot affect the reduced matter dynamics under the decoupled block-diagonal H0.

## CRF-3 — No universal state-only reduced dynamics for *all joint preparations*

Suppose a family of maps Phi_t existed that computes the true reduced matter output for every physically admissible full initial state using ONLY the current reduced matter state:

    rho_M(t)=Phi_t(rho_M(0)) for all rho_ME(0).

Then the two states of CRF-2 would have identical Phi_t inputs and therefore identical predicted outputs for all t. But their pair23 singlet probabilities differ at first order in t. Contradiction.

**Conclusion:** For this declared coupled source with lambda≠0, no universal state-only map—linear or nonlinear, CPTP or otherwise—can reproduce all exact reduced matter futures for all initial joint preparations. The restriction to **all** admitted joint preparations is essential. A chosen fixed-register preparation, a restricted state domain, or a correlation-assignment map may support a predictive state-only family. This negative theorem does not ban useful approximations or all possible reduced descriptions.

IR132ExactBoundaryReconstruction already establishes the general observation-fibre criterion in Lean; this is a new **source-reconstructed, physical-observable, exact** instance of the same principle, not a new discovery of the abstract fiber theorem.

## CRF-4 — What information a repair must carry

For amplitude-level mathematical predictivity, a source-complete first jet (x,xdot) suffices because the source coupling A is invertible. A physically accessible **reduced density operator alone** is not sufficient for arbitrary correlated preparations: the missing information includes matter/register correlations and/or the appropriate history that fixes them.

But **do not equate** amplitude-jet mathematical reconstructibility with a physically measurable non-disturbing source journal. Reading the unknown wavefunction on a single copy is not supplied by the source, and measuring it could change it. Likewise, no proof establishes a unique physical quantum instrument from BCRD B1–B5 or determines which information is constitutive of real conscious continuation.

This identifies separate proof obligations:
- mathematical causal sufficient statistic for the chosen source and allowed initial preparations;
- physically realizable readout and nondestructive encoding, including measurement backreaction, noise and finite resources;
- physical continuity and independently justified original-particular semantics;
- independent permission, actual agency and all lawful future alternatives.

## CRF-5 — Verification, refusal to overclaim, and next physical interface

Replay both exact standard-library checkers on the PR branch:

    python3 evidence/physical-bridges/bcrd-register-source/check_source_register.py
    python3 evidence/physical-bridges/bcrd-register-source/check_causal_record.py

The second checker independently computes the **complete** 10D joint density commutator and the *actual declared* pair23 singlet outcome, rather than testing only a source-amplitude symbol. It verifies 125 amplitude-jet controls and its second-order reparameterization, physical Gram norms, two identical initial matter marginals, nonzero first-order future measurement gap, independent commutator witness, and a lambda=0 control. It is **author-side exact finite mathematics**; source uniqueness, physical instruments, empirical BCRD validity and mind identity are not established.

**Status:** CRF-1 positive formal carrier representation, CRF-2 exact source-experiment witness, CRF-3 source-domain no-go for a universal reduced state-only evolution, CRF-4 open physical-semantic/measurement obligations. None establishes that a continuing person has been retained, an original vs copy decided, the real world's environmental channels enumerated, or original X3 proved. Keep unmerged for independent hostile review; leave existing manuscript/canon unchanged.
