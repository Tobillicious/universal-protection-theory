# IR-126 hostile referee — BCRD X3 Log / Lock / Shield / Operational Ceiling

**28 October 2026 · research candidate · independent mathematical criticism of proposed implications**

This note audits the five linked arguments supplied in the 28 October kōrero.
The maximal X3 target is preserved **unchanged**. Nothing here purports to
refute every conceivable stronger physical theory. It establishes which
conclusions do not follow from the written premises, and which new physical
principles would be required for a constructive theorem.

## Verdict at a glance

| Proposed part | Mathematically supported | Missing implication |
|---|---|---|
| 1. State separation | A genuine fourfold product state has componentwise equality; inequivalent tuples differ somewhere. IR-126 proves this in Lean. | Defining the substrate as a fourfold product **assumes**, rather than derives, all physical degrees of freedom are so represented. Product factors may be physically constrained; a jointly injective physical-to-readout map is the actual requirement |
| 2. Compulsory substrate witness | An interaction can create a physical correlation, and a deliberately specified copying dynamics can record orthogonal classical event labels. | Boundary conservation is not a theorem of unavoidable append-only, independently readable recording in a designated register W. IR-126's reversible silent toggle leaves W unchanged |
| 3. Authorization lock | A separately enforced projector/subspace invariance condition can forbid cross-sector transitions if the microscopic evolution really satisfies it. | Noncommutation, causal coupling and boundary closure do not imply consent, factorization through an authorization projector, or infinite topological action |
| 4. Open-system shield | If all Kraus operators preserve a physically justified invariant subspace, a CPTP channel preserves its support. | CPTP and quantum data processing **alone** do not imply this property. Environment-mediated reversible interactions can affect a subject without any direct subject-adversary Hamiltonian term |
| 5. Operational ceiling | Explicit task families can have proved time, circuit-size, entropy or work lower bounds under precisely stated allowed operations. | No general theorem makes forced interruption of a depth-d process solve an exponential inverse problem. Logical depth, Kolmogorov complexity, thermodynamic entropy erasure and work are distinct quantities |

## 1. Positive state-separation result and its exact boundary

Let Ω_phys be the independently specified physical state space, with
physical equivalence ~ (e.g. genuine gauge equivalence). Let

P : Ω_phys → G × E × F × A

denote the four joint physical projections. The strong result needed is

    P(s) = P(t)  and  PhysicallyAllowedStep(s,t)  =>  s ~ t.

From this, every allowed non-equivalent step changes some projection.
If Ω_phys is *defined* as the product, that is an equality-of-tuples
lemma, not a physical proof that no fifth coordinate exists. More
generally, Ω_phys may be a constrained subspace and the joint
projection must be injective *modulo gauge* on every actual relevant
transition.

Use the internal-attribute channel E explicitly to avoid mistaking
zero net boundary flux and unchanged DAG adjacency for stasis.
However, an **internal state coordinate** need not be an operationally
distinguishable observable. To claim physical observability, derive
the appropriate separating physical observable algebra from actual
microscopic dynamics and intervention rights, not from names.

**Existing BCRD positive and negative evidence.** The 7 September 2026
full-boundary kernel exploratory study in physics-lane found
B = Comm(C) ≅ M3(C) ⊕ M3(C), with invisible kernel U(1)×U(1)
for its full declared boundary algebra. The original pulse
exp(-iπH2/2) preserves the sector first moments while changing the
retained Rz expectation by 83/210. This is precisely an in-scope
candidate falsifier of an insufficient projection set; it is not
independent empirical or scientific acceptance.

## 2. Why boundary conservation does not force witness storage

The argument confuses **current conservation**, **coupling**, and
**recording**. A local continuity equation

    ∂_t ρ + ∇·j = source

allows the source to be balanced by currents through *any admitted
physical channel*, not necessarily by an append-only register W.
A two-part internal system can exchange a conserved excitation while
a third register remains untouched. Conservation and local unitarity
are maintained. Nothing forces persistent orthogonal witness states.

