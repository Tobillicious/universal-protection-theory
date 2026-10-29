#!/bin/zsh
# After the 299-module run 4 finishes: save its receipt, register the seven repair modules,
# run the gates and the final full build (run 5).
WT=/Users/admin/Documents/2026/snuffy-canon-edition/.claude/worktrees/upt-strongest-compile
LEAN=$WT/CANON-EDITION-V4.2-WORKING/lean
STAGE=$WT/CANON-EDITION-STRONGEST-WORKING/staging-lean/Snuffy
OUT=$WT/CANON-EDITION-STRONGEST-WORKING
TMP=/Users/admin/.claude/jobs/f00c7d77/tmp
until grep -q '^## overall:' $LEAN/RECEIPT.txt 2>/dev/null; do sleep 60; done
cp $LEAN/RECEIPT.txt $OUT/RECEIPT-299-RUN4.txt
echo "run4: $(grep -E '^## (overall|theorems audited)' $LEAN/RECEIPT.txt | tr '\n' ' ')" > $TMP/finalize2.log
NEWMODS="ReachTiming FoundingPivotal GrowingBill ContinuationSubject NoisyPooling StageBridge HoldFromCycle"
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
python3 gen-index.py >> $TMP/finalize2.log 2>&1
CORPUS_ROOT=/Users/admin/Documents/2026/Snuffy-Book python3 check-complete.py | grep -E 'completeness|coverage|ERROR' >> $TMP/finalize2.log 2>&1
python3 check-claims.py | tail -2 >> $TMP/finalize2.log 2>&1
rm -rf $TMP/fullbuild5 && mkdir -p $TMP/fullbuild5
MATHLIB_PROJECT=/Users/admin/Documents/2026/Snuffy-Book/BEAM-UPT-2026-10-22/mathlib-probe CORPUS_ROOT=/Users/admin/Documents/2026/Snuffy-Book BUILD=$TMP/fullbuild5 zsh build-and-audit.sh > $TMP/fullbuild5.log 2>&1
cp $LEAN/RECEIPT.txt $OUT/RECEIPT-FINAL.txt
echo "final: $(grep -E '^## (overall|theorems audited)' $LEAN/RECEIPT.txt | tr '\n' ' ')" >> $TMP/finalize2.log
