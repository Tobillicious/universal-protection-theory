#!/bin/zsh
# After run 5 (306 modules) finishes: save its receipt, register the ten gap-closing modules,
# run the gates and the final full build (run 6).
WT=/Users/admin/Documents/2026/snuffy-canon-edition/.claude/worktrees/upt-strongest-compile
LEAN=$WT/CANON-EDITION-V4.2-WORKING/lean
STAGE=$WT/CANON-EDITION-STRONGEST-WORKING/staging-lean/Snuffy
OUT=$WT/CANON-EDITION-STRONGEST-WORKING
TMP=/Users/admin/.claude/jobs/f00c7d77/tmp
until grep -q '^## overall:' $LEAN/RECEIPT.txt 2>/dev/null && grep -q '^final:' $TMP/finalize2.log 2>/dev/null; do sleep 60; done
cp $LEAN/RECEIPT.txt $OUT/RECEIPT-306-RUN5.txt
echo "run5: $(grep -E '^## (overall|theorems audited)' $LEAN/RECEIPT.txt | tr '\n' ' ')" > $TMP/finalize3.log
NEWMODS="FiniteCharacter StagedAlternatives ExclusionRadius CommonPolicyMaximal CommonPolicyTop FoundingCover CountablePooling ExpandingWavefront ItemisedRisk ChannelMeter"
for m in ${=NEWMODS}; do mv $STAGE/$m.lean $LEAN/Snuffy/; done
python3 - "$LEAN/build-and-audit.sh" "$NEWMODS" <<'EOF'
import re, sys
path, add = sys.argv[1], sys.argv[2].split()
s = open(path).read()
m = re.search(r"^MODULES=\((.*)\)$", s, re.M)
mods = m.group(1).split()
mods += [a for a in add if a not in mods]
s = s[:m.start(1)] + " ".join(mods) + s[m.end(1):]
open(path, "w").write(s)
print(len(mods))
EOF
cd $LEAN
python3 gen-index.py >> $TMP/finalize3.log 2>&1
CORPUS_ROOT=/Users/admin/Documents/2026/Snuffy-Book python3 check-complete.py | grep -E 'completeness|coverage|ERROR' >> $TMP/finalize3.log 2>&1
python3 check-claims.py | tail -2 >> $TMP/finalize3.log 2>&1
rm -rf $TMP/fullbuild6 && mkdir -p $TMP/fullbuild6
MATHLIB_PROJECT=/Users/admin/Documents/2026/Snuffy-Book/BEAM-UPT-2026-10-22/mathlib-probe CORPUS_ROOT=/Users/admin/Documents/2026/Snuffy-Book BUILD=$TMP/fullbuild6 zsh build-and-audit.sh > $TMP/fullbuild6.log 2>&1
cp $LEAN/RECEIPT.txt $OUT/RECEIPT-FINAL.txt
echo "final: $(grep -E '^## (overall|theorems audited)' $LEAN/RECEIPT.txt | tr '\n' ' ')" >> $TMP/finalize3.log
