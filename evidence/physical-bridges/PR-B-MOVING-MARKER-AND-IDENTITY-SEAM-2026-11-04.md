# PR B phase 3 — a label must not collapse the particular it claims to preserve

**4 November 2026 · source-frozen test, not a physical subject certificate.** Applies to the exact six-position M0↔M1 swap from `FrozenBCRDEvents.permutation`, read alongside Hilzy's stacked [#287](https://github.com/Tobillicious/universal-protection-theory/pull/287) and PR A [#286](https://github.com/Tobillicious/universal-protection-theory/pull/286).

## Precise issue with a *static* identity carrier

#287 proves that if a structural label assigns the same value to positions 2 and 3, the frozen swap preserves that label. This is correct. But such a label is then **not injective on the six distinct basis positions**: it cannot, on its own, recover which of those positions carried a purported particular.

The new `BCRDTransportedParticularMarker.lean` proves:

- `static_invariance_identifies_swapped_positions`: every static transport-invariant label `c` has `c 2 = c 3`.
- `no_static_invariant_injective_position_code`: therefore no such label can distinguish **all six** positions.
- `no_exact_position_decoder_from_static_orbit_label`: by IR132, no exact decoder can recover the original position from the static label alone.
- `physical_site_is_static_invariant`: independent site L/M/R satisfies this structural invariance but, for that reason, also cannot identify M0 separately from M1.

This does **not** say two conscious subjects are present at M0/M1. It establishes a constraint on the physical labels *before* anyone may argue one-to-one subject identification.

## Positive replacement: follow the moving marker

Define `transportedCode c j = c (permutation j)`. Then:

- `code_is_carried_to_the_transport`: a label initially attached to position `i` is read at `permutation i` following the actual event.
- `transported_code_preserves_injectivity`: if the original source position codes are distinct, transporting them preserves distinctness.
- `dynamic_position_code_has_exact_decoder`: a correct inverse physical-position decoder exists because the frozen source permutation is involutive.
- `marker_history_tracks_original_basis_position`: recursively propagated marker histories still identify the initial source basis position at **every finite step**.
- `all_finite_source_steps_keep_position_codes_injective`: no distinct physical-position markers merge at any finite horizon in this specific repeated-swap source.

This is a positive **causal-tracking candidate** for PR B; it should not be sold as proof of actual subjective continuation. Its correctness as a transported code is an algebraic fact. Its identification with a real particular still needs a noncircular, independently validated semantic map.

## Exact handoff for PR B after source A

A meaningful candidate `Particular` interpretation must answer more than “does a label survive?” The physical position code may change locations while the *referent* remains distinguishable. To establish actual X3.1 continuation, require the source physical event and its complete within-event physical history to warrant that referent's persistence. To establish X3.2 authorization, obtain an authentic subject decision/history not just site membership or generator labels. Real executable future options, restraint, maximality over the full feasible family, and provenance are separately required.

The complementary hostile tests now established in PR B are:

1. A static site/orbit-invariant label may merge physically distinct positions (#287 relationship and new proofs).
2. A dynamically transported position label can avoid that positional merge (new proofs).
3. Even complete before/after matrix observations cannot distinguish hypothetical contradictory original-X3 interpretations absent a justified subject law (`BCRDOperatorSubjectGap`).
4. Every one of original six X3 components is independently required (`ParticularSemanticsAudit`).

**Remaining falsification question:** Find a physical/semantic source law that makes the intended subject/history interpretation *determined*, not simply a free annotation on the frozen matrix. If one cannot be justified, retain the theorem as physical marker persistence only.

Canonical work unchanged. No first-harm or actual-SI claim promoted; branch remains draft for independent review.
