"""Offline G3 R4/R5/R6 evidence-to-WORM handoff; no effect authority.

Uses existing joint-event+inventory digest and signed operator checkpoint.
An O_EXCL local file is NOT independent or administrator-resistant WORM.
"""
import hashlib
import json
import os
import re
import stat

from g3_real_effect_inventory_handoff import inspect as inspect_joint
from koru_operator_checkpoint_recovery import verify_operator_response

SCHEMA = "g3-worm-r4-r5-r6-v1"
FIELDS = frozenset({"schema", "source_commit", "event_sha256",
 "inventory_sha256", "joint_evidence_sha256", "scope",
 "operator_checkpoint", "unresolved", "independent_custody_verified",
 "hCoverage_proved", "hMeaning_proved", "universal_G3_proved",
 "authorizes_effect", "may_clear_hold"})

def canonical(value):
    return json.dumps(value, sort_keys=True, separators=(",", ":"),
                      allow_nan=False, ensure_ascii=True).encode("ascii")

def sha(raw):
    if type(raw) is not bytes or not 0 < len(raw) <= 1048576:
        raise ValueError("missing or oversized evidence bytes")
    return hashlib.sha256(raw).hexdigest()

def no_duplicates(pairs):
    out = {}
    for key, value in pairs:
        if key in out:
            raise ValueError("duplicate JSON field")
        out[key] = value
    return out

def assemble(*, event_bytes, inventory_bytes, expected_commit,
             operator_response, challenge_nonce, expected_floor,
             operator_public_key):
    """Operator key, nonce and checkpoint floor must be pinned out of band."""
    if type(expected_commit) is not str or not re.fullmatch("[0-9a-f]{40}", expected_commit):
        raise ValueError("expected exact source commit")
    report = inspect_joint(event_bytes=event_bytes,
                           inventory_bytes=inventory_bytes,
                           expected_commit=expected_commit)
    verify_operator_response(operator_response, operator_public_key,
                             challenge_nonce, expected_floor)
    return canonical({
        "schema": SCHEMA, "source_commit": expected_commit,
        "event_sha256": sha(event_bytes),
        "inventory_sha256": sha(inventory_bytes),
        "joint_evidence_sha256": report["joint_evidence_sha256"],
        "scope": report["scope"],
        "operator_checkpoint": operator_response,
        "unresolved": report["unresolved"],
        "independent_custody_verified": False,
        "hCoverage_proved": False, "hMeaning_proved": False,
        "universal_G3_proved": False, "authorizes_effect": False,
        "may_clear_hold": False,
    })

def inspect(*, bundle_bytes, event_bytes, inventory_bytes, expected_commit,
            challenge_nonce, expected_floor, operator_public_key):
    if type(bundle_bytes) is not bytes or not 0 < len(bundle_bytes) <= 1048576:
        raise ValueError("invalid bundle bytes")
    try:
        record = json.loads(bundle_bytes.decode("utf8"), object_pairs_hook=no_duplicates)
    except (ValueError, UnicodeError) as exc:
        raise ValueError("invalid bundle JSON") from exc
    if type(record) is not dict or set(record) != FIELDS or record.get("schema") != SCHEMA:
        raise ValueError("invalid bundle schema")
    if record["source_commit"] != expected_commit:
        raise ValueError("wrong source commit")
    expected = assemble(event_bytes=event_bytes, inventory_bytes=inventory_bytes,
        expected_commit=expected_commit,
        operator_response=record["operator_checkpoint"],
        challenge_nonce=challenge_nonce, expected_floor=expected_floor,
        operator_public_key=operator_public_key)
    if bundle_bytes != expected:
        raise ValueError("bundle noncanonical, altered, or evidence mismatch")
    return {"bundle_sha256": sha(bundle_bytes),
            "joint_evidence_sha256": record["joint_evidence_sha256"],
            "unresolved": record["unresolved"], "operator_signature_verified": True,
            "independent_custody_verified": False, "hCoverage_proved": False,
            "hMeaning_proved": False, "universal_G3_proved": False,
            "authorizes_effect": False, "may_clear_hold": False}

def local_write_once(directory, bundle_bytes):
    """Exclusive fsynced local object. Host administrator can still remove it."""
    digest = sha(bundle_bytes)
    if type(directory) is not str or not directory:
        raise ValueError("directory required")
    dir_fd = os.open(directory, os.O_RDONLY | os.O_DIRECTORY | os.O_NOFOLLOW)
    try:
        mode = os.fstat(dir_fd).st_mode
        if not stat.S_ISDIR(mode) or mode & 0o022:
            raise ValueError("directory must not be group/world writable")
        name = digest + ".json"
        fd = os.open(name, os.O_WRONLY | os.O_CREAT | os.O_EXCL | os.O_NOFOLLOW,
                     0o600, dir_fd=dir_fd)
        with os.fdopen(fd, "wb") as output:
            output.write(bundle_bytes)
            output.flush()
            os.fsync(output.fileno())
        os.fsync(dir_fd)
        return name
    finally:
        os.close(dir_fd)
