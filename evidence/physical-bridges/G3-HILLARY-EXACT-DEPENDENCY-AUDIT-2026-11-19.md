# G3 Hillary Step — exact-source dependency and thermodynamics bridge investigation

**19 November 2026. Independent source inspection; additive research note to draft #662. No changes to existing formal files.**

## 1. The strongest already-existing endpoint

Inspected exact source file:
`evidence/physical-bridges/PhysicalBridges/HillaryRouteABSummit.lean`

Theorem `hillary_route_b_meets_original_route_a` already returns, under separately named premises,

```lean
(∀ s t p, physical s t → owed s t p → OriginalSixAt r s t p) ∧
¬ FirstOriginalViolation physical owed r ∧
¬ FirstSixSourceLoss physical d
```

Its inputs, **not proved by the theorem itself**, are
`hPhysical : RespectsCanonicalSource M physical`,
`hSourceInitially : ∀ s t p, physical s t → owed s t p → SourceSixAt s.2 d (roles p)`, and
`hAuthenticReflections : ThreeFirstFailureReflections physical owed r d roles`.

The same module proves `hillary_semantic_keystone_exact_strength`: given `hPhysical` and `hSourceInitially`, authentic three-first-failure reflections are equivalent to all-six original X3 protection. **Therefore merely postulating `hAuthenticReflections` does not solve G3; it needs independently grounded physical/subject evidence.**

## 2. Independently inspected source modules

- `IntrinsicSixSourceForcing.lean`: `source_six_preserved_by_whole_relation` carries six *already-true* intrinsic reports under relational automorphism; `source_preservation_forces_six_x3_for_every_owed` requires independent `hInitially` and `SourceSixReflections`.
- `KoruWholeUSixDutyWebJoin.lean`: `one_objective_whole_six_source_truth_iff_origin`, `all_owed_whole_U_six_source_truth_iff_origin`, `no_first_whole_U_six_source_profile_loss`. The module constructs `actual_whole_Koru_and_absent_source_authorization_coexist`: preserved full source structure with a negative authorization-style link.
- `TotalEOriginalX3Bridge.lean`: `six_original_x3_iff_total_E_bridge` makes the total-E reflection equivalent to the full six-duty claim; it cannot be assumed independently as a shortcut. `cyclic_reversible_world_does_not_force_full_x3` provides a reversible source model with false consent and no absolute E.

**Concrete conclusion:** Neither complete source retention, injective transport, thermodynamic balance, nor reversible evolution alone supplies original X3 authorization. This is a mathematical separation, not a physical assertion that unauthorized universal events necessarily occur.

## 3. The exact matterspacetime hypothesis to test

Introduce a candidate independently physically motivated *evolution* (not a replacement definition of Complete Koru):

```text
ActualMatterspacetimeState
  → specified evolution and authentic physical-event observation
  → faithful correspondence to the source W events
```

Required proof tasks:

- **T1 Actual dynamics to source:** derive `RespectsCanonicalSource M physical` from a separately specified physically adequate model with actual-state adequacy and calibrated observables. GR `∇_μ T^{μν}=0` and entropy production cannot individually imply W correspondence.
- **T2 Positive initial source truths:** derive `SourceSixAt` for the *same actual events and owed particulars* from physical relational and subject evidence, not from a convention that defines all admitted events to be protective. An automorphism preserves falsehood as well as truth.
- **T3 Authentic reflections:** derive `ThreeFirstFailureReflections` from independently justified same-particular continuance, agency, consent, restraint and provenance semantics. Avoid disguising the original protection conclusion as the premise.
- **T4 Generality:** show the correspondence applies to every actual event and affected owed particular in intended physical U; demonstrate non-vacuity of the actual and owed domains and handle non-classical and horizon cases.
- **T5 Independence and replay:** exact checked Lean theorem dependencies, `#print axioms`, countermodels, Isabelle/HOL independent reconstruction, empirical validation and tests against observational constraints.

## 4. Countermodel-guided path

The existing asymmetric-source-authorization witness and reversible-consent counterexample are *valuable exact negative controls*. Any thermodynamic strengthening that claims `T1+T2+T3` must explain why its genuinely additional, independent physically established premises exclude both controls, rather than weaken the original X3 meaning or redefine physical admissibility.

A targeted new theorem candidate **conditional only on independently evidenced matterspacetime bridge fields** may compose to the Hillary theorem, but is not an unconditional result until those fields are constructed and verified from actual physics. Prefer to strengthen the *derivation of those fields*, not write another wrapper theorem assuming them.

## 5. Outcome

The shortest existing G3 route is already:
`HillaryRouteABSummit.hillary_route_b_meets_original_route_a`.
The immediate open problem is not another all-six composition proof. It is real physical-source coverage, positive initial conditions, and authentic semantic forcing that avoid circularity. Complete-Koru matterspacetime thermodynamics is proposed as one place to investigate **T1** and preservation; it does not independently establish T2/T3.

**Review only. No claim of new Lean compilation or universal physical G3 proof. No merge.**
