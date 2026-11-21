# IR-63 — Safety is not service: a source-level reserve-release and liveness separation

The prospective IR-61 controller prevents some excessive actuator effects
at their modeled final application boundary. It does not guarantee that
pending obligations can ever be served. IR-63 tests that omission directly.

## Checked results

1. When a prospective delivery is refused, arbitrary repeated
   deliver attempts can leave the actuator in the same state forever.
   The theorem works for every finite retry count, not merely a witness.
2. A concrete protected actuator with a pending fresh-generation effect
   of size 1, threshold 1 and still-reserved external allowance 1
   refuses the work under every finite retry schedule. This is safe
   but lacks progress.
3. An external effect that *spends* its corresponding allowance
   does not increase the remaining margin: total physical effect grows
   as the reserve decreases. Thus merely waiting for real harmful
   external spending does not create new capacity.
4. A separately discharged reserve lowers the accounting margin
   without touching the physical register or the durable floor.
   Given **independent evidence for all subsequent external effects**,
   IR-61's guarded trace theorem continues to apply.
5. When a source-level fresh token is at the head of the physical
   queue, is acceptable at the final-generation floor, and has positive
   effect within the prospectively checked margin, IR-63 proves a
   concrete increase in the inherited actuator's landed register.
   This is a one-step modeled service witness, **not eventual delivery**
   under all scheduling/fairness assumptions.
6. **Hostile control**: releasing reserve without knowing whether a
   later bypass can occur permits an unsafe bypass. Formal decrease
   in a bookkeeping number alone is not a physical assurance.

## What is and is not established

A positive service assertion needs both physical authority and enough
guaranteed available capacity. IR-61 supplies a safety restriction.
IR-63 adds an explicit conditional service implication and a
counterexample to unconditional service.

Still **OPEN**: a physically justified discharge certificate for an
unneeded reserve; an independently measured future environment/fault
envelope; scheduler fairness, finite time and real physical delivery;
continued individual freedoms, historical continuation and original X3.

Nothing is merged or published. This branch extends IR-62 and leaves
the canonical work untouched.
