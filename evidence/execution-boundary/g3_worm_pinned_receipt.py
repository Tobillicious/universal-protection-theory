"""Offline reviewer-side verifier for independently pinned G3 custody receipts.

A signed receipt is a cryptographic statement, NOT proof of WORM retention,
administrative independence, physical coverage, or permission to clear HOLD.
No signing keys, network calls, or runtime effects exist here.
"""
import hashlib
import json
import re

from cryptography.exceptions import InvalidSignature
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PublicKey
from g3_worm_custody import inspect as inspect_bundle, no_duplicates, sha, canonical

DOMAIN = b"UPT-G3-WORM-CUSTODY-RECEIPT-V1\x00"
FIELDS = frozenset({"schema", "store_id", "sequence", "predecessor_receipt_sha256",
                    "bundle_sha256", "source_commit", "scope",
                    "checkpoint_revision", "retention_policy_id", "status",
                    "signature"})
HEX64 = re.compile(r"[0-9a-f]{64}\Z")


def verify(*, receipt_bytes, bundle_bytes, event_bytes, inventory_bytes,
           expected_commit, challenge_nonce, expected_floor,
           operator_public_key, custodian_public_key,
           independently_pinned_receipt_sha256,
           independently_pinned_predecessor_sha256,
           independently_pinned_store_id,
           independently_pinned_retention_policy_id,
           expected_sequence):
    """Verify exact-byte receipt chain position and underlying R4/R5/R6 record.

    All expected pins must be supplied from outside the submitted record.
    A caller-provided latest digest cannot be used as its own trust anchor.
    """
    if type(receipt_bytes) is not bytes or not 0 < len(receipt_bytes) <= 65536:
        raise ValueError("invalid receipt bytes")
    if (type(independently_pinned_receipt_sha256) is not str
            or not HEX64.fullmatch(independently_pinned_receipt_sha256)
            or sha(receipt_bytes) != independently_pinned_receipt_sha256):
        raise ValueError("receipt differs from independently pinned digest")
    if (type(independently_pinned_predecessor_sha256) is not str
            or not HEX64.fullmatch(independently_pinned_predecessor_sha256)):
        raise ValueError("independently pinned predecessor required")
    if (type(independently_pinned_store_id) is not str
            or not independently_pinned_store_id
            or type(independently_pinned_retention_policy_id) is not str
            or not independently_pinned_retention_policy_id
            or type(expected_sequence) is not int or expected_sequence < 1):
        raise ValueError("invalid independently pinned receipt position")
    if not isinstance(custodian_public_key, Ed25519PublicKey):
        raise ValueError("pinned custodian Ed25519 public key required")
    if custodian_public_key.public_bytes_raw() == operator_public_key.public_bytes_raw():
        raise ValueError("operator and custodian signing identities must differ")
    try:
        receipt = json.loads(receipt_bytes.decode("ascii"), object_pairs_hook=no_duplicates)
    except (UnicodeError, ValueError) as exc:
        raise ValueError("invalid receipt JSON") from exc
    if type(receipt) is not dict or set(receipt) != FIELDS:
        raise ValueError("unexpected custody receipt fields")
    if (receipt["schema"] != "g3-worm-custody-receipt-v1"
            or receipt["store_id"] != independently_pinned_store_id
            or receipt["retention_policy_id"] != independently_pinned_retention_policy_id
            or type(receipt["sequence"]) is not int
            or receipt["sequence"] != expected_sequence
            or receipt["predecessor_receipt_sha256"] != independently_pinned_predecessor_sha256
            or receipt["bundle_sha256"] != sha(bundle_bytes)
            or receipt["source_commit"] != expected_commit
            or receipt["checkpoint_revision"] != expected_floor[0]
            or receipt["status"] != "retained_receipt_claimed"):
        raise ValueError("receipt binding, ancestry, or status mismatch")
    bundle_report = inspect_bundle(
        bundle_bytes=bundle_bytes, event_bytes=event_bytes,
        inventory_bytes=inventory_bytes, expected_commit=expected_commit,
        challenge_nonce=challenge_nonce, expected_floor=expected_floor,
        operator_public_key=operator_public_key)
    import json as _json
    bundle = _json.loads(bundle_bytes)
    if receipt["scope"] != bundle["scope"]:
        raise ValueError("receipt scope mismatch")
    signature = receipt["signature"]
    if type(signature) is not str or len(signature) != 128:
        raise ValueError("invalid custodian signature shape")
    signed_body = {key: value for key, value in receipt.items() if key != "signature"}
    try:
        custodian_public_key.verify(bytes.fromhex(signature), DOMAIN + canonical(signed_body))
    except (InvalidSignature, ValueError) as exc:
        raise ValueError("custodian signature invalid") from exc
    return {
        "receipt_sha256": independently_pinned_receipt_sha256,
        "bundle_sha256": bundle_report["bundle_sha256"],
        "sequence": expected_sequence,
        "predecessor_receipt_sha256": independently_pinned_predecessor_sha256,
        "cryptographic_receipt_verified": True,
        "independent_retention_verified": False,
        "independent_administration_verified": False,
        "hCoverage_proved": False,
        "hMeaning_proved": False,
        "universal_G3_proved": False,
        "authorizes_effect": False,
        "may_clear_hold": False,
    }
