# Co-hold closure with duration feedback

A dependency closure taken at the seed's pause duration can be too small. Adding peers can lengthen the certified pause, bringing more timing-sensitive peers into scope.

Let C be the proposed held set, h(C) a supplied monotone upper certificate for its hold duration, and R_h the supplied co-hold obligation relation at duration h. Assume R_h grows with h. Define

`F(C) = C ∪ {j : some i in C has (i,j) in R_h(C)}`.

F is extensive and monotone. Starting at the seed and repeatedly applying F gives an increasing sequence. In a finite population, every strict step adds at least one node, so it stabilises after at most `population size − seed size` strict steps. Its stable value is contained in every self-consistent certificate containing the seed. For a monotone resource/duration bill it also has no larger bill than any such competing superset **inside this supplied model**.

`CoholdFixedPoint.lean` proves that monotone iteration lies below every post-fixed certificate. With **explicit extensiveness**, its stabilised iterate contains the seed, is closed and is least, without axioms. Seed containment is part of the conclusion, not silently inferred from a theorem for arbitrary monotone F. It does not claim to infer F from an actual environment. `closure_feedback.py` checks 10,206 graph/seed/cost cases, including all three-node directed relations whose edges are absent or have tolerance 1 or 3.

For a concrete cascade A→B→C→D, let the edge tolerances be 1,2,3, let every resident cost one duration unit and let h(C)=1+|C|. Obligations activate when duration exceeds tolerance. Starting with {A}, iteration gives

`{A}, h=2 → {A,B}, h=3 → {A,B,C}, h=4 → {A,B,C,D}, h=5`.

Freezing the relation at the seed's duration 2 returns {A,B}, whose own duration 3 activates another edge. A deadline of 4 passes the seed but fails the least self-consistent certificate. That failure rules out a passing superset under this particular monotone certificate; it does not prove all physical architectures infeasible. A faster implementation, a different interface contract or a tighter sound duration analysis can change F.

The tolerances, edges and duration certificate all need independent application evidence. Hiding an edge, using a duration under-estimate or treating model obligations as measured physical necessities invalidates the application. Combining this construction with the checkpointed recovery bound is a candidate route to a complete co-hold bill, conditional on those missing facts. The existing Paper 11 v0.17.12 rungs 3-5 are retained. These generic components supply conditional application interfaces; they do not reopen those rungs or add a new one.
