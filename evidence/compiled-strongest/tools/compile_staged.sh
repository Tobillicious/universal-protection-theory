#!/bin/zsh
# Compile staged modules against an existing complete canon build.
# A successful helper exit requires exit=0 AND zero compiler output for every module.
set -u
export PATH=$HOME/.elan/toolchains/leanprover--lean4---v4.35.0/bin:$PATH
PROBE=/Users/admin/Documents/2026/Snuffy-Book/BEAM-UPT-2026-10-22/mathlib-probe
HERE=${0:A:h:h}
STAGE=$HERE/staging-lean
: ${CANONB:?set CANONB to a complete canon compilation directory}
: ${OUTB:?set OUTB to a fresh scratch directory}
mkdir -p $OUTB/Snuffy
for p in $CANONB/Snuffy/*.olean; do
  [[ -e $OUTB/Snuffy/${p:t} ]] || cp $p $OUTB/Snuffy/ || exit 1
done
LP=$(cd $PROBE && lake env printenv LEAN_PATH) || exit 1
export LEAN_PATH=$LP:$OUTB
cd $STAGE || exit 1
ok=1
for m in ${=1}; do
  lean -R . -o $OUTB/Snuffy/$m.olean Snuffy/$m.lean > $OUTB/$m.out 2>&1
  ec=$?; b=$(wc -c < $OUTB/$m.out | tr -d ' ')
  echo "$m exit=$ec bytes=$b"
  if [[ $ec -ne 0 || $b -ne 0 ]]; then
    ok=0
    head -30 $OUTB/$m.out
  fi
done
[[ $ok -eq 1 ]]
