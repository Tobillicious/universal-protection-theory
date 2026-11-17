#!/usr/bin/env python3
"""Sanitized strace evidence for existing R5 strict post-connect tests.

Observations are bounded to traced subprocesses after a successful seccomp
installation. Raw traces may contain sensitive data and are never uploaded.
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
                   if p.name[len(prefix.name)+1:].isdigit())
    counts = Counter()
    fenced = 0
    successes = 0
    for path in files:
        active = False
        saw_fence = False
        for line in path.read_text(errors='replace').splitlines():
            if FILTER.search(line):
                active = saw_fence = True
                continue
            if not active:
                continue
            match = CALL.match(line)
            if not match:
                continue
            op, result = match.groups()
            if result.startswith('-1 EPERM '):
                counts[op + '_eperm'] += 1
            elif re.match(r'^\d+', result):
                successes += 1
        if saw_fence:
            fenced += 1
    return {
        'schema': 'g3-r5-strict-syscall-denial-v1',
        'scope': 'three existing post-connect tests; traced child syscalls only',
        'fenced_processes': fenced,
        'socket_eperm': counts['socket_eperm'],
        'connect_eperm': counts['connect_eperm'],
        'successful_post_fence_socket_or_connect': successes,
        'status': ('PASS' if fenced >= 3 and counts['socket_eperm'] >= 1
                   and counts['connect_eperm'] >= 2 and successes == 0 else 'FAIL')
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
