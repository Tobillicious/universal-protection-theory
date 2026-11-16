"""Distinct-UID Unix socket revision witness, disposable Linux research.

Runs the #554 CAS journal under its own unprivileged UID. The requester's
UID can neither read the Ed25519 private key nor alter the SQLite history.
Pinned SO_PEERCRED authorizes a single fixed client identity. No arbitrary
file paths or commands are supplied by the caller.

This is NOT an independent host / administrative domain. Host root retains
control of both processes and persistent history, and can rewind the DB/key.
Replies are historical attestations, NEVER effect permits. A lost reply must
be reconciled through read(), not retried as a new operation.
"""
import json
import os
import socket
import socketserver
import stat
import struct

from cryptography.hazmat.primitives import serialization
from koru_monotonic_revision_witness import (
    MonotonicRevisionWitness, _digest, verify_receipt)

MAX_REQUEST = 4096


def _send(stream, result):
    stream.write((json.dumps(result, sort_keys=True, separators=(",", ":"))
                  + "\n").encode("ascii"))


class _Handler(socketserver.StreamRequestHandler):
    def handle(self):
        try:
            peer = self.request.getsockopt(
                socket.SOL_SOCKET, socket.SO_PEERCRED, struct.calcsize("3i"))
            _pid, uid, _gid = struct.unpack("3i", peer)
            if uid != self.server.client_uid:
                return _send(self.wfile, {"ok": False, "code": "peer_denied"})
            data = self.rfile.readline(MAX_REQUEST + 1)
            if not data.endswith(b"\n") or len(data) > MAX_REQUEST:
                return _send(self.wfile, {"ok": False, "code": "bad_request"})
            query = json.loads(data)
            if query == {"op": "read"}:
                return _send(self.wfile, {"ok": True, "code": "snapshot_only",
                                          "receipt": self.server.witness.read()})
            if (type(query) is dict and
                    set(query) == {"op", "snapshot", "revision", "digest"} and
                    query["op"] == "advance"):
                outcome = self.server.witness.advance(
                    query["snapshot"], expected_revision=query["revision"],
                    expected_digest=query["digest"])
                return _send(self.wfile, outcome)
            return _send(self.wfile, {"ok": False, "code": "bad_request"})
        except Exception as exc:
            # Diagnostic is stderr-only; never disclose state/key via RPC.
            import sys
            print("research witness error:", type(exc).__name__, str(exc),
                  file=sys.stderr, flush=True)
            try:
                _send(self.wfile, {"ok": False,
                                   "code": "witness_unavailable_or_uncertain"})
            except OSError:
                pass


class CrossUidRevisionWitness(socketserver.ThreadingUnixStreamServer):
    daemon_threads = True
    block_on_close = True

    def __init__(self, path, database, key_path, *, client_uid):
        if (os.geteuid() == 0 or type(client_uid) is not int or
                client_uid <= 0 or client_uid == os.geteuid()):
            raise ValueError("distinct nonroot witness and client UIDs required")
        for filename in (database, key_path):
            st = os.stat(filename, follow_symlinks=False)
            if (not stat.S_ISREG(st.st_mode) or
                    st.st_uid != os.geteuid() or
                    stat.S_IMODE(st.st_mode) & 0o077):
                raise PermissionError("witness state/key must be owner private")
        with open(key_path, "rb") as keyfile:
            private = serialization.load_pem_private_key(keyfile.read(),
                                                         password=None)
        self.witness = MonotonicRevisionWitness(database, private)
        self.witness.read()  # fail closed if missing/corrupt; never provision
        self.client_uid = client_uid
        super().__init__(path, _Handler)
        os.chmod(path, 0o666)


def request_witness(path, query, *, expected_uid, public_key):
    """Pinned witness UID and Ed25519 verification; fail on no response."""
    with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as sock:
        sock.settimeout(3)
        sock.connect(path)
        peer = sock.getsockopt(socket.SOL_SOCKET, socket.SO_PEERCRED,
                               struct.calcsize("3i"))
        _pid, uid, _gid = struct.unpack("3i", peer)
        if uid != expected_uid:
            raise PermissionError("unexpected witness principal")
        sock.sendall((json.dumps(query, sort_keys=True) + "\n").encode())
        result = bytearray()
        while not result.endswith(b"\n"):
            chunk = sock.recv(4096)
            if not chunk or len(result) + len(chunk) > MAX_REQUEST * 2:
                raise ValueError("missing/truncated witness acknowledgment")
            result.extend(chunk)
    payload = json.loads(result)
    if type(payload) is not dict or type(payload.get("ok")) is not bool:
        raise ValueError("malformed witness acknowledgment")
    if payload["ok"] and payload.get("code") in (
            "snapshot_only", "revision_committed"):
        verify_receipt(payload["receipt"], public_key)
    return payload
