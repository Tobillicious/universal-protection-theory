"""Loopback-only mTLS transport for the G3 revision witness research fixture.

Reuses #556's monotone protection-state CAS journal and signed receipts.
TLS server requires a pinned CA-signed client certificate and additionally
checks the exact authorized client certificate SHA-256 DER fingerprint.
Client verifies certificate chain and DNS hostname, and pins server DER
fingerprint. No fallback to plaintext; error or uncertain reply fails closed.

A loopback TLS test is NOT independent hosting, rollback-resistant storage,
production key lifecycle, replay-safe administrative authorization, or an
effect-time fence. Receipt validation is necessary but NOT an effect permit.
"""
import hashlib
import json
import socket
import socketserver
import ssl

from cryptography.hazmat.primitives import serialization
from koru_monotonic_revision_witness import MonotonicRevisionWitness, verify_receipt

MAX_REQUEST = 4096
MAX_REPLY = 8192


def _fingerprint(der):
    if type(der) is not bytes or not der:
        raise ValueError("missing certificate")
    return hashlib.sha256(der).hexdigest()


def _valid_fingerprint(value):
    return (type(value) is str and len(value) == 64 and
            all(c in "0123456789abcdef" for c in value))


def _reply(stream, response):
    stream.write((json.dumps(response, sort_keys=True,
                             separators=(",", ":"), ensure_ascii=True)
                  + "\n").encode("ascii"))


class _WitnessTLSHandler(socketserver.StreamRequestHandler):
    def handle(self):
        try:
            # TLS certificate validation completed in get_request. Additionally
            # pin the *specific* caller, not every certificate under this CA.
            caller = _fingerprint(self.request.getpeercert(binary_form=True))
            if caller != self.server.allowed_client_fingerprint:
                return _reply(self.wfile, {"ok": False, "code": "peer_denied"})
            raw = self.rfile.readline(MAX_REQUEST + 1)
            if not raw.endswith(b"\n") or len(raw) > MAX_REQUEST:
                return _reply(self.wfile, {"ok": False, "code": "bad_request"})
            request = json.loads(raw)
            if request == {"op": "read"}:
                response = {"ok": True, "code": "snapshot_only",
                            "receipt": self.server.witness.read()}
            elif (type(request) is dict and
                    set(request) == {"op", "snapshot", "revision", "digest"} and
                    request["op"] == "advance"):
                response = self.server.witness.advance(
                    request["snapshot"], expected_revision=request["revision"],
                    expected_digest=request["digest"])
            else:
                response = {"ok": False, "code": "bad_request"}
            _reply(self.wfile, response)
        except Exception:
            try:
                _reply(self.wfile, {"ok": False,
                                    "code": "witness_unavailable_or_uncertain"})
            except (OSError, ssl.SSLError):
                pass


class LoopbackMTLSRevisionWitness(socketserver.ThreadingTCPServer):
    allow_reuse_address = False
    daemon_threads = True
    block_on_close = True

    def __init__(self, witness, context, *, allowed_client_fingerprint):
        if (not isinstance(witness, MonotonicRevisionWitness) or
                not isinstance(context, ssl.SSLContext) or
                context.verify_mode != ssl.CERT_REQUIRED or
                not _valid_fingerprint(allowed_client_fingerprint)):
            raise ValueError("witness, mTLS and pinned authorized client required")
        self.witness = witness
        self.allowed_client_fingerprint = allowed_client_fingerprint
        witness.read()  # no accidental provisioning
        self.context = context
        # Loopback only: no external binding or automatic service install.
        super().__init__(("127.0.0.1", 0), _WitnessTLSHandler)

    def get_request(self):
        plain, address = self.socket.accept()
        plain.settimeout(3)
        try:
            protected = self.context.wrap_socket(plain, server_side=True)
            return protected, address
        except BaseException:
            plain.close()
            raise


def request_mtls_witness(address, query, *, context, hostname,
                         server_fingerprint, public_key, timeout=3):
    """One authenticated request, never a reusable authorization token."""
    if (type(address) is not tuple or len(address) != 2 or
            address[0] != "127.0.0.1" or
            type(address[1]) is not int or not 0 < address[1] < 65536 or
            not isinstance(context, ssl.SSLContext) or
            context.verify_mode != ssl.CERT_REQUIRED or
            not context.check_hostname or
            type(hostname) is not str or not hostname or
            not _valid_fingerprint(server_fingerprint) or
            type(timeout) not in (int, float) or timeout <= 0):
        raise ValueError("strict loopback TLS peer configuration required")
    raw = (json.dumps(query, sort_keys=True, separators=(",", ":"),
                      ensure_ascii=True) + "\n").encode("ascii")
    if len(raw) > MAX_REQUEST:
        raise ValueError("oversized request")
    with socket.create_connection(address, timeout=timeout) as plain:
        with context.wrap_socket(plain, server_hostname=hostname) as tls:
            if (_fingerprint(tls.getpeercert(binary_form=True)) !=
                    server_fingerprint):
                raise PermissionError("server certificate pin mismatch")
            tls.sendall(raw)
            output = bytearray()
            while b"\n" not in output:
                part = tls.recv(min(2048, MAX_REPLY + 1 - len(output)))
                if not part:
                    raise ValueError("missing or partial TLS reply")
                output.extend(part)
                if len(output) > MAX_REPLY:
                    raise ValueError("oversized TLS reply")
    line, rest = bytes(output).split(b"\n", 1)
    if rest:
        raise ValueError("multiple replies not accepted")
    response = json.loads(line)
    if (type(response) is not dict or type(response.get("ok")) is not bool or
            type(response.get("code")) is not str):
        raise ValueError("malformed witness reply")
    if response["ok"]:
        if response["code"] not in ("snapshot_only", "revision_committed"):
            raise ValueError("unexpected positive response")
        verify_receipt(response["receipt"], public_key)
    return response
