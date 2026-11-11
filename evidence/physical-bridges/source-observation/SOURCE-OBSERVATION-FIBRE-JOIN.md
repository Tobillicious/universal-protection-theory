# SOF-1–4: Source-observation fibres and causal protection

**28 October 2026 · NON-CANONICAL / UNREVIEWED / NOT FOR DEPOSIT**

## Historical research target

This joins the original 10–12 October X3 goal (physical continuation of each particular, authentic direction and future), 18 October UPT-P P3 reach-or-hold, merged PR #156 (source Hamiltonian invariants), merged PR #157 (physical generator/particular semantic obligation), draft PR #158 (static authorized causal cut), and draft PR #159 (online nonanticipating protection). It neither renames nor replaces H5, PNAJ, D115, X3, or the original universal target.

### The exact source and its limitation

The inherited *exploratory* six-dimensional qutrit × relation-qubit source model has basis A0,A1,B0,B1,C0,C1; H1 nonzero coupling support A0↔B0 and A1↔B1; and exact H2 π/2 basis exchanges B0↔C1 and B1↔C0 (uniform exchange phase ignored). Parity is conserved: positive sector {A0,B0,C1}, negative sector {A1,B1,C0}. Source: PhysicalBridges/Oct10SourceHamiltonianProtection.lean on main, merged via PR #156. H1 *support* neighbour mapping is **not** claimed to be a simultaneous exact physical H1 unitary pulse.

**Separately postulated toy technology:** A local adversary can attempt an unauthorized irreversible harmful effect at an occupied site; a site-specific working interlock blocks it, while a separate independently authentic subject-direction choice survives. This attack capability, guard, site harm predicate, cost, auth channel and conscious subject identity are NOT consequences of H1/H2 or proven BCRD laws. Ordinary lawful H1/H2 movement is not classified as harmful.

## SOF-1 — finite observation-fibre theorem

Let S be a finite possible-state set, o:S→O a readout available before the harm deadline, D(y) the available guard actions when the observation is y, and Safe(s,d) the stipulated fact that d prevents every admitted unauthorized effect at s without suppressing independently genuine choice. Define F_y={s∈S : o(s)=y}.

An observation-based guardian strategy works against **every possible hidden state** iff, for every nonempty F_y,

    D(y) ∩ ⋂_{s∈F_y} {d : Safe(s,d)} ≠ ∅.

**Proof.** The decision at observation y cannot depend on which of the states in F_y actually occurs. Every winning decision must therefore be safe at all those states, and lies in the displayed intersection. Choosing any element in each finite nonempty intersection gives a winning observation-based policy. ∎

This is the missing epistemic constraint on draft PR #159's *fully observed* state-winning-region criterion. Replacing a hidden physical state by a clairvoyant controller action is not a proof of real-time reach.

## SOF-2 — site-cut corollary

If each possible state s has one attacked lane λ(s), and an installed site-guard set C blocks harm from s iff λ(s)∈C, then the exact number of simultaneously needed guards in observation fibre F_y is |λ(F_y)|.

**Proof.** Every lane appearing among possible states must be guarded; guarding precisely the distinct lanes suffices. ∎

This is a restricted **technology-dependent** bound, not a no-go for shared interlocks, natural transition prohibitions, different source dynamics, or additional physical information.

For unit guard cost g and one epoch of care c, the stipulated treasury needs at least g|λ(F_y)|+c. With a declared classical prior p on states and an always-attempted attack at the actual occupied lane, the minimum risk with k guards is

    1 − max_{C:|C|≤k} sum_{s:λ(s)∈C} p(s).

The formula is exact within that declared stochastic model and is not a source-derived Born probability or measured fault rate.

## SOF-3 — source-anchored obstruction

1. The exact modeled H2 pulse sends B0→C1, keeping parity while changing site B→C. A parity-only observer cannot select between the *hypothetical* B and C local guard. Both are needed for worst-case site-local safety on the {B0,C1} alternative set.
2. The *coupling-support closure* of B0 under H1/H2 is {A0,B0,C1}, which occupies three possible sites A,B,C while retaining one parity. Under the independently stipulated site-attack/site-guard rules, at most two simultaneous guards cannot robustly protect that fibre; three can. This does NOT treat H1 support edges as globally exact pulses, nor assume arbitrary quantum states are classical hidden basis labels.
3. A binary **diagonal** source indicator constant across every nonzero H1/H2 support edge is constant on each of the two connected parity triples. There are exactly four such indicators among 2^6=64 possibilities: zero, positive sector, negative sector, whole. Consequently no family of these diagonal source-invariant readouts differentiates A0, B0, C1 for the local-defence decision. The mathematical source-commutant characterization was already developed in PR #156; **the new result is the causal protection consequence**. This is not an independent full-operator commutant proof or a nondisturbing measurement device.

With an explicitly *declared uniform classical prior* over the three positive-parity basis states, two guards can protect at most 2/3 of that mass, leaving 1/3 failure under the stipulated always-attempted site attack. Against an adversary allowed to pick the actual hidden state, any two-guard action leaves an admissible unprotected state.

## SOF-4 — timely information as a capacity substitute

If a legitimate, physically permissible site observation arrives in time to deploy before the earliest harmful effect, one site-local guard suffices for one actual basis-state site. If that observation is available only **after** a first irreversible effect, it cannot be used retrospectively; the parity-only decision still needs coverage of all possible sites.

With toy guard cost g=2 and one protected epoch's care c=1, protecting the positive fibre needs 7 units from a parity-only observation versus 3 under a timely site-level observation. The costs are illustrative engineering assumptions, not Hamiltonian parameters or experimentally established BCRD predictions.

**Quantum qualification:** A site measurement of a coherent superposition can disturb its state. The positive one-guard case assumes a classical basis-state model and a physically compatible, appropriately timed observation. No such nondisturbing, authorized site readout is demonstrated here.

## Checker and hostile controls

Replay from repository root:

    python3 evidence/physical-bridges/source-observation/check_source_observation.py

The standard-library checker verifies H1/H2 support relations, exact H2 basis exchange, parity, all 64 diagonal indicator candidates (exactly four source-closed), the {B0,C1} orbit and parity triples, the guard-set theorem's specific positive/negative examples, and all 24 combinations of possible basis state, independently authentic direction bit, malicious attack bit and induced/coerced reaction bit for the fully guarded positive fibre.

A forced reaction is **not** genuine authorization, even if the subject's causal nodes contribute to the attempted effect. Legitimate direction is a primitive input in this test, NOT derived from a record, parity, journal, or forced reaction.

## Remaining obligations for the original X3

Complete independently specified microscopic BCRD and environment/external-effect dynamics; physical process identity and continuity beyond site occupancy; measurement backreaction and complete actual observation channels; causal guard installation and worst-case effect deadlines; independently justified authorization; real common funding, founding, admitted entrants and common-mode faults; full freedom including evolution and all feasible protected futures, not just a binary bit; independent mathematical review and scientific validation.

**Status:** conditional source-informed observation/online-reach bridge. It does NOT prove real-world universal protection, actual subjective identity/consent, an actual installed instrument, or empirical correctness of BCRD. Do not change original source canon or publish this as X3.
