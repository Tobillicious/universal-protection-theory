#!/usr/bin/env python3
"""Sanitized, target-distinct R5 seccomp trace receipt for fixed negative controls.

This observes only three existing disposable strict-policy probes and never
uploads raw strace, which could reveal unreviewed data.
"""
import argparse
from collections import Counter
import json
from pathlib import Path
import re

FILTER = re.compile(r'^prctl\(PR_SET_SECCOMP,\s*SECCOMP_MODE_FILTER,.*\) = 0$')
CALL = re.compile(r'^(socket|connect)\(.*\) = (.*)$')
EXPECTED = Counter({"socket_eperm": 1, "pathname_connect_eperm": 1,
                    "abstract_connect_eperm": 1})

def classify(line):
    match = CALL.match(line)
    if not match:
        return None
    name, result = match.groups()
    if not result.startswith('-1 EPERM '):
        return 'unexpected'
    if name == 'socket' and line.startswith('socket(AF_UNIX,'):
        return 'socket_eperm'
    if name == 'connect' and 'sa_family=AF_UNIX' in line:
        if 'g3-fake-authority-never-created' in line and 'sun_path=' in line:
            return 'pathname_connect_eperm'
        if 'g3-r5-abstract-alternate' in line and 'sun_path=' in line:
            return 'abstract_connect_eperm'
    return 'unexpected'

def summarize(prefix: Path):
    files = sorted(p for p in prefix.parent.glob(prefix.name + '.*')
                   if p.name[len(prefix.name) + 1:].isdigit())
    counts = Counter()
    fenced = 0
    ambiguous = 0
    for path in files:
        filtered = False
        outcomes = []
        for line in path.read_text(errors='replace').splitlines():
            if FILTER.match(line):
                if filtered:
                    ambiguous += 1
                filtered = True
                continue
            if filtered:
                result = classify(line)
                if result is not None:
                    outcomes.append(result)
        if filtered:
            fenced += 1
            if len(outcomes) == 1 and outcomes[0] in EXPECTED:
                counts[outcomes[0]] += 1
            else:
                ambiguous += 1
    ok = fenced == 3 and counts == EXPECTED and ambiguous == 0
    return {
        'schema': 'g3-r5-strict-syscall-denial-v3',
        'scope': 'three existing disposable strict R5 probes; non-exhaustive',
        'fenced_processes': fenced,
        'socket_eperm': counts['socket_eperm'],
        'pathname_connect_eperm': counts['pathname_connect_eperm'],
        'abstract_connect_eperm': counts['abstract_connect_eperm'],
        'unexpected_or_ambiguous_outcomes': ambiguous,
        'distinct_child_and_target_denials_verified': ok,
        'status': 'PASS' if ok else 'FAIL',
    }

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--trace-prefix', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    outcome = summarize(args.trace_prefix)
    args.output.write_text(json.dumps(outcome, indent=2, sort_keys=True) + '\n')
    print(json.dumps(outcome, sort_keys=True))
    return 0 if outcome['status'] == 'PASS' else 1

if __name__ == '__main__':
    raise SystemExit(main())
