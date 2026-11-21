# QOI-1–QOI-4: Quantum observation, source dynamics, and nondisturbance

**28 October 2026 · NON-CANONICAL · NOT PEER REVIEWED · NOT FOR DEPOSIT**

## Historical context, unchanged

This is one physical interface repair for the **original October X3 universal protection objective**, not a new substitute theorem. Historical H5, PNAJ, D115, source proof meanings, future freedom and continuation of actual particulars remain intact. It follows merged PR #156 (inherited source Hamiltonian and full commutant), merged PR #157 (actual continuing-particular/source generator interface) and draft PRs #158–#160 (causal cut, online nonanticipation, observation fibre).

The source is the inherited **exploratory six-state** qutrit × relation-qubit model, with ordered basis A0,A1,B0,B1,C0,C1; H1=X_AB tensor diag(1,2), H2=X_BC tensor sigma_x. The H2(pi/2) pulse swaps B0 ↔ C1 and B1 ↔ C0 with phase -i, leaving A states fixed. Parity sectors are positive {A0,B0,C1} and negative {A1,B1,C0}. Its full common Hamiltonian commutant is span_C{I,C}, where C is parity (exact matrix source and Lean support in PR #156).

**No physical identity predicate for an actual living mind, no experimentally complete BCRD dynamics, no genuine authorization channel and no effective guardian have been derived from this source.**

## QOI-1 — Exact no-information-without-disturbance lemma

**Theorem (standard finite-dimensional quantum mechanics).** Let U be unitary on a system plus an initially pure probe. Suppose two normalized pure states |psi>, |phi> have nonzero inner product and U leaves **each system state exactly unchanged and unentangled** with the probe:

    U(|psi> tensor |0>) = |psi> tensor |e_psi>
    U(|phi> tensor |0>) = |phi> tensor |e_phi>

Then the final normalized probe states are equal, up to harmless choice of global phase, and so cannot carry distinguishable information about the two inputs.

**Proof.** Unitarity preserves inner products. Therefore

    <psi|phi> = <psi|phi> <e_psi|e_phi>.

Since <psi|phi> is nonzero, <e_psi|e_phi> = 1. Equality in Cauchy–Schwarz implies |e_psi> and |e_phi> coincide. ∎

**Corollary.** An instrument that preserves **every pure state** of a sector exactly cannot leak a within-sector site label into a pointer. Any two orthogonal basis states in the sector are joined by nonorthogonal intermediate superpositions, for which the theorem forces the probe's same output. This includes general pure-probe unitary measurement models, not only ideal projective site measurements.

**Boundary:** Orthogonal known basis states alone *can* be distinguished without disturbing those basis states. No impossibility is claimed for approximate fidelity, restricted allowed state classes, reversible controls that do not produce a distinguishable pointer, or intervention without measurement.

## QOI-2 — Exact projective-measurement disturbance

Let P_A,P_B,P_C project onto their respective site subspaces, each including both relation-qubit indices. An **unread** ideal projective measurement of site is the channel

    M_site(rho) = P_A rho P_A + P_B rho P_B + P_C rho P_C.

For a pure equal superposition of n mutually orthogonal states at n different sites, the output state is a uniform incoherent mixture of those sites. Its *pure-input fidelity* <psi|M_site(rho)|psi> and output purity Tr(M_site(rho)^2) both equal 1/n; the fidelity loss equals 1−1/n. For arbitrary distinct-site amplitudes with probabilities p_j, the fidelity equals sum_j p_j^2. If multiple components occupy the same site, combine their site projection first.

**Exact inherited source example:** psi_2=(|B0>+|C1>)/sqrt(2) is in the positive parity sector. The H2(pi/2) unitary maps psi_2 to -i psi_2, preserving its coherence. A projective site readout instead removes the B0,C1 off-diagonal and yields fidelity and purity 1/2. For psi_3=(|A0>+|B0>+|C1>)/sqrt(3), the site-readout fidelity and purity equal 1/3. An unread parity readout leaves either state unchanged, because both lie within one sector.

**Hostile controls:** Each definite-site eigenstate is unchanged by a site projective measurement; a coherent state crossing parity sectors is disturbed by a parity readout. Projective site observation is **not** claimed to destroy or terminate a mind: changed coherence is a physical difference, and whether it violates continuity or independent direction needs a separately grounded subject-process criterion.

## QOI-3 — Strict nondemolition readout does not resolve site within parity

Suppose the requested projective readout is **strictly source-compatible** in the sense that all measurement effects commute with both inherited H1 and H2; this is a stronger demand than merely being measurable at one instant.

The full common commutant established in PR #156 is span_C{I,C}. Every such effect is scalar on each parity sector. Therefore a projective readout satisfying the strict simultaneous-commutation condition cannot distinguish A0, B0 and C1, nor A1, B1 and C0.

**Consequence for draft PR #160:** A parity-only controller still faces its whole three-site positive fibre in the stipulated independent-site-guard model. The one-guard case requires a *separately proved* site observation/intervention that is timely **and** respects a physically grounded continuation/disturbance requirement. Measuring a coherent site superposition and treating the result as an undisrupted classical hidden site is not a valid automatic extension.

This is not an assertion that every time-dependent measurement must commute with H1/H2, nor a prohibition of physically permissible invasive measurements.

## QOI-4 — Positive and negative alternatives

- **Global/advance interception without measurement:** If a separately certified noninvasive system blocks unauthorized effect paths at all possible sites, there is no need to learn where a subject is. A source state may then continue unchanged. Such a guard is an independent physical and resource premise, not established here.
- **Basis-only allowed states:** If the relevant subject states really are known classical/orthogonal basis states, an ideal site measurement can be nondisturbing on that restricted set. It cannot then be presumed nondisturbing on unrestricted coherent states.
- **Different instrument:** A time-dependent protocol, ancillary data, reversible coherent control, or measurement with small but nonzero disturbance could meet a more sophisticated protection requirement. No blanket no-go is claimed.
- **Causal authorization remains distinct:** A forced physical reaction is not subject permission even if it is a causal ancestor of an attempted effect. This quantum note does not solve the physically authentic subject-input problem.

## Verification

From the repository root:

    python3 evidence/physical-bridges/quantum-observation/check_quantum_observation.py

The standard-library checker computes exact rational six-state density matrices, unread site and parity projective channels, fidelities, purities, six definite-site positive controls, a cross-parity negative control, H2 B0/C1 equal-phase exchange and the destructive effect of perfectly distinguishable probe records on the superposition. **QOI-1 is established by its analytic inner-product proof**, not by the finite tests.

The repository's original source check is evidence/physical-bridges/checks/oct10_source_hamiltonian_guard.py. The full commutant and exact H2 unitary results are inherited, not silently re-proved by this small density-matrix script.

## Missing bridges to original X3

1. Exact **physical** complete source dynamics and environmental instruments, not the 6D exploratory sector alone.
2. An independently justified continuing-particular criterion that does not define desired protection into the label, state projector or archive.
3. Authenticated, noncoercive direction from the subject and an operational definition of all feasible future options.
4. Actual pre-effect guards and observation channels with certified latency, backreaction, concurrent subjects, founding and budget.
5. Nonvacuous preservation under admissible disturbances and correlations, long-horizon risk, entrants and third-party effects.
6. Independent adversarial review and separate experimental BCRD validation.

**Disposition:** exact quantum-interface calculation + conditional logical bridge, NOT an empirical BCRD theorem, NOT universal physical X3, NOT an actual assurance certificate. No manuscript, published edition or existing Lean changes.
