"""Record the final full build and bring every count-bearing file to it.

usage: python3 tools/finalize_final.py RUN_LABEL   (from CANON-EDITION-STRONGEST-WORKING/; e.g. RUN10)

Refuses unless the canon receipt (CANON-EDITION-V4.2-WORKING/lean/RECEIPT.txt) shows every module
compiled with zero output, every module kernel-checked, the axiom audit clean and `## overall: PASS`,
and unless the completeness and claims gates and the citation check pass. Then it writes the
receipt copies, LEAN-COUNT.txt, the README count paragraph, the HANDOFF current-state block and the
Zenodo description, and reassembles the master. No upload, no publication."""
import json, re, shutil, subprocess, sys
from pathlib import Path

W = Path(__file__).resolve().parents[1]
L = W.parent / 'CANON-EDITION-V4.2-WORKING' / 'lean'
label = sys.argv[1]

r = (L / 'RECEIPT.txt').read_text()
compiled = re.findall(r'^## (\w+): exit=(\d+) compiler-output-bytes=(\d+)$', r, re.M)
checked = re.findall(r'^## leanchecker Snuffy\.(\w+): exit=(\d+)$', r, re.M)
aud = re.search(r'^## theorems audited: (\d+); non-standard axiom dependencies: (.+)$', r, re.M)
assert re.search(r'^## overall: PASS$', r, re.M), 'receipt is not PASS'
assert compiled and all(e == '0' and b == '0' for _, e, b in compiled), 'a module failed or printed output'
assert len(checked) == len(compiled) and all(e == '0' for _, e in checked), 'kernel check incomplete or failed'
assert aud and aud.group(2).strip() == 'none', 'axiom audit not clean'
M, N = len(compiled), int(aud.group(1))
mods_listed = re.search(r'^MODULES=\((.*)\)$', (L / 'build-and-audit.sh').read_text(), re.M).group(1).split()
assert M == len(mods_listed), f'receipt has {M} modules, canon registers {len(mods_listed)}'

env = dict(**__import__('os').environ, CORPUS_ROOT='/Users/admin/Documents/2026/Snuffy-Book')
gates = []
for cmd in (['python3', 'check-complete.py'], ['python3', 'check-claims.py']):
    p = subprocess.run(cmd, cwd=L, env=env, capture_output=True, text=True)
    gates.append(f'$ {" ".join(cmd)}  (exit {p.returncode})\n{p.stdout.strip()}\n{p.stderr.strip()}'.strip())
    assert p.returncode == 0, f'{cmd[1]} failed:\n{p.stdout}\n{p.stderr}'
cite = subprocess.run(['python3', 'tools/check_citations.py'], cwd=W, capture_output=True, text=True)
assert cite.returncode == 0, cite.stdout
gates.append('$ python3 tools/check_citations.py\n' + cite.stdout.strip())

rec_name = f'RECEIPT-{M}-{label}.txt'
shutil.copyfile(L / 'RECEIPT.txt', W / rec_name)
shutil.copyfile(L / 'RECEIPT.txt', W / 'RECEIPT-FINAL.txt')
(W / f'RECEIPT-{M}-{label}-GATES.txt').write_text('\n\n'.join(gates) + '\n')
Mf, Nf = f'{M:,}', f'{N:,}'

(W / 'LEAN-COUNT.txt').write_text(
    f"The compiled edition's Lean canon contains {M} modules and {Nf} public theorem/lemma names\n"
    f"in the final full build ({label.lower().replace('run', 'run ')}) of 29 October 2026, which freshly compiled and kernel-checked every\n"
    f"module with zero compiler output and passed the full {Nf}-name standard-axiom audit, strict\n"
    f"completeness and claims gates ({rec_name}). Its source hashes match the tree at that run.\n")

readme = (W / 'README.md').read_text()
a = readme.index('The current source contains'); b = readme.index('\n\nThe reference runtime', a)
readme = readme[:a] + (
    f'The canon contains {M} Lean modules and {Nf} public theorem/lemma names. The final full build\n'
    f'compiled every module from an empty build directory with zero compiler output, kernel-checked\n'
    f'each one and audited every name: only Lean\'s three standard axioms, no `sorry`. The completeness,\n'
    f'claims and citation gates pass. `RECEIPT-FINAL.txt` is that receipt (also `{rec_name}`);\n'
    f'earlier receipts keep their own scope. See `HANDOFF.md` for the record of every run.') + readme[b:]
readme = readme.replace('The final package will include the exact source tree, receipts and checksum\nmanifest.',
                        'The deposit includes the exact source tree, receipts and a SHA-256 manifest.')
(W / 'README.md').write_text(readme)

