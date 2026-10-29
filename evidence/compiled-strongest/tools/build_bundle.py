"""Build the Zenodo upload bundle for the compiled edition (no upload, no publication).

usage: python3 tools/build_bundle.py OUT_DIR   (from CANON-EDITION-STRONGEST-WORKING/)

Writes OUT_DIR with the rendered edition, the master, README, the final receipt, two source zips and
MANIFEST.txt (SHA-256 of every uploaded file and of every file inside each zip). Also writes
publication/UPLOAD-MANIFEST.json (path, name, bytes, sha256, md5 per uploaded file) for the draft
uploader. Refuses to run unless RECEIPT-FINAL.txt reports `## overall: PASS`."""
import hashlib, json, os, re, sys, zipfile
from pathlib import Path

W = Path(__file__).resolve().parents[1]
L = W.parent / 'CANON-EDITION-V4.2-WORKING'
out = Path(sys.argv[1]).resolve(); out.mkdir(parents=True, exist_ok=True)

receipt = (W / 'RECEIPT-FINAL.txt').read_text()
assert re.search(r'^## overall: PASS$', receipt, re.M), 'final receipt is not a PASS'
assert 'non-standard axiom dependencies: none' in receipt

def h(p, algo): return hashlib.new(algo, Path(p).read_bytes()).hexdigest()

SKIP_PARTS = {'render', '__pycache__', '.lake', 'build', 'publication', '.DS_Store'}
def zip_tree(zpath, roots):
    inner = []
    with zipfile.ZipFile(zpath, 'w', zipfile.ZIP_DEFLATED) as z:
        for root, arc in roots:
            for p in sorted(root.rglob('*')):
                rel = p.relative_to(root)
                if not p.is_file() or SKIP_PARTS & set(rel.parts) or p.suffix in ('.olean', '.ilean', '.trace') \
                        or '-IN-PROGRESS' in p.name or p.name.startswith('.'):
                    continue
                name = f'{arc}/{rel.as_posix()}'
                z.write(p, name); inner.append((name, h(p, 'sha256')))
    return inner

files = []
def add(src, name):
    dst = out / name
    dst.write_bytes(Path(src).read_bytes()); files.append(dst)

R = W / 'render'
add(R / 'Snuffy-UPT-Compiled-Edition.pdf', 'Snuffy-UPT-Compiled-Edition.pdf')
add(R / 'Snuffy-UPT-Compiled-Edition.html', 'Snuffy-UPT-Compiled-Edition.html')
add(R / 'Snuffy-UPT-Compiled-Edition.epub', 'Snuffy-UPT-Compiled-Edition.epub')
add(W / 'SNUFFY-UPT-STRONGEST-MASTER.md', 'SNUFFY-UPT-STRONGEST-MASTER.md')
add(W / 'README.md', 'README.md')
add(W / 'RECEIPT-FINAL.txt', 'RECEIPT-FINAL.txt')
lean_inner = zip_tree(out / 'lean-canon-source.zip',
                      [(L / 'lean', 'lean'), (L / 'checks', 'checks'), (L / 'inserts', 'inserts')])
files.append(out / 'lean-canon-source.zip')
ed_inner = zip_tree(out / 'edition-sources.zip', [(W, 'CANON-EDITION-STRONGEST-WORKING')])
files.append(out / 'edition-sources.zip')

lines = ['# MANIFEST: SHA-256 of every uploaded file and every file inside each zip', '']
for f in files: lines.append(f'{h(f, "sha256")}  {f.name}')
for zname, inner in (('lean-canon-source.zip', lean_inner), ('edition-sources.zip', ed_inner)):
    lines += ['', f'## inside {zname} ({len(inner)} files)']
    lines += [f'{s}  {n}' for n, s in inner]
(out / 'MANIFEST.txt').write_text('\n'.join(lines) + '\n'); files.append(out / 'MANIFEST.txt')

entries = [{'name': f.name, 'path': str(f), 'bytes': f.stat().st_size,
            'sha256': h(f, 'sha256'), 'md5': h(f, 'md5')} for f in files]
pub = W / 'publication'; pub.mkdir(exist_ok=True)
(pub / 'UPLOAD-MANIFEST.json').write_text(json.dumps(
    {'all_package_checks_pass': True, 'files': entries}, indent=2) + '\n')
print(f'bundle: {len(files)} files, {sum(e["bytes"] for e in entries)/1e6:.1f} MB; '
      f'lean zip {len(lean_inner)} files, edition zip {len(ed_inner)} files')
