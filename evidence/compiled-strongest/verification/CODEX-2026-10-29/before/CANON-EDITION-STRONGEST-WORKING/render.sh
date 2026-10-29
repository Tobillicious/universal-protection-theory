#!/bin/bash
# Render SNUFFY-UPT-STRONGEST-MASTER.md to TeX/PDF (xelatex), HTML and EPUB (MathML),
# with the 4.2 render header and filter.
set -euo pipefail
cd "$(dirname "$0")"
C=../CANON-EDITION-V4.2-WORKING/checks
M=SNUFFY-UPT-STRONGEST-MASTER.md
mkdir -p render
B=render/Snuffy-UPT-Compiled-Edition
T="The Universal Protection Theory — compiled edition"
F=markdown+tex_math_single_backslash+lists_without_preceding_blankline
pandoc -f $F "$M" -s --toc -V geometry:margin=1in -V mainfont="STIXGeneral" -V mathfont="STIX Two Math" \
  -V monofont="Menlo" -M title="The Universal Protection Theory" -M subtitle="Compiled edition: Canon 4.2 with the recovered parts" \
  -M author="Tobias Croydon-McRae" -M date="29 October 2026" -V colorlinks=true -V linkcolor=blue \
  -H $C/render-header.tex --lua-filter=$C/breakable-code.lua -M pagetitle="$T" -o "$B.tex"
( cd render && for i in 1 2 3; do xelatex -interaction=nonstopmode -halt-on-error "$(basename $B).tex" > xelatex.log 2>&1 || { tail -30 xelatex.log; exit 2; }; done )
if grep -q "Missing character" render/*.log; then grep "Missing character" render/*.log | sort | uniq -c | head -20; fi
pandoc -f $F "$M" -s --math-method=mathml --lua-filter=$C/breakable-code.lua --toc -M pagetitle="$T" -M lang=en -o "$B.html"
pandoc -f $F "$M" --math-method=mathml --lua-filter=$C/breakable-code.lua --toc -M title="$T" \
  -M author="Tobias Croydon-McRae" -M lang=en -M date="2026-10-29" -o "$B.epub"
rm -f render/*.aux render/*.out render/*.toc
ls -la render
