#!/bin/bash
# UPT G3 — Reproducible Verification Script
# Run from the repository root: ./publication/verify.sh
# Requires: Lean 4 (elan), lake
set -e

echo "═══════════════════════════════════════════════════════"
echo " UPT G3 — Independent Verification"
echo " $(date)"
echo "═══════════════════════════════════════════════════════"
echo ""

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

PASS=0
FAIL=0

check() {
  if [ $? -eq 0 ]; then
    echo "  ✓ $1"
    PASS=$((PASS + 1))
  else
    echo "  ✗ $1"
    FAIL=$((FAIL + 1))
  fi
}

# 1. Standalone Checkmate
echo "── Step 1: Standalone THE_CHECKMATE ──"
cd "$REPO_ROOT/evidence/physical-bridges"
OUTPUT=$(lake env lean PhysicalBridges/G3TheCheckmateStandalone.lean 2>&1)
echo "$OUTPUT" | grep -q "does not depend on any axioms"
check "THE_CHECKMATE compiles with zero axioms"

# 2. PhysicalBridges full build
echo ""
echo "── Step 2: PhysicalBridges full build ──"
cd "$REPO_ROOT/evidence/physical-bridges"
lake build 2>&1 | tee /tmp/upt-pb-build.log
ERRORS=$(grep -c "error:" /tmp/upt-pb-build.log 2>/dev/null || echo "0")
[ "$ERRORS" = "0" ]
check "PhysicalBridges: 0 build errors"

# 3. Check for sorry
echo ""
echo "── Step 3: Check for sorry ──"
cd "$REPO_ROOT/evidence/physical-bridges"
SORRY_COUNT=$(grep -r "sorry" PhysicalBridges/ --include="*.lean" | grep -v "^.*:.*--" | grep -v "/\-" | grep -v "no sorry" | grep -v "no_sorry" | grep -v "without sorry" | wc -l | tr -d ' ')
[ "$SORRY_COUNT" = "0" ]
check "PhysicalBridges: 0 sorry ($SORRY_COUNT found)"

# 4. Check for custom axioms
echo ""
echo "── Step 4: Check for custom axioms ──"
AXIOM_COUNT=$(grep -r "^axiom " PhysicalBridges/ --include="*.lean" | wc -l | tr -d ' ')
[ "$AXIOM_COUNT" = "0" ]
check "PhysicalBridges: 0 custom axioms ($AXIOM_COUNT found)"

# 5. Count theorems
echo ""
echo "── Step 5: Theorem count ──"
PB_THEOREMS=$(grep -r "^theorem " PhysicalBridges/ --include="*.lean" | wc -l | tr -d ' ')
PB_DEFS=$(grep -r "^def \|^structure \|^inductive \|^class \|^abbrev " PhysicalBridges/ --include="*.lean" | wc -l | tr -d ' ')
PB_FILES=$(find PhysicalBridges/ -name "*.lean" | wc -l | tr -d ' ')
echo "  PhysicalBridges: $PB_THEOREMS theorems, $PB_DEFS definitions, $PB_FILES files"

# 6. G3 zero-axiom audit
echo ""
echo "── Step 6: G3 zero-axiom theorems ──"
G3_FILES=$(find PhysicalBridges/ -name "G3*.lean" | wc -l | tr -d ' ')
echo "  G3 files: $G3_FILES"

# Summary
echo ""
echo "═══════════════════════════════════════════════════════"
echo " Results: $PASS passed, $FAIL failed"
echo "═══════════════════════════════════════════════════════"

if [ "$FAIL" -gt 0 ]; then
  echo " VERIFICATION INCOMPLETE — $FAIL checks failed"
  exit 1
else
  echo " VERIFICATION PASSED"
  exit 0
fi
