# Corrections before final sealing

The original GLM checker returned exit0, while the independent audit rejected its full claimed
derivation. Those are different outcomes and both are retained.

Two draft wording/numerical-display errors were caught before the final paired integration run:

- The 60/k15 seed has 344 exiles per surviving island and eight total residents per live compute
  host. An initial draft called the eight residents exiles; this was corrected.
- The adjacent baseline's interconnect activity was initially carried over as a rounded display
  23.24283448088736. The candidate now uses the frozen exact result's floored display
  23.2428344808873598.

The first independent arithmetic/field/enumeration run and the first paired replay completed
successfully. The final paired replay rebuilds the corrected candidate, and the relocated replay
uses those same bytes. No correction was made to any frozen input or predecessor.
