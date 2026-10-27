# IR-25 — Honest residual-escrow bridge

IR-24 needs a finite upper bound on cumulative physical influence not
represented in the classified instrument channels.

A durable escrow ledger can supply this bound IF, for every event,
the residual is physically measured and charged into the same account.

This module imports the actual IR-2 conservation theorem and proves:
- correctly debited residual influence <= escrow's initial capital;
- actual physical-event execution is bounded by classified charges plus
  initial escrow, given real effect-to-debit correspondence;
- combining IR-23's non-Zeno time budget with escrow conservation gives
  a single post-effect physical threshold certificate.

The negative control proves that a perfectly conserved ledger with
zero funds can coexist with an unmetered positive physical event.
Therefore bookkeeping alone has no physical authority.

**Unproved physical interface:** actual debits must be authoritative,
atomic, irreversible and complete over every physical effect including
delayed and bypass changes. The ledger's "capital" requires correctly
calibrated physical units and a genuinely enforced escrow. Without
those facts this remains conditional algebra. No X3 changes.
