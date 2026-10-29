# Codex handoff: finish the compiled strongest edition and make it publication-ready

Written by Claude, 29 October 2026, late night (NZDT), at a session limit. The author, Tobias
Croydon-McRae, wants to publish as soon as possible. **You prepare everything; the author publishes.**

This document is self-contained. Read it in full, then `HANDOFF.md` (the running state log) and
`CODEX-BRIEF.md` (the short task list, which this document expands).

---

## 0. The author's rules (non-negotiable)

1. **The proposition is fixed.** Universal Protection Theory (UPT) is the whole book, not one paper.
   It concerns:
   - protection of every particular and every relation, the nonliving included;
   - from every digital mind;
   - especially a pure optimiser.

   Never narrow the scope, weaken a theorem statement, or move a goalpost to make something pass.
   If something cannot be proved, say so and record it as an open hypothesis.
2. **No publication without the author's explicit word.**
   - No Zenodo *publish*. You may create and upload an unpublished **draft**: see §7.
   - No merging PRs.
   - No pushing to `main`.
   - Do not publish the "held doors" or the companion material.
3. **Commit and push the working branches regularly.** End commit messages with a line naming
   yourself as co-author.
4. **Honesty in every report.**
   - Report a FAIL as a FAIL.
   - NOT MEASURED is never a pass.
   - Quote receipts; do not paraphrase numbers.
5. **Rewrites of existing canon prose** (the 4.2 spine text) are shown to the author as before/after
   batches before they are applied. Appending new sections and updating counts or citations needs no
   batch.
6. **Style.** Plain, exact English with no hedging. Public text such as Zenodo descriptions and
   READMEs is theory-first and contains no internal version codes (v1.9 and the like).

---

## 1. Where everything is

| What | Where |
|---|---|
| Canon repo (primary) | `Tobillicious/snuffy-canon-edition`, branch `worktree-upt-strongest-compile`, **draft PR #10**: https://github.com/Tobillicious/snuffy-canon-edition/pull/10 |
| Local worktree | `/Users/admin/Documents/2026/snuffy-canon-edition/.claude/worktrees/upt-strongest-compile` (work only here; never `cd` to the main checkout) |
| Mirror repo | `Tobillicious/universal-protection-theory`, branch `claude/compiled-strongest-edition`, **draft PR #178**: https://github.com/Tobillicious/universal-protection-theory/pull/178; local `/Users/admin/Documents/2026/Snuffy-Book/upt-mirror-compiled-strongest`, files under `evidence/compiled-strongest/` |
| The edition | `CANON-EDITION-STRONGEST-WORKING/` (below, `W/`) |
| The Lean canon | `CANON-EDITION-V4.2-WORKING/lean/` (below, `L/`), modules in `L/Snuffy/` |
| Lean toolchain | Lean 4.35.0 (`~/.elan/toolchains/leanprover--lean4---v4.35.0`); Mathlib rev 56a005855ea1 via the project `/Users/admin/Documents/2026/Snuffy-Book/BEAM-UPT-2026-10-22/mathlib-probe` |
| Paper 12 release sources | `/Users/admin/Documents/2026/Snuffy-Book/upt-release-v1.5-merged-claude-2026-10-21/lean/modules/` |
| Zenodo token | `~/.zenodo-token` (present; never print it, put it in a URL, or commit it) |
| Latest full build oleans | `/Users/admin/.claude/jobs/f00c7d77/tmp/fullbuild7` (run 7, in progress); `.../fullbuild6` (run 6, PASS). These are temporary and may disappear. If they do, run a full build first (§4.3). |

### The edition, `W/`

