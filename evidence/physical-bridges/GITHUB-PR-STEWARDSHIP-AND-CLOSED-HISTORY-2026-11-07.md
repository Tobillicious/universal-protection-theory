# UPT GitHub Stewardship — PR Inventory, Historical Recovery, and Evidence Gates

**Snapshot: 7 November 2026 NZDT.** This document is a reproducible *dated triage snapshot*, not a real-time status feed. Check GitHub for subsequent PRs and CI status.
**Inspected base:** `main@8ef4b18792a98f5a1b2bc47143c270dde2ef5333`.
**Purpose:** prevent multiple agents from losing original theorem meaning, duplicating integrated blobs, silently replacing all-six X3 with a proxy, or claiming a physical Q.E.D. from a conditional/model-only theorem.

## 1. Inventory snapshot and priority

Retrieved GitHub Pulls REST endpoint with `state=open` pages 1–3 and `state=closed` pages 1–3, each `per_page=100`, on 7 November 2026:

| Disposition | Number | Interpretation |
| --- | ---: | --- |
| Open PRs | **186** | Most are draft, including long stacked research chains. An open draft is not worthless or automatically ready. |
| Merged PRs | **154** | Merger is source-integration evidence, not unconditional physical proof. |
| Closed without merging | **46** | Requires path/blob/theorem recovery review; do not treat as deleted or necessarily rejected. |
| Historical PRs included in this snapshot | **386** | Status can change after snapshot. |

