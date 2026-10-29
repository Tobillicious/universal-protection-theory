# Brief for Codex: continue the compiled strongest edition

29 October 2026, written by Claude before a session limit. You are continuing in this worktree:
`/Users/admin/Documents/2026/snuffy-canon-edition/.claude/worktrees/upt-strongest-compile`
on branch `worktree-upt-strongest-compile` (draft PR #10). Read `CANON-EDITION-STRONGEST-WORKING/HANDOFF.md`
first, in full.

## Rules (the author's, non-negotiable)

- **Proposition.** The proposition is protection of every particular and relation, the nonliving
  included, from every digital mind, especially a pure optimiser.
  - Never narrow it.
  - Never weaken a statement to make it compile.
  - Never move a goalpost.
- **Publishing.** Never publish:
  - no Zenodo publish;
  - no merging of PRs;
  - no pushing to `main`.
- **Commits.** Commit and push the branch regularly, with clear messages.
- **Honesty.**
  - Report failures exactly as they happened.
  - A FAIL or NOT MEASURED is never written as a pass.
- **Lean.** Use Lean 4.35.0 with Mathlib rev 56a005855ea1 (project
  `/Users/admin/Documents/2026/Snuffy-Book/BEAM-UPT-2026-10-22/mathlib-probe`).
  - A module counts only with zero compiler output and only the standard axioms (propext,
    Classical.choice, Quot.sound).
  - Unregistered `.lean` files inside `lean/Snuffy/` break the coverage gate. Keep new modules
    in `CANON-EDITION-STRONGEST-WORKING/staging-lean/Snuffy/` until you register them.

## Task 1 (first): port four Paper 12 modules into the canon

`tools/check_citations.py` found eight theorem names cited in Part VI.2 that are not in the canon. They
compile in `/Users/admin/Documents/2026/Snuffy-Book/upt-release-v1.5-merged-claude-2026-10-21/lean/modules/`:

| Module | Cited names |
|---|---|
| `CanonicalDominance.lean` | `full_canonical_top` |
| `DurableDrain.lean` | `drained_refinement`, `suffix_reconstruction`, `no_local_choice_succeeds_in_both_worlds` |
| `TrustedCounter.lean` | `accepted_preserves_each_held_operation`, `count_zero_iff_clean` |
| `CoholdFixedPoint.lean` | `stabilised_least`, `least_bill` |

Steps:

1. Port each module as `Book<Name>` with `tools/port_book.py SRC_DIR OUT_DIR`, the same tool used
   for the other 22 `Book*` ports.
   - The port is byte for byte apart from the namespace (`Snuffy.Book.<Name>`).
   - Record the source SHA-256 in the header.
   - Port into `staging-lean/Snuffy/`.
   - Port any imports they need from the same release as well.
2. Compile each module against the canon's existing oleans, with zero output required. If a
   Mathlib rename breaks one, make the smallest faithful fix and record it in the header. Never
   change a statement.
3. Register the modules:
   - move them into `CANON-EDITION-V4.2-WORKING/lean/Snuffy/`;
   - add them to `MODULES` in `CANON-EDITION-V4.2-WORKING/lean/build-and-audit.sh`;
   - run `python3 gen-index.py`, `CORPUS_ROOT=/Users/admin/Documents/2026/Snuffy-Book python3 check-complete.py`
     and `python3 check-claims.py`. All must be clean.
4. Remove the paragraph in `PARTS-V-VIII.md` §VI.2 that begins "Four modules cited below compile in
   the Paper 12 release". Then change the cited names to point at the `Book*` modules where needed,
   and run `python3 assemble.py`.
5. Fix the false positives in `tools/check_citations.py` until it reports 0 unresolved:
   - hypothesis names such as `htopR`;
   - the `Finitary` structure;
   - names given by namespace rather than module (`PhysicalBridges.IR113.*`, `IR134*`, `IR135.*`);
   - the `Snuffy.` prefix.

   Every remaining unresolved name must be a real missing citation; report each one.

## Task 2: the final full build

1. Wait until run 7 is finished. Its receipt is `CANON-EDITION-V4.2-WORKING/lean/RECEIPT.txt`, done
   when it has an `## overall:` line. Copy that receipt to
   `CANON-EDITION-STRONGEST-WORKING/RECEIPT-318-RUN7.txt`.
2. Then run the full build, which takes about 3 hours:
   `MATHLIB_PROJECT=/Users/admin/Documents/2026/Snuffy-Book/BEAM-UPT-2026-10-22/mathlib-probe CORPUS_ROOT=/Users/admin/Documents/2026/Snuffy-Book BUILD=<fresh empty dir> zsh build-and-audit.sh`
   in `CANON-EDITION-V4.2-WORKING/lean`.
3. On `## overall: PASS`:
   - save the receipt as `RECEIPT-<modules>-RUN8.txt` and as `RECEIPT-FINAL.txt`;
   - update `LEAN-COUNT.txt` to cite it, in the same wording as now;
   - run `python3 assemble.py`.
4. On FAIL, record the receipt as `...-FAIL.txt` and fix the cause.

## Task 3: fold in the larger campaign

`/Users/admin/.claude/jobs/f00c7d77/tmp/pilot/campaign-large.json` holds 4,000 crash trials and 1,000
holds. If it exists:

1. Copy it to `installation/pilot/campaign-large-2026-10-30.json`.
2. Point `installation/pilot/build_params.py` at it.
3. Run `python3 build_params.py`, then `python3 ../commission.py params-pilot.json COMMISSIONING-REPORT-PILOT.md`.
4. Update the counts quoted in `PARTS-IX-XII.md`, `installation/COMMISSIONING.md` and `HANDOFF.md`.

## Task 4: mirror and render

1. Copy the changed files into the mirror. The mirror repo is
   `/Users/admin/Documents/2026/Snuffy-Book/upt-mirror-compiled-strongest`, branch
   `claude/compiled-strongest-edition`, PR #178; the files go under `evidence/compiled-strongest/`.
   The changed files are:
   - the master;
   - PARTS;
   - HANDOFF;
   - LEAN-COUNT;
   - the receipts;
   - `installation/`;
   - the new `.lean` files under `lean/`.
2. Commit and push the mirror.
3. Run `render.sh` for the PDF preview. Do not commit `render/`.

## Done means

- `check_citations.py` reports 0 unresolved.
- A fresh full build PASSes with every module registered.
- `LEAN-COUNT.txt` cites that receipt.
- Both PRs are pushed.
- `HANDOFF.md` has a dated section saying exactly what you did and what is left.

Leave publication to the author.