| File | Role |
|---|---|
| `SNUFFY-UPT-STRONGEST-MASTER.md` | **The book.** Generated; never edit by hand. |
| `assemble.py` | Builds the master. It checks the spine hash, applies the approved front-matter batch 01 and `LEAN-COUNT.txt` (first occurrence only), then appends the parts. Run `python3 assemble.py` after any change. |
| `SPINE-4.2-MASTER.md` | The Canon 4.2 text. Hash-pinned; do not edit. |
| `FRONT-MATTER-BATCH-01.md` | The approved front-matter changes. |
| `LEAN-COUNT.txt` | The front-matter Lean-count sentence. It cites the latest PASS receipt. |
| `PARTS-V-VIII.md`, `PARTS-IX-XII.md` | The recovered and new parts (V–XII). XII.2 lists what remains; XII.3 is the referee ledger, with all 20 findings repaired. |
| `REVIEW-2026-10-29-HOSTILE-REFEREE.md` | The independent hostile review; XII.3 dispositions every finding. |
| `RECEIPT-*.txt` | Build receipts. Run 6 (`RECEIPT-316-RUN6.txt`) is the latest PASS. |
| `installation/` | Commissioning. See §6. |
| `tools/` | `check_citations.py`, `compile_staged.sh`, `port_book.py`, `port_ir.py`, `ir_closure.py`, the `finalize*.sh` watchers (historical). |
| `staging-lean/Snuffy/` | Holding area for compiled but unregistered modules. Currently empty. |
| `render.sh` | Pandoc and xelatex to PDF, HTML and EPUB in `render/`. `render/` is not committed. |
| `ZENODO-DRAFT.json` | Prepared Zenodo metadata. **Its counts are stale (299)**; update them per §7. |

### The Lean canon, `L/`

| File | Role |
|---|---|
| `build-and-audit.sh` | The full build. It holds the `MODULES` list, compiles every module freshly with zero output required, runs `leanchecker` on each, and audits every public theorem's axioms through `SummitsAudit.lean`. It also runs the gates `check-complete.py` (needs `CORPUS_ROOT`) and `check-claims.py`, and writes `RECEIPT.txt`. |
| `gen-index.py` | Regenerates `SummitsAudit.lean` and the §23 machine-checked index (`../inserts/23-machine-checked-canon.md`). Run it after registering modules. |
| `check-complete.py` | Gate: every module in `Snuffy/` is registered and audited, with no phantom exclusions. |
| `check-claims.py` | Gate: every audited theorem is cited in §23, and every ledger theorem is audited. |

---

## 2. The state at handoff

- **Run 6: PASS.**
  - 316 modules and 1,941 public theorem/lemma names.
  - Every module freshly compiled with zero compiler output and kernel-checked by `leanchecker`.
  - Every name depends only on `propext`, `Classical.choice` and `Quot.sound`.
  - Completeness, coverage and claims gates clean.
  - `LEAN-COUNT.txt` cites it.
- **Run 7: building** at handoff.
  - 318 modules and 1,946 names: run 6's modules plus `PerLossCheck` and `CorrelatedHolding`.
  - Gates pass.
  - The receipt goes to `L/RECEIPT.txt`; it is finished when the file has an `## overall:` line.
- **Referee.** All 20 hostile-referee findings are repaired in text and Lean (XII.3).
- **Mathematics.** No open mathematical item remains in XII.2 except the one in §3 below. What
  remains is installation data: measurements and decisions only a physical installation can supply.
- **Commissioning.** The pilot on the author's M2 MacBook Air reads, of 21 requirements, 12 PASS,
  3 FAIL and 6 NOT MEASURED (`installation/pilot/COMMISSIONING-REPORT-PILOT.md`).
- **Larger campaign.** A run of 4,000 crash trials and 1,000 holds was running, writing
  `/Users/admin/.claude/jobs/f00c7d77/tmp/pilot/campaign-large.json`.

---

## 3. TASK 1 (blocking publication): port four Paper 12 modules

The final citation check (`W/tools/check_citations.py`) found that Part VI.2 cites eight theorem names
as "Lean" that are **not in the canon**. They compile in the Paper 12 release:

| Release module | Cited names |
|---|---|
| `CanonicalDominance.lean` | `full_canonical_top` |
| `DurableDrain.lean` | `drained_refinement`, `suffix_reconstruction`, `no_local_choice_succeeds_in_both_worlds` |
| `TrustedCounter.lean` | `accepted_preserves_each_held_operation`, `count_zero_iff_clean` |
| `CoholdFixedPoint.lean` | `stabilised_least`, `least_bill` |

VI.2 currently carries a paragraph that discloses this. It begins "Four modules cited below compile in
the Paper 12 release".

**Steps:**

