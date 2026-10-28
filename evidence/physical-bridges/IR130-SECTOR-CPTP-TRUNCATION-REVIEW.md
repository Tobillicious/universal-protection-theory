# IR-130 — Sector-diagonal CPTP truncation models: exact detectability and fixed-point obstructions

**Research candidate · 28 October 2026 · not a proof of real subject truncation or maximal X3**

## Microscopic input

The previously archived finite BCRD model has the declared full-boundary operator algebra
B ≅ M₃(C) ⊕ M₃(C), acting on H = C³ ⊕ C³. Its six-dimensional Hilbert space contains two parity sectors. The 7 September 2026 full-boundary kernel study reports B'=C P₊⊕C P₋ and U(B')=U(1)×U(1). Those facts concern **invisibility to the entire declared B algebra for all states**, not a blanket statement about individual states or an independently validated physical boundary instrument.

We distinguish:

- A particular input ρ versus all inputs in the sector-diagonal state domain S.
- An operator ρ∈B versus a quantum channel Φ that maps density operators to density operators.
- A block-preserving CPTP map versus an actual causal intervention that truncates an authentic living subject.
- The full declared algebra B versus physically restricted/economically accessible boundary readouts.
- Existence of a distinguishing Hermitian observable versus guaranteed emission of a durable physical witness.

## Corrected theorem

**Theorem (fixed-input, full-sector operational detection).** Let ρ be a block-diagonal density matrix, and let Φ be any CPTP channel whose output Φ(ρ) is also block diagonal. If Φ(ρ)≠ρ, then a Hermitian O∈B satisfies

    Tr(O Φ(ρ)) - Tr(Oρ) ≠ 0.

**Proof.** Δ=Φ(ρ)-ρ is a nonzero Hermitian element of B. Choose O=Δ. Then the expectation difference equals Tr(Δ²)=||Δ||²_HS>0. QED.

The full-sector assumption is essential. If output states carry intersector coherences absent from B, their off-block components can be invisible to B even when the full density operators differ. No assertion of detectability is made for restricted boundary subsets of B.

**Uniform quantifier repair:** Nonidentity of Φ as a map (and nonmembership in a unitary phase kernel) is NOT sufficient for Φ(ρ)≠ρ for an arbitrary fixed ρ. Correct alternatives are:

- (input-specific) show Φ(ρ)≠ρ for the particular ρ; or
- (universal-on-class) show ∀ρ∈S_target, Φ(ρ)≠ρ; or
- (existential) show ∃ρ, Φ(ρ)≠ρ, which proves the map is experimentally distinguishable on at least one input.

The U(1)×U(1) phase kernel applies to **unitary conjugations** invisible on all B observables. It is not a classification of every fixed point of every CPTP channel. In particular a nonidentity decoherence map has fixed states.

Nor does mere non-zero positivity establish a **state-independent measurement gap**: sequences of arbitrarily weak channels approach identity, so a positive per-case ||Δ||_HS can tend to zero without uniform lower bounds.

## Exact sector-preserving examples

Work within each C³ block; take P=|0><0|+|1><1|=diag(1,1,0), Q=|2><2|. Put the same block construction on each sector, with separately specified strengths if desired.

**A. Pinching (hard *coherence* truncation).**

    K₀=P, K₁=Q;  Φ_pin(ρ)=PρP+QρQ.

K₀†K₀+K₁†K₁=I. Populations are unchanged, while coherences ρ₀₂ and ρ₁₂ vanish. The ρ₀₁ coherence survives. For EVERY diagonal ρ, Φ_pin(ρ)=ρ, including the sector maximally mixed state. This channel is NOT guaranteed to erase or terminate any microscopic degree of freedom, nor does it force the population on |2> to zero.

