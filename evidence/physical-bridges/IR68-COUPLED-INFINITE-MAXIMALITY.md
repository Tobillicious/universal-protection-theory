# IR-68 — General infinite coupled two-stage full-feasible maximality

**Mathematical scope.** Every potential outcome is a subset of the
countably indexed tagged facts `Bool × Nat`. The tag selects one of TWO
priority layers. The entire infinite feasible outcome universe is
considered, not a finite menu or a finite profile quotient.

A single common predicate `Feasible forbidden` excludes arbitrary
specified finite sets of tagged facts from simultaneous retention.
Unlike IR-67's general separable theorem, these finite no-good patterns
may explicitly couple **first-priority and second-priority facts**.
The empty retention outcome is required to be feasible.

## Source-level construction

1. Starting from empty retention, an infinite first phase scans
   priority-0 facts, adding the next fact exactly when doing so is
   feasible under the **same coupled predicate**.
2. A finite forbidden pattern present in the limit would occur in a
   finite stage. Therefore the first limit is feasible.
3. The second phase starts from this FIRST LIMIT and scans the
   lower-priority facts with the same coupled feasibility oracle.
4. A source-level induction proves the second phase never adds,
   removes, or changes a higher-priority fact. Its limit is feasible.
5. Any feasible alternative strictly improving first-priority
   retention would have been addable during the first phase by
   hereditary feasibility, a contradiction.
6. Any feasible alternative with equivalent first-priority retention
   and strictly better second-priority retention would have been
   addable during the second phase, another contradiction.

The constructed outcome therefore satisfies the exact original
`UPTExist.LexAlignedL` predicate against EVERY outcome satisfying
the same common coupled feasible predicate. The `UPTExist.LexBetter`
order is neither changed nor replaced by a scalar score.

## What it does and does not resolve

IR-68 is a substantial formal generalization of IR-67 for **two**
priority stages: it does NOT assume their feasible sets factor into
independent parts. Coupling constraints are arbitrary finite mixed
patterns; the infinite number of feasible outcomes need not be
enumerated.

The construction is classical and noncomputable for unrestricted
feasibility predicates. It is not a deployed selection algorithm.

The class remains FINITARY: infeasible outcomes must be detectable by
one forbidden finite pattern of retained facts. A global infinite
budget, asymptotic failure, unbounded historical debt or any other
feasibility violation with no finite witness can invalidate the chain
upper-bound property. The original `UPTExist.chainKey` countermodel
remains a real objection outside this model class.

**Still open:** deriving that class for the actual original X3 physical
feasible world; more than two genuinely coupled original priority
stages; the original protected particular and all full freedom
attributes; joint physical realizability, impartial conflict policy,
actual historical continuation and externally verified service.
No X3 weakening or canonical archive modification is proposed.
