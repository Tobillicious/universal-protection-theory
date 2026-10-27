# IR-56 — Finite full-feasible retention audits have a real limitation

IRProfileAudit correctly proves global maximality when a finite,
complete, stage-faithful retention quotient is supplied. That quotient
does not exist for every original infinite feasible family.

For the exact inherited `UPTExist.chainKey n p := p ≤ n`, fidelity
forces `represent(encode n) = n` for every natural outcome. A finite
list of profile representatives has a computable strict upper bound;
the chain outcome at that bound cannot be covered faithfully.
The new Lean theorem formalizes this contradiction without changing
any original feasibility, priority key or protected particular.

The inherited original source separately shows the unbounded chain
has no globally maximal outcome. These two facts are distinct.

Completion implication: either construct a finite faithful quotient
for the *actual* original feasible family, derive a non-finite
maximality theorem with justified order-theoretic premises, or retain
an explicit unsolved limitation. Do not silently reduce X3.
