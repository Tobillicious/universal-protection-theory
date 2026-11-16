"""Linux SO_PEERCRED authenticated single-request HOLD receipt exchange.

Research-only *connected socket* handler, not a listener/service/daemon.
Caller supplies a connected AF_UNIX socket, trusted issuer key, verified floor
and common fence. Kernel peer identity gates signing; public receipt proves
only HOLD at issuance. No publication/effect API is exposed.
"""
import json
import socket
import struct

from koru_signed_hold_receipt import issue_complete_receipt

MAX_FRAME = 4096


def _read_frame(sock):
    """Bounded newline framing: no implicit acceptance of truncated input."""
    raw = bytearray()
    while len(raw) <= MAX_FRAME:
        part = sock.recv(min(1024, MAX_FRAME + 1 - len(raw)))
        if not part:
            raise ValueError("incomplete request/response")
        raw.extend(part)
        if b"\n" in part:
            line, rest = bytes(raw).split(b"\n", 1)
            if rest or len(line) > MAX_FRAME:
                raise ValueError("trailing or oversized frame")
            return json.loads(line)
    raise ValueError("oversized frame")


def _send_frame(sock, data):
    payload = json.dumps(data, sort_keys=True, separators=(",", ":"),
                         allow_nan=False).encode("ascii") + b"\n"
    if len(payload) > MAX_FRAME:
        raise ValueError("oversized response")
    sock.sendall(payload)


def _peercred(sock):
    if not hasattr(socket, "SO_PEERCRED") or sock.family != socket.AF_UNIX:
        raise PermissionError("Linux Unix peer credentials required")
    raw = sock.getsockopt(socket.SOL_SOCKET, socket.SO_PEERCRED,
                          struct.calcsize("3i"))
    return struct.unpack("3i", raw)


def serve_one(sock, *, permitted_uid, private_key, floor, fence, issuer,
              endpoint_binding=None):
    """Handle exactly one query; never modifies HOLD state or authorizes effects.

    Intended for already accepted and provisioned AF_UNIX connections.
    Refuse invalid peer before reading request. No persistent listener.
    """
    if type(permitted_uid) is not int or permitted_uid < 0:
        raise ValueError("invalid UID policy")
    _pid, uid, _gid = _peercred(sock)
    if uid != permitted_uid:
        raise PermissionError("unauthorized peer UID")
    if endpoint_binding is not None:
        endpoint_binding.verify()
    request = _read_frame(sock)
    if (type(request) is not dict or set(request) != {"op", "nonce"} or
            request["op"] != "query_complete_hold" or
            type(request["nonce"]) is not str):
        raise ValueError("invalid HOLD query")
    signed = issue_complete_receipt(
        private_key, floor, fence, issuer=issuer, nonce=request["nonce"])
    _send_frame(sock, signed)


def query_one(sock, challenge_client, *, event_id, authority_ref,
              minimum_generation, expected_server_uid):
    """Pin Linux server UID BEFORE sending a query challenge.

    Also requires the caller's pinned issuer key in challenge_client. A UID
    alone is not a unique service identity, root-hardening, or consent proof.
    """
    if type(expected_server_uid) is not int or expected_server_uid < 0:
        raise ValueError("explicit server UID pin required")
    try:
        _pid, uid, _gid = _peercred(sock)
        if uid != expected_server_uid:
            return False
    except (PermissionError, OSError, ValueError, struct.error):
        return False
    nonce = challenge_client.begin(
        event_id=event_id, authority_ref=authority_ref,
        minimum_generation=minimum_generation)
    try:
        _send_frame(sock, {"op": "query_complete_hold", "nonce": nonce})
        receipt = _read_frame(sock)
    except (OSError, ValueError, UnicodeError, TypeError, json.JSONDecodeError):
        receipt = None
    return challenge_client.accept(nonce, receipt)
