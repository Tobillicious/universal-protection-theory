# IR-64 — Two-sided physical safety and observed service

IR-62 supplied a **one-sided upper physical-effect simulation**:
actual physical effect <= modeled effect + conserved physical residual.
IR-63 proved a **source-level actuator landed-register progress** result
under a physical safety margin. Those together STILL do not imply that
any recipient physically received the intended service.

## New proof structure

A separate physical-service state is introduced, with an independent
`observedServed` register and its own shared shortfall bank.
It is deliberately not identified with the controller's source-level
`landed` counter.

For each independently sourced physical event, the theorem requires:

1. IR-62's physical *upper* effect correspondence;
2. a shortfall debit fitting the remaining **service** bank;
3. a *lower delivery correspondence*:
   next modeled landed <= previous modeled landed +
   independently observed service + charged shortfall.

Induction proves for every finite certified trace:

- **physical safety upper bound:** actual physical effect is no larger
  than the model plus its separately conserved physical residual;
- **delivery lower bound:** modeled actuator landing is no larger than
  initial modeled landing + physically observed service + spent service
  shortfall;
- **two conserved banks:** physical residuals and missing-service
  allowance cannot be reused across events.

If modeled delivered impact strictly exceeds the initial baseline
plus the **entire** shortfall allowance, an actual observed-service
increment must be positive. A combined theorem simultaneously
establishes the independent physical threshold and positive service.

This does NOT mean positive observed service equals any particular
individual's continued freedom, consent, identity or historical
continuation; those are separate semantic obligations.

## Hostile control

A modeled final actuator delivery can advance its source-level
landed register while an independent observed-service register remains
zero. Thus the IR-62 upper simulation *cannot* prove delivered
service: upper physical effect bounds allow actual effect to be
smaller than modeled, even zero.

## Open empirical and semantic interfaces

- Trustworthy physical measurements of *actual delivered service*;
- receipt/recipient identity and correct satisfaction of the
  prescribed individual permission or freedom;
- causal association of source controller effects with physically
  delivered outcomes; freshness, cryptographic proof and no replay;
- nonreusable shortfall bank and service-recovery rights for misses;
- scheduler/fairness and wall-clock bounded eventual delivery;
- all-device physical event inventory and actual residual
  correspondence from IR-62;
- original X3's maximal full-feasible realization and history
  continuation.

**Formal only.** New result is conditional on proof obligations
recorded in the theorem signatures; no actual instrument was tested.
