# Cathedral — source-symmetry route to guardian forcing

**3 November 2026 | narrowly scoped draft, no changes to the canon**

## The target and why this is not just another guardian premise

PR #205 established the exact criterion
`ExistsCutGuardian ↔ FibreHasGuard`. PR #206 then derived
`FibreHasGuard` from action-indexed cut-response congruence and
pointwise viable actions, subject to **still-open** physical
factoring/cut-completeness evidence.

The question here is more source-facing:

> Can physical symmetries of BCRD *force* the cut-response
> congruence needed for a common guardian, without assuming
> those response bits equal as an independent premise?

This PR gives a **conditional positive route** plus a **hostile
negative control**. It neither certifies that physical BCRD has these
symmetries nor replaces actual source measurements.

## The new Lean lemma

`PhysicalBridges/CathedralSymmetryForcing.lean` defines an
`ActionFixedSymmetry` on states: a reversible relabelling of
the **whole state space**, preserving the source's actual cut,
protected predicate, action permissions, and every
action-indexed successor relation **for the same action label**.

The crucial difference from merely being a reversible or
covariant BCRD transformation is the fixed-action requirement.
For each action `a`, the same `a` must be physically
interpretable and permitted after the symmetry; no unobserved
action-frame adapter is inferred.

`action_fixed_symmetry_transports_guard` derives safety after
symmetry transformation from the source transition and sector
invariance. Nothing in that lemma silently equates
`allowed` with `protected`: permissions are independently
supplied and can have different values in different
states; the action-fixed invariance is an *explicit* physical
hypothesis to verify.

`CutIsActionFixedOrbit` says that any two protected states
sharing the cut are connected by one of these **genuine
action-fixed** source symmetries.

Then `source_symmetry_orbits_force_fibre_guard` proves:

```text
CutIsActionFixedOrbit
∧ (each protected state has some independently available
   source-robustly-safe action)
──────────────────────────────────────────────────────────────
FibreHasGuard
```

The subsequent `source_symmetry_orbits_force_guardian` composes
with PR #205's iff, giving existence of a cut-only guardian.
That remains a mathematical selector, not an enacted physical
controller or a completed original-X3 protection claim.

## Negative control: symmetry that MOVES actions is insufficient

The same module supplies an exact two-state/two-action countermodel:

- all states have the **same** observation;
- the state swap maps every state to the other;
- each state has a perfectly safe individually allowed action;
- the source step and permission relation are covariant under
  simultaneous state AND action flipping;
- there is nonetheless NO single observation-only action
  allowed at both states, and therefore no guardian.

This rules out a tempting shortcut: **"symmetry ⇒ common
guardian."** The transformation must preserve an invariant
physical action label (or there must be another justified
action-descent/canonical-invariant-action certificate).
State symmetry alone is categorically insufficient.

## The exact source-facing obligations, not to be elided

To invoke this forcing theorem on real BCRD:

1. Specify `S`, `A`, `observe`, `step`, `allowed`
   and the **original X3** predicate without defining them
   to make the result true.
2. Construct actual source symmetries and verify their
   invertibility on the full source sector—not just a toy
   example or a gauge re-description.
3. Verify **fixed-action** permission covariance:
   every physically named action is preserved as the
   *same* action under the symmetry. An action permutation
   is insufficient unless that action frame is separately
   observable and implemented.
4. Verify every actual modeled successor (including possible
   bad outcomes) is carried to a genuine successor, and the
   original protected semantics are source-invariant.
5. Show actual protected cut fibres are entire **orbits** of
   those symmetries, not merely sharing a scalar readout or
   a coincidental measurement.
6. Derive pointwise robust viability for actual allowed
   transitions from physical BCRD structure, not a safety
   policy supplied as a premise.
7. Finally, prove actual physical effects are fully mediated
   by the resulting guardian. This is independent of
   mathematical guardian existence. Also preserve independent
   full-history/agency and original two-priority maximality
   obligations.

These are physical and semantic requirements, **not claimed
to be complete in this PR**. No internal mathematics in
this module establishes a global universal protector.

## Live source clue and limitation

The repository's existing `BCRDIdentityCharge.lean` provides
an exact, frozen M3d source update which is reversible while
the candidate joint-parity charge changes; the file correctly
states that this is **not** evidence that actual original-X3
subject continuity fails. It is evidence against casually
treating generic reversibility or one candidate charge as a
sufficient physical preservation invariant.

Therefore: do not simply pronounce `W\rho W†` reversible and
promote it to continuity of actual subject histories or action
invariance. What is required here is **action-fixed
transformation covariance of the ACTUAL source interventions**,
not merely the existence of a reversible update operator.

## Exact frozen BCRD-source test (new checked adapter)

The module now imports `Oct10SourceHamiltonianProtection.lean`, which records the inherited exact six-state H2 pulse. It defines **one and the same** H2 source relation with the pulse as the sole `Unit` action and the authentic parity observation. Then it proves *both*:

- `h2_parity_cut_has_guardian`: when the protected predicate is *positive parity*, the actual modeled H2 update preserves it, hence a parity-preserving guardian policy exists in that bounded source.
- `h2_site_cut_has_no_guardian` and `h2_site_robust_viability_fails`: when the protected predicate is *local B-site occupation*, the source-supported pulse B0 → C1 breaks it, so even pointwise viability fails and no guardian exists.

The separate `h2_pulse_is_not_site_action_fixed_symmetry` proves the pulse cannot be installed as an `ActionFixedSymmetry` preserving the B-site predicate; this follows from the explicit exact source witness, not a fabricated hypothetical event. `h2_reversible_source_preserves_parity_cut` confirms the same pulse is reversible and preserves the parity readout.

**Interpretation:** BCRD-source reversibility + conserved parity + a cut do **not** automatically force local particular protection. The two guarded predicates are *different properties of the same physical-source model*. This distinguishes invariant sectors from particular continuity and prevents swapping them in the forced theorem. It neither demonstrates an actual subjective injury nor identifies B-site occupation with original X3.

**CI:** all new source-specific theorems kernel-checked in the pinned Lean workflow https://github.com/Tobillicious/universal-protection-theory/actions/runs/41596019113 (SUCCESS on `a2256313ffd127793743db5ca783ea4a55db90e1`).

### Next forcing task, after this bounded sector diagnostic

Extract action-labelled, genuinely source-supported transformations and action frames for the full BCRD sector **with actual original-X3 historical/subject predicates**, then test orbit closure and viability. The H2 parity sector cannot substitute for that missing original-X3 semantics. If an action-fixed orbit construction fails, document the obstruction; do not declare the theorem physical by redefining protection to mean a conserved charge.

## Relation to the foundational mathematics

The structural-identity draft PR #245 remains useful as a
separate source of questions about representation and genuine
individuality. But `SameRole` or gauge-equivalent
representations do NOT license merging distinct subjects or
assuming their safe action sets intersect. Indeed our
moving-action countermodel is an explicit warning against that.

**No new mathematical operator needed for the theorem as stated.**
The proposed koru remains a possible later culturally
reviewed notation; nothing here needs a new glyph.

## Review gates

- Pinned Lean build and kernel axiom audit.
- Verify that the allowed/step/protected/source-cut hypotheses
  are independent of the guardian conclusion.
- Reproduce the two-state moving-action obstruction.
- Seek a *source-constructed* `ActionFixedSymmetry` and orbit
  cover for a genuine BCRD sector. If none is justified,
  report that route as blocked rather than changing X3 or
  claiming forcing by analogy.
- Do NOT merge, change the canonical manuscript, publish,
  or promote physical claims without a separate review decision.
