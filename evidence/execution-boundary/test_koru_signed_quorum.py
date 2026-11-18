import pytest
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PrivateKey

from koru_signed_quorum import sign_quorum_state, verify_quorum_attestation, assemble_quorum_attestations


def test_sign_and_verify_quorum_attestation():
    key = Ed25519PrivateKey.generate()
    pub = key.public_key()
    sig = sign_quorum_state(key, "G3-Alpha", 7, "0xroot")
    assert verify_quorum_attestation(pub, "G3-Alpha", 7, "0xroot", sig)


def test_invalid_signature_rejected():
    key = Ed25519PrivateKey.generate()
    other = Ed25519PrivateKey.generate().public_key()
    sig = sign_quorum_state(key, "G3-Alpha", 7, "0xroot")
    assert not verify_quorum_attestation(other, "G3-Alpha", 7, "0xroot", sig)


def test_quorum_assembly_requires_two_thirds():
    attestations = [
        {"node_id": "a", "valid": True},
        {"node_id": "b", "valid": True},
        {"node_id": "c", "valid": False},
    ]
    result = assemble_quorum_attestations(attestations)
    assert result["quorum_size"] == 2
    assert result["required"] == 2


def test_quorum_assembly_fails_below_threshold():
    attestations = [
        {"node_id": "a", "valid": True},
        {"node_id": "b", "valid": False},
        {"node_id": "c", "valid": False},
    ]
    with pytest.raises(ValueError):
        assemble_quorum_attestations(attestations)
