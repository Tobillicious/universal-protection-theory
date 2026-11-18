"""R7 detached review bound to the exact G3 WORM custody receipt.

Reuses existing R4/R5/R6 WORM and R7 Ed25519 review verification.
No effect authorization or independent physical certification.
"""
import hashlib
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PublicKey
from g3_worm_pinned_receipt import verify as verify_worm
from g3_r7_external_review_signature import verify as verify_review

def verify(*, receipt_bytes, bundle_bytes, event_bytes, inventory_bytes,
           expected_commit, challenge_nonce, expected_floor,
           operator_public_key, custodian_public_key,
           independently_pinned_receipt_sha256,
           independently_pinned_predecessor_sha256,
           independently_pinned_store_id,
           independently_pinned_retention_policy_id,
           expected_sequence, review_bytes, review_signature,
           reviewer_public_key, independently_pinned_reviewer_key_sha256):
    if type(reviewer_public_key) is not bytes or len(reviewer_public_key) != 32:
        raise ValueError("reviewer Ed25519 key required")
    if (type(independently_pinned_reviewer_key_sha256) is not str
            or hashlib.sha256(reviewer_public_key).hexdigest()
            != independently_pinned_reviewer_key_sha256):
        raise ValueError("reviewer key differs from independent pin")
    if (not isinstance(operator_public_key, Ed25519PublicKey)
            or not isinstance(custodian_public_key, Ed25519PublicKey)):
        raise ValueError("independent operator and custodian keys required")
    reviewer_key = Ed25519PublicKey.from_public_bytes(reviewer_public_key)
    if reviewer_key.public_bytes_raw() in (
            operator_public_key.public_bytes_raw(),
            custodian_public_key.public_bytes_raw()):
        raise ValueError("reviewer key must differ from operator and custodian")
    worm = verify_worm(
        receipt_bytes=receipt_bytes, bundle_bytes=bundle_bytes,
        event_bytes=event_bytes, inventory_bytes=inventory_bytes,
        expected_commit=expected_commit, challenge_nonce=challenge_nonce,
        expected_floor=expected_floor, operator_public_key=operator_public_key,
        custodian_public_key=custodian_public_key,
        independently_pinned_receipt_sha256=independently_pinned_receipt_sha256,
        independently_pinned_predecessor_sha256=independently_pinned_predecessor_sha256,
        independently_pinned_store_id=independently_pinned_store_id,
        independently_pinned_retention_policy_id=independently_pinned_retention_policy_id,
        expected_sequence=expected_sequence)
    import json
    from g3_worm_custody import no_duplicates
    review_document = json.loads(review_bytes.decode("utf-8"), object_pairs_hook=no_duplicates)
    receipt_document = json.loads(receipt_bytes.decode("utf-8"), object_pairs_hook=no_duplicates)
    if (type(review_document) is not dict or type(receipt_document) is not dict
            or review_document.get("scope") != receipt_document.get("scope")):
        raise ValueError("R7 review scope differs from WORM receipt scope")
    review = verify_review(
        review_bytes=review_bytes, signature=review_signature,
        reviewer_public_key=reviewer_public_key,
        expected_head=expected_commit,
        expected_evidence_sha256=independently_pinned_receipt_sha256)
    if review["decision"] != "ACCEPT_BOUNDED_RESEARCH":
        status = "HOLD_REVIEW_NOT_ACCEPTED"
    else:
        status = "BOUNDED_CRYPTOGRAPHIC_REVIEW_ACCEPTED_PHYSICAL_GATES_OPEN"
    return {
        "schema": "g3-r7-worm-joint-review-v1",
        "source_commit": expected_commit,
        "receipt_sha256": worm["receipt_sha256"],
        "bundle_sha256": worm["bundle_sha256"],
        "review_decision": review["decision"],
        "reviewer_key_sha256": independently_pinned_reviewer_key_sha256,
        "cryptographic_custody_receipt_verified": True,
        "detached_review_signature_verified": True,
        "status": status,
        "independent_reviewer_identity_verified": False,
        "independent_administration_verified": False,
        "independent_retention_verified": False,
        "hCoverage_proved": False,
        "hMeaning_proved": False,
        "universal_G3_proved": False,
        "authorizes_effect": False,
        "may_clear_hold": False,
        "may_merge_or_deploy": False,
    }
