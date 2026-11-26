import os, re, json, sys

GITHUB_PB = "https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/physical-bridges/PhysicalBridges/"
GITHUB_SN = "https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/compiled-strongest/lean/Snuffy/"

base = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

def extract_decls(root):
    entries = []
    for fn in sorted(os.listdir(root)):
        if not fn.endswith('.lean') or fn == '.lean':
            continue
        path = os.path.join(root, fn)
        with open(path) as f:
            for line in f:
                m = re.match(r'^(theorem|lemma|def|abbrev|structure|inductive|class)\s+(\S+)', line)
                if m:
                    kind = m.group(1)
                    name = m.group(2).rstrip('(:{')
                    entries.append({"name": name, "kind": kind, "file": fn})
    return entries

pb = extract_decls(os.path.join(base, 'evidence/physical-bridges/PhysicalBridges'))
sn = extract_decls(os.path.join(base, 'evidence/compiled-strongest/lean/Snuffy'))

data = {"pb": pb, "sn": sn, "pb_base": GITHUB_PB, "sn_base": GITHUB_SN}
outpath = os.path.join(base, 'publication', 'glossary-data.json')
with open(outpath, 'w') as f:
    json.dump(data, f)
print(f"Wrote {len(pb)} PB + {len(sn)} SN declarations to glossary-data.json")
