"""Signed quorum attestation for G-Mesh nodes."""
import json
import hashlib
from typing import Dict, List

from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey, Ed25519PublicKey
from cryptography.exceptions import InvalidSignature


def sign_quorum_state(private_key: Ed25519PrivateKey, node_id: str, epoch: int, state_root: str) -> bytes:
    payload = json.dumps({"node_id": node_id, "epoch": epoch, "state_root": state_root}, sort_keys=True).encode()
    return private_key.sign(payload)


def verify_quorum_attestation(public_key: Ed25519PublicKey, node_id: str, epoch: int, state_root: str, signature: bytes) -> bool:
    payload = json.dumps({"node_id": node_id, "epoch": epoch, "state_root": state_root}, sort_keys=True).encode()
    try:
        public_key.verify(signature, payload)
        return True
    except InvalidSignature:
        return False


def assemble_quorum_attestations(attestations: List[Dict]) -> Dict:
    """Assemble a signed quorum packet; requires at least 2/3 of provided attestations."""
    required = max(1, (len(attestations) * 2 + 2) // 3)
    valid = [a for a in attestations if a.get("valid")]
    if len(valid) < required:
        raise ValueError(f"Quorum not met: {len(valid)}/{required}")
    digest = hashlib.sha256(json.dumps(valid, sort_keys=True).encode()).hexdigest()
    return {"quorum_size": len(valid), "required": required, "digest": digest, "attestations": valid}
