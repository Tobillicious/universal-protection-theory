"""Check every Lean name cited in the recovered parts against the compiled canon.

usage: python3 tools/check_citations.py  (from CANON-EDITION-STRONGEST-WORKING/)

A citation is a backticked `Module.name` or `Module` whose first segment is a Capitalised identifier.
It resolves when lean/Snuffy/<Module>.lean exists and, for `Module.name`, declares that name (theorem,
lemma, def, structure or abbrev, possibly inside a namespace). A backticked lowercase identifier is
resolved by searching every module for a declaration of that name."""
import glob, os, re, sys

HERE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
LEAN = os.path.join(HERE, '..', 'CANON-EDITION-V4.2-WORKING', 'lean', 'Snuffy')
PARTS = ['PARTS-V-VIII.md', 'PARTS-IX-XII.md']

decl = re.compile(r'^\s*(?:private\s+|protected\s+|noncomputable\s+)*(?:theorem|lemma|def|structure|abbrev|inductive|class|instance)\s+([^\s:({\[]+)', re.M)
mods = {}
for f in glob.glob(os.path.join(LEAN, '**', '*.lean'), recursive=True):
    name = os.path.relpath(f, LEAN)[:-5].replace(os.sep, '.')
    mods[name] = set(m.split('.')[-1] for m in decl.findall(open(f).read()))
all_names = set().union(*mods.values())

tick = re.compile(r'`([^`\s]+)`')
missing, checked = [], 0
for part in PARTS:
    for ln, line in enumerate(open(os.path.join(HERE, part)), 1):
        for tok in tick.findall(line):
            tok = tok.strip('.,;:()')
            if '/' in tok or tok.endswith(('.md', '.py', '.json', '.txt', '.lean', '.sh')) or not re.match(r'^[A-Za-z][\w.\']*$', tok):
                continue
            segs = tok.split('.')
            if segs[0][0].isupper():
                # find the longest module prefix
                for k in range(len(segs), 0, -1):
                    mod = '.'.join(segs[:k])
                    if mod in mods: break
                else:
                    if len(segs) == 1 and tok not in all_names:
                        continue   # a capitalised word in backticks that is not a module, e.g. a type name
                    missing.append((part, ln, tok, 'no such module')); checked += 1; continue
                checked += 1
                rest = segs[k:]
                if rest and rest[-1] not in mods[mod]:
                    missing.append((part, ln, tok, f'{rest[-1]} not declared in {mod}'))
            elif '_' in tok and tok.islower() or re.match(r'^[a-z]+[A-Z_]\w*$', tok):
                checked += 1
                if tok not in all_names:
                    missing.append((part, ln, tok, 'not declared in any module'))
print(f'modules {len(mods)}, citations checked {checked}, unresolved {len(missing)}')
for m in missing: print('  %s:%d  `%s`  %s' % m)
sys.exit(1 if missing else 0)
