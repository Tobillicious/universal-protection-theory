#!/bin/zsh
# Compile staged modules (staging-lean/Snuffy/*.lean) against an existing full canon build, without
# registering them. Usage: CANONB=<full build dir> OUTB=<scratch dir> zsh tools/compile_staged.sh "Mod1 Mod2 ..."
#   CANONB  a directory from a finished build-and-audit.sh run (BUILD=...), containing Snuffy/*.olean
#   OUTB    scratch output directory (created; canon oleans are copied in once)
# A module passes only with exit 0 and bytes=0 (zero compiler output).
export PATH=$HOME/.elan/toolchains/leanprover--lean4---v4.35.0/bin:$PATH
PROBE=/Users/admin/Documents/2026/Snuffy-Book/BEAM-UPT-2026-10-22/mathlib-probe
HERE=${0:A:h:h}
STAGE=$HERE/staging-lean
: ${CANONB:?set CANONB to a finished full build directory}
: ${OUTB:?set OUTB to a scratch directory}
mkdir -p $OUTB/Snuffy
cp -n $CANONB/Snuffy/*.olean $OUTB/Snuffy/ 2>/dev/null
LP=$(cd $PROBE && lake env printenv LEAN_PATH)
export LEAN_PATH=$LP:$OUTB
cd $STAGE
for m in ${=1}; do
  lean -R . -o $OUTB/Snuffy/$m.olean Snuffy/$m.lean > $OUTB/$m.out 2>&1; ec=$?
  b=$(wc -c < $OUTB/$m.out | tr -d ' ')
  echo "$m exit=$ec bytes=$b"
  [[ $b -ne 0 ]] && head -30 $OUTB/$m.out
done
