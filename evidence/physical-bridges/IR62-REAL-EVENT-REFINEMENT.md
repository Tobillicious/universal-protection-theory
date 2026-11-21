# IR-62 — Forward physical-event refinement with conserved residual escrow

**Source-level research proof on stacked branch IR-62.** This bridges
IR-61's *prospectively guarded synthetic controller* with a distinct
physical-event stream and independent actual-effect register.

## Structural change over IR-60 / IR-61

Each physical event carries a **proposed** model label, an actual
effect increment and a residual debit. The real state stores an
independent actual register; it is not defined as the modeled register.
At each transition a certificate must establish:

- IR-61's modeled external-event allowance is respected;
- the residual debit fits the remaining escrow;
- actual effect increment is at most the source-derived modeled
  register increment **plus the charged residual**.

The physical event type and the modeled nine-constructor event type
are distinct. For an actual physical trace, certificates must cover
**every actual transition in order**, including latent, bypass and
precommitted effects. This is an open physical-interface premise, not
something Lean can infer from a closed inductive alphabet.

## Positive theorem

The transition function updates the independent physical register and
the real residual bank. A structural induction derives:

- modeled IR-61 prospective safety under its certified external route;
- actual physical effect <= modeled physical effect + spent residual;
- spent residual + remaining residual = *one common initial budget*
  after every finite certified prefix.

If the controller envelope is T and the real physical threshold is
at least T + initial residual budget, all certified physical-event
prefixes are below the physical threshold. This eliminates the need
to assume a bound on the final actual register or a separate
retrospective final-effect sum.

## Negative controls

A real event labeled `.tick` with actual effect +2 and no residual
debit is rejected by the correspondence certificate; without the
certificate, a controller safe at threshold 1 can coexist with a
physical register of 2. Arbitrarily large unmetered residuals also
defeat any proposed universal finite residual budget.

## Still unresolved

The source theorem does **not** generate its own physical certificates.
It requires independent demonstration of the following:

1. Exhaustive real event enumeration: every physical transition must be
   represented, including hidden side effects and continuous dynamics.
2. Measured correctness of the model label and of actual physical
   increments, timing, sign and scale.
3. Real escrow debits must be causally coupled to actual residual
   effects; no unaudited or uncharged route can bypass them.
4. Verified final actuator gate, durable epoch floor and fresh-credential
   authority, not just software descriptions.
5. The initial real/model correspondence and a physical margin large
   enough for all residual exposure.
6. Nothing here establishes universal X3 joint realization or
   subjective/historical continuity.

**Status:** formal construction only; not real-world physical assurance.
