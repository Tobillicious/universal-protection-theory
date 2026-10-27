# IR-27 — Machine-auditable proof and physical assurance ledger

GitHub Actions now checks not only Lean theorem compilation, transitive
axioms, and independent finite-model tests, but also the *status of
claims about the world*.

The JSON ledger distinguishes:
- `FORMALLY_CHECKED` for specific verified Lean modules and synthetic
  model results (still conditional on their premises);
- `DECLARED` for unmeasured physical/semantic assumptions;
- `OPEN` for unestablished required results;
- `MEASURED` only with citation URI, hash, reviewer and method;
- `INDEPENDENTLY_REPLICATED` with at least two distinct reviewers
  and complete evidence metadata.

The checker refuses missing critical physical obligations, silent
promotion of model theorems to physics, duplicate claim IDs, and
evidence-free claims of measurement or replication. Its own negative
tests deliberately attempt these invalid promotions and require failure.

**Limitations:** A completed evidence field can still contain false
information; CI validates structure and traceability, **not the truth**
of a laboratory result or semantic claim. Scientific measurement,
independent review, and good-faith source examination remain essential.

Nothing has been measured by this PR. No main/canonical publication is
altered. All original X3 freedoms remain unchanged.
