# 10 October X3 physical theorem — original-source Hamiltonian test

**Working independent-source research note · 28 October 2026. NO canonical change.**

## Historic authority and strict non-replacement

The original Snuffy Batch 10 (10 October 2026) nine-paper review collection, Batch 11 (11 October), and 12 October author reconciliation are the baseline. The separate 10 October Gemini proof bank includes proposed H5, PNAJ, and a DIFFERENT D115 strategic deterrence inequality; the manuscript D115 is the identical-statistics/XOR informational example. Preserve BOTH source lineages verbatim with source-qualified identifiers. Do not retrofit the 24 October integration into the earlier original.

The 10 October Given the Lattice text assumes completion of BCRD (P1–P4). It does not demonstrate that physics. The original universal X3 target includes every particular continuing history, independent direction, meaningful choices, and durable effective protection. The 12 October Whole Argument identifies early first-agent and far-side-of-an-ender cases where remote deterrence or interception may fail.

## Actual pre-October microscopic source, and what it really licenses

Source: Tobillicious/physics-lane, September 7 full-boundary kernel study:
https://github.com/Tobillicious/physics-lane/blob/main/inbox/downloads-2026-09-09/archives/bcrd_boundary_kernel_2026-09-07/BCRD-FULL-BOUNDARY-KERNEL-2026-09-07.md
Frozen original source SHA: 2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35.

**Exploratory finite BCRD qutrit x relation-qubit model, NOT the universal physical theory.**
Basis A0, A1, B0, B1, C0, C1.
H1 = X_AB tensor diag(1,2).
H2 = X_BC tensor sigma_x.
Conserved C = (Q_A+Q_B-Q_C) tensor sigma_z.
Parity+ sector = span{A0,B0,C1}; parity- sector = span{A1,B1,C0}.
The full declared boundary algebra is M3(C) direct-sum M3(C).

**Crucial:** C is the source conserved parity, not a physically derived BCRD Gauss generator. No universal complete BCRD transition-source list is established by this finite control.

The exact inherited H2 pulse U=exp(-i pi H2/2) maps B0 to -i C1 and B1 to -i C0. This source pulse satisfies [H2,C]=0 and U† C U=C, but the local B-site projector PB=|B0><B0|+|B1><B1| is NOT invariant: the B0 state's PB expectation falls from 1 to 0. Thus **parity conservation plus algebraic boundary closure does not physically force a local site-occupancy lock**.

This is NOT actual termination of a conscious subject; site occupancy is not proven equivalent to the same historical subject. We are proving the missing SEMANTIC and GENERATOR constraint cannot be silently inferred from parity.

The exact source full-boundary observable Rz = I3 tensor sigma_z registers the change in the archived full-rank state rho=diag(1/4,1/10,1/6,1/7,9/35,1/12):
Tr(rho Rz)=73/210, Tr(UrhoU† Rz)=-1/21, difference=83/210. **Detectable does not mean blocked.**

## Strong exact six-dimensional classification

Let P be any diagonal binary (0 or 1 per basis ket) projector. For a Hamiltonian H, its commutator with P has entries H_ij (p_j-p_i). Since the source H1 couples A0-B0 and A1-B1, and H2 couples B0-C1 and B1-C0, [H1,P]=[H2,P]=0 holds iff

    p_A0=p_B0=p_C1 and p_A1=p_B1=p_C0.

**Full, non-diagonal strengthening (independently certified):** Define the joint complex-linear commutator map

    L : M6(C) -> M6(C) x M6(C),   X -> (H1 X - X H1, H2 X - X H2).

Using 36 row-major unknown matrix coordinates and 72 exact integer linear equations, the companion executable constructs a certified 34 by 34 submatrix. Its **exact rational determinant is 82,944, not zero**. The row selection (zero-indexed) is

    2,3,0,1,16,17,8,9,6,7,22,23,41,15,53,13,4,5,
    20,46,18,58,10,11,26,27,24,25,59,32,33,30,31,52

and column selection

    0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,
    18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34.

Therefore rank(L)>=34. I and C commute with both H1/H2 and are independent, so nullity(L)>=2; by rank-nullity rank(L)<=34. Hence rank(L)=34 and

    Comm(H1,H2) = span_C{ I, C }.

