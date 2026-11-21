"""Two independently signed, all-of-two witness observation: research only.

Both independent witness signing keys must attest precisely the same revision,
digest, and predecessor. The client floor records agreed observations only
AFTER both signatures and consensus checks succeed. Any outage, lag, fork,
invalid signature, or lost reply denies the observation and does not advance
its floor. No effect permit can be obtained through this module.

This is all-of-two availability, NOT consensus among Byzantine replicas:
two witnesses may be administered by one actor, collude, both roll back, or
observe different times during sequential reads. Test-time separate keys do
NOT establish separate hardware, administrators, or rollback-resistant storage.
"""
from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PublicKey

from koru_client_revision_floor import ClientRevisionFloor
from koru_monotonic_revision_witness import verify_receipt

_BODY_FIELDS = ("domain", "revision", "digest", "previous_digest")


def _key_bytes(key):
    if not isinstance(key, Ed25519PublicKey):
        raise TypeError("Ed25519 witness verification key required")
    return key.public_bytes(
        encoding=serialization.Encoding.Raw,
        format=serialization.PublicFormat.Raw)


class TwoWitnessAgreement:
    """Require two distinct trusted Ed25519 keys and a retained client floor."""

    def __init__(self, floor, secondary_public_key):
        if not isinstance(floor, ClientRevisionFloor):
            raise TypeError("trusted provisioned observer floor required")
        if (_key_bytes(floor.public_key) ==
                _key_bytes(secondary_public_key)):
            raise ValueError("two distinct signing identities required")
        self.floor = floor
        self.secondary_public_key = secondary_public_key

    def accept_pair(self, receipt_a, receipt_b):
        """Check both first; one durable client-floor update after agreement."""
        a = verify_receipt(receipt_a, self.floor.public_key)
        b = verify_receipt(receipt_b, self.secondary_public_key)
        if any(a[k] != b[k] for k in _BODY_FIELDS):
            raise PermissionError("witnesses disagree on history")
        result = self.floor.accept(receipt_a)
        return {"code": "two_witness_history_observed_only",
                "floor_result": result, "revision": a["revision"],
                "digest": a["digest"]}


def observe_two_mtls_witnesses(primary, secondary, *, agreement):
    """Read both pinned mTLS witness endpoints before recording agreement.

    primary/secondary are callables with zero arguments, each independently
    configured to call request_mtls_witness with its OWN pinned server cert,
    expected hostname, TLS context, public receipt key and endpoint.
    Neither the callables nor this function conveys effects authorization.
    """
    if not isinstance(agreement, TwoWitnessAgreement):
        raise TypeError("two-witness agreement required")
    if not callable(primary) or not callable(secondary) or primary is secondary:
        raise ValueError("two separate witness request adapters required")
    a = primary()
    b = secondary()
    if (type(a) is not dict or type(b) is not dict or
            a.get("ok") is not True or b.get("ok") is not True or
            a.get("code") != "snapshot_only" or
            b.get("code") != "snapshot_only"):
        raise PermissionError("two-witness read missing or uncertain")
    return agreement.accept_pair(a["receipt"], b["receipt"])
