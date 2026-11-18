"""G3 physical last-mile review: join scoped R5, R6 and quorum on ONE packet.

This only checks consistency of supplied evidence and registered signatures.
It cannot prove independently complete actual-world effects, real independent
custody, authentic subject meaning, or universal protection. Never authorizes
effects, clears HOLD, merges or deploys.
"""
import hashlib
import json

from g3_r6_zelda_event_packet import inspect_packet
from g3_quorum_certificate_check import verify as verify_quorum

_GATES = (
    "R4_independent_quorum_custody",
    "R5_independent_effect_path_completeness",
    "R6_authentic_six_duties",
    "R7_independent_replay_and_acceptance",
    "UNIVERSAL_actual_world_correspondence",
)


def evaluate(*, packet_bytes, expected_commit, certificate_bytes,
             trusted_roster, independently_pinned_roster_sha256):
    """All inputs explicitly supplied by reviewer; no source trust inferred.

    Signatures cover SHA256 of exactly the bytes parsed by the event auditor.
    The roster fingerprint is independently pinned rather than read from the
    submitted certificate. A matching cryptographic quorum is NOT a custody
    or X3 certificate.
    """
    if type(packet_bytes) is not bytes:
        raise ValueError("packet must be immutable bytes")
    packet_report = inspect_packet(packet_bytes, expected_commit=expected_commit)
    if type(trusted_roster) is not dict or not trusted_roster:
        raise ValueError("independent pinned roster required")
    canonical_roster = json.dumps(trusted_roster, sort_keys=True,
                                  separators=(",", ":"), ensure_ascii=True).encode()
    roster_digest = hashlib.sha256(canonical_roster).hexdigest()
    if (type(independently_pinned_roster_sha256) is not str
            or roster_digest != independently_pinned_roster_sha256):
        raise ValueError("independent roster pin mismatch")
    packet_digest = hashlib.sha256(packet_bytes).hexdigest()
    quorum = verify_quorum(certificate_bytes, expected_sha=packet_digest,
                           trusted_roster=trusted_roster)
    if packet_report["packet_sha256"] != packet_digest:
        raise ValueError("event packet digest changed across validation")
    if (quorum["authorizes_effect"] is not False
            or quorum["may_clear_hold"] is not False
            or packet_report["authorizes_effect"] is not False):
        raise ValueError("review-only boundary violated")
    gaps = list(packet_report["unresolved"])
    if not quorum["cryptographic_threshold_met"]:
        gaps.append("R4_signed_review_threshold_missing")
    return {
        "schema": "g3-joint-r5-r6-quorum-review-v1",
        "scope": packet_report["scope"],
        "source_commit": expected_commit,
        "event_packet_sha256": packet_digest,
        "independently_pinned_roster_sha256": roster_digest,
        "scoped_event_count": packet_report["events_reconciled"],
        "registered_valid_signatures": quorum["valid_signatures"],
        "required_signatures": quorum["required_signatures"],
        "signature_threshold_met": quorum["cryptographic_threshold_met"],
        "unresolved_scoped_evidence": sorted(gaps),
        "open_external_gates": list(_GATES),
        "status": ("SIGNED_BOUNDED_REVIEW_REQUIRES_INDEPENDENT_VALIDATION"
                   if quorum["cryptographic_threshold_met"]
                   else "BLOCKED_NO_SIGNED_QUORUM"),
        "hCoverage_proved": False,
        "hMeaning_proved": False,
        "independent_custody_verified": False,
        "universal_physical_protection_proved": False,
        "authorizes_effect": False,
        "may_clear_hold": False,
        "may_merge_or_deploy": False,
    }
