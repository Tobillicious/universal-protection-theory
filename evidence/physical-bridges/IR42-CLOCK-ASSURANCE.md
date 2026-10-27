# IR-42 — Assuring service timing without inventing deadlines

Following verified IR-37..IR-39 and IR-41, the public ledger now
distinguishes:

- Formal, machine-checked **implications** from a robust decreasing
  service rank, source-level belief/state tracking, and an upper
  bound on inter-step event duration.
- An OPEN obligation to show event indices really correspond to
  committed physical transitions in a correctly monitored instrument.
- An OPEN obligation to measure/guarantee a maximum wallclock delay
  between every necessary physical event, including stalls, faults
  and recovery.

The reviewer brief explicitly asks researchers to inspect these
premises. No empirical timestamps or physical instrument observations
are claimed, and no declaration is promoted to measured status merely
because the Lean code compiles. The original UPT feasibility order
and full X3 remain unchanged.

The event-time theorem's conclusion applies to a SUPPLIED completed
trace; that trace's actual physical existence is a substantive
semantic/experimental requirement, not a consequence of a total
`time : Nat -> Nat` function alone.
