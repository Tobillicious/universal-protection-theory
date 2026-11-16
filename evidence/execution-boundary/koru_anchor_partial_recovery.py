"""Conservative one-step recovery after anchor-first observer commit failure.

RESEARCH ONLY. The #561 anchored observer commits the separate anchor first,
then the client floor. A crash between commits leaves anchor one revision ahead.
This repair is allowed ONLY if both independently signed witness receipts
match the surviving anchor exactly, and the client floor is exactly one
contiguous predecessor. No remote state may decrease either store.

An operator MUST call this separate recovery path deliberately. Normal
observation remains fail-closed on disagreement. Successful reconciliation
is a history observation only, NEVER permission for a protected effect.

The four stores are still co-administrable, not hardware rollback resistant.
A coordinated rollback of all files still defeats this research model.
"""
from koru_monotonic_revision_witness import verify_receipt
from koru_retained_third_anchor import AnchoredTwoWitnessAgreement
from koru_two_witness_agreement import _BODY_FIELDS


def recover_anchor_first_partial_commit(anchored, primary_receipt,
                                        secondary_receipt):
    """Repair exactly one missing local observer commit, fail closed otherwise.

    Re-fetch both witness receipts over their authenticated transports before
    calling. This function checks signatures and retained-anchor continuity,
    but cannot itself prove time freshness or independent administration.
    """
    if not isinstance(anchored, AnchoredTwoWitnessAgreement):
        raise TypeError("explicit anchored two-witness agreement required")
    agreement = anchored.agreement
    a = verify_receipt(primary_receipt, agreement.floor.public_key)
    b = verify_receipt(secondary_receipt, agreement.secondary_public_key)
    if any(a[k] != b[k] for k in _BODY_FIELDS):
        raise PermissionError("two witnesses disagree on recovery state")
    observed = agreement.floor.read_floor()
    retained = anchored.anchor.read_floor()
    if (a["revision"], a["digest"], a["previous_digest"]) != retained:
        raise PermissionError("witness receipts do not match surviving anchor")
    if (retained[0] != observed[0] + 1 or
            retained[2] != observed[1]):
        raise PermissionError("not exactly one contiguous missing observer commit")
    # Anchor is deliberately not modified; the existing strictly monotonic
    # CAS floor validates the signature and predecessor before the write.
    result = agreement.floor.accept(primary_receipt)
    if anchored.anchor.read_floor() != agreement.floor.read_floor():
        raise PermissionError("anchor changed or post-repair inconsistency")
    return {"code": "one_step_observer_history_reconciled_only",
            "floor_result": result, "revision": a["revision"]}


def recover_from_two_authenticated_reads(primary_read, secondary_read, *,
                                         anchored):
    """Require TWO successful fresh-transport calls, with no quorum downgrade."""
    if (not callable(primary_read) or not callable(secondary_read) or
            primary_read is secondary_read):
        raise ValueError("two distinct witness read adapters required")
    first = primary_read()
    second = secondary_read()
    if (type(first) is not dict or type(second) is not dict or
            first.get("ok") is not True or second.get("ok") is not True or
            first.get("code") != "snapshot_only" or
            second.get("code") != "snapshot_only"):
        raise PermissionError("missing or uncertain recovery witness read")
    return recover_anchor_first_partial_commit(
        anchored, first["receipt"], second["receipt"])