Every orthogonal projector invariant under BOTH H1/H2 must commute with both (the generators are Hermitian), hence be in this commutant. Its eigenvalue in each +/- parity sector must be 0 or 1; **there are precisely four invariant orthogonal projectors out of ALL possible (including non-diagonal)**: 0, P+, P-, I.

This **stronger result does NOT prove real subject protection**. It says the fixed source family cannot preserve any proper smaller protected subspace within a parity sector. A dynamical/history-sensitive notion of particular continuation or a different physically derived protection mechanism remains possible.

Thus **exactly FOUR of the 64 diagonal 0/1 projectors** commute with BOTH inherited Hamiltonians: none, parity+, parity-, and all. A projector containing only B-site occupancy is not among them. Sector preservation cannot certify particular-by-particular continuation within the sector.

The companion Lean source Oct10SourceHamiltonianProtection.lean formalizes the finite source coupling support and exact binary classification. The Python standard-library independent executable checks the SOURCE matrices, both parity commutators, the actual exact Gaussian-integer pi/2 pulse, all 64 candidates, and the archived rational Rz difference. The Lean code does NOT formalize complex matrix exponentiation.

## Exact local lock theorem, and the source-to-X3 gap

For a fixed orthogonal P in finite-dimensional H and a Hermitian admitted Hamiltonian H,

    exp(-itH) Ran(P) subset Ran(P) for ALL real t
       iff
    (I-P)HP=0
       iff
    [H,P]=0.

Proof: differentiate (I-P) exp(-itH) P=0 at t=0; self-adjointness kills the opposite cross block. The converse follows by power-series commutation. A pulse might return to the protected subspace at one endpoint after leaving it earlier: the quantifier ALL t is essential.

A physical controller, environment, actuator, graph-rewrite and fault inventory must satisfy this criterion or an independently derived time-dependent viable protection relation for each genuinely subject-relevant safety property. For a CPTP channel with Kraus K_k, the corresponding necessary-and-sufficient subspace criterion is (I-P)K_k P=0 for every k (already established in IR-129; avoid reproving it as new physics).

For an open Markov GKSL generator, trajectory-level invariance is ensured by (I-P)L_kP=0 for every jump and (I-P)(H-i/2 sum L_k†L_k)P=0 for the no-jump effective Hamiltonian. These are GENERATOR constraints to be physically derived, not an implication from conserved charge labels.

**Nonblocking problem:** making every individual microscopic basis projector invariant would force offdiagonal Hamiltonian couplings to vanish and can prevent all meaningful transitions. The original X3 requires protected autonomous change and real choices, not permanent stasis. A contextually legitimate, dynamic subject continuation criterion, separately grounded, is necessary.

## What remains, ordered by genuine logical dependence

1. Recover and pin the **complete microscopic BCRD admissible source laws**, not just the exploratory H1/H2 finite process.
2. Bind subject identity, agency, autonomy and choice to independent physical predicates (possibly moving in state and time). Distinguish a process transported to a new state from a terminated process.
3. Derive a local pre-effect non-bypass or viable-transition law for every actual source, including environmental and independent actor mediation, without postulating a protective result as an axiom.
4. Prove coverage of all actual source operators, and that legitimate protected evolution and branch-access remain executable, to avoid the museum-exhibit trap.
5. Only then combine with original D16, D60, D63, D65–D79, manuscript D115/D116, and source-qualified PNAJ/H5 conditional normative and decision bridges, plus the original maximal X3.
6. Reconcile proof lineage BEFORE claiming universality; no later IR result replaces the original 10 October theorem.

## Honest verdict

**PROVED IN THE INHERITED FINITE SOURCE MODEL:** H1/H2 conserve C; H2 changes B-site occupancy while keeping C; an exact nonzero rational minor proves the full commutant is span_C{I,C}, so only four invariant orthogonal projectors of any type exist; the inherited full boundary algebra detects a concrete finite pulse.

**NOT PROVED:** the B-site equals a living subject; the source model is complete physical BCRD; a real particular can be harmed by this toy pulse; the universe physically enforces or refutes maximal X3. It is a source-anchored obstruction to deriving a universal local lock merely from parity conservation and theoretical observability.

This file is a NEW independent experiment **in support of the original 10 October goal**, not a substituted definition of that goal.
