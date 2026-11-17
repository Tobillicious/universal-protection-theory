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

# strace -ff emits the file descriptor returned by socket() and used by
# connect()/close(). Count only live connected Unix sockets at confinement,
# not closed connections made earlier by interpreter startup. Ambiguous
# descriptor manipulation fails closed rather than being counted as safe.
# strace pads any call shorter than 40 columns before "= <ret>", e.g.
#   socket(AF_UNIX, SOCK_STREAM, 0)         = 3
#   close(3)                                = 0
# so every result separator below accepts one-or-more spaces. Matching the
# padded form only ADDS tracked sockets/connections; it cannot release one.
SOCKET_FD = re.compile(r"^socket\(AF_UNIX,.*\)\s+= ([0-9]+)$")
CONNECT_FD = re.compile(r"^connect\(([0-9]+), .*AF_UNIX.*\)\s+= 0$")
CLOSE_FD = re.compile(r"^close\(([0-9]+)(?=\)|<)")
FD_MODIFY = re.compile(r"^(?:dup|dup2|dup3|fcntl|sendmsg|recvmsg|recvmmsg|pidfd_getfd)\(")
FD_TRANSFER = re.compile(r"^(?:sendmsg|sendmmsg|recvmsg|recvmmsg|pidfd_getfd)\(")


def live_connected_unix_sockets(before):
    opened = set()
    connected = set()
    for line in before:
        # Transfer APIs can carry an FD absent from this socket tracker;
        # a matching digit in strace text is not reliable provenance evidence.
        # The selected fixed child has no pre-fence descriptor-transfer contract.
        if FD_TRANSFER.match(line):
            raise ValueError("ambiguous pre-fence descriptor transfer attempt")
        if FD_MODIFY.match(line):
            # This fixed child must not manipulate the tracked socket
            # capability through other FD-producing or transfer syscalls.
            if any(re.search(r"\b" + str(fd) + r"\b", line)
                   for fd in opened | connected):
                raise ValueError("ambiguous pre-fence socket descriptor manipulation")
        # close_range() can invalidate the tracked authority descriptor without
        # emitting any close(fd) line. Unless the selected child proves a
        # disjoint range, its effect on our FD lifetime is ambiguous.
        # Fail closed whenever any tracked socket has been opened; this
        # fixed child has no post-socket close_range contract.
        if line.startswith("close_range(") and opened:
            raise ValueError("ambiguous pre-fence close_range over tracked socket lifetime")
        match = SOCKET_FD.match(line)
        if match:
            fd = int(match.group(1))
            opened.add(fd)
            connected.discard(fd)
            continue
        match = CONNECT_FD.match(line)
        if match:
            fd = int(match.group(1))
            if fd not in opened:
                raise ValueError("Unix connection not associated with tracked socket")
            connected.add(fd)
            continue
        match = CLOSE_FD.match(line)
        if match:
            fd = int(match.group(1))
            if line.rstrip().endswith("= 0"):
                # strace can annotate close(4<UNIX-STREAM:[...]>).
                # A successful close removes that live capability.
                opened.discard(fd)
                connected.discard(fd)
            elif fd in opened or fd in connected:
                # An unconfirmed close is not evidence of release.
                raise ValueError("ambiguous tracked socket close result")
    return connected


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
        # strace -ff follows a PID across execve(). The same PID trace can
        # contain the unittest harness's earlier Unix connections before it
        # execs the fixed Python -c child. Do not count those as child effects.
        # Select the last successful fixed-child execve before its filter,
        # WITHOUT relaxing the one-connection requirement within that child.
        installs = [i for i, line in enumerate(lines) if FILTER_INSTALL in line
                    and "= 0" in line]
        if not installs:
            continue
        child_execs = [i for i, line in enumerate(lines[:installs[-1]])
                       if line.startswith("execve(") and '"-c"' in line
                       and line.rstrip().endswith("= 0")]
        if not child_execs:
            stages["no_fixed_child_execve"] += 1
            continue
        lines = lines[child_execs[-1]:]
        installs = [i for i, line in enumerate(lines) if FILTER_INSTALL in line
                    and "= 0" in line]
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
        # Closed setup connections are not live capabilities. The existing
        # fixed launcher independently audits all live /proc/self/fd handles
        # immediately before seccomp, and validates SO_PEERCRED UID + PID.
        # Reconstruct Unix socket lifetime from trace as an extra witness.
        live_connections = live_connected_unix_sockets(before)
        stages["live_connected_unix_count_" + str(min(len(live_connections), 9))] += 1
        # Sanitized evidence-only telemetry for failing trace qualification.
        # Never log raw strace lines, socket paths, peer data, or PID filenames.
        # The trusted in-child /proc/self/fd audit remains authoritative.
        # These counts help identify whether our tracer failed to observe
        # close()/close_range() or incorrectly selected a pre-child segment.
        close_calls = sum(line.startswith("close(") and line.endswith("= 0")
                          for line in before)
        close_range_calls = sum(line.startswith("close_range(") and
                                line.endswith("= 0") for line in before)
        stages["successful_close_count_" + str(min(close_calls, 20))] += 1
        stages["successful_close_range_count_" + str(min(close_range_calls, 9))] += 1
        stages["tracked_open_not_connected_" +
               str(min(len(set(int(m.group(1)) for line in before
                               if (m := SOCKET_FD.match(line))) -
                           live_connections), 9))] += 1
        if len(sockets) < 1 or len(connections) < 1 or len(live_connections) != 1:
            stages["pre_connection_mismatch"] += 1
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
            "live_connected_af_unix_at_filter": len(live_connections),
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
        "schema": "g3-r5-observed-syscalls-v4",
        "observed_outcome_counts": dict(sorted(outcomes.items())),
        "scope": "one tested fixed-marker authority request and HOLD-first denial; observed, non-exhaustive",
        "selection": "one live tracked pre-filter AF_UNIX connection at filter, successful seccomp install, post-filter authority reply; no successful post-filter socket/connect",
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
