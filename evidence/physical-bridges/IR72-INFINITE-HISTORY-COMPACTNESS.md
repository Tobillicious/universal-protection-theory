# IR-72 — Infinite physical-history feasibility without static finite-obstruction closure

## Motivation: the archive and the precise obstacle

The author's 23–24 October archived *A Lattice Preservation Calculus*
(DOI 10.5281/zenodo.23599528) lists a typed plant-transition register,
application-time permits, priced FIFO workload certificates and sensor
safety envelopes. The original physical nine-route register is not
verified as an exhaustive real-world plant, and the zero-breach bound
still requires a route-inclusion premise. The archive's source claims
do not by themselves demonstrate an infinite actual feasible history,
historical continuity or full X3 maximality.

The later IR-69–71 source-level route proves global infinite
lexicographic maximality for models whose static feasibility is
characterized by finite forbidden retentions and feasible mandatory
bases. IR-69/70 also prove those hypotheses fail for some genuine
infinite-tail and positive-duties predicates.

**IR-72 develops a different existence route:** model feasibility as
*an infinite physical transition history that remains within a
protected viability set*, rather than as a downward-closed subset of
retained facts.

## Main theorem

Let physical states be ANY type S and disturbances ANY type D; use
two possible actions at each state. Let `next : S → Bool → D → S`
and `safe : S → Prop`.

Suppose a particular physical initial state satisfies the unaltered
source-level `IRViability.Viable safe next n initial` for **every
finite horizon n**. This means a robust, potentially state-dependent
controller can survive all disturbances up to that horizon, but its
policy may initially depend on n.

The source-level proof constructs:

1. A horizon-weakening lemma `Viable m s → Viable n s` for n ≤ m.
2. A finite-action compactness lemma: when every finite horizon is
   viable, **one of the two immediate actions** has disturbance
   successors viable at EVERY finite horizon simultaneously.
   To prove it, suppose neither action does; choose finite
   counterhorizons for each and take their maximum, contradicting
   viability for the following horizon.
3. A single, total (possibly noncomputable) memoryless policy
   preserving the predicate `ForeverViable` at each transition.
4. A full infinite trajectory `stateAt stream n` defined for all
   natural times, safe for EVERY n and EVERY disturbance stream,
   not simply a different finite plan for each n.

This is a **genuine infinite-history witness from all finite horizons
and finitely many action choices**, without the static
finite-forbidden-retention representation and without a finite state
space. It does not assume the existence of the common policy; it
derives it.

## Hostile countermodel

The result is false if the action alphabet has unbounded branching.
An initial machine may choose ANY finite countdown duration. For
every finite horizon n it can choose a large enough countdown and
remain safe that long. But once the first duration is committed, it
will eventually expire; no action then preserves safety forever.
This separates `∀ n, ∃ finite viable plan of length n` from
`∃ one infinite viable plan` without a compactness condition.

## Exact physical interface still missing

For a full application to the original UPT physical universe we need:

- A source-level mapping from **every original actual plant transition**
  (including the archive's nine categories, hidden effects, delays,
  restarts, bypasses, environment and continuous evolution) into the
  modeled `next`, `S` and `D`, preserving safety and action meaning.
- A finite physically meaningful immediate choice alphabet, or a
  more general verified compactness/closed-graph theorem for the
  actual action space. This cannot be inferred just from nine
  controller event types, which are not necessarily the actual
  authorized action set.
- Independent derivation of `∀n, Viable safe next n initial` from
  plant physics, budgets, genuinely available services, disturbances
  and mandatory history-continuation predicates. This is a NEW
  substantive premise, not discharged by the archived finite FIFO
  workload example or sensor tail.
- Semantic transfer from modeled safe states to original protected
  particular histories; a perpetually safe but inactive hold is not
  continued agency, service or autonomy. Must add liveness and
  freedom-to-change constraints, not merely a safety bit.
- A genuine original-order X3 maximality theorem OVER the resulting
  full feasible dynamic history family; IR-72 constructs one safe
  strategy, **not** a maximal protected-freedom strategy.
- Actual hardware/measurement tests. No verified physical instrument
  is currently documented in the mainline evidence template.

## Research status

The source proof is a conditional mathematics theorem and an
adversarial infinite-action countermodel. It is not a real-world
physics proof, no X3 weakening, no archive rewrite. It supplies a
distinct route when static finite-refutability does not capture the
original history semantics.

**Source verification provenance:** The live Zenodo API could not be
fetched in this session. Archive characterization above uses the
previously supplied edition 3.7 and the previous source-level
physical-interface/hostile-referee audits, cross-checked against
current mainline IR-58 and the paper-11 physical assumptions register.
This is NOT a fresh full-file replay of the DOI archive.