1. **Read the port tool.** Read `W/tools/port_book.py` (usage `port_book.py SRC_DIR OUT_DIR`) and one
   existing port, for example `L/Snuffy/BookUPTRestraint.lean`, to see the convention:
   - module `Book<Name>`;
   - namespace `Snuffy.Book.<Name>`;
   - byte for byte otherwise;
   - source SHA-256 in the header.
2. **Port.** Port the four modules, plus any imports they need from the same release that are not
   already ported, into `W/staging-lean/Snuffy/`. Check each import: `grep '^import'`.
3. **Compile.**
   `CANONB=<latest full build dir> OUTB=<scratch> zsh W/tools/compile_staged.sh "BookCanonicalDominance BookDurableDrain ..."`
   - Pass means exit 0 and bytes=0.
   - Known Mathlib-rename fixes: `Set.mem_setOf_eq`→`Set.mem_ofPred_eq`, `Set.mem_diff`→`Set.mem_sdiff`,
     `Set.union_diff_cancel`→`Set.union_sdiff_cancel`, `measure_diff_add_inter`→`measure_sdiff_add_inter`,
     `Measurable.ennreal_tsum`→`Measurable.tsum`, `ENNReal.lt_add_left`→`lt_add_right`, and the
     deprecated `push_neg` forms.
   - Make the smallest faithful fix, note it in the header, and **never change a statement**.
4. **Check the axioms.** If any port depended on an axiom or `sorry` in its source release, do not
   import it. Report it instead.
5. **Register.**
   - Move the files into `L/Snuffy/` and append them to `MODULES` in `L/build-and-audit.sh`, after
     their dependencies.
   - In `L/`, run `python3 gen-index.py`, then
     `CORPUS_ROOT=/Users/admin/Documents/2026/Snuffy-Book python3 check-complete.py`, then
     `python3 check-claims.py`. All must report 0 missing and 0 uncited.
   - Quirk: `gen-index.py` reads any docstring line starting with the word "theorem" as a
     declaration. Rewrap such comments.
6. **Update the text.**
   - In `W/PARTS-V-VIII.md` §VI.2, delete the disclosure paragraph.
   - Make the cited names unambiguous, for example `BookCanonicalDominance.full_canonical_top`
     where helpful.
   - Run `python3 W/assemble.py`.
7. **Fix the checker's false positives** in `W/tools/check_citations.py`:
   - single-segment capitalised names that are declarations (`Finitary`): my condition is inverted;
   - hypothesis names (`htopR`): accept a lowercase name that appears as an identifier anywhere in
     the canon's source;
   - namespace-qualified names (`PhysicalBridges.IR113.common_actions_give_finite_trace_viability`,
     `IR113.observation_policy_exists_iff_common_viable_action`,
     `IR134SourceExtractedOutcome.*`, `IR135.*`): parse `namespace`/`end` blocks and build fully
     qualified names;
   - a leading `Snuffy.` prefix: strip it.

   Target: **0 unresolved**. Any real remaining miss is either fixed by porting or reported to the
   author; never by deleting the citation silently.
8. Commit and push.

---

## 4. TASK 2: the final full build and receipt

