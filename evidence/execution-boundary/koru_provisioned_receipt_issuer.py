"""Strict provisioned-key HOLD issuer entrypoint, disposable Linux research.

Authenticates an already connected peer and optional socket endpoint *before*
loading any private key. A trusted, independently pinned Ed25519 public key
must match the private key. Delegates to the existing signed-HOLD issuer,
which requires a completed floor under the shared effect fence.

No listening daemon, policy change, key generation, publish permit or effect.
"""
import hmac
import os

from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PublicKey

from koru_local_hold_ack_socket import _peercred, serve_one
from koru_root_receipt_key import load_root_receipt_key


def serve_one_provisioned(sock, *, permitted_uid, key_path,
                          trusted_public_key, floor, fence, issuer,
                          endpoint_binding=None):
    """Never acknowledge if signer provenance or HOLD verification fails.

    The public key is a pinned trust anchor, not obtained from the key file or
    from the request. An authorized client still cannot authorize effects.
    """
    if type(permitted_uid) is not int or permitted_uid < 0:
        raise ValueError("explicit permitted UID required")
    if os.geteuid() != 0:
        raise PermissionError("trusted root issuer required")
    if not isinstance(trusted_public_key, Ed25519PublicKey):
        raise TypeError("pinned Ed25519 public key required")

    _pid, uid, _gid = _peercred(sock)
    if uid != permitted_uid:
        raise PermissionError("unauthorized receipt requester")
    if endpoint_binding is not None:
        endpoint_binding.verify()

    private_key = load_root_receipt_key(key_path)
    candidate = private_key.public_key().public_bytes(
        serialization.Encoding.Raw, serialization.PublicFormat.Raw)
    expected = trusted_public_key.public_bytes(
        serialization.Encoding.Raw, serialization.PublicFormat.Raw)
    if not hmac.compare_digest(candidate, expected):
        raise PermissionError("receipt signing key does not match trust anchor")

    return serve_one(
        sock, permitted_uid=permitted_uid, private_key=private_key,
        floor=floor, fence=fence, issuer=issuer,
        endpoint_binding=endpoint_binding)
