"""R5: summarize fixed-child preconnection and post-seccomp strace syscalls.

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
SYSCALL = re.compile(r"^([A-Za-z_][A-Za-z_0-9]*)\(")
FILTER_INSTALL = "prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER"


def summarize(prefix):
    traces = sorted(prefix.parent.glob(prefix.name + ".*"))
    if not traces:
        raise ValueError("no per-process traces")
    children = []
    # Only aggregate stage counts are logged on failure. Raw strace content
    # can contain test credentials and must never be uploaded or echoed.
    stages = collections.Counter()
    for path in traces:
        if not path.name[len(prefix.name) + 1:].isdigit():
            continue
        stages["numeric_pid_traces"] += 1
        lines = path.read_text(errors="replace").splitlines()
        # Detect this existing launcher via the installed seccomp filter.
        installs = [i for i, line in enumerate(lines) if FILTER_INSTALL in line
                    and "= 0" in line]
        if not installs:
            continue
        stages["seccomp_install_success"] += 1
        # The reviewed fixed child connects under executor UID BEFORE its
        # strict seccomp install. Require both successful AF_UNIX socket
        # creation and a successful AF_UNIX connection in that same PID
        # trace. An unrelated Python-only seccomp probe cannot qualify.
        before = lines[:installs[-1]]
        sockets = [line for line in before
                   if line.startswith("socket(") and "AF_UNIX" in line
                   and " = " in line and " = -1 " not in line]
        connections = [line for line in before
                       if line.startswith("connect(") and "AF_UNIX" in line
                       and line.rstrip().endswith("= 0")]
        if not sockets:
            stages["no_pre_filter_unix_socket"] += 1
        if not connections:
            stages["no_pre_filter_unix_connect"] += 1
        # The launcher verifies exactly one live inherited/new FD at the
        # handoff, not exactly one socket() ever called during Python startup.
        # Preserve exactly one successful authority connect and the subsequent
        # post-filter success prohibition; allow additional CLOSED pre-filter
        # AF_UNIX sockets in the observed startup trace.
        stages["successful_unix_socket_count_" + str(min(len(sockets), 9))] += 1
        stages["successful_unix_connect_count_" + str(min(len(connections), 9))] += 1
        # Calls before seccomp include transient Python/OS local lookups.
        # Audit the *live* socket descriptors at the handoff rather than the
        # number of socket/connect invocations since process startup.
        # Reject unknown FD-manipulation in this narrow trace analysis:
        # it must not falsely turn an unreviewed launch into a pass.
        live_unix = set()
        connected_unix = set()
        untracked = False
        for line in before:
            match = re.match(r"^socket\\(AF_UNIX,.*\\)\\s+=\\s+(\\d+)(?:\\s|$)", line)
            if match:
                live_unix.add(int(match.group(1)))
                continue
            match = re.match(r"^connect\\((\\d+),.*\\)\\s+=\\s+0(?:\\s|$)", line)
            if match:
                fd = int(match.group(1))
                if fd in live_unix:
                    connected_unix.add(fd)
                continue
            match = re.match(r"^close\\((\\d+)\\)\\s+=\\s+0(?:\\s|$)", line)
            if match:
                fd = int(match.group(1))
                live_unix.discard(fd)
                connected_unix.discard(fd)
                continue
            if re.match(r"^(dup|dup2|dup3|socketpair|close_range|fcntl)\\(", line):
                # A narrow collector cannot reason about unknown FD
                # duplication or mass-close operations without more data.
                # Refuse certification instead of ignoring such operations.
                if " = -1 " not in line:
                    untracked = True
        stages["live_unix_at_fence_" + str(min(len(live_unix), 9))] += 1
        stages["live_connected_unix_at_fence_" + str(min(len(connected_unix), 9))] += 1
        if len(sockets) < 1 or not connections or untracked or len(live_unix) != 1 or connected_unix != live_unix:
            stages["pre_connection_mismatch"] += 1
            if untracked:
                stages["untracked_fd_manipulation"] += 1
            continue
        stages["pre_connection_verified"] += 1
        after = lines[installs[-1] + 1:]
        # The fixed request happens only AFTER the post-connect kernel fence.
        # A successful new socket/connect after confinement is a hard failure,
        # even when the authority returned an apparently positive response.
        if any(line.startswith(("socket(", "connect("))
               and " = " in line and " = -1 " not in line
               for line in after):
            raise ValueError("unexpected successful socket/connect after confinement")
        # Select an actual serialized authority reply from the confined
        # child's stdout. strace -s 1024 captures the bounded JSON output.
        replies = [outcome for outcome in ("synthetic_effect_returned", "authority_denied")
                   if any("write(1," in line and outcome in line for line in after)]
        if len(replies) != 1:
            stages["ambiguous_post_fence_reply"] += 1
            raise ValueError("missing or ambiguous traced authority outcome")
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
        # Creation before the fence is required; no post-fence socket
        # creation is required or permitted in this fixed-client workload.
        stages["qualified_children"] += 1
        children.append({
            "trace_file": path.name,
            "observed_authority_outcome": replies[0],
            "after_seccomp_syscalls": dict(sorted(counts.items())),
            "kernel_eperm_by_syscall": dict(sorted(denials.items())),
            "pre_seccomp_af_unix_socket_creations": len(sockets),
            "pre_seccomp_af_unix_connections": len(connections),
            "verified_connected_unix_fds_at_filter": len(connected_unix),
            "after_seccomp_af_unix_socket_attempts": af_unix_sockets,
            "other_socket_creation_attempts": non_unix_socket_attempts,
        })
    if len(children) < 3:
        raise ValueError(
            "expected positive/repeated-denial and HOLD-first child traces; found " +
            str(len(children)) + "; sanitized trace stages=" +
            json.dumps(dict(sorted(stages.items())), sort_keys=True))
    outcomes = collections.Counter(child["observed_authority_outcome"] for child in children)
    if outcomes["synthetic_effect_returned"] != 1 or outcomes["authority_denied"] < 2:
        raise ValueError("expected exactly one effect and at least two denials")
    return {
        "schema": "g3-r5-observed-syscalls-v3",
        "observed_outcome_counts": dict(sorted(outcomes.items())),
        "scope": "one tested fixed-marker authority request and HOLD-first denial; observed, non-exhaustive",
        "selection": "one live connected pre-filter AF_UNIX socket FD, successful seccomp install, post-filter authority reply; no successful post-filter socket/connect",
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
