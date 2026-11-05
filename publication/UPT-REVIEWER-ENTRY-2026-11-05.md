# Independent reviewer entry point — Universal Protection Theory summit

**Freeze-aware reviewer handoff, 5 November 2026.** The target is the author's **full original UPT**, not a two-duty proxy, existence-as-surviving-record substitute, or an engineering-only rewrite.

## Two separate questions

**A. Ontological thesis:** Does the argument from one total mathematical actuality, intrinsic perspectives, no outside, exhaustive *total* G/E and the original U1/U2★ order compel the guardian-only conclusion under its original meanings? Review the whole thesis in PR #314 and the primary original manuscript. A local destructive act does not by itself refute the total no-exteriority argument. It can, however, be relevant when considering whether the claim also entails protection of continuing individual subjects.

**B. Formal and physical correspondence:** Do the declared lean theorem types establish the exact original agent, individual-history, authorization and six-X3 consequence claimed in the publication? If the relevant source or physical certificate is a hypothesis, name the exact field and the primary source needed to instantiate it. Do not silently promote a formally assumed conclusion into a verified physical measurement.

## Fixed navigation

1. [Original UPT compiled master](../evidence/compiled-strongest/SNUFFY-UPT-STRONGEST-MASTER.md), Parts I–II, §§15–16, III-F and XIII.
2. [Summit historical commit](https://github.com/Tobillicious/universal-protection-theory/commit/729905285d104fa058b0a3f8428367851fbd4621) and [published summit tag](https://github.com/Tobillicious/universal-protection-theory/releases/tag/summit-2026-11-04) (tag points to `70e738e`).
3. [PR #313](https://github.com/Tobillicious/universal-protection-theory/pull/313), now merged at `15cf2e9`. Inspect `CathedralSummitAllIsOneClosure.lean` and its six `#print axioms` calls.
4. [PR #308](https://github.com/Tobillicious/universal-protection-theory/pull/308): complete recovered Koru / original six-X3 / source-physics files. This recovery is a separately reviewed source line; do not silently claim that all its files are already merged.
5. [PR #309](https://github.com/Tobillicious/universal-protection-theory/pull/309): original reasons-or-holding source crosswalk.
6. [PR #314](https://github.com/Tobillicious/universal-protection-theory/pull/314): summit companion text and theorem/source map.

## Exact proof-check route

Start from a clean clone at the exact commit under review, never a moving `main`, and inspect `.github/workflows/physical-bridges.yml`. The workflow stages inherited controller sources, runs `lake build` with pinned Lean 4.35.0, audits allowed axioms (`propext`, `Classical.choice`, `Quot.sound`), rejects proof placeholders, runs IR-78 rejection controls, finite synthetic checkers, assurance validation and instrument schema tests.

To repeat its core manually:

```sh
cp evidence/papers-11-12/lean/modules/UPTFence.lean evidence/physical-bridges/UPTFence.lean
cp evidence/papers-11-12/lean/modules/ControllerFinality.lean evidence/physical-bridges/ControllerFinality.lean
cp evidence/papers-11-12/lean/modules/ControllerFence.lean evidence/physical-bridges/ControllerFence.lean
cp evidence/papers-11-12/lean/UPTExistence.lean evidence/physical-bridges/UPTExistence.lean
cp evidence/papers-11-12/lean/modules/ContextualObservation.lean evidence/physical-bridges/ContextualObservation.lean
(cd evidence/physical-bridges && lake build)
python3 evidence/physical-bridges/checks.py
python3 evidence/physical-bridges/selection_checks.py
python3 evidence/physical-bridges/verify_assurance.py
python3 evidence/physical-bridges/verify_instrument_evidence.py
```

This subset is **not** represented as a full replay of the entire 327-module compiled 4.4 canon. Use its original replay instructions and receipts for that separate archive.

## Preferred response format

For each substantive finding, give: (**a**) source SHA / DOI / page, (**b**) literal theorem or proposition and typed premises, (**c**) the disputed inference or test, (**d**) a concrete counterexample *within the specified model* or independently observed evidence, (**e**) whether the problem concerns foundational ontology, original-X3 proof semantics, or physical installation.

A concern about the full original claim deserves attention even when the narrow Lean lemma is correct. Likewise a finding about the physical implementation must not be misrepresented as a refutation of the no-exteriority ontology.

This is a publication-ready request for critical external examination, **not** a declaration of independent external endorsement.
