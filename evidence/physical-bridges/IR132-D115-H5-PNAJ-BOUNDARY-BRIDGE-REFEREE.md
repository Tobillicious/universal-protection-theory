# IR-132 — D115/H5/PNAJ and bulk-to-boundary reconstruction: provenance-first hostile referee

**Working mathematical review · 28 October 2026 · original maximal X3 preserved · no physical closure claim**

## I. Source lineage and naming collision

The new 28 October candidate labels “D115” as **Boundary-Complete Relational Trace Closure**, and joins it to “H5” entropy-creating generative incompleteness, PNAJ and a unique bulk-to-boundary bridge. Earlier Snuffy D115 material (the *Another Origin* / information-capacity route) used D115 for **identical statistics but unequal task-relevant informational access**, illustrated by fair bits/XOR, and D116 for a limited-information recovery/channel gap. The candidate boundary closure is therefore NOT to overwrite D115 or be listed as historically proved under the same number. This review retains the user's formulations as **candidate D115-BC / H5-BC / PNAJ-BC / Bridge-BC** pending author provenance reconciliation. A separate contemporary candidate had also used a D115 label for a conditional protected spectral projector: this reinforces the need for identifiers before promotion.

Do not infer canonical status, established BCRD physical truth or Book I provenance from theorem labels alone.

## II. D115-BC: what a Gauss constraint actually entails

Let H_phys=∩ ker(G_x). If a unitary U preserves each constraint strongly,
[U,G_x]=0, then G_x U|ψ>=0 for |ψ>∈H_phys.
If an observable O is gauge invariant, [O,G_x]=0. Neither statement shows that O is **boundary-supported** or separates arbitrary internal physical states.

A vanishing expectation of [G_boundary,O_boundary] may arise from the constraint or the fact that G acts trivially on the physical sector. It is not a proof that all bulk information can be read from the cut, nor that a boundary trace is invariant under arbitrary *physical evolution*. More precisely, the displayed commutator involves G_boundary, which must be represented on the reduced boundary Hilbert space to be paired with ρ_boundary.

The proposed equivalence

    Tr(ρ_boundary[G_boundary,O])=0 for all O∈A_boundary
      IFF Z(A_boundary)⊆ker(δ_anomaly)

has no derivation as written. The anomaly map δ_anomaly is undefined as an operator with specified domain, image and dynamical relation to G_boundary. If G_boundary=0, the entire left condition holds for any boundary ρ. If δ_anomaly is independently chosen nonzero on a center element, the right condition fails. Conversely, δ_anomaly=0 makes the right condition true but establishes no information-completeness property. Such relations have to come from an actual microscopic action.

Tomita–Takesaki modular theory applies to an appropriate cyclic and separating representation / faithful normal state. It does not automatically apply to every arbitrary pure vector for every local subalgebra. Under a faithful normal state's modular group, central elements of the von Neumann algebra are fixed pointwise; preserving the center is therefore not an independent indication of the claimed absence of information leakage. Modular conditional-expectation theorems have specific hypotheses, not “closure” inferred from the name.

Gauge-group averaging P_Gauss=∫ U(g) dg is legitimate only with a specified normalized Haar measure on a suitable compact (or otherwise properly regulated) gauge group; it does not automatically construct a universal projection for all BCRD constraints.

## III. H5-BC: strict entropy increase is not implied

The proposed theorem claims EVERY deterministic/generative complete map must have ΔS=S(Φρ)-S(ρ)>0, on the basis of positive quantum relative entropy.

This inference is FALSE. Relative entropy
    D(σ||ρ)=Tr σ(logσ-logρ)≥0
is not the same quantity as
    S(σ)-S(ρ).
A nontrivial unitary Φ(ρ)=UρU† can preserve von Neumann entropy exactly for EVERY ρ, while acting nontrivially on states and observables. A trace-preserving, Gauss-compatible identity channel trivially has ΔS=0.

The stronger counterexample uses a genuine CPTP reset to a pure state:
    ρ=I_2/2,  σ=|0><0|,
    K0=|0><0|, K1=|0><1|,
    ∑K†K=I,  Φ(ρ)=σ.
Then
    D(σ||ρ)=ln 2 >0,
    S(σ)-S(ρ)= -ln 2 <0.
Thus STRICT relative entropy does not even force a nonnegative entropy difference. G=0 is a valid (though physically uninformative) Gauss constraint, so nothing stated about generic Gauss closure excludes this example.

The purported inference “ΔS=0 implies D=0” is also false: a unitary rotation between distinct mixed states of the same spectrum has ΔS=0 but D(σ||ρ)>0 for full-rank ρ.

