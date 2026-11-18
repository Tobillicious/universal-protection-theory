"""Offline R5/R6 real-evidence inventory handoff: no effects or authorization.

A reviewer must independently obtain event and inventory files. Byte hashes
bind both documents for a separate signed R7 review. Even a good signature
cannot establish actual-world exhaustiveness or authentic consent.
"""
import hashlib
import json

from g3_r6_zelda_event_packet import inspect_packet
from g3_r7_external_review_signature import verify as verify_review

FIELDS = frozenset({"schema", "source_commit", "scope", "observed_event_ids",
                    "effect_paths", "examined_bypass_classes",
                    "unexamined_bypass_classes", "observer_ref"})
BYPASS = frozenset({"direct_file_writes", "inherited_write_fds",
                    "unix_socket_paths", "abstract_unix_sockets",
                    "network_sockets", "process_creation",
                    "alternate_writers", "privileged_host_admin"})


def _unique(values):
    if (type(values) is not list or len(set(values)) != len(values)
            or any(type(x) is not str or not 1 <= len(x) <= 200
                   or x.strip() != x for x in values)):
        raise ValueError("invalid or duplicate inventory identifiers")
    return set(values)


def _object(pairs):
    result = {}
    for key, value in pairs:
        if key in result:
            raise ValueError("duplicate inventory JSON field")
        result[key] = value
    return result


def inspect(*, event_bytes, inventory_bytes, expected_commit):
    if type(inventory_bytes) is not bytes or not 0 < len(inventory_bytes) <= 65536:
        raise ValueError("invalid inventory bytes")
    event_review = inspect_packet(event_bytes, expected_commit=expected_commit)
    try:
        inv = json.loads(inventory_bytes.decode("utf8"), object_pairs_hook=_object)
    except (UnicodeError, ValueError) as exc:
        raise ValueError("invalid inventory JSON: " + str(exc)) from exc
    if (type(inv) is not dict or set(inv) != FIELDS
            or inv["schema"] != "g3-r5-physical-inventory-v1"):
        raise ValueError("invalid inventory schema")
    if inv["source_commit"] != expected_commit or inv["scope"] != event_review["scope"]:
        raise ValueError("inventory source/scope mismatch")
    if (type(inv["observer_ref"]) is not str or
            not 1 <= len(inv["observer_ref"]) <= 200):
        raise ValueError("missing observer reference")
    ids = _unique(inv["observed_event_ids"])
    paths = _unique(inv["effect_paths"])
    checked = _unique(inv["examined_bypass_classes"])
    unchecked = _unique(inv["unexamined_bypass_classes"])
    if checked & unchecked or not (checked | unchecked) <= BYPASS:
        raise ValueError("overlapping or unknown bypass classes")
    packet = json.loads(event_bytes)
    gaps = list(event_review["unresolved"])
    if ids != {e["event_id"] for e in packet["events"]}:
        gaps.append("R5_R6_event_ids_disagree")
    if paths != {e["effect_path"] for e in packet["events"]} or paths != set(packet["declared_paths"]):
        gaps.append("R5_R6_effect_paths_disagree")
    for cls in sorted(BYPASS - checked - unchecked):
        gaps.append("bypass_class_unaccounted:" + cls)
    for cls in sorted(unchecked):
        gaps.append("bypass_class_unexamined:" + cls)
    digest = hashlib.sha256(
        b"UPT-G3-R5-R6-BUNDLE-V1\x00"
        + len(event_bytes).to_bytes(8, "big") + event_bytes
        + len(inventory_bytes).to_bytes(8, "big") + inventory_bytes
    ).hexdigest()
    return {
        "schema": "g3-r5-r6-joint-handoff-v1",
        "source_commit": expected_commit,
        "scope": inv["scope"],
        "event_sha256": hashlib.sha256(event_bytes).hexdigest(),
        "inventory_sha256": hashlib.sha256(inventory_bytes).hexdigest(),
        "joint_evidence_sha256": digest,
        "unresolved": sorted(gaps),
        "independent_custody_verified": False,
        "hCoverage_proved": False,
        "hMeaning_proved": False,
        "universal_physical_protection_proved": False,
        "authorizes_effect": False,
        "may_clear_hold": False,
        "may_merge_or_deploy": False,
    }


def inspect_signed(*, event_bytes, inventory_bytes, expected_commit,
                   review_bytes, review_signature, pinned_reviewer_public_key):
    report = inspect(event_bytes=event_bytes, inventory_bytes=inventory_bytes,
                     expected_commit=expected_commit)
    review = verify_review(
        review_bytes=review_bytes, signature=review_signature,
        reviewer_public_key=pinned_reviewer_public_key,
        expected_head=expected_commit,
        expected_evidence_sha256=report["joint_evidence_sha256"])
    if review["signature_valid_for_supplied_public_key"] is not True:
        raise ValueError("R7 external signature validation failed")
    report["detached_review_signature_verified"] = True
    report["reviewer_decision"] = review["decision"]
    return report
