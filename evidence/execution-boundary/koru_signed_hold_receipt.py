"""Challenge-bound Ed25519 HOLD receipts for isolated G3 research.

ONLY the trusted receipt issuer holds the private key. These receipts are
evidence for a particular nonce-bound query, NOT authorization to publish,
and NOT proof of a later state. Signature checking cannot replace a fresh
effect-time fence and protected floor read. No production socket/issuer.
"""
import json
from cryptography.exceptions import InvalidSignature
from cryptography.hazmat.primitives.asymmetric.ed25519 import (
    Ed25519PrivateKey, Ed25519PublicKey)

VERSION = "koru-g3-hold-receipt-v1"
FIELDS = frozenset(("version", "issuer", "nonce", "status", "generation",
                    "event_id", "authority_ref", "signature"))
BODY_FIELDS = FIELDS - {"signature"}


def _valid_text(value, maximum):
    return type(value) is str and 0 < len(value) <= maximum and value.isascii()


def _body(*, issuer, nonce, generation, event_id, authority_ref):
    if (not _valid_text(issuer, 128) or
            type(nonce) is not str or len(nonce) != 64 or
            any(c not in "0123456789abcdef" for c in nonce) or
            type(generation) is not int or generation < 1 or
            not _valid_text(event_id, 512) or
            not _valid_text(authority_ref, 512)):
        raise ValueError("invalid HOLD receipt context")
    return {"version": VERSION, "issuer": issuer, "nonce": nonce,
            "status": "hold_complete", "generation": generation,
            "event_id": event_id, "authority_ref": authority_ref}


def _serialize(value):
    return json.dumps(value, sort_keys=True, separators=(",", ":"),
                      ensure_ascii=True, allow_nan=False).encode("ascii")


def issue_complete_receipt(private_key, floor, fence, *, issuer, nonce):
    """Root/trusted issuer only; sign under common lock AFTER durable HOLD.

    The floor reference must be independently root-owned and verified.
    A pending/inconsistent state cannot produce a completed receipt.
    """
    if not isinstance(private_key, Ed25519PrivateKey):
        raise TypeError("trusted Ed25519 issuer key required")
    with fence:
        result = floor.hold_status(fence)
        if result.get("code") != "hold_complete" or result.get("ok") is not True:
            raise PermissionError("completed HOLD not verified")
        state = floor.read()
        if state["held"] is not True or result["generation"] != state["generation"]:
            raise PermissionError("HOLD state changed")
        body = _body(issuer=issuer, nonce=nonce,
                     generation=state["generation"],
                     event_id=state["event_id"],
                     authority_ref=state["authority_ref"])
        return {**body, "signature": private_key.sign(_serialize(body)).hex()}


def verify_complete_receipt(public_key, receipt, *, issuer, nonce,
                            event_id, authority_ref, minimum_generation):
    """Pin issuer public key + fresh, single-use query challenge externally.

    A caller MUST generate a new unpredictable nonce for EACH status query,
    and never accept a receipt for an earlier nonce. Offline signature
    verification does not independently detect root-floor rollback.
    """
    try:
        if not isinstance(public_key, Ed25519PublicKey):
            return False
        if type(receipt) is not dict or set(receipt) != FIELDS:
            return False
        if type(minimum_generation) is not int or minimum_generation < 1:
            return False
        expected = _body(issuer=issuer, nonce=nonce,
                         generation=receipt["generation"],
                         event_id=event_id, authority_ref=authority_ref)
        if any(receipt.get(k) != v for k, v in expected.items()):
            return False
        if receipt["generation"] < minimum_generation:
            return False
        sig = receipt["signature"]
        if (type(sig) is not str or len(sig) != 128 or
                any(c not in "0123456789abcdef" for c in sig)):
            return False
        public_key.verify(bytes.fromhex(sig), _serialize(expected))
        return True
    except (InvalidSignature, ValueError, TypeError, KeyError, OverflowError):
        return False
