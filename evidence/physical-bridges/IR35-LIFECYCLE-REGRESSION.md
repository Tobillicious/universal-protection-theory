# IR-31–IR-34 — Independent actuator/recovery regression suite

The bounded Python oracle (lifecycle_checks.py) separately simulates
closed actuator admissions, in-flight and pending work, physical
delivery and held-epoch crash recovery.

- Enumerates thousands of short interleavings after a complete barrier
  and verifies no landing and no new accepted work.
- Enumerates restart, hold and delivery sequences with obsolete queued
  generation tokens, checking live/durable floors stay high enough.
- Negative witnesses: queue-only acknowledgement can miss in-flight
  work; an empty open queue can accept more work; closing admissions
  does not cancel an already pending effect; volatile-only epoch updates
  fail after restart; final apply-time token checks are required.

The assurance ledger additionally tracks eight new claims:
four **synthetic/formally checked** results and four **physical
obligations still DECLARED**. The validator refuses promotion of those
obligations without relevant evidence metadata.

The Python oracle is supplementary and bounded. Lean proves general
finite-trace theorems *under the modeled transition relation*; neither
method establishes the real-world atomicity, cryptographic
authenticity, physical channel completeness or crash durability.