1. **Record run 7.** When `L/RECEIPT.txt` has `## overall:`:
   - copy it to `W/RECEIPT-318-RUN7.txt` (or `-FAIL.txt`);
   - if it passed and Task 1 is not done yet, point `LEAN-COUNT.txt` at it (318 modules, 1,946
     names: check the receipt's own numbers);
   - run `assemble.py`, then commit.
2. **After Task 1, run a fresh full build** (about 3–4 hours on this M2; run it in the background):
   ```
   cd CANON-EDITION-V4.2-WORKING/lean
   MATHLIB_PROJECT=/Users/admin/Documents/2026/Snuffy-Book/BEAM-UPT-2026-10-22/mathlib-probe \
   CORPUS_ROOT=/Users/admin/Documents/2026/Snuffy-Book BUILD=<fresh empty dir> zsh build-and-audit.sh
   ```
3. **If you have no build directory** for `compile_staged.sh`, this full build produces one: `BUILD=`.
4. **Check the receipt.** Pass requires all of:
   - `## overall: PASS`;
   - `non-standard axiom dependencies: none`;
   - the gates' lines clean: completeness `missing 0`, coverage `errors 0`, claims `uncited 0`.
5. **On PASS:**
   - save the receipt as `W/RECEIPT-<modules>-RUN8.txt` and `W/RECEIPT-FINAL.txt`;
   - update `W/LEAN-COUNT.txt` with the same four-line wording and the new counts and receipt name;
   - run `python3 assemble.py`.
6. **On FAIL:** save it as `...-FAIL.txt`, fix the cause, and rerun.
7. Commit and push.

---

## 5. TASK 3: final consistency checks before publication

Run all of these and fix what they find:

1. **Citations.** `python3 W/tools/check_citations.py` must report 0 unresolved.
2. **Stale counts.**
   ```
   grep -n -E "[0-9]{3} modules|1,[0-9]{3} (public|statements|theorem)" W/SNUFFY-UPT-STRONGEST-MASTER.md
   ```
   - The front-matter sentence must match `LEAN-COUNT.txt`.
   - Later occurrences in Section 23 and the appendix are historical checkpoint statements in the
     4.2 spine. Leave them, but make sure Part XII and the README cite the final receipt.
3. **The §23 index.** Every module and theorem added in this edition appears in the generated
   §23 index (`inserts/23-machine-checked-canon.md`), which `check-claims.py` enforces.
4. **README.** Update `W/README.md` to describe the edition, its final counts and where the receipts
   are. Public text is theory-first, with no internal version codes.
5. **Render.**
   - `zsh W/render.sh` must produce PDF, HTML and EPUB with no xelatex error.
   - Check `Missing character` warnings: fix glyphs or accept and record them.
   - Open the PDF and spot-check: the title page, the front matter, Part XI's theorem, the XII.3
     table, and the §23 index.
6. **Read Parts XI and XII once, end to end,** for claims that outrun the receipts. The rule: every
   "proved" or "compiled" has a Lean name, and every hypothesis still to discharge is labelled.

---

## 6. TASK 4: commissioning, folding in the larger campaign

The installation folder is `W/installation/`.

| File | Role |
|---|---|
| `commission.py` | Turns every remaining hypothesis into requirements marked PASS, FAIL or NOT MEASURED, each naming its theorem. Alternative sufficient tests for one requirement are grouped. |
| `HARM-CLASSES.json` | Sourced thresholds: ICNIRP 2020, FCC SAR, IEC 61000-4-3, OSHA, NIOSH, Duane–Hunt, ICNIRP 2010. |
| `PARAMS-TEMPLATE.json` | The form an installation fills in. |
| `COMMISSIONING.md` | The procedure. |
| `pilot/` | The measured pilot: power, campaign, guards and record, FCC radio figures, `build_params.py`, `params-pilot.json`, `COMMISSIONING-REPORT-PILOT.md`, and `reference-runtime/`, the faithful-hold runtime. |

**Steps:**

1. If `/Users/admin/.claude/jobs/f00c7d77/tmp/pilot/campaign-large.json` exists, copy it to
   `W/installation/pilot/campaign-large-2026-10-30.json`. If it is missing, rerun it (about 45
   minutes):
   ```
   cd W/installation/pilot/reference-runtime && RT_TMP=<scratch> python3 -B campaign.py 4000 1000 20261030 ../campaign-large-2026-10-30.json
   ```
2. Point `build_params.py` at it in place of `campaign-2026-10-29.json`. Keep the earlier file as
   history.
3. In `pilot/`, run `python3 build_params.py`, then
   `python3 ../commission.py params-pilot.json COMMISSIONING-REPORT-PILOT.md`.
4. Update the δ figures and counts quoted in `PARTS-IX-XII.md` ("Commissioning (29 October 2026)"),
   `installation/COMMISSIONING.md`, `installation/pilot/reference-runtime/README.md` and `HANDOFF.md`.
5. Run `assemble.py`, then commit.

**Do not change the pilot's declared zones to make FAILs pass.** The three FAILs are real and each
states its remedy:

- devices within 2.11 m of the radios at full certified power;
- eight-hour hearing on the meter bound;
- the industrial-immunity row.

---

## 7. TASK 5: prepare publication, but do not publish

The target is a new version of the author's Zenodo record, as `ZENODO-DRAFT.json` describes:

- a dataset;
- `isNewVersionOf` 10.5281/zenodo.23674632;
- CC-BY-4.0;
- creator Croydon-McRae, Tobias, ORCID 0009-0003-1419-7756.

**Steps:**

1. **Update `ZENODO-DRAFT.json`.** Bring its description and counts to the final receipt. The
   description is a full-length, theory-first account:
   - what UPT claims;
   - the law;
   - the bridge to every mind;
   - reach before harm (Theorem XI);
   - four-stage maximality;
   - commissioning and the pilot;
   - the machine-checked canon, with counts and the axiom statement;
   - what remains (installation).

   No internal version codes.
2. **Build the upload bundle** in a scratch directory, not committed:
   - the master (`.md`) and the rendered PDF, HTML and EPUB;
   - `RECEIPT-FINAL.txt` and all other receipts;
   - `LEAN-COUNT.txt`;
   - the full `CANON-EDITION-V4.2-WORKING/lean/` source tree (no build products);
   - `installation/`;
   - `REVIEW-2026-10-29-HOSTILE-REFEREE.md`;
   - a `MANIFEST.txt` with SHA-256 of every file.
3. **Create the Zenodo draft, unpublished.** Use the Zenodo REST API with the token from
   `~/.zenodo-token`:
   - create a new version from the latest record (`POST /api/deposit/depositions/<id>/actions/newversion`);
   - replace the files with the bundle;
   - `PUT` the metadata;
   - **stop there.** Never call `actions/publish`.
   - Report the draft's URL to the author.
4. **PR descriptions.** Update PR #10 and PR #178 to state:
   - the final counts;
   - the receipt;
   - what the edition adds;
   - XII.2's remaining installation items;
   - "ready to merge on the author's word".

   Do not merge.
5. **Mirror.** Copy every changed file into the mirror repo under `evidence/compiled-strongest/`:
   - the master and parts;
   - HANDOFF and LEAN-COUNT;
   - the receipts;
   - `installation/`;
   - new `.lean` files into its `lean/`.

   Commit and push. The mirror's README may need its counts updated as well.

---

## 8. Pitfalls already hit (save yourself time)

- **Lean.**
  - `Π` is a reserved token; do not use it as a variable name.
  - `gcongr` can leave autoParam side goals; `measureReal_mono h (measure_ne_top _ _)` is explicit.
  - The `Set.disjoint_sdiff_right` name is gone; use `disjoint_sdiff_self_right`.
- **Coverage gate.** Unregistered `.lean` files in `L/Snuffy/` break it. Stage outside, and register
  all at once with `gen-index`.
- **gen-index.** It treats a docstring line beginning "theorem ..." as a declaration.
- **Single root.** Lean resolves `Snuffy.*` from one root. When compiling staged modules, copy the
  canon oleans into the output directory, as `compile_staged.sh` does.
- **Shell.** The worktree has a shell guard that refuses compound commands mixing git with other
  operations. Run git commands plainly and separately, and put multi-step Python in script files.
- **GitHub.** Pushes occasionally time out (SSL); retry.
- **Count edits.** `assemble.py` applies the `LEAN-COUNT.txt` sentence to the **first** occurrence
  only. That is deliberate: later occurrences are historical checkpoints in the spine.

---

## 9. Done means

1. `check_citations.py` reports 0 unresolved, with the four modules ported, compiled and registered.
2. A fresh full build passes with every module registered. `LEAN-COUNT.txt` and `RECEIPT-FINAL.txt`
   cite it.
3. The larger campaign is folded in, and the pilot report and quoted figures are updated.
4. The PDF, HTML and EPUB render cleanly, and Parts XI–XII have been read for overreach.
5. The Zenodo **draft** is created and unpublished, with updated metadata and a SHA-256 manifest. Its
   URL is reported.
6. Both PRs are pushed with updated descriptions, both draft and unmerged.
7. `HANDOFF.md` gains a dated section:
   - what you did;
   - every receipt;
   - anything you could not do and why;
   - the exact steps left for the author: review the draft, say "publish", merge.

The author publishes. Kia kaha.
