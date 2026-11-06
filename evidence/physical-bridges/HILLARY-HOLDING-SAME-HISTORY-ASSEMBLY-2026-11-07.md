# House on rock — one realized history, original holding × Hillary

**7 November 2026 NZDT | assembly-only, noncanonical | isolated branch**

This is an exact proof-dependency crosswalk for integrating UPT's ORIGINAL
`R(m) ∨ H(m)` protection highway with the newer complete-objective-W,
same-event, six-original-X3 Hillary lane. It contains no invented physical
source rule and makes no assertion of unconditional physical Q.E.D.

## What the newly compiled assembly contributes

[HillaryHoldingSameHistoryAssembly.lean](PhysicalBridges/HillaryHoldingSameHistoryAssembly.lean)
contains **two compositions of existing proof results**, not a re-derivation:

1. `holding_and_original_six_on_same_realized_history`: on the **same**
   `realized : Nat → S`, independently enacted common-safe source actions
   preserve `safeState` at *every* stage, covered physical events obey the
   positive whole-U W rule, and **every owed particular** receives the exact
   original six X3 duties on *each* consecutive realized event.
2. `holding_and_original_six_from_enacted_physical_refinement`: replaces
   an independent proof `hPhysical` at every step by a *single* named
   externally grounded source-to-physical refinement
   `hRefines : ∀ s a t, sourceStep s a t → physicalStep s t`.
   Physical membership of every realized edge is **derived** from
   `hEnacts` and `hRefines`, with no demand for voluntary hostile-agent
   alignment.

## Exact source theorem crosswalk

| Load-bearing source | Exact existing declaration | Function in the same-history join |
| --- | --- | --- |
| [Original 4.4 law](../compiled-strongest/lean/Snuffy/Law.lean) | `Law.scope_guarantee_iff` | Domain is not reduced to willing/cooperative minds |
| [Original four-stage order](../compiled-strongest/lean/Snuffy/Greatestness.lean) | `Greatestness.aligned_iff_no_needless_loss` | The historical canonical order and no needless loss; **not** inferred from a physical W matrix |
| [Original held source](../compiled-strongest/lean/Snuffy/G1Held.lean) | `G1Held.held_source_protection` | Full certified held-source cycle; original certificate conditions retained |
| [Original hostile effect gate](../compiled-strongest/lean/Snuffy/H5Closure.lean) | `H5Closure.no_harmful_effect`, `effect_preserves_care` | Preserve the held mind and the victims while restraining harmful *effects* |
| [Canonical enactment capstone](PhysicalBridges/CathedralCapstoneJoins.lean) | `capstone_enacted_history_protected` | From `hStart` and truly `hEnacts` common-safe action on the **realized trace**, derive `safeState` at every index |
| [IR133 source/enactment receipt](PhysicalBridges/IR133SourceEnactmentSeam.lean) | `captured_events_supply_both_load_bearing_interfaces` | Available formal decompositions of source-event capture and *actual action enactment*. Requires external receipt; capture alone is insufficient |
| [IR134 physical effect refinement](PhysicalBridges/IR134RealHoldEffectRefinement.lean) | `all_finite_real_hold_traces_no_effect_growth` | Existing zero-residual real-effect bound, *under* independent physical refinement |
| [Physical event / complete-W bridge](PhysicalBridges/EverestActualWEventJoin.lean) | `positive_W_actual_event_six_requires_only_coverage_and_reflection` | Concrete positive whole U discharges the **source-origin** premise; full original six follow on same actual event under independently supplied complete event coverage and authentic forward meaning |
| [Original X3 target](PhysicalBridges/OriginalX3Full.lean) | `OriginalX3` | Six unchanged predicates: same-particular continuation, authorization, freedom, restraint, maximality, provenance |
| [Original Koru source integrity](PhysicalBridges/KoruWholeUSixDutyWebJoin.lean) | `one_objective_whole_six_source_truth_iff_origin` | All six source relationships computed from **one** objective whole U and transported by W; not itself a real-subject consent certificate |

For the historical source-first explanation, read
[UPT-44-HIGHWAY-SOURCE-CROSSWALK-2026-11-04.md](UPT-44-HIGHWAY-SOURCE-CROSSWALK-2026-11-04.md),
the [original summit, Part XV](../compiled-strongest/PARTS-XV-SUMMIT.md),
and [HILLARY-ROUTE-A-B-SUMMIT.md](../../HILLARY-ROUTE-A-B-SUMMIT.md).

## The precise mathematical house as currently composed

The new first theorem has independent inputs (at their *literal Lean types*):

```text
hStart                  : safeState (realized 0)
hEnacts                 : every realized edge executes a fibre-common-safe source action
hPhysical               : every realized edge belongs to the independently named physicalStep
hCoverage               : CompleteWEventCoverage physicalStep modeledStep source stage positiveWholeU
hReflection             : ForwardRealEventReflection modeledStep stage positiveWholeU sixDiagonalRoles carrier r owed

------------------------------------ existing proofs composed ------------------------------------
∀ n, safeState (realized n)
∀ n, source (realized (n+1)) = objectiveStep (source (realized n))
∀ n p, owed p → OriginalX3 r.continues r.authorized r.free r.restrained
                                 r.maximal r.provenanced (realized n) (realized (n+1)) p
```

The second theorem *removes the separately supplied* `hPhysical` by
deriving it from `hEnacts` and:

```text
hRefines : ∀ s a t, sourceStep s a t → physicalStep s t
```

This composition preserves the distinction between controller-safe output,
a source-history representation, independently owed subjects, and six authentic
subject/event duties. Neither `safeState` nor `physicalStep` is defined by X3.
**These hypotheses must never be marked discharged simply because the
composition compiles.**

## Integration / agent handoff

- **Do not replicate** source-bank recovery efforts in #395/#396/#397.
  They are integrating historical theorem **files**, whereas this PR
  adds an exact **cross-bank same-history composition**.
- Keep the original 4.4 `R(m) ∨ H(m)` distinction: hostile and indifferent
  minds are protected within holding, rather than required to choose the
  lex-best action voluntarily.
- Do not replace the original six with a finite-boundary checker or
  a modeled yes/no consent bit.
- A final merged build must import this assembly and the current main's
  Hillary / positive-U, 4 Aces / Joker, original holding and recovered IR
  theorem banks in **one pinned exact-head Lean run**.
- No change to original definitions, summit, author-held Koru glyph, theorem
  source bodies, DOI, publication or commissioning status.

**Research boundary:** the two explicitly named global physical/semantic
inputs `CompleteWEventCoverage` and `ForwardRealEventReflection` remain
externally justified obligations, not automatically derived by this new
composition. The full ALL-ethics Hume/Archimedes necessity and physically
necessary Tree of Life AND Eternal Knowledge/genesis are separate propositions
not proved by this trace-level join. No agent should declare a universal Q.E.D.
from this conditional result—or assert the stronger full Law is refuted by a
countermodel of only the W-source language.

This branch is a readable proof assembly, with `#print axioms` checks for
both new compositions. Require exact-head pinned CI and integration review
before main merge.