hand = (W / 'HANDOFF.md').read_text()
cut = hand.index('# Handoff — compiled strongest UPT edition')
block = f"""## Current state — final verification passed (29 October 2026, late)

**Final full build PASS ({label}):** {M} modules and {Nf} public theorem/lemma names, every module
compiled from an empty build directory with zero output, kernel-checked, and every name audited to
Lean's three standard axioms. Completeness, claims and citation gates pass
(`{rec_name}`, `RECEIPT-{M}-{label}-GATES.txt`; `RECEIPT-FINAL.txt`).

- **Codex's continuation, reviewed by Claude.** Kept:
  - nine recovered modules, each verified byte for byte against its source hash;
  - the citation checker;
  - the runtime lock repair and its 4,000-crash, 1,000-hold campaign with zero failures;
  - the trial-versus-kernel evidence scoping.
- **Reverted:** its scope drift, with the author's approval (commits 4126d14, 4cf8b59).
- **Builds.** Run 7's log was recovered after Codex's run-8 collision; run 9 died when its session
  closed; the final build is the receipt above.
- **The pilot:** 9 PASS, 3 FAIL and 10 NOT MEASURED of 22 screening requirements. This is honest,
  and it does not bear on the theory's proofs.
- **Remaining.** Physical installation, as listed in XII.2. Publication is the author's word:
  review the Zenodo draft, then merge PR #10 and PR #178.

"""
(W / 'HANDOFF.md').write_text(block + hand[cut:])

z = json.loads((W / 'ZENODO-DRAFT.json').read_text())
z['_status'] = (f'Final metadata, 29 October 2026, for the final full build ({M} modules, {Nf} names). '
                'Upload as an unpublished draft; publication only on the author\'s explicit word.')
d = z['description']
d = re.sub(r'<p><strong>The machine-checked canon\.</strong>.*?</p>',
    f'<p><strong>The machine-checked canon.</strong> {M} Lean 4 modules and {Nf} audited public theorems and '
    'lemmas compile against Mathlib with zero compiler output and pass the kernel checker, with no sorry and '
    "only Lean's three standard axioms. Completeness, claims and citation gates check that every built module "
    'is in the canon, every audited theorem is cited in the manuscript and every cited name exists.</p>', d, flags=re.S)
d = d.replace('whenever infeasibility has finite character: real tragedies are finite.',
    'whenever the space of executable policies is compact, from which finite character follows; alternative '
    'requirements are covered, and in a tragedy maximality reduces exactly to one check per loss.')
d = d.replace('Where the top outcome is realisable and funded it is the greatest, and no rival can exceed it.',
    'Where the top outcome is realisable and funded it is the greatest, and no rival can exceed it; under '
    'union closure from locality one policy, fixed before the world is known, realises it in every world.')
d = d.replace('Holding failure falls exponentially once protection-first capacity clears the threshold r = C(1−ε)/H &gt; 1.',
    'Holding failure falls exponentially once protection-first capacity clears the threshold r = C(1−ε)/H &gt; 1, '
    'and stays bounded under a random threat and any correlation among keepers.')
d = re.sub(r'<p><strong>Contents:</strong>.*?</p>',
    '<p><strong>An independent hostile review</strong> of the new parts raised twenty findings; every one is '
    'repaired in the text and in Lean, and the disposition ledger is included.</p>'
    '<p><strong>Commissioning.</strong> Every remaining physical hypothesis is a measurable check with its pass '
    'condition, against a sourced harm-class table. A pilot on one laptop is included as measured evidence, '
    'with its failures and unmeasured items reported as they are; physical installation remains to be built.</p>'
    '<p><strong>Contents:</strong> the compiled master manuscript with PDF, EPUB and HTML renders; the full '
    'Lean source tree with its one-command build-and-audit script and final receipt; the edition sources, '
    'receipts, review, commissioning checker and pilot evidence; and a SHA-256 manifest of every file. '
    'This version supersedes earlier versions of this record.</p>', d, flags=re.S)
assert f'{M} Lean 4 modules' in d and 'hostile review' in d
z['description'] = d
(W / 'ZENODO-DRAFT.json').write_text(json.dumps(z, indent=1, ensure_ascii=False) + '\n')

import importlib.util
spec = importlib.util.spec_from_file_location('genindex', L / 'gen-index.py')
gi = importlib.util.module_from_spec(spec); spec.loader.exec_module(gi)
mods = gi.modules(); names = {m: gi.theorems(L / 'Snuffy' / f'{m}.lean') for m in mods}
assert len(mods) == M and sum(map(len, names.values())) == N, 'index counts differ from the receipt'
rows = ['# XII.4 The current machine-checked index', '',
        f'This index lists all {M} modules of the canon and all {Nf} audited public theorems and lemmas, '
        f'as compiled, kernel-checked and axiom-audited in the final full build (`{rec_name}`). '
        'Section 23 above retains the historical 4.2 checkpoint index.', '']
for m in mods:
    rows += [f'**{m}**', '', ', '.join(f'`{n}`' for n in names[m]) or '(definitions only)', '']
(W / 'CURRENT-THEOREM-INDEX.md').write_text('\n'.join(rows) + '\n')

subprocess.run(['python3', 'assemble.py'], cwd=W, check=True)
print(f'FINAL: {M} modules, {Nf} names, {rec_name}; gates and citations pass; files updated.')
