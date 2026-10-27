# IR-51 — Microstep safety rather than endpoint-only finality

The original IRControllerPhysical theorem is a *physical endpoint*
correspondence conditional on correct log-to-physics mapping. A trace
0→2→0 has both endpoints safely below threshold 1, but an unsafe
intermediate state. The microtrace contract separately requires a
verified effect envelope and pre-event safety margin for **each**
physical transition. A source-level theorem composes the original
certified-hold equality with this new intermediate-state guarantee,
without pretending one premise implies the other.

An independent negative witness shows how a sampled safe state list
can omit an unsafe real event. A finite list also cannot certify a
continuous trajectory absent an independently verified physical
interpolation bound. All channel coverage, sensors, actuator timing,
hidden bypass effects and hardware measurements remain OPEN.

No real-world device or historical/subjective continuation certified.