Where H5 assumes inaccessible data, a valid information-theoretic lower bound must be stated in terms of explicit observations and indistinguishable states. Neither “modular flow” nor “generative” in a name creates a positive entropy gap.

## IV. PNAJ-BC: wrong inequality directions and wrong quantifier

With natural logarithms, quantum Pinsker has the form
    D(σ||ρ) ≥ (1/2)||σ-ρ||_1²
(for faithful support conditions).
It gives an UPPER bound
    ||σ-ρ||_1 ≤ sqrt(2D(σ||ρ))
when D is finite, NOT the submitted lower bound.
Large relative entropy need not imply large trace distance.

Hölder's trace inequality says
    |Tr(C(σ-ρ))| ≤ ||C||_∞ ||σ-ρ||_1,
NOT ≥. A central observable can be insensitive to a nonzero state difference; choosing C=I makes the expected-value gap exactly zero for any two normalized states. Hence the desired positive single-judgment gap does not follow.

The submitted
    sup_{E computable}|J(ρ)-J(Eρ)| ≥ δ
only asserts that at least one algorithm makes a sizable error. It does not rule out a different algorithm that is exact. For universal impossibility one needs, for example,
    inf_{E in permitted algorithms} sup_{ρ in S} error(E,ρ) ≥ δ>0,
with the observation model, task and allowed class fixed.

Being a functional of the **center** of a finite-dimensional algebra does not make a judgment noncomputable. For instance, J_C(ρ)=Tr(Cρ) with known rational C and rational density matrix ρ is an elementary computable function.

**Correct PNAJ information-gap theorem:** Let z:S→Z be the information actually available to the approximator, J:S→R a specified judgment. If two physically admissible states s,t satisfy
    z(s)=z(t),  |J(s)-J(t)|=δ>0,
then for EVERY estimator f:Z→R,
    max(|f(z(s))-J(s)|, |f(z(t))-J(t)|) ≥ δ/2.
Proof: let a=f(z(s))=f(z(t)); triangle inequality gives
    δ≤|J(s)-a|+|a-J(t)|≤2 max(errors).
This is genuinely independent of algorithms' computational sophistication and is a precise non-substitutability theorem **relative to the available observations**. It requires proving the indistinguishable pair and a meaningful δ on the real physical judgment domain. It does not assert metaphysical impossibility of algorithmic judgment or a universal origin-derived standing rule.

Lean IR-132 proves the exact non-reconstructibility case, without assuming a metric: same accessible input, different judgment ⇒ no estimator can be exact on BOTH.

## V. Bridge-BC: a correct finite-dimensional reconstruction criterion

Let S_phys be the actual admissible physical state domain. Let
    b:S_phys→B
be the operational boundary readout and
    l:S_phys→L
the logical interior quantity to reconstruct.

**Theorem (fiber criterion):** For nonempty L,
an exact function d:B→L satisfying d(b(s))=l(s) for every
s∈S_phys exists IFF
    b(s)=b(t) ⇒ l(s)=l(t)
for all s,t∈S_phys.

*Necessity*: apply d to equal boundary readings.
*Sufficiency*: for each populated boundary fiber, choose one
representative state and return its logical label; fiber
constancy makes the choice independent of representative.
Outside the observed image use a default logical label.

The sufficiency construction may require classical choice and
is not by itself a computable algorithm, a physical sensor
or a norm-preserving linear/isometric *-algebra embedding.

IR132ExactBoundaryReconstruction.lean proves both directions
and the exact two-bit counterexample.

**Gauss-compatible countermodel:** H=B⊗E with B=E=C²,
G=0, and states
    ρ0=|0,0><0,0|,
    ρ1=|0,1><0,1|.
The reduced boundary states Tr_E ρ0 = Tr_E ρ1
are identical, while the interior states differ.
For every boundary operator O_B,
    Tr((O_B⊗I_E)(ρ0-ρ1))=0.
No boundary decoder can recover the bulk label on
both states. Even if a model has nontrivial gauge
constraints, it must separately prove they eliminate
all such degenerate observable fibers.

**Size obstruction:** A claimed injective linear map
M_n(C)→M_m(C) cannot exist when n²>m², simply
by complex vector-space dimension. In particular,
a unique isometric full-bulk embedding into a
smaller boundary algebra cannot be inferred
without a restricted *code subalgebra/subspace*.

**Exact positive construction:** Let H_L=C²,
H_B=C², H_E=C² and choose the fixed-ancilla isometry

    V: H_L→H_B⊗H_E,
    V|ψ>=|ψ>_B⊗|0>_E.

