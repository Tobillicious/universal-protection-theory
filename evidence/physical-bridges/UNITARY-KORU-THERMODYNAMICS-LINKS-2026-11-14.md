# Unitary whole, Complete Koru and thermodynamics — source links

This note accompanies `PhysicalBridges.UnitaryWholeReducedObserver` in draft PR #443. It links existing results; it does not assert a new thermodynamic or black-hole theorem.

## Mathematical bridge

* `reversible_whole_is_injective`: a left-invertible closed-system map retains distinguishability.
* `perfect_recovery_implies_injective` and `noninjective_no_perfect_decoder`: exact decoding requires distinct complete histories to have distinct records.
* `injective_has_image_decoder`: injectivity suffices for decoding on the range of attainable records, not necessarily for a decoder on all possible records.
* `reversible_whole_can_have_noninjective_projection`: the identity evolution of a two-bit whole is reversible while projection onto the first bit loses the second bit.

## Koru connections

* [Koru complete-equation obstruction](PhysicalBridges/KoruCompleteEquationObstruction.lean): equal answer projections need not preserve operator/operand distinctions.
* [Koru objective whole](PhysicalBridges/KoruObjectiveWholeU.lean): local views do not determine all whole-source distinctions.
* [Koru operator-history provenance](PhysicalBridges/KoruOperatorHistoryProvenance.lean): a terminal result need not identify its complete operator history.
* [Koru recoverable noncollapse](PhysicalBridges/KoruRecoverableNoncollapse.lean): source-specific recoverability conditions.

The Koru is the proposed whole relational physical node/correspondence, **not** a unary map or the mathematical variable for the abstract evolution function above. A complete physical Koru account must distinguish intrinsic relational facts from an observer's coarse-grained projection.

## Thermodynamics and quantum information

* [Thermodynamic ledger](../compiled-strongest/lean/Snuffy/ThermoLedger.lean): conditional first-law/entropy/correlation bookkeeping.
* [Quantum Landauer](../compiled-strongest/lean/Snuffy/QuantumLandauer.lean): quantum thermodynamic accounting under specified state, bath, and unitary hypotheses.
* [Complete Koru cross-domain join ledger](COMPLETE-KORU-CROSS-DOMAIN-JOIN-LEDGER-2026-11-07.md): distinguishes First Koru/spacetime from Complete Koru/matterspacetime and identifies remaining physical joins.
* [Four aces objective whole](FOUR-ACES-OBJECTIVE-WHOLE-2026-11-07.md): broader research context.

**Crucial distinctions:** Unitary evolution preserves the full quantum state; tracing out inaccessible degrees of freedom can discard locally recoverable information. Thermodynamic entropy increase, observational coarse-graining, physical loss of a particular, and destruction of a relational history are not interchangeable propositions. This abstract Lean module does not prove the black-hole information paradox is resolved, or that Hawking radiation consists of released Korus. To assert the latter, construct a physical radiation channel and test its injectivity/correlations against semiclassical and quantum-gravity constraints.

## Verification

The module is imported by `PhysicalBridges.lean` on this draft branch so the existing physical-bridge build can check it. Report kernel certification only after the corresponding workflow succeeds.