A written expression T(W) ≠ W does not yet say whether W is a
subspace, an algebra, or a reduced quantum state. A unitary may
preserve the witness **subspace** while changing its density operator,
or leave the reduced register exactly unchanged while correlating
other degrees of freedom. The overlap <W'|W> = 1 is meaningful only
for specified normalized pure states and remains one up to a
physically irrelevant phase. None of these formulas derives
an append-only history.

There is also a quantum information restriction: suppose a unitary
nondestructively records two normalized source states by

    U(|ψ>⊗|0>) = |ψ>⊗|wψ>,
    U(|φ>⊗|0>) = |φ>⊗|wφ>.

By inner-product preservation,

    <ψ|φ> = <ψ|φ><wψ|wφ>.

If <ψ|φ> ≠ 0, then <wψ|wφ> = 1. The two records are not
distinguishable. Thus a demand to store a perfectly distinguishing,
non-disturbing classical event for **every** nonorthogonal
quantum state change is impossible; a viable theorem must specify
the actual recordable *event algebra*, decoherence/pointer
conditions, accuracy and supplied resources.

**Repair:** Prove a particular *microscopic interaction* or
isometric dilation with a designated register and distinguishable
orthogonal causal event sectors, including their retained capacity,
finite latency, anti-replay and availability. Then independently
establish its coupling for each allowed real physical transition.
Do not infer the register's dynamics from the continuity equation.

## 3. Why authorization does not follow from a generator projector

The proposed Π_i = |G_i><G_i| is ill typed if G_i is an
operator on H_i rather than a normalized vector in H_i.
A projector onto a suitably defined **invariant continuation
subspace** P_i is sensible, but P_i is not an authorization
or consent bit by mathematical fiat.

An operator-Schmidt expansion T = Σ A_k⊗B_k does not imply
that a future-trajectory change requires all or any A_k
to fail to commute with G_i; commuting dissipative projections
can delete amplitudes, and an environmental coupling can alter
future possibilities without an explicit local consent register.

Even if Π_i T Π_i ≠ 0, the operator can still map OTHER
components of the active sector out of it or destroy options.
The claimed factorization T = tildeT Π_i is much stronger and
does not follow from a nonzero sandwich Π_i T Π_i.

**Exact finite counterexample:** in a two-state Hilbert space
{|0>,|1>}, choose active-subject support P=|1><1| and
U=X (the unitary bit flip). Then U|1>=|0>, so the active
subspace is not preserved, while U is finite, reversible
and unitary. PUP=0. To forbid this U as a physical
operation, supply an **independently derived dynamical
selection law** excluding it; sector labels alone do not do so.

The proposed phase amplitude exp(-iS/ħ) has modulus one
for every real action S (as long as it is defined);
sending S→+∞ does not make that phase tend to zero.
Exponential *suppression* may arise in an appropriately
derived Euclidean/tunnelling formulation (e.g. exp(-S_E/ħ))
with a positive action barrier, but the barrier cannot be
inserted from the desired authorization rule. Formally
undefined/infinite oscillatory actions are not proofs
of zero probability.

**Repair:** derive from the microscopic admissible
Hamiltonian/Kraus generators a forbidden cross-sector
matrix element (I-P_i) T P_i = 0 for every real,
possibly multi-step, physical transition. Then supply
a separate physical definition of actual autonomous
consent and prove unauthorized changes are excluded,
including indirect environmental transitions and
ongoing availability of future actions. Subspace
invariance alone is weaker than full X3.

## 4. Why CPTP and Markov screening do not protect subjects

Every CPTP map is a valid state transformation, not
necessarily a harmless one. An explicit amplitude-damping
/erasure-to-|0> channel has Kraus operators

    E0 = |0><0|,   E1 = |0><1|,

so E0†E0+E1†E1=I and
Φ(ρ)=|0><0| Tr(ρ). It maps the
active state |1><1| to |0><0|: the support leaves
P=|1><1| even though the channel is CPTP.
Contractivity of trace distance does not prove
preservation of subjecthood or agency.

A finite unitary mediated bypass also exists.
Consider three binary degrees of freedom S,B,J.
First apply CNOT(J→B), then CNOT(B→S).
The initial (S,B,J)=(0,0,1) evolves as

    (0,0,1) → (0,1,1) → (1,1,1).