**Source of truth for current status:** [open PRs](https://github.com/Tobillicious/universal-protection-theory/pulls?q=is%3Apr+is%3Aopen), [closed-unmerged PRs](https://github.com/Tobillicious/universal-protection-theory/pulls?q=is%3Apr+is%3Aclosed+-is%3Amerged), [merged PRs](https://github.com/Tobillicious/universal-protection-theory/pulls?q=is%3Apr+is%3Amerged), and the pinned check runs on each **exact PR head**.

## 2. Restored historical proof sources: first recovery batch

The following **four exact historical content blobs** were absent under their original paths on the inspected `main`. This recovery branch copies their **byte-for-byte identical Git blob content**, preserving historical source and namespaces. The build-root imports are additive.

| Closed original PR | Source file `evidence/physical-bridges/PhysicalBridges/` | Exact historical Git blob SHA | Mathematical contribution; scope |
| --- | --- | --- | --- |
| [#295](https://github.com/Tobillicious/universal-protection-theory/pull/295) | `BCRDCoherenceFibre.lean` | `8b4835fed7b3da09d7f0bd0343c6b248ce40760e` | Complex M3d populations collide while phase/density coherence distinguishes modeled source origins. No authentic-subject decoder claimed. |
| [#296](https://github.com/Tobillicious/universal-protection-theory/pull/296) | `BCRDThreePopulationKey.lean` | `72406ae5e3eccc259c5686fcb786c90a236e26b3` | Three modeled stage-population scalars identify source origins; independent measurement/execution correspondence remains unproved. |
| [#296](https://github.com/Tobillicious/universal-protection-theory/pull/296) | `BCRDPopulationMeasurementGranularity.lean` | `15f6787b730a637f889ce3200b582351504b8e70` | Demonstrates destructive fine dephasing and an exact single-shot decoder obstruction; source-level, not experimental certification. |
| [#302](https://github.com/Tobillicious/universal-protection-theory/pull/302) | `SummitUniversalParticularScope.lean` | `cff8caf40b8befa74287ed5acfaf76c87a7df446` | Historical all-owed six-X3 quantifier repair plus a selected-person two-particular countermodel. The all-owed *positive* theorem has a later counterpart on `main`; preserve the original source and negative control as historical evidence. |

Original heads: #295 `325cda6aa0ab4adc0b07fec016b5940be23e6e8d`; #296 `dabf0c59bf03d3e759f9826a4b8988df24279623`; #302 `d7b0066b89a16c64923225b28e154a876793be3a`.

**Exact check performed:** each newly fetched recovery-branch file reports the same Git blob SHA as the historical PR head. The files retain their own explicit restrictions. Before merging this integration, require its **own exact-head pinned Lean CI**, no `sorryAx`, source-identity review, and the source-to-subject claim boundary above. Do not reopen a historical stacked PR merely to copy a file already checked into the recovery branch.

## 3. Earlier closed sources already represented on main

Do not recreate historical `#298`, `#299`, and `#300` from scratch. Their named source modules **already exist** on `main`:

- `PhysicalBridges/AllIsDynamicRelationalTransport.lean` — independent relational microstep transport.
- `PhysicalBridges/AllIsWithinEventHistory.lean` — no first loss within EVERY represented microstep, not just equal endpoints.
- `PhysicalBridges/AllIsForwardPersistence.lean` — one-way persistence investigation.

The later `PhysicalBridges/UniversalOwedOriginalX3.lean` also already addresses every owed particular rather than a selected one; the #302 source remains useful specifically for exact historical provenance and its separate selected-particular countermodel. Presence of a named module is not automatically proof that **every** historical theorem or old blob is included; compare definitions and blob SHA before making that claim.

### Other closed-unmerged candidates (not yet cleared)

- [#297](https://github.com/Tobillicious/universal-protection-theory/pull/297) — historical hostile-review changes to six already-existing source modules; inspect change-by-change, **do not wholesale overwrite `main`**.
- [#301](https://github.com/Tobillicious/universal-protection-theory/pull/301) — historical source/summit claim fences; compare its two changed sources with present versions.
- [#303](https://github.com/Tobillicious/universal-protection-theory/pull/303) and [#304](https://github.com/Tobillicious/universal-protection-theory/pull/304) — historical checkpoint/rollback branches; **never merge/reopen as a wholesale tree replacement** without separate author approval and exact impact review.
### Exact-restored closed IR proof sources — audit completed

**Git blob comparison verified six identical historical and current-main source files. No reopening or restore commit required for these files.** Matching exact blob automatically includes every theorem and negative control in that file; it is stronger than title similarity.

| Closed source PR | Exact historical source(s) already on `main` | Identical Git blob SHA |
| --- | --- | --- |
| [#115](https://github.com/Tobillicious/universal-protection-theory/pull/115) | `IR102SectorSemanticBridge.lean` | `4ff9b913e0f228caa6df51802803e38b3422ef32` |
| [#120](https://github.com/Tobillicious/universal-protection-theory/pull/120) | `IR107ReversibleCoercion.lean` | `60586bb44441bf78424e3def8df1dfdcebd41bd5` |
| [#128](https://github.com/Tobillicious/universal-protection-theory/pull/128) | `IR113ObservationClassSelection.lean` and `IR114RecoveryInventoryGap.lean` | `019601019ba4b9119ca5f247bfd76d4e1a706842`, `0e1aa16f3ec2593b0dc89d52f76248bc172c8c88` |
| [#149](https://github.com/Tobillicious/universal-protection-theory/pull/149) | `IR129BoundaryInvisibleKernel.lean` | `210710cc4c052fde0b4b8c2bed64ad3af66505d4` |
| [#151](https://github.com/Tobillicious/universal-protection-theory/pull/151) | `IR130SectorInputDetectability.lean` | `60ac197b84bf69fd69667b4ddc7f3346b58df21f` |

Those are exact matches for the identified Lean files, **not** a complete comparison of every ancillary PR document or root import. Their closure status should not be interpreted as loss of these proof sources.
- The older closed stacked IR-2–IR-30 chains require similar theorem-level comparison; no automatic deletion, re-open, or claim of full restoration.

Each closed PR needs one of **exact-restored**, **equivalent-with-proof-map**, **unique-recover-needed**, **requires-author decision**, or **historical-only** with a citation and an exact current source path. Do not classify as superseded from title similarity alone.

## 4. Active independent lanes: do not merge by title

| Lane | PRs, status at audit | GitHub coordination decision |
| --- | --- | --- |
| Historical summit/Hillary source–subject integration | [#389](https://github.com/Tobillicious/universal-protection-theory/pull/389), draft | Integrates exact file blobs from [#372](https://github.com/Tobillicious/universal-protection-theory/pull/372), [#377](https://github.com/Tobillicious/universal-protection-theory/pull/377), [#379](https://github.com/Tobillicious/universal-protection-theory/pull/379) atop [merged #388](https://github.com/Tobillicious/universal-protection-theory/pull/388); pinned run passed at head `bc727d603dae2ba1c50a86ae1d964cef2018bbab`. Holds its own explicit **draft/author-review gate**. It does not certify full physical subject semantics. |
| Author-held Four Aces / Joker | [#387](https://github.com/Tobillicious/universal-protection-theory/pull/387), draft; [#375](https://github.com/Tobillicious/universal-protection-theory/pull/375), [#381–#385](https://github.com/Tobillicious/universal-protection-theory/pulls?q=is%3Apr+is%3Aopen+Joker) | Independent conceptual/cosmological branch; do not promote hypothetical universe succession, theological interpretation, or genesis feedback to experimentally proven physics. Preserve author’s scope and manuscript approval. |
| Law publication and readings | [#360](https://github.com/Tobillicious/universal-protection-theory/pull/360) through [#363](https://github.com/Tobillicious/universal-protection-theory/pull/363), drafts | Keep review-stage manuscripts and DOI/publication approval separate from Lean source integrations. |
| Complete Koru and original six proved source chain | [#365](https://github.com/Tobillicious/universal-protection-theory/pull/365), [#367](https://github.com/Tobillicious/universal-protection-theory/pull/367), [#369](https://github.com/Tobillicious/universal-protection-theory/pull/369), [#373](https://github.com/Tobillicious/universal-protection-theory/pull/373), [#376](https://github.com/Tobillicious/universal-protection-theory/pull/376), [#380](https://github.com/Tobillicious/universal-protection-theory/pull/380), [#386](https://github.com/Tobillicious/universal-protection-theory/pull/386), [#388](https://github.com/Tobillicious/universal-protection-theory/pull/388), merged | Existing formal source transport, logical reflection tests and negative controls. **Not** standalone universal physical certification. |
| Sealed model / original UPT lane | [#338](https://github.com/Tobillicious/universal-protection-theory/pull/338), merged | Strong modeled optimiser/cut guarantee conditional on verified sealing, authentic subject interpretation and physical coverage. Preserve all six original X3 duties and hostile-agent standing. |
| Historical summit and original text | [#310](https://github.com/Tobillicious/universal-protection-theory/pull/310), [#311](https://github.com/Tobillicious/universal-protection-theory/pull/311), [#329](https://github.com/Tobillicious/universal-protection-theory/pull/329), merged | Immutable reference/restore chain. Do not erase or replace its original proof meaning with a weaker all-six proxy or a different Koru glyph. |

## 5. Proof-status vocabulary: do not conflate

1. **Historically recorded**: exact original text/commit/PR, irrespective of whether later reviewers agree with the claim.
2. **Kernel-checked**: a named Lean theorem with exact hypotheses on a verified head, including standard axiom prints; CI pass is not empirical physics.
3. **Merged into `main`**: source is integrated and discoverable; check source hashes and imports.
4. **Physical-source model verified**: a finite W, complex M3d or sealed-meter model theorem; specify its domain and every assumption.
5. **Authentic universal UPT**: requires independently demonstrated complete physical coverage, true initial source condition and source-to-authentic-particular duty correspondence (original six for EVERY owed particular). The existing #388 proves only the precise finite-W forward-reflection equivalence under positive origin, not that the reflection holds for actual physics.

No PR comment, label, draft status, title, citation, or manuscript can substitute for the final implication. Positive source conservation never manufactures absent authorization. No universal physical Q.E.D. from conditional theorem names.

## 6. Agent GitHub protocol

- Before creating a new proof, search `main`, historical branch sources, and **closed** PRs by *theorem name*, not just manuscript headings. Check current source contents against historical blob and theorem statements.
- Record each PR's base, head, exact changed paths, root import, head CI, source provenance, dependencies, and **exact theorem hypotheses**.
- Create a fresh additive integration branch for a stale stacked PR; retain original exact blobs when feasible. Preserve historical PRs and checkpoint commits. Never mass-close or force-push.
- For a new merge: inspect changed paths, GitHub mergeability, pinned Lean build, `sorryAx`/axiom audit, independent negative controls, and author/other-agent hold notes. **Never claim merge complete until GitHub verifies it.**
- Keep original six X3 (identity-through-history, authentic authorization, freedom, restraint, maximality over actual feasible alternatives, provenance), same-particular quantification and `R(m) ∨ H(m)` scope; do not silently substitute a controller two-field proxy, local endpoint or recorded consent bit.
- The **first protection-Law Q.E.D.** comes before Four Aces and Joker. A symbolic/philosophical/cosmological reading may add interpretation, not substitute for an independently checked physical forcing theorem.
- Reopening a closed historical PR requires a source-level reason: missing unique content that cannot be recovered more safely on a fresh branch, clean current base/dependencies, and explicit author review for any reset/restoration policy branch.

**Owner-facing reading route:** [THE-LAW-START-HERE.md](../../THE-LAW-START-HERE.md), [HILLARY-ROUTE-A-B-SUMMIT.md](../../HILLARY-ROUTE-A-B-SUMMIT.md), [cross-domain join ledger](COMPLETE-KORU-CROSS-DOMAIN-JOIN-LEDGER-2026-11-07.md). Do not read this coordination document as a new mathematical axiom or publication claim.
