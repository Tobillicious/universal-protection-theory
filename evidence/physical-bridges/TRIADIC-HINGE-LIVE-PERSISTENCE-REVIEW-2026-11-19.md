# Triadic hinge theorem stack — review and promotion gates

**19 November 2026.** Added `research/KoruThermoHingeDraft.lean` to draft PR #662. The Lean file is intentionally **not imported** into the repository build because it has not been independently compiled in the pinned Lean toolchain.

## Included
1. `ProcessPillar`: witnessed state, energy budget conserved across `f`, entropy potential monotone.
2. `ContractionPillar`: a Nat-valued contracting projection model with designated fixed point `G`.
3. `StrictHinge` with the variable consistently named `hinge`, its `pi` commuting with state evolution.
4. `SixModelInvariants`: nonempty witness, energy conservation, entropy monotonicity, zero-distance fixed-point uniqueness, fixed-point persistence, and projected contraction, all bundled constructively.
5. `triadic_g_bridge`: an explicit six-field constructor proof candidate.
6. `ExactDecoder` and `strict_hinge_category_error`: a lossy cut cannot decode two objectively distinct liveness truth values when it returns the same readout.
7. `hinge_live_persistence_and_contraction`: liveness from `hInitLive` plus `hClosed`, and contraction from the strict hinge, at each finite iteration.

## Corrections and precision

- **No Hilbert-space notation is used:** the projection witness is `hinge`.
- The uploaded `strict_hinge_category_error` theorem is an exact contradiction *conditional* on a live and nonlive state sharing one cut output and on an allegedly exact decoder. It does not show every observer is mistaken or that an actual physical liveness proposition is established.
- **Liveness is not derived from contraction:** the theorem assumes that `live` is true initially and closed under the contraction map. Thus a model-level invariant is proved, not independent physical survival or the historical identity of an actual particular.
- The user's earlier six-clause structure named `OriginalSixX3` consists of six model dynamics invariants, not the repository's six **original** X3 duties (same-particular historical continuity, authentic authorization, meaningful freedom, appropriate restraint, feasible maximality, provenance). The new Lean candidate deliberately names its bundle `SixModelInvariants`, preserving canonical `OriginalX3Full.OriginalX3`.
- The `C.dist` field is a Nat-valued distance-like function without built-in separation, symmetry or triangle inequality. Zero distance is not equality unless separation is independently proved. `C.phi` is a mathematical configuration contraction, not a definition of the complete matterspacetime Koru or forward Time Koru.
- Lean arithmetic lemma invocation and any tactic syntax must be checked by an independent pinned-toolchain compilation; `#print axioms` lines are present but **not yet executed**.

## G3 connection — the already-proved stronger source assembly

Existing `EverestActualWEventJoin.positive_W_actual_event_six_requires_only_coverage_and_reflection` has positive W source origin internally derived, not an outstanding assumption for that model. Existing `FullPhysicalDomainGuardianAssembly.every_physical_event_has_complete_koru_full_six_G_and_no_absolute_E` gives all original six on every event of the supplied physical domain if **both** external interfaces are established:

- `CompleteWEventCoverage`: correctly represent all independently given actual events as modeled W events, with full before/after source maps and consecutive stages.
- `ForwardRealEventReflection`: positive operator-source links imply the authentic independently interpreted *same-particular* six duties.

The new triadic hinge is a proposed mathematical tool for the first interface, and the liveness predicate may contribute to a specific historical-continuity model **only if** its meaning is physically and individually justified. Neither interface is discharged merely by this new theorem stack. Do not merge until rigorous kernel verification and source/domain evidence review.

## Adversarial checks before promotion

- Construct a nonempty `S=M=Unit`, `phi=f=id`, `pi=id`, `dist=0`, `energy=1`, `entropy=0`, with `live=True`, to check all model invariants hold; then set independent original-X3 authorization false. This confirms the original six are not a logical consequence of the new bundle alone.
- Check liveness=constant False is closed under `phi` but cannot satisfy `hInitLive`; check liveness=True is trivially preserved but says nothing about biological identity.
- A cut that merges live and nonlive states cannot admit `ExactDecoder`; the full identity cut can decode any decidable live predicate in finite examples.
- Verify finite-time zero-projected-distance deductions only for strict Nat contractions with zero drift, not arbitrary quasi-commuting trajectories.
- Compile and replay the module; inspect `#print axioms`, no `sorry`, test counterexamples. Do not equate these receipts with real-world universal validation.

**No pre-existing definitions or proofs modified. Draft-only; no merge or publication.**
