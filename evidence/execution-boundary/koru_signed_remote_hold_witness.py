"""Fresh signed remote HOLD witness query over a preconnected Linux Unix socket.

Research only. No deployed witness, listener, persistent/rollback-resistant
storage or consent source. An external, independently durable and ordered state
provider is REQUIRED before this can become production anti-rollback evidence.
"""
import json
import os
import secrets

from cryptography.exceptions import InvalidSignature
from cryptography.hazmat.primitives.asymmetric.ed25519 import (
    Ed25519PrivateKey, Ed25519PublicKey)
from koru_local_hold_ack_socket import _peercred, _read_frame, _send_frame

DOMAIN = "koru-g3-independent-hold-witness-v1"
FIELDS = frozenset(("domain", "nonce", "generation", "held",
                    "event_id", "authority_ref"))


def _valid_state(state):
    return (type(state) is dict and
            set(state) == {"generation", "held", "event_id", "authority_ref"} and
            type(state["generation"]) is int and state["generation"] >= 1 and
            type(state["held"]) is bool and
            type(state["event_id"]) is str and
            0 < len(state["event_id"]) <= 512 and state["event_id"].isascii() and
            type(state["authority_ref"]) is str and
            0 < len(state["authority_ref"]) <= 512 and
            state["authority_ref"].isascii())


def _encoded(body):
    return json.dumps(body, sort_keys=True, separators=(",", ":"),
                      ensure_ascii=True, allow_nan=False).encode("ascii")


def serve_witness_once(sock, *, private_key, state, permitted_uid):
    """Serve one query from already authenticated requester; never updates state.

    State must originate outside the local floor rollback domain. The fixture
    deliberately supplies synthetic state and therefore does not meet it.
    """
    if not isinstance(private_key, Ed25519PrivateKey):
        raise TypeError("independently provisioned Ed25519 private key required")
    if type(permitted_uid) is not int or permitted_uid < 0:
        raise ValueError("permitted UID required")
    _pid, uid, _gid = _peercred(sock)
    if uid != permitted_uid:
        raise PermissionError("unauthorized witness requester")
    query = _read_frame(sock)
    if (type(query) is not dict or set(query) != {"op", "nonce"} or
            query["op"] != "read_hold_witness" or
            type(query["nonce"]) is not str or len(query["nonce"]) != 64 or
            any(c not in "0123456789abcdef" for c in query["nonce"])):
        raise ValueError("invalid witness query")
    if not _valid_state(state):
        raise ValueError("invalid independent witness state")
    body = dict(state, domain=DOMAIN, nonce=query["nonce"])
    _send_frame(sock, dict(body, signature=private_key.sign(_encoded(body)).hex()))


class SignedWitnessReader:
    """One-shot signed witness reader implementing #538's read() interface."""

    def __init__(self, connect, public_key, *, expected_server_uid):
        if not callable(connect) or not isinstance(public_key, Ed25519PublicKey):
            raise TypeError("explicit connection factory and pinned key required")
        if type(expected_server_uid) is not int or expected_server_uid < 0:
            raise ValueError("server UID pin required")
        self._connect = connect
        self._public_key = public_key
        self._uid = expected_server_uid

    def read(self):
        # New 256-bit challenge per attempted read. The response must bind to
        # this nonce and independent pinned verification key.
        nonce = secrets.token_hex(32)
        with self._connect() as sock:
            _pid, uid, _gid = _peercred(sock)
            if uid != self._uid:
                raise PermissionError("untrusted witness server UID")
            _send_frame(sock, {"op": "read_hold_witness", "nonce": nonce})
            response = _read_frame(sock)
        if (type(response) is not dict or
                set(response) != FIELDS | {"signature"} or
                response.get("domain") != DOMAIN or
                response.get("nonce") != nonce):
            raise ValueError("missing or stale independent witness response")
        state = {key: response[key] for key in
                 ("generation", "held", "event_id", "authority_ref")}
        if not _valid_state(state):
            raise ValueError("malformed independent witness state")
        signature = response["signature"]
        if (type(signature) is not str or len(signature) != 128 or
                any(c not in "0123456789abcdef" for c in signature)):
            raise ValueError("invalid witness signature encoding")
        try:
            self._public_key.verify(
                bytes.fromhex(signature),
                _encoded({key: response[key] for key in FIELDS}))
        except InvalidSignature as exc:
            raise PermissionError("independent witness signature failed") from exc
        return state
