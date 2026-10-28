# IR-129 — Mandatory Boundary Trace: microscopic operator-algebra referee and repaired theorem

**Research review · 28 October 2026 · original maximal X3 scope unchanged**

## Verdict

The submitted **Mandatory Boundary Trace for Structural Truncations**
does **not** follow from the displayed local Gauss constraints. The
proposed `State Separation` is a valid equality-of-tuples lemma
when the fourfold product is genuinely complete; it does not
establish that the relevant boundary-local operator algebra
distinguishes changes in internal relational degrees of freedom.

The **Kraus subspace-preservation theorem** in the user's third part
*is mathematically correct* for a fixed projector on a finite-
dimensional Hilbert space. It is a precise Lock/Shield condition,
but its physical satisfaction and connection to the same
continuing subject remain separate.

## I. Type repairs

For a fixed physical state space H_phys, let A_∂ be a specified
real linear space (or *-algebra) of independently accessible,
boundary-supported gauge-invariant operators, represented
on H_phys.

The correct invisible *state-difference* subspace is

    N_∂ := {Δ = Δ† : Tr(O Δ)=0 for every O in A_∂}.

For the original fixed initial density operator ρ, define
Δ_Φ(ρ) := Φ(ρ)-ρ. Then the proposed mandatory trace is exactly

    for every physical admissible truncation Φ and ρ in scope,
       Δ_Φ(ρ) not in N_∂.

This requires Δ_Φ(ρ)≠0. It can fail even for a nonidentity
channel if ρ is stationary or if all boundary observables are
insensitive to its action.

A CPTP channel Φ is a superoperator mapping density matrices
to density matrices; Φ(|ψ>) is not generally defined.
`ker(O)` is ambiguous unless O is a specified measurement map
on states/trace-class differences, as opposed to an algebra of
observables. A channel is **operationally invisible for all
inputs** if Φ*(O)=O for all O in A_∂; state-specific invisibility
is weaker.

For a unitary U, the correct expectation difference is

    <ψ|(U† O U - O)|ψ>,

not generally <ψ|[O,U]|ψ>. A nonzero operator commutator does
not guarantee a nonzero expectation difference at the chosen
state.

## II. Exact microscopic Gauss-preserving countermodel

Take two link qubits with computational basis
|00>, |01>, |10>, |11>. Define

    Q = Z ⊗ Z,
    G = (I - Q)/2,
    H_phys = ker(G) = span{|00>, |11>}.

Thus every physical vector obeys Gauss parity Q=+1.

Let

    U = X ⊗ X.

Then U is a finite unitary, U²=I and

    [U,Q]=[U,G]=0.

In particular, U maps physical vectors to physical vectors,
and U|11> = |00>. The *internal link-occupancy pattern*
changes from two present edges to two absent edges, within this
deliberately simplified structural encoding. It is NOT proven
that these link bits represent the real BCRD geometry, and
no claim about real subjects follows.

Now define the deliberately restricted boundary-flux algebra

    A_∂ = span_C{I,Q} = C*(Q).

For every O=aI+bQ in A_∂, and in fact every density ρ,

    Tr(O UρU†)
      = Tr(U† O U ρ)
      = Tr(Oρ),

since [U,Q]=0.

In the concrete cut state ρ=|11><11| and ρ'=|00><00|,
each boundary O has expectation a+b in BOTH states.
The physical state changes, the Gauss constraint is satisfied,
and **no boundary charge observable detects the cut**.

This is not a proof that the full operational algebra lacks an
observable capable of detecting the change. For example
Z⊗I is gauge invariant in this toy sector, and distinguishes
|00> and |11> if it is operationally available. That operator
is an internal occupancy measurement, not automatically
supported on the specified subsystem boundary. Accordingly,
the counterexample proves a **failure of the implication
from Gauss law to boundary trace**, not the physical possibility
of a BCRD-subject termination.

The companion Lean finite-link model IR-129 proves the same
reversible, Gauss-neutral invisibility claim for every function
of parity and explicitly verifies that internal occupancy
would distinguish the change if admitted into the readout
family.

## III. Specific gaps in the submitted microscopic proof

**Gap 1 — No derived constraint violation.** If U commutes
with all G_v and G_v|ψ>=0, then

    G_v U|ψ> = U G_v|ψ> = 0.

Thus the asserted expression
`G_v Φ_trunc(|ψ>) = -χ_e*|ψ> ≠ 0`
does not hold for a general gauge-preserving cut. For a
CPTP map, the vector expression is generally not even typed.
Deleting an edge may be inadmissible in one actual model,
but its inadmissibility must be **derived from the real
microscopic permitted operator family**, not assumed by
declaring a local source uncompensated.

