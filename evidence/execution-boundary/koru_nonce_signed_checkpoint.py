"""Nonce-bound Ed25519 checkpoint replies for the #545 read-only contrast.

A signed *snapshot* is not a remote transaction, irreversible history, or an
effect permit. Fixture signing key, socketpair and checkpoint are local; the
actual outside-host, nonrollbackable authority remains to be implemented.
"""
import secrets

from cryptography.exceptions import InvalidSignature
from cryptography.hazmat.primitives.asymmetric.ed25519 import (
    Ed25519PrivateKey, Ed25519PublicKey)
from koru_local_hold_ack_socket import _peercred, _read_frame, _send_frame
from koru_signed_remote_hold_witness import _encoded
from koru_external_checkpoint_contrast import _valid_checkpoint

DOMAIN = "koru-g3-external-checkpoint-v1"
FIELDS = frozenset(("domain", "nonce", "generation", "held", "event_id",
                    "authority_ref", "pending_ids"))


def serve_checkpoint_once(sock, *, private_key, checkpoint, permitted_uid):
    """Serve one pinned-UID requester from an externally supplied snapshot."""
    if not isinstance(private_key, Ed25519PrivateKey):
        raise TypeError("test-supplied signing key required")
    if type(permitted_uid) is not int or permitted_uid < 0:
        raise ValueError("requester UID required")
    _pid, uid, _gid = _peercred(sock)
    if uid != permitted_uid:
        raise PermissionError("untrusted requester")
    request = _read_frame(sock)
    if (type(request) is not dict or set(request) != {"op", "nonce"}
            or request["op"] != "checkpoint"
            or type(request["nonce"]) is not str
            or len(request["nonce"]) != 64
            or any(c not in "0123456789abcdef" for c in request["nonce"])):
        raise ValueError("bad checkpoint request")
    if not _valid_checkpoint(checkpoint):
        raise ValueError("invalid checkpoint state")
    body = dict(checkpoint, domain=DOMAIN, nonce=request["nonce"])
    _send_frame(sock, dict(body, signature=private_key.sign(_encoded(body)).hex()))


class SignedCheckpointReader:
    """One fresh authenticated snapshot; no effect-time serialization."""

    def __init__(self, connect, public_key, *, expected_server_uid):
        if not callable(connect) or not isinstance(public_key, Ed25519PublicKey):
            raise TypeError("connection factory and pinned key required")
        if type(expected_server_uid) is not int or expected_server_uid < 0:
            raise ValueError("server UID pin required")
        self._connect = connect
        self._key = public_key
        self._uid = expected_server_uid

    def read(self):
        nonce = secrets.token_hex(32)
        with self._connect() as sock:
            _pid, uid, _gid = _peercred(sock)
            if uid != self._uid:
                raise PermissionError("checkpoint server UID mismatch")
            _send_frame(sock, {"op": "checkpoint", "nonce": nonce})
            reply = _read_frame(sock)
        if (type(reply) is not dict or set(reply) != FIELDS | {"signature"}
                or reply.get("domain") != DOMAIN or reply.get("nonce") != nonce):
            raise ValueError("stale or malformed checkpoint")
        state = {k: reply[k] for k in
                 ("generation", "held", "event_id", "authority_ref", "pending_ids")}
        if not _valid_checkpoint(state):
            raise ValueError("invalid checkpoint state")
        signature = reply["signature"]
        if (type(signature) is not str or len(signature) != 128 or
                any(c not in "0123456789abcdef" for c in signature)):
            raise ValueError("invalid signature format")
        try:
            self._key.verify(bytes.fromhex(signature),
                             _encoded({k: reply[k] for k in FIELDS}))
        except InvalidSignature as exc:
            raise PermissionError("checkpoint signature mismatch") from exc
        return state
