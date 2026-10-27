# Finite retention-profile feasibility audit

## Status
Draft source-level repair independent source-level audit, integrated against the mainline physical-bridge track. No change to X3 or the original feasible family.

## Problem
IR-17's `NoExcludedImprover` was still assumed: a safe-menu maximum
could be beaten by an omitted original full-feasible outcome. Simply
renaming that assumption to "safety" is not an adequate repair.

## Certificate
`IRProfileAudit.audited_no_excluded_improver` DERIVES the previously
assumed condition from three independently reviewable obligations:

1. **Coverage**: every original full-feasible outcome maps to one of a
   finite list of retention profiles. No requirement that the outcomes
   themselves be finite, or that the profiles be physically safe.
2. **Faithfulness**: for every original priority stage and every
   protected particular, a feasible outcome and its representative
   profile agree on retention. This must be proved for the actual
   outcome interpretation, not asserted based on an incomplete sensor.
3. **Obstruction witness**: for every listed profile, either exhibit a
   particular kept by the selected outcome and lost by that profile at
   the *first differing priority stage*, or prove stagewise equality and
   continue to the next original stage. Exhausting all stages without a
   witness establishes non-improvement as well.

The proof converts any alleged full-feasible improving outcome into an
improving faithful profile, then contradicts its corresponding
obstruction witness. It uses the **unchanged** source-level
`UPTExist.LexBetter`, not a weakened or safety-filtered comparator.

`audited_selected_global_maximal` then joins the derived exclusion
certificate to the real IR-17 source theorem. PR #20's selected
end-to-end theorem can take that result via the same original interface.

## Nonvacuity and hostile controls

The `InfiniteExample` makes original feasible outcomes of type
`Bool × Nat` and includes every one; it keeps only one selected outcome
in the safety menu. A **two-profile** audit suffices because the
unbounded natural-number component does not change either retention
profile. An excluded incomparable maximum is not falsely required to
be dominated or placed on the safe menu.

Negative controls demonstrate independent necessity of coverage and
profile faithfulness. In a second `Bool` example, an omitted outcome
actually strictly improves the selected outcome. A dishonest abstraction
maps it to the selected non-improving profile. This abstraction passes
profile enumeration and obstruction but **fails faithfulness**.
Separately, omitting an actual feasible profile fails coverage.

## Exactness and falsification

The second proof pass establishes `obstruction_iff_not_better`: by the
original `UPTExist.LexBetter` definition, the stagewise obstruction
certificate is **logically equivalent** to lack of strict improvement.
The reverse direction uses ordinary classical logic to obtain a
particular witnessing an absent retention. The audit does not change
the preorder or silently impose a stronger maximality criterion.

`alleged_improver_exposes_bad_audit` proves a useful reviewer diagnostic:
if someone exhibits a genuine strict improver despite all listed
profile-obstruction certificates passing, then either its profile was
left out of the finite list or some stagewise retention fact differs
between the actual outcome and the representative. The proof identifies
a formal disjunction; deriving a concrete physical missing channel or
historical identity witness still requires the semantics of the real
instrument.

## What remains unproved

- A finite, genuinely complete profile abstraction for the real
  physical/instrument-defined feasible outcome space.
- A semantic proof that its profiles faithfully track every original
  stage's *actual* living histories/particulars, including identities
  and freedoms; observations alone do not establish that.
- Source-to-plant observation, all causal channels, calibration,
  latency, continuous-time and physical effect bounds already listed
  in IR-10, IR-15, and PR #20.
- A realizable selected observation-uniform policy for any actual
  installation.
- Universal adoption, subjective continuity, or unconditional physical
  compulsion.

The argument is *conditional*. Enumerating two profiles in a toy
system does NOT demonstrate completeness of a real universe's options.

## Review gates
- [ ] Lean 4.35 build passes and `#print axioms` reports no `sorryAx`
- [ ] Independent line-by-line audit of `Obstructs` vs original `LexBetter`
- [ ] Independent audit of the bad-abstraction hostile control
- [ ] Require concrete coverage/faithfulness witnesses before using a
      profile certificate to claim original full-feasible maximality
      of a real physical choice

Do not merge or canonize without author/independent review.
