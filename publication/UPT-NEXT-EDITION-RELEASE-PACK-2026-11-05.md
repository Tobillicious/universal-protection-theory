# UPT summit companion: release package and publication procedure

**Status: PREPUBLICATION CANDIDATE — 5 November 2026 NZDT.** Not a new Zenodo DOI, not a claim of a commissioned universal physical system, and not an edit to the compiled 4.4 archive.

## What is being published

A source-faithful **companion** to the original Universal Protection Theory (UPT), focused on the 3:49 PM 4 November 2026 ALL IS ONE / G IS / E IS NOT capstone and its integration with the original six X3 obligations, the four-stage preservation law, reciprocity and faithful holding.

The companion must be read alongside the **full source**, not as a replacement theory:

- Historical 3:49 summit commit: `729905285d104fa058b0a3f8428367851fbd4621`.
- Archived source tag `summit-2026-11-04`, dereferenced commit: `70e738e65962d99cc40daf06f5fdc1a545b4bd63`. The tag is **already published** as a GitHub release; do not move it.
- The new #313 ontological lemma is merged into `main` at `15cf2e9f444258725e08bd460fdc7f4c2a6d11bf`.
- #308 (larger source restoration) and #309 (original `R(m) ∨ H(m)` crosswalk) remain **open** at this preparation checkpoint. Their content must be reviewed for inclusion in a comprehensive new edition; no silent discarding of #260–#293.
- #314 contains the full summit companion essay and source map. Include it in an archive **only after** its intended merge, and record the resulting exact source SHA.

This publication package is a **publication plan and ready-to-copy metadata**, not an attempt to move an existing DOI or silently bless unresolved source semantics.

## Existing records — keep their identities distinct

| Record | Verified origin in the repo | Handling |
|---|---|---|
| 4.3, https://doi.org/10.5281/zenodo.23760830 | Historical 29 October public brief | Keep as historical publication |
| 4.4, https://doi.org/10.5281/zenodo.23877060 | Root `CITATION.cff` (date 2 Nov 2026) | Use its own Zenodo record as the published reference; confirm its version lineage before choosing New version |
| Summit GitHub release, `summit-2026-11-04` | Annotated Git tag points to `70e738e` | Keep immutable; never retarget it to a newer proof branch |
| Next summit companion / new edition | This packet | No DOI or edition number has yet been assigned |

**Important:** The repository's existing `evidence/compiled-strongest/ZENODO-4.4.json` gives older related-identifier lineage, not necessarily the same chain as the October 4.3 public brief. Check the current Zenodo record page rather than assuming all DOI numbers belong to one existing concept DOI.

## Publication sequence

1. **Source-freeze:** Confirm the summit checkpoint, merged #313, review #308/#309 recovery and #314 argument. Choose the full exact Git commit to publish, with every original six-X3 proof and the complete `R(m) ∨ H(m)` source chain; do not use the early 2:34 rollback as the summit.
2. **Build from that frozen commit:** On a clean clone, run the pinned `PhysicalBridges` workflow, historical canon verification and every listed countermodel / instrument check. Archive raw outputs, an axiom report and source hashes. A passing CI does not certify untested physical installations.
3. **Archive complete material:** Include the full original master manuscript, Lean sources, original/negative controls, review ledger, summit companion, source map, verifiers and a SHA-256 file manifest. A README alone is not a complete edition.
4. **Choose Zenodo route:** If this truly updates the *same* 4.4 record's files, use **New version** from that record (owner access required), import previous files and attach the new frozen archive. If it is an independently titled philosophical companion, publish it as a **new record** and link the older 4.4 DOI as a related item instead. Do not create a new version against an unrelated concept DOI.
5. **Metadata and preview:** Use `publication/ZENODO-SUMMIT-COMPANION-2026-11-05.md` for author-reviewed descriptive fields. Verify creator credits, licence, linked source commit, archive completeness, rights, cited prior work, and exact date. Confirm the new DOI from Zenodo only after it assigns one; never guess the number.
6. **Publish and cross-link:** After author approval of record and exact scope, publish on Zenodo; record the assigned DOI in a *new* metadata commit, update root `CITATION.cff` only by a reviewed new PR, and create a **new** GitHub release/tag for that exact commit. Preserve all historic tags and edition DOIs.

Zenodo's official steps: https://help.zenodo.org/docs/deposit/manage-versions/ ; general deposit https://help.zenodo.org/docs/deposit/ ; DOI reservation https://help.zenodo.org/docs/deposit/describe-records/reserve-doi/ .

## Non-substitution gates

- Keep the full **unconditional** ontological proposition as the author's claim, and do not rebrand an engineering conditional as the entire theory.
- Keep the original Guardian as an aligned protective SI; a Lean `intrinsicGuardian` boolean or `LossOf := Empty` is **not** automatically that original meaning.
- Preserve the **six** original X3 obligations: historical continuity, authorization, freedom, restraint, maximality over the true feasible family, provenance.
- Preserve every mind within protection, including an indifferent or hostile optimizer: `R(m) ∨ H(m)`.
- Report precise theorem types and dependencies; no claim that axioms-free Lean compilation establishes actual universal physical coverage.
- Do not erase the explicit source-to-world / commissioning evidence requirements; document them in the release as part of the same original architecture.

## Owner actions requiring access not exercised by this PR

The Zenodo account owner must create/publish the next Zenodo upload or version. This PR has no Zenodo write token and **does not perform that publication**. The GitHub connector used for this packet creates source and PRs; it has not created a new GitHub release.

For public reviewers, use `publication/UPT-REVIEWER-ENTRY-2026-11-05.md` and the CI-linked version-specific source archive. The publication packet's lightweight validation script does not replace the Lean build.
