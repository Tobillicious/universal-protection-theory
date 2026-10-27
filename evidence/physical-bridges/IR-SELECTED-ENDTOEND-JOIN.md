# Selected-policy end-to-end source-level join

## Purpose
This branch integrates IR-17's `NoExcludedImprover` into the actual
end-to-end composition originally presented in IR-10, instead of leaving
IR-17 as an unconnected logical lemma.

## Improvement over IR-10
IR-10 requires both:
- that every excluded full-feasible outcome be strictly beaten by some
  safe-menu outcome (global safe-menu cofinality); and
- a viable realising observation-uniform policy for **every** menu outcome.

This theorem instead takes one specifically **selected** safe-menu maximum
and one specifically supplied viable observation-only policy. It proves
full original-UPT maximality of that same chosen outcome and composes
the original held-window equality, greatest model-relative viability,
finite-step concrete/record observable correspondence, and post-effect
safety bounds. It needs **no full-menu cofinality** and **no implementation
policy for every unchosen menu item**.

## Remaining substantive conditions
- The selected outcome must exclude all strict improvements from outside
  the safe menu under the original full UPT feasibility order.
- A real viable observation-uniform policy realising that particular
  outcome must be furnished.
- The IR-10 log/physical correspondence, observation/record simulation,
  sensor, intervention, drift and event coverage assumptions remain.
- A model-relative invariant does not prove an installed instrument's
  physical completeness or a person's subjective continuity.
- None of this changes X3, alters the UPT stage order, or proves universal
  adoption or application in the physical world.

## Review
Check with the pinned Lean workflow and inspect the
`#print axioms selected_end_to_end_certificate` output.
Use independent hostile review before merge or any canonical publication.
