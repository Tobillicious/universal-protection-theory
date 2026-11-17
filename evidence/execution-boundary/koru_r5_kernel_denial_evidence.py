#!/usr/bin/env python3
"""Sanitized process-distinct strace receipt for existing strict R5 tests.

Research-only: each traced disposable child must show its OWN post-filter
kernel denial. Raw traces are never uploaded.
"""
import argparse
from collections import Counter
import json
from pathlib import Path
import re

FILTER = re.compile(r'^prctl\(PR_SET_SECCOMP,\s*SECCOMP_MODE_FILTER,.*\) = 0$')
CALL = re.compile(r'^(socket|connect)\(.*\) = (.*)$')

def summarize(prefix: Path):
    files = sorted(p for p in prefix.parent.glob(prefix.name + '.*')
                   if p.name[len(prefix.name) + 1:].isdigit())
    children = []
    failures = 0
    for path in files:
        after_filter = False
        child = Counter()
        for line in path.read_text(errors='replace').splitlines():
            if FILTER.match(line):
                if after_filter:
                    failures += 1
                after_filter = True
                continue
            if not after_filter:
                continue
            match = CALL.match(line)
            if not match:
                continue
            op, result = match.groups()
            if result.startswith('-1 EPERM '):
                child[op + '_eperm'] += 1
            else:
                child['unexpected_outcome'] += 1
        if after_filter:
            children.append(dict(child))
    counts = Counter()
    for child in children:
        if child == {'socket_eperm': 1}:
            counts['socket'] += 1
        elif child == {'connect_eperm': 1}:
            counts['connect'] += 1
        else:
            failures += 1
    passed = (len(children) == 3 and counts == {'socket': 1, 'connect': 2}
              and failures == 0)
    return {
        'schema': 'g3-r5-strict-syscall-denial-v2',
        'scope': 'three existing strict child probes; observed, non-exhaustive',
        'fenced_processes': len(children),
        'socket_eperm': counts['socket'],
        'connect_eperm': counts['connect'],
        'unexpected_or_ambiguous_outcomes': failures,
        'distinct_child_denials_verified': passed,
        'status': 'PASS' if passed else 'FAIL',
    }

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--trace-prefix', type=Path, required=True)
    ap.add_argument('--output', type=Path, required=True)
    args = ap.parse_args()
    record = summarize(args.trace_prefix)
    args.output.write_text(json.dumps(record, indent=2, sort_keys=True) + '\n')
    print(json.dumps(record, sort_keys=True))
    return 0 if record['status'] == 'PASS' else 1

if __name__ == '__main__':
    raise SystemExit(main())
