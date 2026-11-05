# Cathedral — protective action descent under moving source symmetries

**3 November 2026 | extension of draft PR #246 | noncanonical and source-conditional**

## What improves on the first forcing theorem?

`CathedralSymmetryForcing.lean` derives a common guardian when every physical action has a fixed label under a family of symmetries transitive on each protected observation cut. That is sufficient but too strong as a general physical requirement: some symmetries properly transform action frames.

The follow-up `PhysicalBridges/CathedralCovariantActionDescent.lean` therefore defines `CovariantSymmetry` where the state relabelling **and** action relabelling are both reversible, permissions and **all** action-labelled transitions are covariant, the observation is preserved, and the *source-defined protected predicate* is invariant.

A covariance `σ` takes a safe action at source state `s` to a safe action at `σ(s)`, but generally its **action label is transformed**. This is not a guarantee of any one guardian available to a cut-only controller.

The *minimal sufficient constructive-looking condition tested here* is `HasFixedSafeOrbitAnchors`. For each nonempty protected observation fibre, a source-specified anchor state has a **robustly safe independently allowed action** `a` such that every protected state `t` in that fibre can be reached from the anchor by a true state/action covariance that maps `a` back to **the same physical action `a`**. Crucially the symmetry may move every other action label.

That is not a recoding of `FibreHasGuard`: it asks for ONE safe action at an anchor plus externally sourced transport symmetries and fixed-action certificates, not direct safety proofs for all other states.

Then the following proof chain is checked:

```
actual action/state covariance of allowed, transition and sector
  + robustly-safe source anchor action
  + action-fixed transport of THAT candidate across every cut state
  -> same action guards every state in the cut
  -> ExistsCutGuardian via pre-existing CathedralCutGuardianCriterion.
```

### Finite positive control

The source has two states and three possible named actions (`none`, `some false`, `some true`). The state flip swaps the latter two action labels but fixes `none`. Every state admits `none` and executing it *actually changes the source state*, demonstrating a non-stalling action. The symmetric source model therefore has a cut guardian **although the action-fixed-all-labels hypothesis from the first theorem fails**.

This is still a finite toy with a trivial protected predicate, not an actual source or real X3 guarantee; "non-stalling" does not by itself certify freedom or subjective continuity.

### Finite negative control

The original two-state/two-action hidden-cut source has each state individually safe and full simultaneous state/action covariance, but no invariant candidate action spanning the cut. The new theorem correctly fails to apply, and there is no cut guardian. This is a strict safeguard against silently inferring protection from source symmetry in the wrong action frame.

## Exact BCRD six-state source: symmetry is NOT NECESSARY

The inherited six-state source `Oct10Source` has H2 pulse transitions and an authentic parity cut. Its **positive-parity** sector has a guardian for its *parity predicate*. However the exact H2 pulse **fixes A0** and **moves B0** (B0 → C1), and these are both in the same positive-parity observational fibre.

Any reversible source covariance of the action-labelled H2 step relation must commute with the H2 pulse. Thus it preserves whether a state is a **fixed point** of that pulse. Consequently no such covariance can send A0 to B0, and no collection of such covariances can give orbit coverage of this entire parity fibre.

Lean proves:

- `h2_step_is_pulse`: determinism of the exact source relation;
- `h2_step_covariance_commutes_with_pulse`: any valid covariance commutes with source H2, not by assumption;
- `h2_covariance_preserves_pulse_fixed`: dynamical fixed-point distinction is invariant under all source covariances;
- `h2_parity_guardian_does_not_require_orbit_descent`: positive parity guardian exists but `HasFixedSafeOrbitAnchors` is FALSE for this same source.

This matters: our action-descent criterion is **a sufficient forcing route, not an iff, and not a physically necessary condition for even a weak source-sector guardian**.

It would be particularly mistaken to assert that the real BCRD source is necessarily orbit-homogeneous merely because two points have equal parity or because the theory is mathematically relational.

## Open physical obligations and decision gate

1. Independently identify BCRD physical state, action frame, intervention availability, and all admitted successors. A mere basis relabelling or one conserved charge cannot supply this.
2. **Derive**, rather than stipulate, either a physically invariant safe action on each relevant protected fibre, a non-symmetry physical forcing mechanism, or a valid refinement with an independent sensor/effect contract.
3. Maintain the original X3 subject/history/authorization semantics. The bare local B-site occupancy and the conserved parity predicate are **not** original X3.
4. Establish actual effects are obligatorily mediated by the physically implemented policy, with physical no-bypass, crash/hold and authenticated actuator evidence.
5. Distinguish "guardian exists" and "some option can move" from long-horizon continuation, consent, two-way agency, and original two-priority X3 maximality. These are not automatic.
6. Review against the other models' open PR #206 (response factorization), #227 (real-event joins) and #229 (source-enactment). Do not unilaterally merge or modify them.

**Status:** pinned Lean CI PASS for all claims in the new module, including both finite examples and the exact six-state source no-go. No independent physical confirmation, no full X3 forcing, no publication/canon change.

The noncanonical foundational PR #245 stays separate. GLM is independently reviewing the argument; do not attribute unprovided results to GLM.

## Decision

The source H2 test establishes a real limitation of our symmetry route: even a true source-sector guardian can exist without orbit symmetry. We should not spend the whole UPT programme attempting to force BCRD into symmetry-orbit transitivity.

Prioritise: actual original-X3 source semantics, enacted mediation and a demonstrable universally common safe action (through any justifiable physical route), or precisely state which assumption/counterexample blocks it.
