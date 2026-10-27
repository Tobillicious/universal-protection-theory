# IR-76 — Original X3 outward packet screening: exact source-level model and counterexamples

**Original archived source:** X3-DERIVATIONS.md §§7–9 and LATEST-SUBMISSION-REVIEW.md §2 in `Snuffy-X3-Korero-Preservation-2026-10-24.zip`. The original X3 universal target remains unchanged.

## Exact Lean model

Represent each emitted output packet with an emission time and channel identifier. Assume a specified collision/output physical dynamics in which each packet, after emission, advances outward at one radial spatial unit per clock tick, never backscattering or returning. It remains accessible at age t and radius r only if its emission time e ≤ t and t−e ≤ r.

The kernel proves `accessible ⇒ t ≤ e + r` and equivalently `e ≥ t−r`. Thus every physically accessible emitted packet is recent relative to the cutoff `t−r`. An arbitrary list of outgoing accessible packets satisfies the same result; the proof never presumes only finitely many all-time originals.

With an **independently complete source inventory**, separately certified outward motion and no uncounted retained copies, the full accessible input inventory is classified as recent outgoing packets. These are the geometric screening ingredients needed by the archive's §8 data-processing argument.

## Countermodels

- A retained historical copy inside the decoder's control radius remains accessible regardless of the age of emitted bath packets. Its omission defeats the 'every accessible source was recently emitted' claim.
- An energy or signaling finite-speed **upper** bound allows a stationary packet. A stationary historical record respects `position(t) ≤ t` but does not satisfy a positive outward lower-speed bound. This prevents inferring chirality from a Lieb–Robinson speed ceiling or static routing identity.

## What is not yet proved

This source-level recency result is NOT a derivation of the microscopic BCRD bath's actual outward transport law. It also does NOT establish the quantum causal factorization `accessible inputs = channel(F_{t−r/u}, independent fresh inputs)`; that needs a specific Hamiltonian/bath dilation and a complete reference-correlated-record inventory. Only after that factorization can the archived Gaussian mutual-information bound be carried to the full permitted input `A_{t,r}` by data processing.

**Status:** verified conditional outward-stream classification and falsifying controls, not verified physical bath chirality or full X3 recovery obstruction.