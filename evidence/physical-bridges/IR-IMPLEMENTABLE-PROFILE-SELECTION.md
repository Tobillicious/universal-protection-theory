# Selecting an implementable original global maximum

`PhysicalBridges.IRImplementableProfileSelection` continues the finite
retention-profile selection construction with the implementation seam kept
explicit. An arbitrary maximal tie can be unimplementable. Selecting the best
implementable option alone can also produce an option dominated in the
original full feasible family. The new search handles both cases.

## Exact criterion and construction

Keep the original `UPTExist.LexBetter` keys, protected particular type and
full feasible predicate. Supply a complete, exactly faithful finite cover by
actually feasible representatives. The original particular and outcome types
may both be infinite. This is a sufficient finite-profile route, not a claim
that original maximality generally requires finite profiles.

For the criterion's completeness, implementation must be invariant under the
exact full retention profile on feasible outcomes. Then
`implementable_global_maximal_iff_finite_audit` proves:

```text
some original full-feasible globally maximal outcome is implementable
  iff
some listed representative is implementable and no listed representative
strictly improves it in the original comparator.
```

`comparison_iff_of_same_retentions` transports **both** comparator arguments.
It therefore carries maximality from an original outcome to its faithful
representative as well as transporting alleged improving competitors.

`passesAudit` checks a candidate against every representative, including
unimplementable competitors. `findImplementableMax` returns the first candidate
that is both globally profile-maximal and implementable. The only decision
procedures supplied to this finite algorithm are those for the original
comparator and the implementation predicate.

`found_is_implementable_global_maximal` proves soundness for the actual returned
candidate. It does not require implementation invariance, because the selected
candidate's own implementation witness has already passed.
`search_none_iff_no_implementable_global_maximal` proves completeness under the
invariance interface. `search_success_iff_implementable_global_maximal` returns
the actual selected full-feasible maximal implementation exactly when one
exists.

No `NoExcludedImprover`, preselected obstruction certificates, all-menu
implementation premise, greatest/top outcome, or enumeration of all original
particulars/outcomes is assumed. An empty representative family is handled by
the criterion itself; nonemptiness is needed only when a positive existence
witness is asserted.

## Checked negative controls

1. **An unimplementable maximal tie.** In the four-stage Boolean example,
   both choices preserve life and grant different incomparable freedoms.
   The earlier arbitrary selector chooses the unimplementable peer. The new
   search returns the implementable peer without removing its competitor.
2. **A globally dominated implementable choice.** The only implementable
   choice has strictly fewer original freedoms than an unimplementable
   full-feasible competitor. The search returns `none`. It does not replace
   original global maximality with maximality inside the implementable subset.
3. **Implementation-relevant metadata lost by profiles.** A complete feasible
   retention cover can omit implementation information. The example contains
   an implementable original maximum while its representative cannot be
   implemented. This proves why the completeness theorem needs implementation
   invariance, or a refined profile carrying the relevant distinctions.

An application must derive that implementation interface for the actual
source-defined policy-realisation relation. Neither exact retention alone nor
the word "implementable" supplies an actuator, an observation-uniform policy,
timely service, resources, or the full historical correspondence. Those remain
the same original implementation task.

## Verification performed

Pinned Lean 4.35.0 compilation passed without warnings or errors. Its stdout
contains fifteen intentional standard-axiom probes; all lists are subsets of
`propext` and `Quot.sound`, and several executable controls use no axioms.
Independent `leanchecker` passed with empty output.

From `evidence/physical-bridges/`, with the pinned toolchain on PATH and the
existing imported sources staged:

```sh
lake env lean -o .lake/build/lib/lean/PhysicalBridges/IRImplementableProfileSelection.olean PhysicalBridges/IRImplementableProfileSelection.lean
lake env leanchecker PhysicalBridges.IRImplementableProfileSelection
```

These are mathematical proofs and synthetic controls, with no new physical
measurement or historical-subject identity validation claimed.
