#!/bin/zsh
# Wait for the 198-module run to finish, then register the 101 staged modules and run the final full build.
WT=/Users/admin/Documents/2026/snuffy-canon-edition/.claude/worktrees/upt-strongest-compile
LEAN=$WT/CANON-EDITION-V4.2-WORKING/lean
STAGE=$WT/CANON-EDITION-STRONGEST-WORKING/staging-lean/Snuffy
OUT=$WT/CANON-EDITION-STRONGEST-WORKING
TMP=/Users/admin/.claude/jobs/f00c7d77/tmp
until grep -q '^## overall:' $LEAN/RECEIPT.txt 2>/dev/null; do sleep 60; done
cp $LEAN/RECEIPT.txt $OUT/RECEIPT-198-RUN2.txt
echo "run2: $(grep '^## overall:' $LEAN/RECEIPT.txt)" > $TMP/finalize.log
# move staged modules into the canon
mv $STAGE/*.lean $LEAN/Snuffy/
# registration order: Book ports (BookUPTExistence first), then the new modules, then the IR closure
BOOK="BookUPTExistence $(cd $LEAN/Snuffy && ls Book*.lean | sed 's/\.lean$//' | grep -v -e '^BookUPTExistence$' -e '^BookContextualObservation$' | tr '\n' ' ')"
NEW="EmissionBound FoundingAnchor ContinuationPredicate"
IR="$(cat $TMP/ir_order.txt)"
python3 - "$LEAN/build-and-audit.sh" "$BOOK $NEW $IR" <<'EOF'
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
python3 gen-index.py >> $TMP/finalize.log 2>&1
CORPUS_ROOT=/Users/admin/Documents/2026/Snuffy-Book python3 check-complete.py | grep -E 'completeness|coverage|ERROR' >> $TMP/finalize.log 2>&1
python3 check-claims.py | tail -2 >> $TMP/finalize.log 2>&1
rm -rf $TMP/fullbuild3 && mkdir -p $TMP/fullbuild3
MATHLIB_PROJECT=/Users/admin/Documents/2026/Snuffy-Book/BEAM-UPT-2026-10-22/mathlib-probe CORPUS_ROOT=/Users/admin/Documents/2026/Snuffy-Book BUILD=$TMP/fullbuild3 zsh build-and-audit.sh > $TMP/fullbuild3.log 2>&1
cp $LEAN/RECEIPT.txt $OUT/RECEIPT-FINAL.txt
echo "final: $(grep -E '^## (overall|theorems audited)' $LEAN/RECEIPT.txt | tr '\n' ' ')" >> $TMP/finalize.log
