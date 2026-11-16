"""Third separately retained observation: research-only rollback contrast.

Two witnesses and a client floor cannot notice coordinated rollback of all
three SQLite stores. An additional *separately retained* anchor detects that
attack ONLY IF the anchor survives and is trusted. Here the anchor is STILL
an ordinary local SQLite file, NOT independent host/storage or an append-only
hardware monotonic counter. This is deliberately fail-closed on partial
commit: reconciliation is an outstanding engineering obligation.

No effect permit is returned. Never provision an anchor from an untrusted
remote latest read. Provision only from an explicitly trusted signed receipt.
"""
from koru_client_revision_floor import ClientRevisionFloor
from koru_monotonic_revision_witness import verify_receipt
from koru_two_witness_agreement import TwoWitnessAgreement, _BODY_FIELDS


class AnchoredTwoWitnessAgreement:
    """Require two signers, plus surviving anchor AND client floor."""

    def __init__(self, agreement, anchor):
        if (not isinstance(agreement, TwoWitnessAgreement) or
                not isinstance(anchor, ClientRevisionFloor) or
                anchor.path == agreement.floor.path):
            raise ValueError("two-witness agreement and separate anchor required")
        # An anchor signed by another principal would need its own
        # explicit cross-principal statement; v1 pins the same trusted
        # primary witness key and requires a separate storage path.
        from koru_two_witness_agreement import _key_bytes
        if _key_bytes(anchor.public_key) != _key_bytes(agreement.floor.public_key):
            raise ValueError("anchor and observer must use same trusted key")
        self.agreement = agreement
        self.anchor = anchor

    def accept_pair(self, primary_receipt, secondary_receipt):
        """Check both and retain anchor before client floor.

        If the second commit fails, subsequent calls DENY while anchors are
        inconsistent. No invented recovery by overwriting the surviving
        anchor with the lower client floor.
        """
        a = verify_receipt(primary_receipt, self.agreement.floor.public_key)
        b = verify_receipt(secondary_receipt,
                           self.agreement.secondary_public_key)
        if any(a[k] != b[k] for k in _BODY_FIELDS):
            raise PermissionError("witnesses disagree on history")
        if self.anchor.read_floor() != self.agreement.floor.read_floor():
            raise PermissionError("client floor and retained anchor disagree")
        anchor_status = self.anchor.accept(primary_receipt)
        # An error HERE leaves an anchor-ahead state. The next call will
        # deny until a separately designed recovery protocol repairs it.
        observer_status = self.agreement.floor.accept(primary_receipt)
        return {"code":"two_witness_anchored_history_only",
                "anchor_result":anchor_status,
                "observer_result":observer_status,
                "revision":a["revision"]}


def observe_anchored_two_services(primary_read, secondary_read, *, anchored):
    """Two pinned mTLS read adapters, plus third retained observation."""
    if not isinstance(anchored, AnchoredTwoWitnessAgreement):
        raise TypeError("explicit anchored agreement required")
    if (not callable(primary_read) or not callable(secondary_read) or
            primary_read is secondary_read):
        raise ValueError("two separate trusted mTLS adapters required")
    a = primary_read()
    b = secondary_read()
    if (type(a) is not dict or type(b) is not dict or
            a.get("ok") is not True or b.get("ok") is not True or
            a.get("code") != "snapshot_only" or
            b.get("code") != "snapshot_only"):
        raise PermissionError("missing or uncertain witness read")
    return anchored.accept_pair(a["receipt"], b["receipt"])
