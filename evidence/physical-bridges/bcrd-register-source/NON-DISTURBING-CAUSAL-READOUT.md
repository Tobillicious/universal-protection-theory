# NDR-1–5: Nondisturbing causal readout and exact source exceptions

**29 October 2026 NZDT · NON-CANONICAL AUTHOR-SIDE MATHEMATICS · NOT INDEPENDENTLY ACCEPTED · NOT FOR DEPOSIT**

## Provenance and relationship to prior results

This is a continuation of draft PR #168 on the **ten-dimensional six-spin total-singlet × UP/DOWN register** declared by physics-lane, branch sol/bcrd-instrument-origin-2026-09-09, commit ee63d6115e4861a7291d706ee813b474f5f513b9, source blob 671acc4c1f1cc0884e71655846a30b63e066d833. It is distinct from the **6D** UPT qutrit × relation-qubit source in earlier draft #161. The origin's exact instrument audit says independent acceptance NONE and B1–B5 do not uniquely select Lüders, Swap45 or the mixture.

The quantum **no-information-without-disturbance theorem is established**, not novel. What is new here is a physical-source-locked pair, the actual declared future pair23 observable, and a necessary counterexample against an overbroad no-readout claim. No empirical BCRD, consciousness, identity or original universal X3 follows. Preserve historical H5/PNAJ/D115 and manuscripts unchanged.

## NDR-1 — Same current matter state and nonorthogonal source states with different futures

Let e0,e1 be two singlet-kernel basis vectors, each with squared physical Gram norm 8. For |z|=1, define the normalized source states

    |Psi_z>=(|UP,e0>+z|DOWN,e1>)/4.

Because of register orthogonality, their inner products and matter marginal are

    <Psi_z|Psi_w>=(1+conj(z)w)/2,
    rho_M,z=(|e0><e0|_G+|e1><e1|_G)/16.

For **z=1 versus z=i**, the full states are **nonorthogonal** with overlap (1+i)/2 (squared magnitude 1/2), but the entire matter-only density matrix is identical. Under the *same inherited coupled* H_lambda, at original lambda=1, the actual supplied pair23-singlet probability derivatives are

    d p_1 / dt at 0 = 0,
    d p_i / dt at 0 = -3/8,

so p_1(t)-p_i(t)=(3/8)t+O(t²). The exact Gaussian-rational checker derives this using the physical **nonorthogonal singlet Gram matrix** and full 10D density commutators. With *altered* lambda=0 these derivatives coincide. No conscious particular is assumed.

## NDR-2 — Perfect one-shot preservation implies identical readout on nonorthogonal inputs

**Established quantum theorem, proven here:** Let |psi0>,|psi1> be normalized, c=<psi0|psi1>≠0. Suppose a quantum instrument, including ancillas/unobserved environment, leaves the **whole joint input pure state** exactly unchanged (nonselectively) for each input. A Stinespring isometry W maps |psi_j>|0> to |psi_j>|a_j>: since the system marginal remains pure, the joint output factorizes. Inner-product preservation gives

    c = c<a0|a1>.

Since c≠0, <a0|a1>=1. By equality of normalized vectors, |a0>=|a1>. Thus no apparatus output record, however postprocessed, carries distinguishing information about these inputs. QED.

This bars extracting their differing hidden correlations **perfectly and without whole-state disturbance in a single run**. It does NOT forbid approximate/invasive measurements, repeated-ensemble tomography, restricted orthogonal measurements, or readings of conserved quantities whose source states have differentiable orthogonal eigenvalue sectors.

The exact checker verifies that the inherited pair has c=(1+i)/2≠0 and tests the scalar requirement c=c alpha against several Gaussian-rational candidate pointer overlaps. The *general* result follows from the isometry argument, not from finitely sampled overlaps.

## NDR-3 — Essential positive exception: orthogonal correlated source inputs

The prior CRF-2 witness used **z=i and z=-i**. These pure joint states are actually **orthogonal**, though their matter marginals still agree. An ideal global three-outcome projection

    P_i=|Psi_i><Psi_i|_G,  P_-i=|Psi_-i><Psi_-i|_G,
    P_other=I-P_i-P_-i

distinguishes exactly this promised pair and leaves either promised input unchanged at the measurement time. The exact checker independently verifies P_i²=P_i, P_-i²=P_-i, P_i P_-i=0, and their actions on |Psi_±i> in the physical Gram representation.

Therefore a categorical claim that *all* hidden correlations cannot be observed nondestructively is false. BUT such a global projector is **not shown to be among the independently physically available instruments**; the source B1–B5 does not uniquely select real hardware. Moreover the exact checker shows [H_lambda,P_i]≠0 at lambda=1, so the proposed projection is **not quantum-nondemolition under ongoing unmodified source evolution**. On arbitrary superpositions, it is generally disturbing. The nondisturbance here is only at one instant for that restricted promised set.

## NDR-4 — Do not conflate three access claims

1. **Ensemble history tomography:** The prior physics-lane author-side study reports 100-dimensional history-effect span for supplied instrument families. This concerns statistical discrimination across *repeatable preparations and trials* in a frozen model, not exact nondisturbing one-run extraction from a unique ongoing source.
2. **Single-run whole-state preservation:** NDR-2 rules out a distinguishing apparatus record for the explicit nonorthogonal full source pair if both must be preserved exactly.
3. **Restricted QND measurement:** Certain orthogonal promised inputs admit exact projective information without initial disturbance, but engineering, timing, source Hamiltonian commutation, and impact on possible lawful alternatives are separate matters.

The exact source CRF-1 algebraic amplitude-jet identity y=lambda^-1 A^-1(i xdot-Bx) does **not** manufacture an apparatus that reads an arbitrary unknown wavefunction and time derivative from one system. If source lifetime preservation requires a nondisturbing physical journal, this limitation must be confronted rather than redefined away.

## NDR-5 — What a genuine physical-to-X3 bridge still needs

A candidate physical causal-record instrument must identify its **admissible input states**, which historical/causal distinctions matter, a justified actual physical interaction and measurement readout, quantified disturbance/latency/errors, and whether it preserves the *constitutive ongoing particular* and its noncoerced lawful freedom. It must distinguish predicting a process from the process's historical identity. Existing BCRD source selection, physical completeness, original/copy distinctions, all-minds scope, real subject consent and global installation remain OPEN.

### Exact checker

Run on the PR branch:

    python3 evidence/physical-bridges/bcrd-register-source/check_nondisturbing_readout.py

The standard-library checker runs the already committed source and causal-record reconstructions and checks source pure state overlaps, same matter marginal, future supplied pair23 statistics, decoupled control, exact Gram-correct orthogonal projectors and their failure to commute with the source. Its mathematical computations are exact; neither the instrument’s physical installation nor the identity semantics are derived by the checker.

**Disposition:** useful theorem-level constraint and orthogonal exception to any proposed nondisturbing causal-memory interface. No claim of empirical or universal physical protection, conscious identity, actual instrument selection or original X3 proof. Keep original H5/PNAJ/D115, prior canon and published work untouched.
