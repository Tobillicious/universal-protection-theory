# SRN-1–4: BCRD register-source invariance obstruction

**29 October 2026 NZDT · NON-CANONICAL · AUTHOR-SIDE RESEARCH · NOT FOR DEPOSIT**

## Source lock and noninterchangeable models

This exact source reconstruction concerns the **ten-dimensional** six-spin total-singlet + register model in physics-lane, **not** the distinct six-dimensional qutrit/relation-qubit exploratory model of earlier UPT PRs #156–#167. Neither model is established as a conscious subject or as complete physically verified BCRD.

Physics-lane source branch: sol/bcrd-instrument-origin-2026-09-09, head ee63d6115e4861a7291d706ee813b474f5f513b9.

- Predictive closure model, blob 671acc4c1f1cc0884e71655846a30b63e066d833: orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/predictive-closure/verify_history_effect_span.py
- Instrument verifier, blob eca41a5903ccdc8aea21619691df7d7a1ddd1f7e: orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/reduction-gluing/verify_instrument_origin_sol.py
- Original author-side result, blob e94374e64fab5c8d88df5e403a37ca508b7f92e0: orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/reduction-gluing/RESULT-INSTRUMENT-ORIGIN-SOL.md

**Independence and origin limits:** Original report records INDEPENDENT_ACCEPTANCE=NONE; the B1–B5 operational translation does NOT uniquely choose Lüders over Swap45 or the fixed mixture, and the frozen final-decision labels overlap. The physics-lane Hamiltonian, measurement effects and competing update maps are a declared process; not uniquely derived as physical law from BCRD. Original X3, H5, PNAJ, D115 and all canon remain unchanged.

## SRN-1. Exact source Hamiltonian obstruction

Let M be the five-dimensional total spin-zero sector of six spin-1/2 particles. In M define A=K12=S1·S2=(Swap12-I/2)/2. In the two-register UP/DOWN order S=C²⊗M, the source Hamiltonian is

    H_lambda = [[D+V, lambda*A], [lambda*A, D]],
    D=K12+K23; V=K34+K45+K56.
    P=diag(I5,0), Q=I10-P.

**Theorem:** For every lambda!=0, the register-UP subspace fails coherent invariance. Indeed QH_lambda P=lambda A has rank 5.

**Proof:** Swap12²=I and pair swaps preserve the singlet sector. Accordingly A satisfies the exact quadratic and inverse identities

    A²+(1/2)A-(3/16)I5=0,
    A^-1=(16/3)A+(8/3)I5.

The only eigenvalues are 1/4 and -3/4, both nonzero; therefore A is invertible and QHP has full rank for lambda!=0. No claim is made that leaving register-UP kills a conscious mind. □

## SRN-2. Original three measurement instruments cannot fix it at finite Poisson rate

For each supplied complete two-outcome family R (register up/down; pair12 singlet/triplet; pair23 singlet/triplet), all outcome projectors are block diagonal in UP/DOWN. U=I_register⊗Swap45 is block diagonal, physically Gram-unitary, and commutes with the frozen R outcomes. The candidate maps are

    J0_R(rho)=R rho R†
    J1_R(rho)=(U R) rho (U R)†
    Jhalf_R(rho)=1/2 J0_R(rho)+1/2 J1_R(rho).

Each two-outcome family is trace preserving when unselected outcomes are summed, and all Kraus operators are UP/DOWN block preserving. Thus Q L_j P=0 for their Kraus jump operators.

**Separate modelling assumption:** Suppose one of these supplied nonselective instrument families occurs at a finite Markovian Poisson rate gamma, with source H_lambda and no compensating Hamiltonian/feedback/bath. The weighted Kraus jumps satisfy sum L_j†L_j=gamma I, so the effective GKSL drift K_eff=-iH_lambda-(gamma/2)I obeys

    QK_eff P=-i lambda A != 0.

By the established GKSL invariant-subspace criterion (OSB-1), register-UP is not strictly invariant for ANY of these three update families when lambda!=0 and gamma is finite. A finite sum of complete block-preserving jump families likewise cannot cancel this cross-register Hamiltonian drift.

This does **not** establish that physical BCRD generates any one such Poisson monitoring process. Other dynamics, control, coherent feedback, changing the sector, and singular ideal limits are not excluded.

## SRN-3. Short-time source-leakage coefficient

For normalized UP input psi in the physical singlet subspace under H_lambda,

    p_DOWN(t) = lambda² t² ||A psi||² + O(t³),
    ||A psi||² >= 1/16 ||psi||².

Hence p_DOWN(t)/t² approaches a value >=lambda²/16 for nonzero lambda as t tends to 0. In the stated finite-rate block-preserving nonselective jump model the second-order coefficient is unchanged, because the jump maps do not directly transfer UP to DOWN or cancel the source cross-block drift. The result is a **short-time** obstruction to strict invariance—not a persistent all-time leakage bound nor proof of mind injury.

For lambda=0 this specific obstruction vanishes; lambda=0 is a different declared source parameter, not a physical repair to lambda=1.

## SRN-4. Verification and status

Run:

    python3 evidence/physical-bridges/bcrd-register-source/check_source_register.py

The self-contained exact Fraction checker reconstructs the 20-dimensional 3-UP and 15-dimensional 4-UP spin bases, five-dimensional singlet kernel of S_plus, pair swaps and Kij, singlet Gram matrix, physical Swap45 unitarity, restricted H_lambda, projectors and full-rank coupling. It is a fresh author-side **implementation**, not an independent reviewer acceptance.

**What remains:** a physically complete BCRD microscopic source and instrument derivation, genuinely safe/authorized interventions, independently validated original-particular continuation, full rights and ability to evolve, all external environmental channels and entrants, global founding/resources, and independent empirical physics validation.

**Disposition:** exact counterexample to *automatically* treating register-UP as a protected invariant; source-level conditional noninvariance under the stipulated Poisson instrument class. Not a universal X3 theorem or a new protection installation. Preserve original H5/PNAJ/D115, manuscript and published versions.