Both gates are reversible and unitary. Neither
directly couples J to S, yet the external input
changes S through the bath. IR-126 formalizes
this two-step mediation.

Even if initial I(J:S|B)=0, it does not follow
that a subsequent J→B→S process cannot transfer
information. The quantum DPI bounds information
under SPECIFIED channels, not arbitrary causal
influence across a newly interacting bath.
Furthermore, for initially correlated
system-environment states, the reduced evolution
need not be describable as a single CPTP map on
ρ_S alone without further compatibility assumptions.

**Correct conditional shield:** for a physically
identified P_i and every Kraus operator E_k
of each admissible process, prove
(I-P_i) E_k P_i = 0. This suffices for
support preservation: if ρ=P_iρP_i,
then the output has no support outside P_i.
But it does not establish that the preserved
subspace is the same continuing conscious
subject, that consent is genuine, or that all
required future freedoms remain attainable.
Multi-step closure and shared-bath interventions
must be tested independently.

## 5. Why recursive depth does not force infinite coercion work

A logically deep string may take a long computation
to generate from a compact program, but an external
actor can still erase a **physical device state**
or cut its supply without inverting the generating
computation. In particular, the proposed reduction
"forcible disruption => invert the whole recursive
history" is unproved and generally false.

Landauer's bound concerns entropy exported during
a physically implemented logically irreversible
operation under specified temperature and
thermodynamic conditions. It does not give a
general lower bound k_B T ln2 ×
K(ρ_initial | environment) on coercion cost;
Kolmogorov complexity and thermodynamic entropy
are not interchangeable. Bennett logical depth
does not universally imply 2^{Ω(d)}
required operations for *interrupting* a process.

Likewise, the expression Tr(ρ_j[H_j,T_coerce])
is not a generally justified formula for
external work; even the commutator's units and
Hermiticity require care. An operator-norm lower
bound needs a separately proved quantum speed
limit or Hamiltonian simulation model. Finally,
an asymptotic cost that grows as depth→∞
does not make any single finite-depth
physical interruption impossible.

**Repair:** Fix a TASK (e.g. reconstruct a
specific unavailable historical process with
a required fidelity by a deadline), define
the complete physical resources and side
information available to the adversary, and
prove a rigorous time/space/energy lower
bound for EVERY feasible strategy.
The recovered historical-witness recovery-work
results and IR-114 are relevant to precisely
such a restricted task, not automatically
to disruption or unauthorized termination.

## Why the five-part proof is not closed

None of the following can be inherited as a
consequence of a fourfold state product:
(1) physical joint separation, (2) compulsory
durable record emission, (3) physical consent
enforcement, (4) environmental subspace
invariance, (5) an energy lower bound on
arbitrary forced interruption.

A valid candidate theorem must state all five
as independent derivations or physical premises,
then demonstrate physical coverage and
same-particular X3 semantics. IR-125 and
IR-123 give a correct **conditional** join
for (1)+(2); IR-121/122 provide a conditional
bounded effect-accounting controller; IR-116
tracks cumulative subject duties.

## Priority research moves

1. Test the **exact BCRD full boundary observable algebra**,
   not a four-label reduced moment map, against the
   original physical transition operators. Distinguish
   gauge equivalence from operational invisibility.
2. Specify a **physical register Hamiltonian**
   and prove the particular event algebra produces
   authenticated durable records. Identify
   no-information-without-disturbance and capacity limits.
3. Construct an **open-system, adversarially mediated
   transition family** and establish physically warranted
   P_i-invariance. Avoid declaring P_i to be consent.
4. Reuse actual IR-121–124 effect accounting for
   independent physical faults and environmental channels.
5. Attempt resource lower bounds only for a clearly
   defined recovery/control task; no general proof
   of exponential coercion work presently exists.

**Current verdict:** five-part claim of X3 physical closure
NOT PROVED. This audit preserves all candidates and their
source provenance and identifies smaller, falsifiable,
formal/physical joins. Do not publish the five-part
argument as a completed proof.