**B. Soft dephasing (the draft's diagonal Kraus pair).**

    D₀=diag(1,1,sqrt(1-γ)),
    D₁=sqrt(γ)|2><2|,  0≤γ≤1.

These satisfy ∑D†D=I. The population ρ₂₂ is exactly unchanged; coherences to |2> are multiplied by sqrt(1-γ). Thus this is NOT amplitude damping; it is partial dephasing relative to P/Q. Both channels A/B have diagonal fixed-point states.

**C. Actual intra-sector population transfer (amplitude damping).**

    A₀=diag(1,1,sqrt(1-γ)),
    A₁=sqrt(γ)|0><2|.

Again ∑A†A=I. For ρ=|2><2|,

    Φ_AD(ρ)=(1-γ)|2><2|+γ|0><0|,

so Δ=γ(|0><0|-|2><2|) and Tr(Δ²)=2γ²>0 for γ>0. The channel nevertheless fixes |0><0|. Even a genuine population-transfer channel is not detectable on every possible input.

To implement a sector-preserving channel globally, use the **direct sum of sectorwise effects** with a Kraus representation that is well typed and complete. A blockwise dephasing or amplitude damping may also destroy intersector coherence in the unphysical full H description; the declared state domain is block diagonal. Block-diagonal Kraus operators are a convenient sufficient choice for no intersector transfer but are NOT a derivation from BCRD physical admissibility. Note that block-preserving states without sector-weight conservation can also arise from channels whose Kraus operators are not block diagonal.

**D. Coherent input demonstration.** In one sector take the pure input

    |ψ>=(|0>+|2>)/sqrt(2),  ρ=|ψ><ψ|.

For pinching, Δ has offdiagonal entries -1/2, so Tr(Δ²)=1/2.
For soft dephasing, Δ₀₂=Δ₂₀=(sqrt(1-γ)-1)/2, giving
Tr(Δ²)=(1-sqrt(1-γ))²/2.
For γ=16/25 this is 2/25. For amplitude damping at γ=16/25,
the |2> population transfers into |0> and a different Δ results.

## Finite-dimensional algebraic formalisation (Lean source)

IR130SectorInputDetectability.lean encodes the **18 real coordinates** of block-Hermitian operators over an exact integer coordinate lattice: six diagonal parameters and six upper-triangular complex coherences (each real and imaginary, total 12). It proves by extensionality that the 18 readout coordinates jointly separate every pair of distinct operators; it then derives the correct fixed-input theorem.

The Lean model does NOT itself implement complex matrices, continuous normalised density states or a CPTP certificate. Those require independent matrix-theoretic validation. The channel examples above supply actual Kraus representations and simple completeness checks at the mathematical level; the exact rational finite verifier can check representative test cases.

The same Lean module shows a projective pinching map is nonidentity while fixing every diagonal input. That counterexample rules out the proposed unqualified “nontrivial channel implies Δ≠0 for all ρ” step. A choice of 18 coordinates as readouts is only as physically strong as the justified operational availability of the corresponding Hermitian observables.

## Why this still does not prove X3

Even detecting a real state change does not identify it as a **subject's structural truncation**. A subject semantic adapter must establish which microscopic patterns constitute the same continued subject, which operations alter its future agency, and which changes are authorized.

Detectability does NOT imply prevention: IR-127's typed rejection relation, IR-121's physically budgeted effects, the IR-129 conditional observable test and a valid physical mediation certificate are separate. Without a runtime substrate-level lock (or proven forbidden transition operator), an adversary may produce a detectable event after harm has occurred.

The active mathematical targets are:
(1) classify genuinely admissible microscopic subject-structure maps (not all generic CPTP maps);
(2) prove their action changes the chosen state's block-diagonal operational equivalence class;
(3) obtain a calibrated minimum detectable margin or explicit time/resource bounds when needed;
(4) derive actual boundary sensor access and irreversible authenticated witness retention;
(5) close physical bypasses and prove an enforced authorization relation;
(6) separately preserve nonblocking, noncoercive **branching** futures rather than a single deterministic orbit.

## Independent progress warning

For a deterministic generator φ:X→X, injective equivariance eφ=ψe preserves the cardinality of finite orbits and nonfixed motion. It does NOT prove open branching: a deterministic generator has only one immediate successor from each state, and a two-state oscillator cycles forever without a choice. A genuine future-capability theorem requires an action-labelled transition relation and **backed-by-physical-service** enabled choices; temporal non-starvation/fairness is stronger still.

**Verdict:** The corrected algebraic theorem is provable, valuable and genuinely falsifiable in finite models. The draft's stronger universal detectability and subject-preservation conclusions do not follow without independent state-specific and physical-semantic premises.