For each logical operator A∈B(H_L), define
    tilde A=A_B∈B(H_B).
Then
    (tilde A⊗I_E)V=V A,
    V†(tilde A⊗I_E)V=A,
so all logical expectations are exactly represented
by boundary observables on the encoded states.
Also, for EVERY environment operator E,
    V†(I_B⊗E)V=<0|E|0>I_L;
the environment has no logical information.

The fully linear isometry V and the algebra map
are a positive constructive example, NOT a
consequence of Gauss constraints alone.

## VI. General erasure-correctable code criterion

For an actual encoding isometry V:H_L→H_B⊗H_E,
a finite-dimensional sufficient-and-necessary
condition for complete recovery of arbitrary logical
quantum information from B (erasure of E) is that
the complementary environment channel is constant:

    V†(I_B⊗E)V = ω(E) I_L
    for every E∈B(H_E),

with ω a normalized positive functional on E.
This is the erasure-specific Knill–Laflamme
condition. It says the discarded environment
cannot distinguish logical inputs.

Under the exact code-correction hypotheses, a
boundary recovery channel exists, and
logical observables have appropriate Heisenberg
representatives on the recoverable boundary
operator algebra, modulo behavior off the code.
The reconstruction map is not generally unique
off-code without extra gauge/representation
choices.

If a claim is stronger—one *specific fixed*
isometry V:H_bulk→H_boundary and
B(A)=VAV†—then norm isometry follows from
V†V=I. But the critical **existence** of a
physically permitted V, and physical placement
of its image in accessible boundary degrees
of freedom, do NOT follow from modular theory
or local Gauss law. Some code states admit no
boundary-only recovery, as above.

A geometric/bulk JLMS relation is a result
under specific holographic code and relative
entropy assumptions; it is not a theorem that
every arbitrary relational graph and arbitrary
boundary cut admits a unique reconstruction
Green's function or a modularly equivalent
bulk/boundary Hilbert space.

## VII. Consequences for UPT and X3

One may conditionally join:

1. **Source-exact logical boundary decoder** or
   Knill–Laflamme code condition for a specified
   logical subalgebra and boundary access rights.
2. **IR129/130 physical detection**, after proving
   that the actual causal subject-relevant cut
   changes a state distinguishable by those
   operationally available boundary measurements.
3. **IR125 witness capture**, via an independently
   specified physical measurement/durable record
   mechanism. Mathematical distinguishability
   alone is NOT logging.
4. **IR127/128/131 protection, equivariance
   and executable branching**, plus honest
   consent, progressing services and real
   physical mediation.
5. Independent **particular/identity semantic
   correspondence**, maximal X3 choice/freedom,
   and coverage of indirect environmental bypasses.

The candidate D115/H5/PNAJ logic cannot simply
replace any of these joins. If original D115
(XOR/statistical-capacity distinction) is to be
used, it should be reconnected under its
historically grounded statement, not silently
equated with the new boundary-center candidate.

## VIII. Validation programme and verdict

A concrete BCRD model would need: actual
Hamiltonian/Gauss generators and physical state
code; boundary algebra with measured access;
explicit encoding V and erasure channel;
finite Kraus / Knill–Laflamme checks across
all logical matrix units; reconstruction of
a noncommuting logical basis (not merely a
central charge); modelled environmental faults;
and a source-to-physical subject/continuation
and authorization adapter.

**Verdict:** D115-BC, H5-BC and universal PNAJ-BC
as presented are unproved and contain false
implications. A unique universal Bridge-BC
is contradicted by elementary physical models.
The *fiberwise boundary decoder theorem* and
*code-subspace erasure reconstruction theorem*
are rigorous conditional replacements with
explicit positive and negative cases.
Do not promote any proposed theorem to
canonical Snuffy/BCRD universal physics or
maximal X3 without source reconciliation,
independent physical and semantic proofs.

## Scholarly grounding

- Knill & Laflamme, *Theory of quantum
  error-correcting codes*, Phys. Rev. A 55,
  900 (1997), DOI 10.1103/PhysRevA.55.900.
- Takesaki, *Conditional expectations in
  von Neumann algebras*, J. Functional
  Analysis 9, 306–321 (1972), DOI
  10.1016/0022-1236(72)90004-3.
- Quantum Pinsker inequality and
  Schatten Hölder trace-duality are standard
  inequalities; verify directions before
  invoking as a positive separation bound.

These works do not validate BCRD or the
conscious-subject semantics.