**Gap 2 — Gauge algebra does not imply boundary separation.**
The fact [O,G_v]=0 says O respects the constraints. It
does not imply A_∂ spans all gauge-invariant observables, nor
that A_∂ distinguishes every internal structural change.
Boundary electric-flux superselection observables may all
have fixed eigenvalues in a sector with many distinct internal
physical states.

**Gap 3 — No guaranteed expectation change.** Even if
[O,U]≠0, there can exist ρ such that
Tr(O UρU†)=Tr(Oρ), e.g. ρ=I/d. Hence a universal theorem must
state whether it concerns one chosen initial ρ or merely the
existence of a state on which a channel differs.

**Gap 4 — Source completeness and actual observability.**
Having an operator in a theoretical algebra does not show an
independent physical instrument can read it, in finite time,
with enough precision and without destructive effects.
IR-123–125 keep these obligations separate.

## IV. Corrected mandatory trace theorem

Let D_cut be the set of nonzero self-adjoint differences
Δ_Φ(ρ) produced by the **actual admissible structural cuts**
on the **specified physical states**. Let
A_∂^⊥ be the trace-annihilator of the independently
defined boundary observable family.

Then:

**Theorem (operationally detectable structural cuts).**
If

    D_cut ∩ A_∂^⊥ = ∅,

then for every Φ,ρ generating Δ in D_cut there exists
O∈A_∂ with

    Tr(O Φ(ρ)) ≠ Tr(O ρ).

**Proof.** Since Δ∉A_∂^⊥, by the definition of the
annihilator it is false that Tr(OΔ)=0 for all O∈A_∂.
Therefore some O satisfies Tr(OΔ)≠0. Linearity of trace
gives the desired difference. QED.

This condition is exact and honest but is an additional
**physical observable-separation property**, not a
derived consequence of Gauss law alone.

A stronger, testable finite-dimensional sufficient condition:
fix a real basis {B_α} for the linear span of physically
admissible cut-induced state differences, and independently
accessible Hermitian boundary observables {O_j}. Define

    M_{jα} = Tr(O_j B_α).

If M has full column rank and every admitted cut produces a
nonzero Δ in span{B_α}, then at least one observable detects
every cut. This is the next concrete proof target.
The rank test must use the **actual microscopic BCRD
observable algebra** and its true boundary support,
not a hand-selected set that makes the conclusion true.

A second route with a much stronger hypothesis:
if every cut changes a physically warranted conserved
boundary charge q and some available O_∂ faithfully measures
that charge, detection follows immediately. Neutral internal
cuts show why this route cannot be universal without an
additional physical prohibition.

## V. Correct Lock/Shield theorem — necessity AND sufficiency

Let H be finite-dimensional, P=P†=P² an orthogonal
projector onto a specified protected subspace and Q=I-P.
Let Φ(ρ)=Σ_k E_kρE_k† be CPTP:
Σ_k E_k†E_k=I.

**Theorem.** The following are equivalent:

1. For EVERY density matrix supported in P, its image
   under Φ has support in P.
2. Q E_k P = 0 for EVERY Kraus operator E_k.

**(2=>1)** If ρ=PρP, then E_k P = P E_k P;
therefore each E_kρE_k† has support in P, as does
their sum.

**(1=>2)** Let |ψ> be any unit vector in ran(P).
For ρ=|ψ><ψ| the output is supported in P.
Its nonnegative leakage probability is

    0 = Tr(Q Φ(ρ))
      = Σ_k ||Q E_k |ψ>||².

Every summand must vanish, for each |ψ>, yielding
Q E_k P=0 for all k. QED.

This criterion is independent of arbitrary Kraus-basis
representations. It is an **invariant-subspace theorem**,
not a proof of subjective identity, autonomous consent or
continued physically executable choices. No real BCRD
Hamiltonian or environmental dilation enforcing this
criterion has been supplied here.

## VI. Precise finite-channel state separation correction

The supplied product lemma is valid: if
Ω=G×E×F×A as **fully defined state space**, then distinct
endpoint tuples differ in at least one component.

But the statement `dΦ=0` at a point implies Φ is a
constant map is generally false. For example
f(x)=x² has f'(0)=0 but is nonconstant. If a smooth map
has zero differential **at every point** of a connected
smooth manifold, it is locally constant and hence constant.
Neither claim is needed for the endpoint tuple theorem.
A topology/geometry quotient modulo gauge requires an
additional separation theorem for physically inequivalent
states; four factor names do not demonstrate no hidden
degrees of freedom.

