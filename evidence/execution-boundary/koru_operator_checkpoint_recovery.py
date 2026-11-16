"""Agent 3: independently signed checkpoint challenge before partial recovery.

Research-only interface, NOT an independent deployed operator. The operator
private key and storage MUST be outside the application's rollback domain.
An authenticated response must bind the caller's fresh challenge to the
surviving checkpoint. This does not establish a distributed transaction,
HOLD liveness, or permission for an effect.
"""
import json
import secrets

from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PublicKey
from cryptography.exceptions import InvalidSignature

from koru_anchor_partial_recovery import recover_from_two_authenticated_reads
from koru_retained_third_anchor import AnchoredTwoWitnessAgreement
from koru_two_witness_agreement import _key_bytes

DOMAIN = "koru-g3-operator-checkpoint-challenge-v1"
_FIELDS = frozenset(("domain", "nonce", "revision", "digest", "previous_digest"))


def _encode(body):
    return json.dumps(body, sort_keys=True, separators=(",", ":"),
                      allow_nan=False).encode("ascii")


def verify_operator_response(response, public_key, nonce, expected_floor):
    """Validate the distinct operator's challenge-bound exact checkpoint."""
    if not isinstance(public_key, Ed25519PublicKey):
        raise ValueError("pinned operator verification key required")
    if (type(response) is not dict or set(response) != _FIELDS | {"signature"} or
            response.get("domain") != DOMAIN or
            response.get("nonce") != nonce or
            type(nonce) is not str or len(nonce) != 64 or
            any(c not in "0123456789abcdef" for c in nonce) or
            type(response.get("revision")) is not int or
            type(response.get("digest")) is not str or
            type(response.get("previous_digest")) is not str or
            type(response.get("signature")) is not str):
        raise PermissionError("invalid operator checkpoint response")
    body = {key: response[key] for key in _FIELDS}
    try:
        signature = bytes.fromhex(response["signature"])
        if len(signature) != 64:
            raise ValueError("wrong signature length")
        public_key.verify(signature, _encode(body))
    except (InvalidSignature, ValueError, UnicodeError) as exc:
        raise PermissionError("invalid operator checkpoint signature") from exc
    if (body["revision"], body["digest"], body["previous_digest"]) != expected_floor:
        raise PermissionError("independent checkpoint differs from retained history")
    return True


def recover_with_operator_checkpoint(*, anchored, primary_read, secondary_read,
                                     operator_read, operator_public_key):
    """One-step observer repair only, gated by a fresh signed operator response.

    The operator_read(nonce) interface MUST obtain a fresh authenticated
    response from a separately administered custody service. This function
    cannot verify who administers it. No path authorizes any effect.
    """
    if not isinstance(anchored, AnchoredTwoWitnessAgreement):
        raise TypeError("existing anchored agreement required")
    if (not callable(primary_read) or not callable(secondary_read) or
            not callable(operator_read) or
            len({id(primary_read), id(secondary_read), id(operator_read)}) != 3):
        raise ValueError("three distinct read adapters required")
    if (not isinstance(operator_public_key, Ed25519PublicKey) or
            _key_bytes(operator_public_key) in {
                _key_bytes(anchored.agreement.floor.public_key),
                _key_bytes(anchored.agreement.secondary_public_key)}):
        raise ValueError("separate pinned operator signing key required")

    checkpoint = anchored.anchor.read_floor()
    nonce = secrets.token_hex(32)
    result = operator_read(nonce)
    verify_operator_response(result, operator_public_key, nonce, checkpoint)

    # The existing #562 checks two signed witnesses, exact contiguous
    # predecessor, and refuses anchor mutations or gaps. It only advances
    # the lagging observer floor; it cannot un-HOLD or authorize effects.
    recovered = recover_from_two_authenticated_reads(
        primary_read, secondary_read, anchored=anchored)
    if anchored.anchor.read_floor() != checkpoint:
        raise PermissionError("retained checkpoint changed during recovery")
    # A new, independently challenged observation catches operator history
    # moving while the observer was repaired. No rollback of the monotone
    # observer is attempted on mismatch: this is a history-only refusal.
    # This is NOT cross-host atomicity: changes after this final read are
    # outside the guarantees of this research fixture.
    post_nonce = secrets.token_hex(32)
    post = operator_read(post_nonce)
    verify_operator_response(post, operator_public_key, post_nonce, checkpoint)
    if anchored.anchor.read_floor() != checkpoint:
        raise PermissionError("retained checkpoint changed after operator recheck")
    return {"code": "operator_checkpoint_history_reconciled_only",
            "revision": recovered["revision"], "authorizes_effect": False}
