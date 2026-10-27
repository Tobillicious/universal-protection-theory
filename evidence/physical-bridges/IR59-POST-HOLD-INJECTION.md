# IR-59 — Revocation despite arbitrary post-hold queue injections

**Status:** draft proof, subject to pinned Lean build and hostile review.

**Problem closed within the synthetic protocol.** IR-33/34 show that a committed
hold excludes old queued effects through restart and delivery, but their
existing execution language excludes new dispatch. IR-59 introduces an
unconstrained queue-injection command on the *existing* source-level
`IRDurableEpoch.Persisted` machine, along with a ghost counter measuring
effects landed by tokens from a revoked generation (token <= g).

A final-application credential check, backed by a durable monotone floor,
ensures this revoked-generation counter cannot increase under **any finite
interleaving** of future committed holds, crashes/restarts, queue injections
with arbitrary credentials, and deliveries. There is no assumption that
new pending credentials are old-only. A nonvacuity witness shows fresh
generation work can still land after the hold.

A source-level negative test shows that volatile-only revocation permits
old work to land after a restart. The existing IR-33 unsafeDeliver
countermodel shows why admitting a token safely is insufficient without
a check at the *physical landing* boundary.

**Crucial limit.** The result concerns only revoked-generation effects.
A credential carrying a new generation can still land. It does not prove
that the new effect is safe, that minting is controlled, that all actual
actuators implement the checked delivery operation, that bypasses do not
exist, or that irreversible already-in-flight events are cancellable.
`revokedLanded` is a ghost audit quantity, not a physical measurement.

Therefore this is a *positive protocol-level route-exclusion lemma*,
not an unconditional `zero_breach_bound` for physical systems.
The archived nine-transition mediation, physical coverage, and
liquidation-trigger obligations remain open. The original X3 population,
full-feasible maximality and the canonical book are unchanged.
