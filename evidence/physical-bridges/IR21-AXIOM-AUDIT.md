# IR-21 — Independent transitive axiom audit in CI

Before this repair, the workflow compiled Lean, printed each theorem's
`#print axioms`, and checked for literal `sorry`/`admit` tokens in
the new source files. That did NOT automatically fail the pipeline
if a compiled theorem acquired an unexpected transitive axiom
such as `sorryAx` through an imported dependency.

The Lean action provides a built-in `axiom-audit` option. This PR sets:

- `axiom-audit: true`
- `axiom-audit-root: PhysicalBridges`
- `axiom-audit-allow: propext,Classical.choice,Quot.sound`

The action audits declarations across the requested namespace and fails
on any unexpected axiom. Existing compilation, textual placeholder
checks, and independent model checks remain.

**Scope note:** Conventional proof-theoretic axioms on the explicit
allowlist are not asserted to be physical premises. Conversely,
the explicit physical premises *in theorem signatures* are Lean
hypotheses, not unchecked custom axioms: axiom-audit cannot prove that
any actual instrument supplies them. It is a stronger formal
provenance gate, not a physics validation tool.

Reviewer should confirm this action audits ALL required modules,
especially the imported historical Snuffy sources. Other namespaces
may need additional dedicated roots when their theorem signatures
are used in publication claims.
