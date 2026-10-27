# IR-26 — Append-only provenance as an explicit history interface

The earlier IR-8 theorem guarantees observed future records match
physically modeled events under a named forward-simulation relation.
Observation equivalence need not distinguish different particulars.

This finite-history module creates a separate physical history and
append-only durable record. Both retain an origin identifier; a physical
event is represented by a record event according to a specified encoder.

Lean proves:
- a correctly initialized provenance relation is preserved by one
  physical/record append operation;
- source-level IR-8 forward simulation extends correspondence through
  **every finite event history**;
- physical and recorded origins cannot be silently overwritten;
- distinct modeled origins cannot collapse into a single faithful record;
- simply matching recorded events is insufficient: a negative witness
  has equal event outputs and different origins.

What remains independent and UNPROVED: whether the chosen `origin`
identifier corresponds to actual historical identity of a continuing
particular, whether all relevant physical changes become authenticated
events, whether records are durably and non-equivocally maintained by
real hardware, whether a copied record constitutes continuation,
and all subjective/cognitive interpretations.

This is a provenance integrity theorem, not an identity metaphysics
theorem or an empirical instrument certificate. X3 unchanged.
