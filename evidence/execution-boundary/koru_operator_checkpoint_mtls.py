"""Read-only challenge endpoint for operator-owned historical custody.

Loopback-only mTLS research transport. This endpoint never accepts a claimed
checkpoint or history update from the caller. A separately provisioned
custodian signs its OWN floor. No effect permission or HOLD commit here.
"""
import hashlib
import json
import socket
import socketserver
import ssl

from koru_mtls_revision_witness import _fingerprint, _valid_fingerprint
from koru_operator_checkpoint_custodian import OperatorCheckpointCustodian
from koru_operator_checkpoint_recovery import verify_operator_response

MAX_REQUEST = 256
MAX_REPLY = 2048


def _valid_nonce(value):
    return (type(value) is str and len(value) == 64 and
            all(c in "0123456789abcdef" for c in value))


class _OperatorHandler(socketserver.StreamRequestHandler):
    def handle(self):
        try:
            if (_fingerprint(self.request.getpeercert(binary_form=True)) !=
                    self.server.allowed_client_fingerprint):
                return self.reply({"ok": False, "code": "peer_denied"})
            raw = self.rfile.readline(MAX_REQUEST + 1)
            if not raw.endswith(b"\n") or len(raw) > MAX_REQUEST:
                return self.reply({"ok": False, "code": "bad_request"})
            request = json.loads(raw, parse_constant=lambda _: (_ for _ in ()).throw(ValueError("invalid JSON constant")))
            if (type(request) is not dict or set(request) != {"op", "nonce"} or
                    request["op"] != "checkpoint" or not _valid_nonce(request["nonce"])):
                return self.reply({"ok": False, "code": "bad_request"})
            return self.reply({"ok": True, "code": "checkpoint_only",
                               "receipt": self.server.custodian.respond(request["nonce"])})
        except Exception:
            try:
                self.reply({"ok": False, "code": "operator_unavailable_or_uncertain"})
            except (OSError, ssl.SSLError):
                pass

    def reply(self, value):
        encoded = json.dumps(value, sort_keys=True, separators=(",", ":"),
                             allow_nan=False).encode("ascii") + b"\n"
        if len(encoded) > MAX_REPLY:
            raise ValueError("oversized response")
        self.wfile.write(encoded)


class LoopbackOperatorCheckpointService(socketserver.ThreadingTCPServer):
    allow_reuse_address = False
    daemon_threads = True
    block_on_close = True

    def __init__(self, custodian, context, *, allowed_client_fingerprint):
        if (not isinstance(custodian, OperatorCheckpointCustodian) or
                not isinstance(context, ssl.SSLContext) or
                context.verify_mode != ssl.CERT_REQUIRED or
                not _valid_fingerprint(allowed_client_fingerprint)):
            raise ValueError("operator custody and pinned mTLS client required")
        # Fail closed if the operator's durable floor has disappeared.
        custodian._agreement.floor.read_floor()
        self.custodian = custodian
        self.context = context
        self.allowed_client_fingerprint = allowed_client_fingerprint
        super().__init__(("127.0.0.1", 0), _OperatorHandler)

    def get_request(self):
        plain, address = self.socket.accept()
        plain.settimeout(3)
        try:
            return self.context.wrap_socket(plain, server_side=True), address
        except BaseException:
            plain.close()
            raise


def request_operator_checkpoint(address, nonce, *, context, hostname,
                                server_fingerprint, operator_public_key, timeout=3):
    """Pinned mTLS request with an authenticated challenge-bound receipt."""
    if (type(address) is not tuple or len(address) != 2 or
            address[0] != "127.0.0.1" or
            type(address[1]) is not int or not 0 < address[1] < 65536 or
            not isinstance(context, ssl.SSLContext) or
            context.verify_mode != ssl.CERT_REQUIRED or
            not context.check_hostname or type(hostname) is not str or
            not hostname or not _valid_fingerprint(server_fingerprint) or
            not _valid_nonce(nonce) or
            type(timeout) not in (float, int) or timeout <= 0):
        raise ValueError("strict operator transport and challenge required")
    raw = json.dumps({"op": "checkpoint", "nonce": nonce},
                     sort_keys=True, separators=(",", ":")).encode("ascii") + b"\n"
    with socket.create_connection(address, timeout=timeout) as plain:
        with context.wrap_socket(plain, server_hostname=hostname) as tls:
            tls.settimeout(timeout)
            if _fingerprint(tls.getpeercert(binary_form=True)) != server_fingerprint:
                raise PermissionError("operator certificate pin mismatch")
            tls.sendall(raw)
            output = bytearray()
            while b"\n" not in output:
                if len(output) >= MAX_REPLY:
                    raise ValueError("operator reply too large")
                part = tls.recv(min(1024, MAX_REPLY + 1 - len(output)))
                if not part:
                    raise ValueError("missing or partial operator response")
                output.extend(part)
                if len(output) > MAX_REPLY:
                    raise ValueError("operator reply too large")
    line, extra = bytes(output).split(b"\n", 1)
    if extra:
        raise ValueError("unexpected trailing operator response")
    response = json.loads(line, parse_constant=lambda _: (_ for _ in ()).throw(ValueError("invalid JSON constant")))
    if (type(response) is not dict or
            set(response) not in ({"ok", "code"}, {"ok", "code", "receipt"}) or
            type(response["ok"]) is not bool or type(response["code"]) is not str):
        raise ValueError("malformed operator response")
    if response["ok"] is not True or response["code"] != "checkpoint_only":
        raise PermissionError("operator denied or unavailable")
    receipt = response.get("receipt")
    if type(receipt) is not dict:
        raise ValueError("missing checkpoint receipt")
    # Validate the signature here; the recovery caller validates the exact
    # expected retained anchor as well. No trust-on-first-use key.
    floor = (receipt.get("revision"), receipt.get("digest"),
             receipt.get("previous_digest"))
    verify_operator_response(receipt, operator_public_key, nonce, floor)
    return receipt
