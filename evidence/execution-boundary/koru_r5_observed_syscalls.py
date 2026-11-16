"""R5: summarize actual strace syscalls after the existing fixed child's seccomp install.

Read-only analysis of a disposable Linux trace. Never claim exhaustive syscall
reachability: strace perturbs scheduling, coverage is one exercised trace, and
the root authority, kernel and tracing observer are outside this trust claim.
"""
import argparse
import collections
import json
from pathlib import Path
import re
import sys

# strace -ff writes one file per traced PID.
SYSCALL = re.compile(r"^([A-Za-z_][A-Za-z_0-9]*)\\(")
FILTER_INSTALL = "prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER"


def summarize(prefix):
    traces = sorted(prefix.parent.glob(prefix.name + ".*"))
    if not traces:
        raise ValueError("no per-process traces")
    children = []
    for path in traces:
        if not path.name[len(prefix.name) + 1:].isdigit():
            continue
        lines = path.read_text(errors="replace").splitlines()
        # Detect this existing launcher via the installed seccomp filter.
        installs = [i for i, line in enumerate(lines) if FILTER_INSTALL in line
                    and "= 0" in line]
        if not installs:
            continue
        # Fixed-child marker request must be tested, not a Python-only probe.
        if not any("AF_UNIX" in line and
                   ("socket(" in line or "connect(" in line)
                   for line in lines[installs[-1] + 1:]):
            continue
        after = lines[installs[-1] + 1:]
        counts = collections.Counter()
        denials = collections.Counter()
        af_unix_sockets = 0
        non_unix_socket_attempts = 0
        for line in after:
            hit = SYSCALL.match(line)
            if not hit:
                continue
            name = hit.group(1)
            counts[name] += 1
            if " = -1 EPERM " in line:
                denials[name] += 1
            if name == "socket":
                if "AF_UNIX" in line:
                    af_unix_sockets += 1
                else:
                    non_unix_socket_attempts += 1
        if af_unix_sockets < 1:
            raise ValueError("confined child did not create expected AF_UNIX socket")
        children.append({
            "trace_file": path.name,
            "after_seccomp_syscalls": dict(sorted(counts.items())),
            "kernel_eperm_by_syscall": dict(sorted(denials.items())),
            "af_unix_socket_creations": af_unix_sockets,
            "other_socket_creation_attempts": non_unix_socket_attempts,
        })
    if len(children) < 3:
        raise ValueError("expected positive/repeated-denial and HOLD-first child traces; found " + str(len(children)))
    return {
        "schema": "g3-r5-observed-syscalls-v1",
        "scope": "one tested fixed-marker authority request and HOLD-first denial; observed, non-exhaustive",
        "selection": "successful PR_SET_SECCOMP + post-filter AF_UNIX operation, not generic test-runner syscalls",
        "children": children,
    }


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--trace-prefix", type=Path, required=True)
    ap.add_argument("--output", type=Path, required=True)
    args = ap.parse_args()
    record = summarize(args.trace_prefix)
    args.output.write_text(json.dumps(record, indent=2, sort_keys=True) + "\n")
    print("R5 confined child traces=" + str(len(record["children"])) +
          " (observed syscalls only; not complete mediation)")
    for child in record["children"]:
        print(child["trace_file"] + " " + ",".join(child["after_seccomp_syscalls"]))


if __name__ == "__main__":
    main()
