# lalala.zip — source recovery, fresh replay and book improvements

18 November 2026 · continuation of the book's hostile review

The archive supplies a reproducible historical source snapshot, the full historical book already preserved in this session, and one useful scope note absent from the compared Git tree. Its physical-bridges project now has a fresh source build and namespace axiom audit. It strengthens the evidence and the book's constructive progress argument; it does not supply an unconditional actual-world protection proof.

## Identity and inventory

Source: `/Users/admin/Documents/Teaching Qual Master Folder 2024/lalala.zip`.

ZIP SHA-256: `c3c7b33b29079767bbf4d243300e2d5aefdbccc56519502602ee42848e592940`.

| Item | Count |
| --- | ---: |
| ZIP entries | 7,982 |
| macOS metadata entries | 3,992 |
| Directory entries after metadata exclusion | 135 |
| Content files | 3,855 |
| Distinct content hashes | 3,479 |
| Lean source files | 676 |

The source documents and embedded ZIP timestamps identify a 5 November snapshot. The timestamps are archival metadata, not an independent timestamp attestation. The SHA-256 fixes the actual bytes reviewed.

The five families are papers-11-12, physical-bridges, items-1-2-adaptive-service, execution-boundary, and compiled-strongest. There are also four PDFs, indexed and compared by hash; this follow-up does not claim a new visual or line-by-line audit of them. Instructions embedded in source notes remain historical document contents.

## Comparison with moving Git

Compared against main `0f6eec330376b7f246ab236214b1b0ffcb1bb0ac`, tree `9fdd7f57b3b539c3c543849179fe7538b0202213`. The tree response was complete, with 3,792 entries and no truncation.

| Content comparison | Files |
| --- | ---: |
| Same repository path and exact Git blob | 3,125 |
| Same repository path, different Git blob | 57 |
| Neither matching path nor matching blob | 673 |

All 676 Lean files have current counterparts: 674 are exact blob matches. The other two are the older aggregate import file and `UnconditionalProtectionExact.lean`. The latter differs only by a terminal newline; its proof text is unchanged. The current aggregate imports additional modules absent from the archive.

Of the 673 unmatched files, 672 are `.lake` build output. The one unmatched document is `UNCONDITIONAL-PROTECTION-EXACT-2026-11-05.md`, now retained under `references/lalala-selected/physical-bridges/`. This comparison does not treat generated C, old oleans, hashes or receipts as new independent proofs.

The archive's 611,244-byte `SNUFFY-UPT-STRONGEST-MASTER.md` matches the already preserved historical canon exactly, Git blob `0027cfaeb6cf6418506c9cf2f13aca2971b7feeb`. It adds no competing version of that book.

Full inventories and comparisons are in `references/lalala-inventory.json` and `references/lalala-git-comparison.json`.

## Fresh source build and axiom audit

The replay staged 254 Lean files and three configuration files from the archive. It excluded the archive's `.lake` directory and compiled objects. The unchanged project configuration pins Lean 4.35.0 and has no external Lake packages.

The default physical-bridges target built successfully: **249 jobs**, exit code zero. See `lalala-lake-build-receipt.txt` and `lalala-build-result.json`.

A separately written auditor imports that freshly built target, enumerates its public `PhysicalBridges` theorem declarations and inspects their transitive axiom dependencies:

| Audited declaration class | Count |
| --- | ---: |
| No axiom dependencies | 1,651 |
| Only allowed standard foundations | 1,637 |
| Total checked theorem declarations | 3,288 |
| Admitted/custom axiom dependencies | 0 |

The allowlist is `propext`, `Classical.choice`, and `Quot.sound`. Declaration counts include helper and generated theorem declarations; they are not a count of independently discovered physical laws. The scope is the archived default target, not every Lean file in all five families and not a fresh full-current-main replay.

The auditor and source manifest are available in `archive-replay/lalala-physical-bridges/ArchiveNamespaceAudit.lean` and `references/lalala-replay-source-manifest.json`. The complete audit receipt and summary are `lalala-namespace-axiom-receipt.txt` and `lalala-namespace-axiom-summary.json`.

No axiom dependency does not mean no theorem hypothesis. The physical, semantic and initial-state premises remain in the checked types.

## The recovered scope note

The archive's unique protection note explicitly distinguishes being unconditional over a mind's policy from being unconditional over the world. Its theorem is independent of an optimizer's benevolence **within the specified metered-boundary model**. Complete metering is a substantive condition; one unmetered edge supplies a constructive killer.

The note also identifies the model's limitations: consent is a Boolean record, protected particulars are represented coordinates, and the model has no agent-to-agent harm channel. Non-retiring mind lineage survives by the specified agent semantics. This does not prove that every actual mind and subject is protected against every actual interaction.

That source boundary is a graph-cut metering concept. It does not define or establish the author's distinct Complete Koru boundary. Those types must remain separate in the central argument.

The current `UnconditionalProtectionExact` proof has the same mathematical text, so these qualifications are directly relevant to interpreting that theorem. Later models may add capabilities, but their added correspondence and coverage claims must be checked at their own types.

## Constructive improvement added to the book

The progress chapter now uses the existing ranked-service and bounded-stall constructions rather than discussing liveness only as a missing property.

For a service goal, invariant and natural-number rank, the source proves bounded service when productive events strictly decrease the rank, stalls do not increase it, zero rank entails service, and the completed trace obeys a stall budget B. At the exact horizon N = initial rank + B, a verified maximum delay D between completed events gives:

\[
\mathrm{Inv}(s_N)\land\mathrm{Served}(s_N)
\land t_N\le t_0+(\mathrm{rank}(s_0)+B)D.
\]

`IRConcreteClockedStalls` supplies a positive witness: initial rank two, one stall, two productive events, four modeled time units per event, service by twelve modeled units. Three stalls fail service. These declarations were included in the fresh source replay.

The improvement is substantive conditional mathematics. Actual completion, truthful event timing, a real service interpretation and the original six-duty certificate still need their own same-history correspondence. A numerical counter reaching zero is not substituted for a person's delivered freedom.

## Stronger current-Git joins

The review also read `IntegratedProtectionCoexistenceAssembly` and `IntegratedProtectionHostileControls` at main `0f6eec3`. These later modules are absent from the older archive.

The assembly joins original-cohort continuation and executable required options with authentic original-six duties over the **same independently specified real-step domain**. Its theorem retains mediation, source reflection, a protected initial state, actual trace reachability, complete guarded-effect coverage and all six authentic reflections as inputs. The hostile controls separately expose missing original duties, incomplete effect inventories and the gap between committed logs and a full computed history.

These source results strengthen the available architecture. They neither erase the original-six target nor derive the actual physical/semantic inputs from the archive's existence. Their source was inspected here; they are not counted as part of the older archive's fresh build.

## Result for the book

The archive confirms the identity of the full historical book, supplies a fresh replay of a substantial proof project, recovers a useful explicit scope note, and provides a constructive bounded-service route now incorporated into the progress chapter. It changes neither the six original duties nor the author's distinct boundary clarification.

The universal actual-world conclusion remains unestablished. The next physical advance requires independently meaningful actual events, affected subjects, complete effect coverage and genuine service/agency evidence. Archive size, compilation counts and retained records cannot stand in for those facts.
