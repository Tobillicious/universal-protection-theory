# IR-73 — Temporal finite-prefix refutation of missed bounded service

**Provenance:** independent Lean repair and hostile checks responding to
Gemini's discussion of DOI 10.5281/zenodo.23599528, IR-69–IR-72 and
the relation between timed FIFO guarantees and open-ended service.
The live Zenodo record was not accessible; this is based on the
previously supplied original source audit and current GitHub proof
signatures, not a fresh archive replay.

## Exact distinction

- Static `IRFiniteRefutationCriterion.FiniteRefutations` concerns
  finite sets of **retained facts**. IR-70 proves an exact iff for that
  static inclusion-order feasibility representation.
- IR-73 instead defines `FinitePrefixRefutations` on infinite
  physical-state histories `Nat → Bool × Bool`; a finite witness
  forces failure for every alternative history with the same **true
  state sequence** up to the witness cutoff. No result equates the two
  notions without a separate faithful semantic bridge.

## Formally proved

1. `bounded_response_has_finite_prefix_refutations`:
   if a true request is not served at any time in the closed interval
   [k, k + deadline], the true history prefix of length
   k + deadline + 1 forces violation in all matching histories.
   One response suffices; Gemini's textual formula mistakenly
   demanded a response at EVERY k <= deadline.
2. `threshold_failure_is_finite_prefix_refutation`: a violated
   pointwise threshold has a finite index, and matching the true
   physical reading at that time forces failure. No bounded-descent
   assumption is needed for THIS logical existence claim.
3. `unbounded_eventual_service_is_not_finitely_refutable`:
   a request at time zero that is never served is infeasible under
   eventual-service liveness, yet every finite prefix has a
   physically labeled future extension that finally serves it.
   Hence failure of unbounded eventual service has no generic
   finite forcing prefix.
4. `bounded_response_implies_eventual`, but for EVERY fixed deadline
   there exists a history satisfying eventual service and violating
   that deadline. No generic promotion of an undated service duty
   into a nominal FIFO deadline is valid.

## Limits and physical join

A mathematical prefix of **true physical states** is not a log of
sensor observations. A hidden jump at any finite time still yields
a finite true-state safety witness, even if the controller does not
detect it. The missing interface is correct timestamped observation
and complete causal/refinement coverage, plus a source-to-recipient
service receipt.

A bounded service deadline improves temporal refutability but cannot
be invented. A timed FIFO theorem on declared loads/protocols does
not show every actual service and interruption fits that deadline.
The full X3 physical feasible history predicate may mix safety,
unbounded eventual duties, positive continuity requirements,
multi-particular autonomy and nonfinitary tail constraints. IR-73
does not establish original X3 maximality or full physical
feasibility.

**Reviewer correction:** A fixed 100 J battery with an independently
required energy drain 0.01 J/tick and a hard reserve of 5 J loses
its permissible 95 J after 9500 ticks absent replenishment. It
cannot be viable for every finite horizon. The proposed example
of 'all finite horizons viable but no infinite continuation' is
internally inconsistent for that fixed finite battery. IR-72's
unbounded initial action countdown remains a genuine logical
counterexample when the action space is not compact.
