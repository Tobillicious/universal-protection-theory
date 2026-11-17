"""Offline, read-only G3 Zelda event-evidence packet auditor.

Reads a separately collected JSON packet. It never calls Docker, imports
the authority process, grants execution, asserts a live deployment, or treats
caller-supplied records as independently authenticated proof.
"""
import argparse
import hashlib
import json
import os
import stat
from pathlib import Path
import re
import sys

from g3_r6_same_event_evidence_audit import SIX, audit_same_event

SHA40 = re.compile(r"[0-9a-f]{40}\Z")
FIELDS = frozenset({"schema", "source_commit", "scope", "declared_paths",
                    "events", "owed_by_event", "duties_by_event"})
MAX_BYTES = 1024 * 1024


def _strict_object(pairs):
    out = {}
    for k, v in pairs:
        if k in out:
            raise ValueError("duplicate JSON key: " + k)
        out[k] = v
    return out


def _bounded_unique_strings(value, what):
    if type(value) is not list or not value:
        raise ValueError("nonempty list required for " + what)
    if any(type(v) is not str for v in value) or len(set(value)) != len(value):
        raise ValueError("invalid or duplicated " + what)
    return set(value)


def inspect_packet(raw, *, expected_commit):
    if type(raw) is not bytes or len(raw) == 0 or len(raw) > MAX_BYTES:
        raise ValueError("invalid or oversized packet")
    if type(expected_commit) is not str or not SHA40.fullmatch(expected_commit):
        raise ValueError("independently pinned Git SHA required")
    try:
        packet = json.loads(raw.decode("utf-8"), object_pairs_hook=_strict_object)
    except (UnicodeDecodeError, json.JSONDecodeError) as e:
        raise ValueError("invalid JSON packet") from e
    if type(packet) is not dict or set(packet) != FIELDS:
        raise ValueError("event packet schema mismatch")
    if packet["schema"] != "g3-r6-zelda-observed-events-v1":
        raise ValueError("event packet version mismatch")
    if packet["source_commit"] != expected_commit:
        raise ValueError("source commit does not match independently pinned SHA")
    if (type(packet["scope"]) is not str
            or not 1 <= len(packet["scope"]) <= 500
            or not packet["scope"].strip()):
        raise ValueError("explicit bounded scope required")
    if type(packet["owed_by_event"]) is not dict or type(packet["duties_by_event"]) is not dict:
        raise ValueError("event-subject maps required")
    owed = {
        event: _bounded_unique_strings(subjects, "owed subjects at " + event)
        for event, subjects in packet["owed_by_event"].items()
    }
    # A claim of external verification is deliberately NOT an input field:
    # neither this JSON nor the caller may self-certify independence.
    report = audit_same_event(
        declared_paths=_bounded_unique_strings(packet["declared_paths"], "declared paths"),
        events=packet["events"],
        owed_by_event=owed,
        duties_by_event=packet["duties_by_event"],
        externally_verified_path_inventory=False,
        independently_authenticated_observers=False,
    )
    report["schema"] = "g3-r6-zelda-event-packet-audit-v1"
    report["source_commit"] = expected_commit
    report["scope"] = packet["scope"]
    report["packet_sha256"] = hashlib.sha256(raw).hexdigest()
    report["independence_self_certification_accepted"] = False
    return report


def read_packet_once(path):
    """Bounded regular-file read via the same no-follow descriptor.

    O_NONBLOCK ensures an attacker-swapped FIFO does not hang the auditor.
    The size is checked on the opened inode; extra bytes detect growth during
    read, and a changed inode size is rejected. External authentication and
    independent administration remain separate obligations.
    """
    if not hasattr(os, "O_NOFOLLOW"):
        raise ValueError("platform cannot enforce no-follow evidence opening")
    flags = os.O_RDONLY | os.O_NOFOLLOW | os.O_NONBLOCK
    if hasattr(os, "O_CLOEXEC"):
        flags |= os.O_CLOEXEC
    fd = os.open(path, flags)
    try:
        initial = os.fstat(fd)
        if not stat.S_ISREG(initial.st_mode):
            raise ValueError("packet input must be a regular file")
        if initial.st_size <= 0 or initial.st_size > MAX_BYTES:
            raise ValueError("invalid or oversized packet input")
        with os.fdopen(fd, "rb", closefd=False) as source:
            data = source.read(MAX_BYTES + 1)
        final = os.fstat(fd)
        if (not stat.S_ISREG(final.st_mode) or
                final.st_dev != initial.st_dev or
                final.st_ino != initial.st_ino or
                final.st_size != initial.st_size or
                len(data) != initial.st_size):
            raise ValueError("packet changed during read")
        if len(data) > MAX_BYTES:
            raise ValueError("oversized packet input")
        return data
    finally:
        os.close(fd)


def main():
    p = argparse.ArgumentParser(description="Non-authorizing Zelda event packet audit")
    p.add_argument("--packet", type=Path, required=True)
    p.add_argument("--expected-commit", required=True,
                   help="40-char commit independently obtained from trusted source")
    p.add_argument("--output", type=Path, required=True)
    args = p.parse_args()
    try:
        receipt = inspect_packet(read_packet_once(args.packet),
                                 expected_commit=args.expected_commit)
        # Exclusive write; never overwrite an existing forensic receipt.
        with args.output.open("x", encoding="utf-8") as out:
            json.dump(receipt, out, sort_keys=True, indent=2)
            out.write("\n")
    except (ValueError, OSError) as exc:
        print("G3 R6 packet rejected: " + str(exc), file=sys.stderr)
        return 1
    print("G3 R6 event packet audited; status=" + receipt["status"] +
          "; authorizes_effect=false")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