## VII. Next independent BCRD experiment

1. Extract from physics-lane the exact **full boundary
   algebra**, Gauss generators and microscopic
   admissible Hamiltonians; record the sectors and
   **actual supported observables** separately.
2. Enumerate or parameterize genuinely *structural*
   modifications to a specified relational subject
   graph, with the corresponding state maps and inputs.
3. Test whether each difference falls inside the
   annihilator A_∂^⊥, using the exact rank matrix M
   or an equivalent operator-algebraic calculation.
4. Where a cut is invisible, inspect whether it is
   actually physically admissible, internally detectable,
   or excluded by a separately derived physical
   selection rule. Do not declare it forbidden by
   Gauss invariance alone.
5. If operational detection succeeds, validate a
   physically unavoidable and durable *record*
   mechanism separately (IR-125); detection by a
   mathematical operator is not automatic witness emission.
6. Establish independently that protected subspaces
   track authentic continuing subjects, consent
   and the original maximal X3 future freedoms.

**Status:** a mathematically correct conditional trace criterion,
a microscopic Gauss-neutral countermodel for a restricted
boundary algebra, and a correct finite-dimensional Kraus
subspace theorem. No physically universal Mandatory Boundary
Trace or maximal X3 conclusion is established.

### Contextual scientific references

- Balachandran, Nair, Pinzul, Reyes-Lega & Vaidya (2022),
  *Superselection, boundary algebras, and duality in gauge theories*,
  Physical Review D 106, 025001,
  https://doi.org/10.1103/PhysRevD.106.025001
- *Gauge redundancy-free formulation of compact QED with
  dynamical matter for quantum and classical computations*,
  Physical Review D 102, 114517,
  https://doi.org/10.1103/PhysRevD.102.114517

These are established gauge-theory context, NOT evidence
that the speculative BCRD model or original X3 is validated.

## VIII. Structural graph changes may change the Hilbert-space fibre

A genuine topology-changing rewrite G→G' may not be an operator
on a single fixed H. If the microscopic construction instead has
a Hilbert-space bundle G↦H_G, with physical projectors P_G
and Gauss operators G_v^(G), the correct type for a rewrite
K_{G→G'} is

    K : H_G → H_G'.

There is no automatically meaningful commutator [K,G_v]
between operators on DIFFERENT spaces. A valid physical
intertwiner may satisfy, after identifying relevant
constraints,

    G_v^(G') K = K G_v^(G),

or at least

    K(P_G H_G) ⊆ P_G' H_G'.

The boundary algebra also changes with G. To compare
the two expectation values, specify a physically warranted
operator transport ι_{G→G'}:A_∂(G)→A_∂(G'):

    Tr_{H_G'}(ι(O) Φ_{G→G'}(ρ))
       versus Tr_{H_G}(Oρ).

Without this interface even the submitted structural-cut
theorem is ill-typed for genuinely changing graph topology.
A fixed ambient Hilbert space with occupancy registers,
as used in the IR-129 countermodel, is one possible
representation but must be justified, not silently assumed.

## IX. All-input channel invisibility versus fixed-state invisibility

Let A_∂ be a represented finite-dimensional unital
*-algebra of boundary observables, and U a unitary on the
same H. For a fixed O and arbitrary states ρ,

    Tr(O UρU†) = Tr(Oρ) for ALL ρ
      ⇔ U† O U = O.

Nondegeneracy of the trace pairing gives the reverse
implication. Hence invisibility of U to EVERY O∈A_∂ and
EVERY ρ is equivalent to

    U ∈ A_∂'  (the algebra's commutant).

This is a stronger, useful physical audit target than
checking only Gauss-charge conservation. It still
does NOT say which U are actual structural cuts.
Prove that each physically admissible cut unitary
lies OUTSIDE A_∂' and then specify an actually
available input state for which it changes a
measurement. For a fixed initial ρ, even U∉A_∂'
does not guarantee a detected change.

If the full physical algebra in a finite model is
A = M_n(C) ⊕ M_m(C) acting irreducibly on each
block, then its commutant comprises scalar multiples
of identity on each block. Unitaries invisible to
the **whole** algebra consist of independent block
phases U(1)×U(1) in the n=m case. But this inference
applies only to that FULL algebra, not necessarily
to the smaller set of **boundary-supported**
observables whose measurements are available to the
physical installation.

The archived exploratory BCRD full-boundary study
reported a candidate algebra M3(C)⊕M3(C) and
invisible U(1)×U(1). This is a useful concrete
reference for the commutant audit, NOT an accepted
proof of real BCRD completeness or any subject
identity correspondence.
